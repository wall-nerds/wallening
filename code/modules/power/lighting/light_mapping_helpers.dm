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
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/light, DEFAULT_OFFSET_Y_NORTH, DEFAULT_OFFSET_Y_SOUTH, DEFAULT_OFFSET_X, DEFAULT_OFFSET_X)

// ---- Broken tube
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/light/broken, DEFAULT_OFFSET_Y_NORTH, DEFAULT_OFFSET_Y_SOUTH, DEFAULT_OFFSET_X, DEFAULT_OFFSET_X)

// ---- Tube construct
MAPPING_DIRECTIONAL_HELPERS(/obj/structure/light_construct, DEFAULT_OFFSET_Y_NORTH, DEFAULT_OFFSET_Y_SOUTH, DEFAULT_OFFSET_X, DEFAULT_OFFSET_X)

// ---- Tube frames
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/light/built, DEFAULT_OFFSET_Y_NORTH, DEFAULT_OFFSET_Y_SOUTH, DEFAULT_OFFSET_X, DEFAULT_OFFSET_X)

// ---- No nightlight tubes
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/light/no_nightlight, DEFAULT_OFFSET_Y_NORTH, DEFAULT_OFFSET_Y_SOUTH, DEFAULT_OFFSET_X, DEFAULT_OFFSET_X)

// ---- Warm light tubes
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/light/warm, DEFAULT_OFFSET_Y_NORTH, DEFAULT_OFFSET_Y_SOUTH, DEFAULT_OFFSET_X, DEFAULT_OFFSET_X)

// ---- No nightlight warm light tubes
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/light/warm/no_nightlight, DEFAULT_OFFSET_Y_NORTH, DEFAULT_OFFSET_Y_SOUTH, DEFAULT_OFFSET_X, DEFAULT_OFFSET_X)

// ---- Cold light tubes
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/light/cold, DEFAULT_OFFSET_Y_NORTH, DEFAULT_OFFSET_Y_SOUTH, DEFAULT_OFFSET_X, DEFAULT_OFFSET_X)

// ---- No nightlight cold light tubes
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/light/cold/no_nightlight, DEFAULT_OFFSET_Y_NORTH, DEFAULT_OFFSET_Y_SOUTH, DEFAULT_OFFSET_X, DEFAULT_OFFSET_X)

// ---- Red tubes
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/light/red, DEFAULT_OFFSET_Y_NORTH, DEFAULT_OFFSET_Y_SOUTH, DEFAULT_OFFSET_X, DEFAULT_OFFSET_X)

// ---- Blacklight tubes
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/light/blacklight, DEFAULT_OFFSET_Y_NORTH, DEFAULT_OFFSET_Y_SOUTH, DEFAULT_OFFSET_X, DEFAULT_OFFSET_X)

// ---- Dim tubes
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/light/dim, DEFAULT_OFFSET_Y_NORTH, DEFAULT_OFFSET_Y_SOUTH, DEFAULT_OFFSET_X, DEFAULT_OFFSET_X)


// -------- Bulb lights
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/light/small, DEFAULT_OFFSET_Y_NORTH, DEFAULT_OFFSET_Y_SOUTH, DEFAULT_OFFSET_X, DEFAULT_OFFSET_X)

// ---- Bulb construct
MAPPING_DIRECTIONAL_HELPERS(/obj/structure/light_construct/small, DEFAULT_OFFSET_Y_NORTH, DEFAULT_OFFSET_Y_SOUTH, DEFAULT_OFFSET_X, DEFAULT_OFFSET_X)

// ---- Bulb frames
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/light/small/built, DEFAULT_OFFSET_Y_NORTH, DEFAULT_OFFSET_Y_SOUTH, DEFAULT_OFFSET_X, DEFAULT_OFFSET_X)

// ---- Broken bulbs
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/light/small/broken, DEFAULT_OFFSET_Y_NORTH, DEFAULT_OFFSET_Y_SOUTH, DEFAULT_OFFSET_X, DEFAULT_OFFSET_X)

// ---- Red bulbs
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/light/small/red, DEFAULT_OFFSET_Y_NORTH, DEFAULT_OFFSET_Y_SOUTH, DEFAULT_OFFSET_X, DEFAULT_OFFSET_X)

// ---- Blacklight bulbs
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/light/small/blacklight, DEFAULT_OFFSET_Y_NORTH, DEFAULT_OFFSET_Y_SOUTH, DEFAULT_OFFSET_X, DEFAULT_OFFSET_X)
