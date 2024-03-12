if !released
{
    if inst != noone && !instance_exists(inst)
        inst = noone
    with (obj_baddie)
    {
        if (state == states.grabbed || state == states.hit)
        {
            other.grabbedby = grabbedby
            other.released = true
            other.image_speed = 0.35
            other.image_index = 0
        }
    }
}
else if floor(image_index) == 3 && !instance_exists(inst)
{
    inst = instance_create(x, (y + 13), obj_policecar)
    inst.targetplayer = obj_player
    inst.targetRoom = targetRoom
    inst.targetDoor = targetDoor
}
