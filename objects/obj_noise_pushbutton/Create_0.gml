hspeed = -0.4
with obj_player
{
	state = states.actor
	xscale = 1
	sprite_index = spr_idle
	image_speed = 0.35
}
depth = -7
alarm[0] = room_speed * 9
image_speed = 0.35
image_xscale = -1
grav = 0.5;
hsp = 0;
vsp = 0;

if global.jukebox == -1
{
	fmod_stop_instance_immediately(global.music)
	noie = scr_sound(mu_noiseappear, false)
}
woah = false

