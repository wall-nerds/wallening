/**
 * # Render over, Keep hitbox element!
 *
 * Non bespoke element (1 in existence) that makes structures render over mobs, but still allow you to attack the mob's hitbox!
 * Used in plastic flaps, and directional windows!
 */
/datum/element/render_over_keep_hitbox

/datum/element/render_over_keep_hitbox/Attach(datum/target)
	. = ..()
	if(!isstructure(target))
		return ELEMENT_INCOMPATIBLE
	var/obj/structure/obj_target = target

	RegisterSignal(obj_target, COMSIG_MOVABLE_Z_CHANGED, .proc/on_changed_z_level)
	RegisterSignal(obj_target, COMSIG_ATOM_UPDATE_OVERLAYS, .proc/on_update_overlays)
	obj_target.alpha = 0
	obj_target.update_overlays()

/datum/element/render_over_keep_hitbox/Detach(obj/structure/target, ...)
	UnregisterSignal(target, list(COMSIG_MOVABLE_Z_CHANGED, COMSIG_ATOM_UPDATE_OVERLAYS))
	target.alpha = initial(target.alpha)
	target.update_overlays()
	return ..()

/datum/element/render_over_keep_hitbox/proc/on_changed_z_level(obj/structure/target, turf/old_turf, turf/new_turf, same_z_layer)
	SIGNAL_HANDLER

	if(same_z_layer)
		return
	target.update_overlays()

/datum/element/render_over_keep_hitbox/proc/on_update_overlays(obj/structure/target, list/overlays)
	SIGNAL_HANDLER

	var/turf/our_turf = get_turf(target)
	//you see mobs under it, but you hit them like they are above it

	overlays += mutable_appearance(
		target.icon,
		target.icon_state,
		ABOVE_MOB_LAYER,
		null,
		MUTATE_PLANE(GAME_PLANE, our_turf),
		initial(target.alpha),
		RESET_ALPHA,
	)
