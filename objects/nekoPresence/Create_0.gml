/// @description Initialize Discord.
if instance_number(object_index) > 1 || !RPC_USED
{
	instance_destroy();
	exit;
}
global.discord_initialized = false;

