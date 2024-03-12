alarm[0] = -1
if instance_exists(player) && player.character == "SP"
	sugary = true;
if instance_exists(player) && player.character == "PP"
	pissino = true;
gms_instance_sync_var_add("sugary", sugary);
gms_instance_sync_var_add("pissino", pissino);
gms_instance_sync(real(id), is_onetime | isc_local);

