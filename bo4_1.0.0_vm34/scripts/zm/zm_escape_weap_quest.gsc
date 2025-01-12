#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gestures;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm\weapons\zm_weap_tomahawk;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_net;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_zonemgr;

#namespace zm_escape_weap_quest;

// Namespace zm_escape_weap_quest/zm_escape_weap_quest
// Params 0, eflags: 0x2
// Checksum 0x5fc0e80b, Offset: 0x320
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_escape_weap_quest", &__init__, &__main__, undefined);
}

// Namespace zm_escape_weap_quest/zm_escape_weap_quest
// Params 0, eflags: 0x0
// Checksum 0xed3fef59, Offset: 0x370
// Size: 0x1c4
function __init__() {
    n_bits = getminbitcountfornum(4);
    clientfield::register("scriptmover", "" + #"hash_5ecbfb9042fc7f38", 1, 1, "int");
    clientfield::register("actor", "" + #"hash_588871862d19b97d", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"hash_2be4ce9b84bd3b58", 1, 1, "counter");
    clientfield::register("actor", "" + #"hash_338ecd1287d0623b", 1, 1, "counter");
    clientfield::register("scriptmover", "" + #"tomahawk_pickup_fx", 1, n_bits, "int");
    clientfield::register("scriptmover", "" + #"hash_51657261e835ac7c", 1, n_bits, "int");
    callback::on_start_gametype(&function_ccd294ad);
}

// Namespace zm_escape_weap_quest/zm_escape_weap_quest
// Params 0, eflags: 0x0
// Checksum 0xfd9e0b6c, Offset: 0x540
// Size: 0x35c
function function_ccd294ad() {
    if (!zm_custom::function_5638f689(#"zmequipmentisenabled")) {
        return;
    }
    level flag::init(#"soul_catchers_charged");
    level flag::init(#"tomahawk_pickup_complete");
    level.var_bc12a3e6 = [];
    level.var_2803dca = [];
    level.var_8d29355f = [];
    level.n_soul_catchers_charged = 0;
    level.var_4087d9ec = array("idle", "scan", "shake", "yawn");
    level.no_gib_in_wolf_area = &check_for_zombie_in_wolf_area;
    level.var_f3e287b8 = struct::get_array("wolf_position");
    for (i = 0; i < level.var_f3e287b8.size; i++) {
        level.var_bc12a3e6[i] = level.var_f3e287b8[i];
        level.var_2803dca[i] = getent(level.var_f3e287b8[i].target, "targetname");
        level.var_8d29355f[i] = struct::get(level.var_f3e287b8[i].var_8afe94d);
    }
    for (i = 0; i < level.var_bc12a3e6.size; i++) {
        level.var_bc12a3e6[i].var_98730ffa = 0;
        level.var_bc12a3e6[i].var_4591c029 = 0;
        level.var_bc12a3e6[i].s_scene = level.var_8d29355f[i];
        level.var_bc12a3e6[i] thread soul_catcher_check();
        level.var_bc12a3e6[i] thread soul_catcher_state_manager();
        level.var_bc12a3e6[i] thread wolf_head_removal("tomahawk_door_sign_" + i + 1);
        level.var_2803dca[i] = getent(level.var_bc12a3e6[i].target, "targetname");
    }
    level thread soul_catchers_charged();
    zm::register_zombie_damage_override_callback(&function_abfdee74);
    callback::on_connect(&on_player_connect);
}

// Namespace zm_escape_weap_quest/zm_escape_weap_quest
// Params 0, eflags: 0x0
// Checksum 0xc7815cdc, Offset: 0x8a8
// Size: 0x3c
function __main__() {
    if (zm_custom::function_5638f689(#"zmequipmentisenabled")) {
        level thread tomahawk_pickup();
    }
}

// Namespace zm_escape_weap_quest/zm_escape_weap_quest
// Params 0, eflags: 0x0
// Checksum 0x3640da4c, Offset: 0x8f0
// Size: 0x142
function on_player_connect() {
    self endon(#"disconnect");
    while (true) {
        var_3551d88 = self waittill("new_" + "lethal_grenade");
        w_newweapon = var_3551d88.weapon;
        w_tomahawk = getweapon(#"tomahawk_t8");
        if (w_newweapon == w_tomahawk) {
            if (self flag::exists(#"hash_46915cd7994e2d33")) {
                self flag::set(#"hash_46915cd7994e2d33");
                if (level flag::exists(#"soul_catchers_charged") && !level flag::get(#"soul_catchers_charged")) {
                    level flag::set(#"soul_catchers_charged");
                }
                return;
            }
        }
    }
}

// Namespace zm_escape_weap_quest/zm_escape_weap_quest
// Params 0, eflags: 0x0
// Checksum 0x4159ab38, Offset: 0xa40
// Size: 0xb8
function check_for_zombie_in_wolf_area() {
    if (!isdefined(self)) {
        return false;
    }
    if (self.archetype != "zombie") {
        return false;
    }
    for (i = 0; i < level.var_bc12a3e6.size; i++) {
        if (self istouching(level.var_2803dca[i])) {
            if (!level.var_bc12a3e6[i].is_charged && !level.var_bc12a3e6[i].var_4591c029) {
                return true;
            }
        }
    }
    return false;
}

// Namespace zm_escape_weap_quest/zm_escape_weap_quest
// Params 13, eflags: 0x0
// Checksum 0xe84a0f64, Offset: 0xb00
// Size: 0x2fe
function function_abfdee74(willbekilled, inflictor, attacker, damage, flags, mod, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
    if (self.archetype != "zombie") {
        return;
    }
    if (isplayer(attacker) && (isdefined(willbekilled) && willbekilled || damage >= self.health)) {
        for (i = 0; i < level.var_bc12a3e6.size; i++) {
            if (self istouching(level.var_2803dca[i])) {
                if (!level.var_bc12a3e6[i].is_charged && !(isdefined(level.var_bc12a3e6[i].var_4591c029) && level.var_bc12a3e6[i].var_4591c029) && level.var_bc12a3e6[i].var_98730ffa < 6) {
                    self.ignoreall = 1;
                    self.allowdeath = 0;
                    self.no_gib = 1;
                    self.var_1a08a6be = 1;
                    self.b_ignore_cleanup = 1;
                    self.health = 1;
                    self.animname = "zombie_eaten";
                    self notsolid();
                    self setteam(util::get_enemy_team(self.team));
                    attacker notify(#"hash_2706d6137c04adf4");
                    self.var_2a81c718 = level.var_bc12a3e6[i];
                    self.var_2a81c718.var_4591c029 = 1;
                    if (self.var_2a81c718.var_98730ffa == 0) {
                        self.var_2a81c718 notify(#"first_zombie_killed_in_zone");
                        if (!(isdefined(level.wolf_encounter_vo_played) && level.wolf_encounter_vo_played)) {
                            self.var_2a81c718 thread first_wolf_encounter_vo();
                        }
                    }
                    n_eating_anim = self which_eating_anim();
                    self.var_2a81c718 thread function_b32ecf5(n_eating_anim, self);
                }
            }
        }
    }
}

// Namespace zm_escape_weap_quest/zm_escape_weap_quest
// Params 2, eflags: 0x0
// Checksum 0x229b5cbc, Offset: 0xe08
// Size: 0x5e4
function function_b32ecf5(n_eating_anim, ai_zombie) {
    if (!isdefined(ai_zombie)) {
        return;
    }
    ai_zombie thread function_df784e90();
    var_7c91cf51 = util::spawn_model(#"tag_origin", ai_zombie.origin, ai_zombie.angles);
    ai_zombie linkto(var_7c91cf51);
    if (n_eating_anim == 3) {
        var_dffb8010 = "Look Front";
        var_9d1de1db = "Eat Front";
        var_c3ccb0fc = (0, 180, 0);
    } else if (n_eating_anim == 4) {
        var_dffb8010 = "Look Right";
        var_9d1de1db = "Eat Right";
        var_c3ccb0fc = (0, 0, 0);
    } else {
        var_dffb8010 = "Look Left";
        var_9d1de1db = "Eat Left";
        var_c3ccb0fc = (0, 85, 0);
    }
    var_7c91cf51 scene::play(#"hash_7ab2e0d1b8b97d93", "impact", ai_zombie);
    var_7c91cf51 thread scene::play(#"hash_7ab2e0d1b8b97d93", "rise", ai_zombie);
    var_3786e67d = scene::function_3dd10dad(#"hash_7ab2e0d1b8b97d93", "rise");
    ai_zombie clientfield::set("" + #"hash_588871862d19b97d", 1);
    vec_dir = self.s_scene.origin - var_7c91cf51.origin;
    var_6ea7737a = vectorscale(vec_dir, 0.2);
    v_angles_forward = vectortoangles(vec_dir);
    var_7c91cf51 moveto(var_7c91cf51.origin + var_6ea7737a, var_3786e67d, var_3786e67d);
    if (self.var_98730ffa == 0) {
        self flag::wait_till(#"wolf_intro_anim_complete");
    } else {
        wait var_3786e67d;
    }
    self notify(#"wolf_eating");
    if (self.var_98730ffa < 5) {
        self thread function_25219d1a();
    }
    self.s_scene thread scene::play(var_dffb8010);
    a_scene_ents = self.s_scene.scene_ents;
    foreach (ent in a_scene_ents) {
        if (ent.model === #"c_t8_zmb_mob_wolf_head") {
            var_b69f14da = ent;
            break;
        }
    }
    if (!isdefined(ai_zombie)) {
        self notify(#"finished_eating");
        self.var_4591c029 = 0;
        if (isdefined(var_7c91cf51)) {
            var_7c91cf51 delete();
        }
        return;
    }
    var_7c91cf51 thread scene::play(#"hash_7ab2e0d1b8b97d93", "shrink", ai_zombie);
    var_4f2de4f1 = scene::function_3dd10dad(#"hash_7ab2e0d1b8b97d93", "shrink");
    var_4f2de4f1 /= 2;
    var_7c91cf51 moveto(var_b69f14da gettagorigin("TAG_MOUTH_FX"), var_4f2de4f1, var_4f2de4f1);
    var_7c91cf51 rotateto(v_angles_forward + var_c3ccb0fc, var_3786e67d);
    wait var_4f2de4f1;
    if (isdefined(ai_zombie)) {
        ai_zombie unlink();
        ai_zombie clientfield::set("" + #"hash_588871862d19b97d", 0);
        self.s_scene scene::play(var_9d1de1db, ai_zombie);
    } else {
        self.s_scene scene::play(var_9d1de1db);
    }
    var_b69f14da clientfield::increment("" + #"hash_2be4ce9b84bd3b58");
    self.var_98730ffa++;
    self notify(#"finished_eating");
    self.var_4591c029 = 0;
    if (isdefined(ai_zombie)) {
        ai_zombie delete();
    }
    var_7c91cf51 delete();
}

// Namespace zm_escape_weap_quest/zm_escape_weap_quest
// Params 0, eflags: 0x0
// Checksum 0xe221511c, Offset: 0x13f8
// Size: 0x6c
function function_df784e90() {
    self endon(#"death");
    self waittill(#"zombie_eaten_hide");
    self clientfield::increment("" + #"hash_338ecd1287d0623b");
    self ghost();
}

// Namespace zm_escape_weap_quest/zm_escape_weap_quest
// Params 0, eflags: 0x0
// Checksum 0x1e508b2b, Offset: 0x1470
// Size: 0xf8
function which_eating_anim() {
    soul_catcher = self.var_2a81c718;
    forward_dot = vectordot(anglestoforward(soul_catcher.angles), vectornormalize(self.origin - soul_catcher.origin));
    if (forward_dot > 0.85) {
        return 3;
    }
    right_dot = vectordot(anglestoright(soul_catcher.angles), self.origin - soul_catcher.origin);
    if (right_dot > 0) {
        return 4;
    }
    return 5;
}

// Namespace zm_escape_weap_quest/zm_escape_weap_quest
// Params 0, eflags: 0x0
// Checksum 0xaa197360, Offset: 0x1570
// Size: 0x2a4
function soul_catcher_state_manager() {
    self endon(#"hash_13c5316203561c4f");
    wait 1;
    self flag::init(#"wolf_intro_anim_complete");
    if (self.script_noteworthy == "rune_3") {
        self.var_7b98b639 = getent("rune_3", "targetname");
    } else if (self.script_noteworthy == "rune_2") {
        self.var_7b98b639 = getent("rune_2", "targetname");
    } else if (self.script_noteworthy == "rune_1") {
        self.var_7b98b639 = getent("rune_1", "targetname");
    }
    self waittill(#"first_zombie_killed_in_zone");
    if (isdefined(self.t_hurt)) {
        self.t_hurt show();
    }
    self.var_7b98b639 clientfield::set("" + #"hash_5ecbfb9042fc7f38", 1);
    self.s_scene scene::play("Start");
    self flag::set(#"wolf_intro_anim_complete");
    self waittill(#"finished_eating");
    while (!self.is_charged) {
        self thread function_5f76e240();
        self waittill(#"fully_charged", #"finished_eating");
    }
    self notify(#"hash_1c2dd0a16f7ac134");
    self.var_7b98b639 clientfield::set("" + #"hash_5ecbfb9042fc7f38", 0);
    self.var_7b98b639 setmodel("p8_zm_esc_dream_catcher");
    self.s_scene scene::play("Depart");
}

// Namespace zm_escape_weap_quest/zm_escape_weap_quest
// Params 0, eflags: 0x0
// Checksum 0xf458ba81, Offset: 0x1820
// Size: 0xe2
function function_5f76e240() {
    self notify(#"wolf_idling");
    self endon(#"wolf_eating", #"hash_1c2dd0a16f7ac134", #"wolf_idling");
    while (true) {
        var_68e7aa53 = array::random(level.var_4087d9ec);
        self.s_scene thread scene::play(var_68e7aa53);
        var_410fdabb = scene::function_3dd10dad(self.s_scene.scriptbundlename, var_68e7aa53);
        wait var_410fdabb + randomintrange(4, 10);
    }
}

// Namespace zm_escape_weap_quest/zm_escape_weap_quest
// Params 1, eflags: 0x0
// Checksum 0x527dab6c, Offset: 0x1910
// Size: 0x8c
function wolf_head_removal(wolf_head_model_string) {
    wolf_head_model = getent(wolf_head_model_string, "targetname");
    wolf_head_model setmodel(#"p8_zm_esc_dream_catcher_off");
    self waittill(#"fully_charged");
    wolf_head_model setmodel(#"p8_zm_esc_dream_catcher");
}

// Namespace zm_escape_weap_quest/zm_escape_weap_quest
// Params 0, eflags: 0x0
// Checksum 0xf13894, Offset: 0x19a8
// Size: 0x68
function soul_catchers_charged() {
    while (true) {
        if (level.n_soul_catchers_charged >= level.var_bc12a3e6.size) {
            level flag::set(#"soul_catchers_charged");
            level notify(#"soul_catchers_charged");
            break;
        }
        wait 1;
    }
}

// Namespace zm_escape_weap_quest/zm_escape_weap_quest
// Params 0, eflags: 0x0
// Checksum 0x8912671b, Offset: 0x1a18
// Size: 0xd4
function soul_catcher_check() {
    self endon(#"hash_13c5316203561c4f");
    self.is_charged = 0;
    while (true) {
        if (self.var_98730ffa >= 6) {
            level.n_soul_catchers_charged++;
            self.is_charged = 1;
            self notify(#"fully_charged");
            level thread function_daa39c85();
            break;
        }
        waitframe(1);
    }
    self thread function_7d8a92f5();
    if (level.n_soul_catchers_charged >= level.var_bc12a3e6.size) {
        level flag::set(#"soul_catchers_charged");
    }
}

// Namespace zm_escape_weap_quest/zm_escape_weap_quest
// Params 0, eflags: 0x0
// Checksum 0x699b7f81, Offset: 0x1af8
// Size: 0xe2
function function_25219d1a() {
    if (!zm_utility::is_classic()) {
        return;
    }
    a_players = getplayers();
    a_closest = util::get_array_of_closest(self.origin, a_players);
    for (i = 0; i < a_closest.size; i++) {
        if (!(isdefined(a_closest[i].dontspeak) && a_closest[i].dontspeak)) {
            a_closest[i] thread zm_audio::create_and_play_dialog("wolf_head", "feed");
            break;
        }
    }
}

// Namespace zm_escape_weap_quest/zm_escape_weap_quest
// Params 0, eflags: 0x0
// Checksum 0x205db0ec, Offset: 0x1be8
// Size: 0xfa
function function_7d8a92f5() {
    if (!zm_utility::is_classic()) {
        return;
    }
    wait 3.5;
    a_players = getplayers();
    a_closest = util::get_array_of_closest(self.origin, a_players);
    for (i = 0; i < a_closest.size; i++) {
        if (!(isdefined(a_closest[i].dontspeak) && a_closest[i].dontspeak)) {
            a_closest[i] thread zm_audio::create_and_play_dialog("wolf_head", "comp", level.n_soul_catchers_charged - 1);
            break;
        }
    }
}

// Namespace zm_escape_weap_quest/zm_escape_weap_quest
// Params 0, eflags: 0x0
// Checksum 0xccb2aaed, Offset: 0x1cf0
// Size: 0xd0
function first_wolf_encounter_vo() {
    wait 2;
    a_closest = arraysortclosest(level.players, self.origin);
    for (i = 0; i < a_closest.size; i++) {
        if (!(isdefined(a_closest[i].dontspeak) && a_closest[i].dontspeak)) {
            a_closest[i] thread zm_audio::create_and_play_dialog("wolf_head", "feed_first", undefined, 1);
            level.wolf_encounter_vo_played = 1;
            break;
        }
    }
}

// Namespace zm_escape_weap_quest/zm_escape_weap_quest
// Params 0, eflags: 0x0
// Checksum 0x7adcb374, Offset: 0x1dc8
// Size: 0x2b4
function tomahawk_pickup() {
    level flag::wait_till(#"soul_catchers_charged");
    var_4a4970e8 = struct::get("tom_pil");
    mdl_tomahawk = var_4a4970e8.scene_ents[#"prop 2"];
    mdl_tomahawk waittill(#"hash_72879554ff8d0b60");
    wait 0.5;
    var_fea8800a = struct::get("s_tom_fx", "targetname");
    level.var_6293e8f0 = util::spawn_model("tag_origin", var_fea8800a.origin);
    mdl_tomahawk playloopsound(#"amb_tomahawk_swirl");
    s_pos_trigger = struct::get("t_tom_pos", "targetname");
    if (isdefined(s_pos_trigger)) {
        trigger = spawn("trigger_radius_use", s_pos_trigger.origin, 0, 275, 100);
        trigger.script_noteworthy = "rt_pickup_trigger";
        trigger triggerignoreteam();
        trigger sethintstring(#"hash_1cf1c33d78cb53aa");
        trigger setcursorhint("HINT_NOICON");
    }
    if (isdefined(trigger)) {
        trigger thread tomahawk_pickup_trigger();
        foreach (e_player in getplayers()) {
            e_player thread function_3c231f6();
        }
        callback::on_connect(&function_3c231f6);
    }
    level flag::set(#"tomahawk_pickup_complete");
}

// Namespace zm_escape_weap_quest/zm_escape_weap_quest
// Params 0, eflags: 0x0
// Checksum 0xee9f97dd, Offset: 0x2088
// Size: 0x64
function function_daa39c85() {
    var_da270a8c = struct::get("tom_pil");
    str_shot_name = "Shot " + level.n_soul_catchers_charged + 1;
    var_da270a8c thread scene::play(str_shot_name);
}

// Namespace zm_escape_weap_quest/zm_escape_weap_quest
// Params 0, eflags: 0x0
// Checksum 0xf7440e1f, Offset: 0x20f8
// Size: 0xd6
function tomahawk_pickup_trigger() {
    while (true) {
        s_result = self waittill(#"trigger");
        e_player = s_result.activator;
        if (!e_player hasweapon(getweapon(#"tomahawk_t8")) && !e_player hasweapon(getweapon(#"tomahawk_t8_upgraded"))) {
            self thread function_ebcf29cb(e_player);
            waitframe(1);
        }
    }
}

// Namespace zm_escape_weap_quest/zm_escape_weap_quest
// Params 1, eflags: 0x0
// Checksum 0xa34862e4, Offset: 0x21d8
// Size: 0x3a4
function function_ebcf29cb(e_player) {
    e_player notify(#"obtained_tomahawk");
    e_player endon(#"obtained_tomahawk", #"disconnect");
    var_4a4970e8 = struct::get("tom_pil");
    mdl_tomahawk = var_4a4970e8.scene_ents[#"prop 2"];
    mdl_tomahawk setinvisibletoplayer(e_player);
    self setinvisibletoplayer(e_player);
    e_player zm_utility::disable_player_move_states(1);
    e_player.var_187e198d = e_player._gadgets_player[1];
    if (e_player flag::exists(#"hash_11ab20934759ebc3") && e_player flag::get(#"hash_11ab20934759ebc3")) {
        e_player giveweapon(getweapon(#"tomahawk_t8_upgraded"));
        str_tutorial = #"hash_77bbe7cec9945ff5";
        e_player thread zm_audio::create_and_play_dialog("ax_upgrade", "pickup", undefined, 1);
    } else {
        e_player giveweapon(getweapon(#"tomahawk_t8"));
        str_tutorial = #"hash_a89ec051050c008";
        e_player thread zm_audio::create_and_play_dialog("ax", "pickup", undefined, 1);
    }
    e_player thread function_5815042();
    if (isdefined(e_player.var_56c7266a) && e_player.var_56c7266a) {
        e_player waittill(#"fasttravel_over");
    }
    e_player thread zm_equipment::show_hint_text(str_tutorial);
    if (self.script_noteworthy == "rt_pickup_trigger") {
        e_player.retriever_trigger = self;
    }
    e_player clientfield::set_to_player("tomahawk_in_use", 1);
    e_player notify(#"player_obtained_tomahawk");
    level notify(#"tomahawk_aquired");
    e_player zm_stats::increment_client_stat("prison_tomahawk_acquired", 0);
    if (e_player flag::exists(#"hash_11ab20934759ebc3") && e_player flag::get(#"hash_11ab20934759ebc3")) {
        e_player clientfield::set_to_player("" + #"upgraded_tomahawk_in_use", 1);
    }
    e_player zm_utility::enable_player_move_states();
}

// Namespace zm_escape_weap_quest/zm_escape_weap_quest
// Params 0, eflags: 0x0
// Checksum 0x35f7e38f, Offset: 0x2588
// Size: 0xd4
function function_5815042() {
    self endon(#"disconnect");
    self enableweapons();
    self enableoffhandweapons();
    self freezecontrols(1);
    wait 0.1;
    self gestures::function_42215dfa("gestable_zombie_tomahawk_flourish", undefined, 0);
    wait 1.5;
    if (isdefined(self.var_56c7266a) && self.var_56c7266a) {
        self disableweapons();
        self freezecontrols(0);
    }
}

// Namespace zm_escape_weap_quest/zm_escape_weap_quest
// Params 0, eflags: 0x0
// Checksum 0x3e11b88e, Offset: 0x2668
// Size: 0x43c
function function_3c231f6() {
    self endon(#"disconnect");
    var_302eebd3 = getent("rt_pickup_trigger", "script_noteworthy");
    var_4a4970e8 = struct::get("tom_pil");
    mdl_tomahawk = var_4a4970e8.scene_ents[#"prop 2"];
    while (true) {
        if (isdefined(var_302eebd3)) {
            if (level flag::get(#"soul_catchers_charged") && !self hasweapon(getweapon(#"tomahawk_t8")) && !self hasweapon(getweapon(#"tomahawk_t8_upgraded"))) {
                if (!self flag::exists(#"hash_120fbb364796cd32") && !self flag::exists(#"hash_11ab20934759ebc3") || !self flag::get(#"hash_120fbb364796cd32") || self flag::get(#"hash_11ab20934759ebc3")) {
                    var_302eebd3 setvisibletoplayer(self);
                    mdl_tomahawk setvisibletoplayer(self);
                    var_a879fa43 = self getentitynumber() + 1;
                    level.var_6293e8f0 setvisibletoplayer(self);
                    if (self flag::exists(#"hash_11ab20934759ebc3") && self flag::get(#"hash_11ab20934759ebc3")) {
                        level.var_6293e8f0 clientfield::set("" + #"hash_51657261e835ac7c", var_a879fa43);
                    } else {
                        level.var_6293e8f0 clientfield::set("" + #"tomahawk_pickup_fx", var_a879fa43);
                    }
                } else {
                    var_302eebd3 setinvisibletoplayer(self);
                    mdl_tomahawk setinvisibletoplayer(self);
                    level.var_6293e8f0 clientfield::set("" + #"tomahawk_pickup_fx", 0);
                    level.var_6293e8f0 clientfield::set("" + #"hash_51657261e835ac7c", 0);
                    waitframe(1);
                }
            } else {
                var_302eebd3 setinvisibletoplayer(self);
                mdl_tomahawk setinvisibletoplayer(self);
                level.var_6293e8f0 clientfield::set("" + #"tomahawk_pickup_fx", 0);
                level.var_6293e8f0 clientfield::set("" + #"hash_51657261e835ac7c", 0);
                waitframe(1);
            }
        }
        wait 1;
    }
}

