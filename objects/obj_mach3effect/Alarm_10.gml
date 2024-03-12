/// @description sync
if (check_bysync() == 0 && sync == 0 && instance_number(object_index) < 100)
{
    gms_instance_sync_var_add("spr", sprite_index)
    gms_instance_sync_var_add("img", image_index)
    gms_instance_sync_var_add("xscale", image_xscale)
    gms_instance_sync_var_add("spr_palette", spr_palette)
    gms_instance_sync_var_add("paletteselect", paletteselect)
	gms_instance_sync_var_add("blend", image_blend)
	gms_instance_sync_var_add("tex", tex)
    gms_instance_sync(real(id), 9)
}