use v6.c;

use NativeCall;

use GLib::Raw::ReturnedValue;
use Rest::Raw::Types;

use Rest::Proxy::Auth;

use GLib::Roles::Signals::Generic;

role Rest::Roles::Signals::Proxy {
  also does GLib::Roles::Signals::Generic;

  has %!signals-rp;

  #  RestProxyAuth *auth, gboolean retrying --> gboolean
  method connect-authenticate (
    $obj,
    $signal = 'authenticate',
    &handler?
  ) {
    my $hid;
    %!signals-rp{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-authenticate($obj, $signal,
        -> $, $rpa, $g {
          CATCH {
            default { 𝒮.note($_) }
          }

          # cw: In a departure from normal, we create the Auth object
          #     here and pass it to the user-exposed handler.
          my $rpao = Rest::Proxy::Auth.new($rpa);

          my $r = ReturnedValue.new;
          𝒮.emit( [self, $rpao, $g, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ self.create-signal-supply($signal, 𝒮), $obj, $hid ];
    };
    %!signals-rp{$signal}[0].tap(&handler) with &handler;
    %!signals-rp{$signal}[0];
  }
}

# RestProxy *proxy,  RestProxyAuth *auth,  gboolean retrying --> gboolean
sub g-connect-authenticate (
  Pointer $app,
  Str     $name,
          &handler (Pointer, RestProxyAuth, gboolean --> gboolean),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }
