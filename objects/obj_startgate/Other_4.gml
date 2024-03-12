/// @description pigtotal, level name
/*ini_open("saveData" + string(global.saveslot) + ".ini");
global.pigtotal += ini_read_real("Highscore", string(level), 0);
ini_close();*/

// lname
var _msg = lang_string("msg.level." + level);
if !string_startswith(_msg, "msg.level.")
	msg = _msg;

// fix the level fucker
oglevel = level // global.leveltosave, oops! :3

if !global.panic && string_startswith(room_get_name(room), "tower_") && room != tower_entrancehall
{
	with instance_create(x - 96 * image_xscale, y + 96 * image_yscale, obj_ranksign)
	{
		levelsign = other.level
	}
}

if !computer && ((image_xscale != 1 || image_yscale != 1) || OLD_GAMEPLAY)
{
	computer = 2
	if FINAL_GAMEPLAY
		sprite_index = spr_entrancegate_NEW;
	else
		sprite_index = spr_entrancegate
	if check_sugary()
		sprite_index = spr_entrancegate_ss;
}

if !computer
{
	scr_hub_bg_init()
	scr_hub_bg_reinit(x, y)
}
