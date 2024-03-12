function secret_add(create_func, step_func)
{
    with obj_secretmanager
    {
        ds_list_add(secrettriggers, [step_func])
        if create_func != noone
			create_func()
    }
}

function secret_add_touchall(argument0, argument1, argument2)
{
    with obj_secretmanager
        ds_list_add(touchall, [argument0, argument1, argument2])
}

function secret_add_touchall_requirement(argument0, argument1) {
    touchrequirement[argument0] = [argument1, 0]
}

function secret_check_touchall() //gml_Script_secret_check_touchall
{
    if touchrequirement != noone && is_array(touchrequirement)
    {
        for (var xx = 0; xx < array_length(touchrequirement); xx++)
        {
            var t = 0
            for (var i = 0; i < ds_list_size(touchall); i++)
            {
                var b = ds_list_find_value(touchall, i)
                if b[1] == xx
                    t++
            }
            if t == touchrequirement[xx][0]
                touchrequirement[xx][1] = 1
        }
		
		var b = true;
        for(var i = 0; i < array_length(touchrequirement); i++)
		{
			if !touchrequirement[i][1]
            {
                b = false
                break
            }
		}
        if b
            return true;
    }
    return false;
}

function secret_check_trigger(portal_trigger) //gml_Script_secret_check_trigger
{
    var _found = false
    with obj_secrettrigger
    {
        if trigger == portal_trigger && active
            _found = true
    }
    return _found;
}

function secret_open_portal(portal_trigger) //gml_Script_secret_open_portal
{
    with obj_secretportal
    {
        if trigger == portal_trigger && ds_list_find_index(global.saveroom, id) == -1
		&& !place_meeting(x, y, obj_marbleblock) && !place_meeting(x, y, obj_secretblock)
		&& !place_meeting(x, y, obj_secretbigblock) && !place_meeting(x, y, obj_secretmetalblock)
		&& !place_meeting(x, y, obj_secretdestroyable)
            active = true
    }
}

function secret_close_portal(portal_trigger, quick = false) //gml_Script_secret_close_portal
{
    with obj_secretportal
    {
        if trigger == portal_trigger && sprite_index != spr_secretportal_close
        {
            sprite_index = spr_secretportal_close
            if !quick
                image_index = 0
            else
                image_index = 14
            active = false
        }
    }
}

function secret_close_portalID(ID) //gml_Script_secret_close_portalID
{
    with ID
    {
        sprite_index = spr_secretportal_close
        image_index = 14
        active = false
    }
}
