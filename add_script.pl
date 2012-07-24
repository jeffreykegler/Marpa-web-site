#!perl

use autodie;;
use English qw( -no_match_vars ) ;

sub usage {
   die "$PROGRAM_NAME: file_to_modify";
}
usage() if scalar @ARGV != 1;
my $filename = $ARGV[0];
usage() if not -w $filename;
open my $fh, q{<}, $filename;
my $contents = do { local $RS = undef; <>; };
close $fh;

if ($contents =~ m{ </script> \s* </body> \s* </html> \s* \z}xms)
{
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

open my $fh, q{>}, $filename;
print {$fh} $contents;
