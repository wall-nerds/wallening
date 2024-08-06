/// Adds clickable balloons whenever someone holds the examine key (is it still shift in the future?)
/datum/component/examine_balloon
	/// Offset applied on the bubble
	var/pixel_y_offset

/datum/component/examine_balloon/Initialize(pixel_y_offset = 24)
	. = ..()

	if(!ismovable(parent))
		return COMPONENT_INCOMPATIBLE

	src.pixel_y_offset = pixel_y_offset

	var/atom/atom_parent = parent

	RegisterSignal(atom_parent, COMSIG_ATOM_UPDATE_OVERLAYS, PROC_REF(on_update_overlays))
	atom_parent.update_icon(UPDATE_OVERLAYS)

/datum/component/examine_balloon/proc/on_update_overlays(atom/movable/parent, list/overlays)
	SIGNAL_HANDLER

	var/mutable_appearance/examine_bubble = new(parent.appearance)
	SET_PLANE_EXPLICIT(examine_bubble, WALLMOUNT_BALLOONS_PLANE, parent)
	examine_bubble.blend_mode = BLEND_INSET_OVERLAY
	examine_bubble.dir = SOUTH

	examine_bubble.pixel_w = 0
	examine_bubble.pixel_x = 0
	examine_bubble.pixel_y = 0
	examine_bubble.pixel_z = 0

	examine_bubble.appearance_flags = null //some flags (like tilebound) mess with pixel adjustments
	examine_bubble.overlays = overlays.Copy() //we add a miror as overlay to the object, which loops infinitely... so dont

	var/mutable_appearance/thought_bubble = mutable_appearance(
		'icons/effects/effects.dmi',
		"examine_bubble",
	)

	thought_bubble.overlays += examine_bubble
	thought_bubble.pixel_y += pixel_y_offset

	SET_PLANE_EXPLICIT(thought_bubble, WALLMOUNT_BALLOONS_PLANE, parent)

	overlays += thought_bubble
