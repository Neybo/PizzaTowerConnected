if other.object_index == obj_onewaybigblock
{
	if x < other.x + 64 && sign(other.image_xscale) == 1
	or x > other.x + -64 && sign(other.image_xscale) == -1
		exit;
}
instance_destroy(other)

