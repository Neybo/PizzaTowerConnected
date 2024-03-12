event_inherited();
if OLD_GAMEPLAY
{
	spr_intro = spr_toppinchoco_run;
	spr_idle = spr_toppinchoco;
	spr_run = spr_toppinchoco_run;
	spr_panic = spr_toppinchoco_run;
	spr_panicidle = spr_toppinchoco;
}
else
{
	spr_intro = spr_toppinchoco_intro_NEW;
	spr_idle = spr_toppinchoco_NEW;
	spr_run = spr_toppinchoco_run_NEW;
	spr_panic = spr_toppinchoco_panicrun_NEW;
	spr_panicidle = spr_toppinchoco_panic_NEW;
	spr_taunt = spr_toppinchoco_taunt_NEW;
	yoffset = 0;
}

spr_intro_strongcold = spr_toppinchoco_run;
spr_idle_strongcold = spr_toppinchoco;
spr_run_strongcold = spr_toppinchoco_run;
spr_panic_strongcold = spr_toppinchoco_run;
spr_panicidle_strongcold = spr_toppinchoco;
