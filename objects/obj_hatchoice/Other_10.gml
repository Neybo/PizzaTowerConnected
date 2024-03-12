/// @description hats & reset choice
spr_idle = selarray[sel[0]][0];

ini_open("saveData" + string(global.saveslot) + ".ini")

if (sel[0] != 5)
	locked = !check_hat(sel[0]);
else
	locked = !ini_read_real("UnlocksNEW", "hat1", 0)
	
ini_close()


selmin = 0;
selmax = array_length(selarray) - 1;

