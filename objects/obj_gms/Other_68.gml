// show_debug_message("obj_gms - Async Networking"); prevent console flooding
if async_load[?"id"] == global.__socket
{
	switch async_load[?"type"]
	{
		case network_type_data:
			global.__socket_connected = true;
			global.__socket_connecting = false;
			var buffersize = max(0, async_load[?"size"]) + max(0, buffer_tell(global._rr));
			
			if buffer_get_size(global._rr) <= buffersize
			{
				var newsize = ceil((buffersize + 1) / 2048) * 2048
				buffer_resize(global._rr, newsize);
			}
			
			buffer_copy(async_load[?"buffer"], 0, async_load[?"size"], global._rr, buffer_tell(global._rr));
			buffer_seek(global._rr, buffer_seek_start, buffersize);
			break;
	}
}

loadsave = true;

