if other.object_index =  && other.character != "S" && other.character != "V"
{
	if .shotgunAnim = false && .backupweapon = false && .state = states.handstandjump
	{
		.shotgunAnim = true
		.state = states.shotgun
		.image_index = 0
		.sprite_index= .spr_shotgunpullout
		global.gotshotgun = true
		scr_soundeffect(sfx_shotgungot)
		instance_destroy()
		
		tv_push_prompt_once(tv_create_prompt("This is the shotgun powerup text", 2, spr_tv_shotgun, 3), "shotgun");
		
		with obj_tv
		{
			image_speed = 0.25
			message = choose( "ITS TIME TO KICK ASS", "...AND IM ALL OUT OF ASS", "KICKING ASS AND CHEWING ASS", "ITS TIME TO ASS", "IM ALL OUT OF BUBBLE GUM",
			"ITS TIME TO CHEW BUBBLE GUM AND KICK ASS", "ITS TIME TO KICK BUBBLE GUM", "ITS TIME FOR AN ASS KICKING", "ITS TIME FOR BUBBLE GUM",  "ITS TIME TO CHEW ASS")
			alarm[0] = 200
			showtext = true
			tvsprite = spr_tvdook
		}

	}

}