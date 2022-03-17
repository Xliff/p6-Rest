use v6.c;

use GLib::Raw::Definitions;

unit package Rest::Raw::Enums;

constant OAuthSignatureMethod is export := guint32;
our enum OAuthSignatureMethodEnum is export <
  PLAINTEXT
  HMAC_SHA1
>;

constant RestMemoryUse is export := guint32;
our enum RestMemoryUseEnum is export <
  REST_MEMORY_STATIC
  REST_MEMORY_TAKE
  REST_MEMORY_COPY
>;

constant RestProxyCallError is export := guint32;
our enum RestProxyCallErrorEnum is export <
  REST_PROXY_CALL_FAILED
>;

constant RestProxyError is export := guint32;
our enum RestProxyErrorEnum is export (
  REST_PROXY_ERROR_CANCELLED                            =>   1,
  'REST_PROXY_ERROR_RESOLUTION',
  'REST_PROXY_ERROR_CONNECTION',
  'REST_PROXY_ERROR_SSL',
  'REST_PROXY_ERROR_IO',
  'REST_PROXY_ERROR_FAILED',
  REST_PROXY_ERROR_HTTP_MULTIPLE_CHOICES                => 300,
  REST_PROXY_ERROR_HTTP_MOVED_PERMANENTLY               => 301,
  REST_PROXY_ERROR_HTTP_FOUND                           => 302,
  REST_PROXY_ERROR_HTTP_SEE_OTHER                       => 303,
  REST_PROXY_ERROR_HTTP_NOT_MODIFIED                    => 304,
  REST_PROXY_ERROR_HTTP_USE_PROXY                       => 305,
  REST_PROXY_ERROR_HTTP_THREEOHSIX                      => 306,
  REST_PROXY_ERROR_HTTP_TEMPORARY_REDIRECT              => 307,
  REST_PROXY_ERROR_HTTP_BAD_REQUEST                     => 400,
  REST_PROXY_ERROR_HTTP_UNAUTHORIZED                    => 401,
  REST_PROXY_ERROR_HTTP_FOUROHTWO                       => 402,
  REST_PROXY_ERROR_HTTP_FORBIDDEN                       => 403,
  REST_PROXY_ERROR_HTTP_NOT_FOUND                       => 404,
  REST_PROXY_ERROR_HTTP_METHOD_NOT_ALLOWED              => 405,
  REST_PROXY_ERROR_HTTP_NOT_ACCEPTABLE                  => 406,
  REST_PROXY_ERROR_HTTP_PROXY_AUTHENTICATION_REQUIRED   => 407,
  REST_PROXY_ERROR_HTTP_REQUEST_TIMEOUT                 => 408,
  REST_PROXY_ERROR_HTTP_CONFLICT                        => 409,
  REST_PROXY_ERROR_HTTP_GONE                            => 410,
  REST_PROXY_ERROR_HTTP_LENGTH_REQUIRED                 => 411,
  REST_PROXY_ERROR_HTTP_PRECONDITION_FAILED             => 412,
  REST_PROXY_ERROR_HTTP_REQUEST_ENTITY_TOO_LARGE        => 413,
  REST_PROXY_ERROR_HTTP_REQUEST_URI_TOO_LONG            => 414,
  REST_PROXY_ERROR_HTTP_UNSUPPORTED_MEDIA_TYPE          => 415,
  REST_PROXY_ERROR_HTTP_REQUESTED_RANGE_NOT_SATISFIABLE => 416,
  REST_PROXY_ERROR_HTTP_EXPECTATION_FAILED              => 417,
  REST_PROXY_ERROR_HTTP_INTERNAL_SERVER_ERROR           => 500,
  REST_PROXY_ERROR_HTTP_NOT_IMPLEMENTED                 => 501,
  REST_PROXY_ERROR_HTTP_BAD_GATEWAY                     => 502,
  REST_PROXY_ERROR_HTTP_SERVICE_UNAVAILABLE             => 503,
  REST_PROXY_ERROR_HTTP_GATEWAY_TIMEOUT                 => 504,
  REST_PROXY_ERROR_HTTP_HTTP_VERSION_NOT_SUPPORTED      => 505,
);
