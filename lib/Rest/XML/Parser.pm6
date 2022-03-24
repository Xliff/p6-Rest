use v6.c;

use Method::Also;

use NativeCall;

use Rest::Raw::Types;

use Rest::XML::Node;

use GLib::Roles::Object;

our subset RestXmlParserAncestry is export of Mu
  where RestXmlParser | GObject;

class Rest::XML::Parser {
  also does GLib::Roles::Object;

  has RestXmlParser $!rxp;

  submethod BUILD ( :$rest-xml-parser ) {
    self.setRestXmlParser( $rest-xml-parser ) if $rest-xml-parser
  }

  method setRestXmlParser (RestXmlParserAncestry $_) {
    my $to-parent;

    $!rxp = do {
      when RestXmlParser {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(RestXmlParser, $_);
      }
    }
    self!setObject($to-parent)
  }

  method Rest::Raw::Definitions::RestXmlParser
    is also<RestXmlParser>
  { $!rxp }

  multi method new (RestXmlParserAncestry $rest-xml-parser, :$ref = True) {
    return Nil unless $rest-xml-parser;

    my $o = self.bless( :$rest-xml-parser );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $rest-xml-parser = rest_xml_parser_new();

    $rest-xml-parser ?? self.bless( :$rest-xml-parser ) !! Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &rest_xml_parser_get_type, $n, $t );
  }

  method parse_from_data (Str() $data, Int() $len = $data.chars, :$raw = False)
    is also<parse-from-data>
  {
    my goffset $l = $len;

    propReturnObject(
      rest_xml_parser_parse_from_data($!rxp, $data, $l),
      $raw,
      |Rest::XML::Node.getTypePair
    );
  }

}

### /usr/src/librest-0.8.1/rest/rest-xml-parser.h

sub rest_xml_parser_get_type ()
  returns GType
  is native(rest)
  is export
{ * }

sub rest_xml_parser_new ()
  returns RestXmlParser
  is native(rest)
  is export
{ * }

sub rest_xml_parser_parse_from_data (
  RestXmlParser $parser,
  Str           $data,
  goffset       $len
)
  returns RestXmlNode
  is native(rest)
  is export
{ * }
