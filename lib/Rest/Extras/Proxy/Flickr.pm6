use v6.c;

use Method::Also;
use NativeCall;

use Rest::Raw::Types;
use Rest::Raw::Extras::Proxy::Flickr;

use Rest::Proxy;

our subset FlickrProxyAncestry is export of Mu
  where FlickrProxy | RestProxyAncestry;

class Rest::Extras::Proxy::Flickr is Rest::Proxy {
  has FlickrProxy $!rfp;

  submethod BUILD ( :$flickr-proxy ) {
    self.setFlickrProxy( $flickr-proxy ) if $flickr-proxy
  }

  method setFlickrProxy (FlickrProxyAncestry $_) {
    my $to-parent;

    $!rfp = do {
      when FlickrProxy {
        $to-parent = cast(RestProxy, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(FlickrProxy, $_);
      }
    }
    self.setRestProxy($to-parent)
  }

  method Rest::Raw::Definitions::FlickrProxy
    is also<FlickrProxy>
  { $!rfp }

  multi method new (FlickrProxyAncestry $flickr-proxy, :$ref = True) {
    return Nil unless $flickr-proxy;

    my $o = self.bless( :$flickr-proxy );
    $o.ref if $ref;
    $o;
  }
  multi method new (Str() $api-key, Str() $shared_secret) {
    my $flickr-proxy = flickr_proxy_new($api-key, $shared_secret);

    $flickr-proxy ?? self.bless( :$flickr-proxy ) !! Nil;
  }

  method new_with_token (Str $api_key, Str $shared_secret, Str $token)
    is also<new-with-token>
  {
    my $flickr-proxy = flickr_proxy_new_with_token(
      $api_key,
      $shared_secret,
      $token
    );

    $flickr-proxy ?? self.bless( :$flickr-proxy ) !! Nil;
  }

  # Type: string
  method api-key is rw  is also<api_key> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        warn 'api-key does not allow reading' if $DEBUG;
        '';
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('api-key', $gv);
      }
    );
  }

  # Type: string
  method shared-secret is rw  is also<shared_secret> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        warn 'shared-secret does not allow reading' if $DEBUG;
        '';
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('shared-secret', $gv);
      }
    );
  }

  # Type: string
  method token is rw  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        warn 'token does not allow reading' if $DEBUG;
        '';
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('token', $gv);
      }
    );
  }

  method build_login_url (Str() $frob, Str() $perms) is also<build-login-url> {
    flickr_proxy_build_login_url($!rfp, $frob, $perms);
  }

  method get_api_key is also<get-api-key> {
    flickr_proxy_get_api_key($!rfp);
  }

  method get_shared_secret is also<get-shared-secret> {
    flickr_proxy_get_shared_secret($!rfp);
  }

  method get_token is also<get-token> {
    flickr_proxy_get_token($!rfp);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &flickr_proxy_get_type, $n, $t );
  }

  method is_successful (
    ::?CLASS:U:

    RestXmlNode()           $root,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<is-successful>
  {
    clear_error;
    my $rv = so flickr_proxy_is_successful($root, $error);
    set_error($error);
    $rv;
  }

  method make_upload ( :$raw = False ) is also<make-upload> {
    propReturnObject(
      flickr_proxy_new_upload($!rfp),
      $raw,
      |Rest::Extras::Proxy::Call::Flickr.getTypePair
    );
  }

  method make_upload_for_file (
    Str()                    $filename,
    CArray[Pointer[GError]]  $error     = gerror,
                            :$raw       = False
  )
    is also<make-upload-for-file>
  {
    clear_error;
    my $rpc = flickr_proxy_new_upload_for_file(
      $!rfp,
      $filename,
      $error
    );
    set_error($error);

    propReturnObject(
      $rpc,
      $raw,
      |Rest::Extras::Proxy::Call::Flickr.getTypePair
    );
  }

  method set_token (Str() $token) is also<set-token> {
    flickr_proxy_set_token($!rfp, $token);
  }

  method sign (GHashTable() $params) {
    flickr_proxy_sign($!rfp, $params);
  }

}
