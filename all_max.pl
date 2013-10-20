$g=100;
for($h=0;$h<1000;$h=$h+1)
{
open(FILE,"<","outs/in_$g.$h.txt");
while(<FILE>)
{
chomp;
push(@arr,$_);
}

close(FILE);
@array=splice(@arr,1,1);
undef @arr;
print "line is $array[0] \n";
foreach $line(@array)
{
@line=split(/\s+/,$line);
#print "line is $line[0] \n";
push(@num_coll,$line[1]);
#print "$num_coll[0] \n";
push(@num_lane,$line[2]);
push(@num_veh,$line[0]);
push(@time,$line[3]);
}
#print "line is $line[0] \n";
undef @array;
}
################################### collisions ###########################################################
$max=$num_coll[0];

for($i=0;$i<1000;$i=$i+1)
{
if($num_coll[$i]>$max)
{
$max=$num_coll[$i];
}
}
$max=$max/$g;

$min=$num_coll[0];

for($i=0;$i<1000;$i=$i+1)
{
if($num_coll[$i]<$min)
{
$min=$num_coll[$i];
}
}
$min=$min/$g;

for($i=0;$i<1000;$i=$i+1)
{

$avg=$avg+$num_coll[$i];
}
$avg=$avg/($g*1000);

#########################################      lane changes    ##########################################################################

$max_lc=$num_lane[0];

for($i=0;$i<1000;$i=$i+1)
{
if($num_lane[$i]>$max_lc)
{
$max_lc=$num_lane[$i];
#print "i is $i \n";
$numax_lc= $num_veh[$i];
}


}
$min_lc=$num_lane[999];

for($i=0;$i<1000;$i=$i+1)
{
if($num_lane[$i]<$min_lc)
{
$min_lc=$num_lane[$i];
$numin_lc= $num_veh[$i];
}

}


for($i=0;$i<1000;$i=$i+1)
{

$avg_lc=$avg_lc+$num_lane[$i];
$num=$num+$num_veh[$i];
}
$avg_lc=$avg_lc/$num;



#########################################        time            ############################################################################

$max_time=$time[0];

for($i=0;$i<1000;$i=$i+1)
{
if($time[$i]>$max_time)
{
$max_time=$time[$i];
}
}

$min_time=$time[0];

for($i=0;$i<1000;$i=$i+1)
{
if($time[$i]<$min_time)
{
$min_time=$time[$i];
}
}

for($i=0;$i<1000;$i=$i+1)
{

$avg_time=$avg_time+$time[$i];
}
$avg_time=$avg_time/1000;


print "maximum coll all of $g is $max \n";
print "minimum coll all of $g is $min \n";
print "avg coll all of $g is $avg \n";
print "maximum lane all of $g is $max_lc \n";
print "minimum lane all of $g is $min_lc \n";
print "avg lane all of $g is $avg_lc \n";
print "maximum time all of $g is $max_time \n";
print "minimum time all of $g is $min_time \n";
print "avg coll time of $g is $avg_time \n";
print "max number of vehicles is $numax_lc \n";
print "min number of vehicles is $numin_lc \n";
close(FILE);