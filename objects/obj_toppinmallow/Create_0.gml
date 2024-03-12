event_inherited();
if OLD_GAMEPLAY
{
	spr_intro = spr_toppinmallow_run;
	spr_idle = spr_toppinmallow;
	spr_run = spr_toppinmallow_run;
	spr_panic = spr_toppinmallow_run;
	spr_panicidle = spr_toppinmallow;
}
else
{
	spr_intro = spr_toppinmallow_intro_NEW;
	spr_idle = spr_toppinmallow_NEW;
	spr_run = spr_toppinmallow_run_NEW;
	spr_panic = spr_toppinmallow_panicrun_NEW;
	spr_panicidle = spr_toppinmallow_panic_NEW;
	spr_taunt = spr_toppinmallow_taunt_NEW;
	yoffset = 0;
}

spr_intro_strongcold = spr_toppinmallow_run;
spr_idle_strongcold = spr_toppinmallow;
spr_run_strongcold = spr_toppinmallow_run;
spr_panic_strongcold = spr_toppinmallow_run;
spr_panicidle_strongcold = spr_toppinmallow;

