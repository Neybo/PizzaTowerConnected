/// @description PLAY VID
while instance_exists(obj_videoplayer)
{
	video_close()
	instance_destroy(obj_videoplayer)
}
with instance_create(x - 244, y - 132, obj_videoplayer)
{
	videourl = other.input
	event_user(0)
}
alarm[0] = -1













