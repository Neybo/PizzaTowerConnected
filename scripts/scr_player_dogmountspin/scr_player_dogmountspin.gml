function scr_player_dogmountspin(){
	hsp = movespeed
	vsp = 0
	grav = 0
	var rat = instance_place(x + xscale, y, obj_ratblock)
	if rat
		instance_destroy(rat)
	
	if scr_solidwall(x + sign(hsp), y)
	{
		movespeed *= -1
	}
	
	if animEnd
	{
		grav = basegrav
		state = states.dogmount
		image_index = 0
		sprite_index = (movespeed != 0) ? spr_rideweenie : spr_rideweenie
	}
	image_speed = 0.35
}