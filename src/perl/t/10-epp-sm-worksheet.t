use strict;
use warnings;
use Test::More tests => 82;
use Test::Exception;
use DateTime;
use XML::LibXML;
use Carp;
use lib qw ( t );
use util::xml;
use Data::Dumper;

use_ok('wtsi_clarity::epp::sm::worksheet', 'can use wtsi_clarity::epp::sm::worksheet' );
use_ok('util::xml', 'can use wtsi_clarity::t::util::xml' );

my $TEST_DATA = {
  'container_uri' => {
    'container_details' =>{
                'D:5' => {
                         'input_location' => 'C:4',
                         'sample_volume' => '1.2',
                         'buffer_volume' => '8.8',
                         'input_id' => '27-27'
                       },
                'E:4' => {
                         'input_location' => 'A:3',
                         'sample_volume' => '1.2',
                         'buffer_volume' => '8.8',
                         'input_id' => '27-27'
                       },
                'C:2' => {
                         'input_location' => 'A:6',
                         'sample_volume' => '1.2',
                         'buffer_volume' => '8.8',
                         'input_id' => '27-23'
                       },
                'B:2' => {
                         'input_location' => 'B:5',
                         'sample_volume' => '1.2',
                         'buffer_volume' => '8.8',
                         'input_id' => '27-23'
                       },
                'C:4' => {
                         'input_location' => 'D:2',
                         'sample_volume' => '1.2',
                         'buffer_volume' => '8.8',
                         'input_id' => '27-27'
                       },
                'B:6' => {
                         'input_location' => 'D:5',
                         'sample_volume' => '1.2',
                         'buffer_volume' => '8.8',
                         'input_id' => '27-27'
                       },
                'A:2' => {
                         'input_location' => 'A:5',
                         'sample_volume' => '1.2',
                         'buffer_volume' => '8.8',
                         'input_id' => '27-23'
                       },
                'B:4' => {
                         'input_location' => 'C:2',
                         'sample_volume' => '1.2',
                         'buffer_volume' => '8.8',
                         'input_id' => '27-27'
                       },
                'A:3' => {
                         'input_location' => 'A:11',
                         'sample_volume' => '1.2',
                         'buffer_volume' => '8.8',
                         'input_id' => '27-23'
                       },
                'C:6' => {
                         'input_location' => 'E:5',
                         'sample_volume' => '1.2',
                         'buffer_volume' => '8.8',
                         'input_id' => '27-27'
                       },
                'B:1' => {
                         'input_location' => 'B:1',
                         'sample_volume' => '1.2',
                         'buffer_volume' => '8.8',
                         'input_id' => '27-23'
                       },
                'A:4' => {
                         'input_location' => 'B:2',
                         'sample_volume' => '1.2',
                         'buffer_volume' => '8.8',
                         'input_id' => '27-27'
                       },
                'B:3' => {
                         'input_location' => 'A:12',
                         'sample_volume' => '1.2',
                         'buffer_volume' => '8.8',
                         'input_id' => '27-23'
                       },
                'E:5' => {
                         'input_location' => 'D:4',
                         'sample_volume' => '1.2',
                         'buffer_volume' => '8.8',
                         'input_id' => '27-27'
                       },
                'C:1' => {
                         'input_location' => 'A:2',
                         'sample_volume' => '1.2',
                         'buffer_volume' => '8.8',
                         'input_id' => '27-23'
                       },
                'E:6' => {
                         'input_location' => 'B:6',
                         'sample_volume' => '1.2',
                         'buffer_volume' => '8.8',
                         'input_id' => '27-27'
                       },
                'B:5' => {
                         'input_location' => 'A:4',
                         'sample_volume' => '1.2',
                         'buffer_volume' => '8.8',
                         'input_id' => '27-27'
                       },
                'D:2' => {
                         'input_location' => 'B:6',
                         'sample_volume' => '1.2',
                         'buffer_volume' => '8.8',
                         'input_id' => '27-23'
                       },
                'A:5' => {
                         'input_location' => 'E:3',
                         'sample_volume' => '1.2',
                         'buffer_volume' => '8.8',
                         'input_id' => '27-27'
                       },
                'E:2' => {
                         'input_location' => 'D:12',
                         'sample_volume' => '1.2',
                         'buffer_volume' => '8.8',
                         'input_id' => '27-27'
                       },
                'E:3' => {
                         'input_location' => 'C:1',
                         'sample_volume' => '1.2',
                         'buffer_volume' => '8.8',
                         'input_id' => '27-27'
                       },
                'A:1' => {
                         'input_location' => 'A:1',
                         'sample_volume' => '1.2',
                         'buffer_volume' => '8.8',
                         'input_id' => '27-23'
                       },
                'A:6' => {
                         'input_location' => 'C:5',
                         'sample_volume' => '1.2',
                         'buffer_volume' => '8.8',
                         'input_id' => '27-27'
                       },
                'E:1' => {
                         'input_location' => 'A:3',
                         'sample_volume' => '1.2',
                         'buffer_volume' => '8.8',
                         'input_id' => '27-23'
                       },
                'D:1' => {
                         'input_location' => 'B:2',
                         'sample_volume' => '1.2',
                         'buffer_volume' => '8.8',
                         'input_id' => '27-23'
                       },
                'C:3' => {
                         'input_location' => 'A:1',
                         'sample_volume' => '1.2',
                         'buffer_volume' => '8.8',
                         'input_id' => '27-27'
                       },
                'D:6' => {
                         'input_location' => 'A:6',
                         'sample_volume' => '1.2',
                         'buffer_volume' => '8.8',
                         'input_id' => '27-27'
                       },
                'C:5' => {
                         'input_location' => 'B:4',
                         'sample_volume' => '1.2',
                         'buffer_volume' => '8.8',
                         'input_id' => '27-27'
                       },
                'D:4' => {
                         'input_location' => 'E:2',
                         'sample_volume' => '1.2',
                         'buffer_volume' => '8.8',
                         'input_id' => '27-27'
                       },
                'D:3' => {
                         'input_location' => 'B:1',
                         'sample_volume' => '1.2',
                         'buffer_volume' => '8.8',
                         'input_id' => '27-27'
                       }
    },
  },
};

my $TEST_DATA2 = {
  'container_uri' => {
    'container_details' =>{
      'A:1' => {
        'input_location' => 'C:4',
        'sample_volume' => '1.2',
        'buffer_volume' => '8.8',
        'input_id' => '27'
      },
    },
  },
};

my $TEST_DATA3 = {
  'container_uri' => {
    'container_details' =>{
      'A:1' => {
             'input_location' => 'C:4',
             'sample_volume' => '1.2',
             'buffer_volume' => '8.8',
             'input_id' => '27'
           },
      'A:2' => {
             'input_location' => 'A:6',
             'sample_volume' => '1.2',
             'buffer_volume' => '8.8',
             'input_id' => '23'
           },
      'A:3' => {
             'input_location' => 'A:8',
             'sample_volume' => '1.2',
             'buffer_volume' => '8.8',
             'input_id' => '27'
           },
      'A:4' => {
             'input_location' => 'Z:8',
             'sample_volume' => '1.2',
             'buffer_volume' => '8.8',
             'input_id' => '25'
            },
      'B:1' => {
             'input_location' => 'A:3',
             'sample_volume' => '1.2',
             'buffer_volume' => '8.8',
             'input_id' => '27'
           },
      'B:2' => {
             'input_location' => 'B:5',
             'sample_volume' => '1.2',
             'buffer_volume' => '8.8',
             'input_id' => '23'
           },
      'B:3' => {
             'input_location' => 'C:5',
             'sample_volume' => '1.2',
             'buffer_volume' => '8.8',
             'input_id' => '23'
           },
      'B:4' => {
             'input_location' => 'W:5',
             'sample_volume' => '1.2',
             'buffer_volume' => '8.8',
             'input_id' => '23'
           },
      'B:5' => {
             'input_location' => 'W:5',
             'sample_volume' => '1.2',
             'buffer_volume' => '8.8',
             'input_id' => '23'
           },
    },
    'output_container_info' => {
      'container_uri' => { 'purpose' => 'PLATE_PURPOSE_out', 'plate_name' => 'PLATE_NAME', 'barcode' => '1234567890123456', 'wells' => 96, },
    },
    'input_container_info' => {
      '27' => { 'purpose' => 'PLATE_PURPOSE_27', 'plate_name' => 'PLATE_NAME', 'barcode' => '1234567890123456', 'wells' => 96, },
      '25' => { 'purpose' => 'PLATE_PURPOSE_25', 'plate_name' => 'PLATE_NAME', 'barcode' => '1234567890123456', 'wells' => 96, },
      '23' => { 'purpose' => 'PLATE_PURPOSE_23', 'plate_name' => 'PLATE_NAME', 'barcode' => '1234567890123456', 'wells' => 96, },
    },
    'process_id' => 'PROCESS_ID',
  },
};



{ # testing get_location
  local $ENV{'WTSICLARITY_WEBCACHE_DIR'} = 't/data/sm/worksheet';
  # local $ENV{'SAVE2WTSICLARITY_WEBCACHE'} = 1;
  my $step = wtsi_clarity::epp::sm::worksheet->new(
    process_url => 'http://clarity-ap:8080/api/v2/processes/24-102407');


  my @test_data = (
    { 'in' => [ 0, 0,10,10], 'out' => undef, },
    { 'in' => [ 0,11,10,10], 'out' => undef, },
    { 'in' => [11, 0,10,10], 'out' => undef, },
    { 'in' => [11,11,10,10], 'out' => undef, },
    { 'in' => [ 0, 1,10,10], 'out' => undef, },
    { 'in' => [ 0, 2,10,10], 'out' => undef, },
    { 'in' => [ 0,10,10,10], 'out' => undef, },
    { 'in' => [ 1, 0,10,10], 'out' => undef, },
    { 'in' => [ 2, 0,10,10], 'out' => undef, },
    { 'in' => [10, 0,10,10], 'out' => undef, },
    { 'in' => [ 1, 1,10,10], 'out' => "A:1", },
    { 'in' => [ 2, 2,10,10], 'out' => "B:2", },
    { 'in' => [ 3, 5,10,10], 'out' => "E:3", },
    { 'in' => [10,10,10,10], 'out' => "J:10", },
  );
  foreach my $datum (@test_data) {
    my ($i,$j, $c, $r) = @{$datum->{'in'}};
    my $expected = $datum->{'out'};
    # my $expected = %{$datum}->{'out'};
    my $val = wtsi_clarity::epp::sm::worksheet::get_location($i,$j, $c, $r);

    if (defined $expected){
      cmp_ok($val, 'eq', $expected, "get_location($i, $j,...) should give $expected.");
    } else {
      is($val, undef, "get_location($i, $j,...) should not give anything.");
    }
    
  }
}

{ # get_legend_content
  local $ENV{'WTSICLARITY_WEBCACHE_DIR'} = 't/data/sm/worksheet';
  # local $ENV{'SAVE2WTSICLARITY_WEBCACHE'} = 1;
  my $step = wtsi_clarity::epp::sm::worksheet->new(
    process_url => 'http://clarity-ap:8080/api/v2/processes/24-102407');


  my @test_data = (
    { 'in' => [ 0, 0,10,10], 'out' => "", },
    { 'in' => [ 0,11,10,10], 'out' => "", },
    { 'in' => [11, 0,10,10], 'out' => "", },
    { 'in' => [11,11,10,10], 'out' => "", },
    { 'in' => [ 0, 1,10,10], 'out' => ".\nA\n.", },
    { 'in' => [ 0, 2,10,10], 'out' => ".\nB\n.", },
    { 'in' => [ 0,10,10,10], 'out' => ".\nJ\n.", },
    { 'in' => [ 1, 0,10,10], 'out' => "1", },
    { 'in' => [ 2, 0,10,10], 'out' => "2", },
    { 'in' => [10, 0,10,10], 'out' => "10", },
    { 'in' => [ 1, 1,10,10], 'out' => undef, },
    { 'in' => [10,10,10,10], 'out' => undef, },
  );
  foreach my $datum (@test_data) {
    my ($i,$j, $c, $r) = @{$datum->{'in'}};
    my $expected = $datum->{'out'};
    my $val = wtsi_clarity::epp::sm::worksheet::get_legend_content($i,$j, $c, $r);

    if (defined $expected){
      cmp_ok($val, 'eq', $expected, "get_legend_content($i, $j,...) should give the correct value.");
    } else {
      is($val, undef, "get_legend_content($i, $j,...) should not give anything.");
    }

  }
}

{ # get_table_data
  local $ENV{'WTSICLARITY_WEBCACHE_DIR'} = 't/data/sm/worksheet';
  # local $ENV{'SAVE2WTSICLARITY_WEBCACHE'} = 1;
  my $step = wtsi_clarity::epp::sm::worksheet->new(
    process_url => 'http://clarity-ap:8080/api/v2/processes/24-102407');

  my @expected_data = (
    { 'in' => [0,0],  'out' => "", },
    { 'in' => [1,1],  'out' => "A:1\n2723\nv1 b8", },
    { 'in' => [0,1],  'out' => ".\nA\n.", },
    { 'in' => [0,2],  'out' => ".\nB\n.", },
    { 'in' => [6,2],  'out' => ".\nB\n.", },
    { 'in' => [1,0],  'out' => "1", },
    { 'in' => [3,0],  'out' => "3", },
  );
  my ($table, $prop) = wtsi_clarity::epp::sm::worksheet::get_table_data($TEST_DATA->{'container_uri'}->{'container_details'}, 5,6);

  cmp_ok(scalar @{$table}, '==', 6+2 , "get_table_data should return an array of the correct size (nb of rows).");
  cmp_ok(scalar @{@{$table}[0]}, '==', 5+2 , "get_table_data should return an array of the correct size (nb of cols).");

  foreach my $datum (@expected_data) {
    my ($i,$j) = @{$datum->{'in'}};
    my $expected = $datum->{'out'};
    my $val = $table->[$j][$i];
    cmp_ok($val, 'eq', $expected, "get_table_data(...,$i, $j) should give the correct format.");
  }
}

{ # get_containers_data
  local $ENV{'WTSICLARITY_WEBCACHE_DIR'} = 't/data/sm/worksheet';
  my $step = wtsi_clarity::epp::sm::worksheet->new(
    process_url => 'http://clarity-ap:8080/api/v2/processes/24-102407');

  my $data = $step->get_containers_data();
  my $container_uri = q{http://clarity-ap.internal.sanger.ac.uk:8080/api/v2/containers/27-8129};
  my $cont = $data->{'container_details'}->{$container_uri};

  my @expected_data = (
    { 'param' => 'D:1',  
    'exp_location' => "B:2",
    'exp_sample_volume' => "1.2",
    'exp_buffer_volume' => "8.8",
    'exp_id' => "27-23",
    },
    { 'param' => 'D:3',  
    'exp_location' => "B:1",
    'exp_sample_volume' => "1.2",
    'exp_buffer_volume' => "8.8",
    'exp_id' => "27-27",
    },
  );

  foreach my $datum (@expected_data) {
    my $out = $datum->{'param'};
    my $exp_loc = $datum->{'exp_location'};
    my $exp_smp = $datum->{'exp_sample_volume'};
    my $exp_buf = $datum->{'exp_buffer_volume'};
    my $exp_id  = $datum->{'exp_id'};
    my $in_loc  = $cont->{$out}->{'input_location'};
    my $in_smp  = $cont->{$out}->{'sample_volume'};
    my $in_buf  = $cont->{$out}->{'buffer_volume'};
    my $in_id   = $cont->{$out}->{'input_id'};

    cmp_ok($in_loc, 'eq', $exp_loc, "get_containers_data(...) should give the correct relation $out <-> $exp_loc (found $in_loc). ");
    cmp_ok($in_smp, 'eq', $exp_smp, "get_containers_data(...) should give the sample volume. ");
    cmp_ok($in_buf, 'eq', $exp_buf, "get_containers_data(...) should give the buffer volume. ");
    cmp_ok($in_id, 'eq', $exp_id, "get_containers_data(...) should give the container id. ");
  }
}



{ # get_cell_properties
  local $ENV{'WTSICLARITY_WEBCACHE_DIR'} = 't/data/sm/worksheet';
  # local $ENV{'SAVE2WTSICLARITY_WEBCACHE'} = 1;
  my $step = wtsi_clarity::epp::sm::worksheet->new(
    process_url => 'http://clarity-ap:8080/api/v2/processes/24-102407');

  my @expected_data = (
    { 'pos' => "A:1",  'background_color' => "red", 'font_size' => '7' },
    { 'pos' => "A:2",  'background_color' => "green", 'font_size' => '7' },
    { 'pos' => "A:3",  'background_color' => "red", 'font_size' => '7' },
    { 'pos' => "A:4",  'background_color' => "blue", 'font_size' => '7' },
    { 'pos' => "A:5",  'background_color' => "white", 'font_size' => '7' },
    { 'pos' => "B:1",  'background_color' => "red", 'font_size' => '7' },
    { 'pos' => "B:2",  'background_color' => "green", 'font_size' => '7' },
    { 'pos' => "B:3",  'background_color' => "green", 'font_size' => '7' },
    { 'pos' => "B:4",  'background_color' => "green", 'font_size' => '7' },
    { 'pos' => "B:5",  'background_color' => "green", 'font_size' => '7' },
  );

  my $colour_data = {'27' => 'red', '23' => 'green', '25' => 'blue'} ;

  foreach my $datum (@expected_data) {
    my $pos = $datum->{'pos'};

    my $prop = wtsi_clarity::epp::sm::worksheet::get_cell_properties($TEST_DATA3->{'container_uri'}->{'container_details'}, $colour_data, $pos);

    my $exp_bg = $datum->{'background_color'};
    my $exp_fs = $datum->{'font_size'};
    my $bg = $prop->{'background_color'};
    my $fs = $prop->{'font_size'};
    cmp_ok($bg, 'eq', $exp_bg, "get_cell_properties(...,$pos) {background_color} should give $exp_bg.");
    cmp_ok($fs, 'eq', $exp_fs, "get_cell_properties(...,$pos) {font_size} should give $exp_fs.");
  }
}

{ # get_colour_data
  local $ENV{'WTSICLARITY_WEBCACHE_DIR'} = 't/data/sm/worksheet';
  # local $ENV{'SAVE2WTSICLARITY_WEBCACHE'} = 1;
  my $step = wtsi_clarity::epp::sm::worksheet->new(
    process_url => 'http://clarity-ap:8080/api/v2/processes/24-102407');

  my %expected_data = (
     '27' => "red" ,
     '23' => "green" ,
     '25' => "blue" ,
  );
  my @list_of_colours = ('red', 'green', 'blue', 'yellow', 'orange');

  my $cols = wtsi_clarity::epp::sm::worksheet::get_colour_data($TEST_DATA3->{'container_uri'}->{'container_details'}, @list_of_colours);

  while (my ($id, $exp_col) = each %expected_data ) {


    my $found = $cols->{$id};
    cmp_ok($found, 'eq', $exp_col, "get_colour_data(...) {$id} should give $exp_col.");
  }
}

{ # get_title
  local $ENV{'WTSICLARITY_WEBCACHE_DIR'} = 't/data/sm/worksheet';
  # local $ENV{'SAVE2WTSICLARITY_WEBCACHE'} = 1;
  my $step = wtsi_clarity::epp::sm::worksheet->new(
    process_url => 'http://clarity-ap:8080/api/v2/processes/24-102407');

  my $title = wtsi_clarity::epp::sm::worksheet::get_title($TEST_DATA3->{'container_uri'}, 'container_uri');


  my $exp_title = q{Process PROCESS_ID - PLATE_PURPOSE_out - Cherrypicking};
  # my $found = $cols->{$id};
  cmp_ok($title, 'eq', $exp_title, "get_title(...) should give $exp_title.");
}


{ # get_legend_properties
  local $ENV{'WTSICLARITY_WEBCACHE_DIR'} = 't/data/sm/worksheet';
  # local $ENV{'SAVE2WTSICLARITY_WEBCACHE'} = 1;
  my $step = wtsi_clarity::epp::sm::worksheet->new(
    process_url => 'http://clarity-ap:8080/api/v2/processes/24-102407');

  my @expected_data = (
    { 'pos' => [0,0],  'background_color' => "white", 'font_size' => '7' },
    { 'pos' => [2,2],  'background_color' => "white", 'font_size' => '7' },
    { 'pos' => [0,2],  'background_color' => "white", 'font_size' => '7' },
    { 'pos' => [2,0],  'background_color' => "white", 'font_size' => '7' },
    { 'pos' => [1,1],  'background_color' => "white", 'font_size' => '7' },
    { 'pos' => [1,0],  'background_color' => "white", 'font_size' => '7' },
    { 'pos' => [0 ,1],  'background_color' => "white", 'font_size' => '7' },
    # { 'in' => [1,1],  'out' => "abcd", },
    # { 'in' => [0,1],  'out' => "A", },
    # { 'in' => [0,2],  'out' => "B", },
    # { 'in' => [6,2],  'out' => "B", },
    # { 'in' => [1,0],  'out' => "1", },
    # { 'in' => [3,0],  'out' => "3", },
  );

  foreach my $datum (@expected_data) {
    my ($i,$j) = @{$datum->{'pos'}};

    my $prop = wtsi_clarity::epp::sm::worksheet::get_legend_properties($TEST_DATA, $i, $j, 1, 1);

    my $exp_bg = $datum->{'background_color'};
    my $exp_fs = $datum->{'font_size'};
    my $bg = $prop->{'background_color'};
    my $fs = $prop->{'font_size'};
    cmp_ok($bg, 'eq', $exp_bg, "get_legend_properties(..., $i, $j) {background_color} should give $exp_bg.");
    cmp_ok($fs, 'eq', $exp_fs, "get_legend_properties(..., $i, $j) {font_size} should give $exp_fs.");
  }
}



# {
#   local $ENV{'WTSICLARITY_WEBCACHE_DIR'} = 't/data/sm/cherrypick_volume';
#   # local $ENV{'SAVE2WTSICLARITY_WEBCACHE'} = 1;
#   my $step = wtsi_clarity::epp::sm::cherrypick_volume->new(
#     process_url => 'http://clarity-ap:8080/api/v2/processes/24-102066');
#
#   lives_ok { $step->fetch_and_update_targets($step->process_doc) } 'In case (1), the class managed to fetch and updates the artifact';
#
#   cmp_ok(scalar keys %{$step->_targets}, '==', 5, 'In case (1), there should be 5 artifacts (Test Fixture).');
#
#   my $SAMPLE_PATH = q(/art:artifact/udf:field[@name='Cherrypick Sample Volume']);
#   my $BUFFER_PATH = q(/art:artifact/udf:field[@name='Cherrypick Buffer Volume']);
#
#   my %expected_result = (
#     'http://clarity-ap.internal.sanger.ac.uk:8080/api/v2/artifacts/JON1301A251PA1?state=360076' => [5/45 , 10 - 5/45 ],
#     'http://clarity-ap.internal.sanger.ac.uk:8080/api/v2/artifacts/JON1301A252PA1?state=360082' => [5/3  , 10 - 5/3  ],
#     'http://clarity-ap.internal.sanger.ac.uk:8080/api/v2/artifacts/JON1301A253PA1?state=360058' => [5/9  , 10 - 5/9  ],
#     'http://clarity-ap.internal.sanger.ac.uk:8080/api/v2/artifacts/JON1301A254PA1?state=360086' => [5/35 , 10 - 5/35 ],
#     'http://clarity-ap.internal.sanger.ac.uk:8080/api/v2/artifacts/JON1301A255PA1?state=360078' => [2    , 10 - 2    ],
#   );
#
#   foreach my $sampleURI (keys %{$step->_targets})
#   {
#     my @element_samples = util::xml::find_elements( $step->_targets->{$sampleURI}, $SAMPLE_PATH) ;
#     my @element_buffers = util::xml::find_elements( $step->_targets->{$sampleURI}, $BUFFER_PATH) ;
#     cmp_ok(scalar @element_samples, '==', 1, 'In case (1), the sample volume should be present on the sample.');
#     cmp_ok(scalar @element_buffers, '==', 1, 'In case (1), the buffer volume should be present on the sample.');
#     my $element_sample = shift @element_samples;
#     my $element_buffer = shift @element_buffers;
#     cmp_ok($element_sample->textContent, 'eq', @{$expected_result{$sampleURI}}[0], 'In case (1), the sample volume should be as expected.');
#     cmp_ok($element_buffer->textContent, 'eq', @{$expected_result{$sampleURI}}[1], 'In case (1), the buffer volume should be as expected.');
#   }
# }
#



#
# {
#   local $ENV{'WTSICLARITY_WEBCACHE_DIR'} = 't/data/sm/cherrypick_volume';
#   # local $ENV{'SAVE2WTSICLARITY_WEBCACHE'} = 1;
#   my $step = wtsi_clarity::epp::sm::cherrypick_volume->new(
#     process_url => 'http://clarity-ap:8080/api/v2/processes/24-102067');
#
#   lives_ok { $step->fetch_and_update_targets($step->process_doc) } 'In case (2), the class managed to fetch and updates the artifact';
#
#   cmp_ok(scalar keys %{$step->_targets}, '==', 5, 'In case (2), there should be 5 artifacts (Test Fixture).');
#
#   my $SAMPLE_PATH = q(/art:artifact/udf:field[@name='Cherrypick Sample Volume']);
#   my $BUFFER_PATH = q(/art:artifact/udf:field[@name='Cherrypick Buffer Volume']);
#
#   my %expected_result = (
#     'http://clarity-ap.internal.sanger.ac.uk:8080/api/v2/artifacts/JON1301A251PA1?state=360076' => [ 25/450 ,  0.1 - 25/450 ],
#     'http://clarity-ap.internal.sanger.ac.uk:8080/api/v2/artifacts/JON1301A252PA1?state=360082' => [ 25/30  ,  0            ],
#     'http://clarity-ap.internal.sanger.ac.uk:8080/api/v2/artifacts/JON1301A253PA1?state=360058' => [ 25/90  ,  0            ],
#     'http://clarity-ap.internal.sanger.ac.uk:8080/api/v2/artifacts/JON1301A254PA1?state=360086' => [ 25/350 ,  0.1 - 25/350 ],
#     'http://clarity-ap.internal.sanger.ac.uk:8080/api/v2/artifacts/JON1301A255PA1?state=360078' => [ 1      ,  0            ],
#   );
#
#   foreach my $sampleURI (keys %{$step->_targets})
#   {
#     my @element_samples = util::xml::find_elements( $step->_targets->{$sampleURI}, $SAMPLE_PATH) ;
#     my @element_buffers = util::xml::find_elements( $step->_targets->{$sampleURI}, $BUFFER_PATH) ;
#     cmp_ok(scalar @element_samples, '==', 1, 'In case (2), the sample volume should be present on the sample.');
#     cmp_ok(scalar @element_buffers, '==', 1, 'In case (2), the buffer volume should be present on the sample.');
#     my $element_sample = shift @element_samples;
#     my $element_buffer = shift @element_buffers;
#     cmp_ok($element_sample->textContent, 'eq', @{$expected_result{$sampleURI}}[0], 'In case (2), the sample volume should be as expected.');
#     cmp_ok($element_buffer->textContent, 'eq', @{$expected_result{$sampleURI}}[1], 'In case (2), the buffer volume should be as expected.');
#   }
# }
#
#
#
#
#
#
#
# {
#   local $ENV{'WTSICLARITY_WEBCACHE_DIR'} = 't/data/sm/cherrypick_volume';
#   # local $ENV{'SAVE2WTSICLARITY_WEBCACHE'} = 1;
#   my $step = wtsi_clarity::epp::sm::cherrypick_volume->new(
#     process_url => 'http://clarity-ap:8080/api/v2/processes/24-102068');
#
#   lives_ok { $step->fetch_and_update_targets($step->process_doc) } 'In case (3), the class managed to fetch and updates the artifact';
#
#   cmp_ok(scalar keys %{$step->_targets}, '==', 5, 'In case (3), there should be 5 artifacts (Test Fixture).');
#
#   my $SAMPLE_PATH = q(/art:artifact/udf:field[@name='Cherrypick Sample Volume']);
#   my $BUFFER_PATH = q(/art:artifact/udf:field[@name='Cherrypick Buffer Volume']);
#
#   my %expected_result = (
#     'http://clarity-ap.internal.sanger.ac.uk:8080/api/v2/artifacts/JON1301A251PA1?state=360076' => [50,''],
#     'http://clarity-ap.internal.sanger.ac.uk:8080/api/v2/artifacts/JON1301A252PA1?state=360082' => [50,''],
#     'http://clarity-ap.internal.sanger.ac.uk:8080/api/v2/artifacts/JON1301A253PA1?state=360058' => [50,''],
#     'http://clarity-ap.internal.sanger.ac.uk:8080/api/v2/artifacts/JON1301A254PA1?state=360086' => [50,''],
#     'http://clarity-ap.internal.sanger.ac.uk:8080/api/v2/artifacts/JON1301A255PA1?state=360078' => [ 2,''],
#   );
#
#   foreach my $sampleURI (keys %{$step->_targets})
#   {
#     my @element_samples = util::xml::find_elements( $step->_targets->{$sampleURI}, $SAMPLE_PATH) ;
#     my @element_buffers = util::xml::find_elements( $step->_targets->{$sampleURI}, $BUFFER_PATH) ;
#     cmp_ok(scalar @element_samples, '==', 1, 'In case (3), the sample volume should be present on the sample.');
#     cmp_ok(scalar @element_buffers, '==', 1, 'In case (3), the buffer volume should be present on the sample.');
#     my $element_sample = shift @element_samples;
#     my $element_buffer = shift @element_buffers;
#     cmp_ok($element_sample->textContent, 'eq', @{$expected_result{$sampleURI}}[0], 'In case (3), the sample volume should be as expected.');
#     cmp_ok($element_buffer->textContent, 'eq', @{$expected_result{$sampleURI}}[1], 'In case (3), the buffer volume should be empty.');
#   }
# }
1;
