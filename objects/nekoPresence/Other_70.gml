/// @description Capture async events from NekoPresence.
var ev_type = async_load[? "event_type"];

if ev_type == "DiscordReady"
{
	global.discord_initialized = true;
	ready = true;
	
	// just in case :)
	global.hiloypoll = async_load[? "user_id"] //hi loypoll
	if !global.richpresence
	{
		instance_destroy();
		exit;
	}

	// create
	//rousr_dissonance_set_large_image("runner_icon");
	np_setpresence_buttons(0, "Join PTC", "https://discord.gg/nftWvCpexq")
	np_setpresence_more("", "", false);
	np_setpresence("", "", obj_drpc_updater.large, "");
}
