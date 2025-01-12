#using scripts\core_common\animation_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\killcam_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\visionset_mgr_shared;

#namespace globallogic;

// Namespace globallogic/globallogic
// Params 0, eflags: 0x2
// Checksum 0xb7b3dfef, Offset: 0x368
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"globallogic", &__init__, undefined, #"visionset_mgr");
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0xdb10e3e9, Offset: 0x3b8
// Size: 0x70a
function __init__() {
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
    clientfield::register("worlduimodel", "hudItems.team1.roundsWon", 1, 4, "int", undefined, 0, 0);
    clientfield::register("worlduimodel", "hudItems.team1.livesCount", 1, 8, "int", undefined, 0, 0);
    clientfield::register("worlduimodel", "hudItems.team1.noRespawnsLeft", 1, 1, "int", undefined, 0, 0);
    clientfield::register("worlduimodel", "hudItems.team2.roundsWon", 1, 4, "int", undefined, 0, 0);
    clientfield::register("worlduimodel", "hudItems.team2.livesCount", 1, 8, "int", undefined, 0, 0);
    clientfield::register("worlduimodel", "hudItems.team2.noRespawnsLeft", 1, 1, "int", undefined, 0, 0);
    clientfield::register("worlduimodel", "hudItems.specialistSwitchIsLethal", 1, 1, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "hudItems.armorIsOnCooldown", 1, 1, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "hudItems.hideOutcomeUI", 1, 1, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "hudItems.captureCrateState", 1, 2, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "hudItems.captureCrateTotalTime", 1, 13, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "hudItems.playerLivesCount", 1, 8, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "huditems.killedByEntNum", 1, 4, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "huditems.killedByAttachmentCount", 1, 4, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "huditems.killedByItemIndex", 1, 10, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "huditems.killedByMOD", 1, 8, "int", undefined, 0, 0);
    for (index = 0; index < 5; index++) {
        clientfield::register("clientuimodel", "huditems.killedByAttachment" + index, 1, 6, "int", undefined, 0, 0);
    }
    level._effect[#"annihilate_explosion"] = #"hash_17591c79f2960fba";
    level._effect[#"pineapplegun_explosion"] = #"hash_84cd1f227fcd07e";
    level.gameended = 0;
    level.postgame = 0;
    level.new_health_model = getdvarint(#"new_health_model", 1) > 0;
    level.var_9ef11bf6 = getgametypesetting(#"playermaxhealth") - 150;
}

// Namespace globallogic/globallogic
// Params 7, eflags: 0x0
// Checksum 0x96091e69, Offset: 0xad0
// Size: 0x9e
function on_end_game(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval && !level.gameended) {
        callback::callback(#"on_end_game", localclientnum);
        level notify(#"game_ended");
        level.gameended = 1;
    }
}

// Namespace globallogic/globallogic
// Params 7, eflags: 0x0
// Checksum 0x361b0bbe, Offset: 0xb78
// Size: 0x76
function post_game(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval && !level.postgame) {
        level notify(#"post_game");
        level.postgame = 1;
    }
}

// Namespace globallogic/globallogic
// Params 7, eflags: 0x0
// Checksum 0x85dda83d, Offset: 0xbf8
// Size: 0x4e
function firefly_effect_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (bnewent && newval) {
    }
}

// Namespace globallogic/globallogic
// Params 7, eflags: 0x0
// Checksum 0xf638bf0, Offset: 0xc50
// Size: 0x184
function annihilate_effect_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval && !oldval) {
        where = self gettagorigin("J_SpineLower");
        if (!isdefined(where)) {
            where = self.origin;
        }
        where += (0, 0, -40);
        character_index = self getcharacterbodytype();
        fields = getcharacterfields(character_index, currentsessionmode());
        if (isdefined(fields) && fields.fullbodyexplosion !== "") {
            if (util::is_mature() && !util::is_gib_restricted_build()) {
                playfx(localclientnum, fields.fullbodyexplosion, where);
            }
            playfx(localclientnum, "explosions/fx8_exp_grenade_default", where);
        }
    }
}

// Namespace globallogic/globallogic
// Params 7, eflags: 0x0
// Checksum 0xfa9573e0, Offset: 0xde0
// Size: 0xdc
function pineapplegun_effect_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval && !oldval) {
        where = self gettagorigin("J_SpineLower");
        if (!isdefined(where)) {
            where = self.origin;
        }
        if (isdefined(level._effect[#"pineapplegun_explosion"])) {
            playfx(localclientnum, level._effect[#"pineapplegun_explosion"], where);
        }
    }
}

// Namespace globallogic/globallogic
// Params 2, eflags: 0x0
// Checksum 0xe17556b0, Offset: 0xec8
// Size: 0x8c
function play_plant_sound(param1, param2) {
    if (function_f9eeb14f(self, "No Plant Sounds")) {
        return;
    }
    tagpos = self gettagorigin("j_ring_ri_2");
    self playsound(self.localclientnum, #"fly_bomb_buttons_npc", tagpos);
}

