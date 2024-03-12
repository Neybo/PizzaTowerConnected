event_inherited();

groundpound = false;
stunnable = false;
parryable = false;

grav = 0.5;
hsp = 0;
vsp = 0;
movespeed = 7
state = states.cherrywait
stunned = 0
alarm[0] = 150
roaming = true
collectdrop = 5
flying = false
straightthrow = false
cigar = false
cigarcreate = false
stomped = false
shot = false
thrown = false
reset = false
flash = false
landspr = spr_slimebounce
idlespr = spr_charcherry_wait
fallspr = spr_charcherry_run
stunfallspr = spr_charcherry_wait
walkspr = spr_charcherry_run
turnspr = spr_charcherry_run
recoveryspr = spr_charcherry_wait
grabbedspr = spr_charcherry_wait
scaredspr = spr_charcherry_wait
popoutspr = spr_charcherry_popout

if REMIX_GAMEPLAY
{
	fallspr = spr_charcherry_run_NEW
	walkspr = spr_charcherry_run_NEW
	turnspr = spr_charcherry_run_NEW
	popoutspr = spr_charcherry_popout_NEW
}

image_xscale = -1
hp = 1
slapped = false
grounded = true
birdcreated = false
boundbox = false
spr_dead = spr_charcherry_dead
heavy = false
depth = 0

paletteselect = 1
spr_palette = palette_cheeseslime

grabbedby = 0
momentum = 5

hitboxcreate = false
image_speed = 0.35
steppy = 0

stuntouchbuffer = 0
sugaryenemy = true;

