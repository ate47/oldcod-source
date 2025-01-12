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
// Params 0, eflags: 0x2
// Checksum 0x18b146c2, Offset: 0x200
// Size: 0x54
function autoexec __init__system__() {
    system::register(#"zm_wallbuy", &__init__, &__main__, #"zm");
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 0, eflags: 0x0
// Checksum 0x21c7e3cd, Offset: 0x260
// Size: 0x154
function __init__() {
    if (!getgametypesetting(#"zmwallbuysenabled")) {
        return;
    }
    level flag::init("weapon_wallbuys_created");
    level._effect[#"wallbuy_ambient_fx"] = "zombie/fx8_wallbuy_amb";
    level._effect[#"hash_6928ec90dff78e0c"] = "zombie/fx8_wallbuy_amb_reverse";
    level._effect[#"wallbuy_reveal_fx"] = "zombie/fx8_wallbuy_reveal";
    clientfield::register("scriptmover", "wallbuy_ambient_fx", 1, 1, "int", &function_b9c8be83, 0, 0);
    clientfield::register("scriptmover", "wallbuy_reveal_fx", 1, 1, "int", &function_aee4f03c, 0, 0);
    init();
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 0, eflags: 0x0
// Checksum 0xcda2b5da, Offset: 0x3c0
// Size: 0x5c
function __main__() {
    if (!getgametypesetting(#"zmwallbuysenabled")) {
        return;
    }
    if (isdefined(level.var_4dd09857) && level.var_4dd09857) {
        function_9e8dccbe();
    }
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 0, eflags: 0x0
// Checksum 0xdd9fa8f5, Offset: 0x428
// Size: 0x85c
function init() {
    spawn_list = [];
    spawnable_weapon_spawns = struct::get_array("weapon_upgrade", "targetname");
    spawnable_weapon_spawns = arraycombine(spawnable_weapon_spawns, struct::get_array("bowie_upgrade", "targetname"), 1, 0);
    spawnable_weapon_spawns = arraycombine(spawnable_weapon_spawns, struct::get_array("sickle_upgrade", "targetname"), 1, 0);
    spawnable_weapon_spawns = arraycombine(spawnable_weapon_spawns, struct::get_array("tazer_upgrade", "targetname"), 1, 0);
    spawnable_weapon_spawns = arraycombine(spawnable_weapon_spawns, struct::get_array("buildable_wallbuy", "targetname"), 1, 0);
    if (isdefined(level.use_autofill_wallbuy) && level.use_autofill_wallbuy) {
        spawnable_weapon_spawns = arraycombine(spawnable_weapon_spawns, level.active_autofill_wallbuys, 1, 0);
    }
    if (!(isdefined(level.headshots_only) && level.headshots_only)) {
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
        weapon_group = function_b3cd8cdc(spawnable_weapon.weapon);
        if (weapon_group == #"weapon_pistol" && !getgametypesetting(#"zmweaponspistol") || weapon_group == #"weapon_cqb" && !getgametypesetting(#"zmweaponsshotgun") || weapon_group == #"weapon_smg" && !getgametypesetting(#"zmweaponssmg") || weapon_group == #"weapon_assault" && !getgametypesetting(#"zmweaponsar") || weapon_group == #"weapon_tactical" && !getgametypesetting(#"zmweaponstr") || weapon_group == #"weapon_lmg" && !getgametypesetting(#"zmweaponslmg") || weapon_group == #"weapon_sniper" && !getgametypesetting(#"zmweaponssniper") || weapon_group == #"weapon_knife" && !getgametypesetting(#"zmweaponsknife")) {
            continue;
        }
        if (isdefined(spawnable_weapon.zombie_weapon_upgrade) && spawnable_weapon.weapon.isgrenadeweapon && isdefined(level.headshots_only) && level.headshots_only) {
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
// Params 1, eflags: 0x0
// Checksum 0x8c87f255, Offset: 0xc90
// Size: 0xee
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
// Params 1, eflags: 0x0
// Checksum 0x93537bf3, Offset: 0xd88
// Size: 0x1b4
function wallbuy_player_connect(localclientnum) {
    keys = getarraykeys(level._active_wallbuys);
    println("<dev string:x30>" + localclientnum);
    for (i = 0; i < keys.size; i++) {
        wallbuy = level._active_wallbuys[keys[i]];
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
// Params 7, eflags: 0x0
// Checksum 0x70477e76, Offset: 0xf48
// Size: 0x3fa
function wallbuy_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (binitialsnap) {
        while (!isdefined(level._active_wallbuys) || !isdefined(level._active_wallbuys[fieldname])) {
            waitframe(1);
        }
    }
    struct = level._active_wallbuys[fieldname];
    println("<dev string:x46>" + localclientnum);
    switch (newval) {
    case 0:
        struct.models[localclientnum].origin = struct.models[localclientnum].parent_struct.origin;
        struct.models[localclientnum].angles = struct.models[localclientnum].parent_struct.angles;
        struct.models[localclientnum] hide();
        break;
    case 1:
        if (binitialsnap) {
            if (!isdefined(struct.models)) {
                while (!isdefined(struct.models)) {
                    waitframe(1);
                }
                while (!isdefined(struct.models[localclientnum])) {
                    waitframe(1);
                }
            }
            struct.models[localclientnum] show();
            struct.models[localclientnum].origin = struct.models[localclientnum].parent_struct.origin;
        } else {
            waitframe(1);
            if (localclientnum == 0) {
                playsound(0, #"zmb_weap_wall", struct.origin);
            }
            vec_offset = (0, 0, 0);
            if (isdefined(struct.models[localclientnum].parent_struct.script_vector)) {
                vec_offset = struct.models[localclientnum].parent_struct.script_vector;
            }
            struct.models[localclientnum].origin = struct.models[localclientnum].parent_struct.origin + anglestoright(struct.models[localclientnum].angles + vec_offset) * 8;
            struct.models[localclientnum] show();
            struct.models[localclientnum] moveto(struct.models[localclientnum].parent_struct.origin, 1);
        }
        break;
    case 2:
        if (isdefined(level.var_606e6080)) {
            struct.models[localclientnum] [[ level.var_606e6080 ]]();
        }
        break;
    }
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 7, eflags: 0x0
// Checksum 0x886be616, Offset: 0x1350
// Size: 0x470
function wallbuy_callback_idx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    basefield = getsubstr(fieldname, 0, fieldname.size - 4);
    struct = level._active_wallbuys[basefield];
    if (newval == 0) {
        if (isdefined(struct.models[localclientnum])) {
            struct.models[localclientnum] hide();
        }
        return;
    }
    if (newval > 0) {
        weaponname = level.buildable_wallbuy_weapons[newval - 1];
        weapon = getweapon(weaponname);
        if (!isdefined(struct.models)) {
            struct.models = [];
        }
        if (!isdefined(struct.models[localclientnum])) {
            target_struct = struct::get(struct.target, "targetname");
            model = undefined;
            if (isdefined(level.buildable_wallbuy_weapon_models[weaponname])) {
                model = level.buildable_wallbuy_weapon_models[weaponname];
            }
            angles = target_struct.angles;
            if (isdefined(level.var_4b2570c[weaponname])) {
                switch (level.var_4b2570c[weaponname]) {
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
            target_model = zm_utility::spawn_buildkit_weapon_model(localclientnum, weapon, undefined, target_struct.origin, angles);
            target_model hide();
            target_model.parent_struct = target_struct;
            struct.models[localclientnum] = target_model;
            if (isdefined(struct.fx[localclientnum])) {
                stopfx(localclientnum, struct.fx[localclientnum]);
                struct.fx[localclientnum] = undefined;
            }
            fx = level._effect[#"870mcs_zm_fx"];
            if (isdefined(level._effect[weaponname + "_fx"])) {
                fx = level._effect[weaponname + "_fx"];
            }
            struct.fx[localclientnum] = playfx(localclientnum, fx, struct.origin, anglestoforward(struct.angles), anglestoup(struct.angles), 0.1);
            level notify(#"wallbuy_updated");
        }
    }
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 0, eflags: 0x0
// Checksum 0x7ecede97, Offset: 0x17c8
// Size: 0x66c
function function_9e8dccbe() {
    wallbuys = struct::get_array("wallbuy_autofill", "targetname");
    if (!isdefined(wallbuys) || wallbuys.size == 0 || !isdefined(level.var_723d0afa) || level.var_723d0afa.size == 0) {
        return;
    }
    level.use_autofill_wallbuy = 1;
    var_69e24b8b[#"all"] = getarraykeys(level.var_723d0afa[#"all"]);
    index = 0;
    var_7e5108a3 = [];
    level.active_autofill_wallbuys = [];
    foreach (wallbuy in wallbuys) {
        weapon_class = wallbuy.script_string;
        weapon = undefined;
        if (isdefined(weapon_class) && weapon_class != "") {
            if (!isdefined(var_69e24b8b[weapon_class]) && isdefined(level.var_723d0afa[weapon_class])) {
                var_69e24b8b[weapon_class] = getarraykeys(level.var_723d0afa[weapon_class]);
            }
            if (isdefined(var_69e24b8b[weapon_class])) {
                for (i = 0; i < var_69e24b8b[weapon_class].size; i++) {
                    if (level.var_723d0afa[#"all"][var_69e24b8b[weapon_class][i]]) {
                        weapon = var_69e24b8b[weapon_class][i];
                        level.var_723d0afa[#"all"][weapon] = 0;
                        break;
                    }
                }
            } else {
                continue;
            }
        } else {
            var_7e5108a3[var_7e5108a3.size] = wallbuy;
            continue;
        }
        if (!isdefined(weapon)) {
            continue;
        }
        wallbuy.zombie_weapon_upgrade = weapon.name;
        wallbuy.weapon = weapon;
        right = anglestoright(wallbuy.angles);
        wallbuy.origin -= right * 2;
        wallbuy.target = "autofill_wallbuy_" + index;
        target_struct = spawnstruct();
        target_struct.targetname = wallbuy.target;
        target_struct.angles = wallbuy.angles;
        target_struct.origin = wallbuy.origin;
        model = wallbuy.weapon.worldmodel;
        target_struct.model = model;
        target_struct struct::init();
        level.active_autofill_wallbuys[level.active_autofill_wallbuys.size] = wallbuy;
        index++;
    }
    foreach (wallbuy in var_7e5108a3) {
        weapon_name = undefined;
        for (i = 0; i < var_69e24b8b[#"all"].size; i++) {
            if (level.var_723d0afa[#"all"][var_69e24b8b[#"all"][i]]) {
                weapon = var_69e24b8b[#"all"][i];
                level.var_723d0afa[#"all"][weapon] = 0;
                break;
            }
        }
        if (!isdefined(weapon)) {
            break;
        }
        wallbuy.zombie_weapon_upgrade = weapon.name;
        wallbuy.weapon = weapon;
        right = anglestoright(wallbuy.angles);
        wallbuy.origin -= right * 2;
        wallbuy.target = "autofill_wallbuy_" + index;
        target_struct = spawnstruct();
        target_struct.targetname = wallbuy.target;
        target_struct.angles = wallbuy.angles;
        target_struct.origin = wallbuy.origin;
        model = wallbuy.weapon.worldmodel;
        target_struct.model = model;
        target_struct struct::init();
        level.active_autofill_wallbuys[level.active_autofill_wallbuys.size] = wallbuy;
        index++;
    }
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 7, eflags: 0x0
// Checksum 0x2889795d, Offset: 0x1e40
// Size: 0x14a
function function_b9c8be83(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        if (isdefined(self.var_557c54b7)) {
            stopfx(localclientnum, self.var_557c54b7);
            self.var_557c54b7 = undefined;
        }
        if (!isdefined(self.ambient_fx_id)) {
            self.ambient_fx_id = util::playfxontag(localclientnum, level._effect[#"wallbuy_ambient_fx"], self, "tag_fx_wall_buy");
        }
        return;
    }
    if (isdefined(self.ambient_fx_id)) {
        stopfx(localclientnum, self.ambient_fx_id);
        self.ambient_fx_id = undefined;
    }
    if (!isdefined(self.var_557c54b7)) {
        self.var_557c54b7 = util::playfxontag(localclientnum, level._effect[#"hash_6928ec90dff78e0c"], self, "tag_fx_wall_buy");
    }
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 7, eflags: 0x0
// Checksum 0xb40d79bf, Offset: 0x1f98
// Size: 0x7c
function function_aee4f03c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        util::playfxontag(localclientnum, level._effect[#"wallbuy_reveal_fx"], self, "tag_fx_wall_buy");
    }
}

