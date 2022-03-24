use v6.c;

use Method::Also;
use NativeCall;

use Rest::Raw::Types;
use Rest::Raw::Extras::Proxy::LastFM;

use Rest::Proxy;

our subset LastfmProxyAncestry is export of Mu
  where LastfmProxy | RestProxyAncestry;

class Rest::Extras::Proxy::LastFM is Rest::Proxy {
  has LastfmProxy $!lfm;

  submethod BUILD ( :$lastfm-proxy ) {
    self.setLastfmProxy( $lastfm-proxy ) if $lastfm-proxy
  }

  method setLastfmProxy (LastfmProxyAncestry $_) {
    my $to-parent;

    $!lfm = do {
      when LastfmProxy {
        $to-parent = cast(RestProxy, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(LastfmProxy, $_);
      }
    }
    self.setRestProxy($to-parent)
  }

  method Rest::Raw::Definitions::LastfmProxy
  { $!lfm }

  multi method new (LastfmProxyAncestry $lastfm-proxy, :$ref = True) {
    return Nil unless $lastfm-proxy;

    my $o = self.bless( :$lastfm-proxy );
    $o.ref if $ref;
    $o;
  }
  multi method new (Str() $api-key, Str() $secret) {
    my $lastfm-proxy = lastfm_proxy_new($api-key, $secret);

    $lastfm-proxy ?? self.bless( :$lastfm-proxy ) !! Nil;
  }

  method new_with_session (Str() $api_key, Str() $secret, Str() $session_key) is also<new-with-session> {
    my $lastfm-proxy = lastfm_proxy_new_with_session(
      $api_key,
      $secret,
      $session_key
    );

    $lastfm-proxy ?? self.bless( :$lastfm-proxy ) !! Nil;
  }

  method build_login_url (Str() $token) is also<build-login-url> {
    lastfm_proxy_build_login_url($!lfm, $token);
  }

  method get_api_key
    is also<
      get-api-key
      api_key
      api-key
    >
  {
    lastfm_proxy_get_api_key($!lfm);
  }

  method get_secret
    is also<
      get-secret
      secret
    >
  {
    lastfm_proxy_get_secret($!lfm);
  }

  method get_session_key
    is also<
      get-session-key
      session_key
      session-key
    >
  {
    lastfm_proxy_get_session_key($!lfm);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &lastfm_proxy_get_type, $n, $t );
  }

  method is_successful (RestXmlNode() $root, CArray[Pointer[GError]] $error = gerror)
    is also<is-successful>
  {
    clear_error;
    # cw: xmlNode?
    my $rv = so lastfm_proxy_is_successful($root, $error);
    set_error($error);
    $rv;
  }

  method set_session_key (Str() $session_key) is also<set-session-key> {
    lastfm_proxy_set_session_key($!lfm, $session_key);
  }

  method sign (GHashTable() $params) {
    lastfm_proxy_sign($!lfm, $params);
  }

}
