with other
{
	if character == "V"
		scr_hurtplayer(id)
	else
	{
		if scr_transformationcheck()
		{
			hsp = 0
			movespeed = 0
			state = states.firemouth
			image_index = 0
			sprite_index = spr_firemouthintro
			state = states.firemouth
			bombpeptimer = 3
			instance_destroy(other, false)
			
			tv_push_prompt_once(tv_create_prompt("This is the firemouth transformation text", 2, spr_tv_firemouth, 3), "firemouth");
		}
	}
}

