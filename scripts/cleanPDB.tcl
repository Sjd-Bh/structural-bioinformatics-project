mol delete all

set HETlist [list F2I MR0 CS5 CS7 CS9 SC6 SC7 BSD 314 316 318 1LI 2LI 586 929 0BI 74A Z74 Z75 Z76 842 957 PB0 PB8 0GO 0LG 0N1 0GH 957 842]
set i 0
foreach f [glob "./pdb/*.pdb"] {
	set HET [lindex $HETlist $i]
	set out [string range $f end-7 end-4]
	set g [append out "_cleanStr.pdb"]
	
	mol load pdb $f
	set sel "protein and chain A and not altloc B or resname $HET"
	[atomselect top $sel] writepdb $g
	
	set i [expr {1+$i}]
}

