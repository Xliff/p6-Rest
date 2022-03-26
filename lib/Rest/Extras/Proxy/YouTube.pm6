use v6.c;

use NativeCall;

use Rest::Raw::Types;

use Rest::Proxy;

our subset YoutubeProxyAncestry is export of Mu
  where YoutubeProxy | RestProxyAncestry;

class Rest::Extras::Proxy::Youtube is Rest::Proxy {
  has YoutubeProxy $!ryp;

  submethod BUILD ( :$youtube-proxy ) {
    self.setYoutubeProxy( $youtube-proxy ) if $youtube-proxy
  }

  method setYoutubeProxy (YoutubeProxyAncestry $_) {
    my $to-parent;

    $!ryp = do {
      when YoutubeProxy {
        $to-parent = cast(RestProxy, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(YoutubeProxy, $_);
      }
    }
    self.setRestProxy($to-parent)
  }

  method Rest::Raw::Definitions::YoutubeProxy
  { $!ryp }

  multi method new (YoutubeProxyAncestry $youtube-proxy, :$ref = True) {
    return Nil unless $youtube-proxy;

    my $o = self.bless( :$youtube-proxy );
    $o.ref if $ref;
    $o;
  }
  multi method new (Str() $developer_key) {
    my $youtube-proxy = youtube_proxy_new($developer_key);

    $youtube-proxy ?? self.bless( :$youtube-proxy ) !! Nil;
  }

  method new_with_auth (Str() $developer_key, Str() $user_auth) {
    my $youtube-proxy = youtube_proxy_new_with_auth($developer_key, $user_auth);

    $youtube-proxy ?? self.bless( :$youtube-proxy ) !! Nil;
  }

  # Type: string
  method developer-key is rw  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        warn 'developer-key does not allow reading' if $DEBUG;
        '';
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('developer-key', $gv);
      }
    );
  }

  # Type: string
  method user-auth is rw  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        warn 'user-auth does not allow reading' if $DEBUG;
        '';
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('user-auth', $gv);
      }
    );
  }

  method get_type {
    state ($n, $t);
    unstable_get_type( self.^name, &youtube_proxy_get_type, $n, $t );
  }

  method set_user_auth (Str() $user_auth) {
    youtube_proxy_set_user_auth($!ryp, $user_auth);
  }

  proto method upload_async (|)
  { * }

  multi method upload_async (
    Str()                    $filename,
    GHashTable()             $fields,
                             &callback,
    GObject()                $weak_object  = GObject,
    gpointer                 $user_data    = gpointer,
    CArray[Pointer[GError]]  $error        = gerror,
    Int()                   :$incomplete   = False
  ) {
    samewith(
      $filename,
      $fields,
      $incomplete,
      &callback,
      $weak_object,
      $user_data,
      $error
    )
  }
  multi method upload_async (
    Str()                   $filename,
    GHashTable()            $fields,
    Int()                   $incomplete,
                            &callback,
    GObject()               $weak_object  = GObject,
    gpointer                $user_data    = gpointer,
    CArray[Pointer[GError]] $error        = gerror
  ) {
    my gboolean $i = $incomplete.so.Int;

    clear_error;
    my $rv = so youtube_proxy_upload_async(
      $!ryp,
      $filename,
      $fields,
      $i,
      &callback,
      $weak_object,
      $user_data,
      $error
    );
    set_error($error);
    $rv;
  }

}

### /usr/src/librest-0.8.1/rest/../rest-extras/youtube-proxy.h

sub youtube_proxy_get_type ()
  returns GType
  is native(rest-extras)
  is export
{ * }

sub youtube_proxy_new (Str $developer_key)
  returns YoutubeProxy
  is native(rest-extras)
  is export
{ * }

sub youtube_proxy_new_with_auth (Str $developer_key, Str $user_auth)
  returns RestProxy
  is native(rest-extras)
  is export
{ * }

sub youtube_proxy_set_user_auth (YoutubeProxy $proxy, Str $user_auth)
  is native(rest-extras)
  is export
{ * }

sub youtube_proxy_upload_async (
  YoutubeProxy            $self,
  Str                     $filename,
  GHashTable              $fields,
  gboolean                $incomplete,
                          &callback,
  GObject                 $weak_object,
  gpointer                $user_data,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(rest-extras)
  is export
{ * }
