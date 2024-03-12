/// @description hats & reset choice
var _s = selarray[sel[0]][0];
if _s == "special1"
	spr_idle = spr_sausagemansmoked_grabbed;
else if _s == "bluethug" or _s == "greenthug"
	spr_idle = spr_shrimp_idle;
else
	spr_idle = object_get_sprite(selarray[sel[0]][0]);

if spr_idle == spr_noisey_walk_NEW && OLD_GAMEPLAY
	spr_idle = spr_noisey_walk;
if spr_idle == spr_ninjaNEW_idle && OLD_GAMEPLAY
	spr_idle = spr_ninja_idle;
if spr_idle == spr_newpizzice_walk && OLD_GAMEPLAY
	spr_idle = spr_pizzice_walk;
if spr_idle == spr_charcherry_wait
{
	spr_idle = spr_charcherry_run;
	if REMIX_GAMEPLAY
		spr_idle = spr_charcherry_run_NEW;
}

selmin = 0;
selmax = array_length(selarray) - 1;

