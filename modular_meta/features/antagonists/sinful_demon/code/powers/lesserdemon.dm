/mob/living/simple_animal/lesserdemon
	name = "demon"
	real_name = "demon"
	desc = "A large, menacing creature covered in armored red scales."
	speak_emote = list("cackles")
	emote_hear = list("cackles","screeches")
	response_help  = "thinks better of touching"
	response_disarm = "flails at"
	response_harm   = "punches"
	icon = 'modular_meta/features/antagonists/icons/sinful_demon/mob.dmi'
	icon_state = "lesserdaemon"
	icon_living = "lesserdaemon"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	speed = 0.25
	combat_mode = TRUE
	stop_automated_movement = 1
	status_flags = CANPUSH
	attack_sound = 'sound/magic/demon_attack1.ogg'
	deathsound = 'sound/magic/demon_dies.ogg'
	deathmessage = "wails in anger and fear as it collapses in defeat!"
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 250 //Weak to cold
	maxbodytemp = INFINITY
	faction = list("hell")
	attacktext = "wildly tears into"
	maxHealth = 200
	health = 200
	environment_smash = ENVIRONMENT_SMASH_STRUCTURES
	obj_damage = 40
	melee_damage_lower = 20
	melee_damage_upper = 20
	wound_bonus = -15
	lighting_cutoff_red = 22
	lighting_cutoff_green = 5
	lighting_cutoff_blue = 5
	loot = (/obj/effect/decal/cleanable/blood)
	del_on_death = TRUE

/mob/living/simple_animal/lesserdemon/attackby(obj/item/W, mob/living/caster, params)
	. = ..()
	if(istype(W, /obj/item/nullrod))
		visible_message(span_warning("[src] screams in unholy pain from the blow!"), \
						span_cult("As \the [W] hits you, you feel holy power blast through your form, tearing it apart!"))
		adjustBruteLoss(22) //22 extra damage from the nullrod while in your true form. On average this means 40 damage is taken now.

/mob/living/simple_animal/lesserdemon/UnarmedAttack(mob/living/L, proximity)//10 hp healed from landing a hit.
	if(isliving(L))
		if(L.stat != DEAD && !L.can_block_magic(MAGIC_RESISTANCE_HOLY|MAGIC_RESISTANCE_MIND)) //demons do not gain succor from the dead or holy
			adjustHealth(-maxHealth * 0.05)
	return ..()

/mob/living/simple_animal/lesserdemon/Life(seconds_per_tick = SSMOBS_DT, times_fired)
	. = ..()
	if(!src)
		return
	if(istype(get_area(src.loc), /area/chapel)) //being a non-carbon will not save you!
		if(src.stat != DEAD) //being dead, however, will save you
			src.visible_message(span_warning("[src] begins to melt apart!"), span_danger("Your very soul melts from the holy room!"), "You hear sizzling.")
			adjustHealth(20) //20 damage every ~2 seconds. About 20 seconds for a full HP demon to melt apart in the chapel.

/mob/living/simple_animal/lesserdemon/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/life_draining, damage_overtime = 2)
