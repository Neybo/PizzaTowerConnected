event_inherited();
if OLD_GAMEPLAY
{
	spr_intro = spr_toppinworm_run;
	spr_idle = spr_toppinworm;
	spr_run = spr_toppinworm_run;
	spr_panic = spr_toppinworm_run;
	spr_panicidle = spr_toppinworm;
}
else
{
	spr_intro = spr_toppinworm_intro_NEW;
	spr_idle = spr_toppinworm_NEW;
	spr_run = spr_toppinworm_run_NEW;
	spr_panic = spr_toppinworm_panicrun_NEW;
	spr_panicidle = spr_toppinworm_panic_NEW;
	spr_taunt = spr_toppinworm_taunt_NEW;
	yoffset = 0;
}

spr_intro_strongcold = spr_toppinworm_run;
spr_idle_strongcold = spr_toppinworm;
spr_run_strongcold = spr_toppinworm_run;
spr_panic_strongcold = spr_toppinworm_run;
spr_panicidle_strongcold = spr_toppinworm;
