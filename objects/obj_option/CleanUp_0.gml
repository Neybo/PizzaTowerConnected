surf_free()
surf_free(bgsurf)

instance_destroy(roomname);

if global.music != music
	fmod_release_instance(music)
	
fmod_release_instance(pmach2_new)
fmod_release_instance(pmach2_old)

if instance_exists(blur_op1)
{
	instance_destroy(blur_op1)
	instance_destroy(blur_op2)
	instance_destroy(mach_op1)
	instance_destroy(mach_op2)
}
