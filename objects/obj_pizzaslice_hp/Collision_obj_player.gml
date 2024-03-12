
if (global.hp < 8 && global.hp > 0)
{
global.hp += 1

with instance_create(x, y, obj_smallnumber)
	number = "+1"
scr_soundeffect(sfx_collecttopping)

create_collect(x, y, spr_healthpickupeaten )

instance_destroy()
}