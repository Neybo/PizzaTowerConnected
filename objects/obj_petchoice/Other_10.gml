/// @description hats & reset choice
spr_idle = selarray[sel[0]][0];

locked = false;
ini_open("saveData" + string(global.saveslot) + ".ini")

if sel[0] == 6
	locked = !file_exists("mario_information");
else if sel[0] == 11
	locked = !ini_read_real("UnlocksNEW", "pet1", 0)
else if sel[0] == 12
	locked = !ini_read_real("UnlocksNEW", "pet2", 0)
else if sel[0] == 13
	locked = !ini_read_real("UnlocksNEW", "pet3", 0)
else if sel[0] == 14
	locked = !ini_read_real("UnlocksNEW", "pet4", 0)
else if sel[0] == 15
	locked = !ini_read_real("UnlocksNEW", "pet5", 0)
	
ini_close()

selmin = 0;
selmax = array_length(selarray) - 1;

