writer++;
if writer < string_length(dialogue[curdiag])
{
	var cur_l = string_char_at(dialogue[curdiag], writer);
	
	if cur_l == "\n" or cur_l == " " or cur_l == ","
	or cur_l == "." or cur_l == "?" or cur_l == "!"
	or cur_l == ":" or cur_l == "\"" or cur_l == "'"
		exit;
	
	// pause text (format: ^1, ^2, etc.)
	if cur_l == "^"
	{
		var stop = string_char_at(dialogue[curdiag], writer + 1);
		if string_isnumber(stop)
		{
			writer++;
			alarm[0] = real(stop) * 6;
			exit;
		}
	}
	
	// modifier
	if cur_l == "\\"
	{
		writer++;
		writer++;
		exit;
	}
	
	if is_array(diagsound)
	{
		fmod_stop_instance_immediately(diagsnd);
		diagsnd = scr_soundeffect(diagsound[irandom(array_length(diagsound) - 1)]);
	}
	else
	{
		fmod_stop_instance_immediately(diagsnd);
		diagsnd = scr_soundeffect(diagsound);
	}
}
