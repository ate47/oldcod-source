#using scripts/core_common/postfx_shared;

#namespace filter;

// Namespace filter/filter_shared
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x600
// Size: 0x4
function init_filter_indices() {
    
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0xcffcdcf2, Offset: 0x610
// Size: 0x3e
function map_material_helper_by_localclientnum(localclientnum, materialname) {
    level.filter_matid[materialname] = mapmaterialindex(localclientnum, materialname);
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0x7f0fe62d, Offset: 0x658
// Size: 0x4c
function map_material_if_undefined(localclientnum, materialname) {
    if (isdefined(mapped_material_id(materialname))) {
        return;
    }
    map_material_helper_by_localclientnum(localclientnum, materialname);
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0x98b5db07, Offset: 0x6b0
// Size: 0x34
function map_material_helper(player, materialname) {
    map_material_helper_by_localclientnum(player.localclientnum, materialname);
}

// Namespace filter/filter_shared
// Params 1, eflags: 0x0
// Checksum 0xca249a5c, Offset: 0x6f0
// Size: 0x3c
function mapped_material_id(materialname) {
    if (!isdefined(level.filter_matid)) {
        level.filter_matid = [];
    }
    return level.filter_matid[materialname];
}

// Namespace filter/filter_shared
// Params 1, eflags: 0x0
// Checksum 0xcb008795, Offset: 0x738
// Size: 0x3c
function function_987d4651(player) {
    init_filter_indices();
    map_material_helper(player, "generic_filter_binoculars");
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0xf0f154b7, Offset: 0x780
// Size: 0x7c
function function_93df2062(player, filterid, var_5a938650) {
    setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_binoculars"));
    setfilterpassenabled(player.localclientnum, filterid, 0, 1);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0xe6353401, Offset: 0x808
// Size: 0x44
function function_1aba1139(player, filterid, var_5a938650) {
    setfilterpassenabled(player.localclientnum, filterid, 0, 0);
}

// Namespace filter/filter_shared
// Params 1, eflags: 0x0
// Checksum 0x95fbe4b8, Offset: 0x858
// Size: 0x3c
function function_458cab93(player) {
    init_filter_indices();
    map_material_helper(player, "generic_filter_binoculars_with_outline");
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0xd40ba6c9, Offset: 0x8a0
// Size: 0x7c
function function_148ad096(player, filterid, var_5a938650) {
    setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_binoculars_with_outline"));
    setfilterpassenabled(player.localclientnum, filterid, 0, 1);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x82258826, Offset: 0x928
// Size: 0x44
function function_493fa18b(player, filterid, var_5a938650) {
    setfilterpassenabled(player.localclientnum, filterid, 0, 0);
}

// Namespace filter/filter_shared
// Params 1, eflags: 0x0
// Checksum 0x1c6ca2b5, Offset: 0x978
// Size: 0xbc
function function_932d212a(player) {
    init_filter_indices();
    map_material_helper(player, "generic_filter_hazmat");
    map_material_helper(player, "generic_overlay_hazmat_1");
    map_material_helper(player, "generic_overlay_hazmat_2");
    map_material_helper(player, "generic_overlay_hazmat_3");
    map_material_helper(player, "generic_overlay_hazmat_4");
}

// Namespace filter/filter_shared
// Params 4, eflags: 0x0
// Checksum 0x7be0dab1, Offset: 0xa40
// Size: 0x74
function function_220254d4(player, filterid, var_5a938650, opacity) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 0, opacity);
    setoverlayconstant(player.localclientnum, var_5a938650, 0, opacity);
}

// Namespace filter/filter_shared
// Params 5, eflags: 0x0
// Checksum 0x8d9da72b, Offset: 0xac0
// Size: 0x214
function function_e063bf35(player, filterid, var_5a938650, stage, opacity) {
    setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_hazmat"));
    setfilterpassenabled(player.localclientnum, filterid, 0, 1);
    if (stage == 1) {
        setoverlaymaterial(player.localclientnum, var_5a938650, mapped_material_id("generic_overlay_hazmat_1"), 1);
    } else if (stage == 2) {
        setoverlaymaterial(player.localclientnum, var_5a938650, mapped_material_id("generic_overlay_hazmat_2"), 1);
    } else if (stage == 3) {
        setoverlaymaterial(player.localclientnum, var_5a938650, mapped_material_id("generic_overlay_hazmat_3"), 1);
    } else if (stage == 4) {
        setoverlaymaterial(player.localclientnum, var_5a938650, mapped_material_id("generic_overlay_hazmat_4"), 1);
    }
    setoverlayenabled(player.localclientnum, var_5a938650, 1);
    function_220254d4(player, filterid, var_5a938650, opacity);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0xe54b96b3, Offset: 0xce0
// Size: 0x6c
function function_75d85722(player, filterid, var_5a938650) {
    setfilterpassenabled(player.localclientnum, filterid, 0, 0);
    setoverlayenabled(player.localclientnum, var_5a938650, 0);
}

// Namespace filter/filter_shared
// Params 1, eflags: 0x0
// Checksum 0xdca8ca13, Offset: 0xd58
// Size: 0x5c
function function_5a922e24(player) {
    init_filter_indices();
    map_material_helper(player, "generic_filter_helmet");
    map_material_helper(player, "generic_overlay_helmet");
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0xfc8616fe, Offset: 0xdc0
// Size: 0xe4
function function_cee27707(player, filterid, var_5a938650) {
    setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_helmet"));
    setfilterpassenabled(player.localclientnum, filterid, 0, 1);
    setoverlaymaterial(player.localclientnum, var_5a938650, mapped_material_id("generic_overlay_helmet"), 1);
    setoverlayenabled(player.localclientnum, var_5a938650, 1);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0xd31cc961, Offset: 0xeb0
// Size: 0x6c
function function_fd9ab75c(player, filterid, var_5a938650) {
    setfilterpassenabled(player.localclientnum, filterid, 0, 0);
    setoverlayenabled(player.localclientnum, var_5a938650, 0);
}

// Namespace filter/filter_shared
// Params 1, eflags: 0x0
// Checksum 0xacce996c, Offset: 0xf28
// Size: 0x3c
function function_10dc6ea8(player) {
    init_filter_indices();
    map_material_helper(player, "generic_overlay_tacticalmask");
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0x28ddd4b5, Offset: 0xf70
// Size: 0x74
function function_40b0197b(player, filterid) {
    setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_overlay_tacticalmask"));
    setfilterpassenabled(player.localclientnum, filterid, 0, 1);
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0x7c787bc7, Offset: 0xff0
// Size: 0x3c
function function_25548a10(player, filterid) {
    setfilterpassenabled(player.localclientnum, filterid, 0, 0);
}

// Namespace filter/filter_shared
// Params 1, eflags: 0x0
// Checksum 0x39e8674b, Offset: 0x1038
// Size: 0x3c
function function_90159c32(player) {
    init_filter_indices();
    map_material_helper(player, "generic_filter_hud_projected_grid");
}

// Namespace filter/filter_shared
// Params 1, eflags: 0x0
// Checksum 0xff11df08, Offset: 0x1080
// Size: 0x3c
function function_6db44c5c(player) {
    init_filter_indices();
    map_material_helper(player, "generic_filter_hud_projected_grid_haiti");
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x47d02002, Offset: 0x10c8
// Size: 0x44
function function_cf709d74(player, filterid, amount) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 0, amount);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x356bed46, Offset: 0x1118
// Size: 0x4c
function function_e2be8307(player, filterid, amount) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 1, amount);
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0x60548c7c, Offset: 0x1170
// Size: 0xb4
function function_5d6f61d9(player, filterid) {
    setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_hud_projected_grid"));
    setfilterpassenabled(player.localclientnum, filterid, 0, 1);
    player function_cf709d74(player, filterid, 500);
    player function_e2be8307(player, filterid, 200);
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0x3f5fd953, Offset: 0x1230
// Size: 0xb4
function function_b5049b53(player, filterid) {
    setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_hud_projected_grid_haiti"));
    setfilterpassenabled(player.localclientnum, filterid, 0, 1);
    player function_cf709d74(player, filterid, 500);
    player function_e2be8307(player, filterid, 200);
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0xf1e78425, Offset: 0x12f0
// Size: 0x3c
function function_1fd7d8fa(player, filterid) {
    setfilterpassenabled(player.localclientnum, filterid, 0, 0);
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0x6bcdd503, Offset: 0x1338
// Size: 0x44
function function_3ede9623(player, materialname) {
    init_filter_indices();
    map_material_helper(player, "generic_filter_emp_damage");
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0xdfbb9d2e, Offset: 0x1388
// Size: 0x44
function function_65003376(player, filterid, amount) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 0, amount);
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0x8892480b, Offset: 0x13d8
// Size: 0x74
function function_714b3e9e(player, filterid) {
    setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_emp_damage"));
    setfilterpassenabled(player.localclientnum, filterid, 0, 1);
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0x330158d8, Offset: 0x1458
// Size: 0x3c
function function_a32e572b(player, filterid) {
    setfilterpassenabled(player.localclientnum, filterid, 0, 0);
}

// Namespace filter/filter_shared
// Params 1, eflags: 0x0
// Checksum 0x26f3a5f6, Offset: 0x14a0
// Size: 0x3c
function function_5c4aeccd(player) {
    init_filter_indices();
    map_material_helper(player, "generic_filter_raindrops");
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x2995ad2, Offset: 0x14e8
// Size: 0x44
function function_bb250e0(player, filterid, amount) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 0, amount);
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0xfacd99d2, Offset: 0x1538
// Size: 0xbc
function function_a40f9ac8(player, filterid) {
    setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_raindrops"));
    setfilterpassenabled(player.localclientnum, filterid, 0, 1);
    setfilterpassquads(player.localclientnum, filterid, 0, 400);
    function_bb250e0(player, filterid, 1);
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0xbe9cc45b, Offset: 0x1600
// Size: 0x3c
function function_7da78a75(player, filterid) {
    setfilterpassenabled(player.localclientnum, filterid, 0, 0);
}

// Namespace filter/filter_shared
// Params 1, eflags: 0x0
// Checksum 0x8a3fb1ad, Offset: 0x1648
// Size: 0x3c
function function_c12b34cf(player) {
    init_filter_indices();
    map_material_helper(player, "generic_filter_squirrel_raindrops");
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0xb032b922, Offset: 0x1690
// Size: 0x44
function function_9311ebba(player, filterid, amount) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 0, amount);
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0x30025c2c, Offset: 0x16e0
// Size: 0xbc
function function_c1f28aa0(player, filterid) {
    setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_squirrel_raindrops"));
    setfilterpassenabled(player.localclientnum, filterid, 0, 1);
    setfilterpassquads(player.localclientnum, filterid, 0, 400);
    function_9311ebba(player, filterid, 1);
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0xad3fea57, Offset: 0x17a8
// Size: 0x3c
function function_e5a84437(player, filterid) {
    setfilterpassenabled(player.localclientnum, filterid, 0, 0);
}

// Namespace filter/filter_shared
// Params 1, eflags: 0x0
// Checksum 0x4827f3d4, Offset: 0x17f0
// Size: 0x3c
function function_29c41029(player) {
    init_filter_indices();
    map_material_helper(player, "generic_filter_radialblur");
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0xdf0934fd, Offset: 0x1838
// Size: 0x44
function function_9d339d74(player, filterid, amount) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 0, amount);
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0x412fc16d, Offset: 0x1888
// Size: 0x94
function function_bc34f612(player, filterid) {
    setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_radialblur"));
    setfilterpassenabled(player.localclientnum, filterid, 0, 1);
    function_9d339d74(player, filterid, 1);
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0x6701aee8, Offset: 0x1928
// Size: 0x3c
function function_1eef0721(player, filterid) {
    setfilterpassenabled(player.localclientnum, filterid, 0, 0);
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0xcd1e0a62, Offset: 0x1970
// Size: 0x54
function init_filter_vehicle_damage(player, materialname) {
    init_filter_indices();
    if (!isdefined(level.filter_matid[materialname])) {
        map_material_helper(player, materialname);
    }
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0xc1aae3dc, Offset: 0x19d0
// Size: 0x44
function set_filter_vehicle_damage_amount(player, filterid, amount) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 0, amount);
}

// Namespace filter/filter_shared
// Params 4, eflags: 0x0
// Checksum 0x4082ca4d, Offset: 0x1a20
// Size: 0x84
function set_filter_vehicle_sun_position(player, filterid, x, y) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 4, x);
    setfilterpassconstant(player.localclientnum, filterid, 0, 5, y);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x4725b021, Offset: 0x1ab0
// Size: 0x8c
function enable_filter_vehicle_damage(player, filterid, materialname) {
    if (isdefined(level.filter_matid[materialname])) {
        setfilterpassmaterial(player.localclientnum, filterid, 0, level.filter_matid[materialname]);
        setfilterpassenabled(player.localclientnum, filterid, 0, 1);
    }
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0xca9d313b, Offset: 0x1b48
// Size: 0x3c
function disable_filter_vehicle_damage(player, filterid) {
    setfilterpassenabled(player.localclientnum, filterid, 0, 0);
}

// Namespace filter/filter_shared
// Params 1, eflags: 0x0
// Checksum 0x4063a1de, Offset: 0x1b90
// Size: 0x3c
function init_filter_oob(player) {
    init_filter_indices();
    map_material_helper(player, "generic_filter_out_of_bounds");
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0xc3d681c5, Offset: 0x1bd8
// Size: 0x74
function enable_filter_oob(player, filterid) {
    setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_out_of_bounds"));
    setfilterpassenabled(player.localclientnum, filterid, 0, 1);
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0xd2e9dee5, Offset: 0x1c58
// Size: 0x3c
function disable_filter_oob(player, filterid) {
    setfilterpassenabled(player.localclientnum, filterid, 0, 0);
}

// Namespace filter/filter_shared
// Params 1, eflags: 0x0
// Checksum 0xbca5d38e, Offset: 0x1ca0
// Size: 0x3c
function init_filter_tactical(player) {
    init_filter_indices();
    map_material_helper(player, "generic_filter_tactical_damage");
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0xcd7c0dec, Offset: 0x1ce8
// Size: 0x74
function enable_filter_tactical(player, filterid) {
    setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_tactical_damage"));
    setfilterpassenabled(player.localclientnum, filterid, 0, 1);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x4159bfec, Offset: 0x1d68
// Size: 0x44
function set_filter_tactical_amount(player, filterid, amount) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 0, amount);
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0xd6b6302e, Offset: 0x1db8
// Size: 0x3c
function disable_filter_tactical(player, filterid) {
    setfilterpassenabled(player.localclientnum, filterid, 0, 0);
}

// Namespace filter/filter_shared
// Params 1, eflags: 0x0
// Checksum 0xba5c3f32, Offset: 0x1e00
// Size: 0x3c
function init_filter_water_sheeting(player) {
    init_filter_indices();
    map_material_helper(player, "generic_filter_water_sheeting");
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0x7c1e882, Offset: 0x1e48
// Size: 0x7c
function enable_filter_water_sheeting(player, filterid) {
    setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_water_sheeting"));
    setfilterpassenabled(player.localclientnum, filterid, 0, 1, 0, 1);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x74f6fa34, Offset: 0x1ed0
// Size: 0x44
function set_filter_water_sheet_reveal(player, filterid, amount) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 0, amount);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0xc9649683, Offset: 0x1f20
// Size: 0x4c
function set_filter_water_sheet_speed(player, filterid, amount) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 1, amount);
}

// Namespace filter/filter_shared
// Params 5, eflags: 0x0
// Checksum 0x26d850ab, Offset: 0x1f78
// Size: 0xbc
function set_filter_water_sheet_rivulet_reveal(player, filterid, riv1, riv2, riv3) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 2, riv1);
    setfilterpassconstant(player.localclientnum, filterid, 0, 3, riv2);
    setfilterpassconstant(player.localclientnum, filterid, 0, 4, riv3);
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0x57a0a39c, Offset: 0x2040
// Size: 0x3c
function disable_filter_water_sheeting(player, filterid) {
    setfilterpassenabled(player.localclientnum, filterid, 0, 0);
}

// Namespace filter/filter_shared
// Params 1, eflags: 0x0
// Checksum 0x9ed46fd9, Offset: 0x2088
// Size: 0x3c
function init_filter_water_dive(player) {
    init_filter_indices();
    map_material_helper(player, "generic_filter_water_dive");
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0xe98d51c8, Offset: 0x20d0
// Size: 0x7c
function enable_filter_water_dive(player, filterid) {
    setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_water_dive"));
    setfilterpassenabled(player.localclientnum, filterid, 0, 1, 0, 1);
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0xefa93401, Offset: 0x2158
// Size: 0x3c
function disable_filter_water_dive(player, filterid) {
    setfilterpassenabled(player.localclientnum, filterid, 0, 0);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x8b8796db, Offset: 0x21a0
// Size: 0x44
function set_filter_water_dive_bubbles(player, filterid, amount) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 0, amount);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x251e9aad, Offset: 0x21f0
// Size: 0x4c
function set_filter_water_scuba_bubbles(player, filterid, amount) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 1, amount);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x5974aaa8, Offset: 0x2248
// Size: 0x4c
function set_filter_water_scuba_dive_speed(player, filterid, amount) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 2, amount);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x2b718618, Offset: 0x22a0
// Size: 0x4c
function set_filter_water_scuba_bubble_attitude(player, filterid, amount) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 3, amount);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x916262bd, Offset: 0x22f8
// Size: 0x4c
function set_filter_water_wash_reveal_dir(player, filterid, dir) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 4, dir);
}

// Namespace filter/filter_shared
// Params 5, eflags: 0x0
// Checksum 0xb1d0f37b, Offset: 0x2350
// Size: 0xbc
function set_filter_water_wash_color(player, filterid, red, green, blue) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 5, red);
    setfilterpassconstant(player.localclientnum, filterid, 0, 6, green);
    setfilterpassconstant(player.localclientnum, filterid, 0, 7, blue);
}

// Namespace filter/filter_shared
// Params 1, eflags: 0x0
// Checksum 0x38fb9366, Offset: 0x2418
// Size: 0x3c
function function_f44c9dd9(player) {
    init_filter_indices();
    map_material_helper(player, "generic_filter_teleportation");
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0xf1c6d307, Offset: 0x2460
// Size: 0x74
function function_7a91bae8(player, filterid) {
    setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_teleportation"));
    setfilterpassenabled(player.localclientnum, filterid, 0, 1);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0xe3e55dc0, Offset: 0x24e0
// Size: 0x44
function function_2cf71d91(player, filterid, amount) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 0, amount);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0xf4d37cb6, Offset: 0x2530
// Size: 0x4c
function function_7fb9bb44(player, filterid, amount) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 6, amount);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x14877d02, Offset: 0x2588
// Size: 0x4c
function function_938a88fe(player, filterid, amount) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 1, amount);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x167b5d9f, Offset: 0x25e0
// Size: 0x4c
function function_c90d3ae3(player, filterid, amount) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 7, amount);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x6d89bcb4, Offset: 0x2638
// Size: 0x4c
function function_90153eb8(player, filterid, radius) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 2, radius);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x8e332683, Offset: 0x2690
// Size: 0x4c
function function_9c9024f5(player, filterid, amount) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 3, amount);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0xfb1fb9d9, Offset: 0x26e8
// Size: 0x4c
function function_1784e1d4(player, filterid, direction) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 4, direction);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x46734144, Offset: 0x2740
// Size: 0x4c
function function_5972ebfe(player, filterid, threshold) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 5, threshold);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0xcd86ccf9, Offset: 0x2798
// Size: 0x4c
function function_f19a3b7d(player, filterid, amount) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 8, amount);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x923de31c, Offset: 0x27f0
// Size: 0x4c
function function_a0b3d7e5(player, filterid, set) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 9, set);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x73b5722b, Offset: 0x2848
// Size: 0x4c
function function_2b8f6ce9(player, filterid, amount) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 10, amount);
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0x6dcb1695, Offset: 0x28a0
// Size: 0x3c
function function_bb2096a1(player, filterid) {
    setfilterpassenabled(player.localclientnum, filterid, 0, 0);
}

// Namespace filter/filter_shared
// Params 1, eflags: 0x0
// Checksum 0x7993aa1, Offset: 0x28e8
// Size: 0x2c
function settransported(player) {
    player thread postfx::playpostfxbundle("zm_teleporter");
}

// Namespace filter/filter_shared
// Params 1, eflags: 0x0
// Checksum 0x866006b3, Offset: 0x2920
// Size: 0x3c
function init_filter_ev_interference(player) {
    init_filter_indices();
    map_material_helper(player, "generic_filter_ev_interference");
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0xa049ac38, Offset: 0x2968
// Size: 0x9c
function enable_filter_ev_interference(player, filterid) {
    map_material_if_undefined(player.localclientnum, "generic_filter_ev_interference");
    setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_ev_interference"));
    setfilterpassenabled(player.localclientnum, filterid, 0, 1);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0xdad24c30, Offset: 0x2a10
// Size: 0x44
function set_filter_ev_interference_amount(player, filterid, amount) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 0, amount);
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0xacd3436d, Offset: 0x2a60
// Size: 0x3c
function disable_filter_ev_interference(player, filterid) {
    setfilterpassenabled(player.localclientnum, filterid, 0, 0);
}

// Namespace filter/filter_shared
// Params 1, eflags: 0x0
// Checksum 0x48daa103, Offset: 0x2aa8
// Size: 0x52
function function_28c704c9(player) {
    init_filter_indices();
    map_material_helper(player, "generic_filter_vehicle_takeover");
    return mapped_material_id("generic_filter_vehicle_takeover");
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x890dc18d, Offset: 0x2b08
// Size: 0x7c
function function_9850a644(player, filterid, var_5a938650) {
    setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_vehicle_takeover"));
    setfilterpassenabled(player.localclientnum, filterid, 0, 1);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x79e94d64, Offset: 0x2b90
// Size: 0x44
function function_741de3d1(player, filterid, var_5a938650) {
    setfilterpassenabled(player.localclientnum, filterid, 0, 0);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x95216e67, Offset: 0x2be0
// Size: 0x44
function function_18e6d33a(player, filterid, amount) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 0, amount);
}

// Namespace filter/filter_shared
// Params 1, eflags: 0x0
// Checksum 0x5618aab1, Offset: 0x2c30
// Size: 0x3c
function init_filter_vehicle_hijack_oor(player) {
    init_filter_indices();
    map_material_helper(player, "generic_filter_vehicle_out_of_range");
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0x5e4124ee, Offset: 0x2c78
// Size: 0x134
function enable_filter_vehicle_hijack_oor(player, filterid) {
    setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_vehicle_out_of_range"));
    setfilterpassenabled(player.localclientnum, filterid, 0, 1);
    setfilterpassconstant(player.localclientnum, filterid, 0, 1, 0);
    setfilterpassconstant(player.localclientnum, filterid, 0, 2, 1);
    setfilterpassconstant(player.localclientnum, filterid, 0, 3, 0);
    setfilterpassconstant(player.localclientnum, filterid, 0, 4, -1);
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0x46aca016, Offset: 0x2db8
// Size: 0x44
function set_filter_vehicle_hijack_oor_noblack(player, filterid) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 3, 1);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0xbf5d9cf1, Offset: 0x2e08
// Size: 0x74
function set_filter_vehicle_hijack_oor_amount(player, filterid, amount) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 0, amount);
    setfilterpassconstant(player.localclientnum, filterid, 0, 1, amount);
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0x9dc0fe8e, Offset: 0x2e88
// Size: 0x3c
function disable_filter_vehicle_hijack_oor(player, filterid) {
    setfilterpassenabled(player.localclientnum, filterid, 0, 0);
}

// Namespace filter/filter_shared
// Params 1, eflags: 0x0
// Checksum 0x30ef7871, Offset: 0x2ed0
// Size: 0x3c
function init_filter_speed_burst(player) {
    init_filter_indices();
    map_material_helper(player, "generic_filter_speed_burst");
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0x2d09f95, Offset: 0x2f18
// Size: 0x74
function enable_filter_speed_burst(player, filterid) {
    setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_speed_burst"));
    setfilterpassenabled(player.localclientnum, filterid, 0, 1);
}

// Namespace filter/filter_shared
// Params 4, eflags: 0x0
// Checksum 0x748981ee, Offset: 0x2f98
// Size: 0x54
function set_filter_speed_burst(player, filterid, constantindex, amount) {
    setfilterpassconstant(player.localclientnum, filterid, 0, constantindex, amount);
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0xa65f4af6, Offset: 0x2ff8
// Size: 0x3c
function disable_filter_speed_burst(player, filterid) {
    setfilterpassenabled(player.localclientnum, filterid, 0, 0);
}

// Namespace filter/filter_shared
// Params 1, eflags: 0x0
// Checksum 0x44b8acd1, Offset: 0x3040
// Size: 0x4c
function init_filter_overdrive(player) {
    init_filter_indices();
    if (sessionmodeiscampaigngame()) {
        map_material_helper(player, "generic_filter_overdrive_cp");
    }
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0xcf97db6, Offset: 0x3098
// Size: 0x74
function enable_filter_overdrive(player, filterid) {
    setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_overdrive_cp"));
    setfilterpassenabled(player.localclientnum, filterid, 0, 1);
}

// Namespace filter/filter_shared
// Params 4, eflags: 0x0
// Checksum 0x48618c1f, Offset: 0x3118
// Size: 0x54
function function_4c32b68f(player, filterid, constantindex, amount) {
    setfilterpassconstant(player.localclientnum, filterid, 0, constantindex, amount);
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0x6cc0cf5, Offset: 0x3178
// Size: 0x3c
function disable_filter_overdrive(player, filterid) {
    setfilterpassenabled(player.localclientnum, filterid, 0, 0);
}

// Namespace filter/filter_shared
// Params 1, eflags: 0x0
// Checksum 0x73389b47, Offset: 0x31c0
// Size: 0x3c
function function_1b1d6213(localclientnum) {
    init_filter_indices();
    map_material_helper_by_localclientnum(localclientnum, "generic_filter_frost");
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0x6c066db7, Offset: 0x3208
// Size: 0x6c
function enable_filter_frost(localclientnum, filterid) {
    setfilterpassmaterial(localclientnum, filterid, 0, mapped_material_id("generic_filter_frost"));
    setfilterpassenabled(localclientnum, filterid, 0, 1, 0, 1);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x8b0e6499, Offset: 0x3280
// Size: 0x3c
function set_filter_frost_layer_one(localclientnum, filterid, amount) {
    setfilterpassconstant(localclientnum, filterid, 0, 0, amount);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x46603e5d, Offset: 0x32c8
// Size: 0x44
function set_filter_frost_layer_two(localclientnum, filterid, amount) {
    setfilterpassconstant(localclientnum, filterid, 0, 1, amount);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x91044552, Offset: 0x3318
// Size: 0x44
function set_filter_frost_reveal_direction(localclientnum, filterid, direction) {
    setfilterpassconstant(localclientnum, filterid, 0, 2, direction);
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0xc0dec7f8, Offset: 0x3368
// Size: 0x34
function disable_filter_frost(localclientnum, filterid) {
    setfilterpassenabled(localclientnum, filterid, 0, 0);
}

// Namespace filter/filter_shared
// Params 1, eflags: 0x0
// Checksum 0x789ff76a, Offset: 0x33a8
// Size: 0x3c
function init_filter_vision_pulse(localclientnum) {
    init_filter_indices();
    map_material_helper_by_localclientnum(localclientnum, "generic_filter_vision_pulse");
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0x8b5b4846, Offset: 0x33f0
// Size: 0x84
function enable_filter_vision_pulse(localclientnum, filterid) {
    map_material_if_undefined(localclientnum, "generic_filter_vision_pulse");
    setfilterpassmaterial(localclientnum, filterid, 0, mapped_material_id("generic_filter_vision_pulse"));
    setfilterpassenabled(localclientnum, filterid, 0, 1);
}

// Namespace filter/filter_shared
// Params 4, eflags: 0x0
// Checksum 0xb37a85d5, Offset: 0x3480
// Size: 0x4c
function set_filter_vision_pulse_constant(localclientnum, filterid, var_17e8cbc5, value) {
    setfilterpassconstant(localclientnum, filterid, 0, var_17e8cbc5, value);
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0xfba84fe5, Offset: 0x34d8
// Size: 0x34
function disable_filter_vision_pulse(localclientnum, filterid) {
    setfilterpassenabled(localclientnum, filterid, 0, 0);
}

// Namespace filter/filter_shared
// Params 1, eflags: 0x0
// Checksum 0xf75fee70, Offset: 0x3518
// Size: 0x3c
function init_filter_sprite_transition(player) {
    init_filter_indices();
    map_material_helper(player, "generic_filter_transition_sprite");
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0x49e68ca1, Offset: 0x3560
// Size: 0x9c
function enable_filter_sprite_transition(player, filterid) {
    setfilterpassmaterial(player.localclientnum, filterid, 1, mapped_material_id("generic_filter_transition_sprite"));
    setfilterpassenabled(player.localclientnum, filterid, 1, 1);
    setfilterpassquads(player.localclientnum, filterid, 1, 2048);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x5d5a615d, Offset: 0x3608
// Size: 0x4c
function set_filter_sprite_transition_octogons(player, filterid, octos) {
    setfilterpassconstant(player.localclientnum, filterid, 1, 0, octos);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x3dfcfed4, Offset: 0x3660
// Size: 0x4c
function set_filter_sprite_transition_blur(player, filterid, blur) {
    setfilterpassconstant(player.localclientnum, filterid, 1, 1, blur);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0xa0163bad, Offset: 0x36b8
// Size: 0x4c
function set_filter_sprite_transition_boost(player, filterid, boost) {
    setfilterpassconstant(player.localclientnum, filterid, 1, 2, boost);
}

// Namespace filter/filter_shared
// Params 4, eflags: 0x0
// Checksum 0x8ad0c338, Offset: 0x3710
// Size: 0x84
function set_filter_sprite_transition_move_radii(player, filterid, inner, outter) {
    setfilterpassconstant(player.localclientnum, filterid, 1, 24, inner);
    setfilterpassconstant(player.localclientnum, filterid, 1, 25, outter);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x9cf0f7a1, Offset: 0x37a0
// Size: 0x4c
function set_filter_sprite_transition_elapsed(player, filterid, time) {
    setfilterpassconstant(player.localclientnum, filterid, 1, 28, time);
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0xe3d8f8be, Offset: 0x37f8
// Size: 0x3c
function disable_filter_sprite_transition(player, filterid) {
    setfilterpassenabled(player.localclientnum, filterid, 1, 0);
}

// Namespace filter/filter_shared
// Params 1, eflags: 0x0
// Checksum 0xd965a3ae, Offset: 0x3840
// Size: 0x3c
function init_filter_frame_transition(player) {
    init_filter_indices();
    map_material_helper(player, "generic_filter_transition_frame");
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0x3926cb98, Offset: 0x3888
// Size: 0x74
function enable_filter_frame_transition(player, filterid) {
    setfilterpassmaterial(player.localclientnum, filterid, 2, mapped_material_id("generic_filter_transition_frame"));
    setfilterpassenabled(player.localclientnum, filterid, 2, 1);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0xac8e5d84, Offset: 0x3908
// Size: 0x4c
function set_filter_frame_transition_heavy_hexagons(player, filterid, hexes) {
    setfilterpassconstant(player.localclientnum, filterid, 2, 0, hexes);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x622d3aa5, Offset: 0x3960
// Size: 0x4c
function set_filter_frame_transition_light_hexagons(player, filterid, hexes) {
    setfilterpassconstant(player.localclientnum, filterid, 2, 1, hexes);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x32e7d968, Offset: 0x39b8
// Size: 0x4c
function set_filter_frame_transition_flare(player, filterid, opacity) {
    setfilterpassconstant(player.localclientnum, filterid, 2, 2, opacity);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x964b5edc, Offset: 0x3a10
// Size: 0x4c
function set_filter_frame_transition_blur(player, filterid, amount) {
    setfilterpassconstant(player.localclientnum, filterid, 2, 3, amount);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x676648f7, Offset: 0x3a68
// Size: 0x4c
function set_filter_frame_transition_iris(player, filterid, opacity) {
    setfilterpassconstant(player.localclientnum, filterid, 2, 4, opacity);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x24fc254d, Offset: 0x3ac0
// Size: 0x4c
function set_filter_frame_transition_saved_frame_reveal(player, filterid, reveal) {
    setfilterpassconstant(player.localclientnum, filterid, 2, 5, reveal);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x8fe76f11, Offset: 0x3b18
// Size: 0x4c
function set_filter_frame_transition_warp(player, filterid, amount) {
    setfilterpassconstant(player.localclientnum, filterid, 2, 6, amount);
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0xa1ab0077, Offset: 0x3b70
// Size: 0x3c
function disable_filter_frame_transition(player, filterid) {
    setfilterpassenabled(player.localclientnum, filterid, 2, 0);
}

// Namespace filter/filter_shared
// Params 1, eflags: 0x0
// Checksum 0x2f6c1cc0, Offset: 0x3bb8
// Size: 0x3c
function init_filter_base_frame_transition(player) {
    init_filter_indices();
    map_material_helper(player, "generic_filter_transition_frame_base");
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0x24549272, Offset: 0x3c00
// Size: 0x74
function enable_filter_base_frame_transition(player, filterid) {
    setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_transition_frame_base"));
    setfilterpassenabled(player.localclientnum, filterid, 0, 1);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x88439684, Offset: 0x3c80
// Size: 0x44
function set_filter_base_frame_transition_warp(player, filterid, warp) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 0, warp);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x3ecb5e65, Offset: 0x3cd0
// Size: 0x4c
function set_filter_base_frame_transition_boost(player, filterid, boost) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 1, boost);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x5c718c70, Offset: 0x3d28
// Size: 0x4c
function set_filter_base_frame_transition_durden(player, filterid, opacity) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 2, opacity);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x46552499, Offset: 0x3d80
// Size: 0x4c
function set_filter_base_frame_transition_durden_blur(player, filterid, blur) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 3, blur);
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0xbc34044, Offset: 0x3dd8
// Size: 0x3c
function disable_filter_base_frame_transition(player, filterid) {
    setfilterpassenabled(player.localclientnum, filterid, 0, 0);
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0x693dde1b, Offset: 0x3e20
// Size: 0x5c
function function_45b9cd7d(localclientnum, digitalblood) {
    if (digitalblood) {
        map_material_helper_by_localclientnum(localclientnum, "generic_filter_sprite_blood_damage_reaper");
        return;
    }
    map_material_helper_by_localclientnum(localclientnum, "generic_filter_sprite_blood_damage");
}

// Namespace filter/filter_shared
// Params 4, eflags: 0x0
// Checksum 0x27e010db, Offset: 0x3e88
// Size: 0xd4
function function_f6ff9686(localclientnum, filterid, passid, digitalblood) {
    if (digitalblood) {
        setfilterpassmaterial(localclientnum, filterid, passid, mapped_material_id("generic_filter_sprite_blood_damage_reaper"));
    } else {
        setfilterpassmaterial(localclientnum, filterid, passid, mapped_material_id("generic_filter_sprite_blood_damage"));
    }
    setfilterpassenabled(localclientnum, filterid, passid, 1);
    setfilterpassquads(localclientnum, filterid, passid, 400);
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0x688705e9, Offset: 0x3f68
// Size: 0x5c
function function_1532508d(localclientnum, digitalblood) {
    if (digitalblood) {
        map_material_helper_by_localclientnum(localclientnum, "generic_filter_sprite_blood_heavy_damage_reaper");
        return;
    }
    map_material_helper_by_localclientnum(localclientnum, "generic_filter_sprite_blood_heavy_damage");
}

// Namespace filter/filter_shared
// Params 4, eflags: 0x0
// Checksum 0x1fc4526e, Offset: 0x3fd0
// Size: 0xd4
function function_c4e616ee(localclientnum, filterid, passid, digitalblood) {
    if (digitalblood) {
        setfilterpassmaterial(localclientnum, filterid, passid, mapped_material_id("generic_filter_sprite_blood_heavy_damage_reaper"));
    } else {
        setfilterpassmaterial(localclientnum, filterid, passid, mapped_material_id("generic_filter_sprite_blood_heavy_damage"));
    }
    setfilterpassenabled(localclientnum, filterid, passid, 1);
    setfilterpassquads(localclientnum, filterid, passid, 400);
}

// Namespace filter/filter_shared
// Params 4, eflags: 0x0
// Checksum 0xdc73afde, Offset: 0x40b0
// Size: 0x4c
function function_c511e703(localclientnum, filterid, passid, opacity) {
    setfilterpassconstant(localclientnum, filterid, passid, 0, opacity);
}

// Namespace filter/filter_shared
// Params 4, eflags: 0x0
// Checksum 0xa8e8f0ef, Offset: 0x4108
// Size: 0x4c
function function_db8726c7(localclientnum, filterid, passid, offset) {
    setfilterpassconstant(localclientnum, filterid, passid, 26, offset);
}

// Namespace filter/filter_shared
// Params 4, eflags: 0x0
// Checksum 0xbde2b435, Offset: 0x4160
// Size: 0x4c
function function_5152516c(localclientnum, filterid, passid, time) {
    setfilterpassconstant(localclientnum, filterid, passid, 28, time);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x9ccd5d26, Offset: 0x41b8
// Size: 0x3c
function function_e8ee9075(localclientnum, filterid, passid) {
    setfilterpassenabled(localclientnum, filterid, passid, 0);
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0x45ac4b88, Offset: 0x4200
// Size: 0x6c
function function_cfe957f(localclientnum, digitalblood) {
    init_filter_indices();
    if (digitalblood) {
        map_material_helper_by_localclientnum(localclientnum, "generic_filter_blood_damage_reaper");
        return;
    }
    map_material_helper_by_localclientnum(localclientnum, "generic_filter_blood_damage");
}

// Namespace filter/filter_shared
// Params 4, eflags: 0x0
// Checksum 0xc573d123, Offset: 0x4278
// Size: 0xb4
function function_c6391b80(localclientnum, filterid, passid, digitalblood) {
    if (digitalblood) {
        setfilterpassmaterial(localclientnum, filterid, passid, mapped_material_id("generic_filter_blood_damage_reaper"));
    } else {
        setfilterpassmaterial(localclientnum, filterid, passid, mapped_material_id("generic_filter_blood_damage"));
    }
    setfilterpassenabled(localclientnum, filterid, passid, 1);
}

// Namespace filter/filter_shared
// Params 4, eflags: 0x0
// Checksum 0x32579efc, Offset: 0x4338
// Size: 0x4c
function function_f3adf179(localclientnum, filterid, passid, opacity) {
    setfilterpassconstant(localclientnum, filterid, passid, 0, opacity);
}

// Namespace filter/filter_shared
// Params 4, eflags: 0x0
// Checksum 0x8e181515, Offset: 0x4390
// Size: 0x4c
function function_dd2f5261(localclientnum, filterid, passid, var_9f19e07c) {
    setfilterpassconstant(localclientnum, filterid, passid, 6, var_9f19e07c);
}

// Namespace filter/filter_shared
// Params 5, eflags: 0x0
// Checksum 0xd6e990cd, Offset: 0x43e8
// Size: 0x7c
function function_ba8f6d71(localclientnum, filterid, passid, pitch, yaw) {
    setfilterpassconstant(localclientnum, filterid, passid, 1, pitch);
    setfilterpassconstant(localclientnum, filterid, passid, 2, yaw);
}

// Namespace filter/filter_shared
// Params 4, eflags: 0x0
// Checksum 0xfb32e373, Offset: 0x4470
// Size: 0x4c
function function_fd3a600(localclientnum, filterid, passid, amount) {
    setfilterpassconstant(localclientnum, filterid, passid, 3, amount);
}

// Namespace filter/filter_shared
// Params 5, eflags: 0x0
// Checksum 0x36d576e6, Offset: 0x44c8
// Size: 0x7c
function function_70dca458(localclientnum, filterid, passid, var_99833f4a, var_7b0c24f7) {
    setfilterpassconstant(localclientnum, filterid, passid, 4, var_99833f4a);
    setfilterpassconstant(localclientnum, filterid, passid, 5, var_7b0c24f7);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x4e668e16, Offset: 0x4550
// Size: 0x3c
function function_4a86fcb7(localclientnum, filterid, passid) {
    setfilterpassenabled(localclientnum, filterid, passid, 0);
}

// Namespace filter/filter_shared
// Params 1, eflags: 0x0
// Checksum 0xcbfec793, Offset: 0x4598
// Size: 0x3c
function init_filter_sprite_rain(player) {
    init_filter_indices();
    map_material_helper(player, "generic_filter_sprite_rain");
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0xd56bcca4, Offset: 0x45e0
// Size: 0x9c
function enable_filter_sprite_rain(player, filterid) {
    setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_sprite_rain"));
    setfilterpassenabled(player.localclientnum, filterid, 0, 1);
    setfilterpassquads(player.localclientnum, filterid, 0, 2048);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x7ce60425, Offset: 0x4688
// Size: 0x44
function set_filter_sprite_rain_opacity(player, filterid, opacity) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 0, opacity);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x88b8e41b, Offset: 0x46d8
// Size: 0x4c
function set_filter_sprite_rain_seed_offset(player, filterid, offset) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 26, offset);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x1bc8d56a, Offset: 0x4730
// Size: 0x4c
function set_filter_sprite_rain_elapsed(player, filterid, time) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 28, time);
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0x54d7d846, Offset: 0x4788
// Size: 0x3c
function disable_filter_sprite_rain(player, filterid) {
    setfilterpassenabled(player.localclientnum, filterid, 0, 0);
}

// Namespace filter/filter_shared
// Params 1, eflags: 0x0
// Checksum 0xc7fdf28, Offset: 0x47d0
// Size: 0x3c
function function_e4987221(player) {
    init_filter_indices();
    map_material_helper(player, "generic_filter_blkstn_sprite_rain");
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0xf061200e, Offset: 0x4818
// Size: 0x9c
function function_cd327356(player, filterid) {
    setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_blkstn_sprite_rain"));
    setfilterpassenabled(player.localclientnum, filterid, 0, 1);
    setfilterpassquads(player.localclientnum, filterid, 0, 2048);
}

// Namespace filter/filter_shared
// Params 1, eflags: 0x0
// Checksum 0x34a3f398, Offset: 0x48c0
// Size: 0x3c
function init_filter_sprite_dirt(player) {
    init_filter_indices();
    map_material_helper(player, "generic_filter_sprite_dirt");
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0x71eb8982, Offset: 0x4908
// Size: 0x9c
function enable_filter_sprite_dirt(player, filterid) {
    setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_sprite_dirt"));
    setfilterpassenabled(player.localclientnum, filterid, 0, 1);
    setfilterpassquads(player.localclientnum, filterid, 0, 400);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x38b785a8, Offset: 0x49b0
// Size: 0x44
function set_filter_sprite_dirt_opacity(player, filterid, opacity) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 0, opacity);
}

// Namespace filter/filter_shared
// Params 5, eflags: 0x0
// Checksum 0x84dc50c, Offset: 0x4a00
// Size: 0xbc
function set_filter_sprite_dirt_source_position(player, filterid, right, up, distance) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 1, right);
    setfilterpassconstant(player.localclientnum, filterid, 0, 2, up);
    setfilterpassconstant(player.localclientnum, filterid, 0, 3, distance);
}

// Namespace filter/filter_shared
// Params 4, eflags: 0x0
// Checksum 0xdd23d625, Offset: 0x4ac8
// Size: 0x84
function set_filter_sprite_dirt_sun_position(player, filterid, pitch, yaw) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 4, pitch);
    setfilterpassconstant(player.localclientnum, filterid, 0, 5, yaw);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x67afb3f4, Offset: 0x4b58
// Size: 0x4c
function set_filter_sprite_dirt_seed_offset(player, filterid, offset) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 26, offset);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0xac6af781, Offset: 0x4bb0
// Size: 0x4c
function set_filter_sprite_dirt_elapsed(player, filterid, time) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 28, time);
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0x2dadf131, Offset: 0x4c08
// Size: 0x3c
function disable_filter_sprite_dirt(player, filterid) {
    setfilterpassenabled(player.localclientnum, filterid, 0, 0);
}

// Namespace filter/filter_shared
// Params 1, eflags: 0x0
// Checksum 0xa0987c8, Offset: 0x4c50
// Size: 0x3c
function function_2c6745d7(player) {
    init_filter_indices();
    map_material_helper(player, "generic_filter_blood_spatter");
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0x61f00d8d, Offset: 0x4c98
// Size: 0x74
function function_aaeba942(player, filterid) {
    setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_blood_spatter"));
    setfilterpassenabled(player.localclientnum, filterid, 0, 1);
}

// Namespace filter/filter_shared
// Params 4, eflags: 0x0
// Checksum 0xca5cdba, Offset: 0x4d18
// Size: 0x7c
function function_3e6453dd(player, filterid, threshold, direction) {
    setfilterpassconstant(player.localclientnum, filterid, 0, 0, threshold);
    setfilterpassconstant(player.localclientnum, filterid, 0, 1, direction);
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0xac2c1a18, Offset: 0x4da0
// Size: 0x3c
function function_5dc1f50f(player, filterid) {
    setfilterpassenabled(player.localclientnum, filterid, 0, 0);
}

// Namespace filter/filter_shared
// Params 1, eflags: 0x0
// Checksum 0x54c4accf, Offset: 0x4de8
// Size: 0x3c
function function_52f1f1e9(player) {
    init_filter_indices();
    map_material_helper(player, "generic_filter_zm_teleporter_base");
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x630d88cb, Offset: 0x4e30
// Size: 0x7c
function function_4264d7a0(player, filterid, passid) {
    setfilterpassmaterial(player.localclientnum, filterid, passid, mapped_material_id("generic_filter_zm_teleporter_base"));
    setfilterpassenabled(player.localclientnum, filterid, passid, 1);
}

// Namespace filter/filter_shared
// Params 4, eflags: 0x0
// Checksum 0x90b99d95, Offset: 0x4eb8
// Size: 0x54
function function_534d04b4(player, filterid, passid, amount) {
    setfilterpassconstant(player.localclientnum, filterid, passid, 0, amount);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x8567fc9a, Offset: 0x4f18
// Size: 0x44
function function_f21915b1(player, filterid, passid) {
    setfilterpassenabled(player.localclientnum, filterid, passid, 0);
}

// Namespace filter/filter_shared
// Params 1, eflags: 0x0
// Checksum 0x7feaa6f2, Offset: 0x4f68
// Size: 0x3c
function function_c769801d(player) {
    init_filter_indices();
    map_material_helper(player, "generic_filter_zm_teleporter_sprite");
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x8c6adbcb, Offset: 0x4fb0
// Size: 0xa4
function function_4018823c(player, filterid, passid) {
    setfilterpassmaterial(player.localclientnum, filterid, passid, mapped_material_id("generic_filter_zm_teleporter_sprite"));
    setfilterpassenabled(player.localclientnum, filterid, passid, 1);
    setfilterpassquads(player.localclientnum, filterid, passid, 400);
}

// Namespace filter/filter_shared
// Params 4, eflags: 0x0
// Checksum 0x788fde82, Offset: 0x5060
// Size: 0x54
function function_62edec3(player, filterid, passid, opacity) {
    setfilterpassconstant(player.localclientnum, filterid, passid, 0, opacity);
}

// Namespace filter/filter_shared
// Params 4, eflags: 0x0
// Checksum 0x61d234d4, Offset: 0x50c0
// Size: 0x54
function function_21cbbd87(player, filterid, passid, offset) {
    setfilterpassconstant(player.localclientnum, filterid, passid, 26, offset);
}

// Namespace filter/filter_shared
// Params 4, eflags: 0x0
// Checksum 0x78c9c607, Offset: 0x5120
// Size: 0x54
function function_565f032c(player, filterid, passid, time) {
    setfilterpassconstant(player.localclientnum, filterid, passid, 28, time);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x9cd0e140, Offset: 0x5180
// Size: 0x44
function function_f0467a75(player, filterid, passid) {
    setfilterpassenabled(player.localclientnum, filterid, passid, 0);
}

// Namespace filter/filter_shared
// Params 1, eflags: 0x0
// Checksum 0xad31dbab, Offset: 0x51d0
// Size: 0x3c
function function_ebce407b(player) {
    init_filter_indices();
    map_material_helper(player, "generic_filter_zm_teleporter_base");
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x23909a43, Offset: 0x5218
// Size: 0x7c
function function_e927dc0c(player, filterid, passid) {
    setfilterpassmaterial(player.localclientnum, filterid, passid, mapped_material_id("generic_filter_zm_teleporter_base"));
    setfilterpassenabled(player.localclientnum, filterid, passid, 1);
}

// Namespace filter/filter_shared
// Params 5, eflags: 0x0
// Checksum 0xb6ab1465, Offset: 0x52a0
// Size: 0x8c
function function_d2305609(player, filterid, passid, threshold, direction) {
    setfilterpassconstant(player.localclientnum, filterid, passid, 0, threshold);
    setfilterpassconstant(player.localclientnum, filterid, passid, 1, direction);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x6b25a4d0, Offset: 0x5338
// Size: 0x44
function function_4f343c03(player, filterid, passid) {
    setfilterpassenabled(player.localclientnum, filterid, passid, 0);
}

// Namespace filter/filter_shared
// Params 1, eflags: 0x0
// Checksum 0x96326fa9, Offset: 0x5388
// Size: 0x3c
function function_73164cd2(player) {
    init_filter_indices();
    map_material_helper(player, "postfx_keyline_blend");
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x30178c3a, Offset: 0x53d0
// Size: 0x7c
function function_64955317(player, filterid, passid) {
    setfilterpassmaterial(player.localclientnum, filterid, passid, mapped_material_id("postfx_keyline_blend"));
    setfilterpassenabled(player.localclientnum, filterid, passid, 1);
}

// Namespace filter/filter_shared
// Params 4, eflags: 0x0
// Checksum 0xdd44dd73, Offset: 0x5458
// Size: 0x54
function function_bc7126cc(player, filterid, passid, opacity) {
    setfilterpassconstant(player.localclientnum, filterid, passid, 0, opacity);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x4a598ed9, Offset: 0x54b8
// Size: 0x44
function function_a349ad2a(player, filterid, passid) {
    setfilterpassenabled(player.localclientnum, filterid, passid, 0);
}

// Namespace filter/filter_shared
// Params 1, eflags: 0x0
// Checksum 0x5d124d27, Offset: 0x5508
// Size: 0x3c
function init_filter_drowning_damage(localclientnum) {
    init_filter_indices();
    map_material_helper_by_localclientnum(localclientnum, "generic_filter_drowning");
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0x7003460f, Offset: 0x5550
// Size: 0x6c
function enable_filter_drowning_damage(localclientnum, passid) {
    setfilterpassmaterial(localclientnum, 5, passid, mapped_material_id("generic_filter_drowning"));
    setfilterpassenabled(localclientnum, 5, passid, 1, 0, 1);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x2f60feed, Offset: 0x55c8
// Size: 0x44
function set_filter_drowning_damage_opacity(localclientnum, passid, opacity) {
    setfilterpassconstant(localclientnum, 5, passid, 0, opacity);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0xc373b1c4, Offset: 0x5618
// Size: 0x44
function set_filter_drowning_damage_inner_radius(localclientnum, passid, inner) {
    setfilterpassconstant(localclientnum, 5, passid, 1, inner);
}

// Namespace filter/filter_shared
// Params 3, eflags: 0x0
// Checksum 0x5ed58550, Offset: 0x5668
// Size: 0x44
function set_filter_drowning_damage_outer_radius(localclientnum, passid, outer) {
    setfilterpassconstant(localclientnum, 5, passid, 2, outer);
}

// Namespace filter/filter_shared
// Params 2, eflags: 0x0
// Checksum 0xc5ca3abc, Offset: 0x56b8
// Size: 0x34
function disable_filter_drowning_damage(localclientnum, passid) {
    setfilterpassenabled(localclientnum, 5, passid, 0);
}

