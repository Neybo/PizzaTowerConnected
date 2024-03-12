if check_online() && gms_self_admin_rights() > 0
	gms_p2p_send(p2p.pvp_punch, other.player_id)
