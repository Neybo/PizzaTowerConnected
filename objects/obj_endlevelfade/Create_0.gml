if (global.racing)
{
	var timestr = string(global.taminutes) + ":"
	if (global.taseconds < 10)
		timestr += "0"
	timestr += string(global.taseconds)
	gms_p2p_send(p2p.race_finished, gms_p2p_all_in_session, timestr)
	room_goto(racing_results)
	room = racing_results
	instance_destroy();
	exit;
}

with obj_player
{
	scale_xs = 1
	scale_ys = 1
}

fadealpha = 0
AT = false
HAT = false
fadein = false
depth = -10000;
alarm[0] = 235;

// do the thing
if global.jukebox != -1
	fmod_pause_instance(global.jukebox);
endlevel();

if (global.rank == "s" && scr_prankvalid() && check_online())
{
	jba_global("P-rank!", gms_self_name() + " has just got a p-rank on " 
	+ scr_levelnamenice() + "! Nice!", globalembeds.p_rank)
}

global.leveltosave = "none"
global.tauntcount = 0

if scr_checkskin(checkskin.p_anton)
{
	scr_soundeffect(mu_antoncomplete);
	alarm[0] = 150;
}
else
{
	// get rank music
	var ranksound = mu_ranka;
	if instance_exists(obj_player) && obj_player.character == "SN"
	{
		ranksound = mu_ranks_sn;
		alarm[0] = room_speed * 3.5;
	}
	else if instance_exists(obj_player) && (obj_player.character == "SP")
	{
		// sugary spire's shitty one
		ranksound = mu_ranka_ss;
		if global.rank == "s" or global.rank == "yousuck"
			ranksound = mu_ranks_ss;
		if global.rank == "b"
			ranksound = mu_rankb_ss;
		if global.rank == "c"
			ranksound = mu_rankc_ss;
		if global.rank == "d"
			ranksound = mu_rankd_ss;
		alarm[0] = room_speed * 3.55;
	}
	else
	{
		if global.rank == "s"
			ranksound =  scr_prankvalid() ? mu_rankp : mu_ranks;
		if global.rank == "b" or global.rank == "c"
			ranksound = mu_rankc;
		if global.rank == "d"
			ranksound = mu_rankd;
	}
	if global.rank == "yousuck"
	{
		ranksound = mu_ranksuck;
		if global.musicgame != 1
			alarm[0] = room_speed * 3.5;
	}
	
	// pp
	if instance_exists(obj_player) && obj_player.character == "PP" && !global.streamer
	{
		ranksound = mu_ranks_PP;
		alarm[0] = room_speed * 3.5;
	}
	
	// apply event:/PIZZA CASTLE
	if global.musicgame == 1
		ranksound = scr_getmidi(ranksound);
	
	// play
	scr_soundeffect(ranksound);
}

with obj_player
{
	doorx = x;
	state = states.door;
	sprite_index = spr_lookdoor;
	image_index = 0;
}
global.panic = false;
global.snickchallenge = false;

with obj_followcharacter
	if object_index != obj_petfollow instance_destroy();

