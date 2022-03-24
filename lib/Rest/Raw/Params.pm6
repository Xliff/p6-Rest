use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use Rest::Raw::Definitions;

unit package Rest::Raw::Params;

### /usr/src/librest-0.8.1/rest/rest-params.h

sub rest_params_add (RestParams $params, RestParam $param)
  is native(rest)
  is export
{ * }

sub rest_params_are_strings (RestParams $params)
  returns uint32
  is native(rest)
  is export
{ * }

sub rest_params_as_string_hash_table (RestParams $params)
  returns GHashTable
  is native(rest)
  is export
{ * }

sub rest_params_free (RestParams $params)
  is native(rest)
  is export
{ * }

sub rest_params_get (RestParams $params, Str $name)
  returns RestParam
  is native(rest)
  is export
{ * }

sub rest_params_iter_init (RestParamsIter $iter, RestParams $params)
  is native(rest)
  is export
{ * }

sub rest_params_iter_next (
  RestParamsIter    $iter,
  CArray[Str]       $name,
  CArray[RestParam] $param
)
  returns uint32
  is native(rest)
  is export
{ * }

sub rest_params_new ()
  returns RestParams
  is native(rest)
  is export
{ * }

sub rest_params_remove (RestParams $params, Str $name)
  is native(rest)
  is export
{ * }
