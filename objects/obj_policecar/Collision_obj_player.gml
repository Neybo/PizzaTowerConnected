if (state == states.policecartaxi)
    return;
with (obj_player)
{
    targetRoom = other.targetRoom
    lastroom = room
    targetDoor = other.targetDoor
    visible = false
    if (state != states.gotoplayer)
        state = states.policecartaxi
    cutscene = 1
    hsp = 0
    vsp = 0
}
grav = 0
state = states.policecartaxi
hsp = 10
image_xscale = 1
vsp = 0
