use v6.c;

use Method::Also;

use NativeCall;

use Rest::Raw::Types;
use Rest::Raw::Param;

use GLib::Roles::Implementor;

# BOXED
class Rest::Param {
  also does GLib::Roles::Implementor;

  has RestParam $!rp;

  submethod BUILD ( :$rest-param ) {
    $!rp = $rest-param;
  }

  method Rest::Raw::Definitions::RestParam
    is also<RestParam>
  { $!rp }

  proto method new_full (|)
    is also<new-full>
  { * }

  multi method new_full (
    Str()    $name,
    Int()    $use,
    Str      $data,
    Str()    $content_type,
    Str()    $filename,
            :$encoding      = 'utf8'
  ) {
    samewith($name, $use, $data.encode($encoding), $content_type, $filename);
  }
  multi method new_full (
    Str()    $name,
    Int()    $use,
    Buf      $data,
    Str()    $content_type,
    Str()    $filename
  ) {
    samewith(
      $name,
      $use,
      CArray[uint8].new($data),
      $data.bytes,
      $content_type,
      $filename
    )
  }
  multi method new_full (
    Str()         $name,
    Int()         $use,
    CArray[uint8] $data,
    Str()         $content_type,
    Str()         $filename
  ) {
    samewith(
      $name,
      $use,
      cast(Pointer, $data),
      $data.elems,
      $content_type,
      $filename
    )
  }
  multi method new_full (
    Str()         $name,
    Int()         $use,
    CArray[uint8] $data,
    Int()         $length         is copy,
    Str()         $content_type,
    Str()         $filename
  ) {
    samewith(
      $name,
      $use,
      cast(Pointer, $data),
      $length,
      $content_type,
      $filename
    )
  }
  multi method new_full (
    Str()    $name,
    Int()    $use,
    gpointer $data,
    Int()    $length,
    Str()    $content_type,
    Str()    $filename
  ) {
    my RestMemoryUse $u = $use;
    my gsize         $l = $length;

    my $rest-param = rest_param_new_full(
      $name,
      $u,
      $data,
      $l,
      $content_type,
      $filename
    );

    $rest-param ?? self.bless( :$rest-param ) !! Nil;
  }

  method new_string (Str() $name, Int() $use, Str() $string) is also<new-string> {
    my RestMemoryUse $u = $use;

    my $rest-param = rest_param_new_string($!rp, $name, $use, $string);

    $rest-param ?? self.bless( :$rest-param ) !! Nil;
  }

  proto method new_with_owner (|)
    is also<new-with-owner>
  { * }

  multi method new_with_owner (
    Str()     $name,
    Str       $data,
    Str()     $content_type,
    Str()     $filename,
    gpointer  $owner,
              &owner_dnotify,
             :$encoding       = 'utf8'
  ) {
    samewith(
      $name,
      $data.encode($encoding),
      $content_type,
      $filename,
      $owner,
      &owner_dnotify
    )
  }
  multi method new_with_owner (
    Str()     $name,
    Buf       $data,
    Str()     $content_type,
    Str()     $filename,
    gpointer  $owner,
              &owner_dnotify
  ) {
    samewith(
      $name,
      CArray[uint8].new($data),
      $data.bytes,
      $content_type,
      $filename,
      $owner,
      &owner_dnotify
    )
  }
  multi method new_with_owner (
    Str()         $name,
    CArray[uint8] $data,
    Int()         $length,
    Str()         $content_type,
    Str()         $filename,
    gpointer      $owner,
                  &owner_dnotify
  ) {
    samewith(
      $name,
      cast(Pointer, $data),
      $length,
      $content_type,
      $filename,
      $owner,
      &owner_dnotify
    );
  }
  multi method new_with_owner (
    Str()    $name,
    gpointer $data,
    Int()    $length,
    Str()    $content_type,
    Str()    $filename,
    gpointer $owner,
             &owner_dnotify
  ) {
    my gsize $l = $length;

    rest_param_new_with_owner(
      $name,
      $data,
      $l,
      $content_type,
      $filename,
      $owner,
      &owner_dnotify
    );
  }

  method get_content ( :$carray = False )
    is also<
      get-content
      content
    >
  {
    $carray ?? rest_param_get_content_carray($!rp)
            !! rest_param_get_content($!rp);
  }

  method get_content_length
    is also<
      get-content-length
      content_length
      content-length
    >
  {
    rest_param_get_content_length($!rp);
  }

  method get_content_type
    is also<
      get-content-type
      content_type
      content-type
    >
  {
    rest_param_get_content_type($!rp);
  }

  method get_file_name
    is also<
      get-file-name
      file_name
      file-name
      filename
    >
  {
    rest_param_get_file_name($!rp);
  }

  method get_name
    is also<
      get-name
      name
    >
  {
    rest_param_get_name($!rp);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &rest_param_get_type, $n, $t );
  }

  method is_string is also<is-string> {
    so rest_param_is_string($!rp);
  }

  method ref {
    rest_param_ref($!rp);
    self;
  }

  method unref {
    rest_param_unref($!rp);
  }
}
