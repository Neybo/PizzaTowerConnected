event_inherited();
if OLD_GAMEPLAY
{
	spr_intro = spr_toppinshroom_intro;
	spr_idle = spr_toppinshroom;
	spr_run = spr_toppinshroom_run;
	spr_panic = spr_toppinshroom_panic;
	spr_panicidle = spr_toppinshroom_panicidle;
	
	spr_intro_strongcold = spr_xmasshroomtoppin_intro;
	spr_idle_strongcold = spr_xmasshroomtoppin_idle;
	spr_run_strongcold = spr_xmasshroomtoppin_walk;
	spr_panic_strongcold = spr_xmasshroomtoppin_panic;
	spr_panicidle_strongcold = spr_xmasshroomtoppin_panicidle;
}
else
{
	spr_intro = spr_toppinshroom_intro_NEW;
	spr_idle = spr_toppinshroom_NEW;
	spr_run = spr_toppinshroom_run_NEW;
	spr_panic = spr_toppinshroom_run_NEW;
	spr_panicidle = spr_toppinshroom_panic_NEW;
	
	spr_intro_strongcold = spr_xmastoppinshroom_intro_NEW;
	spr_idle_strongcold = spr_xmastoppinshroom_NEW;
	spr_run_strongcold = spr_xmastoppinshroom_run_NEW;
	spr_panic_strongcold = spr_xmastoppinshroom_run_NEW;
	spr_panicidle_strongcold = spr_xmastoppinshroom_panic_NEW;
	
	yoffset = 0;
}
