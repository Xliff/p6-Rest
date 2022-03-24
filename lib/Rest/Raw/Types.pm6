use v6;

use CompUnit::Util :re-export;

use GLib::Raw::Exports;
use GIO::Raw::Exports;
use SOUP::Raw::Exports;
use Rest::Raw::Exports;

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
need GIO::Raw::Definitions;
need GIO::Raw::Enums;
need GIO::Raw::Structs;
need GIO::Raw::Subs;
need GIO::DBus::Raw::Types;
need GIO::Raw::Quarks;
need SOUP::Raw::Definitions;
need SOUP::Raw::Enums;
need SOUP::Raw::Subs;
need Rest::Raw::Definitions;
need Rest::Raw::Enums;

BEGIN {
  glib-re-export($_) for |@glib-exports,
                         |@gio-exports,
                         |@soup-exports,
                         |@rest-exports;
}
