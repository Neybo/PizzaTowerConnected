event_inherited();

substate = states.walk
substate_max = 3 * room_speed
substate_buffer = substate_max
hitboxcreate = false
shot = 0

grav = 0.5;
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
flash = false

landspr = spr_pizzaslug_walk
idlespr = spr_pizzaslug_idle
fallspr = spr_pizzaslug_walk
stunfallspr = spr_pizzaslug_stun
walkspr = spr_pizzaslug_walk
turnspr = spr_pizzaslug_turn
recoveryspr = spr_pizzaslug_stun
grabbedspr = spr_pizzaslug_stun
scaredspr = spr_pizzaslug_scared

image_xscale = -1
hp = 1
slapped = false
grounded = true
birdcreated = false
boundbox = false
spr_dead = spr_pizzaslug_dead

heavy = false
depth = 0

paletteselect = 0
spr_palette = palette_cheeseslime

grabbedby = 0
stuntouchbuffer = 0
scaredbuffer = 0
