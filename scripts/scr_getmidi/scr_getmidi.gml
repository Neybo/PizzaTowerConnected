function scr_getmidi(mus)
{
	// placeholders
	if mus == mu_hub2
		mus = mu_characterselect_pc;
	else if mus == mu_snickentrance or mus == mu_vigientrance
		mus = mu_entrance_pc;
	else if mus == mu_dungeondepth_re
		mus = mu_dungeondepth_pc;
	else if mus == mu_pizzatime_PP_streamer
		mus = mu_pizzatime_PP_pc;
	else if mus == mu_pizzatime_OLD
		mus = mu_pizzatime_pc;
	else
	{
		mus = fmod_swap_audio(mus, global.fmod_pc_replace)
	}
	return mus;
}

