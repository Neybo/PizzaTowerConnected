/// @description attempt reconnect
if debug
	exit;

if gms_info_isconnected()
{
	// already done on player alarm 11
	disconnected = false;
}
else
{
	gms_connect();
	if global.__socket_connecting
		disconnected = !gms_info_isconnected();
	else
	{
		instance_destroy(obj_pause);
		instance_activate_all();
		
		gms_logout();
		alarm[4] = 1;
		
		exit;
	}
}
alarm[1] = 60;