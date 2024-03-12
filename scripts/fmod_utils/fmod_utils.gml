function fmod_set_loop(instName, loopState){
	return fmod_set_param_from_instance_immediately(instName, "looped", loopState)
}

function fmod_set_pitch(instName, pitch, instantly = true){
	if instantly
		return fmod_set_param_from_instance_immediately(instName, "pitch", pitch)
	else
		return fmod_set_param_from_instance(instName, "pitch", pitch)
}

function fmod_set_vol(instName, vol, instantly = true){
	if instantly
		return fmod_set_param_from_instance_immediately(instName, "volume", vol)
	else
		return fmod_set_param_from_instance(instName, "volume", vol)
}

function fmod_swap_audio(eventName, swapStruct)
{
	var ret_event = eventName
	var new_event = variable_struct_get(swapStruct, eventName)
	if new_event != undefined	
	{
		return new_event
	}
	else
	{
		return ret_event
	}
}

function fmod_swap_audio_pp(eventName, char)
{
	if char == "PP"
		return fmod_swap_audio(eventName, global.fmod_pp_replace)
	else
		return eventName
}