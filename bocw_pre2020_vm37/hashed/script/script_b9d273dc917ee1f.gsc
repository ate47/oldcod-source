#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;

#namespace namespace_4abf1500;

// Namespace namespace_4abf1500/namespace_4abf1500
// Params 0, eflags: 0x6
// Checksum 0x9515438d, Offset: 0x148
// Size: 0x54
function private autoexec __init__system__() {
    system::register(#"hash_63e00d742a373f5f", &function_70a657d8, &postinit, undefined, #"hash_f81b9dea74f0ee");
}

// Namespace namespace_4abf1500/namespace_4abf1500
// Params 0, eflags: 0x1 linked
// Checksum 0xc9941445, Offset: 0x1a8
// Size: 0xfc
function function_70a657d8() {
    clientfield::register("scriptmover", "" + #"hash_475f3329eaf62eaf", 1, 1, "int");
    level.var_238bd723 = struct::get_script_bundle_instances("zmintel");
    level.var_e2d764da = 0;
    callback::on_connect(&on_connect);
    callback::on_ai_killed(&on_ai_killed);
    level thread function_696dd88b();
    level thread function_aa317cfe();
    /#
        level thread function_ded2880a();
    #/
}

// Namespace namespace_4abf1500/namespace_4abf1500
// Params 0, eflags: 0x1 linked
// Checksum 0x80f724d1, Offset: 0x2b0
// Size: 0x4
function postinit() {
    
}

// Namespace namespace_4abf1500/namespace_4abf1500
// Params 0, eflags: 0x5 linked
// Checksum 0x80f724d1, Offset: 0x2c0
// Size: 0x4
function private on_connect() {
    
}

// Namespace namespace_4abf1500/namespace_4abf1500
// Params 0, eflags: 0x1 linked
// Checksum 0x7eeba781, Offset: 0x2d0
// Size: 0x1e8
function function_aa317cfe() {
    level flag::wait_till("start_zombie_round_logic");
    var_80198f58 = struct::get_array("zm_intel_radio_transmission_locations");
    foreach (var_41c6d68b in var_80198f58) {
        var_672f5194 = function_edc721b(var_41c6d68b.faction, "radio_transmission", 1);
        var_41c6d68b.var_99bf2e73 = array::random(var_672f5194);
        if (isdefined(var_41c6d68b.var_99bf2e73)) {
            var_41c6d68b.var_bdb97676 = util::spawn_model(var_41c6d68b.var_99bf2e73.model, var_41c6d68b.origin, var_41c6d68b.angles);
            var_41c6d68b.var_bdb97676.var_d5fa8477 = var_41c6d68b.var_99bf2e73.name;
            s_unitrigger = var_41c6d68b.var_bdb97676 zm_unitrigger::create(&function_8176b2c7, isdefined(var_41c6d68b.radius) ? var_41c6d68b.radius : 100, &function_a78987b);
            zm_unitrigger::unitrigger_force_per_player_triggers(s_unitrigger, 1);
        }
    }
}

// Namespace namespace_4abf1500/namespace_4abf1500
// Params 3, eflags: 0x1 linked
// Checksum 0xd49c3857, Offset: 0x4c0
// Size: 0x16a
function function_edc721b(var_fd5d9570, var_2b372cf6, *var_c3a4e620) {
    var_3187c666 = [];
    var_ce9ccdf6 = getscriptbundles("zmintel");
    foreach (var_19a3087c in var_ce9ccdf6) {
        if (var_19a3087c.var_9be0526e === var_c3a4e620 && var_19a3087c.var_ad4ad686 === var_2b372cf6) {
            if (!function_1a594d26(var_19a3087c.name)) {
                if (!isdefined(var_3187c666)) {
                    var_3187c666 = [];
                } else if (!isarray(var_3187c666)) {
                    var_3187c666 = array(var_3187c666);
                }
                if (!isinarray(var_3187c666, var_19a3087c)) {
                    var_3187c666[var_3187c666.size] = var_19a3087c;
                }
            }
        }
    }
    return var_3187c666;
}

// Namespace namespace_4abf1500/namespace_4abf1500
// Params 0, eflags: 0x1 linked
// Checksum 0x6233456, Offset: 0x638
// Size: 0xc8
function function_696dd88b() {
    level flag::wait_till("start_zombie_round_logic");
    foreach (var_495fa1f8 in level.var_238bd723) {
        if (is_true(var_495fa1f8.script_enable_on_start)) {
            var_495fa1f8 thread function_23255935();
        }
    }
}

// Namespace namespace_4abf1500/namespace_4abf1500
// Params 1, eflags: 0x1 linked
// Checksum 0x27f36d28, Offset: 0x708
// Size: 0x1ec
function function_23255935(str_targetname) {
    var_99bf2e73 = self;
    if (isdefined(str_targetname)) {
        var_99bf2e73 = struct::get(str_targetname);
    }
    if (isdefined(var_99bf2e73.scriptbundlename) && !isdefined(var_99bf2e73.var_bdb97676) && !function_1a594d26(var_99bf2e73.scriptbundlename)) {
        s_bundle = getscriptbundle(var_99bf2e73.scriptbundlename);
        if (isdefined(s_bundle.model)) {
            var_99bf2e73.var_bdb97676 = util::spawn_model(s_bundle.model, var_99bf2e73.origin, var_99bf2e73.angles);
            var_99bf2e73.var_bdb97676.var_d5fa8477 = var_99bf2e73.scriptbundlename;
            var_99bf2e73.var_bdb97676.script_flag_true = var_99bf2e73.script_flag_true;
            if (isdefined(var_99bf2e73.modelscale)) {
                var_99bf2e73.var_bdb97676 setscale(var_99bf2e73.modelscale);
            }
            s_unitrigger = var_99bf2e73.var_bdb97676 zm_unitrigger::create(&function_8176b2c7, isdefined(var_99bf2e73.radius) ? var_99bf2e73.radius : 100, &function_a78987b);
            zm_unitrigger::unitrigger_force_per_player_triggers(s_unitrigger, 1);
            if (isdefined(s_bundle.soundloop)) {
                var_99bf2e73.var_bdb97676 playloopsound(s_bundle.soundloop);
            }
        }
    }
}

// Namespace namespace_4abf1500/namespace_4abf1500
// Params 5, eflags: 0x1 linked
// Checksum 0xc115eebb, Offset: 0x900
// Size: 0x200
function function_2ba45c94(var_d5fa8477, v_pos, v_ang = (0, 0, 0), var_d65061b2 = 1, b_play_fx = 1) {
    s_bundle = getscriptbundle(var_d5fa8477);
    var_bdb97676 = util::spawn_model(isdefined(s_bundle.model) ? s_bundle.model : "tag_origin", v_pos, v_ang);
    var_bdb97676.var_d5fa8477 = hash(var_d5fa8477);
    if (var_d65061b2) {
        var_bdb97676 rotate((0, 90, 0));
        var_bdb97676 bobbing((0, 0, 1), 2, 1.5);
    }
    if (b_play_fx) {
        var_bdb97676 clientfield::set("" + #"hash_475f3329eaf62eaf", 1);
    }
    s_unitrigger = var_bdb97676 zm_unitrigger::create(&function_8176b2c7, 100, &function_a78987b);
    zm_unitrigger::unitrigger_force_per_player_triggers(s_unitrigger, 1);
    if (isdefined(s_bundle.soundloop)) {
        var_bdb97676 playloopsound(s_bundle.soundloop);
    }
    return var_bdb97676;
}

// Namespace namespace_4abf1500/namespace_4abf1500
// Params 1, eflags: 0x5 linked
// Checksum 0x21a8fdb4, Offset: 0xb08
// Size: 0x148
function private function_8176b2c7(e_player) {
    if (isdefined(self.stub.related_parent.script_flag_true) && !level flag::get(self.stub.related_parent.script_flag_true)) {
        self.stub.related_parent ghost();
        return false;
    }
    if (e_player function_f0f36d47(self.stub.related_parent.var_d5fa8477)) {
        self sethintstringforplayer(e_player, #"hash_2f327b914445fb30");
        return true;
    }
    self.stub.related_parent show();
    self sethintstringforplayer(e_player, e_player zm_utility::function_d6046228(#"hash_33ae89d6ac634cd3", #"hash_5ab1861040dfa3f9"));
    return true;
}

// Namespace namespace_4abf1500/namespace_4abf1500
// Params 1, eflags: 0x5 linked
// Checksum 0xafcbd2a1, Offset: 0xc58
// Size: 0xf0
function private function_a78987b(e_player) {
    self endon(#"death");
    while (true) {
        s_waitresult = self waittill(#"trigger");
        e_player = s_waitresult.activator;
        if (!zm_utility::can_use(e_player, 0) || e_player function_f0f36d47(self.stub.related_parent.var_d5fa8477)) {
            continue;
        }
        e_player thread collect_intel(self.stub.related_parent.var_d5fa8477, self.stub.related_parent);
    }
}

// Namespace namespace_4abf1500/namespace_4abf1500
// Params 2, eflags: 0x1 linked
// Checksum 0xe7270d52, Offset: 0xd50
// Size: 0x1b4
function collect_intel(var_d5fa8477, var_bdb97676) {
    if (isstring(var_d5fa8477)) {
        var_d5fa8477 = hash(var_d5fa8477);
    }
    if (!isdefined(self.var_9d781602)) {
        self.var_9d781602 = [];
    } else if (!isarray(self.var_9d781602)) {
        self.var_9d781602 = array(self.var_9d781602);
    }
    if (!isinarray(self.var_9d781602, var_d5fa8477)) {
        self.var_9d781602[self.var_9d781602.size] = var_d5fa8477;
    }
    /#
        iprintlnbold("<dev string:x38>" + self getentitynumber() + "<dev string:x43>" + function_9e72a96(var_d5fa8477));
    #/
    self function_3f3be625(var_d5fa8477, var_bdb97676);
    if (isdefined(var_bdb97676)) {
        var_bdb97676 setinvisibletoplayer(self);
    }
    if (isdefined(var_bdb97676) && function_1a594d26(var_d5fa8477)) {
        zm_unitrigger::unregister_unitrigger(var_bdb97676.s_unitrigger);
        var_bdb97676 delete();
    }
}

// Namespace namespace_4abf1500/namespace_4abf1500
// Params 1, eflags: 0x1 linked
// Checksum 0xc434dff2, Offset: 0xf10
// Size: 0x60
function function_f0f36d47(var_d5fa8477) {
    if (isarray(self.var_9d781602) && isinarray(self.var_9d781602, hash(var_d5fa8477))) {
        return true;
    }
    return false;
}

// Namespace namespace_4abf1500/namespace_4abf1500
// Params 2, eflags: 0x1 linked
// Checksum 0xd9dc9947, Offset: 0xf78
// Size: 0x344
function function_3f3be625(var_d5fa8477, var_bdb97676) {
    self endon(#"disconnect");
    if (isdefined(var_bdb97676)) {
        var_eac6151d = var_bdb97676;
        var_bdb97676 stoploopsound();
        var_bdb97676 endon(#"death");
    } else {
        var_eac6151d = self;
    }
    if (isarray(var_eac6151d.var_7e1c3be1) && var_eac6151d.var_7e1c3be1.size) {
        foreach (var_b3130155 in var_eac6151d.var_7e1c3be1) {
            var_eac6151d stopsound(var_b3130155);
        }
        var_eac6151d.var_7e1c3be1 = [];
    }
    s_bundle = getscriptbundle(var_d5fa8477);
    var_eac6151d function_bd78aea0(s_bundle, self);
    if (isarray(s_bundle.var_1ad142ee) && s_bundle.var_1ad142ee.size) {
        if (is_true(s_bundle.var_2a12d36)) {
            foreach (index, var_73a92203 in s_bundle.var_1ad142ee) {
                if (index == s_bundle.var_1ad142ee.size - 1) {
                    var_eac6151d function_8a6749e9(var_73a92203.soundevent, self, var_73a92203.var_f35c5951);
                    continue;
                }
                var_eac6151d thread function_8a6749e9(var_73a92203.soundevent, self, var_73a92203.var_f35c5951);
            }
        } else {
            foreach (var_73a92203 in s_bundle.var_1ad142ee) {
                var_eac6151d function_8a6749e9(var_73a92203.soundevent, self, undefined, var_73a92203.var_f35c5951);
            }
        }
    }
    var_eac6151d function_8f6791a4(s_bundle, self);
}

// Namespace namespace_4abf1500/namespace_4abf1500
// Params 4, eflags: 0x5 linked
// Checksum 0x2ea5718, Offset: 0x12c8
// Size: 0x1ac
function private function_8a6749e9(var_9c1ebb19, e_player, var_dcfc156f, var_c736b731) {
    if (isplayer(self)) {
        self endon(#"disconnect");
    } else {
        self endon(#"death");
    }
    if (isdefined(var_9c1ebb19)) {
        if (isdefined(var_dcfc156f)) {
            wait var_dcfc156f;
        }
        self playsoundtoplayer(var_9c1ebb19, e_player);
        if (!isdefined(self.var_7e1c3be1)) {
            self.var_7e1c3be1 = [];
        } else if (!isarray(self.var_7e1c3be1)) {
            self.var_7e1c3be1 = array(self.var_7e1c3be1);
        }
        self.var_7e1c3be1[self.var_7e1c3be1.size] = var_9c1ebb19;
        var_2690dae = float(isdefined(soundgetplaybacktime(var_9c1ebb19)) ? soundgetplaybacktime(var_9c1ebb19) : 0) / 1000;
        var_2690dae = max(var_2690dae, 0.1);
        wait var_2690dae;
        if (isdefined(var_c736b731)) {
            wait var_c736b731;
        }
        arrayremovevalue(self.var_7e1c3be1, var_9c1ebb19);
    }
}

// Namespace namespace_4abf1500/namespace_4abf1500
// Params 2, eflags: 0x5 linked
// Checksum 0xe9e7f34d, Offset: 0x1480
// Size: 0x174
function private function_bd78aea0(var_19a3087c, e_player) {
    if (isdefined(var_19a3087c.var_3bb3493d)) {
        self playsoundtoplayer(var_19a3087c.var_3bb3493d, e_player);
    }
    if (isdefined(var_19a3087c.var_348b91fd)) {
        switch (var_19a3087c.var_348b91fd) {
        case #"tape":
            var_27c5b5a9 = #"hash_ea30fff000de600";
            str_sound_loop = #"hash_77039de706e2e3d";
            break;
        case #"radio":
            var_27c5b5a9 = #"hash_5c60481ce158163d";
            str_sound_loop = #"hash_5e90e65fa1abb6d0";
            break;
        default:
            var_27c5b5a9 = #"hash_23e6a36fce4ab6ef";
            str_sound_loop = #"hash_67e31bf65d4d86a6";
            break;
        }
    }
    if (isdefined(var_27c5b5a9)) {
        self playsoundtoplayer(var_27c5b5a9, e_player);
    }
    if (isdefined(str_sound_loop)) {
        self.var_50111b4d = str_sound_loop;
        self playloopsound(str_sound_loop);
    }
}

// Namespace namespace_4abf1500/namespace_4abf1500
// Params 2, eflags: 0x5 linked
// Checksum 0x323d89e9, Offset: 0x1600
// Size: 0x104
function private function_8f6791a4(var_19a3087c, e_player) {
    if (isdefined(self.var_50111b4d)) {
        self.var_50111b4d = undefined;
        self stoploopsound();
    }
    if (isdefined(var_19a3087c.var_348b91fd)) {
        switch (var_19a3087c.var_348b91fd) {
        case #"tape":
            var_37b08e30 = #"hash_19cebf2f0254187a";
            break;
        case #"radio":
            var_37b08e30 = #"hash_18cd80b3537d971";
            break;
        default:
            var_37b08e30 = #"hash_720a47fb4eab3f3b";
            break;
        }
    }
    if (isdefined(var_37b08e30)) {
        self playsoundtoplayer(var_37b08e30, e_player);
    }
}

// Namespace namespace_4abf1500/namespace_4abf1500
// Params 1, eflags: 0x1 linked
// Checksum 0x40a4bd58, Offset: 0x1710
// Size: 0x12c
function function_8db78fbc(var_d5fa8477) {
    if (isdefined(var_d5fa8477)) {
        if (!function_1a594d26(var_d5fa8477)) {
            return var_d5fa8477;
        }
        return;
    }
    var_ce9ccdf6 = getscriptbundles("zmintel");
    foreach (var_19a3087c in var_ce9ccdf6) {
        if (var_19a3087c.var_9be0526e === #"hash_daeb8129dc8e394" && var_19a3087c.var_ad4ad686 !== #"dark_aether") {
            if (!function_1a594d26(var_19a3087c.name)) {
                return var_19a3087c.name;
            }
        }
    }
}

// Namespace namespace_4abf1500/namespace_4abf1500
// Params 1, eflags: 0x1 linked
// Checksum 0xfd3502e0, Offset: 0x1848
// Size: 0xa2
function function_1a594d26(var_d5fa8477) {
    foreach (player in getplayers()) {
        if (!player function_f0f36d47(var_d5fa8477)) {
            return false;
        }
    }
    return true;
}

// Namespace namespace_4abf1500/namespace_4abf1500
// Params 1, eflags: 0x5 linked
// Checksum 0xd80f753f, Offset: 0x18f8
// Size: 0x23a
function private on_ai_killed(params) {
    if ((isdefined(level.var_e02cc71) || (isdefined(self.archetype) && isinarray(array(#"stoker", #"gladiator", #"gladiator_marauder", #"gladiator_destroyer", #"werewolf", #"avogadro", #"raz"), self.archetype) || isdefined(self.archetype) && isinarray(array(#"blight_father", #"brutus", #"gegenees", #"mechz", #"hash_7c0d83ac1e845ac2"), self.archetype)) && isplayer(params.eattacker) && level.var_e2d764da <= 1 && math::cointoss(10)) && zm_utility::check_point_in_playable_area(self.origin)) {
        var_44a24b57 = self.origin + (0, 0, 36);
        var_d5fa8477 = function_8db78fbc(level.var_e02cc71);
        if (isdefined(var_d5fa8477)) {
            function_2ba45c94(var_d5fa8477, var_44a24b57);
            level.var_e2d764da++;
        }
        level.var_e02cc71 = undefined;
    }
}

/#

    // Namespace namespace_4abf1500/namespace_4abf1500
    // Params 0, eflags: 0x0
    // Checksum 0xd113d084, Offset: 0x1b40
    // Size: 0x260
    function function_ded2880a() {
        util::init_dvar(#"hash_82bcb0445b8db9", "<dev string:x52>", &function_2ced1cf7);
        util::init_dvar(#"hash_10552bfd7317e7d1", "<dev string:x52>", &function_2ced1cf7);
        util::init_dvar(#"hash_21daeb88f90bb3e1", "<dev string:x52>", &function_2ced1cf7);
        var_65679637 = getscriptbundlenames("<dev string:x56>");
        foreach (var_d5fa8477 in var_65679637) {
            var_d5fa8477 = function_9e72a96(var_d5fa8477);
            util::add_debug_command("<dev string:x61>" + var_d5fa8477 + "<dev string:x87>" + var_d5fa8477 + "<dev string:xb0>");
            util::add_debug_command("<dev string:x61>" + var_d5fa8477 + "<dev string:xb5>" + var_d5fa8477 + "<dev string:xb0>");
            var_19a3087c = getscriptbundle(var_d5fa8477);
            if (var_19a3087c.var_9be0526e === #"hash_daeb8129dc8e394" && var_19a3087c.var_ad4ad686 !== #"dark_aether") {
                util::add_debug_command("<dev string:x61>" + var_d5fa8477 + "<dev string:xde>" + var_d5fa8477 + "<dev string:xb0>");
            }
        }
    }

    // Namespace namespace_4abf1500/namespace_4abf1500
    // Params 1, eflags: 0x0
    // Checksum 0x44856072, Offset: 0x1da8
    // Size: 0x35c
    function function_2ced1cf7(params) {
        if (params.value === "<dev string:x52>") {
            return;
        }
        switch (params.name) {
        case #"hash_82bcb0445b8db9":
            foreach (player in getplayers()) {
                player thread collect_intel(params.value);
            }
            break;
        case #"hash_10552bfd7317e7d1":
            foreach (var_99bf2e73 in level.var_238bd723) {
                if (var_99bf2e73.scriptbundlename === params.value) {
                    v_pos = var_99bf2e73.origin;
                    break;
                }
            }
            if (isdefined(v_pos)) {
                getplayers()[0] dontinterpolate();
                getplayers()[0] setorigin(var_99bf2e73.origin);
            } else {
                /#
                    iprintlnbold("<dev string:x11f>" + params.value);
                #/
            }
            break;
        case #"hash_21daeb88f90bb3e1":
            if (function_1a594d26(params.value)) {
                iprintlnbold("<dev string:x13b>" + params.value);
            } else {
                iprintlnbold("<dev string:x15e>" + params.value + "<dev string:x16b>");
                level.var_e02cc71 = params.value;
            }
            break;
        default:
            break;
        }
        setdvar(#"hash_67a913c37ef95cda", "<dev string:x52>");
        setdvar(#"hash_10552bfd7317e7d1", "<dev string:x52>");
        setdvar(#"hash_21daeb88f90bb3e1", "<dev string:x52>");
    }

#/
