#using scripts/core_common/abilities/gadgets/gadget_camo_render;
#using scripts/core_common/abilities/gadgets/gadget_clone_render;
#using scripts/core_common/ai/systems/fx_character;
#using scripts/core_common/animation_shared;
#using scripts/core_common/audio_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/duplicaterender_mgr;
#using scripts/core_common/scene_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace end_game_taunts;

// Namespace end_game_taunts/end_game_taunts
// Params 0, eflags: 0x2
// Checksum 0xb1ba68cd, Offset: 0x1988
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("end_game_taunts", &__init__, undefined, undefined);
}

// Namespace end_game_taunts/end_game_taunts
// Params 0, eflags: 0x0
// Checksum 0x84c1c196, Offset: 0x19c8
// Size: 0x28c
function __init__() {
    animation::add_notetrack_func("taunts::hide", &hidemodel);
    animation::add_notetrack_func("taunts::show", &showmodel);
    animation::add_notetrack_func("taunts::spawncameraglass", &function_77868cd5);
    animation::add_notetrack_func("taunts::deletecameraglass", &function_6a310293);
    animation::add_notetrack_func("taunts::reaperbulletglass", &function_bb6820f0);
    animation::add_notetrack_func("taunts::centerbulletglass", &function_51285b7e);
    animation::add_notetrack_func("taunts::fireweapon", &fireweapon);
    animation::add_notetrack_func("taunts::stopfireweapon", &stopfireweapon);
    animation::add_notetrack_func("taunts::firebeam", &function_cb36d98c);
    animation::add_notetrack_func("taunts::stopfirebeam", &function_3ec7f964);
    animation::add_notetrack_func("taunts::playwinnerteamfx", &function_8efd00a3);
    animation::add_notetrack_func("taunts::playlocalteamfx", &function_e72c395d);
    level.var_13674108 = array("gfx_p7_zm_asc_data_recorder_glass", "wpn_t7_hero_reaper_minigun_prop", "wpn_t7_loot_hero_reaper3_minigun_prop", "c_zsf_robot_grunt_body", "c_zsf_robot_grunt_head", "wpn_t7_hero_annihilator_prop", "wpn_t7_hero_bow_prop", "wpn_t7_hero_electro_prop_animate", "wpn_t7_hero_flamethrower_world", "wpn_t7_hero_mgl_world", "wpn_t7_hero_mgl_prop", "wpn_t7_hero_spike_prop", "wpn_t7_hero_seraph_machete_prop", "wpn_t7_loot_crowbar_world", "wpn_t7_zmb_katana_prop");
    function_be586671();
}

/#

    // Namespace end_game_taunts/end_game_taunts
    // Params 0, eflags: 0x0
    // Checksum 0x547cbb6e, Offset: 0x1c60
    // Size: 0x238
    function function_93ddf1a2() {
        while (true) {
            setdvar("<dev string:x28>", "<dev string:x33>");
            waitframe(1);
            taunt = getdvarstring("<dev string:x28>");
            if (taunt == "<dev string:x33>") {
                continue;
            }
            model = level.var_62c15215[0];
            if (isdefined(model.var_1e465ba6) && (!isdefined(model) || isdefined(model.var_7ca854a3) || model.var_1e465ba6)) {
                continue;
            }
            bodytype = getdvarint("<dev string:x34>", -1);
            setdvar("<dev string:x34>", -1);
            if (bodytype >= 0) {
                var_7941bf2e = function_dd121ebf(model.localclientnum, bodytype, model.origin, model.angles, model.showcaseweapon);
                model hide();
            } else {
                var_7941bf2e = model;
            }
            idleanimname = function_466e285f(model.localclientnum, model, 0);
            function_f2a89d41(model.localclientnum, var_7941bf2e, 0, idleanimname, taunt);
            if (var_7941bf2e != model) {
                var_7941bf2e delete();
                model show();
            }
        }
    }

    // Namespace end_game_taunts/end_game_taunts
    // Params 0, eflags: 0x0
    // Checksum 0xf7bf3ec0, Offset: 0x1ea0
    // Size: 0x140
    function function_d90bdba7() {
        while (true) {
            setdvar("<dev string:x47>", "<dev string:x33>");
            waitframe(1);
            gesture = getdvarstring("<dev string:x47>");
            if (gesture == "<dev string:x33>") {
                continue;
            }
            model = level.var_62c15215[0];
            if (isdefined(model.var_1e465ba6) && (!isdefined(model) || isdefined(model.var_7ca854a3) || model.var_1e465ba6)) {
                continue;
            }
            idleanimname = function_466e285f(model.localclientnum, model, 0);
            playgesture(model.localclientnum, model, 0, idleanimname, gesture, 1);
        }
    }

    // Namespace end_game_taunts/end_game_taunts
    // Params 0, eflags: 0x0
    // Checksum 0x75fe96d3, Offset: 0x1fe8
    // Size: 0xe2
    function function_41f59618() {
        while (true) {
            waitframe(1);
            if (!getdvarint("<dev string:x54>", 0)) {
                continue;
            }
            for (i = 1; i < 3; i++) {
                model = level.var_62c15215[i];
                box(model.origin, (-15, -15, 0), (15, 15, 72), model.angles[1], (0, 0, 1), 0, 1);
            }
        }
    }

    // Namespace end_game_taunts/end_game_taunts
    // Params 5, eflags: 0x0
    // Checksum 0xf3b5f819, Offset: 0x20d8
    // Size: 0x212
    function function_dd121ebf(localclientnum, characterindex, origin, angles, showcaseweapon) {
        tempmodel = spawn(localclientnum, origin, "<dev string:x62>");
        tempmodel.angles = angles;
        tempmodel.showcaseweapon = showcaseweapon;
        tempmodel.bodymodel = getcharacterbodymodel(characterindex, 0, currentsessionmode());
        tempmodel.helmetmodel = getcharacterhelmetmodel(characterindex, 0, currentsessionmode());
        tempmodel setmodel(tempmodel.bodymodel);
        tempmodel attach(tempmodel.helmetmodel, "<dev string:x33>");
        tempmodel.var_957cc42 = getcharactermoderenderoptions(currentsessionmode());
        tempmodel.var_6f30937d = getcharacterbodyrenderoptions(characterindex, 0, 0, 0, 0);
        tempmodel.var_d44a8060 = getcharacterhelmetrenderoptions(characterindex, 0, 0, 0, 0);
        tempmodel setbodyrenderoptions(tempmodel.var_957cc42, tempmodel.var_6f30937d, tempmodel.var_d44a8060, tempmodel.var_d44a8060);
        return tempmodel;
    }

#/

// Namespace end_game_taunts/end_game_taunts
// Params 3, eflags: 0x0
// Checksum 0x9186e5f5, Offset: 0x22f8
// Size: 0x94
function function_206ff6ca(localclientnum, charactermodel, var_c55b8047) {
    var_7b22aba9 = gettopplayerstaunt(localclientnum, var_c55b8047, 0);
    idleanimname = function_466e285f(localclientnum, charactermodel, var_c55b8047);
    function_f2a89d41(localclientnum, charactermodel, var_c55b8047, idleanimname, var_7b22aba9);
}

// Namespace end_game_taunts/end_game_taunts
// Params 4, eflags: 0x0
// Checksum 0x3e919fdb, Offset: 0x2398
// Size: 0x7c
function function_b5457a9d(localclientnum, charactermodel, idleanimname, var_7b22aba9) {
    function_1926278(charactermodel);
    function_6a310293(undefined);
    function_f2a89d41(localclientnum, charactermodel, 0, idleanimname, var_7b22aba9, 0, 0);
}

// Namespace end_game_taunts/end_game_taunts
// Params 7, eflags: 0x0
// Checksum 0x6f627e8, Offset: 0x2420
// Size: 0x296
function function_f2a89d41(localclientnum, charactermodel, var_c55b8047, idleanimname, var_7b22aba9, var_87e82ec, var_19a5a3c1) {
    if (!isdefined(var_87e82ec)) {
        var_87e82ec = 0;
    }
    if (!isdefined(var_19a5a3c1)) {
        var_19a5a3c1 = 1;
    }
    if (!isdefined(var_7b22aba9) || var_7b22aba9 == "") {
        return;
    }
    function_7222354d(localclientnum, charactermodel);
    charactermodel stopsounds();
    charactermodel endon(#"hash_7222354d");
    charactermodel util::waittill_dobj(localclientnum);
    if (!charactermodel hasanimtree()) {
        charactermodel useanimtree(#all_player);
    }
    charactermodel.var_7ca854a3 = var_7b22aba9;
    charactermodel notify(#"hash_1bd6a53a");
    charactermodel clearanim(idleanimname, var_87e82ec);
    var_85489c4 = function_ae20af86(charactermodel, var_c55b8047);
    hideweapon(charactermodel);
    charactermodel thread function_eb8cdf14(localclientnum, var_7b22aba9);
    charactermodel animation::play(var_7b22aba9, undefined, undefined, 1, var_87e82ec, 0.4);
    if (isdefined(var_19a5a3c1) && var_19a5a3c1) {
        self thread function_21c398b1(charactermodel);
        function_f7b75149(charactermodel, var_85489c4, 0.4, 0.4);
    }
    function_6030b386(charactermodel);
    charactermodel thread animation::play(idleanimname, undefined, undefined, 1, 0.4, 0);
    charactermodel.var_7ca854a3 = undefined;
    charactermodel notify(#"hash_447fd19");
    charactermodel.var_bd3c8c = undefined;
}

// Namespace end_game_taunts/end_game_taunts
// Params 2, eflags: 0x0
// Checksum 0x9415c25a, Offset: 0x26c0
// Size: 0xa6
function function_7222354d(localclientnum, charactermodel) {
    if (isdefined(charactermodel.var_7ca854a3)) {
        charactermodel function_cfed633a();
        charactermodel function_5f04ba5e(localclientnum, charactermodel.var_7ca854a3);
        charactermodel stopsounds();
    }
    charactermodel notify(#"hash_7222354d");
    charactermodel.var_7ca854a3 = undefined;
    charactermodel.var_bd3c8c = undefined;
}

// Namespace end_game_taunts/end_game_taunts
// Params 4, eflags: 0x0
// Checksum 0x82008f78, Offset: 0x2770
// Size: 0x9c
function function_2794f71c(localclientnum, charactermodel, var_c55b8047, gesturetype) {
    idleanimname = function_466e285f(localclientnum, charactermodel, var_c55b8047);
    var_77c5fbfc = gettopplayersgesture(localclientnum, var_c55b8047, gesturetype);
    playgesture(localclientnum, charactermodel, var_c55b8047, idleanimname, var_77c5fbfc);
}

// Namespace end_game_taunts/end_game_taunts
// Params 4, eflags: 0x0
// Checksum 0x3ee92ed2, Offset: 0x2818
// Size: 0x7c
function previewgesture(localclientnum, charactermodel, idleanimname, var_77c5fbfc) {
    function_7222354d(localclientnum, charactermodel);
    function_6a310293(undefined);
    playgesture(localclientnum, charactermodel, 0, idleanimname, var_77c5fbfc, 0);
}

// Namespace end_game_taunts/end_game_taunts
// Params 6, eflags: 0x0
// Checksum 0x66a0a76b, Offset: 0x28a0
// Size: 0x2bc
function playgesture(localclientnum, charactermodel, var_c55b8047, idleanimname, var_77c5fbfc, var_19a5a3c1) {
    if (!isdefined(var_19a5a3c1)) {
        var_19a5a3c1 = 1;
    }
    if (!isdefined(var_77c5fbfc) || var_77c5fbfc == "") {
        return;
    }
    function_1926278(charactermodel);
    charactermodel endon(#"hash_1926278");
    charactermodel util::waittill_dobj(localclientnum);
    if (!charactermodel hasanimtree()) {
        charactermodel useanimtree(#all_player);
    }
    charactermodel.var_1e465ba6 = 1;
    charactermodel notify(#"hash_584b58ed");
    charactermodel clearanim(idleanimname, 0.4);
    var_fd422097 = function_3a5977e5(charactermodel, var_c55b8047);
    var_85489c4 = function_ae20af86(charactermodel, var_c55b8047);
    if (isdefined(var_19a5a3c1) && var_19a5a3c1) {
        self thread function_31dca0d6(charactermodel);
        function_f7b75149(charactermodel, var_fd422097, 0.4, 0.4);
    }
    hideweapon(charactermodel);
    charactermodel animation::play(var_77c5fbfc, undefined, undefined, 1, 0.4, 0.4);
    if (isdefined(var_19a5a3c1) && var_19a5a3c1) {
        self thread function_21c398b1(charactermodel);
        function_f7b75149(charactermodel, var_85489c4, 0.4, 0.4);
    }
    function_6030b386(charactermodel);
    charactermodel thread animation::play(idleanimname, undefined, undefined, 1, 0.4, 0);
    charactermodel.var_1e465ba6 = 0;
    charactermodel notify(#"hash_27e17e90");
}

// Namespace end_game_taunts/end_game_taunts
// Params 1, eflags: 0x0
// Checksum 0xa8c5938, Offset: 0x2b68
// Size: 0x2c
function function_1926278(charactermodel) {
    charactermodel notify(#"hash_1926278");
    charactermodel.var_1e465ba6 = 0;
}

// Namespace end_game_taunts/end_game_taunts
// Params 4, eflags: 0x0
// Checksum 0x4e56518, Offset: 0x2ba0
// Size: 0xa4
function function_f7b75149(charactermodel, var_9753d2, blendintime, blendouttime) {
    if (!isdefined(blendintime)) {
        blendintime = 0;
    }
    if (!isdefined(blendouttime)) {
        blendouttime = 0;
    }
    charactermodel endon(#"hash_7222354d");
    if (!isdefined(var_9753d2) || var_9753d2 == "") {
        return;
    }
    charactermodel animation::play(var_9753d2, undefined, undefined, 1, blendintime, blendouttime);
}

// Namespace end_game_taunts/end_game_taunts
// Params 1, eflags: 0x0
// Checksum 0xc832f36, Offset: 0x2c50
// Size: 0x7a
function function_31dca0d6(charactermodel) {
    charactermodel endon(#"hash_7fdd4e6d");
    while (true) {
        waitresult = charactermodel waittill("_anim_notify_");
        if (waitresult.notetrack == "remove_from_hand") {
            hideweapon(charactermodel);
            return;
        }
    }
}

// Namespace end_game_taunts/end_game_taunts
// Params 1, eflags: 0x0
// Checksum 0x33e72bd4, Offset: 0x2cd8
// Size: 0x7a
function function_21c398b1(charactermodel) {
    charactermodel endon(#"hash_de430a8c");
    while (true) {
        waitresult = charactermodel waittill("_anim_notify_");
        if (waitresult.notetrack == "appear_in_hand") {
            function_6030b386(charactermodel);
            return;
        }
    }
}

// Namespace end_game_taunts/end_game_taunts
// Params 1, eflags: 0x0
// Checksum 0xe72753c9, Offset: 0x2d60
// Size: 0x94
function hideweapon(charactermodel) {
    if (charactermodel.weapon == level.weaponnone) {
        return;
    }
    markasdirty(charactermodel);
    charactermodel attachweapon(level.weaponnone);
    charactermodel useweaponhidetags(level.weaponnone);
    charactermodel notify(#"hash_7fdd4e6d");
}

// Namespace end_game_taunts/end_game_taunts
// Params 1, eflags: 0x0
// Checksum 0x3f85023d, Offset: 0x2e00
// Size: 0x104
function function_6030b386(charactermodel) {
    if (!isdefined(charactermodel.showcaseweapon) || charactermodel.weapon != level.weaponnone) {
        return;
    }
    markasdirty(charactermodel);
    if (isdefined(charactermodel.var_7ff9e1d4)) {
        charactermodel attachweapon(charactermodel.showcaseweapon, charactermodel.var_7ff9e1d4, charactermodel.var_4b073b25);
        charactermodel useweaponhidetags(charactermodel.showcaseweapon);
    } else {
        charactermodel attachweapon(charactermodel.showcaseweapon);
    }
    charactermodel notify(#"hash_de430a8c");
}

// Namespace end_game_taunts/end_game_taunts
// Params 3, eflags: 0x0
// Checksum 0xb717413, Offset: 0x2f10
// Size: 0xbee
function function_466e285f(localclientnum, charactermodel, var_c55b8047) {
    if (isdefined(charactermodel.weapon)) {
        weapon_group = getitemgroupforweaponname(charactermodel.weapon.rootweapon.name);
        if (weapon_group == "weapon_launcher") {
            if (charactermodel.weapon.rootweapon.name == "launcher_lockonly" || charactermodel.weapon.rootweapon.name == "launcher_multi") {
                weapon_group = "weapon_launcher_alt";
            }
        } else if (weapon_group == "weapon_pistol" && charactermodel.weapon.isdualwield) {
            weapon_group = "weapon_pistol_dw";
        } else if (weapon_group == "weapon_special") {
            if (charactermodel.weapon.rootweapon.name == "special_crossbow") {
                weapon_group = "weapon_smg";
            } else if (charactermodel.weapon.rootweapon.name == "special_crossbow_dw") {
                weapon_group = "weapon_pistol_dw";
            }
        } else if (weapon_group == "weapon_knife") {
            if (charactermodel.weapon.rootweapon.name == "melee_wrench" || charactermodel.weapon.rootweapon.name == "melee_crowbar" || charactermodel.weapon.rootweapon.name == "melee_improvise" || charactermodel.weapon.rootweapon.name == "melee_shockbaton") {
                return array("pb_wrench_endgame_1stplace_idle", "pb_wrench_endgame_2ndplace_idle", "pb_wrench_endgame_3rdplace_idle")[var_c55b8047];
            } else if (charactermodel.weapon.rootweapon.name == "melee_knuckles") {
                return array("pb_brass_knuckles_endgame_1stplace_idle", "pb_brass_knuckles_endgame_2ndplace_idle", "pb_brass_knuckles_endgame_3rdplace_idle")[var_c55b8047];
            } else if (charactermodel.weapon.rootweapon.name == "melee_sword" || charactermodel.weapon.rootweapon.name == "melee_bat") {
                return array("pb_sword_endgame_1stplace_idle", "pb_sword_endgame_2ndplace_idle", "pb_sword_endgame_3rdplace_idle")[var_c55b8047];
            } else if (charactermodel.weapon.rootweapon.name == "melee_nunchuks") {
                return array("pb_nunchucks_endgame_1stplace_idle", "pb_nunchucks_endgame_2ndplace_idle", "pb_nunchucks_endgame_3rdplace_idle")[var_c55b8047];
            } else if (charactermodel.weapon.rootweapon.name == "melee_bat" || charactermodel.weapon.rootweapon.name == "melee_fireaxe" || charactermodel.weapon.rootweapon.name == "melee_mace") {
                return array("pb_mace_endgame_1stplace_idle", "pb_mace_endgame_2ndplace_idle", "pb_mace_endgame_3rdplace_idle")[var_c55b8047];
            }
        } else if (weapon_group == "miscweapon") {
            if (charactermodel.weapon.rootweapon.name == "blackjack_coin") {
                return array("pb_brawler_endgame_1stplace_idle", "pb_brawler_endgame_2ndplace_idle", "pb_brawler_endgame_3rdplace_idle")[var_c55b8047];
            } else if (charactermodel.weapon.rootweapon.name == "blackjack_cards") {
                return array("pb_brawler_endgame_1stplace_idle", "pb_brawler_endgame_2ndplace_idle", "pb_brawler_endgame_3rdplace_idle")[var_c55b8047];
            }
        }
        if (isdefined(associativearray("weapon_smg", array("pb_smg_endgame_1stplace_idle", "pb_smg_endgame_2ndplace_idle", "pb_smg_endgame_3rdplace_idle"), "weapon_assault", array("pb_rifle_endgame_1stplace_idle", "pb_rifle_endgame_2ndplace_idle", "pb_rifle_endgame_3rdplace_idle"), "weapon_cqb", array("pb_shotgun_endgame_1stplace_idle", "pb_shotgun_endgame_2ndplace_idle", "pb_shotgun_endgame_3rdplace_idle"), "weapon_lmg", array("pb_lmg_endgame_1stplace_idle", "pb_lmg_endgame_2ndplace_idle", "pb_lmg_endgame_3rdplace_idle"), "weapon_sniper", array("pb_sniper_endgame_1stplace_idle", "pb_sniper_endgame_2ndplace_idle", "pb_sniper_endgame_3rdplace_idle"), "weapon_pistol", array("pb_pistol_endgame_1stplace_idle", "pb_pistol_endgame_2ndplace_idle", "pb_pistol_endgame_3rdplace_idle"), "weapon_pistol_dw", array("pb_pistol_dw_endgame_1stplace_idle", "pb_pistol_dw_endgame_2ndplace_idle", "pb_pistol_dw_endgame_3rdplace_idle"), "weapon_launcher", array("pb_launcher_endgame_1stplace_idle", "pb_launcher_endgame_2ndplace_idle", "pb_launcher_endgame_3rdplace_idle"), "weapon_launcher_alt", array("pb_launcher_alt_endgame_1stplace_idle", "pb_launcher_alt_endgame_2ndplace_idle", "pb_launcher_alt_endgame_3rdplace_idle"), "weapon_knife", array("pb_knife_endgame_1stplace_idle", "pb_knife_endgame_2ndplace_idle", "pb_knife_endgame_3rdplace_idle"), "weapon_knuckles", array("pb_brass_knuckles_endgame_1stplace_idle", "pb_brass_knuckles_endgame_2ndplace_idle", "pb_brass_knuckles_endgame_3rdplace_idle"), "weapon_wrench", array("pb_wrench_endgame_1stplace_idle", "pb_wrench_endgame_2ndplace_idle", "pb_wrench_endgame_3rdplace_idle"), "weapon_sword", array("pb_sword_endgame_1stplace_idle", "pb_sword_endgame_2ndplace_idle", "pb_sword_endgame_3rdplace_idle"), "weapon_nunchucks", array("pb_nunchucks_endgame_1stplace_idle", "pb_nunchucks_endgame_2ndplace_idle", "pb_nunchucks_endgame_3rdplace_idle"), "weapon_mace", array("pb_mace_endgame_1stplace_idle", "pb_mace_endgame_2ndplace_idle", "pb_mace_endgame_3rdplace_idle"), "brawler", array("pb_brawler_endgame_1stplace_idle", "pb_brawler_endgame_2ndplace_idle", "pb_brawler_endgame_3rdplace_idle"))[weapon_group])) {
            anim_name = associativearray("weapon_smg", array("pb_smg_endgame_1stplace_idle", "pb_smg_endgame_2ndplace_idle", "pb_smg_endgame_3rdplace_idle"), "weapon_assault", array("pb_rifle_endgame_1stplace_idle", "pb_rifle_endgame_2ndplace_idle", "pb_rifle_endgame_3rdplace_idle"), "weapon_cqb", array("pb_shotgun_endgame_1stplace_idle", "pb_shotgun_endgame_2ndplace_idle", "pb_shotgun_endgame_3rdplace_idle"), "weapon_lmg", array("pb_lmg_endgame_1stplace_idle", "pb_lmg_endgame_2ndplace_idle", "pb_lmg_endgame_3rdplace_idle"), "weapon_sniper", array("pb_sniper_endgame_1stplace_idle", "pb_sniper_endgame_2ndplace_idle", "pb_sniper_endgame_3rdplace_idle"), "weapon_pistol", array("pb_pistol_endgame_1stplace_idle", "pb_pistol_endgame_2ndplace_idle", "pb_pistol_endgame_3rdplace_idle"), "weapon_pistol_dw", array("pb_pistol_dw_endgame_1stplace_idle", "pb_pistol_dw_endgame_2ndplace_idle", "pb_pistol_dw_endgame_3rdplace_idle"), "weapon_launcher", array("pb_launcher_endgame_1stplace_idle", "pb_launcher_endgame_2ndplace_idle", "pb_launcher_endgame_3rdplace_idle"), "weapon_launcher_alt", array("pb_launcher_alt_endgame_1stplace_idle", "pb_launcher_alt_endgame_2ndplace_idle", "pb_launcher_alt_endgame_3rdplace_idle"), "weapon_knife", array("pb_knife_endgame_1stplace_idle", "pb_knife_endgame_2ndplace_idle", "pb_knife_endgame_3rdplace_idle"), "weapon_knuckles", array("pb_brass_knuckles_endgame_1stplace_idle", "pb_brass_knuckles_endgame_2ndplace_idle", "pb_brass_knuckles_endgame_3rdplace_idle"), "weapon_wrench", array("pb_wrench_endgame_1stplace_idle", "pb_wrench_endgame_2ndplace_idle", "pb_wrench_endgame_3rdplace_idle"), "weapon_sword", array("pb_sword_endgame_1stplace_idle", "pb_sword_endgame_2ndplace_idle", "pb_sword_endgame_3rdplace_idle"), "weapon_nunchucks", array("pb_nunchucks_endgame_1stplace_idle", "pb_nunchucks_endgame_2ndplace_idle", "pb_nunchucks_endgame_3rdplace_idle"), "weapon_mace", array("pb_mace_endgame_1stplace_idle", "pb_mace_endgame_2ndplace_idle", "pb_mace_endgame_3rdplace_idle"), "brawler", array("pb_brawler_endgame_1stplace_idle", "pb_brawler_endgame_2ndplace_idle", "pb_brawler_endgame_3rdplace_idle"))[weapon_group][var_c55b8047];
        }
    }
    if (!isdefined(anim_name)) {
        anim_name = array("pb_brawler_endgame_1stplace_idle", "pb_brawler_endgame_2ndplace_idle", "pb_brawler_endgame_3rdplace_idle")[var_c55b8047];
    }
    return anim_name;
}

// Namespace end_game_taunts/end_game_taunts
// Params 2, eflags: 0x0
// Checksum 0x3673eaae, Offset: 0x3b08
// Size: 0x396
function function_3a5977e5(charactermodel, var_c55b8047) {
    weapon_group = getweapongroup(charactermodel);
    switch (weapon_group) {
    case #"weapon_smg":
        return array("pb_smg_endgame_1stplace_out", "pb_smg_endgame_2ndplace_out", "pb_smg_endgame_3rdplace_out")[var_c55b8047];
    case #"weapon_assault":
        return array("pb_rifle_endgame_1stplace_out", "pb_rifle_endgame_2ndplace_out", "pb_rifle_endgame_3rdplace_out")[var_c55b8047];
    case #"weapon_cqb":
        return array("pb_shotgun_endgame_1stplace_out", "pb_shotgun_endgame_2ndplace_out", "pb_shotgun_endgame_3rdplace_out")[var_c55b8047];
    case #"weapon_lmg":
        return array("pb_lmg_endgame_1stplace_out", "pb_lmg_endgame_2ndplace_out", "pb_lmg_endgame_3rdplace_out")[var_c55b8047];
    case #"weapon_sniper":
        return array("pb_sniper_endgame_1stplace_out", "pb_sniper_endgame_2ndplace_out", "pb_sniper_endgame_3rdplace_out")[var_c55b8047];
    case #"weapon_pistol":
        return array("pb_pistol_endgame_1stplace_out", "pb_pistol_endgame_2ndplace_out", "pb_pistol_endgame_3rdplace_out")[var_c55b8047];
    case #"weapon_pistol_dw":
        return array("pb_pistol_dw_endgame_1stplace_out", "pb_pistol_dw_endgame_2ndplace_out", "pb_pistol_dw_endgame_3rdplace_out")[var_c55b8047];
    case #"weapon_launcher":
        return array("pb_launcher_endgame_1stplace_out", "pb_launcher_endgame_2ndplace_out", "pb_launcher_endgame_3rdplace_out")[var_c55b8047];
    case #"weapon_launcher_alt":
        return array("pb_launcher_alt_endgame_1stplace_out", "pb_launcher_alt_endgame_2ndplace_out", "pb_launcher_alt_endgame_3rdplace_out")[var_c55b8047];
    case #"weapon_knife":
        return array("pb_knife_endgame_1stplace_out", "pb_knife_endgame_2ndplace_out", "pb_knife_endgame_3rdplace_out")[var_c55b8047];
    case #"weapon_knuckles":
        return array("pb_brass_knuckles_endgame_1stplace_out", "pb_brass_knuckles_endgame_2ndplace_out", "pb_brass_knuckles_endgame_3rdplace_out")[var_c55b8047];
    case #"weapon_wrench":
        return array("pb_wrench_endgame_1stplace_out", "pb_wrench_endgame_2ndplace_out", "pb_wrench_endgame_3rdplace_out")[var_c55b8047];
    case #"weapon_sword":
        return array("pb_sword_endgame_1stplace_out", "pb_sword_endgame_2ndplace_out", "pb_sword_endgame_3rdplace_out")[var_c55b8047];
    case #"weapon_nunchucks":
        return array("pb_nunchucks_endgame_1stplace_out", "pb_nunchucks_endgame_2ndplace_out", "pb_nunchucks_endgame_3rdplace_out")[var_c55b8047];
    case #"weapon_mace":
        return array("pb_mace_endgame_1stplace_out", "pb_mace_endgame_2ndplace_out", "pb_mace_endgame_3rdplace_out")[var_c55b8047];
    }
    return "";
}

// Namespace end_game_taunts/end_game_taunts
// Params 2, eflags: 0x0
// Checksum 0xb84fda80, Offset: 0x3ea8
// Size: 0x396
function function_ae20af86(charactermodel, var_c55b8047) {
    weapon_group = getweapongroup(charactermodel);
    switch (weapon_group) {
    case #"weapon_smg":
        return array("pb_smg_endgame_1stplace_in", "pb_smg_endgame_2ndplace_in", "pb_smg_endgame_3rdplace_in")[var_c55b8047];
    case #"weapon_assault":
        return array("pb_rifle_endgame_1stplace_in", "pb_rifle_endgame_2ndplace_in", "pb_rifle_endgame_3rdplace_in")[var_c55b8047];
    case #"weapon_cqb":
        return array("pb_shotgun_endgame_1stplace_in", "pb_shotgun_endgame_2ndplace_in", "pb_shotgun_endgame_3rdplace_in")[var_c55b8047];
    case #"weapon_lmg":
        return array("pb_lmg_endgame_1stplace_in", "pb_lmg_endgame_2ndplace_in", "pb_lmg_endgame_3rdplace_in")[var_c55b8047];
    case #"weapon_sniper":
        return array("pb_sniper_endgame_1stplace_in", "pb_sniper_endgame_2ndplace_in", "pb_sniper_endgame_3rdplace_in")[var_c55b8047];
    case #"weapon_pistol":
        return array("pb_pistol_endgame_1stplace_in", "pb_pistol_endgame_2ndplace_in", "pb_pistol_endgame_3rdplace_in")[var_c55b8047];
    case #"weapon_pistol_dw":
        return array("pb_pistol_dw_endgame_1stplace_in", "pb_pistol_dw_endgame_2ndplace_in", "pb_pistol_dw_endgame_3rdplace_in")[var_c55b8047];
    case #"weapon_launcher":
        return array("pb_launcher_endgame_1stplace_in", "pb_launcher_endgame_2ndplace_in", "pb_launcher_endgame_3rdplace_in")[var_c55b8047];
    case #"weapon_launcher_alt":
        return array("pb_launcher_alt_endgame_1stplace_in", "pb_launcher_alt_endgame_2ndplace_in", "pb_launcher_alt_endgame_3rdplace_in")[var_c55b8047];
    case #"weapon_knife":
        return array("pb_knife_endgame_1stplace_in", "pb_knife_endgame_2ndplace_in", "pb_knife_endgame_3rdplace_in")[var_c55b8047];
    case #"weapon_knuckles":
        return array("pb_brass_knuckles_endgame_1stplace_in", "pb_brass_knuckles_endgame_2ndplace_in", "pb_brass_knuckles_endgame_3rdplace_in")[var_c55b8047];
    case #"weapon_wrench":
        return array("pb_wrench_endgame_1stplace_in", "pb_wrench_endgame_2ndplace_in", "pb_wrench_endgame_3rdplace_in")[var_c55b8047];
    case #"weapon_sword":
        return array("pb_sword_endgame_1stplace_in", "pb_sword_endgame_2ndplace_in", "pb_sword_endgame_3rdplace_in")[var_c55b8047];
    case #"weapon_nunchucks":
        return array("pb_nunchucks_endgame_1stplace_in", "pb_nunchucks_endgame_2ndplace_in", "pb_nunchucks_endgame_3rdplace_in")[var_c55b8047];
    case #"weapon_mace":
        return array("pb_mace_endgame_1stplace_in", "pb_mace_endgame_2ndplace_in", "pb_mace_endgame_3rdplace_in")[var_c55b8047];
    }
    return "";
}

// Namespace end_game_taunts/end_game_taunts
// Params 1, eflags: 0x0
// Checksum 0x3f5a00c8, Offset: 0x4248
// Size: 0x428
function getweapongroup(charactermodel) {
    if (!isdefined(charactermodel.weapon)) {
        return "";
    }
    weapon = charactermodel.weapon;
    if (weapon == level.weaponnone && isdefined(charactermodel.showcaseweapon)) {
        weapon = charactermodel.showcaseweapon;
    }
    weapon_group = getitemgroupforweaponname(weapon.rootweapon.name);
    if (weapon_group == "weapon_launcher") {
        if (charactermodel.weapon.rootweapon.name == "launcher_lockonly" || charactermodel.weapon.rootweapon.name == "launcher_multi") {
            weapon_group = "weapon_launcher_alt";
        }
    } else if (weapon_group == "weapon_pistol" && weapon.isdualwield) {
        weapon_group = "weapon_pistol_dw";
    } else if (weapon_group == "weapon_special") {
        if (charactermodel.weapon.rootweapon.name == "special_crossbow") {
            weapon_group = "weapon_smg";
        } else if (charactermodel.weapon.rootweapon.name == "special_crossbow_dw") {
            weapon_group = "weapon_pistol_dw";
        }
    } else if (weapon_group == "weapon_knife") {
        if (charactermodel.weapon.rootweapon.name == "melee_wrench" || charactermodel.weapon.rootweapon.name == "melee_crowbar" || charactermodel.weapon.rootweapon.name == "melee_improvise" || charactermodel.weapon.rootweapon.name == "melee_shockbaton") {
            weapon_group = "weapon_wrench";
        } else if (charactermodel.weapon.rootweapon.name == "melee_knuckles") {
            weapon_group = "weapon_knuckles";
        } else if (charactermodel.weapon.rootweapon.name == "melee_sword" || charactermodel.weapon.rootweapon.name == "melee_bat") {
            weapon_group = "weapon_sword";
        } else if (charactermodel.weapon.rootweapon.name == "melee_nunchuks") {
            weapon_group = "weapon_nunchucks";
        } else if (charactermodel.weapon.rootweapon.name == "melee_bat" || charactermodel.weapon.rootweapon.name == "melee_fireaxe" || charactermodel.weapon.rootweapon.name == "melee_mace") {
            weapon_group = "weapon_mace";
        }
    }
    return weapon_group;
}

// Namespace end_game_taunts/end_game_taunts
// Params 0, eflags: 0x0
// Checksum 0xefce6088, Offset: 0x4678
// Size: 0x92
function function_6eace780() {
    foreach (model in level.var_13674108) {
        forcestreamxmodel(model);
    }
}

// Namespace end_game_taunts/end_game_taunts
// Params 0, eflags: 0x0
// Checksum 0x13214f62, Offset: 0x4718
// Size: 0x92
function function_be586671() {
    foreach (model in level.var_13674108) {
        stopforcestreamingxmodel(model);
    }
}

// Namespace end_game_taunts/end_game_taunts
// Params 2, eflags: 0x0
// Checksum 0x4c0c62e0, Offset: 0x47b8
// Size: 0xd0
function function_eb8cdf14(localclientnum, var_7b22aba9) {
    var_bff02df7 = struct::get_script_bundle("scene", var_7b22aba9);
    if (!isdefined(var_bff02df7)) {
        return false;
    }
    switch (var_7b22aba9) {
    case #"hash_824aa342":
        self thread function_f39abb1e(localclientnum);
        break;
    case #"hash_5adde9fa":
        self thread function_302396b4(localclientnum, "gi_unit_victim");
        break;
    }
    self thread scene::play(var_7b22aba9);
    return true;
}

// Namespace end_game_taunts/end_game_taunts
// Params 2, eflags: 0x0
// Checksum 0xe22ac63, Offset: 0x4890
// Size: 0xbc
function function_5f04ba5e(localclientnum, var_7b22aba9) {
    var_bff02df7 = struct::get_script_bundle("scene", var_7b22aba9);
    if (!isdefined(var_bff02df7)) {
        return;
    }
    switch (var_7b22aba9) {
    case #"hash_f05bf891":
        if (getdvarstring("mapname") == "core_frontend") {
            self sethighdetail(1, 0);
        }
        break;
    }
    self thread scene::stop(var_7b22aba9);
}

// Namespace end_game_taunts/end_game_taunts
// Params 3, eflags: 0x0
// Checksum 0xf36e719b, Offset: 0x4958
// Size: 0x74
function function_6c468939(var_7b22aba9, func, state) {
    var_bff02df7 = struct::get_script_bundle("scene", var_7b22aba9);
    if (!isdefined(var_bff02df7)) {
        return;
    }
    scene::add_scene_func(var_7b22aba9, func, state);
}

// Namespace end_game_taunts/end_game_taunts
// Params 0, eflags: 0x0
// Checksum 0xb3107fe5, Offset: 0x49d8
// Size: 0xca
function function_cfed633a() {
    if (isdefined(self.var_bd3c8c)) {
        foreach (model in self.var_bd3c8c) {
            if (isdefined(model)) {
                model stopsounds();
                model delete();
            }
        }
        self.var_bd3c8c = undefined;
    }
}

// Namespace end_game_taunts/end_game_taunts
// Params 1, eflags: 0x0
// Checksum 0xec5ac3ff, Offset: 0x4ab0
// Size: 0x24
function hidemodel(param) {
    self hide();
}

// Namespace end_game_taunts/end_game_taunts
// Params 1, eflags: 0x0
// Checksum 0x3e5fcc0d, Offset: 0x4ae0
// Size: 0x24
function showmodel(param) {
    self show();
}

// Namespace end_game_taunts/end_game_taunts
// Params 1, eflags: 0x0
// Checksum 0xb6a14b95, Offset: 0x4b10
// Size: 0xd4
function function_77868cd5(param) {
    if (isdefined(level.var_cb631c4)) {
        function_6a310293(param);
    }
    level.var_cb631c4 = spawn(self.localclientnum, (0, 0, 0), "script_model");
    level.var_cb631c4 setmodel("gfx_p7_zm_asc_data_recorder_glass");
    level.var_cb631c4 setscale(2);
    level.var_cb631c4 thread function_1ac3684f();
}

// Namespace end_game_taunts/end_game_taunts
// Params 0, eflags: 0x0
// Checksum 0x430f6818, Offset: 0x4bf0
// Size: 0xca
function function_1ac3684f() {
    self endon(#"death");
    while (true) {
        camangles = getcamanglesbylocalclientnum(self.localclientnum);
        campos = getcamposbylocalclientnum(self.localclientnum);
        fwd = anglestoforward(camangles);
        self.origin = campos + fwd * 60;
        self.angles = camangles + (0, 180, 0);
        waitframe(1);
    }
}

// Namespace end_game_taunts/end_game_taunts
// Params 1, eflags: 0x0
// Checksum 0xe6938a82, Offset: 0x4cc8
// Size: 0x46
function function_6a310293(param) {
    if (!isdefined(level.var_cb631c4)) {
        return;
    }
    level.var_cb631c4 delete();
    level.var_cb631c4 = undefined;
}

// Namespace end_game_taunts/end_game_taunts
// Params 1, eflags: 0x0
// Checksum 0xb1d52b42, Offset: 0x4d18
// Size: 0xe0
function function_bb6820f0(param) {
    waittillframeend();
    minigun = getweapon("hero_minigun");
    for (i = 30; i > -30; i -= 7) {
        if (!isdefined(self)) {
            return;
        }
        self function_6c7d3666(self.localclientnum, minigun, randomfloatrange(2, 12), i);
        self playsound(0, "pfx_magic_bullet_glass");
        wait minigun.firetime;
    }
}

// Namespace end_game_taunts/end_game_taunts
// Params 1, eflags: 0x0
// Checksum 0x5ea8099c, Offset: 0x4e00
// Size: 0x94
function function_51285b7e(weaponname) {
    waittillframeend();
    weapon = getweapon(weaponname);
    if (weapon == level.weaponnone) {
        return;
    }
    self function_6c7d3666(self.localclientnum, weapon, 4, -2);
    self playsound(0, "pfx_magic_bullet_glass");
}

// Namespace end_game_taunts/end_game_taunts
// Params 1, eflags: 0x0
// Checksum 0xc48fa7eb, Offset: 0x4ea0
// Size: 0x90
function fireweapon(weaponname) {
    if (!isdefined(weaponname)) {
        return;
    }
    self endon(#"stopfireweapon");
    weapon = getweapon(weaponname);
    waittillframeend();
    while (1 && isdefined(self)) {
        self magicbullet(weapon, (0, 0, 0), (0, 0, 0));
        wait weapon.firetime;
    }
}

// Namespace end_game_taunts/end_game_taunts
// Params 1, eflags: 0x0
// Checksum 0xda19f771, Offset: 0x4f38
// Size: 0x1a
function stopfireweapon(param) {
    self notify(#"stopfireweapon");
}

// Namespace end_game_taunts/end_game_taunts
// Params 1, eflags: 0x0
// Checksum 0xcd2d8b27, Offset: 0x4f60
// Size: 0x54
function function_cb36d98c(beam) {
    if (isdefined(self.beamfx)) {
        return;
    }
    self.beamfx = beamlaunch(self.localclientnum, self, "tag_flash", undefined, "none", beam);
}

// Namespace end_game_taunts/end_game_taunts
// Params 1, eflags: 0x0
// Checksum 0xc4e578f0, Offset: 0x4fc0
// Size: 0x4e
function function_3ec7f964(param) {
    if (!isdefined(self.beamfx)) {
        return;
    }
    beamkill(self.localclientnum, self.beamfx);
    self.beamfx = undefined;
}

// Namespace end_game_taunts/end_game_taunts
// Params 1, eflags: 0x0
// Checksum 0x2611fc73, Offset: 0x5018
// Size: 0xc4
function function_8efd00a3(fxname) {
    waittillframeend();
    var_6ca16392 = gettopplayersteam(self.localclientnum, 0);
    if (!isdefined(var_6ca16392)) {
        var_6ca16392 = getlocalplayerteam(self.localclientnum);
    }
    fxhandle = playfxontag(self.localclientnum, fxname, self, "tag_origin");
    if (isdefined(fxhandle)) {
        setfxteam(self.localclientnum, fxhandle, var_6ca16392);
    }
}

// Namespace end_game_taunts/end_game_taunts
// Params 1, eflags: 0x0
// Checksum 0x6adc508f, Offset: 0x50e8
// Size: 0x9c
function function_e72c395d(fxname) {
    waittillframeend();
    localplayerteam = getlocalplayerteam(self.localclientnum);
    fxhandle = playfxontag(self.localclientnum, fxname, self, "tag_origin");
    if (isdefined(fxhandle)) {
        setfxteam(self.localclientnum, fxhandle, localplayerteam);
    }
}

// Namespace end_game_taunts/end_game_taunts
// Params 4, eflags: 0x0
// Checksum 0x3e3431c1, Offset: 0x5190
// Size: 0xac
function function_6c7d3666(localclientnum, weapon, var_8983d19e, yawangle) {
    campos = getcamposbylocalclientnum(localclientnum);
    camangles = getcamanglesbylocalclientnum(localclientnum);
    var_4ebc5205 = camangles + (var_8983d19e, yawangle, 0);
    self magicbullet(weapon, campos, var_4ebc5205);
}

// Namespace end_game_taunts/end_game_taunts
// Params 3, eflags: 0x0
// Checksum 0xc08b5063, Offset: 0x5248
// Size: 0xf4
function function_507afdb5(localclientnum, projectilemodel, var_86add0c8) {
    launchorigin = self gettagorigin("tag_flash");
    if (!isdefined(launchorigin)) {
        return;
    }
    var_80709230 = self gettagangles("tag_flash");
    launchdir = anglestoforward(var_80709230);
    createdynentandlaunch(localclientnum, projectilemodel, launchorigin, (0, 0, 0), launchorigin, launchdir * getdvarfloat("launchspeed", 3.5), var_86add0c8);
}

// Namespace end_game_taunts/end_game_taunts
// Params 1, eflags: 0x0
// Checksum 0x3a68c8c4, Offset: 0x5348
// Size: 0x1ca
function function_f39abb1e(localclientnum) {
    model = spawn(localclientnum, self.origin, "script_model");
    model.angles = self.angles;
    model.targetname = "scythe_prop";
    model sethighdetail(1);
    var_c5b8b9c = "wpn_t7_hero_reaper_minigun_prop";
    if (isdefined(self.bodymodel)) {
        if (strstartswith(self.bodymodel, "c_t7_mp_reaper_mpc_body3")) {
            var_c5b8b9c = "wpn_t7_loot_hero_reaper3_minigun_prop";
        }
    }
    model setmodel(var_c5b8b9c);
    model setbodyrenderoptions(self.var_957cc42, self.var_6f30937d, self.var_d44a8060, self.var_d44a8060);
    self hidepart(localclientnum, "tag_minigun_flaps");
    if (!isdefined(self.var_bd3c8c)) {
        self.var_bd3c8c = [];
    } else if (!isarray(self.var_bd3c8c)) {
        self.var_bd3c8c = array(self.var_bd3c8c);
    }
    self.var_bd3c8c[self.var_bd3c8c.size] = model;
}

// Namespace end_game_taunts/end_game_taunts
// Params 2, eflags: 0x0
// Checksum 0x871e6763, Offset: 0x5520
// Size: 0x14a
function function_67866405(localclientnum, targetname) {
    clone = self function_9d823940(localclientnum, targetname, self.origin, self.angles, self.bodymodel, self.helmetmodel, self.var_957cc42, self.var_6f30937d, self.var_d44a8060);
    clone setscale(0);
    waitframe(1);
    clone hide();
    clone setscale(1);
    if (!isdefined(self.var_bd3c8c)) {
        self.var_bd3c8c = [];
    } else if (!isarray(self.var_bd3c8c)) {
        self.var_bd3c8c = array(self.var_bd3c8c);
    }
    self.var_bd3c8c[self.var_bd3c8c.size] = clone;
}

// Namespace end_game_taunts/end_game_taunts
// Params 5, eflags: 0x0
// Checksum 0x83aea3c0, Offset: 0x5678
// Size: 0x12a
function function_802dd60f(localclientnum, targetname, origin, angles, var_c55b8047) {
    bodymodel = gettopplayersbodymodel(localclientnum, var_c55b8047);
    helmetmodel = gettopplayershelmetmodel(localclientnum, var_c55b8047);
    var_957cc42 = getcharactermoderenderoptions(currentsessionmode());
    var_6f30937d = gettopplayersbodyrenderoptions(localclientnum, var_c55b8047);
    var_d44a8060 = gettopplayershelmetrenderoptions(localclientnum, var_c55b8047);
    return function_9d823940(localclientnum, targetname, origin, angles, bodymodel, helmetmodel, var_957cc42, var_6f30937d, var_d44a8060);
}

// Namespace end_game_taunts/end_game_taunts
// Params 9, eflags: 0x0
// Checksum 0x54085dc3, Offset: 0x57b0
// Size: 0x158
function function_9d823940(localclientnum, targetname, origin, angles, bodymodel, helmetmodel, var_957cc42, var_6f30937d, var_d44a8060) {
    model = spawn(localclientnum, origin, "script_model");
    model.angles = angles;
    model.targetname = targetname;
    model sethighdetail(1);
    model setmodel(bodymodel);
    model attach(helmetmodel, "");
    model setbodyrenderoptions(var_957cc42, var_6f30937d, var_d44a8060, var_d44a8060);
    model hide();
    model useanimtree(#all_player);
    return model;
}

// Namespace end_game_taunts/end_game_taunts
// Params 2, eflags: 0x0
// Checksum 0xe17b8c7c, Offset: 0x5910
// Size: 0x152
function function_302396b4(localclientnum, targetname) {
    model = spawn(localclientnum, self.origin, "script_model");
    model.angles = self.angles;
    model.targetname = targetname;
    model sethighdetail(1);
    model setmodel("c_zsf_robot_grunt_body");
    model attach("c_zsf_robot_grunt_head", "");
    if (!isdefined(self.var_bd3c8c)) {
        self.var_bd3c8c = [];
    } else if (!isarray(self.var_bd3c8c)) {
        self.var_bd3c8c = array(self.var_bd3c8c);
    }
    self.var_bd3c8c[self.var_bd3c8c.size] = model;
}

