use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use Rest::Raw::Definitions;

unit package Rest::Raw::XML::Node;

### /usr/src/librest-0.8.1/rest/rest-xml-node.h

sub rest_xml_node_add_attr (RestXmlNode $node, Str $attribute, Str $value)
  is native(rest)
  is export
{ * }

sub rest_xml_node_add_child (RestXmlNode $parent, Str $tag)
  returns RestXmlNode
  is native(rest)
  is export
{ * }

sub rest_xml_node_find (RestXmlNode $start, Str $tag)
  returns RestXmlNode
  is native(rest)
  is export
{ * }

sub rest_xml_node_free (RestXmlNode $node)
  is native(rest)
  is export
{ * }

sub rest_xml_node_get_attr (RestXmlNode $node, Str $attr_name)
  returns Str
  is native(rest)
  is export
{ * }

sub rest_xml_node_get_type ()
  returns GType
  is native(rest)
  is export
{ * }

sub rest_xml_node_print (RestXmlNode $node)
  returns Str
  is native(rest)
  is export
{ * }

sub rest_xml_node_ref (RestXmlNode $node)
  returns RestXmlNode
  is native(rest)
  is export
{ * }

sub rest_xml_node_set_content (RestXmlNode $node, Str $value)
  is native(rest)
  is export
{ * }

sub rest_xml_node_unref (RestXmlNode $node)
  is native(rest)
  is export
{ * }
