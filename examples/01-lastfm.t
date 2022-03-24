use v6;

use Rest::Proxy;
use Rest::Extras::Proxy::LastFM;

constant API_KEY  = 'aa581f6505fd3ea79073ddcc2215cbc7';
constant SECRET   = '7db227a36b3154e3a3306a23754de1d7';
constant USERNAME = 'rossburton';

use Test;

sub MAIN {
  my $p = Rest::Extras::Proxy::LastFM.new(API_KEY, SECRET);

  is $p.api_key,     API_KEY,  'API key from proxy is correct';
  is $p.secret,      SECRET,   'SECRET from proxy is correct';

  my $call = $p.new-call;
  $call.set-function('user.getInfo');
  $call.add-param('user', USERNAME);
  die "Cannot make call: { $ERROR.message }" unless $call.sync;

  my $parser = Rest::XML::Parser.new;
  my $root = $parser.parse-from-data($call.payload, $call.length);

  ok $root,                    'Parsed Root node exists';
  is $root.name,     'lfm',    'Root node has the correct name';

  my $attr = $root.get-attr('status');
  is $attr,          'ok',     'Root node has the correct value for its status attribute';

  my $u-node = $root.find('user');
  ok $u-node,                  'User node exists';

  my $id = $u-node.find('id');
  ok $id,                      'ID node exists within the User node';

  is $id.content,    '17037',  'ID node content is correct';

  my $nnode = $u-node.find('name');
  ok $nnode,                   'Name node exists within User';

  is $nnode.content, USERNAME, 'Name node content is correct';
}
