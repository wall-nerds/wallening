/// Adds clickable balloons whenever someone holds the examine key (is it still shift in the future?)
/datum/component/examine_balloon
	/// Offset applied on the hologram
	var/pixel_y_offset

	/// Offset applied on the bubble
	var/pixel_y_offset_arrow = 4

/datum/component/examine_balloon/Initialize(pixel_y_offset = 32)
	. = ..()

	if(!ismovable(parent))
		return COMPONENT_INCOMPATIBLE

	src.pixel_y_offset = pixel_y_offset

	var/atom/atom_parent = parent

	RegisterSignal(atom_parent, COMSIG_ATOM_UPDATE_OVERLAYS, PROC_REF(on_update_overlays))
	atom_parent.update_icon(UPDATE_OVERLAYS)

/datum/component/examine_balloon/proc/on_update_overlays(atom/movable/parent, list/overlays)
	SIGNAL_HANDLER

	var/mutable_appearance/hologram = new(parent.appearance)
	SET_PLANE_EXPLICIT(hologram, WALLMOUNT_BALLOONS_PLANE, parent)
	hologram.dir = SOUTH
	hologram.blend_mode = BLEND_INSET_OVERLAY

	hologram.pixel_w = 0
	hologram.pixel_x = 0
	hologram.pixel_y = 0
	hologram.pixel_z = 0

	hologram.appearance_flags = null
	hologram.overlays = parent.overlays.Copy() //we add a miror as overlay to the object, which loops infinitely... so dont

	var/mutable_appearance/examine_backdrop = mutable_appearance( //alpha 1 backdrop with inset overlay to turn the sprite south
		'icons/effects/effects.dmi',
		"examine_backdrop",
	)

	examine_backdrop.pixel_y = pixel_y_offset
	examine_backdrop.overlays += hologram
	SET_PLANE_EXPLICIT(examine_backdrop, WALLMOUNT_BALLOONS_PLANE, parent)

	var/mutable_appearance/examine_arrow = mutable_appearance(
		'icons/effects/effects.dmi',
		"examine_arrow",
	)

	examine_arrow.pixel_y = pixel_y_offset_arrow

	SET_PLANE_EXPLICIT(examine_arrow, WALLMOUNT_BALLOONS_PLANE, parent)

	overlays += examine_backdrop
	overlays += examine_arrow
