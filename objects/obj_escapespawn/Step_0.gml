switch state
{
    case 0:
        if !global.panic
        {
            visible = false
            instance_deactivate_object(baddieID)
            with obj_baddiecollisionbox
            {
                if baddieID == other.baddieID
                    instance_destroy()
            }
        }
        else
            state = 1
        break
	
    case 1:
        var p = instance_nearest(x, y, obj_player)
        visible = false
        image_index = 0
        if p == -4 || number_in_range(p.x, x - 500, x + 500) && number_in_range(p.y, y - 100, y + 100)
        {
            state = 2
            visible = true
        }
        break
	
    case 2:
        if floor(image_index) > 5
        {
			if (baddieID == -4)
				return;
            instance_activate_object(baddieID)
            with baddieID
            {
                x = other.x
                y = other.y
                state = states.stun
                sprite_index = stunfallspr
                stunned = 20
                boundbox = false
                instance_create(x, y, obj_genericpoofeffect)
				
				if other.sugary
				{
					xscale = 1.2
					yscale = 1.2
				}
            }
            state = 3
        }
        break
    case 3:
        if floor(image_index) == image_number - 1
            visible = false
        break
}
