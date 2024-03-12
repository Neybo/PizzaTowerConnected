if (state != states.policecartaxi)
    return;
if (!instance_exists(obj_fadeout))
{
    fmod_create_instance_one_shot(sfx_door)
    with (instance_create(x, y, obj_fadeout))
        roomreset = 1
}
