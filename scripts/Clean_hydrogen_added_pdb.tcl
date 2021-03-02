mol delete all

foreach f [glob ./PDB_hydrogenAdded/*.pdb] {
	set out [string range $f end-9 end-6]
	set g [append out "_H_clean.pdb"]
	mol load pdb $f
	[atomselect top all] writepdb $g
}