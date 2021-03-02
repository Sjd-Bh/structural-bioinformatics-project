mol delete all

set output [open incident.txt w]
set output1 [open total.txt w]


set GBR [open "GBR_resid.txt"]
set GBR_resid [gets $GBR]
set HETlist [list F2I MR0 CS5 CS7 CS9 SC6 SC7 BSD 314 316 318 1LI 2LI 586 929 0BI 74A Z74 Z75 Z76 842 957 PB0 PB8 0GO 0LG 0N1 0GH 957 842]

set incid_list ""
set total_list ""
foreach res $GBR_resid {
	set total 0
	set incident 0
	set i 0
	foreach f [glob "./pdb/*.pdb"] {
		mol load pdb $f
		set HET [lindex $HETlist $i]
		set pdb_res [[atomselect top "protein and name CA and resid $res"] get resid]
		if {$pdb_res==$res} {
			set total [expr {1+$total}]
			set sel "protein and name CA and same residue as exwithin 4.5 of resname $HET and resid $res"
			set eff_contact [[atomselect top $sel] get resid]
			if {$eff_contact==$res} {
				set incident [expr {1+$incident}]
			}
		}
		set i [expr {1+$i}]
		mol delete all
	}
	lappend incid_list $incident
	lappend total_list $total
}

puts $output $incid_list
puts $total_list
$output1 $total_list

close $output
close $output1 



