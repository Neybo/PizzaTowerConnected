if performance_destroy()
	exit;

image_speed = 0.35

if !check_online()
	exit;

if check_bysync() == false
	gms_instance_sync(real(id), is_onetime | isc_local);
