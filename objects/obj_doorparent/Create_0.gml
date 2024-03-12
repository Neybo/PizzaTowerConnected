door = "PARENT";
doCheck = !(instance_exists(obj_randomsecret) // dumbass,
            && object_index == obj_doorS 
            && string_contains(room_name, "secret"))