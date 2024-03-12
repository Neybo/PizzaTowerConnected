application_surface_draw_enable(true)

with obj_drpc_updater
{
	running = false;

	np_clearpresence();
	instance_destroy(nekoPresence);
}

instance_destroy(obj_tv)
instance_destroy(obj_parallax)
instance_deactivate_object(obj_inputdisplay)
instance_deactivate_object(obj_gms)
instance_deactivate_object(obj_pause)
instance_deactivate_object(obj_global)
instance_destroy(obj_camera)
instance_destroy(obj_player)
fmod_stop_all()