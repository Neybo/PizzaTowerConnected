ini_open("saveData" + string(global.saveslot) + ".ini")
if ini_read_real("UnlocksNEW", purchase, 0)
{
	instance_destroy()
}
ini_close()