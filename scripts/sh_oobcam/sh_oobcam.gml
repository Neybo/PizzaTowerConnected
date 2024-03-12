function sh_oobcam()
{
	if !WC_debug
		return "You do not have permission to use this command";
	WC_oobcam = !WC_oobcam;
	if !isOpen
	{
		with obj_tv
		{
			showtext = true;
			alarm[0] = 100;
			message = "LIMITLESS CAMERA " + (other.WC_oobcam ? lang_str("options.on") : lang_str("options.off"));
		}
	}
	else
		return "Limitless camera " + (WC_oobcam ? lang_str("options.on") : lang_str("options.off"));
}
function meta_oobcam()
{
	return {
		description: "toggles the limitless camera",
	}
}
