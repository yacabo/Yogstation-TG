/client
	show_popup_menus = FALSE // THIS DISABLES THE NATIVE BYOND RIGHT-CLICK MENU WHICH OPENS THE MENU WITH ALL THE VERBS. THAT MENU WAS REPLACED BY THE RADIAL MENU. THIS SHOULD ONLY EVER BE ENABLED FOR DEBUG PURPOSES, AND EVEN THEN SHIT MIGHT BREAK
	var/connection_number = 0
	var/last_ping_time = 0 // Stores the last time this cilent pinged someone in OOC, to protect against spamming pings

	var/list/afreeze_stored_verbs = list()