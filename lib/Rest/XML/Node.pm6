use v6.c;

use Method::Also;

use Rest::Raw::Types;
use Rest::Raw::XML::Node;

use GLib::Roles::Implementor;

# BOXED
class Rest::XML::Node {
  also does GLib::Roles::Implementor;

  has RestXmlNode $!rxn is implementor handles<name content>;

  submethod BUILD ( :$rest-xml-node ) {
    $!rxn = $rest-xml-node
  }

  method Rest::Raw::Definitions::RestXmlNode
    is also<RestXmlNode>
  { $!rxn }

  method Array {
    my ($n, @ret) = (self);

    while $n {
      @ret.push($n);
      $n = $n.next;
    }
    @ret;
  }

  method new (RestXmlNode $rest-xml-node) {
    $rest-xml-node ?? self.bless( :$rest-xml-node ) !! Nil;
  }

  method add_attr (Str() $attribute, Str() $value) is also<add-attr> {
    rest_xml_node_add_attr($!rxn, $attribute, $value);
  }

  method add_child (Str() $tag, :$raw = False) is also<add-child> {
    propReturnObject(
      rest_xml_node_add_child($!rxn, $tag),
      $raw,
      |self.getTypePair
    );
  }

  method find (Str() $tag, :$raw = False) {
    propReturnObject(
      rest_xml_node_find($!rxn, $tag),
      $raw,
      |self.getTypePair
    );
  }

  method free {
    rest_xml_node_free($!rxn);
  }

  method get_attr (Str() $attr_name) is also<get-attr> {
    rest_xml_node_get_attr($!rxn, $attr_name);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &rest_xml_node_get_type, $n, $t );
  }

  method print {
    rest_xml_node_print($!rxn);
  }

  method ref {
    rest_xml_node_ref($!rxn);
    self;
  }

  method set_content (Str() $value) is also<set-content> {
    rest_xml_node_set_content($!rxn, $value);
  }

  method unref {
    rest_xml_node_unref($!rxn);
  }

  # Consider wrapping $!rxn attributes in objects, here.
  method next ( :$raw = False ) {
    propReturnObject(
      $!rxn.next,
      $raw,
      |self.getTypePair
    );
  }

  method children ( :$raw = False ) {
    propReturnObject(
      $!rxn.children,
      $raw,
      |GLib::HashTable::String.getTypePair
    );
  }

  method attrs ( :$raw = False ) {
    propReturnObject(
      $!rxn.attrs,
      $raw,
      |GLib::HashTable::String.getTypePair
    );
  }
}
