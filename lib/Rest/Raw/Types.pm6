use v6;

use CompUnit::Util :re-export;

use GLib::Raw::Exports;
use SOUP::Raw::Exports;

my constant forced = 3;

unit package Rest::Raw::Types;

need GLib::Raw::Definitions;
need GLib::Raw::Enums;
need GLib::Raw::Exceptions;
need GLib::Raw::Object;
need GLib::Raw::Structs;
need GLib::Raw::Struct_Subs;
need GLib::Raw::Subs;
need GLib::Roles::Pointers;
need SOUP::Raw::Definitions;
need SOUP::Raw::Enums;
need SOUP::Raw::Structs;


BEGIN {
  glib-re-export($_) for |@glib-exports,
                         |@soup-exports;
}
