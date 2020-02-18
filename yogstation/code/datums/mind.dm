/datum/mind
	var/quiet_round = FALSE //Won't be picked as target in most cases
	var/accent_name = null // The name of the accent this guy has. NULL implies no accent


/datum/mind/proc/vampire_hook()
	var/text = "vampire"
	if(SSticker.mode.config_tag == "vampire")
		text = uppertext(text)
	text = "<i><b>[text]</b></i>: "
	if(is_vampire(current))
		text += "<b>VAMPIRE</b> | <a href='?src=\ref[src];vampire=clear'>human</a> | <a href='?src=\ref[src];vampire=full'>full-power</a>"
	else
		text += "<a href='?src=\ref[src];vampire=vampire'>vampire</a> | <b>HUMAN</b> | <a href='?src=\ref[src];vampire=full'>full-power</a>"
	if(current && current.client && (ROLE_VAMPIRE in current.client.prefs.be_special))
		text += " | Enabled in Prefs"
	else
		text += " | Disabled in Prefs"
	return text

/datum/mind/proc/vampire_href(href, mob/M)
	switch(href)
		if("clear")
			remove_vampire(current)
			message_admins("[key_name_admin(usr)] has de-vampired [current].")
			log_admin("[key_name(usr)] has de-vampired [current].")
		if("vampire")
			if(!is_vampire(current))
				message_admins("[key_name_admin(usr)] has vampired [current].")
				log_admin("[key_name(usr)] has vampired [current].")
				add_vampire(current)
			else
				to_chat(usr, "<span class='warning'>[current] is already a vampire!</span>")
		if("full")
			message_admins("[key_name_admin(usr)] has full-vampired [current].")
			log_admin("[key_name(usr)] has full-vampired [current].")
			if(!is_vampire(current))
				add_vampire(current)
				var/datum/antagonist/vampire/V = has_antag_datum(ANTAG_DATUM_VAMPIRE)
				if(V)
					V.total_blood = 1500
					V.usable_blood = 1500
					V.check_vampire_upgrade()
			else
				var/datum/antagonist/vampire/V = has_antag_datum(ANTAG_DATUM_VAMPIRE)
				if(V)
					V.total_blood = 1500
					V.usable_blood = 1500
					V.check_vampire_upgrade()

/datum/mind/proc/handle_speech(datum/source, mob/speech_args)
	if(accent_name)
		var/message = speech_args[SPEECH_MESSAGE]
		if(message[1] != "*")
			message = " [message]"
			var/list/accent_words = strings(GLOB.accents[accent_name], accent_name, directory = "strings/accents")
			for(var/key in accent_words)
				var/value = accent_words[key]
				if(islist(value))
					value = pick(value)
				message = replacetextEx(message, " [uppertext(key)]", " [uppertext(value)]")
				message = replacetextEx(message, " [capitalize(key)]", " [capitalize(value)]")
				message = replacetextEx(message, " [key]", " [value]")
		speech_args[SPEECH_MESSAGE] = trim(message)
