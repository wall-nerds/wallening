

// Hello lads
// This element exists so sides of a turf "pop off" it visually, preventing weird popin when you walk below it
// It also ensures you can't see anything but the side visible to you, which makes walking in say, maint a lot nicer
// It's not finished yet, which is why this file isn't ticked. We need to rework how sprite files get split up
// For now tho, it'll just sit here

/mutable_appearance/split_vis

/mutable_appearance/split_vis/New()
	. = ..()
	// Need to do this here because it's overriden by the parent call
	appearance_flags = TILE_BOUND | RESET_COLOR | RESET_ALPHA | RESET_TRANSFORM

GLOBAL_LIST_EMPTY(split_visibility_objects)

/proc/get_splitvis_object(z_offset, icon_path, junction, dir, shadow = FALSE, alpha = 255, pixel_x = 0, pixel_y = 0, plane = GAME_PLANE, layer = WALL_LAYER)
	var/key = "[icon_path]-[junction]-[dir]-[shadow]-[alpha]-[pixel_x]-[pixel_y]-[plane]-[layer]-[z_offset]"
	var/mutable_appearance/split_vis/vis = GLOB.split_visibility_objects[key]
	if(vis)
		return vis

	vis = new /mutable_appearance/split_vis()
	vis.icon = icon_path
	var/junc = junction ? junction : "0"
	vis.icon_state = "[junc]-[dir]"
	if(shadow)
		vis.overlays += get_splitvis_object(z_offset, icon_path, junction, dir, FALSE, 120, pixel_x = 0, pixel_y = 0, plane = UNDER_FRILL_PLANE)
	vis.alpha = alpha
	vis.pixel_x = pixel_x
	vis.pixel_y = pixel_y
	SET_PLANE_W_SCALAR(vis, plane, z_offset)
	vis.layer = layer

	GLOB.split_visibility_objects[key] = vis
	return vis

/datum/element/split_visibility
	element_flags = ELEMENT_BESPOKE | ELEMENT_DETACH
	id_arg_index = 2
	var/icon_path

/datum/element/split_visibility/Attach(datum/target, icon_path)
	if(!isatom(target)) // Turfs only cause this would do wacky shit on things that can move
		return ELEMENT_INCOMPATIBLE
	. = ..()
	var/atom/target_atom = target
	if(!(target_atom.smoothing_flags & SMOOTH_BITMASK))
		CRASH("We tried to splitvis [target.type] without bitmask smoothing. What?")

	target_atom.add_overlay(mutable_appearance('wall_blackness.dmi', "wall_background", UNDER_WALL_LAYER, target_atom, GAME_PLANE))
	// Ensures when you try to click on a turf, you actually click on the turf, and not the adjacent things holding it
	target_atom.add_overlay(mutable_appearance('wall_blackness.dmi', "wall_clickcatcher", WALL_CLICKCATCH_LAYER, target_atom, GAME_PLANE))

	src.icon_path = icon_path

	if(ismovable(target))
		RegisterSignal(target, COMSIG_ATOM_SET_SMOOTHED_ICON_STATE, .proc/on_movable_junction_change)
		RegisterSignal(target, COMSIG_MOVABLE_MOVED, .proc/on_move)
		var/turf/our_turf = get_turf(target_atom)
		var/ref = REF(target)
		ADD_TRAIT(our_turf, TRAIT_CONTAINS_SPLITVIS, ref)
		add_split_vis_objects(our_turf, target_atom.smoothing_junction)
	else
		ADD_TRAIT(target, TRAIT_CONTAINS_SPLITVIS, src) // We use src here because this code is hot, and we assert that bespoke elements cannot self delete. Not a good pattern but fast
		RegisterSignal(target, COMSIG_ATOM_SET_SMOOTHED_ICON_STATE, .proc/on_turf_junction_change)
		add_split_vis_objects(target_atom, target_atom.smoothing_junction)

#define DIR_TO_PIXEL_Y(dir) ((dir & NORTH) ? 32 : (dir & SOUTH) ? -32 : 0)
#define DIR_TO_PIXEL_X(dir) ((dir & EAST) ? 32 : (dir & WEST) ? -32 : 0)


/datum/element/split_visibility/proc/add_split_vis_objects(turf/target_turf, junction)
	apply_splitvis_objs(target_turf, junction)

/datum/element/split_visibility/proc/remove_split_vis_objects(turf/target_turf, junction)
	apply_splitvis_objs(target_turf, junction, add_to_turfs = FALSE)

/datum/element/split_visibility/proc/apply_splitvis_objs(turf/target_turf, junction, add_to_turfs = TRUE)
	// cache for sonic speed
	var/icon_path = src.icon_path

	var/offset = GET_Z_PLANE_OFFSET(target_turf.z)

	// Lookup table for diagonal -> junction
	// This lets us do O(1) logic down later, and ensure logic works as we'd like
	var/static/list/diagonal_to_junction
	if(!diagonal_to_junction)
		// It should be as long as all 4 directions combined, so it can act as a lookup for all of them
		diagonal_to_junction = new /list(NORTH|SOUTH|EAST|WEST)
		// Set defaults
		for(var/i in 1 to length(diagonal_to_junction))
			diagonal_to_junction[i] = NONE
		diagonal_to_junction[NORTH|EAST] = NORTHEAST_JUNCTION
		diagonal_to_junction[SOUTH|EAST] = SOUTHEAST_JUNCTION
		diagonal_to_junction[SOUTH|WEST] = SOUTHWEST_JUNCTION
		diagonal_to_junction[NORTH|WEST] = NORTHWEST_JUNCTION

	for(var/direction in GLOB.cardinals)
		// If we're connected in this direction, please don't draw a wall side
		if((junction & direction) == direction)
			continue

		var/active_plane = GAME_PLANE
		var/uses_shadow = FALSE
		if(direction & NORTH)
			active_plane = FRILL_PLANE
			uses_shadow = TRUE

		var/turf/operating_turf = get_step(target_turf, direction)
		// Right up against an edge of the map eh?
		if(!operating_turf)
			continue

		if(add_to_turfs)
			var/mutable_appearance/split_vis/vis
			// If we're trying to draw to something with splitvis, just draw to yourself, and use the hidden wall plane
			if(HAS_TRAIT(operating_turf, TRAIT_CONTAINS_SPLITVIS))
				vis = get_splitvis_object(offset, icon_path, junction, direction, FALSE, 255, 0, 0, HIDDEN_WALL_PLANE)
				target_turf.overlays += vis
			else
				vis = get_splitvis_object(offset, icon_path, junction, direction, uses_shadow, 255, -DIR_TO_PIXEL_X(direction), -DIR_TO_PIXEL_Y(direction), active_plane)
				operating_turf.overlays += vis
		else
			// I HATE the code duping, but we need to try both to ensure it's properly cleared
			var/mutable_appearance/split_vis/vis
			vis = get_splitvis_object(offset, icon_path, junction, direction, FALSE, 255, 0, 0, HIDDEN_WALL_PLANE)
			target_turf.overlays -= vis
			vis = get_splitvis_object(offset, icon_path, junction, direction, uses_shadow, 255, -DIR_TO_PIXEL_X(direction), -DIR_TO_PIXEL_Y(direction), active_plane)
			operating_turf.overlays -= vis

	for(var/direction in GLOB.diagonals)
		// If we're connected in the two components of this direction
		if((junction & direction) != direction)
			continue
		// AND if we're not connected to anything in the SUM of those directions
		var/diagonal_junction = diagonal_to_junction[direction]
		if((junction & diagonal_junction) == diagonal_junction)
			continue

		var/turf/operating_turf = get_step(target_turf, direction)
		// Right up against an edge of the map eh?
		if(!operating_turf)
			continue

		if(add_to_turfs)
			var/mutable_appearance/split_vis/vis
			// If we're trying to draw to something with splitvis, just draw to yourself, and use the hidden wall plane
			// Wallening todo: Frills should block emissives
			if(HAS_TRAIT(operating_turf, TRAIT_CONTAINS_SPLITVIS))
				vis = get_splitvis_object(offset, icon_path, "innercorner", direction, FALSE, 255, 0, 0, HIDDEN_WALL_PLANE, ABOVE_WALL_LAYER)
				target_turf.overlays += vis
			else
				vis = get_splitvis_object(offset, icon_path, "innercorner", direction, FALSE, 255, -DIR_TO_PIXEL_X(direction), -DIR_TO_PIXEL_Y(direction), layer = ABOVE_WALL_LAYER)
				operating_turf.overlays += vis
		else
			// I HATE the code duping, but we need to try both to ensure it's properly cleared
			var/mutable_appearance/split_vis/vis
			vis = get_splitvis_object(offset, icon_path, "innercorner", direction, FALSE, 255, 0, 0, HIDDEN_WALL_PLANE, ABOVE_WALL_LAYER)
			target_turf.overlays -= vis
			vis = get_splitvis_object(offset, icon_path, "innercorner", direction, FALSE, 255, -DIR_TO_PIXEL_X(direction), -DIR_TO_PIXEL_Y(direction), layer = ABOVE_WALL_LAYER)
			operating_turf.overlays -= vis

/datum/element/split_visibility/Detach(atom/target)
	remove_split_vis_objects(target, target.smoothing_junction)
	UnregisterSignal(target, COMSIG_ATOM_SET_SMOOTHED_ICON_STATE)
	if(ismovable(target))
		var/ref = REF(target)
		var/turf/our_turf = get_turf(target)
		REMOVE_TRAIT(our_turf, TRAIT_CONTAINS_SPLITVIS, ref) // We use src here because this code is hot, and we assert that bespoke elements cannot self delete. Not a good pattern but fast
	else
		REMOVE_TRAIT(target, TRAIT_CONTAINS_SPLITVIS, src) // We use src here because this code is hot, and we assert that bespoke elements cannot self delete. Not a good pattern but fast
	return ..()

/datum/element/split_visibility/proc/on_turf_junction_change(turf/source, new_junction)
	SIGNAL_HANDLER
	remove_split_vis_objects(source, source.smoothing_junction)
	add_split_vis_objects(source, new_junction)

/datum/element/split_visibility/proc/on_movable_junction_change(atom/movable/source, new_junction)
	SIGNAL_HANDLER
	if(isturf(source.loc))
		remove_split_vis_objects(source.loc, source.smoothing_junction)
		add_split_vis_objects(source.loc, new_junction)

/datum/element/split_visibility/proc/on_move(atom/source, atom/old_loc, dir, forced, list/old_locs)
	SIGNAL_HANDLER
	if(isturf(old_loc))
		remove_split_vis_objects(old_loc, source.smoothing_junction) // We trust that junction changing will create the new visuals. just gotta cover the old
		QUEUE_SMOOTH_NEIGHBORS(old_loc)
	var/turf/old_turf = get_turf(old_loc)
	var/ref = REF(source)
	REMOVE_TRAIT(old_turf, TRAIT_CONTAINS_SPLITVIS, ref)
	QUEUE_SMOOTH(source)
	QUEUE_SMOOTH_NEIGHBORS(source)
	var/turf/our_turf = get_turf(source)
	if(our_turf)
		ADD_TRAIT(our_turf, TRAIT_CONTAINS_SPLITVIS, ref)
