with (other)
{
    if (key_up && (state == (0 << 0) || state == (79 << 0) || state == (80 << 0) || state == (94 << 0) || state == (75 << 0)) && y == (other.y + 50) && (!instance_exists(obj_noisesatellite)) && (!instance_exists(obj_fadeout)) && state != (88 << 0) && state != (71 << 0))
    {
        lastroom_x = other.x
        lastroom_y = other.y
        lastroom = room
        obj_camera.chargecamera = 0
        ds_list_add(global.saveroom, id)
        .sprite_index = .spr_lookdoor
        .targetDoor = other.targetDoor
        .targetRoom = other.targetRoom
        .image_index = 0
        .state = (88 << 0)
        .mach2 = 0
        if instance_exists(obj_player2)
        {
            if (object_index == obj_player2)
            {
                .x = obj_player2.x
                .y = obj_player2.y
            }
            if (object_index == )
            {
                obj_player2.x = .x
                obj_player2.y = .y
            }
            obj_player2.sprite_index = obj_player2.spr_lookdoor
            obj_player2.targetDoor = other.targetDoor
            obj_player2.targetRoom = other.targetRoom
            obj_player2.image_index = 0
            obj_player2.state = (88 << 0)
            obj_player2.mach2 = 0
        }
        other.visited = 1
        instance_create(x, y, obj_fadeout)
    }
}
