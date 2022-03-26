use v6.c;

use Method::Also;
use NativeCall;

use Rest::Raw::Types;
use Rest::Raw::Proxy;

use Rest::Proxy::Call;

use GLib::Roles::Object;
use Rest::Roles::Signals::Proxy;

our subset RestProxyAncestry is export of Mu
  where RestProxy | GObject;

class Rest::Proxy {
  also does GLib::Roles::Object;
  also does Rest::Roles::Signals::Proxy;

  has RestProxy $!rp is implementor;

  submethod BUILD ( :$rest-proxy ) {
    self.setRestProxy( $rest-proxy ) if $rest-proxy
  }

  method setRestProxy (RestProxyAncestry $_) {
    my $to-parent;

    $!rp = do {
      when RestProxy {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(RestProxy, $_);
      }
    }
    self!setObject($to-parent)
  }

  method Rest::Raw::Definitions::RestProxy
  { $!rp }

  multi method new (RestProxyAncestry $rest-proxy, :$ref = True) {
    return Nil unless $rest-proxy;

    my $o = self.bless( :$rest-proxy );
    $o.ref if $ref;
    $o;
  }
  multi method new (Str() $url_format, Int() $binding_required = False) {
    my gboolean $b = $binding_required.so.Int;

    my $rest-proxy = rest_proxy_new($url_format, $b);

    $rest-proxy ?? self.bless( :$rest-proxy ) !! Nil;
  }

  method new_with_authentication (
    Str() $url_format,
    Int() $binding_required,
    Str() $username,
    Str() $password
  )
    is also<new-with-authentication>
  {
    my gboolean $b = $binding_required.so.Int;

    my $rest-proxy = rest_proxy_new_with_authentication(
      $url_format,
      $binding_required,
      $username,
      $password
    );

    $rest-proxy ?? self.bless( :$rest-proxy ) !! Nil;
  }

  # Type: boolean
  method binding-required is rw  is also<binding_required> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        warn 'binding-required does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('binding-required', $gv);
      }
    );
  }

  # Type: boolean
  method disable-cookies is rw  is also<disable_cookies> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        warn 'disable-cookies does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, Int() $val is copy {
        warn 'disable-cookies is a construct-only attribute'
      }
    );
  }

  # Type: string
  method password is rw  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        warn 'password does not allow reading' if $DEBUG;
        '';
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('password', $gv);
      }
    );
  }

  # Type: string
  method ssl-ca-file is rw  is also<ssl_ca_file> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        warn 'ssl-ca-file does not allow reading' if $DEBUG;
        '';
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('ssl-ca-file', $gv);
      }
    );
  }

  # Type: boolean
  method ssl-strict is rw  is also<ssl_strict> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        warn 'ssl-strict does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('ssl-strict', $gv);
      }
    );
  }

  # Type: string
  method url-format is rw  is also<url_format> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        warn 'url-format does not allow reading' if $DEBUG;
        '';
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('url-format', $gv);
      }
    );
  }

  # Type: string
  method user-agent is rw  is also<user_agent> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        warn 'user-agent does not allow reading' if $DEBUG;
        '';
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('user-agent', $gv);
      }
    );
  }

  # Type: string
  method username is rw  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        warn 'username does not allow reading' if $DEBUG;
        '';
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('username', $gv);
      }
    );
  }

  # Is originally:
  # RestProxy *proxy,  RestProxyAuth *auth,  gboolean retrying --> gboolean
  method authenticate {
    self.connect-authenticate($!rp);
  }

  method add_soup_feature (SoupSessionFeature() $feature)
    is also<add-soup-feature>
  {
    rest_proxy_add_soup_feature($!rp, $feature);
  }

  method error_quark (Rest::Proxy:U: ) is also<error-quark> {
    rest_proxy_error_quark();
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &rest_proxy_get_type, $n, $t );
  }

  method get_user_agent is also<get-user-agent> {
    rest_proxy_get_user_agent($!rp);
  }

  # Alias to new_call.
  method make_call ( :$raw = False )
    is also<
      make-call
      new_call
      new-call
    >
  {
    propReturnObject(
      rest_proxy_new_call($!rp),
      $raw,
      |Rest::Proxy::Call.getTypePair
    )
  }

  method set_user_agent (Str() $user_agent) is also<set-user-agent> {
    rest_proxy_set_user_agent($!rp, $user_agent);
  }

  proto method simple_run (|)
    is also<simple-run>
  { * }

  multi method simple_run (
                             @payload,
                             %params,
    CArray[Pointer[GError]]  $error = gerror,
  ) {
    samewith(
      ArrayToCArray(Str, @payload),
      $error,
      |%params
    );
  }
  multi method simple_run (
    CArray[Str]             $payload,
    CArray[Pointer[GError]] $error    = gerror,
    *%params,
  ) {
    my $call = Rest::Proxy::Call.new($!rp);
    for %params.pairs {
      $call.add_param( .key, .value );
    }
    my $ret     = $call.sync;
    my $len     = $ret ?? $call.get_payload_length !! 0;
       $payload = $ret ?? $call.get_payload        !! Nil;

    ($payload, $len);
  }

}
