if (sprite_index == spr_bulletHUD && global.bullet < 3)
{
    global.bullet += 1
    with (obj_tv)
    {
        sprite = 2031
        alarm[0] = 50
        image_speed = 0.35
    }
    with (instance_create(x, y, obj_smallletters))
        letters = "BULLET"
    instance_destroy()
}
if (sprite_index == spr_fuelHUD && global.fuel < 3)
{
    global.fuel += 1
    with (obj_tv)
    {
        sprite = 932
        alarm[0] = 50
        image_speed = 0.35
    }
    with (instance_create(x, y, obj_smallletters))
        letters = "FUEL"
    instance_destroy()
}
