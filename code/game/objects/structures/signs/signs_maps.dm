#define SIGN_DIR_NORTH "n"
#define SIGN_DIR_SOUTH "s"
#define SIGN_DIR_EAST "e"
#define SIGN_DIR_WEST "w"
#define SIGN_DIR_NORTHEAST "ne"
#define SIGN_DIR_NORTHWEST "nw"
#define SIGN_DIR_SOUTHEAST "se"
#define SIGN_DIR_SOUTHWEST "sw"
#define SUPPORT_LEFT "left"
#define SUPPORT_RIGHT "right"

// //map and direction signs

/obj/structure/sign/map
	name = "station map"
	desc = "A navigational chart of the station."
	max_integrity = 500

/obj/structure/sign/map/left
	icon_state = "map-left"

/obj/structure/sign/map/right
	icon_state = "map-right"

/obj/structure/sign/directions
	/// Temp variable, are we using arrows and support overlays to build the image as opposed to using a static directions sign.
	var/build_overlays = TRUE
	/// What direction is the arrow on the sign pointing?
	var/sign_arrow_direction = null
	/// If this sign has a support on the left or right, which side? null if niether
	var/support_side = null

/obj/structure/sign/directions/update_overlays()
	. = ..()
	if(!build_overlays)
		return
	if(sign_arrow_direction)
		. += "arrow_[sign_arrow_direction]"

/obj/structure/sign/directions/science
	name = "science department sign"
	desc = "A direction sign, pointing out which way the Science department is."
	icon_state = "direction_sci"

WALL_MOUNT_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/science)

/obj/structure/sign/directions/science/right
	support_side = SUPPORT_RIGHT

WALL_MOUNT_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/science/right)
/obj/structure/sign/directions/science/left
	support_side = SUPPORT_LEFT

WALL_MOUNT_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/science/left)

/obj/structure/sign/directions/engineering
	name = "engineering department sign"
	desc = "A direction sign, pointing out which way the Engineering department is."
	icon = 'icons/obj/engineering_sign.dmi'
	icon_state = "direction_eng"

DIRECTIONAL_SIGNS_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/engineering)

/obj/structure/sign/directions/engineering/right
	support_side = SUPPORT_RIGHT

DIRECTIONAL_SIGNS_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/engineering/right)
/obj/structure/sign/directions/engineering/left
	support_side = SUPPORT_LEFT

DIRECTIONAL_SIGNS_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/engineering/left)

/obj/structure/sign/directions/security
	name = "security department sign"
	desc = "A direction sign, pointing out which way the Security department is."
	icon_state = "direction_sec"

WALL_MOUNT_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/security)

/obj/structure/sign/directions/security/right
	support_side = SUPPORT_RIGHT

WALL_MOUNT_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/security/right)
/obj/structure/sign/directions/security/left
	support_side = SUPPORT_LEFT

WALL_MOUNT_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/security/left)

/obj/structure/sign/directions/medical
	name = "medbay sign"
	desc = "A direction sign, pointing out which way the Medbay is."
	icon_state = "direction_med"

WALL_MOUNT_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/medical)

/obj/structure/sign/directions/medical/right
	support_side = SUPPORT_RIGHT

WALL_MOUNT_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/medical/right)
/obj/structure/sign/directions/medical/left
	support_side = SUPPORT_LEFT

WALL_MOUNT_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/medical/left)

/obj/structure/sign/directions/evac
	name = "evacuation sign"
	desc = "A direction sign, pointing out which way the escape shuttle dock is."
	icon_state = "direction_evac"

WALL_MOUNT_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/evac)

/obj/structure/sign/directions/evac/right
	support_side = SUPPORT_RIGHT

WALL_MOUNT_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/evac/right)
/obj/structure/sign/directions/evac/left
	support_side = SUPPORT_LEFT

WALL_MOUNT_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/evac/left)

/obj/structure/sign/directions/supply
	name = "cargo sign"
	desc = "A direction sign, pointing out which way the Cargo Bay is."
	icon_state = "direction_supply"

WALL_MOUNT_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/supply)

/obj/structure/sign/directions/supply/right
	support_side = SUPPORT_RIGHT

WALL_MOUNT_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/supply/right)
/obj/structure/sign/directions/supply/left
	support_side = SUPPORT_LEFT

WALL_MOUNT_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/supply/left)

/obj/structure/sign/directions/command
	name = "command department sign"
	desc = "A direction sign, pointing out which way the Command department is."
	icon_state = "direction_bridge"

WALL_MOUNT_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/command)

/obj/structure/sign/directions/command/right
	support_side = SUPPORT_RIGHT

WALL_MOUNT_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/command/right)
/obj/structure/sign/directions/command/left
	support_side = SUPPORT_LEFT

WALL_MOUNT_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/command/left)

/obj/structure/sign/directions/vault
	name = "vault sign"
	desc = "A direction sign, pointing out which way the station's Vault is."
	icon_state = "direction_vault"

WALL_MOUNT_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/vault)

/obj/structure/sign/directions/vault/right
	support_side = SUPPORT_RIGHT

WALL_MOUNT_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/vault/right)
/obj/structure/sign/directions/vault/left
	support_side = SUPPORT_LEFT

WALL_MOUNT_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/vault/left)

/obj/structure/sign/directions/upload
	name = "upload sign"
	desc = "A direction sign, pointing out which way the station's AI Upload is."
	icon_state = "direction_upload"

WALL_MOUNT_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/upload)

/obj/structure/sign/directions/upload/right
	support_side = SUPPORT_RIGHT

WALL_MOUNT_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/upload/right)
/obj/structure/sign/directions/upload/left
	support_side = SUPPORT_LEFT

WALL_MOUNT_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/upload/left)

/obj/structure/sign/directions/dorms
	name = "dormitories sign"
	desc = "A direction sign, pointing out which way the dormitories are."
	icon_state = "direction_dorms"

WALL_MOUNT_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/dorms)

/obj/structure/sign/directions/dorms/right
	support_side = SUPPORT_RIGHT

WALL_MOUNT_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/dorms/right)
/obj/structure/sign/directions/dorms/left
	support_side = SUPPORT_LEFT

WALL_MOUNT_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/dorms/left)

/obj/structure/sign/directions/lavaland
	name = "lava sign"
	desc = "A direction sign, pointing out which way the hot stuff is."
	icon_state = "direction_lavaland"

WALL_MOUNT_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/lavaland)

/obj/structure/sign/directions/lavaland/right
	support_side = SUPPORT_RIGHT

WALL_MOUNT_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/lavaland/right)
/obj/structure/sign/directions/lavaland/left
	support_side = SUPPORT_LEFT

WALL_MOUNT_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/lavaland/left)

/obj/structure/sign/directions/arrival
	name = "arrivals sign"
	desc = "A direction sign, pointing out which way the arrivals shuttle dock is."
	icon_state = "direction_arrival"

WALL_MOUNT_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/arrival)

/obj/structure/sign/directions/arrival/right
	support_side = SUPPORT_RIGHT

WALL_MOUNT_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/arrival/right)
/obj/structure/sign/directions/arrival/left
	support_side = SUPPORT_LEFT

WALL_MOUNT_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/arrival/left)

/obj/structure/sign/directions/doornum
	name = "room number sign"
	desc = "A sign that states the labeled room's number."
	icon_state = "direction_doornum"

WALL_MOUNT_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/doornum)

/obj/structure/sign/directions/doornum/right
	icon_state = "direction_doornum_right"

WALL_MOUNT_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/doornum/right)
/obj/structure/sign/directions/doornum/left
	icon_state = "direction_doornum_left"

WALL_MOUNT_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/doornum/left)
