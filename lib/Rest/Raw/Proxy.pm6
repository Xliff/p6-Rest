use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use SOUP::Raw::Definitions;
use SOUP::Raw::Enums;
use Rest::Raw::Definitions;

unit package Rest::Raw::Proxy;

### /usr/include/rest-0.7/rest/rest-proxy.h

sub rest_proxy_add_soup_feature (
  RestProxy          $proxy,
  SoupSessionFeature $feature
)
  is native(rest)
  is export
{ * }

sub rest_proxy_error_quark ()
  returns GQuark
  is native(rest)
  is export
{ * }

sub rest_proxy_get_type ()
  returns GType
  is native(rest)
  is export
{ * }

sub rest_proxy_get_user_agent (RestProxy $proxy)
  returns Str
  is native(rest)
  is export
{ * }

sub rest_proxy_new (Str $url_format, gboolean $binding_required)
  returns RestProxy
  is native(rest)
  is export
{ * }

sub rest_proxy_new_call (RestProxy $proxy)
  returns RestProxyCall
  is native(rest)
  is export
{ * }

sub rest_proxy_new_with_authentication (
  Str      $url_format,
  gboolean $binding_required,
  Str      $username,
  Str      $password
)
  returns RestProxy
  is native(rest)
  is export
{ * }

sub rest_proxy_set_user_agent (RestProxy $proxy, Str $user_agent)
  is native(rest)
  is export
{ * }

# cw: In the case of bind, the var args refers to parametrs in the
#     url format. In this situation, it is probably just easier to
#     give a list of parameter names to apply. If necessary, there
#     will be a helper function.

# No valist or var-args
# sub rest_proxy_bind (RestProxy $proxy)
#   returns uint32
#   is native(rest)
#   is export
# { * }

# No valist or var-args!
# sub rest_proxy_bind_valist (RestProxy $proxy, va_list $params)
#   returns uint32
#   is native(rest)
#   is export
# { * }

# cw: The var_arg routines here are simply shorcuts for creating a
#     RestProxyCall and adding params to it. Params are basically
#     string pairs: parameter-name, parameter-value

# No valist or var-args!
# sub rest_proxy_simple_run (
#   RestProxy               $proxy,
#   CArray[Str]             $payload,
#   goffset                 $len,
#   CArray[Pointer[GError]] $error,
#   ...
# )
#   returns uint32
#   is native(rest)
#   is export
# { * }
