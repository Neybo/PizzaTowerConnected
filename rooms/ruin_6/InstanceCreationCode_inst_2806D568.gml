targetRoom = ruin_pizzamart
visible = false;

if FINAL_GAMEPLAY_ONLY && !global.snickchallenge
{
	var lay_id = get_layer("Assets_1");
	var s = layer_sprite_get_id(lay_id, "graphic_3C555227");
	layer_sprite_destroy(s);
	instance_destroy();
}

