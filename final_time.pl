 use Benchmark;
#$t0 = Benchmark->new;



$lane_width=2;
$a=$lane_width/2;
$length=10;



for($v=5;$v<=100;$v=$v+5)
{
for($h=0;$h<1000;$h=$h+1)
{
$start=Time::HiRes::gettimeofday();
open(FILE,"<","inp/in_$v.$h.txt");
open(outfile,">>","outff/in_$v.$h.txt");

while(<FILE>)
{
chomp;
push(@arr,$_);
}
close(FILE);
@array=splice(@arr,1,$v);
$num_lane_changes=0;
$no_collisions=0;
undef @arr;

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


if($line[8] != $line[9])
{
push(@a2,$line[0]);
}
 
}
undef @array;
$size=scalar(@a1);
$size2=scalar(@a2);
#print("$size \n ");
#print "$a1[5] \n ";
#for($i=0;$i<$size;$i=$i+1)
#{
$j=1;


############  we see if there are any vehicles initially which are not changing lane. if they are any vehicles as such we put them in the group ##########################33


for($bb=0;$bb<$size;$bb=$bb+1)
{
if($lani[$bb] != $lanf[$bb])
{
$bb=$size;
last;
}
if($lani[$bb] eq $lanf[$bb])
{

push(@group1,$a1[$bb]);
$j=$j+1;
}

$g=scalar @group1;
}


######################  end of the code      ################################################


#################    if the vehicles are changing lane then we do this coding ############################
for($i=$j;$i<$size;$i=$i+1)
{




if($lani[$j-1] != $lanf[$j-1])
{



if($lani[$i] eq 2)
{

if($acc[$i] !=0)
{
$a=4*$vel[$i]*$vel[$i];
$c=($pos[$i]-$length-$dis[$i]);
$distance=8*$c*$acc[$i];
$s=sqrt($a+$distance);
$t=((-2*$vel[$i])+$s);
$time_has=$t/(2*$acc[$i]);
}
if($acc[$i] eq 0)
{
$time_has=($c/$vel[$i]);
}
if($time_has>=$ttl[$j-1])
{
push(@group1,$a1[$j-1],$a1[$i]);
$priority=$a1[$j-1];
$re=scalar(@group1);
$num_lane_changes=$num_lane_changes+1;
for($w=0;$w<$re; $w=$w+1)
{
#print("The second lane equal TWO vehicles are: $group1[$w] \n");
}
undef @group1;

$j=$i+2;
$i=$i+1;
}





if($time_has < $ttl[$j-1])
{

push(@group1,$a1[$j-1]);
$rA=scalar(@group1);
for($wZ=0;$wZ<$rA; $wZ=$wZ+1)
{
#print("The TTL LESS vehicles are: $group1[$wZ] \n");
}
 
push(@group1,$a1[$i]);


}

}




if($lani[$i] != 2)
{
if($lani[$i] eq $lanf[$i])
{

push(@group1, $a1[$j-1], $a1[$i]);
$rA=scalar(@group1);
for($wZ=0;$wZ<$rA; $wZ=$wZ+1)
{
#print("third one: $group1[$wZ] \n");
}
$priority=$a1[$j-1];
#print " u are in 3rd one \n ";

}


######## if the vehicle after $j-1 is not in the second lane and the vehicle is changing lane we see the distance between the two vehicles.. if the distance criterio satisfies we group them seperately. other wise we group them together. the process repeats ###################

if($lani[$i] != $lanf[$i])
{
$d=$dis[$j-1]+(($vel[$i]*($ttl[$j-1]-$ttl[$i]))+(0.5*$acc[$i]*($ttl[$j-1]-$ttl[$i])*($ttl[$j-1]-$ttl[$i]))+((1/6)*$jerk[$i]*($ttl[$j-1]-$ttl[$i])*($ttl[$j-1]-$ttl[$i])*($ttl[$j-1]-$ttl[$i])));

if($pos[$j-1]-$length-$pos[$i] < $d)
{

push(@group2,$a1[$j-1],$a1[$i]);

$rA=scalar(@group2);
for($wZ=0;$wZ<$rA; $wZ=$wZ+1)
{
#print("fourth one group2 : $group2[$wZ] \n");
}
$priority=$a1[$j-1];
#print "u are in fourth one \n ";



}
if(($pos[$j-1]-$length-$pos[$i]) >= $d)
{
push(@group1,$a1[$j-1]);
#print " u are in fifth one \n ";
$rA=scalar(@group1);
for($wZ=0;$wZ<$rA; $wZ=$wZ+1)
{
#print("fifth one: $group1[$wZ] \n");
}
undef(@group1);
$j=$i+1;
$num_lane_changes=$num_lane_changes+1;
if($i eq ($size-1))
{
$num_lane_changes=$num_lane_changes+1;
}

}

}
}

}
if($lani[$j-1] eq $lanf[$j-1])
{
$j=$i+1;
}
}
#print " total number of lane changes: $lane_changes \n";
#print " number of lane changes: $num_lane_changes \n";
#print " number of collisions: $no_collisions \n";
$width=scalar @group1;


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
# $t1 = Benchmark->new;
#$td = timediff($t1, $t0);
#print "the code took:",timestr($td),"\n";
$end=Time::HiRes::gettimeofday();
print outfile "Number of vehicles \t number of collisions \t number of lane changes \t time overhead \n";
print outfile "$size2 \t $no_collisions \t $num_lane_changes \t";
printf outfile ("%.5f \n",$end-$start);
close(outfile);
}
}














