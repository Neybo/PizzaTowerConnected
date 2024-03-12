image_speed = 0.35
depth = 4

spr_woke = spr_minipillarwoke
spr_sleep = spr_minipillarsleep

x = -10000
y = -10000

if check_sugary()
{
	spr_woke = spr_minipillarwoke_ss
	spr_sleep = spr_minipillarsleep_ss
	if OLD_GAMEPLAY
	{
		spr_woke = spr_minipillarwokeOLD_ss
		spr_sleep = spr_minipillarsleepOLD_ss
	}
}
