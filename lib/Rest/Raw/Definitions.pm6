use v6.c;

use GLib::Raw::Definitions;
use GLib::Raw::Object;
use GLib::Raw::Structs;

use GLib::Roles::Pointers;

unit package Rest::Raw::Definitions;

constant rest        is export = 'rest-0.7',v0;
constant rest-extras is export = 'rest-extras-0.7',v0;

class OAuthProxy        is repr<CPointer> is export does GLib::Roles::Pointers { }
class OAuth2Proxy       is repr<CPointer> is export does GLib::Roles::Pointers { }
class RestProxy         is repr<CPointer> is export does GLib::Roles::Pointers { }
class RestProxyAuth     is repr<CPointer> is export does GLib::Roles::Pointers { }
class RestProxyCall     is repr<CPointer> is export does GLib::Roles::Pointers { }
class RestParam         is repr<CPointer> is export does GLib::Roles::Pointers { }
class RestParams        is repr<CPointer> is export does GLib::Roles::Pointers { }

class FlickrProxy       is repr<CPointer> is export does GLib::Roles::Pointers { }
class LastfmProxy       is repr<CPointer> is export does GLib::Roles::Pointers { }
class YoutubeProxy      is repr<CPointer> is export does GLib::Roles::Pointers { }

class FlickrProxyCall   is repr<CPointer> is export does GLib::Roles::Pointers { }

class RestXmlParser is repr<CStruct> is export does GLib::Roles::Pointers {
  HAS GObject $.parent
}

class RestXmlNode is repr<CStruct> is export does GLib::Roles::Pointers {
  has gint        $.ref_count;
  has Str         $.name;
  has Str         $.content;
  has GHashTable  $!children;
  has GHashTable  $!attrs;
  has RestXmlNode $!next;

  method children is rw {
    Proxy.new:
      FETCH => -> $                { $!children      },
      STORE => -> $, GHashTable \v { $!children := v }
  }
  method attrs is rw {
    Proxy.new:
      FETCH => -> $                { $!attrs         },
      STORE => -> $, GHashTable \v { $!attrs := v    }
  }
  method next is rw {
    Proxy.new:
      FETCH => -> $                { $!next          },
      STORE => -> $, RestXmlNode \v { $!next := v    }
  }
};

constant RestParamsIter is export = GHashTableIter;
