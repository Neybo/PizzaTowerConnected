event_inherited();
landspr = spr_gumslime_walk
idlespr = spr_gumslime_idle
fallspr = spr_gumslime_walk
stunfallspr = spr_gumslime_stunned
walkspr = spr_gumslime_walk
turnspr = spr_gumslime_walk
recoveryspr = spr_gumslime_stunned
grabbedspr = spr_gumslime_stunned
scaredspr = spr_gumslime_scared
spr_dead = spr_gumslime_dead

if FINAL_GAMEPLAY
{
	idlespr = spr_gumslime_idle_NEW
	walkspr = spr_gumslime_walk_NEW
	grabbedspr = spr_gumslime_stunned_NEW
	stunfallspr = spr_gumslime_stunned_NEW
	scaredspr = spr_gumslime_scared_NEW
	spr_dead = spr_gumslime_dead_NEW
}
else
	movespeed = 2

sprite_index = walkspr
sugaryenemy = true

