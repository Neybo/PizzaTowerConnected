/// @description start race
var timeattack = global.timeattack;
scr_playerreset();
global.racing = true
room_speed = 60
global.racelimit = levelselectlimit[levelselect]

instance_activate_object(obj_player)
if instance_exists(obj_player)
{
	with (obj_player)
	{
		state = states.normal;
		targetDoor = "A";
		targetRoom = other.levelselectroom[other.levelselect]
		lastplayerracing = gms_session_player_count(gms_session_current_id())
	}
}

room_goto_new(levelselectroom[levelselect]);

global.timeattack = timeattack;
with obj_timeattack
	newalarm = 60;
destroythis = true

while instance_exists(self)
		instance_destroy(self)