#using script_3b8f43c68572f06;
#using script_6409d04aa560106c;
#using script_70ab01a7690ea256;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\load;
#using scripts\zm_common\util;
#using scripts\zm_common\zm_hero_weapon;

#namespace zm_laststand;

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x6
// Checksum 0x43f2fb20, Offset: 0x260
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_laststand", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x5 linked
// Checksum 0x33911789, Offset: 0x2a8
// Size: 0x284
function private function_70a657d8() {
    level.var_629da31e = function_e49dbc72();
    callback::on_localplayer_spawned(&function_772f66bd);
    revive_hud::register();
    level.laststands = [];
    level.var_ff482f76 = zm_laststand_client::register();
    level.var_16af4504 = [];
    clientfield::register_clientuimodel("ZMInventoryPersonal.self_revive_count", #"hash_1d3ddede734994d8", #"self_revive_count", 1, 7, "int", undefined, 0, 0);
    clientfield::register("allplayers", "zm_last_stand_postfx", 1, 1, "int", &function_50d4c00a, 0, 1);
    for (i = 0; i < 5; i++) {
        level.laststands[i] = spawnstruct();
        level.laststands[i].laststand_update_clientfields = "laststand_update" + i;
        clientfield::register("world", level.laststands[i].laststand_update_clientfields, 1, 5, "float", &update_bleedout_timer, 0, 0);
        clientfield::register_clientuimodel("WorldSpaceIndicators.bleedOutModel" + i + ".hide", #"hash_56cb8e9a65d9f9ad", [#"bleedoutmodel" + (isdefined(i) ? "" + i : ""), #"hide"], 1, 1, "int", undefined, 0, 0);
    }
    level thread wait_and_set_revive_shader_constant();
}

// Namespace zm_laststand/zm_laststand
// Params 1, eflags: 0x1 linked
// Checksum 0xf4a0238c, Offset: 0x538
// Size: 0x16a
function function_772f66bd(localclientnum) {
    localplayer = function_5c10bd79(localclientnum);
    zmdifficultysettings = getscriptbundle("zm_base_difficulty");
    switch (level.gamedifficulty) {
    case 0:
        str_suffix = "_E";
        break;
    case 1:
    default:
        str_suffix = "_N";
        break;
    case 2:
        str_suffix = "_H";
        break;
    case 3:
        str_suffix = "_I";
        break;
    }
    n_base = zmdifficultysettings.("plyBaseHealth" + str_suffix);
    n_target = int(max(n_base, 1));
    localplayer.var_ee9b8af0 = n_target;
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x1 linked
// Checksum 0xf55b5701, Offset: 0x6b0
// Size: 0x22
function function_e49dbc72() {
    return getdvarfloat(#"player_laststandbleedouttime", 0);
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x1 linked
// Checksum 0x9eb5c435, Offset: 0x6e0
// Size: 0xd6
function wait_and_set_revive_shader_constant() {
    while (true) {
        waitresult = level waittillmatch({#notetrack:"revive_shader_constant"}, #"notetrack");
        player = function_5c10bd79(waitresult.localclientnum);
        player mapshaderconstant(waitresult.localclientnum, 0, "scriptVector2", 0, 1, 0, getservertime(waitresult.localclientnum) / 1000);
        waitframe(1);
    }
}

// Namespace zm_laststand/zm_laststand
// Params 7, eflags: 0x1 linked
// Checksum 0xdbd44ffa, Offset: 0x7c0
// Size: 0xfc
function update_bleedout_timer(localclientnum, *oldval, newval, *bnewent, *binitialsnap, fieldname, *bwastimejump) {
    substr = getsubstr(bwastimejump, 16);
    playernum = int(substr);
    model = getuimodel(getuimodel(function_1df4c3b0(binitialsnap, #"hash_56cb8e9a65d9f9ad"), "bleedOutModel" + playernum), "bleedOutPercent");
    if (isdefined(model)) {
        setuimodelvalue(model, fieldname);
    }
}

// Namespace zm_laststand/zm_laststand
// Params 7, eflags: 0x1 linked
// Checksum 0xe1952c2a, Offset: 0x8c8
// Size: 0x164
function function_50d4c00a(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (!isdefined(level.var_629da31e)) {
        return;
    }
    if (bwastimejump) {
        var_32c41440 = self getentitynumber();
        if (!isdefined(level.var_16af4504[var_32c41440])) {
            level.var_16af4504[var_32c41440] = getservertime(fieldname);
        }
        if (self == function_5c10bd79(fieldname)) {
            var_d2c301e0 = level.var_16af4504[var_32c41440];
            self thread function_be34e28f(fieldname, var_d2c301e0);
        }
        return;
    }
    if (self == function_5c10bd79(fieldname)) {
        self notify(#"hash_2f1dc2ea83ba9e2");
        self postfx::exitpostfxbundle("pstfx_zm_last_stand");
    }
    level.var_16af4504[self getentitynumber()] = undefined;
}

// Namespace zm_laststand/zm_laststand
// Params 2, eflags: 0x1 linked
// Checksum 0x9777cbe7, Offset: 0xa38
// Size: 0x25e
function function_be34e28f(localclientnum, var_d2c301e0) {
    self endoncallback(&function_ac994c83, #"death", #"hash_2f1dc2ea83ba9e2");
    self postfx::playpostfxbundle("pstfx_zm_last_stand");
    var_6c2f58e2 = var_d2c301e0 + int(level.var_629da31e * 1000);
    if (util::function_cd6c95db(localclientnum) || namespace_a6aea2c6::is_active(#"silent_film")) {
        self postfx::function_c8b5f318("pstfx_zm_last_stand", "Desaturation", 1);
    } else {
        self postfx::function_c8b5f318("pstfx_zm_last_stand", "Enable Tint", 1);
        self postfx::function_c8b5f318("pstfx_zm_last_stand", "Tint Color R", 0.9);
        self postfx::function_c8b5f318("pstfx_zm_last_stand", "Tint Color G", 0.2);
    }
    while (true) {
        n_current_time = getservertime(localclientnum);
        if (n_current_time >= var_6c2f58e2) {
            self postfx::function_c8b5f318("pstfx_zm_last_stand", "Opacity", 0.25);
            return;
        }
        n_opacity = mapfloat(var_d2c301e0, var_6c2f58e2, 0, 0.25, n_current_time);
        self postfx::function_c8b5f318("pstfx_zm_last_stand", "Opacity", n_opacity);
        waitframe(1);
    }
}

// Namespace zm_laststand/zm_laststand
// Params 1, eflags: 0x1 linked
// Checksum 0x359d1337, Offset: 0xca0
// Size: 0x44
function function_ac994c83(var_c34665fc) {
    if (var_c34665fc == "death" && isdefined(self)) {
        self postfx::exitpostfxbundle("pstfx_zm_last_stand");
    }
}

