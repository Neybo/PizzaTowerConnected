event_inherited();

grav = 0;
hsp = 0;
vsp = 0;

state = states.walk
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
hp = 1
hitboxcreate = false
grounded = false

idlespr = spr_ancho
stunfallspr = spr_anchobounce
walkspr = spr_ancho
grabbedspr = spr_ancho_grabbed
scaredspr = spr_ancho_scared
spr_chargestart = spr_ancho_chargestart
spr_charge = spr_ancho_charge

spr_rage1 = spr_ancho_rage1
spr_rage2 = spr_ancho_rage2
spr_rage3 = spr_ancho_rage3

image_xscale = -1
flash = false
slapped = false
birdcreated = false
boundbox = false
spr_dead =  spr_anchodead
heavy = false
depth = 0

stuck = false

grabbedby = 0
stuntouchbuffer = 0

if global.snickrematch
{
	idlespr = spr_ancho_re
	stunfallspr = spr_anchobounce_re
	walkspr = spr_ancho_re
	grabbedspr = spr_ancho_grabbed_re
	scaredspr = spr_anchobounce_re
	spr_dead = spr_anchodead_re
	
	spr_rage1 = spr_ancho_rage1_re
	spr_rage2 = spr_ancho_rage2_re
	spr_rage3 = spr_ancho_rage3_re
	
	spr_chargestart = spr_ancho_chargestart_re
	spr_charge = spr_ancho_charge_re
	sprite_index = walkspr;
}