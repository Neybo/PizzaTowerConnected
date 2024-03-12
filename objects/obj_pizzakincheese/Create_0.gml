event_inherited();
if OLD_GAMEPLAY
{
	spr_intro = spr_toppincheese_intro;
	spr_idle = spr_toppincheese;
	spr_run = spr_toppincheese_run;
	spr_panic = spr_toppincheese_panic;
	spr_panicidle = spr_toppincheese_panicidle;
	
	spr_intro_strongcold = spr_xmascheesetoppin_intro;
	spr_idle_strongcold = spr_xmascheesetoppin_idle;
	spr_run_strongcold = spr_xmascheesetoppin_walk;
	spr_panic_strongcold = spr_xmascheesetoppin_panic;
	spr_panicidle_strongcold = spr_xmascheesetoppin_panicidle;
}
else
{
	spr_intro = spr_toppincheese_intro_NEW;
	spr_idle = spr_toppincheese_NEW;
	spr_run = spr_toppincheese_run_NEW;
	spr_panic = spr_toppincheese_run_NEW;
	spr_panicidle = spr_toppincheese_panic_NEW;
	
	spr_intro_strongcold = spr_xmastoppincheese_intro_NEW;
	spr_idle_strongcold = spr_xmastoppincheese_NEW;
	spr_run_strongcold = spr_xmastoppincheese_run_NEW;
	spr_panic_strongcold = spr_xmastoppincheese_run_NEW;
	spr_panicidle_strongcold = spr_xmastoppincheese_panic_NEW;
	
	yoffset = 0;
}
