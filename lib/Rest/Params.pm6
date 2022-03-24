use v6.c;

use NativeCall;

use Rest::Raw::Types;
use Rest::Raw::Params;

use GLib::HashTable;

our subset RestParamAncestry is export of Mu
  where RestParams | GHashTable;

class Rest::Params is GLib::HashTable::String {
  has RestParams $!rps;

  submethod BUILD ( :$rest-params ) {
    $!rps = $rest-params;
  }

  multi method new (RestParamAncestry $rest-params, :$ref = True) {
    return Nil unless $rest-params;

    # cw: This is the other way to handle ancestry!
    my $o = self.bless(
      :$rest-params,
      hash-table => $rest-params
    );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $rest-params = rest_params_new();

    $rest-params ?? self.bless( :$rest-params, hash-table => $rest-params )
                 !! Nil;
  }

  method add (RestParam() $param) {
    rest_params_add($!rps, $param);
  }

  method are_strings {
    so rest_params_are_strings($!rps);
  }

  method as_string_hash_table ( :$raw = False ) {
    propReturnObject(
      rest_params_as_string_hash_table($!rps),
      $raw,
      GLib::HashTable::String.getTypePair
    );
  }

  method free {
    rest_params_free($!rps);
  }

  method get (Str() $name, :$raw = False) {
    propReturnObject(
      rest_params_get($!rps, $name),
      $raw,
      |Rest::Param.getTypePair
    );
  }

  method remove (Str() $name) {
    rest_params_remove($!rps, $name);
  }

}

class Rest::Parmas::Iter {
  has RestParamsIter $!rpi;

  submethod BUILD ( :$rest-params-iter ) {
    $!rpi = $rest-params-iter
  }

  method new (RestParams() $rp) {
    my $rest-params-iter = RestParamsIter.new;
    Rest::Params::Iter.init($rest-params-iter, $rp);

    $rest-params-iter ?? self.bless( :$rest-params-iter ) !! Nil;
  }

  method init (
    ::?CLASS:U:

    RestParamsIter $iter,
    RestParams     $params
  ) {
    rest_params_iter_init($iter, $params);
  }

  proto method next (|)
  { * }

  multi method next ( :$raw = False ) {
    my $cn = newCArray(Str);
    my $cp = newCArray(RestParam);

    samewith($cn, $cp, :$raw);
  }
  multi method next (
    CArray[Str]        $name,
    CArray[RestParam]  $param,
                      :$raw = False
  ) {
    rest_params_iter_next($!rpi, $name, $param);

    my $rpr = propReturnObject( ppr($param), $raw, |Rest::Param.getTypePair );

    ( ppr($name), $rpr )
  }
}
