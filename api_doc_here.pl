#!perl

use 5.010;
use strict;
use warnings;
use autodie;;
use English qw( -no_match_vars ) ;
use File::Find;
use File::Spec;

sub usage {
   die "$PROGRAM_NAME: from";
}
usage() if scalar @ARGV != 1;
my $from_name = $ARGV[0];
if (not -d $from_name) {
    die qq{"$from_name" is not a file or a directory} if not -f $from_name;
    copy_one_here( $from_name );
    exit 0;
}

sub wanted {
    my $full_name = $File::Find::name;
    return if not -f $_;
    return if not $_ =~ m/[.]html\z/xms;
    copy_one_here( $full_name );
}

File::Find::find( { no_chdir => 1, wanted => \&wanted }, $from_name );

sub copy_one_here {
    my ($filename) = @_;
    open my $fh, q{<}, $filename;
    my $contents = do { local $RS = undef; <$fh>; };
    close $fh;

    if ( $contents =~ m{ </script> \s* </body> \s* </html> \s* \z}xms ) {
        die "$filename already ends with a </script>";
    }

    $contents =~ s{ \s* </body> \s* </html> \s* \z}{
    <script src="javascripts/scale.fix.js"></script>
              <script type="text/javascript">
            var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
            document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
          </script>
          <script type="text/javascript">
            try {
              var pageTracker = _gat._getTracker("UA-33430331-1");
            pageTracker._trackPageview();
            } catch(err) {}
          </script>
  </body>
</html>
}xms;

    my ( undef, undef, $out_file ) = File::Spec->splitpath($filename);
    open $fh, q{>}, $out_file;
    print {$fh} $contents;
} ## end sub copy_one_here
