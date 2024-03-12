 sprite_index = spr_HUBelevator
depth = 99

state = 0;
categories = ["OLD TOWER", "REPLICA TOWER", "THE BASEMENT", "SUGARY SPIRE"]
hub_array = [
	["SUGARY", hub_roomSP],
	["FLOOR 2", hub_room2],
	["FLOOR 1", hub_room1],
	["ARCADE", hub_arcade],
]

repl_array = [ //replit no way!!!
	//["THE TRUE TOP", tba],
	//["REWIND", tba],
	//["TOP?", tba],
	["STAFF ONLY", tower_5],
	["THE SLUM", tower_4],
	["ADVENTURE ISLAND", tower_3],
	["WESTERN DISTRICT", tower_2],
	["LOBBY", tower_1],
]

sugary_array = [
	//["FLOOR 2", tba],
	["FLOOR 1", hub_roomSP],
]

targetDoor = "A";

if debug || (check_online() && gms_self_admin_rights() > 0)
	array_push(hub_array, ["TEST", rm_test]);
if room == hub_room1
	array_push(hub_array, ["TUTORIAL", PP_room1]);
if check_online() && global.pvp && room != hub_pvp
    array_push(hub_array, ["PVP ARENA", hub_pvp])
if check_online() && room != hub_race
	array_push(hub_array, ["RACE HUB", hub_race])
if check_online() && room != hub_outsideAFK
	array_push(hub_array, ["AFK HALL", hub_outsideAFK])

sel = 0;
for(var i = 0; i < array_length(hub_array); i++)
{
	if room == hub_array[i][1]
	{
		sel = i;
		break;
	}
}

stepsnd = fmod_create_instance(sfx_step)
