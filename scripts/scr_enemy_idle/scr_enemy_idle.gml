function scr_enemy_idle() 
{
	if vsp > 1 && grounded
	{
		instance_create(x, y, obj_landcloud)
		image_index = 0
	}

	if (grounded or object_index == obj_ancho or object_index == obj_miniufo or object_index == obj_kentukybomber) 
	&& sprite_index == scaredspr && scaredbuffer <= 0
	{
		state = states.walk
		sprite_index = walkspr
		
		if object_index == obj_spitcheese && OLD_GAMEPLAY
			image_xscale = throwdir
		if object_index == obj_treasureguy
			state = states.chase
		if object_index == obj_pickle && attacking
		{
			attacking = false
			bombreset = 0
		}
	}
	
	if scaredbuffer > 0
	{
		scaredbuffer = max(scaredbuffer - 1, 0);
		if sugaryenemy && grounded && OLD_GAMEPLAY
			vsp = -5;
	}
	
	if ((variable_instance_exists(id, "turnspr") 
	&& sprite_index == turnspr) or sprite_index == spr_indiancheese_turn 
	or sprite_index == spr_tank_spawnenemy)
	&& floor(image_index) >= image_number - 1
	{
		sprite_index = walkspr
		state = states.walk
		
		if sprite_index == spr_pizzaslug_turn
			image_xscale *= -1
	}
	
	/*
	if grounded or (grounded && !place_meeting(x, y, obj_platform)) && vsp > 0
		hsp = 0
	if !((grounded or (grounded && !place_meeting(x, y, obj_platform)))) && hsp < 0
		hsp += 0.1
	else if !((grounded or (grounded && !place_meeting(x, y, obj_platform)))) && hsp > 0
		hsp -= 0.1
	*/
	hsp = 0;
	
	var railmeet = instance_place(x, y + 1, obj_railparent);
	if railmeet then hsp += railmeet.spdh;

	//Animation
	image_speed = 0.35
}
