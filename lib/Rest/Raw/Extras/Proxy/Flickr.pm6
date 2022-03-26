use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use Rest::Raw::Definitions;

### /usr/src/librest-0.8.1/rest-extras/flickr-proxy.h

sub flickr_proxy_build_login_url (FlickrProxy $proxy, Str $frob, Str $perms)
  returns Str
  is native(rest-extras)
  is export
{ * }

sub flickr_proxy_get_api_key (FlickrProxy $proxy)
  returns Str
  is native(rest-extras)
  is export
{ * }

sub flickr_proxy_get_shared_secret (FlickrProxy $proxy)
  returns Str
  is native(rest-extras)
  is export
{ * }

sub flickr_proxy_get_token (FlickrProxy $proxy)
  returns Str
  is native(rest-extras)
  is export
{ * }

sub flickr_proxy_get_type ()
  returns GType
  is native(rest-extras)
  is export
{ * }

sub flickr_proxy_is_successful (
  RestXmlNode             $root,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(rest-extras)
  is export
{ * }

sub flickr_proxy_new (Str $api_key, Str $shared_secret)
  returns RestProxy
  is native(rest-extras)
  is export
{ * }

sub flickr_proxy_new_upload (FlickrProxy $proxy)
  returns FlickrProxyCall
  is native(rest-extras)
  is export
{ * }

sub flickr_proxy_new_upload_for_file (
  FlickrProxy             $proxy,
  Str                     $filename,
  CArray[Pointer[GError]] $error
)
  returns FlickrProxyCall
  is native(rest-extras)
  is export
{ * }

sub flickr_proxy_new_with_token (Str $api_key, Str $shared_secret, Str $token)
  returns FlickrProxy
  is native(rest-extras)
  is export
{ * }

sub flickr_proxy_set_token (FlickrProxy $proxy, Str $token)
  is native(rest-extras)
  is export
{ * }

sub flickr_proxy_sign (FlickrProxy $proxy, GHashTable $params)
  returns Str
  is native(rest-extras)
  is export
{ * }
