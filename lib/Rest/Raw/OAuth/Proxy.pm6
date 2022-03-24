use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Object;
use GLib::Raw::Structs;
use Rest::Raw::Definitions;

### /usr/src/librest-0.8.1/rest/oauth-proxy.h

sub oauth_proxy_access_token (
  OAuthProxy              $proxy,
  Str                     $function,
  Str                     $verifier,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(rest)
  is export
{ * }

sub oauth_proxy_access_token_async (
  OAuthProxy              $proxy,
  Str                     $function,
  Str                     $verifier,
                          &callback (OAuthProxy, GError, GObject, gpointer),
  GObject                 $weak_object,
  gpointer                $user_data,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(rest)
  is export
{ * }

sub oauth_proxy_auth_step (
  OAuthProxy              $proxy,
  Str                     $function,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(rest)
  is export
{ * }

sub oauth_proxy_auth_step_async (
  OAuthProxy              $proxy,
  Str                     $function,
                          &callback (OAuthProxy, GError, GObject, gpointer),
  GObject                 $weak_object,
  gpointer                $user_data,
  CArray[Pointer[GError]] $error_out
)
  returns uint32
  is native(rest)
  is export
{ * }

sub oauth_proxy_get_signature_host (OAuthProxy $proxy)
  returns Str
  is native(rest)
  is export
{ * }

sub oauth_proxy_get_token (OAuthProxy $proxy)
  returns Str
  is native(rest)
  is export
{ * }

sub oauth_proxy_get_token_secret (OAuthProxy $proxy)
  returns Str
  is native(rest)
  is export
{ * }

sub oauth_proxy_get_type ()
  returns GType
  is native(rest)
  is export
{ * }

sub oauth_proxy_is_oauth10a (OAuthProxy $proxy)
  returns uint32
  is native(rest)
  is export
{ * }

sub oauth_proxy_new (
  Str      $consumer_key,
  Str      $consumer_secret,
  Str      $url_format,
  gboolean $binding_required
)
  returns RestProxy
  is native(rest)
  is export
{ * }

sub oauth_proxy_new_echo_proxy (
  OAuthProxy $proxy,
  Str        $service_url,
  Str        $url_format,
  gboolean   $binding_required
)
  returns RestProxy
  is native(rest)
  is export
{ * }

sub oauth_proxy_new_with_token (
  Str      $consumer_key,
  Str      $consumer_secret,
  Str      $token,
  Str      $token_secret,
  Str      $url_format,
  gboolean $binding_required
)
  returns RestProxy
  is native(rest)
  is export
{ * }

sub oauth_signature_method_get_type ()
  returns GType
  is native(rest)
  is export
{ * }

sub oauth_proxy_request_token (
  OAuthProxy              $proxy,
  Str                     $function,
  Str                     $callback_uri,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(rest)
  is export
{ * }

sub oauth_proxy_request_token_async (
  OAuthProxy              $proxy,
  Str                     $function,
  Str                     $callback_uri,
                          &callback (OAuthProxy, GError, GObject, gpointer),
  GObject                 $weak_object,
  gpointer                $user_data,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(rest)
  is export
{ * }

sub oauth_proxy_set_signature_host (OAuthProxy $proxy, Str $signature_host)
  is native(rest)
  is export
{ * }

sub oauth_proxy_set_token (OAuthProxy $proxy, Str $token)
  is native(rest)
  is export
{ * }

sub oauth_proxy_set_token_secret (
  OAuthProxy $proxy,
  Str        $token_secret
)
  is native(rest)
  is export
{ * }
