if instance_exists(baddieID)
    direction = angle_rotate(direction, point_direction(x, y, baddieID.x, baddieID.y), 2)
else
    baddieID = instance_nearest(x, y, obj_baddie)
image_angle = direction
