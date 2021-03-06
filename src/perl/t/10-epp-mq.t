use strict;
use warnings;
use DateTime;
use Test::More tests => 12;
use Test::Exception;

use_ok('wtsi_clarity::mq::message::epp');
use_ok('wtsi_clarity::epp::generic::messenger');

{
  my $m;
  lives_ok {$m = wtsi_clarity::epp::generic::messenger->new(
       process_url => 'http://some.com/process/XM4567',
       step_url    => 'http://some.com/step/AS456')}
    'object created with step_url and process_url sttributes';
  isa_ok( $m, 'wtsi_clarity::epp::generic::messenger');
  ok(!$m->step_start, 'step_start defaults to false');
  is(ref $m->_date, 'DateTime', 'default datetime object created');
}

{
  my $date = DateTime->now();
  my $m =  wtsi_clarity::epp::generic::messenger->new(
       process_url => 'http://some.com/process/XM4567',
       step_url    => 'http://some.com/step/AS456',
       _date       => $date,
  );
  my $message;
  lives_ok {$message = $m->_message } 'message generated';
  isa_ok( $message, 'wtsi_clarity::mq::message::epp',
    'message generated as wtsi_clarity::mq::message::epp type object');
  ok(!(ref $message->timestamp), 'timestamp coerced');
  my $json;
  lives_ok { $json = $message->freeze } 'can serialize message object';
  my $date_as_string = $date->strftime("%a %b %d %Y %T");
  like($json, qr/$date_as_string/, 'date serialized correctly');
  lives_ok { wtsi_clarity::mq::message::epp->thaw($json) }
    'can read json string back';
}

1;
