# Nick Petro
.data
x: .half 15 
y: .half 6 
z: .half 0
.text
# instructions go here
la $a0, x
lh $t0, 0($a0)
lh $t1, 2($a0)
sub $t0, $t0, $t1
#store and overwrite
sh $t0, 4($a0)
sh $t0, 2($a0)
sh $t0, 0($a0)