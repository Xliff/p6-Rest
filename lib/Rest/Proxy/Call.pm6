use v6.c;

use Method::Also;
use NativeCall;

use Rest::Raw::Types;
use Rest::Raw::Proxy::Call;

use Rest::Param;
use Rest::Params;

use GLib::Roles::Object;

our subset RestProxyCallAncestry is export of Mu
  where RestProxyCall | GObject;

class Rest::Proxy::Call {
  also does GLib::Roles::Object;

  has RestProxyCall $!rpc;

  submethod BUILD ( :$rest-proxy-call ) {
    self.setRestProxyCall( $rest-proxy-call ) if $rest-proxy-call
  }

  method setRestProxyCall (RestProxyCallAncestry $_) {
    my $to-parent;

    $!rpc = do {
      when RestProxyCall {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(RestProxyCall, $_);
      }
    }
    self!setObject($to-parent)
  }

  method Rest::Raw::Definitions::RestProxyCall
    is also<RestProxyCall>
  { $!rpc }

  multi method new (RestProxyCallAncestry $rest-proxy-call, :$ref = True) {
    return Nil unless $rest-proxy-call;

    my $o = self.bless( :$rest-proxy-call );
    $o.ref if $ref;
    $o
  }

  method add_header (Str() $header, Str() $value) is also<add-header> {
    rest_proxy_call_add_header($!rpc, $header, $value);
  }

  proto method add_headers (*%headers)
    is also<add-headers>
  { * }

  multi method add_headers (%headers) {
    samewith(|%headers);
  }
  multi method add_headers (*%headers) {
    self.add_header( .key, .value ) for %headers.pairs;
  }

  method add_param (Str() $name, Str() $value) is also<add-param> {
    rest_proxy_call_add_param($!rpc, $name, $value);
  }

  method add_param_full (RestParam() $param) is also<add-param-full> {
    rest_proxy_call_add_param_full($!rpc, $param);
  }

  proto method add_params (|)
    is also<add-params>
  { * }

  multi method add_params (%params) {
    samewith( |%params );
  }
  multi method add_params (*%params) {
    self.add_param( .key, .value ) for %params.pairs
  }

  method async (
              &callback,
    GObject() $weak_object,
    gpointer  $userdata,
    CArray[Pointer[GError]] $error = gerror
  ) {
    rest_proxy_call_async($!rpc, &callback, $weak_object, $userdata, $error);
  }

  method cancel {
    so rest_proxy_call_cancel($!rpc);
  }

  method continuous (
                            &callback,
    GObject()               $weak_object,
    gpointer                $userdata     = gpointer,
    CArray[Pointer[GError]] $error        = gerror
  ) {
    so rest_proxy_call_continuous(
      $!rpc,
      &callback,
      $weak_object,
      $userdata,
      $error
    );
  }

  method error_quark (Rest::Proxy::Call:U: ) is also<error-quark> {
    rest_proxy_call_error_quark();
  }

  method get_function
    is also<
      get-function
      function
    >
  {
    rest_proxy_call_get_function($!rpc);
  }

  method get_method
    is also<
      get-method
      method
    >
  {
    rest_proxy_call_get_method($!rpc);
  }

  method get_params ( :$raw = False )
    is also<
      get-params
      params
    >
  {
    propReturnObject(
      rest_proxy_call_get_params($!rpc),
      $raw,
      |Rest::Params.getTypePair
    );
  }

  method get_payload
    is also<
      get-payload
      payload
    >
  {
    rest_proxy_call_get_payload($!rpc);
  }

  method get_payload_length
    is also<
      get-payload-length
      payload_length
      payload-length
      length
    >
  {
    rest_proxy_call_get_payload_length($!rpc);
  }

  method get_response_headers
    is also<
      get-response-headers
      response_headers
      response-headers
    >
  {
    rest_proxy_call_get_response_headers($!rpc);
  }

  method get_status_code
    is also<
      get-status-code
      status_code
      status-code
    >
  {
    rest_proxy_call_get_status_code($!rpc);
  }

  method get_status_message
    is also<
      get-status-message
      status_message
      status-message
    >
  {
    rest_proxy_call_get_status_message($!rpc);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &rest_proxy_call_get_type, $n, $t );
  }

  proto method invoke_async (|)
    is also<invoke-async>
  { * }

  multi method invoke_async (
                    &callback,
    GCancellable() :$cancellable = GCancellable,
    gpointer       :$user_data   = gpointer
  ) {
    samewith($cancellable, &callback, $user_data);
  }
  multi method invoke_async (
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    rest_proxy_call_invoke_async($!rpc, $cancellable, &callback, $user_data);
  }

  method invoke_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error    = gerror
  )
    is also<invoke-finish>
  {
    so rest_proxy_call_invoke_finish($!rpc, $result, $error);
  }

  method lookup_header (Str() $header) is also<lookup-header> {
    rest_proxy_call_lookup_header($!rpc, $header);
  }

  method lookup_param (Str() $name, :$raw = False) is also<lookup-param> {
    propReturnObject(
      rest_proxy_call_lookup_param($!rpc, $name),
      $raw,
      |Rest::Param.getTypePair
    );
  }

  method lookup_response_header (Str() $header)
    is also<lookup-response-header>
  {
    rest_proxy_call_lookup_response_header($!rpc, $header);
  }

  method remove_header (Str() $header) is also<remove-header> {
    rest_proxy_call_remove_header($!rpc, $header);
  }

  method remove_param (Str() $name) is also<remove-param> {
    rest_proxy_call_remove_param($!rpc, $name);
  }

  subset GMainLoopCompat of Mu where *.^can('GMainLoop');

  multi method run (
    GMainLoopCompat         $loop,
    CArray[Pointer[GError]] $error = gerror
  ) {
    my $l = newCArray(GMainLoop);
    $l[0] = $loop.GMainLoop;
    samewith($l, $error);
  }
  multi method run (
    CArray[GMainLoop]       $loop  = CArray[GMainLoop],
    CArray[Pointer[GError]] $error = gerror
  ) {
    so rest_proxy_call_run($!rpc, $loop, $error);
  }

  method serialize_params (
    CArray[Str]             $content_type,
    CArray[Str]             $content,
    Int()                   $content_len,
    CArray[Pointer[GError]] $error
  )
    is also<serialize-params>
  {
    my gsize $c = $content_len;

    so rest_proxy_call_serialize_params(
      $!rpc,
      $content_type,
      $content,
      $c,
      $error
    );
  }

  method set_function (Str() $function) is also<set-function> {
    rest_proxy_call_set_function($!rpc, $function);
  }

  method set_method (Str() $method) is also<set-method> {
    rest_proxy_call_set_method($!rpc, $method);
  }

  method sync (CArray[Pointer[GError]] $error_out = gerror) {
    so rest_proxy_call_sync($!rpc, $error_out);
  }

  method upload (
                            &callback,
    GObject                 $weak_object = GObject,
    gpointer                $userdata    = gpointer,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    so rest_proxy_call_upload(
      $!rpc,
      &callback,
      $weak_object,
      $userdata,
      $error
    );
  }

}
