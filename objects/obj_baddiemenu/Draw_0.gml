/// @description
draw_self();

if content != noone && showbaddie
{
	var spr = -1;
	if content == "special1"
	{
		spr = spr_sausageman_idle;
		pal_swap_set(spr_sausageman_palette, 1, false);
	}
	else if content == "bluethug"
	{
		spr = spr_shrimp_idle;
		pal_swap_set(spr_shrimppalette, 2, false);
	}
	else if content == "greenthug"
	{
		spr = spr_shrimp_idle;
		pal_swap_set(spr_shrimppalette, 1, false);
	}
	else
		spr = object_get_sprite(content);
	
	if spr == spr_noisey_walk_NEW && OLD_GAMEPLAY
		spr = spr_noisey_walk;
	if spr == spr_ninjaNEW_idle && OLD_GAMEPLAY
		spr = spr_ninja_idle;
	if spr == spr_newpizzice_walk && OLD_GAMEPLAY
		spr = spr_pizzice_walk;
	if spr == spr_charcherry_wait
	{
		spr = spr_charcherry_run;
		if REMIX_GAMEPLAY
			spr = spr_charcherry_run_NEW;
	}
	
	draw_sprite_ext(spr, 0, x, y - 64, image_xscale, image_yscale, image_angle, image_blend, 0.5);
	pal_swap_reset();
}

