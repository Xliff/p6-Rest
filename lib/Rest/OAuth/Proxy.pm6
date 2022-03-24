use v6.c;

use Method::Also;

use NativeCall;

use Rest::Raw::Types;
use Rest::Raw::OAuth::Proxy;

use Rest::Proxy;

our subset OAuthProxyAncestry is export of Mu
  where OAuthProxy | RestProxyAncestry;

class Rest::OAuth::Proxy is Rest::Proxy {
  has OAuthProxy $!rop;

  submethod BUILD ( :$oauth-proxy ) {
    self.setOAuthProxy( $oauth-proxy ) if $oauth-proxy
  }

  method setOAuthProxy (OAuthProxyAncestry $_) {
    my $to-parent;

    $!rop = do {
      when OAuthProxy {
        $to-parent = cast(RestProxy, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(OAuthProxy, $_);
      }
    }
    self.setRestProxy($to-parent)
  }

  method Rest::Raw::Definitions::OAuthProxy
  { $!rop }

  multi method new (OAuthProxyAncestry $oauth-proxy, :$ref = True) {
    return Nil unless $oauth-proxy;

    my $o = self.bless( :$oauth-proxy );
    $o.ref if $ref;
    $o;
  }
  multi method new (
    Str() $consumer_key,
    Str() $consumer_secret,
    Str() $url_format,
    Int() $binding_required = 0
  ) {
    my gboolean $b = $binding_required.so.Int;

    my $oauth-proxy = oauth_proxy_new(
      $consumer_key,
      $consumer_secret,
      $url_format,
      $binding_required
    );

    $oauth-proxy ?? self.bless( :$oauth-proxy ) !! Nil;
  }

  method new_echo_proxy (
    OAuthProxy() $proxy,
    Str()        $service_url,
    Str()        $url_format,
    Int()        $binding_required = 0
  )
    is also<new-echo-proxy>
  {
    my gboolean $b = $binding_required.so.Int;

    my $oauth-proxy = oauth_proxy_new_echo_proxy(
      $proxy,
      $service_url,
      $url_format,
      $binding_required
    );

    $oauth-proxy ?? self.bless( :$oauth-proxy ) !! Nil;
  }

  method new_with_token (
    Str() $consumer_key,
    Str() $consumer_secret,
    Str() $token,
    Str() $token_secret,
    Str() $url_format,
    Int() $binding_required = 0
  )
    is also<new-with-token>
  {
    my gboolean $b = $binding_required;

    my $oauth-proxy = oauth_proxy_new_with_token(
      $consumer_key,
      $consumer_secret,
      $token,
      $token_secret,
      $url_format,
      $binding_required
    );

    $oauth-proxy ?? self.bless( :$oauth-proxy ) !! Nil;
  }

  # Type: string
  method consumer-key is rw  is also<consumer_key> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        warn 'consumer-key does not allow reading' if $DEBUG;
        '';
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('consumer-key', $gv);
      }
    );
  }

  # Type: string
  method consumer-secret is rw  is also<consumer_secret> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        warn 'consumer-secret does not allow reading' if $DEBUG;
        '';
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('consumer-secret', $gv);
      }
    );
  }

  # Type: string
  method signature-host is rw  is also<signature_host> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        warn 'signature-host does not allow reading' if $DEBUG;
        '';
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('signature-host', $gv);
      }
    );
  }

  # Type: OAuthSignatureMethod
  method signature-method is rw  is also<signature_method> {
    my $gv = GLib::Value.new( GLib::Value.gtypeFromEnum(OAuthSignatureMethod) );
    Proxy.new(
      FETCH => sub ($) {
        warn 'signature-method does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(OAuthSignatureMethod) = $val;
        self.prop_set('signature-method', $gv);
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

  # Type: string
  method token-secret is rw  is also<token_secret> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        warn 'token-secret does not allow reading' if $DEBUG;
        '';
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('token-secret', $gv);
      }
    );
  }

  method access_token (
    Str()                   $function,
    Str()                   $verifier,
    CArray[Pointer[GError]] $error     = gerror
  )
    is also<access-token>
  {
    clear_error;
    my $t = oauth_proxy_access_token($!rop, $function, $verifier, $error);
    set_error($error);
    $t
  }

  proto method access_token_async (|)
    is also<access-token-async>
  { * }

  # No functiond
  multi method access_token_async (
    Str()                   $verifier,
                            &callback,
    GObject()               $weak_object  = GObject,
    gpointer                $user_data    = gpointer,
    CArray[Pointer[GError]] $error        = gerror
  ) {
    samewith(Str, $verifier, &callback, $weak_object, $user_data, $error);
  }
  # No callback
  multi method access_token_async (
    Str()                   $function,
    Str()                   $verifier,
    GObject()               $weak_object  = GObject,
    gpointer                $user_data    = gpointer,
    CArray[Pointer[GError]] $error        = gerror
  ) {
    samewith($function, $verifier, Callable, $weak_object, $user_data, $error)
  }
  multi method access_token_async (
    Str()                   $function,
    Str()                   $verifier,
                            &callback,
    GObject()               $weak_object  = GObject,
    gpointer                $user_data    = gpointer,
    CArray[Pointer[GError]] $error        = gerror
  ) {
    clear_error;
    my $rv = so oauth_proxy_access_token_async(
      $!rop,
      $function,
      $verifier,
      &callback,
      $weak_object,
      $user_data,
      $error
    );
    set_error($error);
    $rv;
  }

  method auth_step (Str() $function, CArray[Pointer[GError]] $error = gerror)
    is also<auth-step>
  {
    clear_error;
    oauth_proxy_auth_step($!rop, $function, $error);
    set_error($error);
  }

  method auth_step_async (
    Str()                   $function,
                            &callback,
    GObject()               $weak_object = GObject,
    gpointer                $user_data   = gpointer,
    CArray[Pointer[GError]] $error       = gerror
  )
    is also<auth-step-async>
  {
    clear_error;
    my $rv = so oauth_proxy_auth_step_async(
      $!rop,
      $function,
      &callback,
      $weak_object,
      $user_data,
      $error
    );
    set_error($error);
  }

  method get_signature_host is also<get-signature-host> {
    so oauth_proxy_get_signature_host($!rop);
  }

  method get_token is also<get-token> {
    oauth_proxy_get_token($!rop);
  }

  method get_token_secret is also<get-token-secret> {
    oauth_proxy_get_token_secret($!rop);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &oauth_proxy_get_type, $n, $t );
  }

  method is_oauth10a is also<is-oauth10a> {
    so oauth_proxy_is_oauth10a($!rop);
  }

  method oauth_signature_method_get_type
    is also<oauth-signature-method-get-type>
  {
    state ($n, $t);

    unstable_get_type(
      'oauth_signature',
      &oauth_signature_method_get_type,
      $n,
      $t
    );
  }

  method request_token (
    Str()                   $function,
    Str()                   $callback_uri,
    CArray[Pointer[GError]] $error         = gerror
  )
    is also<request-token>
  {
    clear_error;
    my $t = oauth_proxy_request_token($!rop, $function, $callback_uri, $error);
    set_error($error);
    $t
  }

  proto method request_token_async (|)
    is also<request-token-async>
  { * }

  multi method request_token_async (
    Str()                   $function,
                            &callback,
    GObject()               $weak_object   = GObject,
    gpointer                $user_data     = gpointer,
    CArray[Pointer[GError]] $error         = gerror
  ) {
    samewith($function, Str, &callback, $weak_object, $user_data, $error);
  }
  multi method request_token_async (
    Str()                   $function,
    Str()                   $callback_uri,
                            &callback,
    GObject()               $weak_object   = GObject,
    gpointer                $user_data     = gpointer,
    CArray[Pointer[GError]] $error         = gerror
  ) {
    clear_error;
    my $rv = so oauth_proxy_request_token_async(
      $!rop,
      $function,
      $callback_uri,
      &callback,
      $weak_object,
      $user_data,
      $error
    );
    set_error($error);
    $rv;
  }

  method set_signature_host (Str() $signature_host)
    is also<set-signature-host>
  {
    oauth_proxy_set_signature_host($!rop, $signature_host);
  }

  method set_token (Str() $token) is also<set-token> {
    oauth_proxy_set_token($!rop, $token);
  }

  method set_token_secret (Str() $token_secret) is also<set-token-secret> {
    oauth_proxy_set_token_secret($!rop, $token_secret);
  }
}
