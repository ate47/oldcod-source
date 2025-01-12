#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_utility;

#namespace zm_perks;

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x0
// Checksum 0x45b21655, Offset: 0x288
// Size: 0x21c
function init() {
    callback::on_start_gametype(&init_perk_machines_fx);
    level._effect[#"hash_57c8c9eff08ddf44"] = #"hash_56161fdf383c5fdc";
    level._effect[#"hash_7c3a9f5103c06ff6"] = #"hash_420040b9ccd8bd85";
    if (zm_utility::get_story() == 2) {
        level._effect[#"hash_223e3f9bde46f5b4"] = #"hash_1678d9a47030413d";
        level._effect[#"hash_10e42380c1009ee9"] = #"hash_6ecd7d04b43d3fde";
        level._effect[#"hash_110d9fbfd034c819"] = #"hash_3060d78224e9c44e";
        level._effect[#"hash_6e4e902b59a22662"] = #"hash_3bb50572a528b187";
        level._effect[#"hash_26247c4bfd6fed73"] = #"hash_57eb5602b41fa4db";
        level._effect[#"hash_46334db9e3c76275"] = #"hash_3a24f6e29267c4d7";
    } else {
        level._effect[#"altar_icon_ambient_fx"] = #"hash_2c9a36103f6cc1e9";
    }
    init_custom_perks();
    perks_register_clientfield();
    init_perk_custom_threads();
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x0
// Checksum 0x8d0dff63, Offset: 0x4b0
// Size: 0x6bc
function perks_register_clientfield() {
    if (isdefined(level.zombiemode_using_perk_intro_fx) && level.zombiemode_using_perk_intro_fx) {
        clientfield::register("scriptmover", "clientfield_perk_intro_fx", 1, 1, "int", &perk_meteor_fx, 0, 0);
    }
    if (level._custom_perks.size > 0) {
        a_keys = getarraykeys(level._custom_perks);
        for (i = 0; i < a_keys.size; i++) {
            if (isdefined(level._custom_perks[a_keys[i]].clientfield_register)) {
                level [[ level._custom_perks[a_keys[i]].clientfield_register ]]();
            }
        }
    }
    for (i = 0; i < 4; i++) {
        clientfield::register("clientuimodel", "hudItems.perkVapor." + i + ".itemIndex", 1, 5, "int", undefined, 0, 0);
        clientfield::register("clientuimodel", "hudItems.perkVapor." + i + ".state", 1, 2, "int", undefined, 0, 0);
        clientfield::register("clientuimodel", "hudItems.perkVapor." + i + ".progress", 1, 5, "float", undefined, 0, 0);
        clientfield::register("clientuimodel", "hudItems.perkVapor." + i + ".chargeCount", 1, 2, "int", undefined, 0, 0);
        clientfield::register("clientuimodel", "hudItems.perkVapor." + i + ".timerActive", 1, 1, "int", undefined, 0, 0);
        clientfield::register("clientuimodel", "hudItems.perkVapor." + i + ".bleedoutOrderIndex", 1, 2, "int", undefined, 0, 0);
        clientfield::register("clientuimodel", "hudItems.perkVapor." + i + ".bleedoutActive", 1, 1, "int", undefined, 0, 0);
        clientfield::register("clientuimodel", "hudItems.perkVapor." + i + ".bleedoutProgress", 1, 5, "float", undefined, 0, 0);
        clientfield::register("clientuimodel", "hudItems.perkVapor." + i + ".specialEffectActive", 1, 1, "int", undefined, 0, 0);
    }
    clientfield::register("scriptmover", "" + #"hash_cf74c35ecc5a49", 1, 1, "int", &function_7b0de0a9, 0, 0);
    clientfield::register("toplayer", "" + #"hash_35fe26fc5cb223b3", 1, 3, "int", &function_52ddf67b, 0, 1);
    clientfield::register("toplayer", "" + #"hash_6fb426c48a4877e0", 1, 3, "int", &function_5f2bd7da, 0, 1);
    clientfield::register("toplayer", "" + #"hash_345845080e40675d", 1, 3, "int", &function_3dcbc4bd, 0, 1);
    clientfield::register("toplayer", "" + #"hash_1da6660f0414562", 1, 3, "int", &function_a56d2944, 0, 1);
    if (zm_utility::get_story() == 2) {
        clientfield::register("world", "" + #"hash_46334db9e3c76275", 1, 1, "int", &function_35de01e9, 0, 0);
        clientfield::register("scriptmover", "" + #"hash_50eb488e58f66198", 1, 1, "int", &function_3f09ced2, 0, 0);
        clientfield::register("allplayers", "" + #"hash_222c3403d2641ea6", 1, 3, "int", &function_59eec5f0, 0, 0);
        clientfield::register("toplayer", "" + #"hash_17283692696da23b", 1, 1, "counter", &function_25e1750f, 0, 0);
    }
    level thread perk_init_code_callbacks();
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x0
// Checksum 0x86b3d86f, Offset: 0xb78
// Size: 0xb6
function perk_init_code_callbacks() {
    wait 0.1;
    if (level._custom_perks.size > 0) {
        a_keys = getarraykeys(level._custom_perks);
        for (i = 0; i < a_keys.size; i++) {
            if (isdefined(level._custom_perks[a_keys[i]].clientfield_code_callback)) {
                level [[ level._custom_perks[a_keys[i]].clientfield_code_callback ]]();
            }
        }
    }
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x0
// Checksum 0xbe89ab1a, Offset: 0xc38
// Size: 0x22
function init_custom_perks() {
    if (!isdefined(level._custom_perks)) {
        level._custom_perks = [];
    }
}

// Namespace zm_perks/zm_perks
// Params 3, eflags: 0x0
// Checksum 0x828e82c5, Offset: 0xc68
// Size: 0xa6
function register_perk_clientfields(str_perk, func_clientfield_register, func_code_callback) {
    _register_undefined_perk(str_perk);
    if (!isdefined(level._custom_perks[str_perk].clientfield_register)) {
        level._custom_perks[str_perk].clientfield_register = func_clientfield_register;
    }
    if (!isdefined(level._custom_perks[str_perk].clientfield_code_callback)) {
        level._custom_perks[str_perk].clientfield_code_callback = func_code_callback;
    }
}

// Namespace zm_perks/zm_perks
// Params 2, eflags: 0x0
// Checksum 0x61fe4eeb, Offset: 0xd18
// Size: 0x66
function register_perk_effects(str_perk, str_light_effect) {
    _register_undefined_perk(str_perk);
    if (!isdefined(level._custom_perks[str_perk].machine_light_effect)) {
        level._custom_perks[str_perk].machine_light_effect = str_light_effect;
    }
}

// Namespace zm_perks/zm_perks
// Params 2, eflags: 0x0
// Checksum 0x1b49d587, Offset: 0xd88
// Size: 0x66
function register_perk_init_thread(str_perk, func_init_thread) {
    _register_undefined_perk(str_perk);
    if (!isdefined(level._custom_perks[str_perk].init_thread)) {
        level._custom_perks[str_perk].init_thread = func_init_thread;
    }
}

// Namespace zm_perks/zm_perks
// Params 3, eflags: 0x0
// Checksum 0x4474fe89, Offset: 0xdf8
// Size: 0xa6
function function_32b099ec(str_perk, var_30d3d89b, var_4f7bb4c9) {
    _register_undefined_perk(str_perk);
    if (!isdefined(level._custom_perks[str_perk].var_30d3d89b)) {
        level._custom_perks[str_perk].var_30d3d89b = var_30d3d89b;
    }
    if (!isdefined(level._custom_perks[str_perk].var_4f7bb4c9)) {
        level._custom_perks[str_perk].var_4f7bb4c9 = var_4f7bb4c9;
    }
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x0
// Checksum 0x4b7cc2a2, Offset: 0xea8
// Size: 0xae
function init_perk_custom_threads() {
    if (level._custom_perks.size > 0) {
        a_keys = getarraykeys(level._custom_perks);
        for (i = 0; i < a_keys.size; i++) {
            if (isdefined(level._custom_perks[a_keys[i]].init_thread)) {
                level thread [[ level._custom_perks[a_keys[i]].init_thread ]]();
            }
        }
    }
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x0
// Checksum 0x7b0c5cb3, Offset: 0xf60
// Size: 0x66
function _register_undefined_perk(str_perk) {
    if (!isdefined(level._custom_perks)) {
        level._custom_perks = [];
    }
    if (!isdefined(level._custom_perks[str_perk])) {
        level._custom_perks[str_perk] = spawnstruct();
    }
}

// Namespace zm_perks/zm_perks
// Params 7, eflags: 0x0
// Checksum 0xbfef613d, Offset: 0xfd0
// Size: 0xb4
function perk_meteor_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.meteor_fx = util::playfxontag(localclientnum, level._effect[#"perk_meteor"], self, "tag_origin");
        return;
    }
    if (isdefined(self.meteor_fx)) {
        stopfx(localclientnum, self.meteor_fx);
    }
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x0
// Checksum 0x87fcb121, Offset: 0x1090
// Size: 0x6c
function init_perk_machines_fx(localclientnum) {
    if (!level.enable_magic) {
        return;
    }
    wait 0.1;
    machines = struct::get_array("zm_perk_machine", "targetname");
    array::thread_all(machines, &perk_start_up);
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x0
// Checksum 0x621dce31, Offset: 0x1108
// Size: 0x158
function perk_start_up() {
    if (isdefined(self.script_int)) {
        power_zone = self.script_int;
        for (int = undefined; int != power_zone; int = waitresult.is_on) {
            waitresult = level waittill(#"power_on");
        }
    } else {
        level waittill(#"power_on");
    }
    timer = 0;
    duration = 0.1;
    while (true) {
        if (isdefined(level._custom_perks[self.script_noteworthy]) && isdefined(level._custom_perks[self.script_noteworthy].machine_light_effect)) {
            self thread vending_machine_flicker_light(level._custom_perks[self.script_noteworthy].machine_light_effect, duration);
        }
        timer += duration;
        duration += 0.2;
        if (timer >= 3) {
            break;
        }
        wait duration;
    }
}

// Namespace zm_perks/zm_perks
// Params 2, eflags: 0x0
// Checksum 0x77686e6b, Offset: 0x1268
// Size: 0x6e
function vending_machine_flicker_light(fx_light, duration) {
    players = level.localplayers;
    for (i = 0; i < players.size; i++) {
        self thread play_perk_fx_on_client(i, fx_light, duration);
    }
}

// Namespace zm_perks/zm_perks
// Params 3, eflags: 0x0
// Checksum 0x49e1464b, Offset: 0x12e0
// Size: 0xc4
function play_perk_fx_on_client(client_num, fx_light, duration) {
    fxobj = spawn(client_num, self.origin + (0, 0, -50), "script_model");
    fxobj setmodel(#"tag_origin");
    util::playfxontag(client_num, level._effect[fx_light], fxobj, "tag_origin");
    wait duration;
    fxobj delete();
}

// Namespace zm_perks/zm_perks
// Params 7, eflags: 0x0
// Checksum 0x62f11c6, Offset: 0x13b0
// Size: 0x6c
function function_25e1750f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self playrenderoverridebundle(#"hash_4659ecede94f0b38", "tag_accessory_left");
    }
}

// Namespace zm_perks/zm_perks
// Params 7, eflags: 0x0
// Checksum 0x9cd4e1f0, Offset: 0x1428
// Size: 0x3fc
function function_7b0de0a9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        switch (self.model) {
        case #"p8_fxanim_zm_vapor_altar_danu_mod":
        case #"p8_fxanim_zm_perk_vending_brew_mod":
            n_slot = 0;
            var_b5586180 = level._effect[#"hash_223e3f9bde46f5b4"];
            break;
        case #"p8_fxanim_zm_vapor_altar_ra_mod":
        case #"p8_fxanim_zm_perk_vending_cola_mod":
            n_slot = 1;
            var_b5586180 = level._effect[#"hash_10e42380c1009ee9"];
            break;
        case #"p8_fxanim_zm_vapor_altar_zeus_mod":
        case #"p8_fxanim_zm_perk_vending_soda_mod":
            n_slot = 2;
            var_b5586180 = level._effect[#"hash_110d9fbfd034c819"];
            break;
        case #"p8_fxanim_zm_perk_vending_tonic_mod":
        case #"p8_fxanim_zm_vapor_altar_odin_mod":
            n_slot = 3;
            var_b5586180 = level._effect[#"hash_6e4e902b59a22662"];
            break;
        }
        str_targetname = "altar_icon_" + n_slot;
        if (isdefined(getent(localclientnum, str_targetname, "targetname"))) {
            return;
        }
        e_player = function_f97e7787(localclientnum);
        var_70221ebf = e_player function_9aa4af98(localclientnum, n_slot);
        var_209b7ec8 = level._custom_perks[var_70221ebf].var_30d3d89b;
        if (zm_utility::get_story() == 2) {
            var_53a8f558 = level._custom_perks[var_70221ebf].var_4f7bb4c9;
        } else {
            var_53a8f558 = level._effect[#"altar_icon_ambient_fx"];
        }
        assert(isdefined(var_209b7ec8), "<dev string:x30>");
        assert(isdefined(var_53a8f558), "<dev string:x46>");
        mdl_icon = util::spawn_model(localclientnum, var_209b7ec8, self gettagorigin("tag_icon_link"), self.angles);
        mdl_icon linkto(self, "tag_icon_link");
        mdl_icon playrenderoverridebundle(#"hash_16b8b568a95931e7");
        mdl_icon.targetname = str_targetname;
        if (zm_utility::get_story() == 2) {
            self.var_5059393a = var_b5586180;
            self.var_2c69c0b2 = var_b5586180;
            mdl_icon.mdl_altar = self;
        }
        mdl_icon thread function_e5862de3(localclientnum, var_53a8f558, isdefined(e_player.var_920099af) ? e_player.var_920099af : e_player getentitynumber() + 1, 0);
    }
}

// Namespace zm_perks/zm_perks
// Params 2, eflags: 0x0
// Checksum 0xdbd05b45, Offset: 0x1830
// Size: 0xea
function function_9aa4af98(localclientnum, n_slot) {
    n_perk = n_slot + 1;
    var_18253ec9 = self zm_loadout::get_loadout_item(localclientnum, "specialty" + n_perk);
    assert(isdefined(var_18253ec9), "<dev string:x6d>");
    s_perk = getunlockableiteminfofromindex(var_18253ec9, 3);
    str_perk = s_perk.specialties[0];
    if (isstring(str_perk)) {
        var_70221ebf = hash(str_perk);
    }
    return var_70221ebf;
}

// Namespace zm_perks/zm_perks
// Params 7, eflags: 0x0
// Checksum 0xa3d0b8d9, Offset: 0x1928
// Size: 0x5c
function function_52ddf67b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    function_fe8d372d(localclientnum, newval, oldval, 0);
}

// Namespace zm_perks/zm_perks
// Params 7, eflags: 0x0
// Checksum 0x57aba847, Offset: 0x1990
// Size: 0x5c
function function_5f2bd7da(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    function_fe8d372d(localclientnum, newval, oldval, 1);
}

// Namespace zm_perks/zm_perks
// Params 7, eflags: 0x0
// Checksum 0x3b5fa83d, Offset: 0x19f8
// Size: 0x5c
function function_3dcbc4bd(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    function_fe8d372d(localclientnum, newval, oldval, 2);
}

// Namespace zm_perks/zm_perks
// Params 7, eflags: 0x0
// Checksum 0x81588ed3, Offset: 0x1a60
// Size: 0x5c
function function_a56d2944(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    function_fe8d372d(localclientnum, newval, oldval, 3);
}

// Namespace zm_perks/zm_perks
// Params 4, eflags: 0x0
// Checksum 0xc40e51e, Offset: 0x1ac8
// Size: 0x1dc
function function_fe8d372d(localclientnum, newval, oldval, n_slot) {
    if (newval == 0) {
        return;
    }
    e_player = function_f97e7787(localclientnum);
    mdl_icon = getent(localclientnum, "altar_icon_" + n_slot, "targetname");
    if (!isdefined(mdl_icon)) {
        if (function_39c37244(newval)) {
            e_player.var_920099af = newval;
        }
        return;
    }
    if (!function_39c37244(newval)) {
        e_player.var_920099af = undefined;
        var_70221ebf = e_player function_9aa4af98(localclientnum, n_slot);
        var_209b7ec8 = level._custom_perks[var_70221ebf].var_30d3d89b;
        if (zm_utility::get_story() == 2) {
            var_53a8f558 = level._custom_perks[var_70221ebf].var_4f7bb4c9;
        } else {
            var_53a8f558 = level._effect[#"altar_icon_ambient_fx"];
        }
        mdl_icon setmodel(var_209b7ec8);
        if (!function_39c37244(oldval, 1)) {
            return;
        }
    }
    mdl_icon thread function_e5862de3(localclientnum, var_53a8f558, newval, oldval);
}

// Namespace zm_perks/zm_perks
// Params 4, eflags: 0x0
// Checksum 0x2ba3384a, Offset: 0x1cb0
// Size: 0x598
function function_e5862de3(localclientnum, var_53a8f558, newval, oldval) {
    n_start_time = gettime();
    n_end_time = n_start_time + int(0.5 * 1000);
    if (!function_39c37244(newval)) {
        self setscale(1);
        if (zm_utility::get_story() == 2) {
            self.mdl_altar.var_2c69c0b2 = self.mdl_altar.var_5059393a;
            self.mdl_altar function_cae1a335(localclientnum, 1);
        }
        self.var_2303154d = util::playfxontag(localclientnum, var_53a8f558, self, "tag_origin");
        playfx(localclientnum, level._effect[#"hash_7c3a9f5103c06ff6"], self.origin, anglestoforward(self.angles), anglestoup(self.angles));
        while (isdefined(self)) {
            n_time = gettime();
            if (n_time >= n_end_time) {
                self function_98a01e4c(#"hash_16b8b568a95931e7", "brightness", 1);
                self function_98a01e4c(#"hash_16b8b568a95931e7", "alpha", 1);
                return;
            } else {
                n_shader_value = mapfloat(n_start_time, n_end_time, 0, 1, n_time);
            }
            self function_98a01e4c(#"hash_16b8b568a95931e7", "brightness", n_shader_value);
            self function_98a01e4c(#"hash_16b8b568a95931e7", "alpha", n_shader_value);
            wait 0.01;
        }
        return;
    }
    if (zm_utility::get_story() == 2) {
        if (newval == 7) {
            self.mdl_altar function_cae1a335(localclientnum, 0);
        } else {
            self.mdl_altar.var_2c69c0b2 = level._effect[#"hash_26247c4bfd6fed73"];
            self.mdl_altar function_cae1a335(localclientnum, 1);
        }
    }
    if (function_39c37244(oldval)) {
        return;
    }
    if (isdefined(self.var_2303154d)) {
        killfx(localclientnum, self.var_2303154d);
        self.var_2303154d = undefined;
    }
    if (newval == 6) {
        self function_98a01e4c(#"hash_16b8b568a95931e7", "brightness", 0);
        self function_98a01e4c(#"hash_16b8b568a95931e7", "alpha", 0);
        return;
    }
    playfx(localclientnum, level._effect[#"hash_57c8c9eff08ddf44"], self.origin, anglestoforward(self.angles), anglestoup(self.angles));
    while (isdefined(self)) {
        n_time = gettime();
        if (n_time >= n_end_time) {
            self function_98a01e4c(#"hash_16b8b568a95931e7", "brightness", 0);
            self function_98a01e4c(#"hash_16b8b568a95931e7", "alpha", 0);
            return;
        } else {
            n_shader_value = mapfloat(n_start_time, n_end_time, 1, 0, n_time);
            var_ec648490 = mapfloat(n_start_time, n_end_time, 1, 1.5, n_time);
        }
        self function_98a01e4c(#"hash_16b8b568a95931e7", "brightness", n_shader_value);
        self function_98a01e4c(#"hash_16b8b568a95931e7", "alpha", n_shader_value);
        self setscale(var_ec648490);
        wait 0.01;
    }
}

// Namespace zm_perks/zm_perks
// Params 2, eflags: 0x0
// Checksum 0x2fe19bb0, Offset: 0x2250
// Size: 0x7e
function function_cae1a335(localclientnum, b_show) {
    if (isdefined(self.var_cc3e742f)) {
        stopfx(localclientnum, self.var_cc3e742f);
    }
    if (b_show) {
        self.var_cc3e742f = util::playfxontag(localclientnum, self.var_2c69c0b2, self, "fx_tag_base_emblem");
        return;
    }
    self.var_cc3e742f = undefined;
}

// Namespace zm_perks/zm_perks
// Params 2, eflags: 0x4
// Checksum 0xc133c147, Offset: 0x22d8
// Size: 0x52
function private function_39c37244(n_value, var_dfaeb670 = 0) {
    if (n_value < 5) {
        if (var_dfaeb670 && n_value == 0) {
            return true;
        }
        return false;
    }
    return true;
}

// Namespace zm_perks/zm_perks
// Params 7, eflags: 0x0
// Checksum 0x7a1662cd, Offset: 0x2338
// Size: 0xdc
function function_35de01e9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        while (!isdefined(self.var_ffd6d241)) {
            waitframe(1);
            self.var_ffd6d241 = getent(localclientnum, "zeus_bird_head", "targetname");
        }
        util::playfxontag(localclientnum, level._effect[#"hash_46334db9e3c76275"], self.var_ffd6d241, "bird_follow_jnt");
        self.var_ffd6d241 thread function_7bf86bd4(localclientnum);
    }
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x0
// Checksum 0xdd21defd, Offset: 0x2420
// Size: 0x70
function function_7bf86bd4(localclientnum) {
    self endon(#"death");
    while (true) {
        wait randomintrange(5, 20);
        self playsound(localclientnum, #"hash_62f87027921fa5b4");
    }
}

// Namespace zm_perks/zm_perks
// Params 7, eflags: 0x0
// Checksum 0x4f875bdb, Offset: 0x2498
// Size: 0xba
function function_3f09ced2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        if (!isdefined(self.var_ffd6d241)) {
            self.var_ffd6d241 = util::spawn_model(localclientnum, "p8_fxanim_zm_vapor_altar_zeus_bird_head_mod", self gettagorigin("tag_bird_head"), self gettagangles("tag_bird_head"));
            self.var_ffd6d241.targetname = "zeus_bird_head";
        }
    }
}

// Namespace zm_perks/zm_perks
// Params 7, eflags: 0x0
// Checksum 0xdc148004, Offset: 0x2560
// Size: 0x29c
function function_59eec5f0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    level endon(#"demo_jump");
    if (!isdefined(self.var_ffd6d241)) {
        self.var_ffd6d241 = getent(localclientnum, "zeus_bird_head", "targetname");
    }
    var_ffd6d241 = self.var_ffd6d241;
    if (!isdefined(var_ffd6d241)) {
        return;
    }
    var_ffd6d241 endon(#"death");
    if (!isdefined(level.var_9ef8bfd4)) {
        level.var_9ef8bfd4 = var_ffd6d241.angles;
        if (level.var_9ef8bfd4[1] == 360) {
            level.var_9ef8bfd4 = (0, 0, 0);
        }
    }
    level notify(#"hash_4d8d403fdb281b69");
    wait 0.5;
    if (newval == 0) {
        var_d5a8444 = array::random(array((7, 7, 7), (-7, -7, -7), (-7, 7, 7), (7, -7, -7)));
        var_ffd6d241 rotateto(level.var_9ef8bfd4 + var_d5a8444, 0.2);
        wait 0.8;
        var_ffd6d241 rotateto(level.var_9ef8bfd4, 0.1);
        return;
    }
    var_a8d54375 = array::random(array((17, 30, 25), (-10, -30, -25), (-10, 30, 25), (17, -30, -25)));
    var_ffd6d241 rotateto(level.var_9ef8bfd4 + var_a8d54375, 0.15);
    var_ffd6d241 thread function_b4f30e48(self);
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x0
// Checksum 0xa3cadca6, Offset: 0x2808
// Size: 0x150
function function_b4f30e48(e_player) {
    if (!isdefined(e_player)) {
        return;
    }
    level endon(#"demo_jump", #"hash_4d8d403fdb281b69");
    e_player endon(#"death");
    self endon(#"death");
    wait 1;
    while (isdefined(e_player)) {
        var_c746e6bf = e_player gettagorigin("j_head");
        if (vectordot(vectornormalize(var_c746e6bf - self.origin), anglestoforward(level.var_9ef8bfd4)) > 0.5) {
            var_933e0d32 = vectortoangles(var_c746e6bf - self.origin);
            self rotateto(var_933e0d32, 0.15);
        }
        wait 0.15;
    }
}

