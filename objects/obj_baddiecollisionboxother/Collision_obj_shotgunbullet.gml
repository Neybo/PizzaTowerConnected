//Kill
if instance_exists(baddieID)
{
	scr_soundeffect(sfx_killenemy)
	if OLD_GAMEPLAY
		scr_sleep(50)
	
	repeat 3
		instance_create(x, y, obj_slapstar)
	repeat 3
		create_particle(x, y, particles.baddiegibs)
	instance_create(x, y, obj_bangeffect)
	
	instance_destroy(baddieID)
	instance_destroy()
}
