use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GLib::Raw::Object;
use GIO::Raw::Definitions;
use Rest::Raw::Definitions;

unit package Rest::Raw::Proxy::Call;

### /usr/src/librest-0.8.1/rest/rest-proxy-call.h

sub rest_proxy_call_add_header (RestProxyCall $call, Str $header, Str $value)
  is native(rest)
  is export
{ * }

sub rest_proxy_call_add_headers (RestProxyCall $call)
  is native(rest)
  is export
{ * }

# sub rest_proxy_call_add_headers_from_valist (
#   RestProxyCall $call,
#   va_list       $headers
# )
#   is native(rest)
#   is export
# { * }

sub rest_proxy_call_add_param (RestProxyCall $call, Str $name, Str $value)
  is native(rest)
  is export
{ * }

sub rest_proxy_call_add_param_full (RestProxyCall $call, RestParam $param)
  is native(rest)
  is export
{ * }

sub rest_proxy_call_add_params (RestProxyCall $call)
  is native(rest)
  is export
{ * }

# sub rest_proxy_call_add_params_from_valist (RestProxyCall $call, va_list $params)
#   is native(rest)
#   is export
# { * }

sub rest_proxy_call_async (
  RestProxyCall           $call,
                          & (
                            RestProxyCall,
                            GError,
                            GObject,
                            gpointer
                          ),
  GObject                 $weak_object,
  gpointer                $userdata,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(rest)
  is export
{ * }

sub rest_proxy_call_cancel (RestProxyCall $call)
  returns uint32
  is native(rest)
  is export
{ * }

sub rest_proxy_call_continuous (
  RestProxyCall           $call,
                          & (
                            RestProxyCall,
                            Str,
                            gsize,
                            GError,
                            GObject,
                            gpointer
                          ),
  GObject                 $weak_object,
  gpointer                $userdata,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(rest)
  is export
{ * }

sub rest_proxy_call_error_quark ()
  returns GQuark
  is native(rest)
  is export
{ * }

sub rest_proxy_call_get_function (RestProxyCall $call)
  returns Str
  is native(rest)
  is export
{ * }

sub rest_proxy_call_get_method (RestProxyCall $call)
  returns Str
  is native(rest)
  is export
{ * }

sub rest_proxy_call_get_params (RestProxyCall $call)
  returns RestParams
  is native(rest)
  is export
{ * }

sub rest_proxy_call_get_payload (RestProxyCall $call)
  returns Str
  is native(rest)
  is export
{ * }

sub rest_proxy_call_get_payload_length (RestProxyCall $call)
  returns goffset
  is native(rest)
  is export
{ * }

sub rest_proxy_call_get_response_headers (RestProxyCall $call)
  returns GHashTable
  is native(rest)
  is export
{ * }

sub rest_proxy_call_get_status_code (RestProxyCall $call)
  returns guint
  is native(rest)
  is export
{ * }

sub rest_proxy_call_get_status_message (RestProxyCall $call)
  returns Str
  is native(rest)
  is export
{ * }

sub rest_proxy_call_get_type ()
  returns GType
  is native(rest)
  is export
{ * }

sub rest_proxy_call_invoke_async (
  RestProxyCall $call,
  GCancellable  $cancellable,
                & (RestProxyCall, GAsyncResult, gpointer),
  gpointer      $user_data
)
  is native(rest)
  is export
{ * }

sub rest_proxy_call_invoke_finish (
  RestProxyCall           $call,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(rest)
  is export
{ * }

sub rest_proxy_call_lookup_header (RestProxyCall $call, Str $header)
  returns Str
  is native(rest)
  is export
{ * }

sub rest_proxy_call_lookup_param (RestProxyCall $call, Str $name)
  returns RestParam
  is native(rest)
  is export
{ * }

sub rest_proxy_call_lookup_response_header (RestProxyCall $call, Str $header)
  returns Str
  is native(rest)
  is export
{ * }

sub rest_proxy_call_remove_header (RestProxyCall $call, Str $header)
  is native(rest)
  is export
{ * }

sub rest_proxy_call_remove_param (RestProxyCall $call, Str $name)
  is native(rest)
  is export
{ * }

sub rest_proxy_call_run (
  RestProxyCall           $call,
  CArray[GMainLoop]       $loop,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(rest)
  is export
{ * }

sub rest_proxy_call_serialize_params (
  RestProxyCall           $call,
  CArray[Str]             $content_type,
  CArray[Str]             $content,
  gsize                   $content_len,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(rest)
  is export
{ * }

sub rest_proxy_call_set_function (RestProxyCall $call, Str $function)
  is native(rest)
  is export
{ * }

sub rest_proxy_call_set_method (RestProxyCall $call, Str $method)
  is native(rest)
  is export
{ * }

sub rest_proxy_call_sync (
  RestProxyCall           $call,
  CArray[Pointer[GError]] $error_out
)
  returns uint32
  is native(rest)
  is export
{ * }

sub rest_proxy_call_upload (
  RestProxyCall           $call,
                          & (
                            RestProxyCall,
                            gsize,
                            gsize,
                            GError,
                            GObject,
                            gpointer
                          ),
  GObject                 $weak_object,
  gpointer                $userdata,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(rest)
  is export
{ * }
