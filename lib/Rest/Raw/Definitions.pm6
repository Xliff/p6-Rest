use v6.c;

use GLib::Raw::Definitions;

use GLib::Roles::Pointers;

unit package Rest::Raw::Definitions;

constant rest is export = 'rest-0.7',v0;

class RestProxy    is repr<CPointer> is export does GLib::Roles::Pointers { }
