use v6.c;

use Method::Also;

use NativeCall;

use Rest::Raw::Types;

use GLib::Roles::Object;

our subset RestProxyAuthAncestry is export of Mu
  where RestProxyAuth | GObject;

class Rest::Proxy::Auth {
  also does GLib::Roles::Object;

  has RestProxyAuth $!rpa;

  submethod BUILD ( :$rest-proxy-auth ) {
    self.setRestProxyAuth( $rest-proxy-auth ) if $rest-proxy-auth
  }

  method setRestProxyAuth (RestProxyAuthAncestry $_) {
    my $to-parent;

    $!rpa = do {
      when RestProxyAuth {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(RestProxyAuth, $_);
      }
    }
    self!setObject($to-parent)
  }

  method Rest::Raw::Definitions::RestProxyAuth
    is also<RestProxyAuth>
  { $!rpa }

  multi method new (RestProxyAuthAncestry $rest-proxy-auth, :$ref = True) {
    return Nil unless $rest-proxy-auth;

    my $o = self.bless( :$rest-proxy-auth );
    $o.ref if $ref;
    $o;
  }

  method cancel {
    rest_proxy_auth_cancel($!rpa);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &rest_proxy_auth_get_type, $n, $t );
  }

  method pause {
    rest_proxy_auth_pause($!rpa);
  }

  method unpause {
    rest_proxy_auth_unpause($!rpa);
  }
}


### /usr/src/librest-0.8.1/rest/rest-proxy-auth-auth.h

sub rest_proxy_auth_cancel (RestProxyAuth $auth)
  is native(rest)
  is export
{ * }

sub rest_proxy_auth_get_type ()
  returns GType
  is native(rest)
  is export
{ * }

sub rest_proxy_auth_pause (RestProxyAuth $auth)
  is native(rest)
  is export
{ * }

sub rest_proxy_auth_unpause (RestProxyAuth $auth)
  is native(rest)
  is export
{ * }
