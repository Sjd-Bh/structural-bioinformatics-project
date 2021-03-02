mol delete all 
source ./union_intersection_proc.tcl
set HETlist [list F2I MR0 CS5 CS7 CS9 SC6 SC7 BSD 314 316 318 1LI 2LI 586 929 0BI 74A Z74 Z75 Z76 842 957 PB0 PB8 0GO 0LG 0N1 0GH 957 842]
# set pdb [2IQG-F2I 2P83-MR0 2QK5-CS5 2QMD-CS7 2QMF-CS9 2QMG-SC6 2QP8-SC7 2VKM-BSD 3CIB-314 3CIC-316 3CID-318 3IVH-1LI 3IVI-2LI 3IXJ-586 3IXK-929 3K5C-0BI 3LNK-74A 3LPI-Z74 3LPJ-Z75 3LPK-Z76 3N4L-842 3NSH-957 3R2F-PB0 3SKG-PB8 3VEU-0GO 4DPF-0LG 4DPI-0N1 4GID-0GH 4I0I-957 4I0J-842]
# GBR detecting
set j 0
set GBR_resid ""
foreach f [glob "./cleanPDB/*.pdb"] {
	set HET [lindex $HETlist $j]
	set i [mol load pdb $f]
	set sel "protein and name CA and same residue as exwithin 4.5 of resname $HET"
	set BR_resid [[atomselect $i $sel] get resid]
	lappend GBR_resid $BR_resid
	#puts $GBR_resid
	set j [expr {1+$j}]
}

set GBR [lsort -unique -integer [join $GBR_resid]]

set output [open GBR_resid.txt w]
puts $output $GBR
close $output