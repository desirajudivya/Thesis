 
use Benchmark;

$length=10;
for($g=5;$g<=100;$g=$g+5)
{
for($h=0;$h<1000;$h=$h+1)
{
$start=Time::HiRes::gettimeofday();
open(FILE,"<","inp/in_$g.$h.txt");
open(outfile,">>","outl/in_$g.$h.txt");


while(<FILE>)
{
chomp;
push(@arr,$_);
}
close(FILE);
@array=splice(@arr,1,$g);
undef @arr;
$no_collisions=0;
$num_lane_changes=0;





foreach $line(@array)
{
@line=split(/\s+/,$line);


push(@a1,$line[0]);
push(@pos, $line[1]);
push(@vel,$line[2]);
push(@acc,$line[3]);
push(@jerk,$line[4]);
push(@dis,$line[5]);
push(@ttl,$line[7]);
push(@lani,$line[8]);
push(@lanf,$line[9]);
push(@theta,$line[6]);

if($line[8] != $line[9])
{
push(@a2,$line[0]);
}

@done=sort @ttl;


}
undef @array;
$size2= scalar @a2;
$size=scalar @a1;
$time_has=$ttl[$size-1];
#$i=4;
for($i=0;$i<$size;$i=$i+1)
{
if($lani[$i] !=$lanf[$i])
{
#print "i intial $i \n";
for($j=$i+1;$j<$size;$j=$j+1)
{
if($lani[$j] eq 2)
{
#print "$j is j\n";
if($acc[$j] !=0)
{
$q=4*$vel[$j]*$vel[$j];
$w=($pos[$j]-$length-$dis[$j]);
$d=8*$w*$acc[$j];
$r=sqrt($q+$d);
$t=((-2*$vel[$j])+$r);
$time_has=$t/(2*$acc[$j]);   
#print "time $a1[$i] has wrt $a1[$j] is : $time_has \n";
#last;
}
if($acc[$j] eq 0)
{
$w=($pos[$j]-$length-$dis[$j]);
$time_has=($w/$vel[$j]);
#print "time it has is $time_has \n";

}
last;
}


}
$x=$time_has-$ttl[$i];
if($i >=1)
{
for($k=$i-1; $k>=0; $k=$k-1)
{
if($lani[$k] eq 2)
{
$c=(1/cos($theta));
$a=1;
$c_square=$c*$c;
$b=sqrt($c_square-$a);
$s=3.14*$b;

if(($pos[$k]-$pos[$i]) >= ($dis[$k]+$s))
{
if($x >= 0)
{
push(@least,$x);
push(@vehicles, $a1[$i]);
#$num_lane_changes=$num_lane_changes+1;
#print "this lane \n";
#print "this lane change number is $num_lane_changes  \n";
last;
}
if($x < 0)
{
#print "cant change lane i-1 is 2  \n";
}

}
if(($pos[$k]-$pos[$i]) < ($dis[$k]+$s))
{
#print "cant change lane i-1 is 2-1  \n";
}

}

if($lani[$k] != 2)
{
if($x >= 0)
{
push(@least,$x);
push(@vehicles, $a1[$i]);
#$num_lane_changes=$num_lane_changes+1;
#print "this lane change number is $num_lane_changes  \n";
last;
}
#$num_lane_changes=$num_lane_changes+1;
if($x < 0)
{
#print "cant change lane i-1 is not 2 \n";
#print " i is $i \n";
#last;
}

}


}
}

if($i<1)
{
$x=$time_has-$ttl[$i];
if($x >= 0)
{
push(@least,$x);
push(@vehicles, $a1[$i]);
#$num_lane_changes=$num_lane_changes+1;
#print "this lane change number is $num_lane_changes  \n";
last;
}
if($x < 0)
{
#print "cant change no lane i-1 \n";
}
}
#$x=$time_has-$ttl[$i];
#last;
}
}
$y=$least[0];
$width=scalar @least;
#print "$width is width \n ";
#print "$least[0] \n ";
for($l=0;$l<$width;$l=$l+1)
{
if($least[$l] <= $y)
{
$y=$least[$l];
$a2=$a1[$l];
}

}
#print "least time is: $y \n";
#print "least time vehicle is: $a2 \n";


if($width>0)
{
$num_lane_changes=$num_lane_changes+1;
}



#print " total number of lane changes: $size2 \n";
#print("number of collisions are :$no_collisions \n ");
#print("number of lane changes: $num_lane_changes \n ");

#$t1 = Benchmark->new;
#$td = timediff($t1, $t0);
#print "the code took:",timestr($td),"\n";
undef @a1;
undef @pos;
undef @vel;
undef @acc;
undef @jerk;
undef @dis;
undef @ttl;
undef @lani;
undef @lanf;
undef @a2;
$end=Time::HiRes::gettimeofday();
#printf("%.5f \n",$end-$start);

print outfile "Number of vehicles \t number of collisions \t number of lane changes \t time overhead \n";
print outfile "$size2 \t $no_collisions \t $num_lane_changes \t";
printf outfile ("%.5f \n",$end-$start);
close(outfile);
}
}
























