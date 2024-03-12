with (other)
{
    x = (other.x + (other.sprite_width / 2))
    y = (other.y + (other.sprite_height - 46))
    if (!instance_exists(obj_fadeout))
    {
        .lastroom = room
        obj_player2.lastroom = room
        .targetDoor = other.targetDoor
        .targetRoom = other.targetRoom
        .verticalhallway = 1
        obj_player2.verticalhallway = 1
        .vhallwaydirection = other.image_yscale
        obj_player2.vhallwaydirection = other.image_yscale
        if instance_exists(obj_player2)
        {
            obj_player2.targetDoor = other.targetDoor
            obj_player2.targetRoom = other.targetRoom
        }
        other.visited = 1
        scr_soundeffect(sfx_door)
        instance_create(x, y, obj_fadeout)
    }
}
