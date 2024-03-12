// THIS IS SO SOME FUNCTIONS GIVE BETTER VALUES ETC
// AND FOR CUSTOM FUNCTIONS IF WE WANT
global.FMODGMS_INST_CREATED_COUNT = 0

function fmod_create_instance(eventName)
{
	randomize()
	var trueName = eventName + "-" + string(global.FMODGMS_INST_CREATED_COUNT++) + "-" + string(irandom(9))
 	if fmod_create_instance_named(eventName, trueName) == FMOD_RESULT.FMOD_OK
		return trueName
	return eventName
}

function fmod_is_instance_playing(instName)
{
	if instName == FMOD_EMPTY
		return false
	else
		return _fmod_is_instance_playing(instName)
}