if other.state == states.gameover or other.state == states.hitlag exit;

if other.character == "V" 
	global.playerhealth = clamp(global.playerhealth + 5, 0, 100)

global.collect += 25
global.combotime += clamp(global.combotime + 25, 0, 60)
if global.combotime > 60
	global.combotime = 60

with instance_create(x, y, obj_smallnumber)
	number = string(25)
scr_soundeffect(sfx_collecttopping)

create_collect(x, y, sprite_index == spr_pizzaslice ? spr_healthpickupeaten : sprite_index)
global.heattime = clamp(global.heattime + 25, 0, 60)

instance_destroy()
scr_failmod(mods.no_toppings);
