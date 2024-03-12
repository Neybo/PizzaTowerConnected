event_inherited();
if OLD_GAMEPLAY
{
	spr_intro = spr_toppincrack_run;
	spr_idle = spr_toppincrack;
	spr_run = spr_toppincrack_run;
	spr_panic = spr_toppincrack_run;
	spr_panicidle = spr_toppincrack;
}
else
{
	spr_intro = spr_toppincrack_intro_NEW;
	spr_idle = spr_toppincrack_NEW;
	spr_run = spr_toppincrack_run_NEW;
	spr_panic = spr_toppincrack_panicrun_NEW;
	spr_panicidle = spr_toppincrack_panic_NEW;
	spr_taunt = spr_toppincrack_taunt_NEW;
	yoffset = 0;
}

spr_intro_strongcold = spr_toppincrack_run;
spr_idle_strongcold = spr_toppincrack;
spr_run_strongcold = spr_toppincrack_run;
spr_panic_strongcold = spr_toppincrack_run;
spr_panicidle_strongcold = spr_toppincrack;
