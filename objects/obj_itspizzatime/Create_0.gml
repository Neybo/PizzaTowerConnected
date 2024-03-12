up = 540 + 100;
image_speed = 0.35;

spr = spr_itspizzatime;
if global.snickrematch
	spr = spr_itspizzatime_re;

if instance_exists(obj_player)
{
	if obj_player.character == "SP" or obj_player.character == "SN"
		spr = spr_glucosegetaway;
	if obj_player.character == "PP"
		spr = spr_itspizzatime_PP;
	if (scr_checkskin(checkskin.p_anton))
	{
		spr = spr_itspizzatime_an
		if (FINAL_GAMEPLAY)
		{
			if (scr_checkskin(checkskin.p_antononly))
				scr_soundeffect(sfx_antonhappyhour)
			else
				scr_soundeffect(sfx_anniehappyhour)
		}
	}
}

