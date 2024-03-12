event_inherited();
if OLD_GAMEPLAY
{
	spr_intro = spr_toppincandy_run;
	spr_idle = spr_toppincandy;
	spr_run = spr_toppincandy_run;
	spr_panic = spr_toppincandy_run;
	spr_panicidle = spr_toppincandy;
}
else
{
	spr_intro = spr_toppincandy_intro_NEW;
	spr_idle = spr_toppincandy_NEW;
	spr_run = spr_toppincandy_run_NEW;
	spr_panic = spr_toppincandy_panicrun_NEW;
	spr_panicidle = spr_toppincandy_panic_NEW;
	spr_taunt = spr_toppincandy_taunt_NEW;
	yoffset = 0;
}
spr_intro_strongcold = spr_toppincandy_run;
spr_idle_strongcold = spr_toppincandy;
spr_run_strongcold = spr_toppincandy_run;
spr_panic_strongcold = spr_toppincandy_run;
spr_panicidle_strongcold = spr_toppincandy;
