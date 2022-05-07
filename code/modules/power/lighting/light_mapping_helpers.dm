/obj/machinery/light/broken
	status = LIGHT_BROKEN
	icon_state = "tube-broken"

/obj/machinery/light/built
	icon_state = "tube-empty"
	start_with_cell = FALSE

/obj/machinery/light/built/Initialize(mapload)
	. = ..()
	status = LIGHT_EMPTY
	update(0)

/obj/machinery/light/no_nightlight
	nightshift_enabled = FALSE

/obj/machinery/light/warm
	bulb_colour = "#fae5c1"

/obj/machinery/light/warm/no_nightlight
	nightshift_allowed = FALSE

/obj/machinery/light/cold
	bulb_colour = "#deefff"
	nightshift_light_color = "#deefff"

/obj/machinery/light/cold/no_nightlight
	nightshift_allowed = FALSE

/obj/machinery/light/red
	bulb_colour = "#FF3232"
	nightshift_allowed = FALSE
	no_emergency = TRUE
	brightness = 4
	bulb_power = 0.7

/obj/machinery/light/blacklight
	bulb_colour = "#A700FF"
	nightshift_allowed = FALSE
	brightness = 4
	bulb_power = 0.8

/obj/machinery/light/dim
	nightshift_allowed = FALSE
	bulb_colour = "#FFDDCC"
	bulb_power = 0.6

// the smaller bulb light fixture

/obj/machinery/light/small
	icon_state = "bulb"
	base_state = "bulb"
	fitting = "bulb"
	brightness = 4
	nightshift_brightness = 4
	bulb_colour = "#FFD6AA"
	desc = "A small lighting fixture."
	light_type = /obj/item/light/bulb

/obj/machinery/light/small/broken
	status = LIGHT_BROKEN
	icon_state = "bulb-broken"

/obj/machinery/light/small/built
	icon_state = "bulb-empty"
	start_with_cell = FALSE

/obj/machinery/light/small/built/Initialize(mapload)
	. = ..()
	status = LIGHT_EMPTY
	update(0)

/obj/machinery/light/small/red
	bulb_colour = "#FF3232"
	no_emergency = TRUE
	nightshift_allowed = FALSE
	brightness = 2
	bulb_power = 0.8

/obj/machinery/light/small/blacklight
	bulb_colour = "#A700FF"
	nightshift_allowed = FALSE
	brightness = 2
	bulb_power = 0.9

// -------- Directional presets
// The directions are backwards on the lights we have now
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/light, offset_north, offset_south, offset_east, offset_west)

// ---- Broken tube
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/light/broken, offset_north, offset_south, offset_east, offset_west)

// ---- Tube construct
MAPPING_DIRECTIONAL_HELPERS(/obj/structure/light_construct, offset_north, offset_south, offset_east, offset_west)

// ---- Tube frames
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/light/built, offset_north, offset_south, offset_east, offset_west)

// ---- No nightlight tubes
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/light/no_nightlight, offset_north, offset_south, offset_east, offset_west)

// ---- Warm light tubes
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/light/warm, offset_north, offset_south, offset_east, offset_west)

// ---- No nightlight warm light tubes
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/light/warm/no_nightlight, offset_north, offset_south, offset_east, offset_west)

// ---- Cold light tubes
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/light/cold, offset_north, offset_south, offset_east, offset_west)

// ---- No nightlight cold light tubes
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/light/cold/no_nightlight, offset_north, offset_south, offset_east, offset_west)

// ---- Red tubes
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/light/red, offset_north, offset_south, offset_east, offset_west)

// ---- Blacklight tubes
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/light/blacklight, offset_north, offset_south, offset_east, offset_west)

// ---- Dim tubes
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/light/dim, offset_north, offset_south, offset_east, offset_west)


// -------- Bulb lights
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/light/small, offset_north, offset_south, offset_east, offset_west)

// ---- Bulb construct
MAPPING_DIRECTIONAL_HELPERS(/obj/structure/light_construct/small, offset_north, offset_south, offset_east, offset_west)

// ---- Bulb frames
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/light/small/built, offset_north, offset_south, offset_east, offset_west)

// ---- Broken bulbs
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/light/small/broken, offset_north, offset_south, offset_east, offset_west)

// ---- Red bulbs
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/light/small/red, offset_north, offset_south, offset_east, offset_west)

// ---- Blacklight bulbs
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/light/small/blacklight, offset_north, offset_south, offset_east, offset_west)
