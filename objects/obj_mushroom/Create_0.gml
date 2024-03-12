image_speed = 0.35
depth = 10
spr_idle = spr_bigmushroom
spr_bounce = spr_bigmushroom_bounce

sugary = check_sugary()
if sugary
{
	spr_idle = spr_bigmarshmallow
	spr_bounce = spr_bigmarshmallow_bounce
}
sprite_index = spr_idle
