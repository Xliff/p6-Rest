use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use Rest::Raw::Definitions;
use Rest::Raw::Enums;

### /usr/src/librest-0.8.1/rest/rest-param.h

sub rest_param_get_content (RestParam $param)
  returns gpointer
  is native(rest)
  is export
{ * }

sub rest_param_get_content_carray (RestParam $param)
  returns CArray[uint8]
  is native(rest)
  is symbol('rest_param_get_content')
  is export
{ * }

sub rest_param_get_content_length (RestParam $param)
  returns gsize
  is native(rest)
  is export
{ * }

sub rest_param_get_content_type (RestParam $param)
  returns Str
  is native(rest)
  is export
{ * }

sub rest_param_get_file_name (RestParam $param)
  returns Str
  is native(rest)
  is export
{ * }

sub rest_param_get_name (RestParam $param)
  returns Str
  is native(rest)
  is export
{ * }

sub rest_param_get_type ()
  returns GType
  is native(rest)
  is export
{ * }

sub rest_param_is_string (RestParam $param)
  returns uint32
  is native(rest)
  is export
{ * }

sub rest_param_new_full (
  Str           $name,
  RestMemoryUse $use,
  gpointer      $data,
  gsize         $length,
  Str           $content_type,
  Str           $filename
)
  returns RestParam
  is native(rest)
  is export
{ * }

sub rest_param_new_string (Str $name, RestMemoryUse $use, Str $string)
  returns RestParam
  is native(rest)
  is export
{ * }

sub rest_param_new_with_owner (
  Str      $name,
  gpointer $data,
  gsize    $length,
  Str      $content_type,
  Str      $filename,
  gpointer $owner,
           &owner_dnotify (gpointer)
)
  returns RestParam
  is native(rest)
  is export
{ * }

sub rest_param_ref (RestParam $param)
  returns RestParam
  is native(rest)
  is export
{ * }

sub rest_param_unref (RestParam $param)
  is native(rest)
  is export
{ * }
