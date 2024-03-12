if other.state == states.gameover exit;

if !picked
{
	hsp = 0
	vsp = 0
	grav = 0
	
	playerid = obj_player

	alarm[0] = 150

	y = playerid.y -50
	x = playerid.x


	with playerid
	{
		state = states.gottreasure
		scr_soundeffect(sfx_secretfound)
		global.giantkey = true
	}
	
	with obj_tv
	{
		showtext = true
		message = "GOT THE GIANT KEY!"
		alarm[2] = 200
	}
	
	global.combotime = 60
	picked = true
}

