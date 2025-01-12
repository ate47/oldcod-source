#using scripts\core_common\postfx_shared;
#using scripts\core_common\util_shared;

#namespace filter;

// Namespace filter/filter_shared
// Params 0, eflags: 0x0
// Checksum 0x8ec21f52, Offset: 0x200
// Size: 0x14
function init_filter_indices() {
    util::function_2170ff73();
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0x2ba635fc, Offset: 0x220
// Size: 0x3e
function map_material_helper_by_localclientnum(localclientnum, materialname) {
    level.filter_matid[materialname] = mapmaterialindex(localclientnum, materialname);
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0x77d6c9d5, Offset: 0x268
// Size: 0x4c
function map_material_if_undefined(localclientnum, materialname) {
    if (isdefined(mapped_material_id(materialname))) {
        return;
    }
    map_material_helper_by_localclientnum(localclientnum, materialname);
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0x9299ebbf, Offset: 0x2c0
// Size: 0x3c
function map_material_helper(player, materialname) {
    if (!isdefined(player)) {
        return;
    }
    map_material_helper_by_localclientnum(player.localclientnum, materialname);
}

// Namespace filter/filter_shared
// Params 1, eflags: 0x0
// Checksum 0x9ce86bf6, Offset: 0x308
// Size: 0x38
function mapped_material_id(materialname) {
    if (!isdefined(level.filter_matid)) {
        level.filter_matid = [];
    }
    return level.filter_matid[materialname];
}

// Namespace filter/filter_shared
// Params 4, eflags: 0x0
// Checksum 0xee28ca3a, Offset: 0x348
// Size: 0x84
function function_db745966(player, filterid, pass, enable) {
    if (!isdefined(player)) {
        return;
    }
    util::function_2170ff73();
    if (isdefined(player)) {
        num = player.localclientnum;
        setfilterpassenabled(num, filterid, pass, enable);
    }
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0xe0370212, Offset: 0x3d8
// Size: 0x54
function init_filter_vehicle_damage(player, materialname) {
    init_filter_indices();
    if (!isdefined(level.filter_matid[materialname])) {
        map_material_helper(player, materialname);
    }
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0xc238c98c, Offset: 0x438
// Size: 0x44
function set_filter_vehicle_damage_amount(player, filterid, amount) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 0, amount);
}

// Namespace filter/filter_shared
// Params 4, eflags: 0x0
// Checksum 0x1e4191bb, Offset: 0x488
// Size: 0x74
function set_filter_vehicle_sun_position(player, filterid, x, y) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 4, x);
    setfilterpassconstant(player.localclientnum, filterid, 0, 5, y);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x891da49c, Offset: 0x508
// Size: 0x84
function enable_filter_vehicle_damage(player, filterid, materialname) {
    if (isdefined(level.filter_matid[materialname])) {
        setfilterpassmaterial(player.localclientnum, filterid, 0, level.filter_matid[materialname]);
        function_db745966(player, filterid, 0, 1);
    }
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0xdc27f86, Offset: 0x598
// Size: 0x44
function disable_filter_vehicle_damage(player, filterid) {
    util::function_2170ff73();
    function_db745966(player, filterid, 0, 0);
}

// Namespace filter/filter_shared
// Params 1, eflags: 0x0
// Checksum 0x76992f8c, Offset: 0x5e8
// Size: 0x3c
function init_filter_oob(player) {
    init_filter_indices();
    map_material_helper(player, "generic_filter_out_of_bounds");
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0xd235503a, Offset: 0x630
// Size: 0x6c
function enable_filter_oob(player, filterid) {
    setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_out_of_bounds"));
    function_db745966(player, filterid, 0, 1);
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0x53105063, Offset: 0x6a8
// Size: 0x34
function disable_filter_oob(player, filterid) {
    function_db745966(player, filterid, 0, 0);
}

// Namespace filter/filter_shared
// Params 1, eflags: 0x0
// Checksum 0x8a608108, Offset: 0x6e8
// Size: 0x3c
function init_filter_tactical(player) {
    init_filter_indices();
    map_material_helper(player, "generic_filter_tactical_damage");
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0x6654c62d, Offset: 0x730
// Size: 0x6c
function enable_filter_tactical(player, filterid) {
    setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_tactical_damage"));
    function_db745966(player, filterid, 0, 1);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x1b12d380, Offset: 0x7a8
// Size: 0x44
function set_filter_tactical_amount(player, filterid, amount) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 0, amount);
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0x27013de7, Offset: 0x7f8
// Size: 0x34
function disable_filter_tactical(player, filterid) {
    function_db745966(player, filterid, 0, 0);
}

// Namespace filter/filter_shared
// Params 1, eflags: 0x0
// Checksum 0x2b7d37f9, Offset: 0x838
// Size: 0x3c
function init_filter_water_sheeting(player) {
    init_filter_indices();
    map_material_helper(player, "generic_filter_water_sheeting");
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0x7c94f032, Offset: 0x880
// Size: 0x7c
function enable_filter_water_sheeting(player, filterid) {
    setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_water_sheeting"));
    setfilterpassenabled(player.localclientnum, filterid, 0, 1, 0, 1);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x2d414c8f, Offset: 0x908
// Size: 0x44
function set_filter_water_sheet_reveal(player, filterid, amount) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 0, amount);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x8893f53f, Offset: 0x958
// Size: 0x44
function set_filter_water_sheet_speed(player, filterid, amount) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 1, amount);
}

// Namespace filter/filter_shared
// Params 5, eflags: 0x0
// Checksum 0x1c731e5c, Offset: 0x9a8
// Size: 0xa4
function set_filter_water_sheet_rivulet_reveal(player, filterid, riv1, riv2, riv3) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 2, riv1);
    setfilterpassconstant(player.localclientnum, filterid, 0, 3, riv2);
    setfilterpassconstant(player.localclientnum, filterid, 0, 4, riv3);
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0x483604dd, Offset: 0xa58
// Size: 0x34
function disable_filter_water_sheeting(player, filterid) {
    function_db745966(player, filterid, 0, 0);
}

// Namespace filter/filter_shared
// Params 1, eflags: 0x0
// Checksum 0x86ba76c3, Offset: 0xa98
// Size: 0x3c
function init_filter_water_dive(player) {
    init_filter_indices();
    map_material_helper(player, "generic_filter_water_dive");
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0x3a6e4191, Offset: 0xae0
// Size: 0x7c
function enable_filter_water_dive(player, filterid) {
    setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_water_dive"));
    setfilterpassenabled(player.localclientnum, filterid, 0, 1, 0, 1);
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0xa02e25f1, Offset: 0xb68
// Size: 0x34
function disable_filter_water_dive(player, filterid) {
    function_db745966(player, filterid, 0, 0);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x86d7f255, Offset: 0xba8
// Size: 0x44
function set_filter_water_dive_bubbles(player, filterid, amount) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 0, amount);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x75d7b91e, Offset: 0xbf8
// Size: 0x44
function set_filter_water_scuba_bubbles(player, filterid, amount) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 1, amount);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x827d3f7c, Offset: 0xc48
// Size: 0x44
function set_filter_water_scuba_dive_speed(player, filterid, amount) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 2, amount);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x5e393268, Offset: 0xc98
// Size: 0x44
function set_filter_water_scuba_bubble_attitude(player, filterid, amount) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 3, amount);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x6002b3c3, Offset: 0xce8
// Size: 0x44
function set_filter_water_wash_reveal_dir(player, filterid, dir) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 4, dir);
}

// Namespace filter/filter_shared
// Params 5, eflags: 0x0
// Checksum 0x538b3089, Offset: 0xd38
// Size: 0xa4
function set_filter_water_wash_color(player, filterid, red, green, blue) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 5, red);
    setfilterpassconstant(player.localclientnum, filterid, 0, 6, green);
    setfilterpassconstant(player.localclientnum, filterid, 0, 7, blue);
}

// Namespace filter/filter_shared
// Params 1, eflags: 0x0
// Checksum 0xafa44d1, Offset: 0xde8
// Size: 0x2c
function settransported(player) {
    player thread postfx::playpostfxbundle(#"zm_teleporter");
}

// Namespace filter/filter_shared
// Params 1, eflags: 0x0
// Checksum 0x1195fb9d, Offset: 0xe20
// Size: 0x3c
function init_filter_ev_interference(player) {
    init_filter_indices();
    map_material_helper(player, "generic_filter_ev_interference");
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0x23a7a68f, Offset: 0xe68
// Size: 0x94
function enable_filter_ev_interference(player, filterid) {
    map_material_if_undefined(player.localclientnum, "generic_filter_ev_interference");
    setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_ev_interference"));
    function_db745966(player, filterid, 0, 1);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x49219c31, Offset: 0xf08
// Size: 0x44
function set_filter_ev_interference_amount(player, filterid, amount) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 0, amount);
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0x48c10e00, Offset: 0xf58
// Size: 0x34
function disable_filter_ev_interference(player, filterid) {
    function_db745966(player, filterid, 0, 0);
}

// Namespace filter/filter_shared
// Params 1, eflags: 0x0
// Checksum 0x61e331d9, Offset: 0xf98
// Size: 0x3c
function init_filter_vehicle_hijack_oor(player) {
    init_filter_indices();
    map_material_helper(player, "generic_filter_vehicle_out_of_range");
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0x82e09a28, Offset: 0xfe0
// Size: 0x12c
function enable_filter_vehicle_hijack_oor(player, filterid) {
    setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_vehicle_out_of_range"));
    function_db745966(player, filterid, 0, 1);
    setfilterpassconstant(player.localclientnum, filterid, 0, 1, 0);
    setfilterpassconstant(player.localclientnum, filterid, 0, 2, 1);
    setfilterpassconstant(player.localclientnum, filterid, 0, 3, 0);
    setfilterpassconstant(player.localclientnum, filterid, 0, 4, -1);
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0xef906bf3, Offset: 0x1118
// Size: 0x44
function set_filter_vehicle_hijack_oor_noblack(player, filterid) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 3, 1);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x318bca3, Offset: 0x1168
// Size: 0x6c
function set_filter_vehicle_hijack_oor_amount(player, filterid, amount) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 0, amount);
    setfilterpassconstant(player.localclientnum, filterid, 0, 1, amount);
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0x97004e63, Offset: 0x11e0
// Size: 0x34
function disable_filter_vehicle_hijack_oor(player, filterid) {
    function_db745966(player, filterid, 0, 0);
}

// Namespace filter/filter_shared
// Params 1, eflags: 0x0
// Checksum 0x66d3a6ce, Offset: 0x1220
// Size: 0x3c
function init_filter_speed_burst(player) {
    init_filter_indices();
    map_material_helper(player, "generic_filter_speed_burst");
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0x4cfaee03, Offset: 0x1268
// Size: 0x6c
function enable_filter_speed_burst(player, filterid) {
    setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_speed_burst"));
    function_db745966(player, filterid, 0, 1);
}

// Namespace filter/filter_shared
// Params 4, eflags: 0x0
// Checksum 0xb3b4da43, Offset: 0x12e0
// Size: 0x4c
function set_filter_speed_burst(player, filterid, constantindex, amount) {
    setfilterpassconstant(player.localclientnum, filterid, 0, constantindex, amount);
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0x2ec9d5e, Offset: 0x1338
// Size: 0x34
function disable_filter_speed_burst(player, filterid) {
    function_db745966(player, filterid, 0, 0);
}

// Namespace filter/filter_shared
// Params 1, eflags: 0x0
// Checksum 0xe0976993, Offset: 0x1378
// Size: 0x3c
function init_filter_sprite_transition(player) {
    init_filter_indices();
    map_material_helper(player, "generic_filter_transition_sprite");
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0x93b20432, Offset: 0x13c0
// Size: 0x94
function enable_filter_sprite_transition(player, filterid) {
    setfilterpassmaterial(player.localclientnum, filterid, 1, mapped_material_id("generic_filter_transition_sprite"));
    function_db745966(player, filterid, 1, 1);
    setfilterpassquads(player.localclientnum, filterid, 1, 2048);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0xeb80410, Offset: 0x1460
// Size: 0x44
function set_filter_sprite_transition_octogons(player, filterid, octos) {
    setfilterpassconstant(player.localclientnum, filterid, 1, 0, octos);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x39aa465f, Offset: 0x14b0
// Size: 0x44
function set_filter_sprite_transition_blur(player, filterid, blur) {
    setfilterpassconstant(player.localclientnum, filterid, 1, 1, blur);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x3ce6282e, Offset: 0x1500
// Size: 0x44
function set_filter_sprite_transition_boost(player, filterid, boost) {
    setfilterpassconstant(player.localclientnum, filterid, 1, 2, boost);
}

// Namespace filter/filter_shared
// Params 4, eflags: 0x0
// Checksum 0x142aad3f, Offset: 0x1550
// Size: 0x74
function set_filter_sprite_transition_move_radii(player, filterid, inner, outter) {
    setfilterpassconstant(player.localclientnum, filterid, 1, 24, inner);
    setfilterpassconstant(player.localclientnum, filterid, 1, 25, outter);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0xe3185b2a, Offset: 0x15d0
// Size: 0x44
function set_filter_sprite_transition_elapsed(player, filterid, time) {
    setfilterpassconstant(player.localclientnum, filterid, 1, 28, time);
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0x924a9b8c, Offset: 0x1620
// Size: 0x34
function disable_filter_sprite_transition(player, filterid) {
    function_db745966(player, filterid, 1, 0);
}

// Namespace filter/filter_shared
// Params 1, eflags: 0x0
// Checksum 0x2fcdacee, Offset: 0x1660
// Size: 0x3c
function init_filter_frame_transition(player) {
    init_filter_indices();
    map_material_helper(player, "generic_filter_transition_frame");
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0xabb3c308, Offset: 0x16a8
// Size: 0x6c
function enable_filter_frame_transition(player, filterid) {
    setfilterpassmaterial(player.localclientnum, filterid, 2, mapped_material_id("generic_filter_transition_frame"));
    function_db745966(player, filterid, 2, 1);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x5d691fd1, Offset: 0x1720
// Size: 0x44
function set_filter_frame_transition_heavy_hexagons(player, filterid, hexes) {
    setfilterpassconstant(player.localclientnum, filterid, 2, 0, hexes);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x67784fcc, Offset: 0x1770
// Size: 0x44
function set_filter_frame_transition_light_hexagons(player, filterid, hexes) {
    setfilterpassconstant(player.localclientnum, filterid, 2, 1, hexes);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0xb5e3e948, Offset: 0x17c0
// Size: 0x44
function set_filter_frame_transition_flare(player, filterid, opacity) {
    setfilterpassconstant(player.localclientnum, filterid, 2, 2, opacity);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0xc17b3aeb, Offset: 0x1810
// Size: 0x44
function set_filter_frame_transition_blur(player, filterid, amount) {
    setfilterpassconstant(player.localclientnum, filterid, 2, 3, amount);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0xd25cf467, Offset: 0x1860
// Size: 0x44
function set_filter_frame_transition_iris(player, filterid, opacity) {
    setfilterpassconstant(player.localclientnum, filterid, 2, 4, opacity);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x49a2ee21, Offset: 0x18b0
// Size: 0x44
function set_filter_frame_transition_saved_frame_reveal(player, filterid, reveal) {
    setfilterpassconstant(player.localclientnum, filterid, 2, 5, reveal);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x62c28bda, Offset: 0x1900
// Size: 0x44
function set_filter_frame_transition_warp(player, filterid, amount) {
    setfilterpassconstant(player.localclientnum, filterid, 2, 6, amount);
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0xfabde2b7, Offset: 0x1950
// Size: 0x34
function disable_filter_frame_transition(player, filterid) {
    function_db745966(player, filterid, 2, 0);
}

// Namespace filter/filter_shared
// Params 1, eflags: 0x0
// Checksum 0xfd6f9f00, Offset: 0x1990
// Size: 0x3c
function init_filter_base_frame_transition(player) {
    init_filter_indices();
    map_material_helper(player, "generic_filter_transition_frame_base");
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0x8e2d78a5, Offset: 0x19d8
// Size: 0x6c
function enable_filter_base_frame_transition(player, filterid) {
    setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_transition_frame_base"));
    function_db745966(player, filterid, 0, 1);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x505adcd5, Offset: 0x1a50
// Size: 0x44
function set_filter_base_frame_transition_warp(player, filterid, warp) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 0, warp);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x6d1fb77a, Offset: 0x1aa0
// Size: 0x44
function set_filter_base_frame_transition_boost(player, filterid, boost) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 1, boost);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x90c91336, Offset: 0x1af0
// Size: 0x44
function set_filter_base_frame_transition_durden(player, filterid, opacity) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 2, opacity);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0xa4c4d4c9, Offset: 0x1b40
// Size: 0x44
function set_filter_base_frame_transition_durden_blur(player, filterid, blur) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 3, blur);
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0x758e7f95, Offset: 0x1b90
// Size: 0x34
function disable_filter_base_frame_transition(player, filterid) {
    function_db745966(player, filterid, 0, 0);
}

// Namespace filter/filter_shared
// Params 4, eflags: 0x0
// Checksum 0xc648352a, Offset: 0x1bd0
// Size: 0x44
function function_d8c6dc18(localclientnum, filterid, passid, opacity) {
    setfilterpassconstant(localclientnum, filterid, passid, 0, opacity);
}

// Namespace filter/filter_shared
// Params 1, eflags: 0x0
// Checksum 0x335b3d02, Offset: 0x1c20
// Size: 0x3c
function init_filter_sprite_rain(player) {
    init_filter_indices();
    map_material_helper(player, "generic_filter_sprite_rain");
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0xb1a206ad, Offset: 0x1c68
// Size: 0x94
function enable_filter_sprite_rain(player, filterid) {
    setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_sprite_rain"));
    function_db745966(player, filterid, 0, 1);
    setfilterpassquads(player.localclientnum, filterid, 0, 2048);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x590ffef4, Offset: 0x1d08
// Size: 0x44
function set_filter_sprite_rain_opacity(player, filterid, opacity) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 0, opacity);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0xfdbb4ca2, Offset: 0x1d58
// Size: 0x44
function set_filter_sprite_rain_seed_offset(player, filterid, offset) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 26, offset);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x1b6b92cf, Offset: 0x1da8
// Size: 0x44
function set_filter_sprite_rain_elapsed(player, filterid, time) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 28, time);
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0x4bfe1c, Offset: 0x1df8
// Size: 0x34
function disable_filter_sprite_rain(player, filterid) {
    function_db745966(player, filterid, 0, 0);
}

// Namespace filter/filter_shared
// Params 1, eflags: 0x0
// Checksum 0xbda62b2b, Offset: 0x1e38
// Size: 0x3c
function init_filter_sprite_dirt(player) {
    init_filter_indices();
    map_material_helper(player, "generic_filter_sprite_dirt");
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0xc4f943c0, Offset: 0x1e80
// Size: 0x94
function enable_filter_sprite_dirt(player, filterid) {
    setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_sprite_dirt"));
    function_db745966(player, filterid, 0, 1);
    setfilterpassquads(player.localclientnum, filterid, 0, 400);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x50d5f36e, Offset: 0x1f20
// Size: 0x44
function set_filter_sprite_dirt_opacity(player, filterid, opacity) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 0, opacity);
}

// Namespace filter/filter_shared
// Params 5, eflags: 0x0
// Checksum 0x5a64d202, Offset: 0x1f70
// Size: 0xa4
function set_filter_sprite_dirt_source_position(player, filterid, right, up, distance) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 1, right);
    setfilterpassconstant(player.localclientnum, filterid, 0, 2, up);
    setfilterpassconstant(player.localclientnum, filterid, 0, 3, distance);
}

// Namespace filter/filter_shared
// Params 4, eflags: 0x0
// Checksum 0x849f365a, Offset: 0x2020
// Size: 0x74
function set_filter_sprite_dirt_sun_position(player, filterid, pitch, yaw) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 4, pitch);
    setfilterpassconstant(player.localclientnum, filterid, 0, 5, yaw);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x8d2af328, Offset: 0x20a0
// Size: 0x44
function set_filter_sprite_dirt_seed_offset(player, filterid, offset) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 26, offset);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0xcff7d686, Offset: 0x20f0
// Size: 0x44
function set_filter_sprite_dirt_elapsed(player, filterid, time) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 28, time);
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0xfe9207bd, Offset: 0x2140
// Size: 0x34
function disable_filter_sprite_dirt(player, filterid) {
    function_db745966(player, filterid, 0, 0);
}

// Namespace filter/filter_shared
// Params 1, eflags: 0x0
// Checksum 0x5395ecc1, Offset: 0x2180
// Size: 0x3c
function init_filter_drowning_damage(localclientnum) {
    init_filter_indices();
    map_material_helper_by_localclientnum(localclientnum, "generic_filter_drowning");
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0x9ea57b56, Offset: 0x21c8
// Size: 0x6c
function enable_filter_drowning_damage(localclientnum, passid) {
    setfilterpassmaterial(localclientnum, 5, passid, mapped_material_id("generic_filter_drowning"));
    setfilterpassenabled(localclientnum, 5, passid, 1, 0, 1);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0xe3546b90, Offset: 0x2240
// Size: 0x3c
function set_filter_drowning_damage_opacity(localclientnum, passid, opacity) {
    setfilterpassconstant(localclientnum, 5, passid, 0, opacity);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x428d8f6c, Offset: 0x2288
// Size: 0x44
function set_filter_drowning_damage_inner_radius(localclientnum, passid, inner) {
    setfilterpassconstant(localclientnum, 5, passid, 1, inner);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x87ec9e38, Offset: 0x22d8
// Size: 0x44
function set_filter_drowning_damage_outer_radius(localclientnum, passid, outer) {
    setfilterpassconstant(localclientnum, 5, passid, 2, outer);
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0xcd2820b, Offset: 0x2328
// Size: 0x34
function disable_filter_drowning_damage(localclientnum, passid) {
    setfilterpassenabled(localclientnum, 5, passid, 0);
}

