mol delete all

set output [open BR.txt w]
set output1 [open contact.txt w]

set GBR [open "GBR_resid.txt"]
set GBR_resid [gets $GBR]

set HETlist [list F2I MR0 CS5 CS7 CS9 SC6 SC7 BSD 314 316 318 1LI 2LI 586 929 0BI 74A Z74 Z75 Z76 842 957 PB0 PB8 0GO 0LG 0N1 0GH 957 842]
set i 0
foreach f [glob "./cleanPDB/*.pdb"] {
	mol load pdb $f
	set HET [lindex $HETlist $i]
	set BR_rseid "protein and name CA and resid $GBR_resid"
	set BR [[atomselect top $BR_rseid] get resid]
	puts $output $BR 
	
	set eff_resid "protein and name CA and same residue as exwithin 4.5 of resname $HET"
	set contact [[atomselect top $eff_resid] get resid]
	puts $output1 $contact
	set i [expr {1+$i}]
}

close $output
close $output1
