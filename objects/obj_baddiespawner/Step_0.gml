scr_collide();
if content == noone or !is_real(content) && !object_exists(content)
	exit;

with obj_player
{
	if character == "V" && (other.content == obj_shotgun or other.content == obj_woodbarrel)
		instance_destroy(other.id);
	if character == "S" && other.content == obj_shotgun
		instance_destroy(other.id);
}

if (!instance_exists(baddieid) && content != obj_shotgun) 
or (!instance_exists(baddieid) && content == obj_shotgun && !obj_player.shotgunAnim)
	refresh--;
else
	refresh = 100;

if refresh <= 0 
{
	image_speed = 0.35
	if floor(image_index) == 5
	{
		with instance_create(x, y - 20, content)
		{
			image_xscale = (object_index == obj_shotgun ? 1 : other.image_xscale);
			state = states.stun;
			stunned = 50;
			vsp = -5;
			other.baddieid = id;
			killreward = false;
			depth = 0;
			countdown = other.countdown
			defused = false
		}
		
		refresh = 100;
	}
}

// provoke
if REMIX_GAMEPLAY
{
	var targetplayer = instance_nearest(x, y, obj_player);
	if targetplayer && targetplayer.x > x - 200 && targetplayer.x < x + 200 && y <= targetplayer.y + 20 && y >= targetplayer.y - 20
	&& targetplayer.state == states.backbreaker
		refresh = 1;
}

