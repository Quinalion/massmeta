/datum/dynamic_ruleset/midround/from_ghosts/sinfuldemon
	name = "Demon of Sin"
	midround_ruleset_style = MIDROUND_RULESET_STYLE_HEAVY
	antag_flag = ROLE_SINFULDEMON
	ruleset_category = parent_type::ruleset_category
	required_type = /mob/dead/observer
	required_candidates = 0
	weight = 5
	cost = 10
	minimum_players = 10
	var/spawncount = 2
	var/list/spawn_locs = list()

/datum/dynamic_ruleset/midround/from_ghosts/sinfuldemon/forget_startup()
	spawn_locs = list()
	return ..()

/datum/dynamic_ruleset/midround/from_ghosts/sinfuldemon/execute()
	for(var/obj/effect/landmark/latejoin/late_join in GLOB.landmarks_list)
		if(!isturf(late_join.loc))
			continue
		spawn_locs += late_join.loc
	if(!spawn_locs.len)
		message_admins("No valid spawn locations found, aborting...")
		return MAP_ERROR
	return ..()
