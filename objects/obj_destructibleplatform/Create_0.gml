falling = false
reset = 100
image_speed = 0.35
depth = 50

spr_idle = spr_cheeseblock;
spr_dissolve = spr_cheeseblockdissolve;
spr_dead = -1;
spr_reform = spr_cheeseblockreform;
if FINAL_GAMEPLAY
{
	spr_idle = spr_cheeseblock_NEW;
	spr_dissolve = spr_cheeseblock_dissolve;
	spr_dead = spr_cheeseblock_falling;
	spr_reform = spr_cheeseblock_reform;
}
sugary = check_sugary();
if sugary
{
	spr_idle = spr_caramelblock_idle;
	spr_dissolve = spr_caramelblock_dissolve;
	spr_dead = spr_caramelblock_dead;
	spr_reform = spr_caramelblock_reform;
}

sprite_index = spr_idle;

