/// @description title screen
with all
	if !persistent instance_destroy(id, false);

instance_destroy(obj_hallway);
instance_destroy(obj_fadeout);
instance_destroy(obj_wartimer)

global.hp = 0;
global.minichat = global.minichatstore

if global.jukebox == FMOD_EMPTY
	fmod_stop_all();
else
	fmod_resume_all();

pause = false;
instance_activate_all();

instance_destroy(obj_debris);
with obj_panicdebris
	alarm[0] = -1;

room_goto(Realtitlescreen);

with obj_player
{
	petfollow = -1
	gravmult = 1
	character = "P"
	state = states.titlescreen
	targetDoor = "A"
	scr_characterspr()
}
scr_playerreset();


// create nice fadeout
instance_create(0, 0, obj_fadein);

