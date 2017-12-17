use strict;
use warnings;

use XML::Simple;
use LWP::UserAgent;
use Data::Dumper;
use File::Spec;
use File::HomeDir;
use File::Path qw/make_path/;

my $other_program = "";
my $ua = LWP::UserAgent->new(agent => "Mozilla/5.0");

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
	list_music $music_array;
	$repeat = 1;
    }
    else {
	if ($choice =~ /^[0-9]+$/) {
	    $choice = int $choice;
	}
	else {
	    $choice = 0;
	}
	
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


sub download_file {
    my $file_name = shift;
    my $url = shift;

    die unless $file_name && $url;

    if (! -e $file_name) {
	print "Please wait while I download the file...\n";
	my $response = $ua->get($url);

	if ($response->is_success) {
	    open DOWNLOAD, ">$file_name";
	    binmode DOWNLOAD;
	    print DOWNLOAD $response->decoded_content;
	    close DOWNLOAD;
	}
	else {
	    die "Could not download song!!!";
	}
    }

    print "Ok\n";
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

    my $title = $music_array->[scalar(@$music_array) - $choice];
    my $title_name = $title->{title};
    $title_name =~ s/[\s\:]/_/g;
    my $dir_name = File::Spec->catfile(File::HomeDir->my_home,
				       "music4programming");
    my $title_name_mp3 = $title_name . ".mp3";
    my $file_name = File::Spec->catfile($dir_name,
					$title_name_mp3);


    # Make directory if not present
    if (! ((-e $dir_name) || (-d $dir_name))) {
	print "Creating directory $dir_name for storing downloaded music\n";
	eval {
	    make_path $dir_name;
	};
	if ($@) {
	    die "Could not create directory $dir_name!!\n";
	}
    }

    download_file $file_name, $title->{guid};
    
    my $command = "";
    my $message = "";
    
    if ($^O eq "darwin") {
	$command = "open";
    }
    elsif ($^O eq "MSWin32") {
	$command = "explorer";
    }
    else {
	my $other_program_needed = 1;
	
	if ($other_program) {
	    print "Playing with $other_program, yes? (yes/no): ";
	    my $ans = <STDIN>;
	    chomp $ans;

	    if ($ans !~ /yes/i) {
		$other_program_needed = 1;
	    }
	    else {
		$other_program_needed = 0;
	    }
	}
	
	if ($other_program_needed) {
	    print "Please type the command to open your music player (Enter if you are not sure): ";
	    $other_program = <STDIN>;
	    chomp $other_program;
	}

	if ($other_program) {
	    $command = $other_program;
	}
	else {
	    $message = "Please play $file_name with your music player!!";
	}
    }

    if (! $message) {
	eval {
	    system ("$command $file_name");
	};
	
	if ($@) {
	    print "Could not play the music, please play ", 
		$file_name,
		" yourself... :-X\n";
	    exit 0;
	}
    }
    else {
	print $message, "\n";
    }

    start_loop($music_array, 0);
}


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
