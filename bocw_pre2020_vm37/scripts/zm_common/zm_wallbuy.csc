#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;

#namespace zm_wallbuy;

// Namespace zm_wallbuy/zm_wallbuy
// Params 0, eflags: 0x6
// Checksum 0x991aa43e, Offset: 0x230
// Size: 0x54
function private autoexec __init__system__() {
    system::register(#"zm_wallbuy", &function_70a657d8, &postinit, undefined, #"zm");
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 0, eflags: 0x5 linked
// Checksum 0x2de836d0, Offset: 0x290
// Size: 0x144
function private function_70a657d8() {
    if (!getgametypesetting(#"zmwallbuysenabled")) {
        return;
    }
    level flag::init("weapon_wallbuys_created");
    level._effect[#"wallbuy_ambient_fx"] = "zombie/fx8_wallbuy_amb";
    level._effect[#"hash_6928ec90dff78e0c"] = "zombie/fx8_wallbuy_amb_reverse";
    level._effect[#"wallbuy_reveal_fx"] = "zombie/fx8_wallbuy_reveal";
    clientfield::register("scriptmover", "wallbuy_ambient_fx", 1, 3, "int", &function_51f5fb94, 0, 0);
    clientfield::register("scriptmover", "wallbuy_reveal_fx", 1, 1, "int", &function_5ed44212, 0, 0);
    init();
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 0, eflags: 0x5 linked
// Checksum 0xbc3bdee, Offset: 0x3e0
// Size: 0x28
function private postinit() {
    if (!getgametypesetting(#"zmwallbuysenabled")) {
        return;
    }
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 0, eflags: 0x1 linked
// Checksum 0x61f40192, Offset: 0x410
// Size: 0x7f4
function init() {
    spawn_list = [];
    spawnable_weapon_spawns = struct::get_array("weapon_upgrade", "targetname");
    spawnable_weapon_spawns = arraycombine(spawnable_weapon_spawns, struct::get_array("bowie_upgrade", "targetname"), 1, 0);
    spawnable_weapon_spawns = arraycombine(spawnable_weapon_spawns, struct::get_array("sickle_upgrade", "targetname"), 1, 0);
    spawnable_weapon_spawns = arraycombine(spawnable_weapon_spawns, struct::get_array("tazer_upgrade", "targetname"), 1, 0);
    spawnable_weapon_spawns = arraycombine(spawnable_weapon_spawns, struct::get_array("buildable_wallbuy", "targetname"), 1, 0);
    if (is_true(level.use_autofill_wallbuy)) {
        spawnable_weapon_spawns = arraycombine(spawnable_weapon_spawns, level.active_autofill_wallbuys, 1, 0);
    }
    if (!is_true(level.headshots_only)) {
        spawnable_weapon_spawns = arraycombine(spawnable_weapon_spawns, struct::get_array("claymore_purchase", "targetname"), 1, 0);
    }
    location = level.scr_zm_map_start_location;
    if ((location == "default" || location == "") && isdefined(level.default_start_location)) {
        location = level.default_start_location;
    }
    match_string = level.scr_zm_ui_gametype;
    if ("" != location) {
        match_string = match_string + "_" + location;
    }
    match_string_plus_space = " " + match_string;
    for (i = 0; i < spawnable_weapon_spawns.size; i++) {
        spawnable_weapon = spawnable_weapon_spawns[i];
        spawnable_weapon.weapon = getweapon(spawnable_weapon.zombie_weapon_upgrade);
        weapon_group = function_e2703c27(spawnable_weapon.weapon);
        if (weapon_group == #"weapon_pistol" && !getgametypesetting(#"zmweaponspistol") || weapon_group == #"weapon_cqb" && !getgametypesetting(#"zmweaponsshotgun") || weapon_group == #"weapon_smg" && !getgametypesetting(#"zmweaponssmg") || weapon_group == #"weapon_assault" && !getgametypesetting(#"zmweaponsar") || weapon_group == #"weapon_tactical" && !getgametypesetting(#"zmweaponstr") || weapon_group == #"weapon_lmg" && !getgametypesetting(#"zmweaponslmg") || weapon_group == #"weapon_sniper" && !getgametypesetting(#"zmweaponssniper") || weapon_group == #"weapon_knife" && !getgametypesetting(#"zmweaponsknife")) {
            continue;
        }
        if (isdefined(spawnable_weapon.zombie_weapon_upgrade) && spawnable_weapon.weapon.isgrenadeweapon && is_true(level.headshots_only)) {
            continue;
        }
        if (!isdefined(spawnable_weapon.script_noteworthy) || spawnable_weapon.script_noteworthy == "") {
            spawn_list[spawn_list.size] = spawnable_weapon;
            continue;
        }
        matches = strtok(spawnable_weapon.script_noteworthy, ",");
        for (j = 0; j < matches.size; j++) {
            if (matches[j] == match_string || matches[j] == match_string_plus_space) {
                spawn_list[spawn_list.size] = spawnable_weapon;
            }
        }
    }
    level._active_wallbuys = [];
    for (i = 0; i < spawn_list.size; i++) {
        spawn_list[i].script_label = spawn_list[i].zombie_weapon_upgrade + "_" + spawn_list[i].origin;
        level._active_wallbuys[spawn_list[i].script_label] = spawn_list[i];
        numbits = 2;
        if (isdefined(level._wallbuy_override_num_bits)) {
            numbits = level._wallbuy_override_num_bits;
        }
        clientfield::register("world", spawn_list[i].script_label, 1, numbits, "int", &wallbuy_callback, 0, 1);
        target_struct = struct::get(spawn_list[i].target, "targetname");
        if (spawn_list[i].targetname == "buildable_wallbuy") {
            bits = 4;
            if (isdefined(level.buildable_wallbuy_weapons)) {
                bits = getminbitcountfornum(level.buildable_wallbuy_weapons.size + 1);
            }
            clientfield::register("world", spawn_list[i].script_label + "_idx", 1, bits, "int", &wallbuy_callback_idx, 0, 1);
        }
    }
    level flag::set("weapon_wallbuys_created");
    callback::on_localclient_connect(&wallbuy_player_connect);
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 1, eflags: 0x1 linked
// Checksum 0x5bb1709f, Offset: 0xc10
// Size: 0xfe
function is_wallbuy(w_to_check) {
    w_base = w_to_check.rootweapon;
    if (!isdefined(level._active_wallbuys)) {
        level._active_wallbuys = [];
    }
    foreach (s_wallbuy in level._active_wallbuys) {
        if (s_wallbuy.weapon == w_base) {
            return true;
        }
    }
    if (isdefined(level._additional_wallbuy_weapons)) {
        if (isinarray(level._additional_wallbuy_weapons, w_base)) {
            return true;
        }
    }
    return false;
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 1, eflags: 0x1 linked
// Checksum 0xb45d165, Offset: 0xd18
// Size: 0x1e0
function wallbuy_player_connect(localclientnum) {
    keys = getarraykeys(level._active_wallbuys);
    println("<dev string:x38>" + localclientnum);
    for (i = 0; i < keys.size; i++) {
        wallbuy = level._active_wallbuys[keys[i]];
        if (wallbuy.weapon == level.weaponnone) {
            assertmsg("<dev string:x51>" + wallbuy.zombie_weapon_upgrade);
            continue;
        }
        fx = level._effect[#"870mcs_zm_fx"];
        if (isdefined(level._effect[wallbuy.zombie_weapon_upgrade + "_fx"])) {
            fx = level._effect[wallbuy.zombie_weapon_upgrade + "_fx"];
        }
        target_struct = struct::get(wallbuy.target, "targetname");
        target_model = zm_utility::spawn_buildkit_weapon_model(localclientnum, wallbuy.weapon, undefined, target_struct.origin, target_struct.angles);
        target_model hide();
        target_model.parent_struct = target_struct;
        wallbuy.models[localclientnum] = target_model;
    }
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 7, eflags: 0x1 linked
// Checksum 0xfa8b0aae, Offset: 0xf00
// Size: 0x42a
function wallbuy_callback(localclientnum, *oldval, newval, *bnewent, binitialsnap, fieldname, *bwastimejump) {
    if (fieldname) {
        while (!isdefined(level._active_wallbuys) || !isdefined(level._active_wallbuys[bwastimejump])) {
            waitframe(1);
        }
    }
    struct = level._active_wallbuys[bwastimejump];
    println("<dev string:x70>" + bnewent);
    if (!isdefined(struct) || !isdefined(struct.models[bnewent]) || !isdefined(struct.models[bnewent].parent_struct)) {
        assertmsg("<dev string:x85>" + bwastimejump);
        return;
    }
    switch (binitialsnap) {
    case 0:
        struct.models[bnewent].origin = struct.models[bnewent].parent_struct.origin;
        struct.models[bnewent].angles = struct.models[bnewent].parent_struct.angles;
        struct.models[bnewent] hide();
        break;
    case 1:
        if (fieldname) {
            if (!isdefined(struct.models)) {
                while (!isdefined(struct.models)) {
                    waitframe(1);
                }
                while (!isdefined(struct.models[bnewent])) {
                    waitframe(1);
                }
            }
            struct.models[bnewent] show();
            struct.models[bnewent].origin = struct.models[bnewent].parent_struct.origin;
        } else {
            waitframe(1);
            if (bnewent == 0) {
                playsound(0, #"zmb_weap_wall", struct.origin);
            }
            vec_offset = (0, 0, 0);
            if (isdefined(struct.models[bnewent].parent_struct.script_vector)) {
                vec_offset = struct.models[bnewent].parent_struct.script_vector;
            }
            struct.models[bnewent].origin = struct.models[bnewent].parent_struct.origin + anglestoright(struct.models[bnewent].angles + vec_offset) * 8;
            struct.models[bnewent] show();
            struct.models[bnewent] moveto(struct.models[bnewent].parent_struct.origin, 1);
        }
        break;
    case 2:
        if (isdefined(level.var_680d143d)) {
            struct.models[bnewent] [[ level.var_680d143d ]]();
        }
        break;
    }
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 7, eflags: 0x1 linked
// Checksum 0xbb64c1da, Offset: 0x1338
// Size: 0x430
function wallbuy_callback_idx(localclientnum, *oldval, newval, *bnewent, *binitialsnap, fieldname, *bwastimejump) {
    basefield = getsubstr(bwastimejump, 0, bwastimejump.size - 4);
    struct = level._active_wallbuys[basefield];
    if (fieldname == 0) {
        if (isdefined(struct.models[binitialsnap])) {
            struct.models[binitialsnap] hide();
        }
        return;
    }
    if (fieldname > 0) {
        weaponname = level.buildable_wallbuy_weapons[fieldname - 1];
        weapon = getweapon(weaponname);
        if (!isdefined(struct.models)) {
            struct.models = [];
        }
        if (!isdefined(struct.models[binitialsnap])) {
            target_struct = struct::get(struct.target, "targetname");
            model = undefined;
            if (isdefined(level.buildable_wallbuy_weapon_models[weaponname])) {
                model = level.buildable_wallbuy_weapon_models[weaponname];
            }
            angles = target_struct.angles;
            if (isdefined(level.var_d9d93dd9[weaponname])) {
                switch (level.var_d9d93dd9[weaponname]) {
                case 90:
                    angles = vectortoangles(anglestoright(angles));
                    break;
                case 180:
                    angles = vectortoangles(anglestoforward(angles) * -1);
                    break;
                case 270:
                    angles = vectortoangles(anglestoright(angles) * -1);
                    break;
                }
            }
            target_model = zm_utility::spawn_buildkit_weapon_model(binitialsnap, weapon, undefined, target_struct.origin, angles);
            target_model hide();
            target_model.parent_struct = target_struct;
            struct.models[binitialsnap] = target_model;
            if (isdefined(struct.fx[binitialsnap])) {
                stopfx(binitialsnap, struct.fx[binitialsnap]);
                struct.fx[binitialsnap] = undefined;
            }
            fx = level._effect[#"870mcs_zm_fx"];
            if (isdefined(level._effect[weaponname + "_fx"])) {
                fx = level._effect[weaponname + "_fx"];
            }
            struct.fx[binitialsnap] = playfx(binitialsnap, fx, struct.origin, anglestoforward(struct.angles), anglestoup(struct.angles), 0.1);
            level notify(#"wallbuy_updated");
        }
    }
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 7, eflags: 0x1 linked
// Checksum 0x970fcfd7, Offset: 0x1770
// Size: 0x18a
function function_51f5fb94(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (isdefined(self.var_11154944)) {
        stopfx(fieldname, self.var_11154944);
        self.var_11154944 = undefined;
    }
    if (bwastimejump) {
        switch (bwastimejump) {
        case 3:
            fx_to_play = #"hash_7df7fa64b947f085";
            break;
        case 4:
            fx_to_play = #"hash_1c2f33d581b291d2";
            break;
        case 5:
            fx_to_play = #"hash_19ef730d1f1a0f98";
            break;
        case 6:
            fx_to_play = #"hash_4c7d47bec47dda6c";
            break;
        case 7:
            fx_to_play = #"hash_2126649becba5c72";
            break;
        }
        if (isdefined(fx_to_play)) {
            self.var_11154944 = util::playfxontag(fieldname, fx_to_play, self, "tag_origin");
        }
    }
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 7, eflags: 0x1 linked
// Checksum 0xb0b72bf5, Offset: 0x1908
// Size: 0x7c
function function_5ed44212(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        util::playfxontag(fieldname, level._effect[#"wallbuy_reveal_fx"], self, "tag_fx_wall_buy");
    }
}

