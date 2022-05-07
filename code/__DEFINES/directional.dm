// Byond direction defines, because I want to put them somewhere.
// #define NORTH 1
// #define SOUTH 2
// #define EAST 4
// #define WEST 8

/// North direction as a string "[1]"
#define TEXT_NORTH "[NORTH]"
/// South direction as a string "[2]"
#define TEXT_SOUTH "[SOUTH]"
/// East direction as a string "[4]"
#define TEXT_EAST "[EAST]"
/// West direction as a string "[8]"
#define TEXT_WEST "[WEST]"

/// Default wallmount north pixel offset
#define DEFAULT_OFFSET_Y_NORTH 32
/// Default wallmount south pixel offset
#define DEFAULT_OFFSET_Y_SOUTH 8
/// Default wallmount x pixel offset
#define DEFAULT_OFFSET_X 11

/// Inverse direction, taking into account UP|DOWN if necessary.
#define REVERSE_DIR(dir) ( ((dir & 85) << 1) | ((dir & 170) >> 1) )

/// Create directional subtypes for a path to simplify mapping.
#define MAPPING_DIRECTIONAL_HELPERS(path, offset_north, offset_south, offset_east, offset_west) \
##path/directional/north {\
	dir = SOUTH; \
	pixel_y = offset_north; \
} \
##path/directional/south {\
	dir = NORTH; \
	pixel_y = -offset_south; \
} \
##path/directional/east {\
	dir = WEST; \
	pixel_x = offset_east; \
} \
##path/directional/west {\
	dir = EAST; \
	pixel_x = -offset_west; \
}
