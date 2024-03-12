event_inherited()
image_speed = 0.35
depth = 2
song = FMOD_EMPTY;

spr_idle = spr_hungrypillar;
spr_angry = spr_hungrypillar_angry;
spr_happy = spr_hungrypillar_happy;
spr_dead = spr_hungrypillar_dead;

if FINAL_GAMEPLAY
{
	if check_sugary()
	{
		spr_idle = spr_hungrypillar_ss;
		spr_angry = spr_hungrypillar_ss;
		spr_happy = spr_hungrypillar_ss;
		spr_dead = spr_hungrypillardead_ss;
	}
	else
	{
		spr_idle = spr_hungrypillar_NEW;
		spr_angry = REMIX_GAMEPLAY ? spr_hungrypillar_angry_NEW : spr_hungrypillar_NEW;
		spr_happy = spr_hungrypillar_NEW;
		spr_dead = spr_hungrypillar_dead_NEW;
	}
}
else if check_sugary()
{
	spr_idle = spr_hungrypillarOLD_ss;
	spr_angry = spr_hungrypillarOLD_ss;
	spr_happy = spr_hungrypillarOLD_ss;
	spr_dead = spr_hungrypillardeadOLD_ss;
}

if global.snickrematch
{
	spr_idle = spr_hungrypillar_re;
	spr_angry = spr_hungrypillar_re;
	spr_happy = spr_hungrypillar_re;
	spr_dead = spr_hungrypillar_dead_re;
}
sprite_index = spr_idle;
