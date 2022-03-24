use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use Rest::Raw::Definitions;

unit package Rest::Raw::Extras::LastFM;

### /usr/src/librest-0.8.1/rest/../rest-extras/lastfm-proxy.h

sub lastfm_proxy_build_login_url (LastfmProxy $proxy, Str $token)
  returns Str
  is native(rest-extras)
  is export
{ * }

sub lastfm_proxy_get_api_key (LastfmProxy $proxy)
  returns Str
  is native(rest-extras)
  is export
{ * }

sub lastfm_proxy_get_secret (LastfmProxy $proxy)
  returns Str
  is native(rest-extras)
  is export
{ * }

sub lastfm_proxy_get_session_key (LastfmProxy $proxy)
  returns Str
  is native(rest-extras)
  is export
{ * }

sub lastfm_proxy_get_type ()
  returns GType
  is native(rest-extras)
  is export
{ * }

sub lastfm_proxy_is_successful (
  RestXmlNode             $root,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(rest-extras)
  is export
{ * }

sub lastfm_proxy_new (Str $api_key, Str $secret)
  returns LastfmProxy
  is native(rest-extras)
  is export
{ * }

sub lastfm_proxy_new_with_session (Str $api_key, Str $secret, Str $session_key)
  returns LastfmProxy
  is native(rest-extras)
  is export
{ * }

sub lastfm_proxy_set_session_key (LastfmProxy $proxy, Str $session_key)
  is native(rest-extras)
  is export
{ * }

sub lastfm_proxy_sign (LastfmProxy $proxy, GHashTable $params)
  returns Str
  is native(rest-extras)
  is export
{ * }
