sprite_index = spr_HUBelevator
depth = 99

state = 0;
categoryindex = 0;
checkroom = false;
categories = ["REPLICA TOWER", "OLD TOWER", "THE BASEMENT", "SUGARY SPIRE"]
hub_array = [];
hub_array_0 = [
	["STAFF ONLY", tower_5, "E"],
	["THE SLUM", tower_4, "E"],
	["ADVENTURE ISLAND", tower_3, "B"],
	["WESTERN DISTRICT", tower_2, "C"],
	["LOBBY", tower_1, "E"],
]

hub_array_1 = [
	["FLOOR 2", hub_room2, "A"],
	["FLOOR 1", hub_room1, "A"],
]

hub_array_2 = [
	["ARCADE", hub_arcade, "A"],
]

hub_array_3 = [
	//["FLOOR 2", rm_blank, "A"],
	["FLOOR 1", hub_roomSP, "A"],
]

targetDoor = "A";

if debug || (check_online() && gms_self_admin_rights() > 0)
	array_push(hub_array_1, ["TEST", rm_test, "A"]);
if room == hub_room1
	array_push(hub_array_1, ["TUTORIAL", PP_room1, "A"]);
if check_online() && global.pvp && room != hub_pvp
    array_push(hub_array_2, ["PVP ARENA", hub_pvp, "A"])
if check_online() && room != hub_race
	array_push(hub_array_2, ["RACE HUB", hub_race, "A"])
if check_online() && room != hub_outsideAFK
	array_push(hub_array_2, ["AFK HALL", hub_outsideAFK, "A"])

sel = 0;
//for(var i = 0; i < array_length(hub_array_0); i++)
//{
//	if room == hub_array_0[i][1]
//	{
//		sel = i;
//		break;
//	}
//}

stepsnd = fmod_create_instance(sfx_step)