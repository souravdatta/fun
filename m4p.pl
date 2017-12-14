use strict;
use warnings;

use XML::Simple;
use LWP::UserAgent;
use Data::Dumper;


sub list_music {
    my $music_array = shift;
    my $i = 1;

    die unless $music_array;
    
    foreach my $m (reverse @$music_array) {
	    print "$i. $m->{title}\n";
	    $i++;
    }
}

sub choice_loop {
    my $choice;
    my $repeat = 0;
    my $music_array = shift;

    die unless $music_array;

    print "Select action (list to list again, quit/exit to exit, a numeric value for choice of music): ";
    $choice = <STDIN>;
    chomp $choice;

    if (! $choice) {
	    print "No choice given, try again!\n";
	    $repeat = 1;
    }
    elsif ($choice =~ /(quit)|(exit)/i) {
	    print "Exit program...\n";
	    exit 0;
    }
    elsif ($choice =~ /list/i) {
	    print "listing musics\n";
	    list_music $music_array;
	    $repeat = 1;
    }
    else {
	    $choice = int $choice;
	    if (($choice < 1) || ($choice > scalar(@$music_array))) {
	        print "Choice is not between 1 to ", scalar(@$music_array), "\n";
	        $repeat = 1;
	    }
	    else {
	        return $choice;
	    }
    }

    if ($repeat) {
	    choice_loop($music_array);
    }
}


sub start_loop {
    my $music_array = shift;
    my $show_list = shift;

    if (! defined($show_list)) {
	    $show_list = 1;
    }

    die unless $music_array;

    list_music $music_array if $show_list;
    
    my $choice = choice_loop $music_array;
    my $command = "";

    if ($^O eq "darwin") {
	    $command = "open";
    }
    elsif ($^O eq "MSWin32") {
	    $command = "explorer";
    }
    else {
	    $command = "xdg-open";
    }

    eval {
	    system ("$command " . $music_array->[scalar(@$music_array) - $choice]->{guid});
    };

    if ($@) {
	    print "Could not play the music, please download/play ", 
	        $music_array->[scalar(@$music_array) - $choice]->{guid},
	        " yourself... :-X\n";
	    exit 0;
    }

    start_loop($music_array, 0);
}


my $ua = LWP::UserAgent->new(agent => "Mozilla/5.0",
			                 timeout => 10);
my $response = $ua->get("https://musicforprogramming.net/rss.php");

if ($response->is_success) {
    my $content = $response->decoded_content;
    my $parser = XML::Simple->new;
    my $data = $parser->XMLin($content);

    start_loop reverse($data->{channel}->{item});
}
else {
    print $response->status_line, "\n";
}

