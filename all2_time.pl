 use Benchmark;
#$t0 = Benchmark->new;

use List::Util qw(min max);
$lane_width=2;
$a=$lane_width/2;
$length=10;





#######################################################################################################################
for($g=5;$g<=100;$g=$g+5)
{
for($h=0;$h<1000;$h=$h+1)
{
$start=Time::HiRes::gettimeofday();
open(FILE,"<","inp/in_$g.$h.txt");
open(outfile,">>","out/in_$g.$h.txt");
print "g is $g \n";
print "h is $h \n";

while(<FILE>)
{
chomp;
push(@arr,$_);
}
close(FILE);


@array=splice(@arr,1,$g);
#print "this is array $r.$s \n";
undef @arr;

$num_lane_changes=0;
$no_collisions=0;

########################################################################################################################
foreach $line(@array)
{
@line=split(/\s+/,$line);
#@final_array= \@line;


#print (" line is $line[0] \n");
push(@a1,$line[0]);
push(@pos, $line[1]);
push(@vel,$line[2]);
push(@acc,$line[3]);
push(@jerk,$line[4]);
push(@dis,$line[5]);
push(@ttl,$line[7]);
push(@lani,$line[8]);
push(@lanf,$line[9]);                    
$theta=$line[6];
#print ("$pos[3] \n");

#push(@vehicleid,$line[0]);

if($line[8] != $line[9])
{
push(@a2,$line[0]);
}
}
undef @array;

$size2=scalar @a2;
$size=scalar @pos;

#print "$line[8] is the number of vehicles in lani \n";
#print("num of vehicles is $size2  \n ");
#print "$a1[5] \n ";
#for($i=0;$i<$size;$i=$i+1)
#{
#$i=0;

for($i=0; $i<$size; $i=$i+1)
{
if($lani[$i] != $lanf[$i])
{
if($lani[$i+1] !=2 and $lani[$i-1] eq 2 )
{
$c=(1/cos($theta));
$a=1;
$c_square=$c*$c;
$b=sqrt($c_square-$a);
$s=3.14*$b;
if(($pos[$i-1]-$pos[$i]) < ($dis[$i-1]+$s))
{
$no_collisions=$no_collisions+1;
}
if(($pos[$i-1]-$pos[$i]) >= ($dis[$i-1]+$s))
{
#$num_lane_changes=$num_lane_changes+1;
}
for($j=$i+2; $j<$width; $j=$j+1)
{
if($lani[$j]==2)
{
if($acc[$j] !=0)
{
$q=4*$vel[$j]*$vel[$j];
$w=($pos[$j]-$length-$dis[$j]);
$d=8*$w*$acc[$j];
$r=sqrt($q+$d);
$t=((-2*$vel[$j])+$r);
$time_has=$t/(2*$acc[$j]);   
}
if($acc[$j] eq 0)
{
$w=($pos[$j]-$length-$dis[$j]);
$time_has=($w/$vel[$j]);
}
if($time_has< $ttl[$i])
{
$no_collisions=$no_collisions+1;
#print "is it coming in this loop "; 
}
if($time_has>= $ttl[$i])
{
if(($pos[$i-1]-$pos[$i]) >= ($dis[$i-1]+$s))
{
$num_lane_changes=$num_lane_changes+1;
}
#print "is it coming in this loop "; 
}
last;
}

}

}


###########################################################################


if($lani[$i+1] eq 2 and $lani[$i-1] != 2 )
{
if($acc[$i+1] !=0)
{
$q=4*$vel[$i+1]*$vel[$i+1];
$w=($pos[$i+1]-$length-$dis[$i+1]);
$d=8*$w*$acc[$i+1];
$r=sqrt($q+$d);
$t=((-2*$vel[$i+1])+$r);
$time_has=$t/(2*$acc[$i+1]);   
}
if($acc[$i+1] eq 0)
{
$w=($pos[$i+1]-$length-$dis[$i+1]);
$time_has=($w/$vel[$i+1]);
}
if($time_has< $ttl[$i])
{
$no_collisions=$no_collisions+1;
#print "is it coming in this loop "; 
}
if($time_has>= $ttl[$i])
{
#$num_lane_changes=$num_lane_changes+1;
#print "is it coming in this loop "; 
}

if($i>=2)
{
for($j=$i-2; $j!=0; $j=$j-1)
{
if($lani[$j]==2)
{
$c=(1/cos($theta));
$a=1;
$c_square=$c*$c;
$b=sqrt($c_square-$a);
$s=3.14*$b;
if(($pos[$j]-$pos[$i]) < ($dis[$j]+$s))
{
$no_collisions=$no_collisions+1;
}
if(($pos[$j]-$pos[$i]) >= ($dis[$j]+$s))
{
if($time_has>= $ttl[$i])
{
$num_lane_changes=$num_lane_changes+1;
}
}
last;
}
}
}

}


#############################################################################

if($lani[$i+1] eq 2 and $lani[$i-1] eq 2 )
{
if($acc[$i+1] !=0)
{
$q=4*$vel[$i+1]*$vel[$i+1];
$w=($pos[$i+1]-$length-$dis[$i+1]);
$d=8*$w*$acc[$i+1];
$r=sqrt($q+$d);
$t=((-2*$vel[$i+1])+$r);
$time_has=$t/(2*$acc[$i+1]);
}
if($acc[$i+1] eq 0)
{
$w=($pos[$i+1]-$length-$dis[$i+1]);
$time_has=($w/$vel[$i+1]);
}
$c=(1/cos($theta));
$a=1;
$c_square=$c*$c;
$b=sqrt($c_square-$a);
$s=3.14*$b;

if($time_has< $ttl[$i] and ($pos[$i-1]-$pos[$i]) < ($dis[$i-1]+$s))
{
$no_collisions=$no_collisions+1;
#print "is it coming in this loop "; 
}
if($time_has>= $ttl[$i] and ($pos[$i-1]-$pos[$i]) >= ($dis[$i-1]+$s))
{
$num_lane_changes=$num_lane_changes+1;
#print "is it coming in this loop "; 
}

if($time_has< $ttl[$i] and ($pos[$i-1]-$pos[$i]) >= ($dis[$i-1]+$s))
{
$no_collisions=$no_collisions+1;
#print "is it coming in this loop "; 
}
if($time_has>= $ttl[$i] and ($pos[$i-1]-$pos[$i]) < ($dis[$i-1]+$s))
{
$no_collisions=$no_collisions+1;
#print "is it coming in this loop "; 
}

}





######################################################################
if($lani[$i+1] != 2 and $lani[$i-1] !=2 )
{
if($lani[$i+1] != $lanf[$i+1])
{
$d=$dis[$i]+(($vel[$i+1]*($ttl[$i]-$ttl[$i+1]))+(0.5*$acc[$i+1]*($ttl[$i]-$ttl[$i+1])*($ttl[$i]-$ttl[$i+1]))+((1/6)*$jerk[$i+1]*($ttl[$i]-$ttl[$i+1])*($ttl[$i]-$ttl[$i+1])*($ttl[$i]-$ttl[$i+1])));
#print "$d \n";
#print "$pos[$j-1] \n";
#print "$pos[$i] \n";
if($pos[$i]-$length-$pos[$i+1] < $d)
{


$no_collisions=$no_collisions+1;
#print "u are in collisions loop \n ";



}
elsif(($pos[$i]-$length-$pos[$i+1]) >= $d)
{
$num_lane_changes=$num_lane_changes+1;
#print " u are in lane changes loop \n ";
}

}
if($lani[$i+1] eq $lanf[$i+1])
{

for($k=$i+2; $k<$width; $k=$j+1)
{
if($lani[$k]==2)
{
if($acc[$k] !=0)
{
$q=4*$vel[$k]*$vel[$k];
$w=($pos[$k]-$length-$dis[$k]);
$d=8*$w*$acc[$k];
$r=sqrt($q+$d);
$t=((-2*$vel[$k])+$r);
$time_has=$t/(2*$acc[$k]);   
}
if($acc[$k] eq 0)
{
$time_has=($w/$vel[$k]);
}
if($time_has< $ttl[$i])
{
$w=($pos[$k]-$length-$dis[$k]);
$no_collisions=$no_collisions+1;
#print "is it coming in this loop "; 
}
if($time_has>= $ttl[$i])
{
#$num_lane_changes=$num_lane_changes+1;
#print "is it coming in this loop "; 
}
last;
}
}



if($i>=2)
{
for($j=$i-2; $j!=0; $j=$j-1)
{
if($lani[$j]==2)
{
$c=(1/cos($theta));
$a=1;
$c_square=$c*$c;
$b=sqrt($c_square-$a);
$s=3.14*$b;
if(($pos[$j]-$pos[$i]) < ($dis[$j]+$s))
{
$no_collisions=$no_collisions+1;
}
if(($pos[$j]-$pos[$i]) >= ($dis[$j]+$s))
{
if($time_has>= $ttl[$i])
{
$num_lane_changes=$num_lane_changes+1;
}
}
last;
}
}
}

}
}
}
}

#print " total number of lane changes: $size2 \n";
#print "no of collisions are : $no_collisions \n ";
#print " no of lane changes are: $num_lane_changes \n";
 
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
print outfile "Number of vehicles \t number of collisions \t number of lane changes \t time overhead \n";
print outfile "$size2 \t $no_collisions \t $num_lane_changes \t";
printf outfile ("%.5f \n",$end-$start);
close(outfile);
}
}




