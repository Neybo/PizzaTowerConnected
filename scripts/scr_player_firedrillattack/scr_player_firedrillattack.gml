function scr_player_firedrillattack(){
	hsp = 14 * xscale
	vsp = 0
	grav = 0
	var rat = instance_place(x + xscale, y, obj_ratblock)
	if rat
		instance_destroy(rat)
	
	if scr_solid(x + xscale, y)
	{
		movespeed = 14
		wallspeed = 14
		grav = basegrav
		image_index = 0
		state = states.climbwall
		sprite_index = spr_machclimbwall
	}
	
	if animEnd
	{
		grav = basegrav
		state = states.mach2
		image_index = 0
		movespeed = 14
	}
	image_speed = 0.35
}