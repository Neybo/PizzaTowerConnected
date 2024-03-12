if opened || alarm[0] != -1
	return;
	
with other
{
	if key_up2 && grounded && state == states.normal
	{
		video_close()
		instance_destroy(obj_videoplayer)
		other.input = ""
		other.opened = true
	}
}