if floor(image_index) >= image_number - 1 && sprite_index == spr_grabbiehand_hifive
{
	sprite_index = spr_grabbiehand_idle
	thumbingup = false
	image_xscale = 1
}

//Fall
var targetplayer = instance_nearest(x, y, obj_player);
if targetplayer && x == xstarte && y == ystarte && !thumbingup
&& number_in_range(targetplayer.x, x - 50, x + 50) && number_in_range(targetplayer.y, y, y + 400)
{
	delay--
	if delay <= 0
	{
		scr_soundeffect(sfx_enemyprojectile)
		grav = 0.35
		vsp = 10
		sprite_index = spr_grabbiehand_fall
		delay = 5
	}
}

//Land and go back up
if grounded && sprite_index == spr_grabbiehand_fall && !grabbing
{
	grav = 0
	sprite_index = spr_grabbiehand_idle
	vsp = -3
}

//Ready to fall again
if y <= ystarte && vsp < 0 && !grabbing
{
	vsp = 0
	y = ystarte
}
//Move toward drop spot
if sprite_index == spr_grabbiehand_catch && !released && grabbing
{
	x = Approach(x, dropspotx, 4);
	y = Approach(y, dropspoty, 4);
}

//Release
if x == dropspotx && y == dropspoty && !released && grabbing
{
	with player
		state = states.freefall
	
	player = noone
	image_index = 0
	sprite_index = spr_grabbiehand_release
	released = true
}

//Come back from release
if sprite_index == spr_grabbiehand_release && floor(image_index) >= image_number - 1 && released && grabbing
	sprite_index = spr_grabbiehand_idle

if sprite_index = spr_grabbiehand_idle && released && grabbing
{
	x = Approach(x, xstarte, 4);
	y = Approach(y, ystarte, 4);
}

//Back to start
if x == xstarte && y == ystarte && grabbing && sprite_index == spr_grabbiehand_idle
{
	grabbing = false
	released = false
}
scr_collide()

if instance_exists(player)
{
	with player
	{
		vsp = 0
		hsp = 0
		state = states.bump
		sprite_index = spr_catched
		x = other.x
		y = other.y
	}
}
