with obj_pizzacoinindicator	
	show = 50
with obj_player
{
	if key_up2 && scr_getcoin()
	{
		ini_open("saveData" + string(global.saveslot) + ".ini")
		ini_write_real("UnlocksNEW", "spentmoney", 
		ini_read_real("UnlocksNEW", "spentmoney", 0) - 100)
		obj_pigtotal.refresh()
		ini_open("saveData" + string(global.saveslot) + ".ini")
		scr_setcoin(scr_getcoin() - 1)
		if check_online()
			gms_ini_player_write("saveData", "pizzacoin", scr_getcoin());
		else
		{
			ini_write_real("online", "pizzacoin", scr_getcoin());
		}
		ini_close()
	}
}