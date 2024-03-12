//Kill
if instance_exists(baddieID) && baddieID.stun && (other.state == states.handstandjump or other.state == states.punch or other.instakillmove)
{
	with other
		scr_pummel();

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
