use v6.c;

use Rest::Raw::Types;

use Rest::OAuth::Proxy;

sub open-binary-file ($bin-file is copy) {
  CATCH {
    default {
      say "Reading file failed: { .message }";
    }
  }

  $bin-file .= IO unless $bin-file ~~ IO::Path;
  $bin-file.open(:bin).slurp;
}

sub get-media-file-name {
  my ($file, $media) = 'test-media.png';

  # Try CWD
  $media = $file.IO;
  return $media if $media.r;

  # Try testing directory
  $media = 't'.IO.add($file);
  return $media if $media.r;

  # Settle on examples/ as final option
  $media = 'examples'.IO.add($file);
}

sub MAIN ($message) {
  my $proxy = Rest::OAuth::Proxy.new(
    'UfXFxDbUjk41scg0kmkFwA',
    'pYQlfI2ZQ1zVK0f01dnfhFTWzizBGDnhNJIw6xwto',
    'https://api.twitter.com/'
  );

  # First stage authentication, this gets a requiest token
  unless $proxy.request-token('oauth/request_token', 'oob') {
    $*ERR.say: "Cannot get a request token: { $ERROR.message }";
  }

  # From the token, construct a URL for the user to visit.
  say "Go to http://twitter.com/oauth/authorize?oauth_token={
       $proxy.get-token } then enter the PIN";

  my $pin = $*IN.get;

  unless $proxy.access-token('oauth/access_token', $pin) {
    $*ERR.say: "Cannot get access token: { $ERROR.message }";
    exit 1;
  }

  # We're now authenticated

  # In order to send an image to twitter, we must load it ourselves
  my $contents = open-binary-file( get-media-file-name() );
  my $img-param = Rest::Param.new-full(
    'media[]',
    REST_MEMORY_COPY,
    $contents,
    'multipart/form-data',
    'test-media.png'
  );
  my $call = $proxy.new-call;
  $call.set-function('1.1/statuses/update_with_media.json');
  $call.set-method('POST');
  $call.add-param('status', $message);
  $call.add-param-full($img-param);

  unless $call.sync {
    say qq:to/STATUS/
      Return Code: { $call.status-code }
      Payload: { $call.payload }
      Cannot make call: { $ERROR.message }
      STATUS
  }

  say $call.payload;
}
