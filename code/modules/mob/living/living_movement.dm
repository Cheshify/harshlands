/mob/living/Moved()
	. = ..()
	update_turf_movespeed(loc)


/mob/living/CanAllowThrough(atom/movable/mover, border_dir)
	. = ..()
	if(.)
		return
	if(mover.throwing)
		return (!density || (body_position == LYING_DOWN) || (mover.throwing.thrower == src && !ismob(mover)))
	if(buckled == mover)
		return TRUE
	if(ismob(mover) && (mover in buckled_mobs))
		return TRUE
	return !mover.density || body_position == LYING_DOWN

/mob/living/toggle_move_intent()
	. = ..()
	update_move_intent_slowdown()

/mob/living/update_config_movespeed()
	update_move_intent_slowdown()
	return ..()

/mob/living/proc/update_move_intent_slowdown()
	add_movespeed_modifier((m_intent == MOVE_INTENT_WALK)? /datum/movespeed_modifier/config_walk_run/walk : /datum/movespeed_modifier/config_walk_run/run)

/mob/living/proc/update_turf_movespeed(turf/open/T)
	if(isopenturf(T))
		add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/turf_slowdown, multiplicative_slowdown = T.slowdown)
	else
		remove_movespeed_modifier(/datum/movespeed_modifier/turf_slowdown)


/mob/living/proc/update_pull_movespeed()
	SEND_SIGNAL(src, COMSIG_LIVING_UPDATING_PULL_MOVESPEED)

	if(pulling)
		if(isliving(pulling))
			var/mob/living/L = pulling
			//SKYRAT EDIT ADDITION
			if(HAS_TRAIT(L, TRAIT_OVERSIZED) && !HAS_TRAIT(src, TRAIT_OVERSIZED) && !iscyborg(src))
				add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/bulky_drag, multiplicative_slowdown = PULL_OVERSIZED_SLOWDOWN)
				return
			//SKYRAT EDIT END
			if(!slowed_by_drag || L.body_position == STANDING_UP || L.buckled || grab_state >= GRAB_AGGRESSIVE)
				remove_movespeed_modifier(/datum/movespeed_modifier/bulky_drag)
				return
			add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/bulky_drag, multiplicative_slowdown = PULL_PRONE_SLOWDOWN)
			return
		if(isobj(pulling))
			var/obj/structure/S = pulling
			if(!slowed_by_drag || !S.drag_slowdown)
				remove_movespeed_modifier(/datum/movespeed_modifier/bulky_drag)
				return
			add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/bulky_drag, multiplicative_slowdown = S.drag_slowdown)
			return
	remove_movespeed_modifier(/datum/movespeed_modifier/bulky_drag)

/mob/living/canZMove(dir, turf/target)
	if(buckled)
		return buckled.can_zTravel(target, dir) && (buckled.movement_type & FLYING | FLOATING)
	return can_zTravel(target, dir) && (movement_type & FLYING | FLOATING)

/mob/living/keybind_face_direction(direction)
	if(stat > SOFT_CRIT)
		return
	return ..()