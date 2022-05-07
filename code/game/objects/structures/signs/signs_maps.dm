//map and direction signs

/obj/structure/sign/map
	name = "station map"
	desc = "A navigational chart of the station."
	max_integrity = 500

/obj/structure/sign/map/left
	icon_state = "map-left"

/obj/structure/sign/map/right
	icon_state = "map-right"

/obj/structure/sign/directions/science
	name = "science department sign"
	desc = "A direction sign, pointing out which way the Science department is."
	icon_state = "direction_sci"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/science, DEFAULT_OFFSET_Y_NORTH, DEFAULT_OFFSET_Y_SOUTH, DEFAULT_OFFSET_X, DEFAULT_OFFSET_X)

/obj/structure/sign/directions/engineering
	name = "engineering department sign"
	desc = "A direction sign, pointing out which way the Engineering department is."
	icon_state = "direction_eng"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/engineering, DEFAULT_OFFSET_Y_NORTH, DEFAULT_OFFSET_Y_SOUTH, DEFAULT_OFFSET_X, DEFAULT_OFFSET_X)

/obj/structure/sign/directions/security
	name = "security department sign"
	desc = "A direction sign, pointing out which way the Security department is."
	icon_state = "direction_sec"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/security, DEFAULT_OFFSET_Y_NORTH, DEFAULT_OFFSET_Y_SOUTH, DEFAULT_OFFSET_X, DEFAULT_OFFSET_X)

/obj/structure/sign/directions/medical
	name = "medbay sign"
	desc = "A direction sign, pointing out which way the Medbay is."
	icon_state = "direction_med"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/medical, DEFAULT_OFFSET_Y_NORTH, DEFAULT_OFFSET_Y_SOUTH, DEFAULT_OFFSET_X, DEFAULT_OFFSET_X)

/obj/structure/sign/directions/evac
	name = "evacuation sign"
	desc = "A direction sign, pointing out which way the escape shuttle dock is."
	icon_state = "direction_evac"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/evac, DEFAULT_OFFSET_Y_NORTH, DEFAULT_OFFSET_Y_SOUTH, DEFAULT_OFFSET_X, DEFAULT_OFFSET_X)

/obj/structure/sign/directions/supply
	name = "cargo sign"
	desc = "A direction sign, pointing out which way the Cargo Bay is."
	icon_state = "direction_supply"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/supply, DEFAULT_OFFSET_Y_NORTH, DEFAULT_OFFSET_Y_SOUTH, DEFAULT_OFFSET_X, DEFAULT_OFFSET_X)

/obj/structure/sign/directions/command
	name = "command department sign"
	desc = "A direction sign, pointing out which way the Command department is."
	icon_state = "direction_bridge"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/command, DEFAULT_OFFSET_Y_NORTH, DEFAULT_OFFSET_Y_SOUTH, DEFAULT_OFFSET_X, DEFAULT_OFFSET_X)

/obj/structure/sign/directions/vault
	name = "vault sign"
	desc = "A direction sign, pointing out which way the station's Vault is."
	icon_state = "direction_vault"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/vault, DEFAULT_OFFSET_Y_NORTH, DEFAULT_OFFSET_Y_SOUTH, DEFAULT_OFFSET_X, DEFAULT_OFFSET_X)

/obj/structure/sign/directions/upload
	name = "upload sign"
	desc = "A direction sign, pointing out which way the station's AI Upload is."
	icon_state = "direction_upload"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/upload, DEFAULT_OFFSET_Y_NORTH, DEFAULT_OFFSET_Y_SOUTH, DEFAULT_OFFSET_X, DEFAULT_OFFSET_X)
