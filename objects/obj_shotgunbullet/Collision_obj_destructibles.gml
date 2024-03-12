if other.object_index != obj_hungrypillar or !pistol
{
	if other.object_index == obj_onewaybigblock
	{
		if (sign(image_xscale) != sign(-other.image_xscale)) or sprite_index == spr_bullet_h
			exit;
	}
	if other.object_index == obj_hungrypillar
	{
		if abs(spdh) > 4
			exit;
	}
	instance_destroy(other)
}
