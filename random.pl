use Benchmark;
#$t0 = Benchmark->new;
$length=2;

for($g=5;$g<=100;$g=$g+5)
{
for($h=0;$h<=999;$h=$h+1)
{
$start=Time::HiRes::gettimeofday();
open(FILE,"<","inp/in_$g.$h.txt");
open(outfile,">>","outs/in_$g.$h.txt");


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

#print "line is $line[0] \n";
push(@a1, $line[0]);
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
}
undef @array;
$theta=$theta[0];
$size2=scalar @a2;
$size=scalar @a1;
$random_number=int(rand($size2-1)); 
     
#print "$random_number \n ";                                                                                                                                                                                                                                                                                                                                                                                
#print "$size2 \n ";

@done1= ();

$random_number1=$random_number;
for($i=0;$i<$random_number1;$i=$i+1)
{
$some=int(rand($size2))+1;


if(! grep{/$some/} @done1)
{
push(@done1, $some);
}
else
{
$random_number1=$random_number+1;
}

}




$width= scalar @done1;
@done=sort @done1;
#print "done : $done[0] \n "; 



#################################################################
for($i=0;$i<$width;$i=$i+1)
{


if($lani[$done[$i]+1] !=0 or $lani[$done[$i]-1] !=0)
{
if($lani[$done[$i]+1] != 2 and $lani[$done[$i]-1] eq 2 )
{
$c=(1/cos($theta));
$a=1;
$c_square=$c*$c;
$b=sqrt($c_square-$a);
$s=3.14*$b;
if(($pos[$done[$i]-1]-$pos[$done[$i]]) < ($dis[$done[$i]-1]+$s))
{
$no_collisions=$no_collisions+1;
}
if(($pos[$done[$i]-1]-$pos[$done[$i]]) >= ($dis[$done[$i]-1]+$s))
{
#$num_lane_changes=$num_lane_changes+1;
}
if($done[$i] < $size2-2)
{
for($j=$i+2; $j<$width; $j=$j+1)
{
if($lani[$j]==2)
{
if($acc[$done[$j]] !=0)
{
$q=4*$vel[$done[$j]]*$vel[$done[$j]];
$w=($pos[$done[$j]]-$length-$dis[$done[$j]]);
$d=8*$w*$acc[$done[$j]];
$r=sqrt($q+$d);
$t=((-2*$vel[$done[$j]])+$r);
$time_has=$t/(2*$acc[$done[$j]]);   
}
if($acc[$done[$j]] eq 0)
{
$w=($pos[$done[$j]]-$length-$dis[$done[$j]]);
$time_has=($w/$vel[$done[$j]]);
}
if($time_has< $ttl[$done[$i]])
{
$no_collisions=$no_collisions+1;
#print "is it coming in this loop "; 
}
if($time_has>= $ttl[$done[$i]])
{
if(($pos[$done[$i]-1]-$pos[$done[$i]]) >= ($dis[$done[$i]-1]+$s))
{
$num_lane_changes=$num_lane_changes+1;
}
#print "is it coming in this loop "; 
}
last;
}
}
}
}





############################################################################################################################

if($lani[$done[$i]+1] eq 2 and $lani[$done[$i]-1] != 2 )
{
if($acc[$done[$i]+1] !=0)
{
$q=4*$vel[$done[$i]+1]*$vel[$done[$i]+1];
$w=($pos[$done[$i]+1]-$length-$dis[$done[$i]+1]);
$d=8*$w*$acc[$done[$i]+1];
$r=sqrt($q+$d);
$t=((-2*$vel[$done[$i]+1])+$r);
$time_has=$t/(2*$acc[$done[$i]+1]);   
}
if($acc[$done[$i]+1] eq 0)
{
$w=($pos[$done[$i]+1]-$length-$dis[$done[$i]+1]);
$time_has=($w/$vel[$done[$i]+1]);
}
if($time_has< $ttl[$done[$i]])
{
$no_collisions=$no_collisions+1;
#print "is it coming in this loop "; 
}
if($time_has>= $ttl[$done[$i]])
{
#$num_lane_changes=$num_lane_changes+1;
#print "is it coming in this loop "; 
}
if($i>=2)
{
for($j=$i-2; $j!=0; $j=$j-1)
{
if($lani[$done[$j]]==2)
{
$c=(1/cos($theta));
$a=1;
$c_square=$c*$c;
$b=sqrt($c_square-$a);
$s=3.14*$b;
if(($pos[$done[$j]]-$pos[$done[$i]]) < ($dis[$done[$j]]+$s))
{
$no_collisions=$no_collisions+1;
}
if(($pos[$done[$j]]-$pos[$done[$i]]) >= ($dis[$done[$j]]+$s))
{
if($time_has>= $ttl[$done[$i]])
{
$num_lane_changes=$num_lane_changes+1;
}
}
last;
}
}
}

}






####################################################################################################################

if($lani[$done[$i]+1] eq 2 and $lani[$done[$i]-1] eq 2 )
{
if($acc[$done[$i]+1] !=0)
{
$q=4*$vel[$done[$i]+1]*$vel[$done[$i]+1];
$w=($pos[$done[$i]+1]-$length-$dis[$done[$i]+1]);
$d=8*$w*$acc[$done[$i]+1];
$r=sqrt($q+$d);
$t=((-2*$vel[$done[$i]+1])+$r);
$time_has=$t/(2*$acc[$done[$i]+1]);
}
if($acc[$done[$i]+1] eq 0)
{
$w=($pos[$done[$i]+1]-$length-$dis[$done[$i]+1]);
$time_has=($w/$vel[$done[$i]+1]);
}
$c=(1/cos($theta));
$a=1;
$c_square=$c*$c;
$b=sqrt($c_square-$a);
$s=3.14*$b;

if($time_has< $ttl[$done[$i]] and ($pos[$done[$i]-1]-$pos[$done[$i]]) < ($dis[$done[$i]-1]+$s))
{
$no_collisions=$no_collisions+1;
#print "is it coming in this loop "; 
}
if($time_has>= $ttl[$done[$i]] and ($pos[$done[$i]-1]-$pos[$done[$i]]) >= ($dis[$done[$i]-1]+$s))
{
$num_lane_changes=$num_lane_changes+1;
#print "is it coming in this loop "; 
}

if($time_has< $ttl[$done[$i]] and ($pos[$done[$i]-1]-$pos[$done[$i]]) >= ($dis[$done[$i]-1]+$s))
{
$no_collisions=$no_collisions+1;
#print "is it coming in this loop "; 
}
if($time_has>= $ttl[$done[$i]] and ($pos[$done[$i]-1]-$pos[$done[$i]]) < ($dis[$done[$i]-1]+$s))
{
$no_collisions=$no_collisions+1;
#print "is it coming in this loop "; 
}

}



################################################################################################################
if($lani[$done[$i]+1] != 2 and $lani[$done[$i]-1] !=2 )
{
if($lani[$done[$i]+1] != $lanf[$done[$i]+1])
{
$dd=$dis[$done[$i]]+(($vel[$done[$i]+1]*($ttl[$done[$i]]-$ttl[$done[$i]+1]))+(0.5*$acc[$done[$i]+1]*($ttl[$done[$i]]-$ttl[$done[$i]+1])*($ttl[$done[$i]]-$ttl[$done[$i]+1]))+((1/6)*$jerk[$done[$i]+1]*($ttl[$done[$i]]-$ttl[$done[$i]+1])*($ttl[$done[$i]]-$ttl[$done[$i]+1])*($ttl[$done[$i]]-$ttl[$done[$i]+1])));
#print "$d \n";
#print "$pos[$j-1] \n";
#print "$pos[$i] \n";
if($pos[$done[$i]]-$length-$pos[$done[$i]+1] < $dd)
{


$no_collisions=$no_collisions+1;
#print "u are in collisions loop \n ";



}
elsif(($pos[$done[$i]]-$length-$pos[$done[$i]+1]) >= $dd)
{
$num_lane_changes=$num_lane_changes+1;
#print " u are in lane changes loop \n ";
}

}
if($lani[$done[$i]+1] eq $lanf[$done[$i]+1])
{
if($done[$i] < $size2-2)
{
for($k=$i+2; $k<$width; $k=$k+1)
{
if($lani[$k]==2)
{
if($acc[$done[$k]] !=0)
{
$q=4*$vel[$done[$k]]*$vel[$done[$k]];
$w=($pos[$done[$k]]-$length-$dis[$done[$k]]);
$d=8*$w*$acc[$done[$k]];
$r=sqrt($q+$d);
$t=((-2*$vel[$done[$k]])+$r);
$time_has=$t/(2*$acc[$done[$k]]);   
}
if($acc[$done[$k]] eq 0)
{
$w=($pos[$done[$k]]-$length-$dis[$done[$k]]);
$time_has=($w/$vel[$done[$k]]);
}
if($time_has< $ttl[$done[$i]])
{
$no_collisions=$no_collisions+1;
#print "is it coming in this loop "; 
}
if($time_has>= $ttl[$done[$i]])
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
if($lani[$done[$j]]==2)
{
$c=(1/cos($theta));
$a=1;
$c_square=$c*$c;
$b=sqrt($c_square-$a);
$s=3.14*$b;
if(($pos[$done[$j]]-$pos[$done[$i]]) < ($dis[$done[$j]]+$s))
{
$no_collisions=$no_collisions+1;
}
if(($pos[$done[$j]]-$pos[$done[$i]]) >= ($dis[$done[$j]]+$s))
{
if($time_has>= $ttl[$done[$i]])
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
}
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

#print(" total number of vehicles which want to change the lane: $random_number \n ");
#print("number of collisions are :$no_collisions \n ");
#print("number of lane changes: $num_lane_changes \n ");

 #$t1 = Benchmark->new;
#$td = timediff($t1, $t0);
#print "the code took:",timestr($td),"\n";

$end=Time::HiRes::gettimeofday();

print outfile "Number of vehicles \t number of collisions \t number of lane changes \t time overhead \n";
print outfile "$random_number \t $no_collisions \t $num_lane_changes \t";
printf outfile ("%.5f \n",$end-$start);
close(outfile);
}
}