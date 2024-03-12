// handle it in obj_baddie instead
if inst_relation(other, obj_onewaybigblock)
	exit;

if instance_exists(baddieID) && baddieID.thrown
{
	if REMIX_GAMEPLAY
		other.momentum[0] = baddieID.hsp;
	instance_destroy(other);
}

