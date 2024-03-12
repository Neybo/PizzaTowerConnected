/// @description escape deactivate
if OLD_GAMEPLAY
{
	if !global.panic && (object_index == obj_minijohn or object_index == obj_babybear)
	{
		boundbox = false;
		instance_deactivate_object(id);
	}
}
else if escape
{
	var b = false
    with obj_escapespawn
    {
        if baddieID == other.id && state != 0
            b = true
    }
	
    if !b
    {
        instance_deactivate_object(id)
        with instance_create(x, y, obj_escapespawn)
            baddieID = other.id
    }
}
