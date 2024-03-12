scr_playerreset();
obj_player.state = states.normal
obj_player.targetDoor = "A"
room_goto(hub_room1);
instance_destroy();