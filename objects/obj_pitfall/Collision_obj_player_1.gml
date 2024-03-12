with (other)
{
    x = other.x
    y = (other.y + (other.sprite_height - 46))
    if (!instance_exists(obj_fadeout))
    {
        .targetDoor = other.targetDoor
        .targetRoom = other.targetRoom
        if instance_exists(obj_player2)
        {
            if (object_index == obj_player2)
            {
                .x = obj_player2.x
                .y = obj_player2.y
                .state = (0 << 0)
            }
            if (object_index == )
            {
                obj_player2.x = .x
                obj_player2.y = .y
                obj_player2.state = (0 << 0)
            }
            obj_player2.targetDoor = other.targetDoor
            obj_player2.targetRoom = other.targetRoom
        }
        other.visited = 1
        image_index = 0
        if (state == (81 << 0))
            state = (0 << 0)
        instance_create(x, y, obj_fadeout)
    }
}
