$k=1;
for($j=5;$j<=15;$j=$j+5)
{
for($i=0;$i<3;$i=$i+1)
{
open(outfile,">>inp/in_$j.$i.txt");
print outfile "vehicleid \t position \t velocity \t acceleration \t jerk \t distance \t theta \t time \t lani \t lanf \n";
close(outfile);
}
}

for($j=5;$j<=15;$j=$j+5)
{
for($i=0;$i<3;$i=$i+1)
{
open(outfile,">>inp/in_$j.$i.txt");
#print outfile "vehicleid \t position \t velocity \t acceleration \t jerk \t distance \t theta \t time \t lani \t lanf \n";
#unlink("in_$j.$i.txt");
while(<outfile>)
{
chomp;
push(@arr,$_);
}
close(file);
@array=splice(@arr,1,$j);
$minimum=5;

for($k=1; $k<=$j;$k=$k+1)
{
$position=int (rand(1600));
push(@pos,$position);
}








for($l=0;$l<$j;$i=$l+1)
{
for($m=$l+1;$m<=$j;$m=$m+1)
{
if($pos[$l] <$pos[$m])
{
$temp=$pos[$m];
$pos[$m]=$pos[$l];
$pos[$l]=$temp;

}
 
}
}

for($l=0;$l<$j;$i=$l+1)
{
$id=$l+1;

$velocity=int (rand(30))+$minimum;
$acceleration=int(rand(2));
$jerk=0;
$distance=(($velocity*3)+($acceleration*3*3));
$theta=45;
$u=($velocity*$velocity);
$time=(-$velocity+sqrt($u+(2*$acceleration*3.14)));
$lani=int(rand(3))+1;
$lanf=int(rand(3))+1;
print outfile "$id \t $pos[$l] \t $velocity \t $acceleration \t $jerk\t $distance \t $theta \t $time \t $lani\t $lanf \n";
}

#if($k eq 0)
#{
#print outfile "$id \t $pos[$k] \t $velocity \t $acceleration \t $jerk\t $distance \t $theta \t $time \t $lani\t $lanf \n"; 
#}


}
}
close(outfile);