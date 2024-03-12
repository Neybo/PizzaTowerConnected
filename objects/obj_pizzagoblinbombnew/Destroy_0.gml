if (destroy)
{
	with (instance_create(x, y, obj_bombexplosionnew))
	{
		rat = other.grabbable;
		baddie = other.baddie;
	}
}
fmod_release_instance(snd)
