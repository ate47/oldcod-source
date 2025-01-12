#using script_3b8f43c68572f06;
#using script_6409d04aa560106c;
#using script_cb847e6c2204e74;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\load;
#using scripts\zm_common\util;
#using scripts\zm_common\zm_hero_weapon;

#namespace zm_laststand;

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x2
// Checksum 0xd51451ba, Offset: 0x200
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_laststand", &__init__, undefined, undefined);
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x0
// Checksum 0x49816601, Offset: 0x248
// Size: 0x1d4
function __init__() {
    revive_hud::register("revive_hud");
    level.laststands = [];
    level.var_70cb425c = zm_laststand_client::register("zm_laststand_client");
    level.var_7d6b01fb = self_revive_visuals::register("self_revive_visuals");
    level.var_d4f0c28b = [];
    clientfield::register("clientuimodel", "ZMInventoryPersonal.self_revive_count", 1, 7, "int", undefined, 0, 0);
    clientfield::register("allplayers", "zm_last_stand_postfx", 1, 1, "int", &function_2e2d6a5a, 0, 1);
    for (i = 0; i < 4; i++) {
        level.laststands[i] = spawnstruct();
        level.laststands[i].laststand_update_clientfields = "laststand_update" + i;
        clientfield::register("world", level.laststands[i].laststand_update_clientfields, 1, 5, "float", &update_bleedout_timer, 0, 0);
    }
    level thread wait_and_set_revive_shader_constant();
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x0
// Checksum 0x1a74e131, Offset: 0x428
// Size: 0xc8
function wait_and_set_revive_shader_constant() {
    while (true) {
        waitresult = level waittill(#"notetrack");
        if (waitresult.notetrack == "revive_shader_constant") {
            player = function_f97e7787(waitresult.localclientnum);
            player mapshaderconstant(waitresult.localclientnum, 0, "scriptVector2", 0, 1, 0, getservertime(waitresult.localclientnum) / 1000);
        }
    }
}

// Namespace zm_laststand/zm_laststand
// Params 7, eflags: 0x0
// Checksum 0xa43e20bf, Offset: 0x4f8
// Size: 0xe4
function update_bleedout_timer(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    substr = getsubstr(fieldname, 16);
    playernum = int(substr);
    model = getuimodel(getuimodelforcontroller(localclientnum), "WorldSpaceIndicators.bleedOutModel" + playernum + ".bleedOutPercent");
    if (isdefined(model)) {
        setuimodelvalue(model, newval);
    }
}

// Namespace zm_laststand/zm_laststand
// Params 7, eflags: 0x0
// Checksum 0xb73e0830, Offset: 0x5e8
// Size: 0x170
function function_2e2d6a5a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(level.var_25eb7190)) {
        return;
    }
    if (newval) {
        var_79f499b0 = self getentitynumber();
        if (!isdefined(level.var_d4f0c28b[var_79f499b0])) {
            level.var_d4f0c28b[var_79f499b0] = getservertime(localclientnum);
        }
        if (self == function_f97e7787(localclientnum)) {
            var_b72c9440 = level.var_d4f0c28b[var_79f499b0];
            self thread function_634f6eb3(localclientnum, var_b72c9440);
        }
        return;
    }
    if (self == function_f97e7787(localclientnum)) {
        self notify(#"hash_2f1dc2ea83ba9e2");
        self postfx::exitpostfxbundle("pstfx_zm_last_stand");
    }
    level.var_d4f0c28b[self getentitynumber()] = undefined;
}

// Namespace zm_laststand/zm_laststand
// Params 2, eflags: 0x0
// Checksum 0x86fa287b, Offset: 0x760
// Size: 0x1fe
function function_634f6eb3(localclientnum, var_b72c9440) {
    self endoncallback(&function_e3e711b0, #"death", #"hash_2f1dc2ea83ba9e2");
    self postfx::playpostfxbundle("pstfx_zm_last_stand");
    var_a9bc1ad5 = var_b72c9440 + int(level.var_25eb7190 * 1000);
    self postfx::function_babe55b3("pstfx_zm_last_stand", "Enable Tint", 1);
    self postfx::function_babe55b3("pstfx_zm_last_stand", "Tint Color R", 0.9);
    self postfx::function_babe55b3("pstfx_zm_last_stand", "Tint Color G", 0.2);
    while (true) {
        n_current_time = getservertime(localclientnum);
        if (n_current_time >= var_a9bc1ad5) {
            self postfx::function_babe55b3("pstfx_zm_last_stand", "Opacity", 0.25);
            return;
        }
        n_opacity = mapfloat(var_b72c9440, var_a9bc1ad5, 0, 0.25, n_current_time);
        self postfx::function_babe55b3("pstfx_zm_last_stand", "Opacity", n_opacity);
        waitframe(1);
    }
}

// Namespace zm_laststand/zm_laststand
// Params 1, eflags: 0x0
// Checksum 0xa02001f1, Offset: 0x968
// Size: 0x44
function function_e3e711b0(var_e34146dc) {
    if (var_e34146dc == "death" && isdefined(self)) {
        self postfx::exitpostfxbundle("pstfx_zm_last_stand");
    }
}

