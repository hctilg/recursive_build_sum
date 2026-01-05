use strict;
use warnings;

sub find_sum {
  my ($a_ref, $used_ref, $value, $index, $sum) = @_;
  my @a = @$a_ref;
  my @used = @$used_ref;

  if ($index < 0) {
    # in the end of array we will print if we can build our sum in this way ^^
    if ($value == 0) {
      for (my $i = $#a; $i >= 0; $i--) {
        if ($used[$i]) print "$a[$i]+";  # this flag tells us that we used a[i] to build the sum in this way or no.
      }
      print "\b=";
      print "$sum\n";
    }
    return;
  }

  if ($value == $a[$index]) {
    # in two below lines we use current number to build our sum
    $used[$index] = 1;  # we let true in this flag because we use this number to build our sum
    find_sum($a_ref, \@used, 0, $index - 1, $sum);  # newValue is zero because oldValue-a[index]=0

    #  and in two below lines we will not use current number to build our sum . if we delete these two below lines we will not have all the ways.
    $used[$index] = 0;  # we let false in this flag because we use this number to build our sum
    find_sum($a_ref, \@used, $value, $index - 1, $sum);  # newValue=value because we don't use this number(a[index])
  } elsif ($value < $a[$index]) {
    # we can't use this number to build our sum because it's bigger than our value
    $used[$index] = 0;  # we let false in this flag because we use this number to build our sum
    find_sum($a_ref, \@used, $value, $index - 1, $sum);
  } elsif ($value > $a[$index]) {
    # in two below lines we use current number to build our sum
    $used[$index] = 1;  # we let true in this flag because we use this number to build our sum
    find_sum($a_ref, \@used, $value - $a[$index], $index - 1, $sum);  # newValue=oldValue-a[index]

    # and in two below lines we will not use current number to build our sum . if we delete these two below lines we will not have all the ways.
    $used[$index] = 0;  # we let false in this flag because we use this number to build our sum
    find_sum($a_ref, \@used, $value, $index - 1, $sum);
  }
}

# main
print "please type the size of array : ";
chomp(my $n = <STDIN>);  # define variable

my @arr = ();  # define input vector
my @used = ();  # define a vector for checking if this number contain our adding ?

print "type your array numbers: ";
chomp(my $line = <STDIN>);
my @numbers = split /\s+/, $line;

push @arr, @numbers;
@used = (0) x $n;

# get the sum . we will check if we can build this number with our given numbers 
print "please type your sum that we will try to build it with array numbers : ";
chomp(my $sum = <STDIN>);

@arr = sort { $a <=> $b } @arr;  # sort our vector . this line is important if we change it algorithm will not work.
find_sum(\@arr, \@used, $sum, $n - 1, $sum);  # call the recursive function to print all the ways we can build sum.