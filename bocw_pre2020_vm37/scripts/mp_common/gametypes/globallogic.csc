#using script_1bd5a845bf9ba498;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\dogtags;
#using scripts\core_common\killcam_shared;
#using scripts\core_common\renderoverridebundle;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\killstreaks\killstreak_detect;
#using scripts\mp_common\gametypes\display_transition;
#using scripts\mp_common\player\player;

#namespace globallogic;

// Namespace globallogic/globallogic
// Params 0, eflags: 0x6
// Checksum 0xa7ad617c, Offset: 0x408
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"globallogic", &function_70a657d8, undefined, undefined, #"visionset_mgr");
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x5 linked
// Checksum 0x1f84012d, Offset: 0x458
// Size: 0xc44
function private function_70a657d8() {
    visionset_mgr::register_visionset_info("mpintro", 1, 31, undefined, "mpintro");
    visionset_mgr::register_visionset_info("crithealth", 1, 25, undefined, "critical_health");
    animation::add_notetrack_func(#"globallogic::play_plant_sound", &play_plant_sound);
    clientfield::register("world", "game_ended", 1, 1, "int", &on_end_game, 1, 1);
    clientfield::register("world", "post_game", 1, 1, "int", &post_game, 1, 1);
    registerclientfield("playercorpse", "firefly_effect", 1, 2, "int", &firefly_effect_cb, 0);
    registerclientfield("playercorpse", "annihilate_effect", 1, 1, "int", &annihilate_effect_cb, 0);
    registerclientfield("playercorpse", "pineapplegun_effect", 1, 1, "int", &pineapplegun_effect_cb, 0);
    registerclientfield("actor", "annihilate_effect", 1, 1, "int", &annihilate_effect_cb, 0);
    registerclientfield("actor", "pineapplegun_effect", 1, 1, "int", &pineapplegun_effect_cb, 0);
    clientfield::function_5b7d846d("hudItems.team1.roundsWon", #"hash_410fe12a68d6e801", [#"team1", #"roundswon"], 1, 4, "int", undefined, 0, 0);
    clientfield::function_5b7d846d("hudItems.team1.livesCount", #"hash_410fe12a68d6e801", [#"team1", #"livescount"], 1, 8, "int", undefined, 0, 0);
    clientfield::function_5b7d846d("hudItems.team1.noRespawnsLeft", #"hash_410fe12a68d6e801", [#"team1", #"norespawnsleft"], 1, 1, "int", undefined, 0, 0);
    clientfield::function_5b7d846d("hudItems.team2.roundsWon", #"hash_410fe12a68d6e801", [#"team2", #"roundswon"], 1, 4, "int", undefined, 0, 0);
    clientfield::function_5b7d846d("hudItems.team2.livesCount", #"hash_410fe12a68d6e801", [#"team2", #"livescount"], 1, 8, "int", undefined, 0, 0);
    clientfield::function_5b7d846d("hudItems.team2.noRespawnsLeft", #"hash_410fe12a68d6e801", [#"team2", #"norespawnsleft"], 1, 1, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.armorIsOnCooldown", #"hash_6f4b11a0bee9b73d", #"armorisoncooldown", 1, 1, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.hideOutcomeUI", #"hash_6f4b11a0bee9b73d", #"hideoutcomeui", 1, 1, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.captureCrateState", #"hash_6f4b11a0bee9b73d", #"capturecratestate", 1, 2, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.captureCrateTotalTime", #"hash_6f4b11a0bee9b73d", #"capturecratetotaltime", 1, 13, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.playerLivesCount", #"hash_6f4b11a0bee9b73d", #"playerlivescount", 1, 8, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("huditems.killedByEntNum", #"hash_6f4b11a0bee9b73d", #"killedbyentnum", 1, 4, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("huditems.killedByAttachmentCount", #"hash_6f4b11a0bee9b73d", #"killedbyattachmentcount", 1, 4, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("huditems.killedByItemIndex", #"hash_6f4b11a0bee9b73d", #"killedbyitemindex", 1, 10, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("huditems.killedByMOD", #"hash_6f4b11a0bee9b73d", #"killedbymod", 1, 8, "int", undefined, 0, 0);
    for (index = 0; index < 5; index++) {
        clientfield::register_clientuimodel("huditems.killedByAttachment" + index, #"hash_6f4b11a0bee9b73d", #"killedbyattachment" + (isdefined(index) ? "" + index : ""), 1, 6, "int", undefined, 0, 0);
    }
    clientfield::register("toplayer", "thermal_sight", 1, 1, "int", &function_765b7c63, 0, 0);
    clientfield::register("toplayer", "strobe_light", 1, 1, "int", &function_e1af467, 0, 0);
    clientfield::register("allplayers", "cold_blooded", 1, 1, "int", &function_194072a7, 0, 0);
    level._effect[#"annihilate_explosion"] = #"hash_17591c79f2960fba";
    level._effect[#"pineapplegun_explosion"] = #"hash_84cd1f227fcd07e";
    level.gameended = 0;
    level.postgame = 0;
    level.new_health_model = getdvarint(#"new_health_model", 1) > 0;
    if (sessionmodeismultiplayergame()) {
        level.var_90bb9821 = getgametypesetting(#"specialistmaxhealth_allies_1") - 150;
    } else {
        level.var_90bb9821 = getgametypesetting(#"playermaxhealth") - 150;
    }
    setdvar(#"bg_boastenabled", getgametypesetting(#"boastenabled"));
    boastallowcam = getgametypesetting(#"boastallowcam");
    setdvar(#"hash_23c5d7207ebc0bf9", boastallowcam);
    setdvar(#"hash_62833d3c5e6d7380", boastallowcam);
    setdvar(#"hash_e099986c072eb0f", getgametypesetting(#"hash_104f124f56f0f20a"));
    setdvar(#"hash_553ad8f9db24bf22", int(1000 * getgametypesetting(#"hash_1614b9cbe0df6f75")));
    setdvar(#"cg_healthperbar", 25);
    callback::on_spawned(&on_player_spawned);
    display_transition::init_shared();
    level.droppedtagrespawn = getgametypesetting(#"droppedtagrespawn");
    if (is_true(level.droppedtagrespawn)) {
        dogtags::init();
    }
}

// Namespace globallogic/globallogic
// Params 1, eflags: 0x1 linked
// Checksum 0x22882e8a, Offset: 0x10a8
// Size: 0x24
function on_player_spawned(*localclientnum) {
    self function_36b630a3(1);
}

// Namespace globallogic/globallogic
// Params 7, eflags: 0x1 linked
// Checksum 0xf1922971, Offset: 0x10d8
// Size: 0xa0
function on_end_game(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump && !level.gameended) {
        callback::callback(#"on_end_game", fieldname);
        level notify(#"game_ended");
        level.gameended = 1;
    }
}

// Namespace globallogic/globallogic
// Params 7, eflags: 0x1 linked
// Checksum 0xcba7bc2a, Offset: 0x1180
// Size: 0x78
function post_game(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump && !level.postgame) {
        level notify(#"post_game");
        level.postgame = 1;
    }
}

// Namespace globallogic/globallogic
// Params 7, eflags: 0x1 linked
// Checksum 0xd8dff7a, Offset: 0x1200
// Size: 0x4e
function firefly_effect_cb(*localclientnum, *oldval, newval, bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump && fieldname) {
    }
}

// Namespace globallogic/globallogic
// Params 7, eflags: 0x1 linked
// Checksum 0x6ecee7c, Offset: 0x1258
// Size: 0x194
function annihilate_effect_cb(localclientnum, oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump && !fieldname) {
        where = self gettagorigin("J_SpineLower");
        if (!isdefined(where)) {
            where = self.origin;
        }
        where += (0, 0, -40);
        character_index = self getcharacterbodytype();
        fields = getcharacterfields(character_index, currentsessionmode());
        if (isdefined(fields) && isdefined(fields.fullbodyexplosion) && fields.fullbodyexplosion !== "") {
            if (util::is_mature() && !util::is_gib_restricted_build()) {
                playfx(binitialsnap, fields.fullbodyexplosion, where);
            }
            playfx(binitialsnap, "explosions/fx8_exp_grenade_default", where);
        }
    }
}

// Namespace globallogic/globallogic
// Params 7, eflags: 0x1 linked
// Checksum 0x6e922ac0, Offset: 0x13f8
// Size: 0xdc
function pineapplegun_effect_cb(localclientnum, oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump && !fieldname) {
        where = self gettagorigin("J_SpineLower");
        if (!isdefined(where)) {
            where = self.origin;
        }
        if (isdefined(level._effect[#"pineapplegun_explosion"])) {
            playfx(binitialsnap, level._effect[#"pineapplegun_explosion"], where);
        }
    }
}

// Namespace globallogic/globallogic
// Params 2, eflags: 0x1 linked
// Checksum 0xaf65bcf3, Offset: 0x14e0
// Size: 0x8c
function play_plant_sound(*param1, *param2) {
    if (function_1e6822f(self, "No Plant Sounds")) {
        return;
    }
    tagpos = self gettagorigin("j_ring_ri_2");
    self playsound(self.localclientnum, #"fly_bomb_buttons_npc", tagpos);
}

// Namespace globallogic/globallogic
// Params 2, eflags: 0x1 linked
// Checksum 0x63b9589d, Offset: 0x1578
// Size: 0xdc
function updateenemyequipment(local_client_num, *newval) {
    if (isdefined(level.var_58253868)) {
        self renderoverridebundle::function_c8d97b8e(newval, #"friendly", #"hash_66ac79c57723c169");
    }
    if (isdefined(level.var_420d7d7e)) {
        self renderoverridebundle::function_c8d97b8e(newval, #"enemy", #"hash_691f7dc47ae8aa08");
    }
    self renderoverridebundle::function_c8d97b8e(newval, #"friendly", #"hash_ebb37dab2ee0ae3");
}

// Namespace globallogic/globallogic
// Params 2, eflags: 0x1 linked
// Checksum 0xffdca313, Offset: 0x1660
// Size: 0x2c
function function_116b413e(local_client_num, newval) {
    self killstreak_detect::function_d859c344(local_client_num, newval);
}

// Namespace globallogic/globallogic
// Params 7, eflags: 0x1 linked
// Checksum 0x99631b44, Offset: 0x1698
// Size: 0x26c
function function_765b7c63(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        if (!is_true(self.var_33b61b6f)) {
            self.var_8e7f416f = self playloopsound(#"hash_a93a3bf58dbd89d");
            self.var_33b61b6f = 1;
        }
    } else if (is_true(self.var_33b61b6f)) {
        self stoploopsound(self.var_8e7f416f);
        self.var_33b61b6f = 0;
    }
    level notify(#"thermal_toggle");
    players = getplayers(local_client_num);
    foreach (player in players) {
        if (util::function_fbce7263(player.team, self.team) && player hasperk(local_client_num, #"specialty_immunenvthermal")) {
            player function_194072a7(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
        }
    }
    util::clean_deleted(level.enemyequip);
    array::thread_all(level.enemyequip, &updateenemyequipment, local_client_num, newval);
    util::clean_deleted(level.enemyvehicles);
    array::thread_all(level.enemyvehicles, &function_116b413e, local_client_num, newval);
}

// Namespace globallogic/globallogic
// Params 7, eflags: 0x1 linked
// Checksum 0x30ec0fc3, Offset: 0x1910
// Size: 0xcc
function function_e1af467(local_client_num, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (function_1cbf351b(fieldname)) {
        return;
    }
    if (bwastimejump && !self function_6c32d092(fieldname, #"talent_resistance")) {
        self function_36b630a3(0);
        return;
    }
    self function_36b630a3(1);
}

// Namespace globallogic/globallogic
// Params 7, eflags: 0x1 linked
// Checksum 0x17a0f7d4, Offset: 0x19e8
// Size: 0xe4
function function_194072a7(local_client_num, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (!function_4e3684f2(fieldname)) {
        if (bwastimejump) {
            self stoprenderoverridebundle(#"rob_sonar_set_enemy");
            self playrenderoverridebundle(#"rob_sonar_set_enemy_cold");
            return;
        }
        self stoprenderoverridebundle(#"rob_sonar_set_enemy_cold");
        self playrenderoverridebundle(#"rob_sonar_set_enemy");
    }
}

