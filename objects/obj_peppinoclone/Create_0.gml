scr_initenemy()

cooldown = 0
hitboxID = -4
grav = 0.5
hsp = 0
vsp = 0
state = states.walk
stunned = 0
alarm[0] = 150
roaming = 1
collectdrop = 5
flying = 0
straightthrow = 0
cigar = 0
cigarcreate = 0
stomped = 0
shot = 0
reset = 0
flash = 0

landspr = spr_player_land
idlespr = spr_player_idle
fallspr = spr_player_fall
stunfallspr = spr_pepclone_stun
walkspr = spr_player_move
turnspr = spr_player_taunt
recoveryspr = spr_player_idle
grabbedspr = spr_pepclone_stun
scaredspr = spr_pepclone_stun
image_xscale = -1

hp = 1
slapped = 0

grounded = 1
birdcreated = 0
boundbox = 0
spr_dead = spr_pepclone_death
heavy = 0

depth = 0
if obj_player.character == "P"
{
	with obj_player
	{
		other.paletteselect = paletteselect
		other.spr_palette = spr_palette
	}
}
else
{
	spr_palette = spr_peppalette
	paletteselect = 1
}
surf = -4 // blah blah blah

grabbedby = 0
stuntouchbuffer = 0
scaredbuffer = 0
haspalette = true
targetplayer = instance_nearest(x, y, obj_player)
