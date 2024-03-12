if trigger == false
	exit;

if is_method(func)
{
	var t = trigger;
	if is_method(trigger)
		var t = trigger();
	
	if t == true
		func();
	else if t != false // neither true nor false somehow?
		func(t);
}
else
{
	trace("Invalid method in obj_eventtrigger in room " + room_get_name(room));
	instance_destroy();
}

