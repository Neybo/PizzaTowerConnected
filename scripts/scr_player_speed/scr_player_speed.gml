function scr_playerspeed(){
	with obj_player
	{
		if global.oggamespeed
		{
			spd_wallclimb1 = 0.075
			spd_wallclimb2 = 0.2
			spd_grab = 10
			spd_movespeedcap = 20
			spd_movespeedpastcap = 0
			spd_mach3speed = 0.025
			spd_turnmach4 = 16
			spd_slide = 12
		}
		else
		{
			spd_wallclimb1 = 0.1
			spd_wallclimb2 = 0.3
			spd_grab = 11
			spd_movespeedcap = 28
			spd_movespeedpastcap = 0.01
			spd_mach3speed = (OLD_GAMEPLAY || !global.slopebitch) ? 0.1 : 0.025
			spd_turnmach4 = 20
			spd_slide = 14
		}
	}
}