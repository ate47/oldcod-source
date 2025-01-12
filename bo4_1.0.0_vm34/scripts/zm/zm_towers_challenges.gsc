#using scripts\core_common\ai\archetype_tiger;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\weapons_shared;
#using scripts\zm\ai\zm_ai_gladiator;
#using scripts\zm\weapons\zm_weap_crossbow;
#using scripts\zm\zm_towers_crowd;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_laststand;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_round_logic;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_ui_inventory;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_vapor_random;
#using scripts\zm_common\zm_weapons;
#using scripts\zm_common\zm_zonemgr;

#namespace zm_towers_challenges;

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 0, eflags: 0x2
// Checksum 0xfbc59845, Offset: 0x660
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_towers_challenges", &__init__, &__main__, undefined);
}

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 0, eflags: 0x0
// Checksum 0x350bdee8, Offset: 0x6b0
// Size: 0x24
function __init__() {
    callback::on_finalize_initialization(&init);
}

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x6e0
// Size: 0x4
function __main__() {
    
}

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 0, eflags: 0x0
// Checksum 0x5410cdf3, Offset: 0x6f0
// Size: 0xa38
function init() {
    if (zm_utility::is_standard()) {
        return;
    }
    level flag::wait_till("all_players_spawned");
    level flag::init(#"first_player_completed_3rd_challenge");
    level flag::init(#"challenge_trap_piece_spawned");
    level._effect[#"brazier_fire"] = #"hash_387c78244f5f45e5";
    level._effect[#"energy_soul"] = #"hash_24eb30a2d07ae5a9";
    level._effect[#"energy_soul_target"] = #"hash_6f5f4eb9267613e3";
    level.var_22bc50cf = array(&function_5118405a, &function_b706b8c5, &function_2ea4a78f);
    level.var_c9e023d0 = array(&function_b03c774, &function_48f53dcd);
    level.var_d3ca2e3d = array(&function_ce7d4594, &function_44c3b7f9, &function_b28de37f);
    if (!zm_custom::function_5638f689(#"zmshieldisenabled")) {
        level.var_d3ca2e3d = array(&function_ce7d4594, &function_44c3b7f9);
    }
    level.var_61a4b8d2 = array(&function_ad9d17f9, &function_3258f41b);
    level.var_ad8d1c70 = array(&function_a54df27d, &function_d198447e, &function_5fcac81d, &function_6c927bf2);
    level.var_f77b231b = array(&function_69f24e57, &function_6ccae194);
    level.var_2d65a7e3 = getent("zm_towers_trap_piece_3", "targetname");
    level.var_2d65a7e3 hide();
    level.var_41e21193 = getentarray("t_challenge_brazier_trigger", "script_noteworthy");
    array::run_all(level.var_41e21193, &sethintstring, #"hash_37fe206ef8f70207");
    level.var_55721f5d = array();
    level.var_55721f5d[0] = "tag_easy_1";
    level.var_55721f5d[1] = "tag_easy_2";
    level.var_55721f5d[2] = "tag_easy_3";
    level.var_55721f5d[3] = "tag_medium_1";
    level.var_55721f5d[4] = "tag_medium_2";
    level.var_55721f5d[5] = "tag_medium_3";
    level.var_55721f5d[6] = "tag_hard_1";
    level.var_55721f5d[7] = "tag_hard_2";
    level.var_55721f5d[8] = "tag_hard_3";
    level.a_mdl_challenge_banners = getentarray("mdl_challenge_banners", "script_noteworthy");
    foreach (banner in level.a_mdl_challenge_banners) {
        str_color = function_d41d478(banner);
        banner scene::init("p8_fxanim_zm_towers_banner_achievement_" + str_color + "_bundle", banner);
        foreach (tag in level.var_55721f5d) {
            banner hidepart(tag);
        }
    }
    level.var_71769ea6 = getentarray("zm_towers_challenge_heads", "script_noteworthy");
    foreach (head in level.var_71769ea6) {
        head hide();
    }
    var_66f7ac25 = array(#"ar_mg1909_t8", #"lmg_standard_t8", #"tr_midburst_t8");
    var_66f7ac25 = array::randomize(var_66f7ac25);
    level.var_edd04fc6 = array(#"self_revive", #"bonus_points_player", #"pistol_standard_t8_upgraded", #"full_ammo", #"hero_weapon_power", var_66f7ac25[0], #"free_perk", #"full_ammo", #"lmg_spray_t8_upgraded");
    zm_spawner::register_zombie_death_event_callback(&function_89a2dd63);
    zm_spawner::register_zombie_death_event_callback(&function_a3e66a17);
    zm_spawner::register_zombie_death_event_callback(&function_b8b46e08);
    zm_spawner::register_zombie_death_event_callback(&function_65ed6734);
    zm_spawner::register_zombie_death_event_callback(&function_b859ac3d);
    zm_spawner::register_zombie_death_event_callback(&function_caf03761);
    zm_spawner::register_zombie_death_event_callback(&function_1bbf0039);
    zm_spawner::register_zombie_death_event_callback(&function_98dc75cb);
    zm_spawner::register_zombie_death_event_callback(&function_1b84dba9);
    zm_spawner::register_zombie_death_event_callback(&function_d55154fe);
    callback::on_ai_damage(&function_e8b8b93a);
    zm_ai_gladiator::function_7f08b6a7(&function_87df4e94);
    level.get_player_perk_purchase_limit = &function_1adeaa1c;
    var_f20a1a82 = getentarray("t_zm_towers_cleat_damage_trig", "script_noteworthy");
    foreach (var_8e7ce497 in var_f20a1a82) {
        var_c70474ee = getent(var_8e7ce497.targetname + "_hint", "targetname");
        thread function_b43ac97c(getent(var_8e7ce497.targetname, "targetname"), var_c70474ee);
    }
}

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 1, eflags: 0x0
// Checksum 0x5b0c45d6, Offset: 0x1130
// Size: 0x8a
function function_d41d478(mdl_banner) {
    switch (mdl_banner.targetname) {
    case #"hash_5485fa3ed2c27d5c":
        return "green";
    case #"ra_brazier_banner":
        return "red";
    case #"odin_brazier_banner":
        return "blue";
    case #"zeus_brazier_banner":
        return "purple";
    }
}

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 1, eflags: 0x0
// Checksum 0xc98916e1, Offset: 0x11c8
// Size: 0x84
function function_3b7f1c73(n_time = 0) {
    self notify(#"hash_b296fe3ccb7d273");
    self endon(#"disconnect", #"hash_b296fe3ccb7d273");
    if (n_time > 0) {
        wait n_time;
    }
    level zm_ui_inventory::function_31a39683(#"zm_towers_challenges", 0, self);
}

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 2, eflags: 0x0
// Checksum 0x59a6dc7d, Offset: 0x1258
// Size: 0x364
function function_4702e540(e_player, var_8e7ce497) {
    e_player endon(#"disconnect");
    e_player flag::init(#"hash_5a74f9da0718c63d");
    e_player flag::init(#"flag_player_completed_all_challenges");
    e_trig = self;
    e_trig flag::set(#"hash_19856658ee6e4f3a");
    e_trig.banner = getent(e_trig.target, "targetname");
    e_trig.banner.var_88d6c87 = getent(e_trig.banner.target, "targetname");
    foreach (player in getplayers()) {
        if (player != e_player) {
            e_trig.banner.var_88d6c87 setinvisibletoplayer(player);
        }
    }
    var_8e7ce497.challenge_struct.e_trig = e_trig;
    e_trig.challenge_struct = var_8e7ce497.challenge_struct;
    switch (e_trig.challenge_struct.targetname) {
    case #"odin_brazier":
        level clientfield::set("brazier_fire_blue", 1);
        var_74900bd6 = #"hash_78c79ed7fe5a14e6";
        break;
    case #"zeus_brazier":
        level clientfield::set("brazier_fire_purple", 1);
        var_74900bd6 = #"hash_2865f19fb8f73873";
        break;
    case #"ra_brazier":
        level clientfield::set("brazier_fire_red", 1);
        var_74900bd6 = #"hash_260c83bb9470b";
        break;
    case #"danu_brazier":
        level clientfield::set("brazier_fire_green", 1);
        var_74900bd6 = #"hash_7ff858c269b8be00";
        break;
    }
    level thread zm_audio::sndannouncerplayvox(var_74900bd6);
    var_8e7ce497.challenge_struct thread function_36147f3a(e_player, e_trig);
}

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 2, eflags: 0x0
// Checksum 0xabaf4a7a, Offset: 0x15c8
// Size: 0x694
function function_36147f3a(e_player, e_trig) {
    e_player endon(#"disconnect");
    if (!e_player flag::get(#"flag_player_completed_all_challenges")) {
        self flag::init(#"hash_5a7dfe069f4cbcec");
        e_player flag::init(#"flag_player_initialized_reward");
        e_player flag::init(#"hash_6534297bbe7e180d");
        level.var_22bc50cf = array::randomize(level.var_22bc50cf);
        level.var_c9e023d0 = array::randomize(level.var_c9e023d0);
        level.var_d3ca2e3d = array::randomize(level.var_d3ca2e3d);
        level.var_61a4b8d2 = array::randomize(level.var_61a4b8d2);
        level.var_ad8d1c70 = array::randomize(level.var_ad8d1c70);
        level.var_f77b231b = array::randomize(level.var_f77b231b);
        self.var_4af81c00 = array();
        self.var_4af81c00[0] = level.var_22bc50cf[0];
        self.var_4af81c00[1] = level.var_22bc50cf[1];
        self.var_4af81c00[2] = level.var_c9e023d0[0];
        self.var_4af81c00[3] = level.var_d3ca2e3d[0];
        self.var_4af81c00[4] = level.var_d3ca2e3d[1];
        self.var_4af81c00[5] = level.var_61a4b8d2[0];
        self.var_4af81c00[6] = level.var_ad8d1c70[0];
        self.var_4af81c00[7] = level.var_ad8d1c70[1];
        self.var_4af81c00[8] = level.var_f77b231b[0];
        self.var_d8619fa0 = 0;
        var_7dd3fff9 = 0;
        self.n_counter = 0;
    }
    while (self.n_counter < self.var_4af81c00.size) {
        self flag::set(#"hash_5a7dfe069f4cbcec");
        while (self flag::get(#"hash_5a7dfe069f4cbcec")) {
            /#
                level.var_5d16fd23 = 1;
                self.var_fb9d9fe9 = 1;
            #/
            if (var_7dd3fff9 === 1) {
                [[ self.var_4af81c00[self.n_counter] ]](e_player, e_trig, var_7dd3fff9);
                var_7dd3fff9 = 0;
                continue;
            }
            e_player thread function_f9ec785a(#"challenge_available");
            [[ self.var_4af81c00[self.n_counter] ]](e_player, e_trig, var_7dd3fff9);
            if (self.n_counter == 2 && level flag::get("first_player_completed_3rd_challenge") && !level flag::get("challenge_trap_piece_spawned")) {
                level thread function_8e5fed7d();
            }
        }
        wait 2.75;
        e_trig.banner showpart(level.var_55721f5d[self.n_counter]);
        self.n_counter++;
    }
    e_trig sethintstring(#"hash_6a6563f3b19ad5bd");
    switch (e_trig.challenge_struct.targetname) {
    case #"odin_brazier":
        level clientfield::set("brazier_fire_blue", 2);
        var_74900bd6 = #"challenges_odin_completed";
        break;
    case #"zeus_brazier":
        level clientfield::set("brazier_fire_purple", 2);
        var_74900bd6 = #"challenges_zeus_completed";
        break;
    case #"ra_brazier":
        level clientfield::set("brazier_fire_red", 2);
        var_74900bd6 = #"challenges_ra_completed";
        break;
    case #"danu_brazier":
        level clientfield::set("brazier_fire_green", 2);
        var_74900bd6 = #"challenges_danu_completed";
        break;
    }
    if (!e_player flag::get(#"flag_player_completed_all_challenges")) {
        e_player flag::set(#"flag_player_completed_all_challenges");
        e_player thread function_8abce7cb(var_74900bd6);
        if (level.players.size > 1) {
            e_player function_17ccc046(e_trig);
        }
    }
}

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 1, eflags: 0x0
// Checksum 0x14643cea, Offset: 0x1c68
// Size: 0x14e
function function_f9ec785a(str_type) {
    self endon(#"disconnect");
    if (str_type == #"challenge_completed") {
        if (!isdefined(self.var_ed68528b)) {
            self.var_ed68528b = 0;
        }
        str_prefix = "challenges_challenge_completed_";
        n_vo = self.var_ed68528b;
        var_c15eb536 = 9;
    } else {
        if (!isdefined(self.var_e87adb3e)) {
            self.var_e87adb3e = 0;
        }
        str_prefix = "challenges_challenge_available_";
        n_vo = self.var_e87adb3e;
        var_c15eb536 = 9;
    }
    var_74900bd6 = hash(str_prefix + n_vo);
    level thread zm_audio::sndannouncerplayvox(var_74900bd6, self);
    n_vo++;
    if (n_vo > var_c15eb536) {
        n_vo = 0;
    }
    if (str_type == #"challenge_completed") {
        self.var_ed68528b = n_vo;
        return;
    }
    self.var_e87adb3e = n_vo;
}

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 1, eflags: 0x0
// Checksum 0xbe950de, Offset: 0x1dc0
// Size: 0x210
function function_8abce7cb(var_74900bd6) {
    self endon(#"disconnect");
    level zm_audio::sndannouncerplayvox(var_74900bd6);
    a_e_players = level.players;
    arrayremovevalue(a_e_players, self);
    foreach (e_player in a_e_players) {
        if (isdefined(e_player.challenge_struct) && e_player flag::exists("flag_player_completed_all_challenges") && !e_player flag::get("flag_player_completed_all_challenges")) {
            str_brazier = e_player.challenge_struct.targetname;
            switch (str_brazier) {
            case #"danu_brazier":
                var_a9a78b86 = #"hash_597c4173f2fd41a4";
                break;
            case #"ra_brazier":
                var_a9a78b86 = #"hash_550bed5125d97a89";
                break;
            case #"odin_brazier":
                var_a9a78b86 = #"hash_31347fc188da1db6";
                break;
            case #"zeus_brazier":
                var_a9a78b86 = #"hash_6c9a2587a2563721";
                break;
            }
            level zm_audio::sndannouncerplayvox(var_a9a78b86);
        }
    }
}

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 0, eflags: 0x0
// Checksum 0x2aa58bd8, Offset: 0x1fd8
// Size: 0xfc
function function_8e5fed7d() {
    level flag::set("challenge_trap_piece_spawned");
    fx_model = util::spawn_model("tag_origin", level.var_2d65a7e3.origin);
    fx_model clientfield::set("blue_glow", 1);
    wait 1;
    level.var_2d65a7e3 show();
    mdl_clip = getent("mdl_acid_trap_cauldron_piece_clip", "targetname");
    mdl_clip solid();
    wait 1;
    fx_model clientfield::set("blue_glow", 0);
}

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 1, eflags: 0x0
// Checksum 0x317cbff4, Offset: 0x20e0
// Size: 0x160
function function_17ccc046(e_trig) {
    self endon(#"disconnect");
    level endon(#"end_game");
    e_player = self;
    foreach (var_27cb36ed in level.var_41e21193) {
        if (var_27cb36ed != e_trig && var_27cb36ed flag::exists(#"hash_19856658ee6e4f3a")) {
            var_27cb36ed setvisibletoplayer(e_player);
            var_27cb36ed.banner.var_88d6c87 setvisibletoplayer(e_player);
            var_27cb36ed sethintstringforplayer(e_player, #"hash_9b98137ec7cd136");
            var_27cb36ed thread function_8763d1d(e_player, e_trig);
        }
    }
}

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 2, eflags: 0x0
// Checksum 0x9b2af815, Offset: 0x2248
// Size: 0x2cc
function function_8763d1d(e_player, var_e66cdee0) {
    level endon(#"end_game");
    e_player endon(#"disconnect");
    while (true) {
        s_info = self waittill(#"trigger");
        if (s_info.activator == e_player && e_player flag::get(#"flag_player_completed_all_challenges")) {
            if (e_player zm_score::can_player_purchase(2500)) {
                e_player zm_score::minus_to_player_score(2500);
                break;
            }
        }
        self sethintstringforplayer(e_player, #"hash_9b98137ec7cd136");
    }
    e_player.challenge_struct = self.challenge_struct;
    if (!isdefined(e_player.challenge_struct.var_2cdba90)) {
        e_player.challenge_struct.var_2cdba90 = array();
    }
    array::add(e_player.challenge_struct.var_2cdba90, e_player, 0);
    foreach (var_27cb36ed in level.var_41e21193) {
        if (var_27cb36ed != var_e66cdee0 && var_27cb36ed != self) {
            var_27cb36ed setinvisibletoplayer(e_player);
        }
    }
    while (!e_player.challenge_struct.var_9ab76d44 flag::get(#"hash_6534297bbe7e180d") && e_player.challenge_struct.var_9ab76d44 flag::get(#"flag_player_initialized_reward")) {
        wait 3;
    }
    e_player.challenge_struct function_36147f3a(e_player, var_27cb36ed);
}

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 2, eflags: 0x0
// Checksum 0xb404f43b, Offset: 0x2520
// Size: 0x324
function function_cc0783e4(n_current_progress, var_6e2e691b) {
    var_36129b32 = n_current_progress / var_6e2e691b;
    var_36129b32 *= 100;
    var_614bd842 = self.targetname;
    switch (var_614bd842) {
    case #"odin_brazier":
        var_e898dbf1 = "head_fire_blue";
        break;
    case #"danu_brazier":
        var_e898dbf1 = "head_fire_green";
        break;
    case #"zeus_brazier":
        var_e898dbf1 = "head_fire_purple";
        break;
    case #"ra_brazier":
        var_e898dbf1 = "head_fire_red";
        break;
    }
    if (var_36129b32 >= 20) {
        var_39f85175 = getent(self.targetname + "_head1", "targetname");
        var_39f85175 show();
        var_39f85175 clientfield::set(var_e898dbf1, 1);
    }
    if (var_36129b32 >= 40) {
        var_39f85175 = getent(self.targetname + "_head2", "targetname");
        var_39f85175 show();
        var_39f85175 clientfield::set(var_e898dbf1, 1);
    }
    if (var_36129b32 >= 60) {
        var_39f85175 = getent(self.targetname + "_head3", "targetname");
        var_39f85175 show();
        var_39f85175 clientfield::set(var_e898dbf1, 1);
    }
    if (var_36129b32 >= 80) {
        var_39f85175 = getent(self.targetname + "_head4", "targetname");
        var_39f85175 show();
        var_39f85175 clientfield::set(var_e898dbf1, 1);
    }
    if (var_36129b32 == 100) {
        var_39f85175 = getent(self.targetname + "_head5", "targetname");
        var_39f85175 show();
        var_39f85175 clientfield::set(var_e898dbf1, 1);
    }
}

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 1, eflags: 0x0
// Checksum 0x64f0eda0, Offset: 0x2850
// Size: 0x1f8
function function_7e6325fe(b_success = 0) {
    var_de411a11 = getentarray(self.targetname + "_heads", "script_banner_ref");
    foreach (mdl_head in var_de411a11) {
        if (b_success) {
            var_53f2b850 = struct::get(mdl_head.target, "targetname");
            var_13f8071c = struct::get(var_53f2b850.target, "targetname");
            var_9297734c = util::spawn_model("tag_origin", var_53f2b850.origin, var_53f2b850.angles);
            var_625d9fa2 = util::spawn_model("tag_origin", var_13f8071c.origin, var_13f8071c.angles);
            var_9297734c clientfield::set("energy_soul", 1);
            var_625d9fa2 clientfield::set("energy_soul_target", 1);
            thread function_86555086(mdl_head, var_9297734c, var_625d9fa2);
            continue;
        }
        mdl_head hide();
    }
}

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 4, eflags: 0x0
// Checksum 0x785a0ae5, Offset: 0x2a50
// Size: 0x84
function function_86555086(mdl_head, var_62c99791, var_b50a0e3b, n_time = 2.25) {
    wait n_time;
    var_62c99791 delete();
    var_b50a0e3b delete();
    mdl_head hide();
}

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 3, eflags: 0x0
// Checksum 0xd42634c6, Offset: 0x2ae0
// Size: 0x36c
function function_5118405a(e_player, e_trig, var_7dd3fff9) {
    e_player endon(#"disconnect");
    if (var_7dd3fff9 === 1) {
        e_trig sethintstring(#"hash_9b98137ec7cd136");
        e_trig waittill(#"trigger");
    }
    e_trig.hint_string = #"hash_172f6f29aaee2d0";
    e_trig sethintstring(e_trig.hint_string, 6);
    if (!isdefined(self.var_8c3dc3bd)) {
        self.var_8c3dc3bd = 0;
    }
    if (e_player == self.var_9ab76d44) {
        level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", 0, e_player);
        level zm_ui_inventory::function_31a39683(#"zm_towers_challenges", 1, e_player);
    }
    if (isdefined(self.var_2cdba90)) {
        foreach (var_9eb7bdb9 in e_player.challenge_struct.var_2cdba90) {
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", 0, var_9eb7bdb9);
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges", 1, var_9eb7bdb9);
        }
    }
    /#
        self.var_66447cf1 = 6;
        self.var_401b6c18 = "<dev string:x30>";
    #/
    self waittill(#"hash_7c2dd12641ed6bf5");
    if (e_player == self.var_9ab76d44) {
        level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", 6, e_player);
    }
    if (isdefined(self.var_2cdba90)) {
        foreach (var_9eb7bdb9 in e_player.challenge_struct.var_2cdba90) {
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", 6, var_9eb7bdb9);
        }
    }
    playsoundatposition(#"zmb_challenges_complete", (0, 0, 0));
    self.var_8c3dc3bd = undefined;
    e_trig function_79e4e667(e_player, 6);
    self flag::clear(#"hash_5a7dfe069f4cbcec");
}

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 1, eflags: 0x0
// Checksum 0x7ddb15e3, Offset: 0x2e58
// Size: 0x360
function function_d55154fe(e_attacker) {
    if (!isplayer(e_attacker)) {
        return;
    }
    e_player = e_attacker;
    if (!isdefined(e_player.challenge_struct) || !isdefined(e_player.challenge_struct.var_8c3dc3bd)) {
        return;
    }
    var_8a8eeb66 = self.damageweapon;
    if (e_player._gadgets_player[1] == var_8a8eeb66 || e_player._gadgets_player[1] == getweapon("mini_turret") && var_8a8eeb66 == getweapon("gun_mini_turret") || e_player._gadgets_player[1] == getweapon("eq_wraith_fire") && var_8a8eeb66 == getweapon("wraith_fire_fire") || e_player._gadgets_player[1] == getweapon("eq_molotov") && var_8a8eeb66 == getweapon("molotov_fire")) {
        e_player.challenge_struct.var_8c3dc3bd++;
        n_progress = e_player.challenge_struct.var_8c3dc3bd;
        if (n_progress >= 6) {
            e_player.challenge_struct.var_8c3dc3bd = 6;
            n_progress = 6;
        }
        e_player.challenge_struct function_cc0783e4(n_progress, 6);
        if (e_player == e_player.challenge_struct.var_9ab76d44) {
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", n_progress, e_player);
        }
        if (isdefined(e_player.challenge_struct.var_2cdba90)) {
            foreach (var_9eb7bdb9 in e_player.challenge_struct.var_2cdba90) {
                level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", n_progress, var_9eb7bdb9);
            }
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", n_progress, e_player.challenge_struct.var_9ab76d44);
        }
    } else {
        return;
    }
    if (n_progress >= 6) {
        e_player.challenge_struct notify(#"hash_7c2dd12641ed6bf5");
    }
}

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 3, eflags: 0x0
// Checksum 0xaf08c9c2, Offset: 0x31c0
// Size: 0x3ac
function function_48f53dcd(e_player, e_trig, var_7dd3fff9) {
    e_player endon(#"disconnect");
    if (var_7dd3fff9 === 1) {
        e_trig sethintstring(#"hash_9b98137ec7cd136");
        e_trig waittill(#"trigger");
    }
    e_trig.hint_string = #"hash_51397dc3d51e150c";
    e_trig sethintstring(e_trig.hint_string, 10);
    if (!isdefined(self.var_b4a4e6d4)) {
        self.var_b4a4e6d4 = 0;
    }
    if (e_player == self.var_9ab76d44) {
        level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", 0, e_player);
        level zm_ui_inventory::function_31a39683(#"zm_towers_challenges", 2, e_player);
    }
    if (isdefined(self.var_2cdba90)) {
        foreach (var_9eb7bdb9 in e_player.challenge_struct.var_2cdba90) {
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", 0, var_9eb7bdb9);
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges", 2, var_9eb7bdb9);
        }
    }
    /#
        self.var_66447cf1 = 10;
        self.var_401b6c18 = "<dev string:x54>";
    #/
    self waittill(#"hash_7731445a0fb80df");
    if (e_player == self.var_9ab76d44) {
        level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", 10, e_player);
    }
    if (isdefined(self.var_2cdba90)) {
        foreach (var_9eb7bdb9 in e_player.challenge_struct.var_2cdba90) {
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", 10, var_9eb7bdb9);
        }
    }
    playsoundatposition(#"zmb_challenges_complete", (0, 0, 0));
    self.var_b4a4e6d4 = undefined;
    e_trig function_79e4e667(e_player, 10);
    self flag::clear(#"hash_5a7dfe069f4cbcec");
    if (!level flag::get(#"first_player_completed_3rd_challenge")) {
        level flag::set(#"first_player_completed_3rd_challenge");
    }
}

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 1, eflags: 0x0
// Checksum 0xe3a271de, Offset: 0x3578
// Size: 0x268
function function_1bbf0039(e_attacker) {
    if (!isplayer(e_attacker)) {
        return;
    }
    e_player = e_attacker;
    if (!isdefined(e_player.challenge_struct) || !isdefined(e_player.challenge_struct.var_b4a4e6d4)) {
        return;
    }
    n_progress = 0;
    var_8a8eeb66 = self.damageweapon;
    if (zm_loadout::is_hero_weapon(var_8a8eeb66)) {
        e_player.challenge_struct.var_b4a4e6d4++;
        n_progress = e_player.challenge_struct.var_b4a4e6d4;
        if (n_progress >= 10) {
            e_player.challenge_struct.var_b4a4e6d4 = 10;
            n_progress = 10;
        }
        e_player.challenge_struct function_cc0783e4(n_progress, 10);
        if (e_player == e_player.challenge_struct.var_9ab76d44) {
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", n_progress, e_player);
        }
        if (isdefined(e_player.challenge_struct.var_2cdba90)) {
            foreach (var_9eb7bdb9 in e_player.challenge_struct.var_2cdba90) {
                level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", n_progress, var_9eb7bdb9);
            }
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", n_progress, e_player.challenge_struct.var_9ab76d44);
        }
    }
    if (n_progress >= 10) {
        e_player.challenge_struct notify(#"hash_7731445a0fb80df");
    }
}

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 3, eflags: 0x0
// Checksum 0xaaa281f7, Offset: 0x37e8
// Size: 0x36c
function function_b706b8c5(e_player, e_trig, var_7dd3fff9) {
    e_player endon(#"disconnect");
    if (var_7dd3fff9 === 1) {
        e_trig sethintstring(#"hash_9b98137ec7cd136");
        e_trig waittill(#"trigger");
    }
    e_trig.hint_string = #"hash_1b26db34a1fb9d5f";
    e_trig sethintstring(e_trig.hint_string, 13);
    if (!isdefined(self.var_546b0d68)) {
        self.var_546b0d68 = 0;
    }
    if (e_player == self.var_9ab76d44) {
        level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", 0, e_player);
        level zm_ui_inventory::function_31a39683(#"zm_towers_challenges", 3, e_player);
    }
    if (isdefined(self.var_2cdba90)) {
        foreach (var_9eb7bdb9 in e_player.challenge_struct.var_2cdba90) {
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", 0, var_9eb7bdb9);
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges", 3, var_9eb7bdb9);
        }
    }
    /#
        self.var_66447cf1 = 13;
        self.var_401b6c18 = "<dev string:x79>";
    #/
    self waittill(#"hash_76251ea6bc659497");
    if (e_player == self.var_9ab76d44) {
        level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", 13, e_player);
    }
    if (isdefined(self.var_2cdba90)) {
        foreach (var_9eb7bdb9 in e_player.challenge_struct.var_2cdba90) {
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", 13, var_9eb7bdb9);
        }
    }
    playsoundatposition(#"zmb_challenges_complete", (0, 0, 0));
    self.var_546b0d68 = undefined;
    e_trig function_79e4e667(e_player, 13);
    self flag::clear(#"hash_5a7dfe069f4cbcec");
}

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 1, eflags: 0x0
// Checksum 0x10967bc5, Offset: 0x3b60
// Size: 0x310
function function_caf03761(e_attacker) {
    if (!isplayer(e_attacker)) {
        return;
    }
    e_player = e_attacker;
    if (!isdefined(e_player.challenge_struct) || !isdefined(e_player.challenge_struct.var_546b0d68)) {
        return;
    }
    w_knife = getweapon("knife");
    var_c028dd58 = getweapon("knife_widows_wine");
    w_bowie_knife = getweapon("bowie_knife");
    var_48bed0e6 = getweapon("bowie_knife_widows_wine");
    n_progress = 0;
    if (self.damageweapon == w_knife || self.damageweapon == var_c028dd58 || self.damageweapon == w_bowie_knife || self.damageweapon == var_48bed0e6) {
        e_player.challenge_struct.var_546b0d68++;
        n_progress = e_player.challenge_struct.var_546b0d68;
        if (n_progress >= 13) {
            e_player.challenge_struct.var_546b0d68 = 13;
            n_progress = 13;
        }
        e_player.challenge_struct function_cc0783e4(n_progress, 13);
        if (e_player == e_player.challenge_struct.var_9ab76d44) {
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", n_progress, e_player);
        }
        if (isdefined(e_player.challenge_struct.var_2cdba90)) {
            foreach (var_9eb7bdb9 in e_player.challenge_struct.var_2cdba90) {
                level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", n_progress, var_9eb7bdb9);
            }
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", n_progress, e_player.challenge_struct.var_9ab76d44);
        }
    }
    if (n_progress >= 13) {
        e_attacker.challenge_struct notify(#"hash_76251ea6bc659497");
    }
}

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 3, eflags: 0x0
// Checksum 0x2bcc869e, Offset: 0x3e78
// Size: 0x36c
function function_2ea4a78f(e_player, e_trig, var_7dd3fff9) {
    e_player endon(#"disconnect");
    if (var_7dd3fff9 === 1) {
        e_trig sethintstring(#"hash_9b98137ec7cd136");
        e_trig waittill(#"trigger");
    }
    e_trig.hint_string = #"hash_110075b9efe67cd0";
    e_trig sethintstring(e_trig.hint_string, 5);
    if (!isdefined(self.var_b69135f8)) {
        self.var_b69135f8 = 0;
    }
    if (e_player == self.var_9ab76d44) {
        level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", 0, e_player);
        level zm_ui_inventory::function_31a39683(#"zm_towers_challenges", 4, e_player);
    }
    if (isdefined(self.var_2cdba90)) {
        foreach (var_9eb7bdb9 in e_player.challenge_struct.var_2cdba90) {
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", 0, var_9eb7bdb9);
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges", 4, var_9eb7bdb9);
        }
    }
    /#
        self.var_66447cf1 = 5;
        self.var_401b6c18 = "<dev string:x98>";
    #/
    self waittill(#"headshot_challenge_completed");
    if (e_player == self.var_9ab76d44) {
        level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", 5, e_player);
    }
    if (isdefined(self.var_2cdba90)) {
        foreach (var_9eb7bdb9 in e_player.challenge_struct.var_2cdba90) {
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", 5, var_9eb7bdb9);
        }
    }
    playsoundatposition(#"zmb_challenges_complete", (0, 0, 0));
    self.var_b69135f8 = undefined;
    e_trig function_79e4e667(e_player, 5);
    self flag::clear(#"hash_5a7dfe069f4cbcec");
}

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 1, eflags: 0x0
// Checksum 0x3d75e6e3, Offset: 0x41f0
// Size: 0x2c8
function function_89a2dd63(e_attacker) {
    if (!isplayer(e_attacker)) {
        return;
    }
    e_player = e_attacker;
    if (!isdefined(e_player.challenge_struct) || !isdefined(e_player.challenge_struct.var_b69135f8)) {
        return;
    }
    n_progress = 0;
    if (zm_utility::is_headshot(self.damageweapon, self.damagelocation, self.damagemod)) {
        e_player.challenge_struct.var_b69135f8++;
        n_progress = e_player.challenge_struct.var_b69135f8;
        if (n_progress >= 5) {
            e_player.challenge_struct.var_b69135f8 = 5;
            n_progress = 5;
        }
        e_player.challenge_struct function_cc0783e4(n_progress, 5);
    } else if (e_player == e_player.challenge_struct.var_9ab76d44) {
        e_player.challenge_struct.var_b69135f8 = 0;
        n_progress = 0;
        e_player.challenge_struct function_7e6325fe();
    }
    if (e_player == e_player.challenge_struct.var_9ab76d44) {
        level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", n_progress, e_player);
    }
    if (isdefined(e_player.challenge_struct.var_2cdba90)) {
        foreach (var_9eb7bdb9 in e_player.challenge_struct.var_2cdba90) {
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", n_progress, var_9eb7bdb9);
        }
        level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", n_progress, e_player.challenge_struct.var_9ab76d44);
    }
    if (n_progress >= 5) {
        e_attacker.challenge_struct notify(#"headshot_challenge_completed");
    }
}

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 3, eflags: 0x0
// Checksum 0x7f719f8c, Offset: 0x44c0
// Size: 0x3bc
function function_b03c774(e_player, e_trig, var_7dd3fff9) {
    e_player endon(#"disconnect");
    if (var_7dd3fff9 === 1) {
        e_trig sethintstring(#"hash_9b98137ec7cd136");
        e_trig waittill(#"trigger");
    }
    e_trig.hint_string = #"hash_12f9edb86e6ba05d";
    e_trig sethintstring(e_trig.hint_string, 1);
    if (!isdefined(self.var_63f26948)) {
        self.var_63f26948 = 0;
    }
    if (e_player == self.var_9ab76d44) {
        level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", 0, e_player);
        level zm_ui_inventory::function_31a39683(#"zm_towers_challenges", 5, e_player);
    }
    if (isdefined(self.var_2cdba90)) {
        foreach (var_9eb7bdb9 in e_player.challenge_struct.var_2cdba90) {
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", 0, var_9eb7bdb9);
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges", 5, var_9eb7bdb9);
        }
    }
    /#
        self.var_66447cf1 = 1;
        self.var_401b6c18 = "<dev string:xb5>";
    #/
    e_player thread function_2d685414();
    self waittill(#"hash_1b7d29ca77ce35c");
    if (e_player == self.var_9ab76d44) {
        level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", 1, e_player);
    }
    if (isdefined(self.var_2cdba90)) {
        foreach (var_9eb7bdb9 in e_player.challenge_struct.var_2cdba90) {
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", 1, var_9eb7bdb9);
        }
    }
    playsoundatposition(#"zmb_challenges_complete", (0, 0, 0));
    self.var_63f26948 = undefined;
    e_trig function_79e4e667(e_player, 1);
    self flag::clear(#"hash_5a7dfe069f4cbcec");
    if (!level flag::get(#"first_player_completed_3rd_challenge")) {
        level flag::set(#"first_player_completed_3rd_challenge");
    }
}

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 0, eflags: 0x0
// Checksum 0x500a84e2, Offset: 0x4888
// Size: 0x258
function function_2d685414() {
    self endon(#"disconnect");
    if (!isplayer(self)) {
        return;
    }
    e_player = self;
    if (!isdefined(e_player.challenge_struct) || !isdefined(e_player.challenge_struct.var_63f26948)) {
        return;
    }
    e_player waittill(#"hash_731c84be18ae9fa3");
    e_player.challenge_struct.var_63f26948++;
    n_progress = e_player.challenge_struct.var_63f26948;
    if (n_progress >= 1) {
        e_player.challenge_struct.var_63f26948 = 1;
        n_progress = 1;
    }
    e_player.challenge_struct function_cc0783e4(n_progress, 1);
    if (e_player == e_player.challenge_struct.var_9ab76d44) {
        level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", n_progress, e_player);
    }
    if (isdefined(e_player.challenge_struct.var_2cdba90)) {
        foreach (var_9eb7bdb9 in e_player.challenge_struct.var_2cdba90) {
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", n_progress, var_9eb7bdb9);
        }
        level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", n_progress, e_player.challenge_struct.var_9ab76d44);
    }
    if (n_progress >= 1) {
        e_player.challenge_struct notify(#"hash_1b7d29ca77ce35c");
    }
}

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 3, eflags: 0x0
// Checksum 0xd98e901f, Offset: 0x4ae8
// Size: 0x324
function function_ce7d4594(e_player, e_trig, var_7dd3fff9) {
    e_player endon(#"disconnect");
    e_trig.hint_string = #"hash_79cb73f346a68dba";
    e_trig sethintstring(e_trig.hint_string, 9);
    if (!isdefined(self.var_da1ed675)) {
        self.var_da1ed675 = 0;
    }
    if (e_player == self.var_9ab76d44) {
        level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", 0, e_player);
        level zm_ui_inventory::function_31a39683(#"zm_towers_challenges", 6, e_player);
    }
    if (isdefined(self.var_2cdba90)) {
        foreach (var_9eb7bdb9 in e_player.challenge_struct.var_2cdba90) {
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", 0, var_9eb7bdb9);
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges", 6, var_9eb7bdb9);
        }
    }
    /#
        self.var_66447cf1 = 9;
        self.var_401b6c18 = "<dev string:xd4>";
    #/
    self waittill(#"hash_6edbb9b7bfeb38a3");
    if (e_player == self.var_9ab76d44) {
        level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", 9, e_player);
    }
    if (isdefined(self.var_2cdba90)) {
        foreach (var_9eb7bdb9 in e_player.challenge_struct.var_2cdba90) {
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", 9, var_9eb7bdb9);
        }
    }
    playsoundatposition(#"zmb_challenges_complete", (0, 0, 0));
    self.var_da1ed675 = undefined;
    e_trig function_79e4e667(e_player, 9);
    self flag::clear(#"hash_5a7dfe069f4cbcec");
}

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 1, eflags: 0x0
// Checksum 0xd2ee0e39, Offset: 0x4e18
// Size: 0x2e0
function function_87df4e94(attacker) {
    if (!isplayer(attacker)) {
        return;
    }
    e_player = attacker;
    if (!isdefined(e_player.challenge_struct) || !isdefined(e_player.challenge_struct.var_da1ed675)) {
        return;
    }
    e_player.challenge_struct.var_da1ed675++;
    n_progress = e_player.challenge_struct.var_da1ed675;
    if (n_progress >= 9) {
        e_player.challenge_struct.var_da1ed675 = 9;
        n_progress = 9;
    }
    e_player.challenge_struct function_cc0783e4(n_progress, 9);
    if (e_player == e_player.challenge_struct.var_9ab76d44) {
        level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", n_progress, e_player);
        if (isdefined(e_player.challenge_struct.var_2cdba90)) {
            foreach (var_9eb7bdb9 in e_player.challenge_struct.var_2cdba90) {
                level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", n_progress, var_9eb7bdb9);
            }
        }
    } else if (isdefined(e_player.challenge_struct.var_2cdba90)) {
        foreach (var_9eb7bdb9 in e_player.challenge_struct.var_2cdba90) {
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", n_progress, var_9eb7bdb9);
        }
        level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", n_progress, e_player.challenge_struct.var_9ab76d44);
    }
    if (n_progress >= 9) {
        e_player.challenge_struct notify(#"hash_6edbb9b7bfeb38a3");
    }
}

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 3, eflags: 0x0
// Checksum 0x3d113c18, Offset: 0x5100
// Size: 0x324
function function_3258f41b(e_player, e_trig, var_7dd3fff9) {
    e_player endon(#"disconnect");
    e_trig.hint_string = #"hash_a3dbb8559be3c1";
    e_trig sethintstring(e_trig.hint_string, 5);
    if (!isdefined(self.var_2bc31bc8)) {
        self.var_2bc31bc8 = 0;
    }
    if (e_player == self.var_9ab76d44) {
        level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", 0, e_player);
        level zm_ui_inventory::function_31a39683(#"zm_towers_challenges", 7, e_player);
    }
    if (isdefined(self.var_2cdba90)) {
        foreach (var_9eb7bdb9 in e_player.challenge_struct.var_2cdba90) {
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", 0, var_9eb7bdb9);
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges", 7, var_9eb7bdb9);
        }
    }
    /#
        self.var_66447cf1 = 5;
        self.var_401b6c18 = "<dev string:xf6>";
    #/
    self waittill(#"hash_31d79470abcf1282");
    if (e_player == self.var_9ab76d44) {
        level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", 5, e_player);
    }
    if (isdefined(self.var_2cdba90)) {
        foreach (var_9eb7bdb9 in e_player.challenge_struct.var_2cdba90) {
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", 5, var_9eb7bdb9);
        }
    }
    playsoundatposition(#"zmb_challenges_complete", (0, 0, 0));
    self.var_2bc31bc8 = undefined;
    e_trig function_79e4e667(e_player, 5);
    self flag::clear(#"hash_5a7dfe069f4cbcec");
}

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 1, eflags: 0x0
// Checksum 0x60bbf600, Offset: 0x5430
// Size: 0x258
function function_98dc75cb(attacker) {
    if (!isplayer(attacker)) {
        return;
    }
    e_player = attacker;
    if (!isdefined(e_player.challenge_struct) || !isdefined(e_player.challenge_struct.var_2bc31bc8)) {
        return;
    }
    n_progress = 0;
    if (self.archetype == "tiger") {
        e_player.challenge_struct.var_2bc31bc8++;
        n_progress = e_player.challenge_struct.var_2bc31bc8;
        if (n_progress >= 5) {
            e_player.challenge_struct.var_2bc31bc8 = 5;
            n_progress = 5;
        }
        e_player.challenge_struct function_cc0783e4(n_progress, 5);
        if (e_player == e_player.challenge_struct.var_9ab76d44) {
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", n_progress, e_player);
        }
        if (isdefined(e_player.challenge_struct.var_2cdba90)) {
            foreach (var_9eb7bdb9 in e_player.challenge_struct.var_2cdba90) {
                level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", n_progress, var_9eb7bdb9);
            }
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", n_progress, e_player.challenge_struct.var_9ab76d44);
        }
    } else {
        return;
    }
    if (n_progress >= 5) {
        e_player.challenge_struct notify(#"hash_31d79470abcf1282");
    }
}

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 3, eflags: 0x0
// Checksum 0x2021392e, Offset: 0x5690
// Size: 0x324
function function_ad9d17f9(e_player, e_trig, var_7dd3fff9) {
    e_player endon(#"disconnect");
    e_trig.hint_string = #"hash_4071eaa9981c7b75";
    e_trig sethintstring(e_trig.hint_string, 3);
    if (!isdefined(self.var_25caaad8)) {
        self.var_25caaad8 = 0;
    }
    if (e_player == self.var_9ab76d44) {
        level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", 0, e_player);
        level zm_ui_inventory::function_31a39683(#"zm_towers_challenges", 8, e_player);
    }
    if (isdefined(self.var_2cdba90)) {
        foreach (var_9eb7bdb9 in e_player.challenge_struct.var_2cdba90) {
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", 0, var_9eb7bdb9);
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges", 8, var_9eb7bdb9);
        }
    }
    /#
        self.var_66447cf1 = 3;
        self.var_401b6c18 = "<dev string:x116>";
    #/
    self waittill(#"hash_5b6a8d05204c98e1");
    if (e_player == self.var_9ab76d44) {
        level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", 3, e_player);
    }
    if (isdefined(self.var_2cdba90)) {
        foreach (var_9eb7bdb9 in e_player.challenge_struct.var_2cdba90) {
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", 3, var_9eb7bdb9);
        }
    }
    playsoundatposition(#"zmb_challenges_complete", (0, 0, 0));
    self.var_25caaad8 = undefined;
    e_trig function_79e4e667(e_player, 3);
    self flag::clear(#"hash_5a7dfe069f4cbcec");
}

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 1, eflags: 0x0
// Checksum 0x62bc67eb, Offset: 0x59c0
// Size: 0x2b0
function function_b859ac3d(e_attacker) {
    if (!isplayer(e_attacker)) {
        return;
    }
    e_player = e_attacker;
    if (!isdefined(e_player.challenge_struct) || !isdefined(e_player.challenge_struct.var_25caaad8)) {
        return;
    }
    n_progress = 0;
    if (isdefined(self.var_9063ed50) && !(isdefined(self.var_9063ed50.var_65e1f45d) && self.var_9063ed50.var_65e1f45d) && self.var_9063ed50.archetype === "catalyst") {
        self.var_9063ed50.var_65e1f45d = 1;
        e_player.challenge_struct.var_25caaad8++;
        n_progress = e_player.challenge_struct.var_25caaad8;
        if (n_progress >= 3) {
            e_player.challenge_struct.var_25caaad8 = 3;
            n_progress = 3;
        }
        e_player.challenge_struct function_cc0783e4(n_progress, 3);
        if (e_player == e_player.challenge_struct.var_9ab76d44) {
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", n_progress, e_player);
        }
        if (isdefined(e_player.challenge_struct.var_2cdba90)) {
            foreach (var_9eb7bdb9 in e_player.challenge_struct.var_2cdba90) {
                level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", n_progress, var_9eb7bdb9);
            }
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", n_progress, e_player.challenge_struct.var_9ab76d44);
        }
    } else {
        return;
    }
    if (n_progress >= 3) {
        e_attacker.challenge_struct notify(#"hash_5b6a8d05204c98e1");
    }
}

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 3, eflags: 0x0
// Checksum 0x1c343f96, Offset: 0x5c78
// Size: 0x33c
function function_44c3b7f9(e_player, e_trig, var_7dd3fff9) {
    e_player endon(#"disconnect");
    e_trig.hint_string = #"hash_d1a6fe737f0b6e6";
    e_trig sethintstring(e_trig.hint_string, 1);
    if (!isdefined(self.var_e4cf34ba)) {
        self.var_e4cf34ba = 0;
    }
    if (e_player == self.var_9ab76d44) {
        level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", 0, e_player);
        level zm_ui_inventory::function_31a39683(#"zm_towers_challenges", 9, e_player);
    }
    if (isdefined(self.var_2cdba90)) {
        foreach (var_9eb7bdb9 in e_player.challenge_struct.var_2cdba90) {
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", 0, var_9eb7bdb9);
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges", 9, var_9eb7bdb9);
        }
    }
    /#
        self.var_66447cf1 = 1;
        self.var_401b6c18 = "<dev string:x13a>";
    #/
    self thread function_7eab5a3c(e_player);
    self waittill(#"temple_challenge_completed");
    if (e_player == self.var_9ab76d44) {
        level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", 1, e_player);
    }
    if (isdefined(self.var_2cdba90)) {
        foreach (var_9eb7bdb9 in e_player.challenge_struct.var_2cdba90) {
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", 1, var_9eb7bdb9);
        }
    }
    playsoundatposition(#"zmb_challenges_complete", (0, 0, 0));
    self.var_e4cf34ba = undefined;
    e_trig function_79e4e667(e_player, 1);
    self flag::clear(#"hash_5a7dfe069f4cbcec");
}

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 1, eflags: 0x0
// Checksum 0xb1a7d13, Offset: 0x5fc0
// Size: 0x24e
function function_7eab5a3c(e_player) {
    self endon(#"temple_challenge_completed");
    e_player endon(#"disconnect");
    var_5b469765 = array("zone_pap_room", "zone_pap_room_balcony_flooded_crypt");
    while (true) {
        level waittill(#"start_of_round");
        str_zone = e_player zm_zonemgr::get_player_zone();
        if (!isinarray(var_5b469765, str_zone)) {
            continue;
        }
        e_player thread function_f9f8d27a(self);
        e_player thread function_cf1f4862(self);
        var_3551d88 = e_player waittill(#"death", #"hash_7df55853368e6305", #"left_temple");
        if (var_3551d88._notify == #"hash_7df55853368e6305") {
            break;
        }
    }
    self function_cc0783e4(1, 1);
    level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", 1, e_player);
    var_c5c0ee54 = self.var_2cdba90;
    if (isdefined(var_c5c0ee54)) {
        foreach (e_helper in var_c5c0ee54) {
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", 1, e_helper);
        }
    }
    self notify(#"temple_challenge_completed");
}

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 1, eflags: 0x0
// Checksum 0x6a92cfff, Offset: 0x6218
// Size: 0xce
function function_f9f8d27a(var_6df87cd2) {
    self endon(#"death", #"hash_7df55853368e6305");
    var_6df87cd2 endon(#"temple_challenge_completed");
    var_5b469765 = array("zone_pap_room", "zone_pap_room_balcony_flooded_crypt");
    while (true) {
        str_zone = self zm_zonemgr::get_player_zone();
        if (!isinarray(var_5b469765, str_zone)) {
            break;
        }
        waitframe(1);
    }
    self notify(#"left_temple");
}

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 1, eflags: 0x0
// Checksum 0xf147e469, Offset: 0x62f0
// Size: 0x6e
function function_cf1f4862(var_6df87cd2) {
    self endon(#"death", #"left_temple");
    var_6df87cd2 endon(#"temple_challenge_completed");
    level waittill(#"end_of_round");
    self notify(#"hash_7df55853368e6305");
}

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 3, eflags: 0x0
// Checksum 0xb7c256d5, Offset: 0x6368
// Size: 0x35c
function function_5fcac81d(e_player, e_trig, var_7dd3fff9) {
    e_player endon(#"disconnect");
    e_trig.hint_string = #"hash_1e2e0e1f2879db9f";
    e_trig sethintstring(e_trig.hint_string, 120);
    if (!isdefined(self.var_aace34b5)) {
        self.var_aace34b5 = 0;
    }
    if (e_player == self.var_9ab76d44) {
        level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", 0, e_player);
        level zm_ui_inventory::function_31a39683(#"zm_towers_challenges", 10, e_player);
    }
    if (isdefined(self.var_2cdba90)) {
        foreach (var_9eb7bdb9 in e_player.challenge_struct.var_2cdba90) {
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", 0, var_9eb7bdb9);
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges", 10, var_9eb7bdb9);
        }
    }
    n_required = int(2);
    /#
        self.var_66447cf1 = n_required;
        self.var_401b6c18 = "<dev string:x155>";
    #/
    e_player thread function_aa21599();
    e_player waittill(#"hash_60b65dbde4aab0c8");
    if (e_player == self.var_9ab76d44) {
        level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", n_required, e_player);
    }
    if (isdefined(self.var_2cdba90)) {
        foreach (var_9eb7bdb9 in e_player.challenge_struct.var_2cdba90) {
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", n_required, var_9eb7bdb9);
        }
    }
    playsoundatposition(#"zmb_challenges_complete", (0, 0, 0));
    e_player.var_aace34b5 = undefined;
    e_trig function_79e4e667(e_player, 120);
    self flag::clear(#"hash_5a7dfe069f4cbcec");
}

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 0, eflags: 0x0
// Checksum 0xc286a591, Offset: 0x66d0
// Size: 0x470
function function_aa21599() {
    self endon(#"disconnect", #"hash_60b65dbde4aab0c8");
    e_player = self;
    if (!isplayer(e_player)) {
        return;
    }
    if (!isdefined(e_player.challenge_struct) || !isdefined(e_player.challenge_struct.var_aace34b5)) {
        return;
    }
    n_progress = 0;
    while (e_player.challenge_struct.var_aace34b5 < 120) {
        n_amount = e_player.var_7229b2ab.var_1cfaf808;
        if (e_player zm_towers_crowd::function_c5e4b9a6()) {
            e_player.challenge_struct.var_aace34b5++;
            n_progress = e_player.challenge_struct.var_aace34b5;
            if (n_progress >= 120) {
                e_player.challenge_struct.var_aace34b5 = 120;
                n_progress = 120;
            }
            e_player.challenge_struct function_cc0783e4(n_progress, 120);
        } else {
            e_player.challenge_struct.var_aace34b5 = 0;
            n_progress = 0;
            if (e_player == e_player.challenge_struct.var_9ab76d44) {
                e_player.challenge_struct function_7e6325fe();
            }
        }
        var_af0703 = floor(n_progress / 60);
        var_af0703 = int(var_af0703);
        level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", var_af0703, e_player);
        wait 1;
    }
    if (e_player == e_player.challenge_struct.var_9ab76d44) {
        var_af0703 = floor(n_progress / 60);
        var_af0703 = int(var_af0703);
        level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", var_af0703, e_player);
        if (isdefined(e_player.challenge_struct.var_2cdba90)) {
            foreach (var_9eb7bdb9 in e_player.challenge_struct.var_2cdba90) {
                level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", var_af0703, var_9eb7bdb9);
            }
        }
    } else if (isdefined(e_player.challenge_struct.var_2cdba90)) {
        var_af0703 = floor(e_player.challenge_struct.var_aace34b5 / 60);
        var_af0703 = int(var_af0703);
        foreach (var_9eb7bdb9 in e_player.challenge_struct.var_2cdba90) {
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", var_af0703, var_9eb7bdb9);
        }
        level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", var_af0703, e_player.challenge_struct.var_9ab76d44);
    }
    e_player notify(#"hash_60b65dbde4aab0c8");
}

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 3, eflags: 0x0
// Checksum 0x6475e37a, Offset: 0x6b48
// Size: 0x324
function function_b28de37f(e_player, e_trig, var_7dd3fff9) {
    e_player endon(#"disconnect");
    e_trig.hint_string = #"hash_2cf00f3e51c59d63";
    e_trig sethintstring(e_trig.hint_string, 9);
    if (!isdefined(self.var_b69135f8)) {
        self.var_9504c513 = 0;
    }
    if (e_player == self.var_9ab76d44) {
        level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", 0, e_player);
        level zm_ui_inventory::function_31a39683(#"zm_towers_challenges", 11, e_player);
    }
    if (isdefined(self.var_2cdba90)) {
        foreach (var_9eb7bdb9 in e_player.challenge_struct.var_2cdba90) {
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", 0, var_9eb7bdb9);
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges", 11, var_9eb7bdb9);
        }
    }
    /#
        self.var_66447cf1 = 9;
        self.var_401b6c18 = "<dev string:x171>";
    #/
    self waittill(#"shield_challenge_completed");
    if (e_player == self.var_9ab76d44) {
        level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", 9, e_player);
    }
    if (isdefined(self.var_2cdba90)) {
        foreach (var_9eb7bdb9 in e_player.challenge_struct.var_2cdba90) {
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", 9, var_9eb7bdb9);
        }
    }
    playsoundatposition(#"zmb_challenges_complete", (0, 0, 0));
    self.var_9504c513 = undefined;
    e_trig function_79e4e667(e_player, 9);
    self flag::clear(#"hash_5a7dfe069f4cbcec");
}

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 1, eflags: 0x0
// Checksum 0x978447a8, Offset: 0x6e78
// Size: 0x258
function function_a3e66a17(e_attacker) {
    if (!isplayer(e_attacker)) {
        return;
    }
    e_player = e_attacker;
    if (!isdefined(e_player.challenge_struct) || !isdefined(e_player.challenge_struct.var_9504c513)) {
        return;
    }
    n_progress = 0;
    if (isdefined(self)) {
        if (function_bada7b90(self.damageweapon)) {
            e_player.challenge_struct.var_9504c513++;
            n_progress = e_player.challenge_struct.var_9504c513;
            if (n_progress >= 9) {
                n_progress = 9;
            }
            e_player.challenge_struct function_cc0783e4(n_progress, 9);
            if (e_player == e_player.challenge_struct.var_9ab76d44) {
                level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", n_progress, e_player);
            }
            if (isdefined(e_player.challenge_struct.var_2cdba90)) {
                foreach (var_9eb7bdb9 in e_player.challenge_struct.var_2cdba90) {
                    level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", n_progress, var_9eb7bdb9);
                }
                level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", n_progress, e_player.challenge_struct.var_9ab76d44);
            }
        } else {
            return;
        }
        if (n_progress >= 9) {
            e_attacker.challenge_struct notify(#"shield_challenge_completed");
        }
    }
}

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 1, eflags: 0x0
// Checksum 0xb0231436, Offset: 0x70d8
// Size: 0x72
function function_bada7b90(weapon_type) {
    switch (weapon_type.name) {
    case #"zhield_zword_dw":
        return 1;
    case #"zhield_zword_turret":
        return 1;
    default:
        return 0;
    }
}

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 3, eflags: 0x0
// Checksum 0xe9cfd244, Offset: 0x7158
// Size: 0x324
function function_a54df27d(e_player, e_trig, var_7dd3fff9) {
    e_player endon(#"disconnect");
    e_trig.hint_string = #"hash_5d5686795cc21d24";
    e_trig sethintstring(e_trig.hint_string, 9);
    if (!isdefined(self.var_b31baa73)) {
        self.var_b31baa73 = 0;
    }
    if (e_player == self.var_9ab76d44) {
        level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", 0, e_player);
        level zm_ui_inventory::function_31a39683(#"zm_towers_challenges", 12, e_player);
    }
    if (isdefined(self.var_2cdba90)) {
        foreach (var_9eb7bdb9 in e_player.challenge_struct.var_2cdba90) {
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", 0, var_9eb7bdb9);
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges", 12, var_9eb7bdb9);
        }
    }
    /#
        self.var_66447cf1 = 9;
        self.var_401b6c18 = "<dev string:x18c>";
    #/
    self waittill(#"hash_47170980360105a8");
    if (e_player == self.var_9ab76d44) {
        level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", 9, e_player);
    }
    if (isdefined(self.var_2cdba90)) {
        foreach (var_9eb7bdb9 in e_player.challenge_struct.var_2cdba90) {
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", 9, var_9eb7bdb9);
        }
    }
    playsoundatposition(#"zmb_challenges_complete", (0, 0, 0));
    self.var_b31baa73 = undefined;
    e_trig function_79e4e667(e_player, 9);
    self flag::clear(#"hash_5a7dfe069f4cbcec");
}

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 1, eflags: 0x0
// Checksum 0x8e0b81fe, Offset: 0x7488
// Size: 0x260
function function_1b84dba9(e_attacker) {
    if (!isplayer(e_attacker)) {
        return;
    }
    e_player = e_attacker;
    if (!isdefined(e_player.challenge_struct) || !isdefined(e_player.challenge_struct.var_b31baa73)) {
        return;
    }
    n_progress = 0;
    if (self.var_29ed62b2 == #"heavy") {
        e_player.challenge_struct.var_b31baa73++;
        n_progress = e_player.challenge_struct.var_b31baa73;
        if (n_progress >= 9) {
            e_player.challenge_struct.var_b31baa73 = 9;
            n_progress = 9;
        }
        e_player.challenge_struct function_cc0783e4(n_progress, 9);
        if (e_player == e_player.challenge_struct.var_9ab76d44) {
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", n_progress, e_player);
        }
        if (isdefined(e_player.challenge_struct.var_2cdba90)) {
            foreach (var_9eb7bdb9 in e_player.challenge_struct.var_2cdba90) {
                level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", n_progress, var_9eb7bdb9);
            }
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", n_progress, e_player.challenge_struct.var_9ab76d44);
        }
    } else {
        return;
    }
    if (n_progress >= 9) {
        e_player.challenge_struct notify(#"hash_47170980360105a8");
    }
}

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 3, eflags: 0x0
// Checksum 0x2fea0509, Offset: 0x76f0
// Size: 0x324
function function_d198447e(e_player, e_trig, var_7dd3fff9) {
    e_player endon(#"disconnect");
    e_trig.hint_string = #"hash_36019120b3e88151";
    e_trig sethintstring(e_trig.hint_string, 9);
    if (!isdefined(self.var_b7f7c55e)) {
        self.var_b7f7c55e = 0;
    }
    if (e_player == self.var_9ab76d44) {
        level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", 0, e_player);
        level zm_ui_inventory::function_31a39683(#"zm_towers_challenges", 13, e_player);
    }
    if (isdefined(self.var_2cdba90)) {
        foreach (var_9eb7bdb9 in e_player.challenge_struct.var_2cdba90) {
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", 0, var_9eb7bdb9);
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges", 13, var_9eb7bdb9);
        }
    }
    /#
        self.var_66447cf1 = 9;
        self.var_401b6c18 = "<dev string:x1b0>";
    #/
    self waittill(#"hash_b7f3e44410f5062");
    if (e_player == self.var_9ab76d44) {
        level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", 9, e_player);
    }
    if (isdefined(self.var_2cdba90)) {
        foreach (var_9eb7bdb9 in e_player.challenge_struct.var_2cdba90) {
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", 9, var_9eb7bdb9);
        }
    }
    playsoundatposition(#"zmb_challenges_complete", (0, 0, 0));
    self.var_b7f7c55e = undefined;
    e_trig function_79e4e667(e_player, 9);
    self flag::clear(#"hash_5a7dfe069f4cbcec");
}

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 1, eflags: 0x0
// Checksum 0x85c48523, Offset: 0x7a20
// Size: 0x2a8
function function_e8b8b93a(params) {
    if (!isplayer(params.eattacker)) {
        return;
    }
    e_player = params.eattacker;
    if (!isdefined(e_player.challenge_struct) || !isdefined(e_player.challenge_struct.var_b7f7c55e)) {
        return;
    }
    if (zm_weap_crossbow::is_crossbow(params.weapon)) {
        if (!isdefined(params.einflictor.var_d8f81c98)) {
            params.einflictor.var_d8f81c98 = 0;
        }
        params.einflictor.var_d8f81c98++;
        if (params.einflictor.var_d8f81c98 >= 9) {
            e_player.challenge_struct.var_b7f7c55e = 9;
            e_player.challenge_struct function_cc0783e4(e_player.challenge_struct.var_b7f7c55e, 9);
            if (e_player == e_player.challenge_struct.var_9ab76d44) {
                level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", e_player.challenge_struct.var_b7f7c55e, e_player);
            }
            if (isdefined(e_player.challenge_struct.var_2cdba90)) {
                foreach (var_9eb7bdb9 in e_player.challenge_struct.var_2cdba90) {
                    level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", e_player.challenge_struct.var_b7f7c55e, var_9eb7bdb9);
                }
                level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", e_player.challenge_struct.var_b7f7c55e, e_player.challenge_struct.var_9ab76d44);
            }
            e_player.challenge_struct notify(#"hash_b7f3e44410f5062");
        }
    }
}

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 3, eflags: 0x0
// Checksum 0x2999594d, Offset: 0x7cd0
// Size: 0x334
function function_69f24e57(e_player, e_trig, var_7dd3fff9) {
    e_player endon(#"disconnect");
    e_trig.hint_string = #"hash_1eafdb1b0b12fa11";
    e_trig sethintstring(e_trig.hint_string, 1);
    if (!isdefined(self.var_92e71741)) {
        self.var_92e71741 = 0;
    }
    if (e_player == self.var_9ab76d44) {
        level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", 0, e_player);
        level zm_ui_inventory::function_31a39683(#"zm_towers_challenges", 14, e_player);
    }
    if (isdefined(self.var_2cdba90)) {
        foreach (var_9eb7bdb9 in e_player.challenge_struct.var_2cdba90) {
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", 0, var_9eb7bdb9);
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges", 14, var_9eb7bdb9);
        }
    }
    /#
        self.var_66447cf1 = 1;
        self.var_401b6c18 = "<dev string:x1d7>";
    #/
    e_player thread function_926fbfe0();
    self waittill(#"hash_5d7c0e41aec8535e");
    if (e_player == self.var_9ab76d44) {
        level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", 1, e_player);
    }
    if (isdefined(self.var_2cdba90)) {
        foreach (var_9eb7bdb9 in e_player.challenge_struct.var_2cdba90) {
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", 1, var_9eb7bdb9);
        }
    }
    playsoundatposition(#"zmb_challenges_complete", (0, 0, 0));
    self.var_92e71741 = undefined;
    e_trig function_79e4e667(e_player, 1);
    self flag::clear(#"hash_5a7dfe069f4cbcec");
}

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 0, eflags: 0x0
// Checksum 0x1debaee9, Offset: 0x8010
// Size: 0x340
function function_926fbfe0() {
    self endon(#"disconnect", #"hash_5d7c0e41aec8535e");
    e_player = self;
    if (!isdefined(e_player.challenge_struct) || !isdefined(e_player.challenge_struct.var_92e71741)) {
        return;
    }
    n_progress = 0;
    while (e_player.challenge_struct.var_92e71741 < 1) {
        waitresult = e_player waittill(#"hash_46064b6c2cb5cf20");
        if (waitresult.blight_father.attacker === e_player) {
            if (isalive(waitresult.blight_father)) {
                var_116af9cb = waitresult.blight_father waittilltimeout(0.75, #"death");
                if (var_116af9cb._notify == #"timeout") {
                    continue;
                } else if (waitresult.blight_father.attacker === e_player) {
                    e_player.challenge_struct.var_92e71741++;
                }
            } else {
                e_player.challenge_struct.var_92e71741++;
            }
        }
        n_progress = e_player.challenge_struct.var_92e71741;
        if (n_progress >= 1) {
            e_player.challenge_struct.var_92e71741 = 1;
            n_progress = 1;
        }
        e_player.challenge_struct function_cc0783e4(n_progress, 1);
        if (e_player == e_player.challenge_struct.var_9ab76d44) {
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", n_progress, e_player);
        }
        if (isdefined(e_player.challenge_struct.var_2cdba90)) {
            foreach (var_9eb7bdb9 in e_player.challenge_struct.var_2cdba90) {
                level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", n_progress, var_9eb7bdb9);
            }
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", n_progress, e_player.challenge_struct.var_9ab76d44);
        }
    }
    if (n_progress >= 1) {
        e_player.challenge_struct notify(#"hash_5d7c0e41aec8535e");
    }
}

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 3, eflags: 0x0
// Checksum 0xc19d7aa4, Offset: 0x8358
// Size: 0x324
function function_6ccae194(e_player, e_trig, var_7dd3fff9) {
    e_player endon(#"disconnect");
    e_trig.hint_string = #"hash_241698a67ac1d9d0";
    e_trig sethintstring(e_trig.hint_string, 1);
    if (!isdefined(self.var_bd41ea14)) {
        self.var_bd41ea14 = 0;
    }
    if (e_player == self.var_9ab76d44) {
        level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", 0, e_player);
        level zm_ui_inventory::function_31a39683(#"zm_towers_challenges", 15, e_player);
    }
    if (isdefined(self.var_2cdba90)) {
        foreach (var_9eb7bdb9 in e_player.challenge_struct.var_2cdba90) {
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", 0, var_9eb7bdb9);
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges", 15, var_9eb7bdb9);
        }
    }
    /#
        self.var_66447cf1 = 1;
        self.var_401b6c18 = "<dev string:x205>";
    #/
    self waittill(#"hash_93d348ce67aaf63");
    if (e_player == self.var_9ab76d44) {
        level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", 1, e_player);
    }
    if (isdefined(self.var_2cdba90)) {
        foreach (var_9eb7bdb9 in e_player.challenge_struct.var_2cdba90) {
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", 1, var_9eb7bdb9);
        }
    }
    playsoundatposition(#"zmb_challenges_complete", (0, 0, 0));
    self.var_bd41ea14 = undefined;
    e_trig function_79e4e667(e_player, 1);
    self flag::clear(#"hash_5a7dfe069f4cbcec");
}

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 1, eflags: 0x0
// Checksum 0x81fa0e0c, Offset: 0x8688
// Size: 0x260
function function_65ed6734(e_attacker) {
    if (!isplayer(e_attacker)) {
        return;
    }
    e_player = e_attacker;
    if (!isdefined(e_player.challenge_struct) || !isdefined(e_player.challenge_struct.var_bd41ea14)) {
        return;
    }
    n_progress = 0;
    if (self.archetype == "blight_father") {
        e_player.challenge_struct.var_bd41ea14++;
        n_progress = e_player.challenge_struct.var_bd41ea14;
        if (e_player.challenge_struct.var_bd41ea14 >= 1) {
            e_player.challenge_struct.var_bd41ea14 = 1;
            n_progress = 1;
        }
        e_player.challenge_struct function_cc0783e4(n_progress, 1);
        if (e_player == e_player.challenge_struct.var_9ab76d44) {
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", n_progress, e_player);
        }
        if (isdefined(e_player.challenge_struct.var_2cdba90)) {
            foreach (var_9eb7bdb9 in e_player.challenge_struct.var_2cdba90) {
                level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", n_progress, var_9eb7bdb9);
            }
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", n_progress, e_player.challenge_struct.var_9ab76d44);
        }
        if (n_progress >= 1) {
            e_attacker.challenge_struct notify(#"hash_93d348ce67aaf63");
        }
    }
}

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 3, eflags: 0x0
// Checksum 0x86783630, Offset: 0x88f0
// Size: 0x34c
function function_6c927bf2(e_player, e_trig, var_7dd3fff9) {
    e_player endon(#"disconnect");
    e_trig.hint_string = #"hash_16eb46dabae1c0ae";
    e_trig sethintstring(e_trig.hint_string, 20);
    if (!isdefined(self.var_d06540fa)) {
        self.var_d06540fa = 0;
    }
    if (e_player == self.var_9ab76d44) {
        level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", 0, e_player);
        level zm_ui_inventory::function_31a39683(#"zm_towers_challenges", 16, e_player);
    }
    if (isdefined(self.var_2cdba90)) {
        foreach (var_9eb7bdb9 in e_player.challenge_struct.var_2cdba90) {
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", 0, var_9eb7bdb9);
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges", 16, var_9eb7bdb9);
        }
    }
    /#
        self.var_66447cf1 = 20;
        self.var_401b6c18 = "<dev string:x22c>";
        e_player.var_401b6c18 = self.var_401b6c18;
    #/
    e_player thread function_d65ebf83();
    e_player waittill(#"hash_3c4a9ff92127458d");
    if (e_player == self.var_9ab76d44) {
        level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", 20, e_player);
    }
    if (isdefined(self.var_2cdba90)) {
        foreach (var_9eb7bdb9 in e_player.challenge_struct.var_2cdba90) {
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", 20, var_9eb7bdb9);
        }
    }
    playsoundatposition(#"zmb_challenges_complete", (0, 0, 0));
    self.var_d06540fa = undefined;
    e_trig function_79e4e667(e_player, 20);
    self flag::clear(#"hash_5a7dfe069f4cbcec");
}

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 1, eflags: 0x0
// Checksum 0x7a2259f8, Offset: 0x8c48
// Size: 0x2b0
function function_b8b46e08(e_attacker) {
    e_attacker endon(#"hash_3c4a9ff92127458d");
    e_player = e_attacker;
    if (!isdefined(e_player.challenge_struct) || !isdefined(e_player.challenge_struct.var_d06540fa)) {
        return;
    }
    n_progress = 0;
    if (e_player.var_2f6b9c05 === 1) {
        e_player.challenge_struct.var_d06540fa++;
        n_progress = e_player.challenge_struct.var_d06540fa;
        if (e_player.challenge_struct.var_d06540fa >= 20) {
            e_player.challenge_struct.var_d06540fa = 20;
            n_progress = 20;
        }
        e_player.challenge_struct function_cc0783e4(n_progress, 20);
    } else if (e_player == e_player.challenge_struct.var_9ab76d44) {
        e_player.challenge_struct.var_d06540fa = 0;
        n_progress = 0;
        e_player.challenge_struct function_7e6325fe();
    }
    if (e_player == e_player.challenge_struct.var_9ab76d44) {
        level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", n_progress, e_player);
    }
    if (isdefined(e_player.challenge_struct.var_2cdba90)) {
        foreach (var_9eb7bdb9 in e_player.challenge_struct.var_2cdba90) {
            level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", n_progress, var_9eb7bdb9);
        }
        level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", n_progress, e_player.challenge_struct.var_9ab76d44);
    }
    if (n_progress >= 20) {
        e_player notify(#"hash_3c4a9ff92127458d");
    }
}

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 0, eflags: 0x0
// Checksum 0xc28678b9, Offset: 0x8f00
// Size: 0x2c8
function function_d65ebf83() {
    self endon(#"disconnect", #"hash_3c4a9ff92127458d");
    if (!isplayer(self)) {
        return;
    }
    if (!isdefined(self.challenge_struct) || !isdefined(self.challenge_struct.var_d06540fa)) {
        return;
    }
    self.var_2f6b9c05 = 0;
    var_be4e449e = getent("e_challenge_center_stage", "targetname");
    while (self.challenge_struct.var_d06540fa < 20) {
        if (self == self.challenge_struct.var_9ab76d44) {
            if (self istouching(var_be4e449e)) {
                self.var_2f6b9c05 = 1;
            } else {
                self.var_2f6b9c05 = 0;
                self.challenge_struct.var_d06540fa = 0;
                self.challenge_struct function_7e6325fe();
                level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", self.challenge_struct.var_d06540fa, self);
                if (isdefined(self.challenge_struct.var_2cdba90)) {
                    foreach (var_9eb7bdb9 in self.challenge_struct.var_2cdba90) {
                        level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", self.challenge_struct.var_d06540fa, var_9eb7bdb9);
                    }
                }
            }
        }
        if (isdefined(self.challenge_struct.var_2cdba90)) {
            foreach (var_9eb7bdb9 in self.challenge_struct.var_2cdba90) {
                if (var_9eb7bdb9 istouching(var_be4e449e)) {
                    var_9eb7bdb9.var_2f6b9c05 = 1;
                    continue;
                }
                var_9eb7bdb9.var_2f6b9c05 = 0;
            }
        }
        wait 0.5;
    }
}

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 2, eflags: 0x0
// Checksum 0x25c84983, Offset: 0x91d0
// Size: 0x5ac
function function_b43ac97c(var_8e7ce497, var_c70474ee) {
    var_8e7ce497.challenge_struct = struct::get(var_8e7ce497.target);
    var_8e7ce497.challenge_struct.var_e1b84d95 = var_8e7ce497.challenge_struct.origin;
    var_c70474ee sethintstring(#"hash_685d7c68f4c511a7");
    while (true) {
        s_info = var_8e7ce497 waittill(#"trigger");
        e_player = s_info.activator;
        if (isplayer(e_player)) {
            break;
        }
    }
    e_player.challenge_struct = var_8e7ce497.challenge_struct;
    e_player.challenge_struct.var_9ab76d44 = e_player;
    e_player.challenge_struct.var_30cd92e9 = getent(var_8e7ce497.challenge_struct.target, "targetname");
    e_player.challenge_struct.var_30cd92e9 flag::init(#"hash_19856658ee6e4f3a");
    foreach (player in getplayers()) {
        if (player != e_player) {
            var_c70474ee sethintstringforplayer(player, #"hash_1705b54e6528bc52");
            e_player.challenge_struct.var_30cd92e9 setinvisibletoplayer(player);
            continue;
        }
        var_c70474ee sethintstringforplayer(e_player, #"hash_4af8c1464e537f6");
        var_8e7ce497 setinvisibletoall();
    }
    var_fba967ce = getentarray("t_challenge_cleat_hint_trig", "script_noteworthy");
    foreach (trig in var_fba967ce) {
        if (trig != var_c70474ee) {
            trig sethintstringforplayer(e_player, #"hash_3e2be45acfa798cd");
        }
    }
    foreach (var_776c7c11 in level.var_41e21193) {
        if (var_776c7c11 != e_player.challenge_struct.var_30cd92e9) {
            var_776c7c11 setinvisibletoplayer(e_player, 1);
            continue;
        }
        var_776c7c11 setinvisibletoall();
        var_776c7c11 setvisibletoplayer(e_player);
    }
    e_player thread function_e7f8ce70();
    var_8e7ce497 setinvisibletoall();
    var_f20a1a82 = getentarray("t_zm_towers_cleat_damage_trig", "script_noteworthy");
    foreach (var_c6ea27e7 in var_f20a1a82) {
        var_c6ea27e7 setinvisibletoplayer(e_player, 1);
    }
    e_player.challenge_struct.var_30cd92e9 function_4702e540(e_player, var_8e7ce497);
    var_fdd62f0f = var_8e7ce497.target + "_banner";
    e_banner = getent(var_fdd62f0f, "targetname");
    str_color = function_d41d478(e_banner);
    e_banner scene::play("p8_fxanim_zm_towers_banner_achievement_" + str_color + "_bundle");
}

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 0, eflags: 0x0
// Checksum 0xb857663f, Offset: 0x9788
// Size: 0x44
function function_e7f8ce70() {
    self endon(#"disconnect");
    level waittill(#"end_game");
    self function_3b7f1c73();
}

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 2, eflags: 0x0
// Checksum 0x2991ef6a, Offset: 0x97d8
// Size: 0x34e
function function_79e4e667(e_player, n_required_goal) {
    e_player endon(#"disconnect", #"hash_4ac0558a94ba3fd7");
    self endon(#"hash_4ac0558a94ba3fd7", #"hash_6f7fd591a005844d");
    e_player flag::clear(#"hash_6534297bbe7e180d");
    if (isdefined(e_player.challenge_struct.var_2cdba90)) {
        foreach (var_9eb7bdb9 in e_player.challenge_struct.var_2cdba90) {
            var_9eb7bdb9 flag::clear(#"hash_6534297bbe7e180d");
        }
    }
    self.var_4333ee02 = 0;
    self sethintstring(#"hash_710531ce6bfa48c8");
    if (e_player == e_player.challenge_struct.var_9ab76d44) {
        var_d3381740 = e_player.challenge_struct function_1d22626(e_player, self);
    }
    while (!e_player flag::get(#"hash_6534297bbe7e180d")) {
        e_player thread function_eddbbe40(var_d3381740);
        s_info = self waittill(#"trigger");
        if (s_info.activator != e_player.challenge_struct.var_9ab76d44) {
            if (isdefined(e_player.challenge_struct.var_2cdba90)) {
                self sethintstringforplayer(s_info.activator, #"hash_5501784aa04e0df2");
            }
            continue;
        }
        if (!zm_utility::can_use(e_player.challenge_struct.var_9ab76d44, self.var_4333ee02)) {
            self.banner.var_88d6c87 thread function_64975719(self, e_player);
            continue;
        }
        if (e_player flag::get(#"flag_player_initialized_reward")) {
            e_player player_give_reward(self);
            if (isdefined(e_player.challenge_struct.mdl_reward)) {
                e_player.challenge_struct.mdl_reward delete();
            }
        }
    }
    self notify(#"hash_6f7fd591a005844d");
}

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 1, eflags: 0x0
// Checksum 0x6cf159d1, Offset: 0x9b30
// Size: 0x306
function function_eddbbe40(var_d3381740) {
    self endon(#"hash_6e1565b413e5e0f4", #"disconnect");
    if (self flag::get(#"flag_player_completed_all_challenges")) {
        return;
    }
    self.var_333206d8 = 0;
    while (true) {
        self.var_333206d8 = 0;
        if (isdefined(var_d3381740) && self util::is_looking_at(var_d3381740)) {
            self.var_333206d8 = 1;
        }
        if (self meleebuttonpressed() && self.var_333206d8 && self istouching(self.challenge_struct.var_30cd92e9) && !self flag::get(#"flag_player_completed_all_challenges")) {
            self notify(#"hash_4ac0558a94ba3fd7");
            self.challenge_struct notify(#"hash_4ac0558a94ba3fd7");
            self.challenge_struct notify(#"hash_4ac0558a94ba3fd7");
            if (isdefined(self.challenge_struct.mdl_reward)) {
                self.challenge_struct.mdl_reward delete();
            }
            self function_3b7f1c73();
            self.challenge_struct function_7e6325fe(1);
            self.challenge_struct.var_30cd92e9 sethintstring("");
            self flag::set(#"hash_6534297bbe7e180d");
            if (isdefined(self.challenge_struct.var_2cdba90)) {
                foreach (var_9eb7bdb9 in self.challenge_struct.var_2cdba90) {
                    var_9eb7bdb9 flag::set(#"hash_6534297bbe7e180d");
                }
            }
            self flag::clear(#"flag_player_initialized_reward");
            self.var_c981566c = undefined;
            self.challenge_struct.var_d8619fa0++;
            break;
        }
        waitframe(1);
    }
}

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 2, eflags: 0x0
// Checksum 0x8e20efcb, Offset: 0x9e40
// Size: 0x110
function function_64975719(e_trig, e_player) {
    self endon(#"death");
    e_player endon(#"disconnect");
    self notify("293f7362ee386f1a");
    self endon("293f7362ee386f1a");
    while (!e_player flag::get(#"hash_6534297bbe7e180d")) {
        if (!zm_utility::can_use(e_player, e_trig.var_4333ee02) && e_player == e_player.challenge_struct.var_9ab76d44) {
            e_trig sethintstringforplayer(e_player, "");
        } else {
            e_trig sethintstringforplayer(e_player, #"hash_710531ce6bfa48c8");
        }
        wait 0.25;
    }
}

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 2, eflags: 0x0
// Checksum 0x84f51eb9, Offset: 0x9f58
// Size: 0x6e2
function function_1d22626(e_player, e_trig) {
    e_player endon(#"disconnect");
    var_7bb343ef = (0, 90, 0);
    var_17b3dc96 = level.var_edd04fc6[self.var_d8619fa0];
    e_player thread function_f9ec785a(#"challenge_completed");
    e_player clientfield::increment_to_player("" + #"hash_2bbcb9e09bd7bb26");
    switch (var_17b3dc96) {
    case #"self_revive":
        self.var_e1513629 = (0, 0, 0);
        self.var_b90d551 = var_7bb343ef;
        self.var_c8b44d6 = #"p8_zm_gla_heart_zombie";
        break;
    case #"full_ammo":
        self.var_e1513629 = (0, 0, 6);
        self.var_b90d551 = var_7bb343ef;
        self.var_c8b44d6 = "p7_zm_power_up_max_ammo";
        break;
    case #"double_points":
        self.var_e1513629 = (0, 0, 6);
        self.var_b90d551 = var_7bb343ef;
        self.var_c8b44d6 = "p7_zm_power_up_double_points";
        break;
    case #"insta_kill":
        self.var_e1513629 = (0, 0, 12);
        self.var_b90d551 = var_7bb343ef;
        self.var_c8b44d6 = "p7_zm_power_up_insta_kill";
        break;
    case #"hero_weapon_power":
        self.var_e1513629 = (0, 0, 6);
        self.var_b90d551 = var_7bb343ef;
        self.var_c8b44d6 = "p8_zm_powerup_full_power";
        break;
    case #"bonus_points_player":
        self.var_e1513629 = (0, 0, 10);
        self.var_b90d551 = var_7bb343ef;
        self.var_c8b44d6 = "zombie_z_money_icon";
        break;
    case #"ar_mg1909_t8":
        e_trig.var_4333ee02 = 1;
        self.var_e1513629 = (0, 0, 9);
        self.var_b90d551 = var_7bb343ef;
        break;
    case #"lmg_standard_t8":
        e_trig.var_4333ee02 = 1;
        self.var_e1513629 = (0, 0, 9);
        self.var_b90d551 = var_7bb343ef;
        break;
    case #"tr_midburst_t8":
        e_trig.var_4333ee02 = 1;
        self.var_e1513629 = (0, 0, 9);
        self.var_b90d551 = var_7bb343ef;
        break;
    case #"pistol_standard_t8_upgraded":
        e_trig.var_4333ee02 = 1;
        self.var_e1513629 = (0, 0, 7);
        self.var_b90d551 = var_7bb343ef;
        break;
    case #"lmg_spray_t8_upgraded":
        e_trig.var_4333ee02 = 1;
        self.var_e1513629 = (0, 0, 7);
        self.var_b90d551 = var_7bb343ef;
        break;
    case #"free_perk":
        sound = "evt_bottle_dispense";
        playsoundatposition(sound, self.origin);
        var_109ad3e3 = e_player zm_perks::function_8e5fbcc0();
        self.var_109ad3e3 = var_109ad3e3;
        self zm_vapor_random::function_2e1d7869(var_109ad3e3);
        var_1bfa1f7e = anglestoforward(self.angles) * -2;
        self.var_e1513629 = var_1bfa1f7e + (0, 0, 7);
        self.var_b90d551 = var_7bb343ef;
        break;
    }
    var_51a2f105 = self.origin + self.var_e1513629;
    v_spawn_angles = self.angles + self.var_b90d551;
    if (var_17b3dc96 == #"ar_mg1909_t8" || var_17b3dc96 == #"lmg_standard_t8" || var_17b3dc96 == #"tr_midburst_t8" || var_17b3dc96 == #"lmg_spray_t8_upgraded" || var_17b3dc96 == #"pistol_standard_t8_upgraded") {
        self.mdl_reward = zm_utility::spawn_buildkit_weapon_model(e_player, getweapon(var_17b3dc96), undefined, var_51a2f105, v_spawn_angles);
        self.mdl_reward.str_weapon_name = var_17b3dc96;
        self.mdl_reward movez(5, 1);
    } else if (var_17b3dc96 == "free_perk") {
        mdl_temp = zm_perks::get_perk_weapon_model(self.var_109ad3e3);
        self.mdl_reward = level.bottle_spawn_location;
        self.mdl_reward setmodel(mdl_temp);
    } else {
        self.mdl_reward = util::spawn_model(self.var_c8b44d6, var_51a2f105, v_spawn_angles);
        self.mdl_reward movez(5, 1);
        self.mdl_reward clientfield::set("powerup_fx", 1);
    }
    e_player.var_c981566c = 1;
    e_player flag::set(#"flag_player_initialized_reward");
    return self.mdl_reward;
}

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 1, eflags: 0x0
// Checksum 0xe1e3ce59, Offset: 0xa648
// Size: 0x370
function player_give_reward(e_trig) {
    self endon(#"disconnect");
    self notify(#"hash_6e1565b413e5e0f4");
    self.challenge_struct function_7e6325fe(1);
    e_trig sethintstring("");
    var_17b3dc96 = level.var_edd04fc6[self.challenge_struct.var_d8619fa0];
    switch (var_17b3dc96) {
    case #"self_revive":
        self zm_laststand::function_1cc4ccbf();
        break;
    case #"free_perk":
        self flag::set(#"hash_5a74f9da0718c63d");
        self zm_perks::give_perk(self.challenge_struct.var_109ad3e3, 0);
        break;
    case #"hero_weapon_power":
    case #"bonus_points_player":
    case #"full_ammo":
    case #"insta_kill":
    case #"double_points":
        level thread zm_powerups::specific_powerup_drop(var_17b3dc96, self.origin);
        break;
    case #"tr_midburst_t8":
    case #"pistol_standard_t8_upgraded":
    case #"lmg_spray_t8_upgraded":
    case #"ar_mg1909_t8":
    case #"lmg_standard_t8":
        if (isdefined(self.challenge_struct.mdl_reward.str_weapon_name)) {
            w_reward = getweapon(self.challenge_struct.mdl_reward.str_weapon_name);
        }
        self thread swap_weapon(w_reward);
        break;
    }
    self function_3b7f1c73();
    self flag::set(#"hash_6534297bbe7e180d");
    if (isdefined(self.challenge_struct.var_2cdba90)) {
        foreach (var_9eb7bdb9 in self.challenge_struct.var_2cdba90) {
            var_9eb7bdb9 flag::set(#"hash_6534297bbe7e180d");
        }
    }
    self flag::clear(#"flag_player_initialized_reward");
    self.var_c981566c = undefined;
    self.challenge_struct.var_d8619fa0++;
}

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 1, eflags: 0x0
// Checksum 0xa4030127, Offset: 0xa9c0
// Size: 0x124
function swap_weapon(w_reward) {
    var_d1bf50be = self getweaponslist();
    foreach (w_gun in var_d1bf50be) {
        rootweapon = zm_weapons::get_base_weapon(w_gun);
        if (rootweapon == w_reward) {
            self zm_weapons::function_d13d5303(w_gun);
            return;
        }
    }
    if (!self hasweapon(w_reward.rootweapon, 1)) {
        self function_dcfc8bde(w_reward);
        return;
    }
    self zm_weapons::function_d13d5303(w_reward);
}

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 1, eflags: 0x0
// Checksum 0xbf766f3f, Offset: 0xaaf0
// Size: 0x7c
function function_dcfc8bde(w_reward) {
    if (self hasweapon(zm_weapons::get_base_weapon(w_reward), 1)) {
        self zm_weapons::weapon_take(zm_weapons::get_base_weapon(w_reward));
    }
    self zm_weapons::weapon_give(w_reward, 1);
}

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 0, eflags: 0x0
// Checksum 0xe1939617, Offset: 0xab78
// Size: 0x48
function function_1adeaa1c() {
    var_4562cc04 = level.perk_purchase_limit;
    if (self flag::get(#"hash_5a74f9da0718c63d")) {
        var_4562cc04++;
    }
    return var_4562cc04;
}

/#

    // Namespace zm_towers_challenges/zm_towers_challenges
    // Params 0, eflags: 0x0
    // Checksum 0x4b269df1, Offset: 0xabc8
    // Size: 0x160
    function function_7ed63c2a() {
        if (isdefined(self.var_5d16fd23) && self.var_5d16fd23) {
            foreach (e_player in getplayers()) {
                if (isdefined(e_player.challenge_struct)) {
                    if (isdefined(e_player.challenge_struct.var_fb9d9fe9) && e_player.challenge_struct.var_fb9d9fe9) {
                        if (e_player.challenge_struct flag::get(#"hash_5a7dfe069f4cbcec")) {
                            e_player.challenge_struct function_8cced84c(e_player.challenge_struct.var_66447cf1, e_player, e_player.challenge_struct.e_trig.hint_string, e_player.challenge_struct.var_401b6c18);
                        }
                    }
                }
            }
        }
    }

    // Namespace zm_towers_challenges/zm_towers_challenges
    // Params 4, eflags: 0x0
    // Checksum 0x7d2948c4, Offset: 0xad30
    // Size: 0xbc
    function function_8cced84c(var_66447cf1, e_player, str_hint_text, var_dc22facc) {
        level zm_ui_inventory::function_31a39683(#"zm_towers_challenges_progress", var_66447cf1, e_player);
        self function_cc0783e4(var_66447cf1, var_66447cf1);
        if (e_player.challenge_struct.var_401b6c18 == "<dev string:x22c>" || e_player.challenge_struct.var_401b6c18 == "<dev string:x155>") {
            e_player notify(var_dc22facc);
            return;
        }
        self notify(var_dc22facc);
    }

#/
