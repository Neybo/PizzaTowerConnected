var roomname = room_get_name(room);
secretgot = string_contains(roomname, "secret") || instance_exists(obj_randomsecret)

if !secretgot
	return;
	
var sg = check_sugary();

global.secretfound++
	
if !sg
{
	var outof = scr_secretsoutof()
}
	
with obj_tv	
{
	if sg
		message = "You have found a secret!";
	else
		message = "You have found " + string(global.secretfound) + " secret" + (global.secretfound == 1 ? "" : "s") + " out of " + string(outof) + "!";

	showtext = true
	alarm[2] = 150
}

scr_soundeffect(sg ? sfx_secretfound_ss : sfx_secretfound)