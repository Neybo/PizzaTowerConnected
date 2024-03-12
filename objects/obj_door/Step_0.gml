if sprite_index == spr_doorblockedsaloon
	return;
if visited && sprite_index != spr_pepperdoor && sprite_index != spr_costumerdoor
{
	sprite_index = spr_doorvisited
	if check_sugary()
		sprite_index = spr_door_ss
		
	
}	

//if instance_exists(obj_noisesatellite)
	//	sprite_index = spr_doorblocked