use v6.c;

use Method::Also;

use Rest::Raw::Types;
use Rest::Raw::OAuth2::Proxy;

use Rest::Proxy;

our subset OAuth2ProxyAncestry is export of Mu
  where OAuth2Proxy | RestProxyAncestry;

class Rest::OAuth2::Proxy is Rest::Proxy {
  has OAuth2Proxy $!o2p;

  submethod BUILD ( :$oauth2-proxy ) {
    self.setOAuth2Proxy( $oauth2-proxy ) if $oauth2-proxy
  }

  method setOAuth2Proxy (OAuth2ProxyAncestry $_) {
    my $to-parent;

    $!o2p = do {
      when OAuth2Proxy {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(OAuth2Proxy, $_);
      }
    }
    self.setRestProxy($to-parent)
  }

  method Rest::Raw::Definitions::OAuth2Proxy
    is also<OAuth2Proxy>
  { $!o2p }

  multi method new (OAuth2ProxyAncestry $oauth2-proxy, :$ref = True) {
    return Nil unless $oauth2-proxy;

    my $o = self.bless( :$oauth2-proxy );
    $o.ref if $ref;
    $o;
  }
  multi method new (
    Str() $client_id,
    Str() $auth_endpoint,
    Str() $url_format,
    Int() $binding_required
  ) {
    my gboolean $b = $binding_required.so.Int;

    my $oauth2-proxy = oauth2_proxy_new(
      $client_id,
      $auth_endpoint,
      $url_format,
      $b
    );

    $oauth2-proxy ?? self.bless( :$oauth2-proxy ) !! Nil;
  }

  method new_with_token (
    Str() $client_id,
    Str() $access_token,
    Str() $auth_endpoint,
    Str() $url_format,
    Int() $binding_required
  )
    is also<new-with-token>
  {
    my gboolean $b = $binding_required.so.Int;

    my $oauth2-proxy = oauth2_proxy_new_with_token(
      $client_id,
      $access_token,
      $auth_endpoint,
      $url_format,
      $b
    );

    $oauth2-proxy ?? self.bless( :$oauth2-proxy ) !! Nil;
  }

  method build_login_url (Str() $redirect_uri) is also<build-login-url> {
    oauth2_proxy_build_login_url($!o2p, $redirect_uri);
  }

  method build_login_url_full (
    Str()        $redirect_uri,
    GHashTable() $extra_params
  )
    is also<build-login-url-full>
  {
    oauth2_proxy_build_login_url_full($!o2p, $redirect_uri, $extra_params);
  }

  method extract_access_token (
    ::?CLASS:U:

    Str() $url
  )
    is also<extract-access-token>
  {
    oauth2_proxy_extract_access_token($url);
  }

  method get_access_token is also<get-access-token> {
    oauth2_proxy_get_access_token($!o2p);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &oauth2_proxy_get_type, $n, $t );
  }

  method set_access_token (Str() $access_token) is also<set-access-token> {
    oauth2_proxy_set_access_token($!o2p, $access_token);
  }

}
