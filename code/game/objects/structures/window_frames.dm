/obj/structure/window_frame
	name = "window frame"
	desc = "A frame section to place a window on top."
	icon = 'icons/obj/smooth_structures/window_frames/window_frame_normal.dmi'
	icon_state = "window_frame_normal-0"
	base_icon_state = "window_frame_normal"
	plane = OVER_TILE_PLANE //otherwise they will mask windows
	smoothing_flags = SMOOTH_BITMASK|SMOOTH_OBJ
	smoothing_groups = list(SMOOTH_GROUP_WINDOW_FRAMES)
	canSmoothWith = list(SMOOTH_GROUP_WINDOW_FRAMES)
	opacity = FALSE
	density = TRUE
	rad_insulation = null
	frill_icon = null // we dont have a frill, our window does
	armor = list(MELEE = 50, BULLET = 70, LASER = 70, ENERGY = 100, BOMB = 10, BIO = 100, FIRE = 0, ACID = 0)
	max_integrity = 50
	anchored = TRUE

	var/mutable_appearance/grill_overlay
	///identical appearance to grill_overlay but completely black and on a lower plane so wires can layer between
	var/mutable_appearance/grill_black_overlay

	///used for an overlay that just layers our southern face (if it exists ie we arent smoothed in that direction) above things that should
	///be occluded like cables that go through us (which show below any grill we have but above us)
	var/mutable_appearance/south_face_overlay

	///whether we currently have a grille
	var/has_grille = FALSE
	///whether we spawn a window structure with us on mapload
	var/start_with_window = FALSE
	///Icon used by grilles for this window frame
	var/grille_icon = 'icons/obj/smooth_structures/window_grille.dmi'

	var/grille_black_icon = 'icons/obj/smooth_structures/window_grille_black.dmi'
	///Icon state used by grilles for this window frame.
	var/grille_icon_state = "window_grille"

	var/south_face_icon = 'icons/obj/smooth_structures/window_frames/frame_faces/normal_frame.dmi'

	///whether or not this window is reinforced and thus doesnt use the default attackby() behavior
	var/is_reinforced = FALSE

	///typepath. creates a corresponding window for this frame.
	///is either a material sheet typepath (eg /obj/item/stack/sheet/glass) or a fulltile window typepath (eg /obj/structure/window/fulltile)
	var/window_type = /obj/item/stack/sheet/glass

	var/sheet_type = /obj/item/stack/sheet/iron
	var/sheet_amount = 2

/obj/structure/window_frame/Initialize(mapload)
	. = ..()

	update_appearance()
	AddElement(/datum/element/climbable)

	if(mapload && start_with_window)
		create_structure_window(window_type, TRUE)

///helper proc to check if we already have a window
/obj/structure/window_frame/proc/has_window()
	SHOULD_BE_PURE(TRUE)

	for(var/obj/structure/window/window in loc)
		if(window.fulltile)
			return TRUE

	return FALSE

///creates a window from the typepath given from window_type, which is either a glass sheet typepath or a /obj/structure/window subtype
/obj/structure/window_frame/proc/create_structure_window(window_material_type, start_anchored = TRUE)
	var/obj/structure/window/our_window

	if(ispath(window_material_type, /obj/structure/window))
		our_window = new window_material_type(loc)
		if(!our_window.fulltile)
			stack_trace("Window frames can't use non fulltile windows!")

	//window_material_type isnt a window typepath, so check if its a material typepath
	if(ispath(window_material_type, /obj/item/stack/sheet/glass))
		our_window = new /obj/structure/window/fulltile(loc)

	if(ispath(window_material_type, /obj/item/stack/sheet/rglass))
		our_window = new /obj/structure/window/reinforced/fulltile(loc)

	if(ispath(window_material_type, /obj/item/stack/sheet/plasmaglass))
		our_window = new /obj/structure/window/plasma/fulltile(loc)

	if(ispath(window_material_type, /obj/item/stack/sheet/plasmarglass))
		our_window = new /obj/structure/window/reinforced/plasma/fulltile(loc)

	if(ispath(window_material_type, /obj/item/stack/sheet/titaniumglass))
		our_window = new /obj/structure/window/reinforced/shuttle(loc)

	if(ispath(window_material_type, /obj/item/stack/sheet/plastitaniumglass))
		our_window = new /obj/structure/window/reinforced/plasma/plastitanium(loc)

	if(ispath(window_material_type, /obj/item/stack/sheet/paperframes))
		our_window = new /obj/structure/window/paperframe(loc)

	if(!start_anchored)
		our_window.set_anchored(FALSE)
		our_window.state = WINDOW_OUT_OF_FRAME

	our_window.update_appearance()

/obj/structure/window_frame/attackby(obj/item/attacking_item, mob/living/user, params)

	add_fingerprint(user)

	if(attacking_item.tool_behaviour == TOOL_WELDER)
		if(atom_integrity < max_integrity)
			if(!attacking_item.tool_start_check(user, amount = 0))
				return

			to_chat(user, span_notice("You begin repairing [src]..."))
			if(!attacking_item.use_tool(src, user, 40, volume = 50))
				return

			atom_integrity = max_integrity
			to_chat(user, span_notice("You repair [src]."))
			update_appearance()
		else
			to_chat(user, span_warning("[src] is already in good condition!"))
		return

	else if(attacking_item.tool_behaviour == TOOL_WIRECUTTER)
		if(has_grille)

			if(!attacking_item.use_tool(src, user, 0, volume = 50))
				return

			to_chat(user, "<span class='notice'>You cut the grille on [src].</span>")

			has_grille = FALSE
			update_appearance()
			return

	else if(isstack(attacking_item))
		var/obj/item/stack/adding_stack = attacking_item
		var/stack_name = "[adding_stack]" // in case the stack gets deleted after use()

		if(is_glass_sheet(adding_stack) && !(has_window()) && adding_stack.use(sheet_amount))
			to_chat(user, "<span class='notice'>You start to add [stack_name] to [src].")
			if(!do_after(user, 2 SECONDS, src))
				return

			to_chat(user, "<span class='notice'>You add [stack_name] to [src].")
			create_structure_window(adding_stack.type, FALSE)

		else if(istype(adding_stack, /obj/item/stack/rods) && !has_grille && adding_stack.use(sheet_amount))
			has_grille = TRUE
			to_chat(user, "<span class='notice'>You add [stack_name] to [src]")
			update_appearance()

	return ..()

/obj/structure/window_frame/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = NONE)
	switch(damage_type)
		if(BRUTE)
			if(damage_amount)
				playsound(src, 'sound/effects/grillehit.ogg', 80, TRUE)
			else
				playsound(src, 'sound/weapons/tap.ogg', 50, TRUE)
		if(BURN)
			playsound(src, 'sound/items/welder.ogg', 80, TRUE)

/obj/structure/window_frame/attack_paw(mob/user, list/modifiers)
	return attack_hand(user, modifiers)

/obj/structure/window_frame/rcd_vals(mob/user, obj/item/construction/rcd/the_rcd)
	if(the_rcd.mode == RCD_DECONSTRUCT)
		return list("mode" = RCD_DECONSTRUCT, "delay" = 20, "cost" = 5)
	return FALSE

/obj/structure/window_frame/rcd_act(mob/user, obj/item/construction/rcd/the_rcd)
	if(the_rcd.mode == RCD_DECONSTRUCT)
		to_chat(user, "<span class='notice'>You deconstruct the window frame.</span>")
		qdel(src)
		return TRUE
	return FALSE

/obj/structure/window_frame/examine(mob/user)
	. = ..()
	if(has_window() && has_grille)
		. += "<span class='notice'>The window is fully constructed.</span>"
	else if(has_window())
		. += "<span class='notice'>The window set into the frame has no reinforcement.</span>"
	else if(has_grille)
		. += "<span class='notice'>The window frame only has a grille set into it.</span>"
	else
		. += "<span class='notice'>The window frame is empty</span>"

///delightfully devilous seymour
/obj/structure/window_frame/set_smoothed_icon_state(new_junction)
	. = ..()
	update_icon()

/*
//Redefinitions of the diagonal directions so they can be stored in one var without conflicts
#define NORTH_JUNCTION NORTH (1<<0) 1
#define SOUTH_JUNCTION SOUTH (1<<1) 2
#define EAST_JUNCTION EAST  (1<<2) 4
#define WEST_JUNCTION WEST  (1<<3) 8
#define NORTHEAST_JUNCTION (1<<4) 16
#define SOUTHEAST_JUNCTION (1<<5) 32 _|
#define SOUTHWEST_JUNCTION (1<<6) 64 |_
#define NORTHWEST_JUNCTION (1<<7) 128
		  _| = 32
		 |_  = 64
		 |_| = 96
		  _  = 2

0  ▢
1  |_|
2  |‾|
3  |#|
4  |=#
5  |_#
6  |‾#
7  |##
8  #=|
9  #_|
10 #‾|
11 ##|
12 #=#
13 #_#
14 #‾#
15 empty

21 |_#
23 |##
29 #_#
31 empty
38 |‾#
39 |##
46 #‾#
47 empty
55 |##
63 empty
74 #‾|
75 ##|
78 #‾#
79 empty
95 empty
110 #‾#
111 empty
127 empty
137 #_|
139 ##|
141 #_#
143 empty
157 #_#
159 empty
175 empty
191 empty
203 ##|
207 empty
223 empty
239 empty
255 empty

*/

/obj/structure/window_frame/update_overlays()
	. = ..()
	if(has_grille)
		var/offset = GET_TURF_PLANE_OFFSET(src)
		grill_overlay = mutable_appearance(grille_icon, "[grille_icon_state]-[smoothing_junction]", plane = (src.plane + 1), offset_const = offset)
		grill_black_overlay = mutable_appearance(grille_black_icon, "[grille_icon_state]_black-[smoothing_junction]", plane = (src.plane), offset_const = offset)
		. += grill_overlay
		. += grill_black_overlay

		var/south_face_exists = !(smoothing_junction & (SOUTH_JUNCTION | SOUTHEAST_JUNCTION | SOUTHWEST_JUNCTION))

		if(!south_face_exists)
			return

		/// 4 cases if the southern face exists
		/// this is set to SOUTH_JUNCTION, SOUTHEAST_JUNCTION, or SOUTHWEST_JUNCTION, or SOUTHEAST_JUNCTION|SOUTHWEST_JUNCTION
		/// depending on whether the south face exists and whether the east and/or west faces exist.
		var/south_face_dir = NONE

		var/east_face_exists = !(smoothing_junction & (EAST_JUNCTION | SOUTHEAST_JUNCTION | NORTHEAST_JUNCTION))
		var/west_face_exists = !(smoothing_junction & (WEST_JUNCTION | SOUTHWEST_JUNCTION | NORTHWEST_JUNCTION))

		if(east_face_exists && west_face_exists)
			south_face_dir = SOUTHEAST_JUNCTION | SOUTHWEST_JUNCTION
		else if(!east_face_exists && !west_face_exists)
			south_face_dir = SOUTH_JUNCTION

		else if(east_face_exists)
			south_face_dir = SOUTHWEST_JUNCTION
		else if(west_face_exists)
			south_face_dir = SOUTHEAST_JUNCTION

		if(!south_face_dir)
			CRASH("somehow a window frame couldnt find a compatible south face direction when it should have one! smoothing_junction: [smoothing_junction], south_face_dir: [south_face_dir]")

		south_face_overlay = mutable_appearance(south_face_icon, "[south_face_dir]", plane = (src.plane + 1), offset_const = offset)
		south_face_overlay.appearance_flags = KEEP_APART
		. += south_face_overlay





/obj/structure/window_frame/grille
	has_grille = TRUE

/obj/structure/window_frame/grille_and_window
	has_grille = TRUE
	start_with_window = TRUE

/obj/structure/window_frame/reinforced
	name = "reinforced window frame"
	window_type = /obj/item/stack/sheet/rglass
	armor = list(MELEE = 80, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 25, BIO = 100, FIRE = 80, ACID = 100)
	max_integrity = 150
	damage_deflection = 11

/obj/structure/window_frame/reinforced/grille_and_window
	has_grille = TRUE
	start_with_window = TRUE

/obj/structure/window_frame/titanium
	name = "shuttle window frame"
	icon = 'icons/obj/smooth_structures/window_frames/window_frame_shuttle.dmi'
	icon_state = "window_frame_shuttle-0"
	base_icon_state = "window_frame_shuttle"
	south_face_icon = 'icons/obj/smooth_structures/window_frames/frame_faces/shuttle_frame.dmi'
	sheet_type = /obj/item/stack/sheet/mineral/titanium
	window_type = /obj/item/stack/sheet/titaniumglass
	custom_materials = list(/datum/material/titanium = WINDOW_FRAME_BASE_MATERIAL_AMOUNT)

/obj/structure/window_frame/titanium/grille_and_window
	has_grille = TRUE
	start_with_window = TRUE

/obj/structure/window_frame/plastitanium
	name = "plastitanium window frame"
	icon = 'icons/obj/smooth_structures/window_frames/window_frame_plastitanium.dmi'
	icon_state = "window_frame_plastitanium-0"
	base_icon_state = "window_frame_plastitanium"
	south_face_icon = 'icons/obj/smooth_structures/window_frames/frame_faces/plasititanium_frame.dmi'
	sheet_type = /obj/item/stack/sheet/mineral/plastitanium
	window_type = /obj/item/stack/sheet/plastitaniumglass
	custom_materials = list(/datum/material/alloy/plastitanium = WINDOW_FRAME_BASE_MATERIAL_AMOUNT)

/obj/structure/window_frame/plastitanium/grille_and_window
	has_grille = TRUE
	start_with_window = TRUE

/obj/structure/window_frame/wood
	name = "wooden platform"
	icon = 'icons/obj/smooth_structures/window_frames/window_frame_wood.dmi'
	icon_state = "window_frame_wood-0"
	base_icon_state = "window_frame_wood"
	south_face_icon = 'icons/obj/smooth_structures/window_frames/frame_faces/wood_frame.dmi'
	sheet_type = /obj/item/stack/sheet/mineral/wood
	custom_materials = list(/datum/material/wood = WINDOW_FRAME_BASE_MATERIAL_AMOUNT)

/obj/structure/window_frame/uranium
	name = "uranium window frame"
	icon = 'icons/obj/smooth_structures/window_frames/window_frame_uranium.dmi'
	icon_state = "window_frame_uranium-0"
	base_icon_state = "window_frame_uranium"
	south_face_icon = 'icons/obj/smooth_structures/window_frames/frame_faces/uranium_frame.dmi'
	sheet_type = /obj/item/stack/sheet/mineral/uranium
	custom_materials = list(/datum/material/uranium = WINDOW_FRAME_BASE_MATERIAL_AMOUNT)

/obj/structure/window_frame/iron
	name = "rough iron window frame"
	icon = 'icons/obj/smooth_structures/window_frames/window_frame_iron.dmi'
	icon_state = "window_frame_iron-0"
	base_icon_state = "window_frame_iron"
	south_face_icon = 'icons/obj/smooth_structures/window_frames/frame_faces/iron_frame.dmi'
	sheet_type = /obj/item/stack/sheet/iron
	custom_materials = list(/datum/material/iron = WINDOW_FRAME_BASE_MATERIAL_AMOUNT)

/obj/structure/window_frame/silver
	name = "silver window frame"
	icon = 'icons/obj/smooth_structures/window_frames/window_frame_silver.dmi'
	icon_state = "window_frame_silver-0"
	base_icon_state = "window_frame_silver"
	south_face_icon = 'icons/obj/smooth_structures/window_frames/frame_faces/silver_frame.dmi'
	sheet_type = /obj/item/stack/sheet/mineral/silver
	custom_materials = list(/datum/material/silver = WINDOW_FRAME_BASE_MATERIAL_AMOUNT)

/obj/structure/window_frame/gold
	name = "gold window frame"
	icon = 'icons/obj/smooth_structures/window_frames/window_frame_gold.dmi'
	icon_state = "window_frame_gold-0"
	base_icon_state = "window_frame_gold"
	south_face_icon = 'icons/obj/smooth_structures/window_frames/frame_faces/gold_frame.dmi'
	sheet_type = /obj/item/stack/sheet/mineral/gold
	custom_materials = list(/datum/material/gold = WINDOW_FRAME_BASE_MATERIAL_AMOUNT)

/obj/structure/window_frame/bronze
	name = "clockwork window mount"
	icon = 'icons/obj/smooth_structures/window_frames/window_frame_bronze.dmi'
	icon_state = "window_frame_bronze-0"
	base_icon_state = "window_frame_bronze"
	south_face_icon = 'icons/obj/smooth_structures/window_frames/frame_faces/bronze_frame.dmi'
	sheet_type = /obj/item/stack/sheet/bronze
	custom_materials = list(/datum/material/bronze = WINDOW_FRAME_BASE_MATERIAL_AMOUNT)

/obj/structure/window_frame/cult
	name = "rune-scarred window frame"
	icon = 'icons/obj/smooth_structures/window_frames/window_frame_cult.dmi'
	icon_state = "window_frame_cult-0"
	base_icon_state = "window_frame_cult"
	south_face_icon = 'icons/obj/smooth_structures/window_frames/frame_faces/cult_frame.dmi'
	sheet_type = /obj/item/stack/sheet/runed_metal
	custom_materials = list(/datum/material/runedmetal = WINDOW_FRAME_BASE_MATERIAL_AMOUNT)

/obj/structure/window_frame/hotel
	name = "hotel window frame"
	icon = 'icons/obj/smooth_structures/window_frames/window_frame_hotel.dmi'
	icon_state = "window_frame_hotel-0"
	base_icon_state = "window_frame_hotel"
	south_face_icon = 'icons/obj/smooth_structures/window_frames/frame_faces/hotel_frame.dmi'
	sheet_type = /obj/item/stack/sheet/mineral/wood
	custom_materials = list(/datum/material/wood = WINDOW_FRAME_BASE_MATERIAL_AMOUNT)

/obj/structure/window_frame/material
	name = "material window frame"
	icon = 'icons/obj/smooth_structures/window_frames/window_frame_material.dmi'
	icon_state = "window_frame_material-0"
	base_icon_state = "window_frame_material"
	south_face_icon = 'icons/obj/smooth_structures/window_frames/frame_faces/material_frame.dmi'
	material_flags = MATERIAL_ADD_PREFIX | MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS

/obj/structure/window_frame/rusty
	name = "rusty window frame"
	icon = 'icons/obj/smooth_structures/window_frames/window_frame_rusty.dmi'
	icon_state = "window_frame_rusty-0"
	base_icon_state = "window_frame_rusty"
	south_face_icon = 'icons/obj/smooth_structures/window_frames/frame_faces/rusty_frame.dmi'
	sheet_type = /obj/item/stack/sheet/iron
	custom_materials = list(/datum/material/iron = WINDOW_FRAME_BASE_MATERIAL_AMOUNT)

/obj/structure/window_frame/sandstone
	name = "sandstone plinth"
	icon = 'icons/obj/smooth_structures/window_frames/window_frame_sandstone.dmi'
	icon_state = "window_frame_sandstone-0"
	base_icon_state = "window_frame_sandstone"
	south_face_icon = 'icons/obj/smooth_structures/window_frames/frame_faces/sandstone_frame.dmi'
	sheet_type = /obj/item/stack/sheet/mineral/sandstone
	custom_materials = list(/datum/material/sandstone = WINDOW_FRAME_BASE_MATERIAL_AMOUNT)

/obj/structure/window_frame/bamboo
	name = "bamboo platform"
	icon = 'icons/obj/smooth_structures/window_frames/window_frame_bamboo.dmi'
	icon_state = "window_frame_bamboo-0"
	base_icon_state = "window_frame_bamboo"
	south_face_icon = 'icons/obj/smooth_structures/window_frames/frame_faces/bamboo_frame.dmi'
	sheet_type = /obj/item/stack/sheet/mineral/bamboo
	custom_materials = list(/datum/material/bamboo = WINDOW_FRAME_BASE_MATERIAL_AMOUNT)

/obj/structure/window_frame/paperframe
	name = "japanese window frame"
	icon = 'icons/obj/smooth_structures/window_frames/window_frame_paperframe.dmi'
	icon_state = "window_frame_paperframe-0"
	base_icon_state = "window_frame_paperframe"
	south_face_icon = 'icons/obj/smooth_structures/window_frames/frame_faces/paperframe.dmi'
	sheet_type = /obj/item/stack/sheet/paperframes
	custom_materials = list(/datum/material/paper = WINDOW_FRAME_BASE_MATERIAL_AMOUNT)
