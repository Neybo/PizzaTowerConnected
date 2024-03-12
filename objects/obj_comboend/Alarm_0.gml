timer = round(timer_max)
if sugary
{
	switch floor(combo / 5)
	{
		case 0: scr_soundeffect(sfx_sscombo_bad); break;
		case 1: scr_soundeffect(sfx_sscombo_sour); break;
		case 2: scr_soundeffect(sfx_sscombo_ok); break;
		case 3: scr_soundeffect(sfx_sscombo_sweet); break;
		case 4: scr_soundeffect(sfx_sscombo_spicy); break;
		case 5: scr_soundeffect(sfx_sscombo_ruthless); break;
		
		default: scr_soundeffect(sfx_sscombo_wtf); break;
	}
}
