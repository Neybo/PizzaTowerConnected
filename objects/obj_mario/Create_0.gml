if room != rm_mario
{
	room_goto(rm_mario);
	exit;
}
application_surface_draw_enable(true);

fmod_stop_all();
with all
	if id != other.id instance_destroy(id, false);
image_alpha = 0;

