// clean ups prevent memory leaks
ds_list_destroy(tvprompts_list);

surf_free(promptsurface)
surf_free(popsurf)
surf_free(surf)
surf_free(bar_surface)