if other.state == states.gameover or other.state == states.hitlag
	exit;

instance_create(x, y, obj_balloonpop);

visible = false;
x = -9999;
y = -9999;
respawn = 100;

with other
{
	vsp = -14;
	jumpstop = true;
	
	if state == states.climbwall
		state = states.jump;
	if state == states.jump
		sprite_index = spr_machfreefall;
}

if REMIX_GAMEPLAY
	scr_soundeffect(sfx_step);

