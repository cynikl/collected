#!/usr/bin/perl

$transcript = "admin_ulabmin_0.7.3_2005.01.28.T";
$transcript_new = "/tmp/admin_ulabmin_0.7.3_2005.01.28_new.T";
$radmind_server = "radmind_master.yourschool.edu";

if ( $radmind_server eq "radmind_master.yourschool.edu" ) {
  print "EDIT this file and set your radmind server first!\n";
  exit 1;
}

chomp ($my_folder = `dirname \"$0\"` );
#chdir "$my_folder/../ulabmin/";
chdir "/";
print "Current directory: ";
print `pwd`;

if ( ! -e "$my_folder/$transcript" ) {
  print "Can't find \"$my_folder/$transcript\"\n";
  exit 1;
}

$transcript_contents = "";
@bla = `cat "$my_folder/$transcript"`;
foreach $bl ( @bla ) {
  @b = split ' ', $bl;
  $relative_path = decode_path ( $b[1] );
  if ( $b[0] eq "d" and ! -e $relative_path ) {
    print "sudo mkdir -m $b[2] \"$relative_path\"\n";
    system "sudo mkdir -m $b[2] \"$relative_path\"";
    print "sudo chown $b[3]:$b[4] \"$relative_path\"\n";
    system "sudo chown $b[3]:$b[4] \"$relative_path\"";
  }
  $fsdiff_output = `sudo /usr/local/bin/fsdiff -c sha1 -1 \"$relative_path\"`;
  print "$fsdiff_output";
  $transcript_contents .= $fsdiff_output;
  
}

open ( FILEHANDLE, "> $transcript_new" ) or die "Could not open $transcript_new\n";
print FILEHANDLE $transcript_contents;
close ( FILEHANDLE );

print "sudo /usr/local/bin/lcreate -c sha1 -h $radmind_server $transcript_new\n";
system "sudo /usr/local/bin/lcreate -c sha1 -h $radmind_server $transcript_new";

sub decode_path {
  my ( $path ) = @_;
  $path =~ s/\\b/ /g;;
#  my $path =~ s/\\t/\t/g;; # convert tabs
#  my $path =~ s/\\n/\n/g;; # convert newline
#  my $path =~ s/\\r/\r/g;; # convert return
#  my $path =~ s/\\/\/g;; # convert backslashes
  return $path;
}
