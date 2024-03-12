function scr_player_portal()
{
	var port = instance_place(x,y,obj_lapportal)
	visible = !port
	if floor(image_index) >= image_number - 1 
	&& (visible || port.sprite_index != spr_portalenter) // better idea? hopefully fixes issues,
	{
		visible = true
		instance_create(x, y, obj_pizzaportalfade)
		state = states.jump
		sprite_index = spr_fall
		grav = basegrav
		vsp = grav;
		return;
	}
	mach2 = 0
}
