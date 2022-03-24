use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use Rest::Raw::Definitions;

unit package Rest::Raw::OAuth2::Proxy;

### /usr/src/librest-0.8.1/rest/oauth2-proxy.h

sub oauth2_proxy_build_login_url (OAuth2Proxy $proxy, Str $redirect_uri)
  returns Str
  is native(rest)
  is export
{ * }

sub oauth2_proxy_build_login_url_full (
  OAuth2Proxy $proxy,
  Str         $redirect_uri,
  GHashTable  $extra_params
)
  returns Str
  is native(rest)
  is export
{ * }

sub oauth2_proxy_extract_access_token (Str $url)
  returns Str
  is native(rest)
  is export
{ * }

sub oauth2_proxy_get_access_token (OAuth2Proxy $proxy)
  returns Str
  is native(rest)
  is export
{ * }

sub oauth2_proxy_get_type ()
  returns GType
  is native(rest)
  is export
{ * }

sub oauth2_proxy_new (
  Str      $client_id,
  Str      $auth_endpoint,
  Str      $url_format,
  gboolean $binding_required
)
  returns OAuth2Proxy
  is native(rest)
  is export
{ * }

sub oauth2_proxy_new_with_token (
  Str      $client_id,
  Str      $access_token,
  Str      $auth_endpoint,
  Str      $url_format,
  gboolean $binding_required
)
  returns OAuth2Proxy
  is native(rest)
  is export
{ * }

sub oauth2_proxy_set_access_token (OAuth2Proxy $proxy, Str $access_token)
  is native(rest)
  is export
{ * }
