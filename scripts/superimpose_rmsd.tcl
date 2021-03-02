
mol delete all

set file [glob ./cleanpdb/*.pdb]
set GBR [open "GBR_resid.txt"]
set GBR_resid [gets $GBR]
set output [open "rmsd.txt" w]

for {set i 0} {$i < [llength $file]} {incr i} {
	set ref [mol load pdb [lindex $file $i]]
	set ref_BR [[atomselect $ref "protein and name CA and resid $GBR_resid"] get resid]
	set rmsd_list ""
	for {set z 0} {$z <= $i} {incr z} {lappend rmsd_list 0}
	
	for {set j [expr {1+$i}]} {$j < [llength $file]} {incr j} {
		set compare [mol load pdb [lindex $file $j]]
		set BR [[atomselect $compare "protein and name CA and resid $ref_BR"] get resid]
		set BR [lsort -unique $BR]
		set sel "protein and name CA and resid $BR"
		# compute the transformation matrix
		set reference_sel [atomselect $ref $sel]
		set comparison_sel [atomselect $compare $sel]
		set fitMat [measure fit $comparison_sel $reference_sel]
		
		# apply it to all of binding region of the molecule 1
		set move_sel [atomselect $compare "protein and resid $BR"]
		$move_sel move $fitMat
		# measure rmsd
		set tcl_precision 5
		set out_rmsd [measure rmsd $comparison_sel $reference_sel]
		lappend rmsd_list $out_rmsd
	}
	set rmsd_array(rmsd_list) $rmsd_list
	puts $output $rmsd_array(rmsd_list)
	mol delete all
}

close $GBR
close $output
