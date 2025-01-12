#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\fx_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm\zm_escape;
#using scripts\zm\zm_escape_util;
#using scripts\zm\zm_escape_vo_hooks;
#using scripts\zm_common\util\ai_brutus_util;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_pack_a_punch;
#using scripts\zm_common\zm_power;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_ui_inventory;
#using scripts\zm_common\zm_utility;

#namespace pap_quest;

// Namespace pap_quest/zm_escape_pap_quest
// Params 0, eflags: 0x2
// Checksum 0x8df7f2a7, Offset: 0x2d8
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"pap_quest", &__init__, &__main__, undefined);
}

// Namespace pap_quest/zm_escape_pap_quest
// Params 0, eflags: 0x0
// Checksum 0xad3d7143, Offset: 0x328
// Size: 0x1f4
function __init__() {
    level.pack_a_punch.custom_power_think = &function_96b3de4b;
    level._effect[#"lightning_near"] = "maps/zm_escape/fx8_pap_lightning_near";
    level._effect[#"lightning_bridge"] = "maps/zm_escape/fx8_pap_lightning_bridge";
    level flag::init(#"pap_quest_completed");
    scene::add_scene_func(#"aib_vign_zm_mob_pap_ghosts", &function_3fdb7279, "play");
    scene::add_scene_func(#"aib_vign_zm_mob_pap_ghosts_b64", &function_2d4a1010, "play");
    scene::add_scene_func(#"aib_vign_zm_mob_pap_ghosts_power_house", &function_f852a467, "play");
    scene::add_scene_func(#"hash_41fada5e44b023a9", &function_c1c9166f, "play");
    scene::add_scene_func(#"aib_vign_zm_mob_pap_ghosts_remove_b64", &function_bc9ea8ba, "play");
    scene::add_scene_func(#"hash_7cc7d9f749a02418", &function_e9e60dd1, "play");
    init_clientfield();
}

// Namespace pap_quest/zm_escape_pap_quest
// Params 0, eflags: 0x4
// Checksum 0x98f8d0c7, Offset: 0x528
// Size: 0xc4
function private init_clientfield() {
    clientfield::register("world", "" + #"lightning_near", 1, 1, "counter");
    clientfield::register("world", "" + #"lightning_far", 1, 1, "counter");
    clientfield::register("scriptmover", "" + #"lightning_near", 1, 1, "counter");
}

// Namespace pap_quest/zm_escape_pap_quest
// Params 0, eflags: 0x0
// Checksum 0xf1a3fa4c, Offset: 0x5f8
// Size: 0x13c
function __main__() {
    if (zm_custom::function_5638f689(#"zmpapenabled") == 1) {
        level thread function_31d1e44e();
    } else if (zm_custom::function_5638f689(#"zmpapenabled") == 0) {
        a_e_zbarriers = getentarray("zm_pack_a_punch", "targetname");
        foreach (e_zbarrier in a_e_zbarriers) {
            e_zbarrier zm_pack_a_punch::set_state_initial();
            e_zbarrier zm_pack_a_punch::set_state_hidden();
        }
    }
    level thread function_330ed827();
}

// Namespace pap_quest/zm_escape_pap_quest
// Params 1, eflags: 0x0
// Checksum 0xbecc06b8, Offset: 0x740
// Size: 0x2fa
function function_96b3de4b(is_powered) {
    level flag::wait_till("start_zombie_round_logic");
    switch (zm_custom::function_5638f689(#"zmpapenabled")) {
    case 1:
        self zm_pack_a_punch::set_state_hidden();
        if (self.script_string == "roof") {
            level flag::wait_till("power_on1");
            var_8ceada94 = getent("pap_shock_box", "script_string");
            var_8ceada94 waittill(#"hash_7e1d78666f0be68b");
            var_8ceada94 playsound(#"hash_3a18ced95ae72103");
            var_8ceada94 playloopsound(#"hash_3a1bb2d95ae92746");
            var_8ceada94 notify(#"hash_7f8e7011812dff48");
            wait 2;
            e_player = zm_utility::get_closest_player(var_8ceada94.origin);
            e_player thread zm_audio::create_and_play_dialog("pap", "build", undefined, 1);
            scene::play(#"aib_vign_zm_mob_pap_ghosts");
            self zm_pack_a_punch::function_e95839cd(1);
            self thread function_501afccf();
            level zm_ui_inventory::function_31a39683(#"zm_escape_paschal", 1);
            level flag::set(#"pap_quest_completed");
        }
        break;
    case 2:
        if (self.script_string == "roof") {
            pap_debris(0, "roof");
            self zm_pack_a_punch::function_e95839cd(1);
            self thread function_501afccf();
            level zm_ui_inventory::function_31a39683(#"zm_escape_paschal", 1);
            level flag::set(#"pap_quest_completed");
        }
        break;
    }
}

// Namespace pap_quest/zm_escape_pap_quest
// Params 1, eflags: 0x4
// Checksum 0x4ecc0e79, Offset: 0xa48
// Size: 0x26c
function private function_3fdb7279(a_ents) {
    a_ents[#"pap"] thread function_3c55018f("roof", 1);
    a_ents[#"actor 1"] clientfield::set("" + #"hash_34562274d7e875a4", 1);
    a_ents[#"actor 2"] clientfield::set("" + #"hash_34562274d7e875a4", 1);
    if (!level flag::get(#"pap_quest_completed")) {
        a_ents[#"pap"] waittill(#"fade_in_start");
        level clientfield::increment("" + #"lightning_near");
        s_lightning_bridge = struct::get("lightning_bridge");
        level clientfield::increment("" + #"lightning_far");
        playsoundatposition(#"hash_7804a63a2ff82145", s_lightning_bridge.origin);
        a_ents[#"pap"] waittill(#"fade_in_end");
        s_lightning_near = struct::get("lightning_near");
        wait 0.6;
        e_player = zm_utility::get_closest_player(s_lightning_near.origin);
        e_player zm_audio::create_and_play_dialog("pap", "react", undefined, 1);
    }
}

// Namespace pap_quest/zm_escape_pap_quest
// Params 1, eflags: 0x4
// Checksum 0xf91a09ef, Offset: 0xcc0
// Size: 0xcc
function private function_2d4a1010(a_ents) {
    a_ents[#"pap"] thread function_3c55018f("building_64");
    a_ents[#"actor 1"] clientfield::set("" + #"hash_34562274d7e875a4", 1);
    a_ents[#"actor 2"] clientfield::set("" + #"hash_34562274d7e875a4", 1);
}

// Namespace pap_quest/zm_escape_pap_quest
// Params 1, eflags: 0x4
// Checksum 0x20413859, Offset: 0xd98
// Size: 0xcc
function private function_f852a467(a_ents) {
    a_ents[#"pap"] thread function_3c55018f("power_house");
    a_ents[#"actor 1"] clientfield::set("" + #"hash_34562274d7e875a4", 1);
    a_ents[#"actor 2"] clientfield::set("" + #"hash_34562274d7e875a4", 1);
}

// Namespace pap_quest/zm_escape_pap_quest
// Params 2, eflags: 0x4
// Checksum 0x31de0032, Offset: 0xe70
// Size: 0x16c
function private function_3c55018f(str_zone, var_9a951397 = 0) {
    self ghost();
    self waittill(#"fade_in_start");
    self show();
    self clientfield::set("" + #"hash_34562274d7e875a4", 1);
    self clientfield::increment("" + #"lightning_near");
    if (var_9a951397) {
        s_lightning_near = struct::get("lightning_near");
        playsoundatposition(#"hash_6c4553b9c8847808", s_lightning_near.origin);
    } else {
        playsoundatposition(#"hash_6c4553b9c8847808", self.origin);
    }
    self waittill(#"fade_in_end");
    pap_debris(0, str_zone);
}

// Namespace pap_quest/zm_escape_pap_quest
// Params 1, eflags: 0x4
// Checksum 0xf5d62b0, Offset: 0xfe8
// Size: 0x11c
function private function_c1c9166f(a_ents) {
    a_ents[#"pap"] thread function_55deacfe(#"hash_79b5f8e539d36a49");
    a_ents[#"pap"] clientfield::set("" + #"hash_34562274d7e875a4", 1);
    a_ents[#"fakeactor 1"] clientfield::set("" + #"hash_34562274d7e875a4", 1);
    a_ents[#"fakeactor 2"] clientfield::set("" + #"hash_34562274d7e875a4", 1);
}

// Namespace pap_quest/zm_escape_pap_quest
// Params 1, eflags: 0x4
// Checksum 0xa6cc2fcd, Offset: 0x1110
// Size: 0x11c
function private function_bc9ea8ba(a_ents) {
    a_ents[#"pap"] thread function_55deacfe(#"hash_1fc69d74f13da62e");
    a_ents[#"pap"] clientfield::set("" + #"hash_34562274d7e875a4", 1);
    a_ents[#"fakeactor 1"] clientfield::set("" + #"hash_34562274d7e875a4", 1);
    a_ents[#"fakeactor 2"] clientfield::set("" + #"hash_34562274d7e875a4", 1);
}

// Namespace pap_quest/zm_escape_pap_quest
// Params 1, eflags: 0x4
// Checksum 0x5ba9091, Offset: 0x1238
// Size: 0x11c
function private function_e9e60dd1(a_ents) {
    a_ents[#"pap"] thread function_55deacfe(#"hash_6d668f3614ed2393");
    a_ents[#"pap"] clientfield::set("" + #"hash_34562274d7e875a4", 1);
    a_ents[#"fakeactor 1"] clientfield::set("" + #"hash_34562274d7e875a4", 1);
    a_ents[#"fakeactor 2"] clientfield::set("" + #"hash_34562274d7e875a4", 1);
}

// Namespace pap_quest/zm_escape_pap_quest
// Params 1, eflags: 0x4
// Checksum 0xac90fd3a, Offset: 0x1360
// Size: 0xd4
function private function_55deacfe(var_b71464a6) {
    self ghost();
    self waittill(#"fade_in_start");
    self show();
    self clientfield::increment("" + #"lightning_near");
    playsoundatposition(#"hash_6c4553b9c8847808", self.origin);
    self waittill(#"fade_in_end");
    level notify(var_b71464a6);
    self ghost();
}

// Namespace pap_quest/zm_escape_pap_quest
// Params 2, eflags: 0x0
// Checksum 0xd249ea27, Offset: 0x1440
// Size: 0x160
function pap_debris(b_show, str_area) {
    a_mdl_debris = getentarray("debris_pap_" + str_area, "targetname");
    if (b_show) {
        foreach (mdl_debris in a_mdl_debris) {
            mdl_debris solid();
            mdl_debris show();
        }
        return;
    }
    foreach (mdl_debris in a_mdl_debris) {
        mdl_debris notsolid();
        mdl_debris hide();
    }
}

// Namespace pap_quest/zm_escape_pap_quest
// Params 0, eflags: 0x0
// Checksum 0xd579575b, Offset: 0x15a8
// Size: 0x114
function function_31d1e44e() {
    if (zm_custom::function_5638f689(#"zmpowerstate") == 1) {
        level flag::wait_till("power_on1");
        if (!level flag::get("power_on")) {
            level thread zombie_brutus_util::attempt_brutus_spawn(1, "zone_studio");
        }
    }
    level waittill(#"hash_222aa78f79091e7");
    if (zm_custom::function_5638f689(#"zmpapenabled") != 2 && !level flag::get("power_on")) {
        level thread zombie_brutus_util::attempt_brutus_spawn(1, "zone_roof");
    }
}

// Namespace pap_quest/zm_escape_pap_quest
// Params 0, eflags: 0x0
// Checksum 0x77d6dba4, Offset: 0x16c8
// Size: 0x23c
function function_330ed827() {
    level endon(#"power_on1");
    var_48859976 = getentarray("building_64_switches", "script_noteworthy");
    var_babb9874 = [];
    var_35f3c031 = randomintrange(0, var_48859976.size) + 1;
    var_8a3abd76 = getentarray("building_64_switch_" + var_35f3c031, "script_string");
    foreach (var_32272583 in var_8a3abd76) {
        if (array::contains(var_48859976, var_32272583)) {
            var_4c151937 = var_32272583;
            var_4c151937 thread zm_escape_vo_hooks::function_44b23be2();
        }
    }
    foreach (var_6d1e21d6 in var_48859976) {
        if (var_6d1e21d6 != var_4c151937) {
            var_6d1e21d6 thread function_6fd3f803();
            if (!isdefined(var_babb9874)) {
                var_babb9874 = [];
            } else if (!isarray(var_babb9874)) {
                var_babb9874 = array(var_babb9874);
            }
            var_babb9874[var_babb9874.size] = var_6d1e21d6;
        }
    }
    level thread function_c877e3f5(var_babb9874);
}

// Namespace pap_quest/zm_escape_pap_quest
// Params 0, eflags: 0x0
// Checksum 0xac62be9d, Offset: 0x1910
// Size: 0xee
function function_6fd3f803() {
    level endon(#"power_on1");
    self setinvisibletoall();
    a_e_parts = getentarray(self.target, "targetname");
    foreach (e_part in a_e_parts) {
        if (isdefined(e_part.script_noteworthy)) {
            self thread function_919262f9(e_part);
        }
    }
    self notify(#"hash_21e36726a7f30458");
}

// Namespace pap_quest/zm_escape_pap_quest
// Params 1, eflags: 0x0
// Checksum 0x34d3e2d6, Offset: 0x1a08
// Size: 0x7c
function function_919262f9(master_switch) {
    level flag::wait_till("start_zombie_round_logic");
    zm_escape::function_dbad05cf(master_switch);
    level flag::wait_till("power_on1");
    zm_escape::function_c65d0c7b(master_switch);
}

// Namespace pap_quest/zm_escape_pap_quest
// Params 1, eflags: 0x0
// Checksum 0x7e7b5c03, Offset: 0x1a90
// Size: 0x44
function function_c877e3f5(var_babb9874) {
    level flag::wait_till("power_on1");
    array::delete_all(var_babb9874);
}

// Namespace pap_quest/zm_escape_pap_quest
// Params 0, eflags: 0x0
// Checksum 0x58f4c6a6, Offset: 0x1ae0
// Size: 0x48a
function function_501afccf() {
    self endon(#"hash_168e8f0e18a79cf8");
    switch (self.script_string) {
    case #"roof":
        var_9dbdf8ac = "lgtexp_pap_rooftops_on";
        break;
    case #"building_64":
        var_9dbdf8ac = "lgtexp_pap_b64_on";
        break;
    case #"power_house":
        var_9dbdf8ac = "lgtexp_pap_powerhouse_on";
        break;
    }
    exploder::exploder(var_9dbdf8ac);
    self.var_1a941e3c = 0;
    if (isdefined(level.var_ac8946b9) && level.var_ac8946b9) {
        var_268a4493 = 1;
    } else {
        var_268a4493 = 5;
    }
    while (true) {
        self flag::wait_till(#"pap_offering_gun");
        self.var_1a941e3c++;
        self flag::wait_till_clear(#"pap_offering_gun");
        if (self.var_1a941e3c >= var_268a4493) {
            self.var_1a941e3c = 0;
            exploder::stop_exploder(var_9dbdf8ac);
            self zm_pack_a_punch::function_e95839cd(0);
            switch (self.script_string) {
            case #"roof":
                level thread scene::play(#"hash_41fada5e44b023a9");
                break;
            case #"building_64":
                level thread scene::play(#"aib_vign_zm_mob_pap_ghosts_remove_b64");
                break;
            case #"power_house":
                level thread scene::play(#"hash_7cc7d9f749a02418");
                break;
            }
            level waittill(#"hide_p");
            self zm_pack_a_punch::function_e95839cd(0, "hidden");
            self zm_pack_a_punch::set_state_hidden();
            level waittill(#"hash_79b5f8e539d36a49", #"hash_1fc69d74f13da62e", #"hash_6d668f3614ed2393");
            pap_debris(1, self.script_string);
            a_e_pack = getentarray("zm_pack_a_punch", "targetname");
            for (e_pack = self; self == e_pack; e_pack = array::random(a_e_pack)) {
            }
            wait 5;
            switch (e_pack.script_string) {
            case #"roof":
                level scene::play(#"aib_vign_zm_mob_pap_ghosts");
                break;
            case #"building_64":
                level scene::play(#"aib_vign_zm_mob_pap_ghosts_b64");
                break;
            case #"power_house":
                level scene::play(#"aib_vign_zm_mob_pap_ghosts_power_house");
                break;
            }
            e_pack zm_pack_a_punch::function_e95839cd(1);
            pap_debris(0, e_pack.script_string);
            e_pack thread function_501afccf();
            self notify(#"hash_168e8f0e18a79cf8");
        }
    }
}

