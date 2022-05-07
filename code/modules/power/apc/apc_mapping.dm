/obj/machinery/power/apc/unlocked
	locked = FALSE

/obj/machinery/power/apc/syndicate //general syndicate access
	req_access = list(ACCESS_SYNDICATE)

/obj/machinery/power/apc/away //general away mission access
	req_access = list(ACCESS_AWAY_GENERAL)

/obj/machinery/power/apc/highcap/five_k
	cell_type = /obj/item/stock_parts/cell/upgraded/plus

/obj/machinery/power/apc/highcap/ten_k
	cell_type = /obj/item/stock_parts/cell/high

/obj/machinery/power/apc/auto_name
	auto_name = TRUE

/obj/machinery/power/apc/sm_apc
	auto_name = TRUE
	cell_type = /obj/item/stock_parts/cell/high

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/power/apc/auto_name, offset_north, offset_south, offset_east, offset_west)
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/power/apc/five_k, offset_north, offset_south, offset_east, offset_west)
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/power/apc/ten_k, offset_north, offset_south, offset_east, offset_west)
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/power/apc/sm_apc, offset_north, offset_south, offset_east, offset_west)
