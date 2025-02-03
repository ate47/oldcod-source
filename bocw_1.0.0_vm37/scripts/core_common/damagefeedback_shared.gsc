#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\weapons_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\weapons\weapon_utils;

#namespace damagefeedback;

/#

    // Namespace damagefeedback/damagefeedback_shared
    // Params 0, eflags: 0x6
    // Checksum 0xd45d9f44, Offset: 0x1a8
    // Size: 0x3c
    function private autoexec __init__system__() {
        system::register(#"damagefeedback", &preinit, undefined, undefined, undefined);
    }

    // Namespace damagefeedback/damagefeedback_shared
    // Params 0, eflags: 0x4
    // Checksum 0x77b6d089, Offset: 0x1f0
    // Size: 0x2c
    function private preinit() {
        callback::on_connect(&on_player_connect);
    }

    // Namespace damagefeedback/damagefeedback_shared
    // Params 0, eflags: 0x0
    // Checksum 0x411af1a2, Offset: 0x228
    // Size: 0x8
    function on_player_connect() {
        
    }

#/

// Namespace damagefeedback/damagefeedback_shared
// Params 1, eflags: 0x0
// Checksum 0xe454d90d, Offset: 0x238
// Size: 0x96
function should_play_sound(mod) {
    if (!isdefined(mod)) {
        return false;
    }
    switch (mod) {
    case #"mod_melee_weapon_butt":
    case #"mod_crush":
    case #"mod_hit_by_object":
    case #"mod_grenade_splash":
    case #"mod_melee_assassinate":
    case #"mod_melee":
        return false;
    }
    return true;
}

// Namespace damagefeedback/damagefeedback_shared
// Params 9, eflags: 0x0
// Checksum 0xf324d989, Offset: 0x2d8
// Size: 0x12a
function play_hit_alert_sfx(mod, inflictor, perkfeedback, weapon, victim, psoffsettime, shitloc, fatal, idflags) {
    if (sessionmodeiscampaigngame()) {
        hitalias = hit_alert_sfx_cp(mod, inflictor, perkfeedback, weapon, victim, psoffsettime, shitloc, fatal);
    }
    if (sessionmodeismultiplayergame() || sessionmodeiswarzonegame()) {
        hitalias = hit_alert_sfx_mp(mod, inflictor, perkfeedback, weapon, victim, psoffsettime, shitloc, fatal, idflags);
    }
    if (sessionmodeiszombiesgame()) {
        hitalias = hit_alert_sfx_zm(mod, inflictor, perkfeedback, weapon, victim, psoffsettime, shitloc, fatal, idflags);
    }
    return hitalias;
}

// Namespace damagefeedback/damagefeedback_shared
// Params 8, eflags: 0x0
// Checksum 0x874c6662, Offset: 0x410
// Size: 0x144
function hit_alert_sfx_cp(mod, *inflictor, *perkfeedback, weapon, *victim, *psoffsettime, shitloc, fatal) {
    hitalias = undefined;
    suffix = "";
    if (should_play_sound(victim)) {
        if (isplayer(self)) {
            if (self isinvehicle()) {
                return hitalias;
            }
        }
        if (is_true(fatal)) {
            suffix = "_fatal";
        } else {
            suffix = "_nf";
        }
        if (weapons::isheadshot(psoffsettime, shitloc, victim)) {
            hitalias = #"hash_7049f87709615569";
        } else {
            hitalias = #"hash_66f38123cad3a33b";
        }
        if (isdefined(hitalias)) {
            hitalias += suffix;
        }
    }
    return hitalias;
}

// Namespace damagefeedback/damagefeedback_shared
// Params 9, eflags: 0x0
// Checksum 0xaab08716, Offset: 0x560
// Size: 0x892
function hit_alert_sfx_mp(mod, inflictor, perkfeedback, weapon, victim, *psoffsettime, shitloc, fatal, idflags) {
    hitalias = undefined;
    if (!isdefined(victim)) {
        return;
    }
    if (isdefined(victim.hitsound) && victim.hitsound != "") {
        hitalias = victim.hitsound;
        return hitalias;
    }
    if (victim.var_965cc0b3) {
        if (is_true(fatal)) {
            hitalias = #"hash_6d7fa87ddd50800";
        } else {
            hitalias = #"hash_644a18cd873e501d";
        }
    }
    if (should_play_sound(inflictor)) {
        if (isdefined(victim.hitsound) && victim.hitsound != "") {
            hitalias = victim.hitsound;
        } else if (victim.grappleweapon) {
            hitalias = #"hash_671bc9a2de453f2e";
        } else if (victim.name == #"snowball") {
            hitalias = #"mpl_hit_alert_snow";
        } else if (victim.name == #"waterballoon") {
            hitalias = #"hash_1fd605562fb1fd3a";
        } else if (isvehicle(psoffsettime)) {
            hitalias = #"hash_2ce81d103e923201";
        } else if (isdefined(psoffsettime) && isdefined(psoffsettime.victimsoundmod)) {
            switch (psoffsettime.victimsoundmod) {
            case #"safeguard_robot":
                hitalias = #"mpl_hit_alert_escort";
                break;
            case #"vehicle":
                hitalias = #"hash_2ce81d103e923201";
                break;
            default:
                hitalias = #"mpl_hit_alert";
                break;
            }
        } else if (isdefined(perkfeedback) && isdefined(perkfeedback.soundmod)) {
            switch (perkfeedback.soundmod) {
            case #"player":
                if (isdefined(idflags) && idflags & 2048 && isdefined(psoffsettime)) {
                    if (isdefined(psoffsettime.var_426947c4)) {
                        if (weapons::isheadshot(victim, shitloc, inflictor)) {
                            hitalias = #"hash_6b219a0cac330e0b";
                        } else {
                            hitalias = #"mpl_hit_alert_armor_broke";
                        }
                    } else {
                        hitalias = #"mpl_hit_alert_armor_hit";
                    }
                } else if (isdefined(psoffsettime) && is_true(psoffsettime.isaiclone)) {
                    hitalias = #"mpl_hit_alert_clone";
                } else if (isdefined(psoffsettime) && is_true(psoffsettime.isaiclone)) {
                    hitalias = #"mpl_hit_alert_clone";
                } else if (isdefined(psoffsettime) && is_true(psoffsettime.var_342564dd)) {
                    hitalias = #"mpl_hit_alert_rad";
                } else if (isdefined(psoffsettime) && isplayer(psoffsettime) && isdefined(psoffsettime.carryobject) && isdefined(psoffsettime.carryobject.hitsound) && isdefined(weapon) && weapon == "armor") {
                    hitalias = psoffsettime.carryobject.hitsound;
                } else if (inflictor == "MOD_BURNED") {
                    hitalias = #"mpl_hit_alert_burn";
                } else if (is_true(fatal)) {
                    if (weapons::isheadshot(victim, shitloc, inflictor)) {
                        hitalias = #"hash_616dd8ea01d089ac";
                    } else {
                        hitalias = #"hash_31e38d8520839566";
                    }
                } else if (weapons::isheadshot(victim, shitloc, inflictor)) {
                    hitalias = #"hash_29ca1afa9209bfc6";
                } else if (inflictor == "MOD_MELEE_WEAPON_BUTT") {
                } else if (shitloc === "riotshield") {
                    hitalias = #"prj_bullet_impact_shield";
                } else {
                    hitalias = #"hash_205c83ac75849f80";
                }
                break;
            case #"heatwave":
                hitalias = #"mpl_hit_alert_heatwave";
                break;
            case #"heli":
                hitalias = #"mpl_hit_alert_air";
                break;
            case #"hpm":
                hitalias = #"mpl_hit_alert_hpm";
                break;
            case #"taser_spike":
                hitalias = #"mpl_hit_alert_taser_spike";
                break;
            case #"straferun":
            case #"dog":
                break;
            case #"firefly":
                hitalias = #"mpl_hit_alert_firefly";
                break;
            case #"drone_land":
                hitalias = #"mpl_hit_alert_air";
                break;
            case #"mini_turret":
                hitalias = #"mpl_hit_alert_quiet";
                break;
            case #"raps":
                hitalias = #"mpl_hit_alert_air";
                break;
            case #"default_loud":
                hitalias = #"mpl_hit_heli_gunner";
                break;
            default:
                hitalias = #"mpl_hit_alert";
                break;
            }
        } else if (inflictor == "MOD_BURNED" || inflictor == "MOD_DOT") {
            hitalias = #"mpl_hit_alert_burn";
        } else {
            hitalias = #"hash_205c83ac75849f80";
            if (is_true(fatal)) {
                hitalias = #"hash_31e38d8520839566";
            }
        }
    } else if (inflictor === "MOD_MELEE_WEAPON_BUTT") {
        if (fatal === 1) {
            hitalias = #"hash_27781beb722b7488";
        }
    } else if (isdefined(perkfeedback) && isdefined(perkfeedback.owner) && isdefined(perkfeedback.owner.soundmod)) {
        if (perkfeedback.owner.soundmod == #"player" && isdefined(idflags) && idflags & 2048 && isdefined(psoffsettime)) {
            if (isdefined(psoffsettime.var_426947c4)) {
                hitalias = #"mpl_hit_alert_armor_broke";
            }
        }
    }
    return hitalias;
}

// Namespace damagefeedback/damagefeedback_shared
// Params 9, eflags: 0x0
// Checksum 0xef50213e, Offset: 0xe00
// Size: 0x862
function hit_alert_sfx_zm(mod, inflictor, perkfeedback, weapon, victim, *psoffsettime, shitloc, fatal, idflags) {
    hitalias = undefined;
    if (!isdefined(victim)) {
        return;
    }
    if (isdefined(victim.hitsound) && victim.hitsound != "") {
        hitalias = victim.hitsound;
        return hitalias;
    }
    if (victim.var_965cc0b3) {
        hitalias = #"hash_644a18cd873e501d";
    }
    if (should_play_sound(inflictor)) {
        if (isdefined(victim.hitsound) && victim.hitsound != "") {
            hitalias = victim.hitsound;
        } else if (victim.grappleweapon) {
            hitalias = #"hash_671bc9a2de453f2e";
        } else if (victim.name == #"snowball") {
            hitalias = #"mpl_hit_alert_snow";
        } else if (victim.name == #"waterballoon") {
            hitalias = #"hash_1fd605562fb1fd3a";
        } else if (isvehicle(psoffsettime)) {
            hitalias = #"hash_2ce81d103e923201";
        } else if (isdefined(psoffsettime) && isdefined(psoffsettime.victimsoundmod)) {
            switch (psoffsettime.victimsoundmod) {
            case #"safeguard_robot":
                hitalias = #"mpl_hit_alert_escort";
                break;
            case #"vehicle":
                hitalias = #"hash_2ce81d103e923201";
                break;
            default:
                hitalias = #"mpl_hit_alert";
                break;
            }
        } else if (isdefined(perkfeedback) && isdefined(perkfeedback.soundmod)) {
            switch (perkfeedback.soundmod) {
            case #"player":
                if (isdefined(idflags) && idflags & 2048 && isdefined(psoffsettime)) {
                    if (isdefined(psoffsettime.var_426947c4)) {
                        if (weapons::isheadshot(victim, shitloc, inflictor)) {
                            hitalias = #"hash_6b219a0cac330e0b";
                        } else {
                            hitalias = #"mpl_hit_alert_armor_broke";
                        }
                    } else {
                        hitalias = #"mpl_hit_alert_armor_hit";
                    }
                } else if (isdefined(psoffsettime) && is_true(psoffsettime.isaiclone)) {
                    hitalias = #"mpl_hit_alert_clone";
                } else if (isdefined(psoffsettime) && is_true(psoffsettime.isaiclone)) {
                    hitalias = #"mpl_hit_alert_clone";
                } else if (isdefined(psoffsettime) && is_true(psoffsettime.var_342564dd)) {
                    hitalias = #"mpl_hit_alert_rad";
                } else if (isdefined(psoffsettime) && isplayer(psoffsettime) && isdefined(psoffsettime.carryobject) && isdefined(psoffsettime.carryobject.hitsound) && isdefined(weapon) && weapon == "armor") {
                    hitalias = psoffsettime.carryobject.hitsound;
                } else if (inflictor == "MOD_BURNED") {
                    hitalias = #"mpl_hit_alert_burn";
                } else if (is_true(fatal)) {
                    if (weapons::isheadshot(victim, shitloc, inflictor)) {
                        hitalias = #"hash_616dd8ea01d089ac";
                    } else {
                        hitalias = #"hash_31e38d8520839566";
                    }
                } else if (weapons::isheadshot(victim, shitloc, inflictor)) {
                    hitalias = #"hash_29ca1afa9209bfc6";
                } else if (inflictor == "MOD_MELEE_WEAPON_BUTT") {
                } else if (shitloc === "riotshield") {
                    hitalias = #"prj_bullet_impact_shield";
                } else {
                    hitalias = #"hash_205c83ac75849f80";
                }
                break;
            case #"heatwave":
                hitalias = #"mpl_hit_alert_heatwave";
                break;
            case #"heli":
                hitalias = #"mpl_hit_alert_air";
                break;
            case #"hpm":
                hitalias = #"mpl_hit_alert_hpm";
                break;
            case #"taser_spike":
                hitalias = #"mpl_hit_alert_taser_spike";
                break;
            case #"straferun":
            case #"dog":
                break;
            case #"firefly":
                hitalias = #"mpl_hit_alert_firefly";
                break;
            case #"drone_land":
                hitalias = #"mpl_hit_alert_air";
                break;
            case #"mini_turret":
                hitalias = #"mpl_hit_alert_quiet";
                break;
            case #"raps":
                hitalias = #"mpl_hit_alert_air";
                break;
            case #"default_loud":
                hitalias = #"mpl_hit_heli_gunner";
                break;
            default:
                hitalias = #"mpl_hit_alert";
                break;
            }
        } else if (inflictor == "MOD_BURNED" || inflictor == "MOD_DOT") {
            hitalias = #"mpl_hit_alert_burn";
        } else {
            hitalias = #"hash_205c83ac75849f80";
            if (is_true(fatal)) {
                hitalias = #"hash_31e38d8520839566";
            }
        }
    } else if (inflictor === "MOD_MELEE_WEAPON_BUTT") {
        if (fatal === 1) {
            hitalias = #"hash_27781beb722b7488";
        }
    } else if (isdefined(perkfeedback) && isdefined(perkfeedback.owner) && isdefined(perkfeedback.owner.soundmod)) {
        if (perkfeedback.owner.soundmod == #"player" && isdefined(idflags) && idflags & 2048 && isdefined(psoffsettime)) {
            if (isdefined(psoffsettime.var_426947c4)) {
                hitalias = #"mpl_hit_alert_armor_broke";
            }
        }
    }
    return hitalias;
}

// Namespace damagefeedback/damagefeedback_shared
// Params 2, eflags: 0x0
// Checksum 0xa691ae21, Offset: 0x1670
// Size: 0x7a
function function_34fbafdc(weapon, mod) {
    if (isdefined(weapon) && isdefined(weapon.var_965cc0b3) && weapon.var_965cc0b3) {
        return true;
    }
    if (isdefined(weapon) && weapon === level.shockrifleweapon && mod === "MOD_DOT") {
        return true;
    }
    return false;
}

// Namespace damagefeedback/damagefeedback_shared
// Params 10, eflags: 0x0
// Checksum 0x1d0820d1, Offset: 0x16f8
// Size: 0x8a6
function update(mod, inflictor, perkfeedback, weapon, victim, psoffsettime, shitloc, fatal, idflags, var_594a2d34) {
    if (!isplayer(self)) {
        return;
    }
    if (is_true(self.nohitmarkers)) {
        return;
    }
    if (isdefined(weapon) && weapon.statname == #"recon_car" && isdefined(victim) && isdefined(victim.owner) && inflictor === victim.owner) {
        return;
    }
    if (isdefined(weapon) && is_true(weapon.nohitmarker)) {
        return;
    }
    if (!isdefined(self.lasthitmarkertime)) {
        self.lasthitmarkertimes = [];
        self.lasthitmarkertime = 0;
        self.lasthitmarkeroffsettime = 0;
        self.var_1ead243c = 0;
    }
    if (isdefined(psoffsettime) && isdefined(victim)) {
        victim_id = victim getentitynumber();
        if (!isdefined(self.lasthitmarkertimes[victim_id])) {
            self.lasthitmarkertimes[victim_id] = 0;
        }
        if (self.lasthitmarkertime == gettime()) {
            if (self.lasthitmarkertimes[victim_id] === psoffsettime && fatal !== 1 && perkfeedback === undefined) {
                return;
            }
        }
        self.lasthitmarkeroffsettime = psoffsettime;
        self.lasthitmarkertimes[victim_id] = psoffsettime;
    } else if (self.lasthitmarkertime == gettime()) {
        return;
    }
    damagestage = 1;
    if (self.lasthitmarkertime >= gettime() - 1000) {
        damagestage = self.var_1ead243c + 1;
        if (damagestage > 2) {
            damagestage = 1;
        }
    }
    self.var_1ead243c = damagestage;
    self.lasthitmarkertime = gettime();
    hitalias = play_hit_alert_sfx(mod, inflictor, perkfeedback, weapon, victim, psoffsettime, shitloc, fatal, idflags);
    if (isdefined(victim) && is_true(victim.isaiclone) || shitloc === "riotshield") {
        self playhitmarker(hitalias);
        return;
    }
    if (isdefined(victim) && (sessionmodeiszombiesgame() || sessionmodeiscampaigngame() || isplayer(victim))) {
        if (victim.health <= 0) {
            damagestage = 5;
        }
    }
    if ((mod === "MOD_DOT" || mod === "MOD_DOT_SELF") && !isdefined(self.var_dbffaa32) && damagestage != 5) {
        return;
    }
    if (!isdefined(var_594a2d34)) {
        var_594a2d34 = function_34fbafdc(weapon, mod);
        if (isdefined(self.viewlockedentity) && isvehicle(self.viewlockedentity) && self.usingvehicle) {
            var_594a2d34 = 0;
        }
    }
    if (isdefined(victim) && is_true(victim.var_8ac0d510) && var_594a2d34) {
        return;
    }
    var_32f65675 = 0;
    if (isdefined(victim) && damagestage == 5 && isdefined(level.skiplaststand) && !is_true(level.skiplaststand) && !is_true(victim.laststand) && isplayer(victim)) {
        var_32f65675 = 1;
    }
    if (isvehicle(victim) && !is_true(victim.var_22b9bee1)) {
        is_vehicle = 1;
    }
    is_dead = damagestage == 5;
    if (isdefined(victim) && victim.archetype === #"robot") {
        is_vehicle = 1;
    }
    is_vehicle = isdefined(victim.var_48d842c3) ? victim.var_48d842c3 : is_vehicle;
    if (isdefined(victim) && self != victim) {
        is_friendly = !victim util::isenemyteam(self.team);
    }
    self playhitmarker(hitalias, damagestage, perkfeedback, is_dead, var_594a2d34, is_vehicle, var_32f65675, is_friendly);
    if (isdefined(inflictor) && isplayer(inflictor)) {
        inflictor playrumbleonentity("hitmarker_rumble");
    }
    /#
        if (isdefined(perkfeedback)) {
            if (isdefined(self.hud_damagefeedback_additional)) {
                switch (perkfeedback) {
                case #"flakjacket":
                    self.hud_damagefeedback_additional setshader(#"damage_feedback_flak", 24, 48);
                    break;
                case #"tacticalmask":
                    self.hud_damagefeedback_additional setshader(#"damage_feedback_tac", 24, 48);
                    break;
                case #"armor":
                    self.hud_damagefeedback_additional setshader(#"damage_feedback_armor", 24, 48);
                    break;
                }
                self.hud_damagefeedback_additional.alpha = 1;
                self.hud_damagefeedback_additional fadeovertime(1);
                self.hud_damagefeedback_additional.alpha = 0;
            }
        } else if (isdefined(self.hud_damagefeedback)) {
            self.hud_damagefeedback setshader(#"damage_feedback", 24, 48);
        }
        if (isdefined(self.hud_damagefeedback) && isdefined(level.growing_hitmarker) && isdefined(victim) && (sessionmodeiscampaigngame() || isplayer(victim))) {
            self thread damage_feedback_growth(victim, mod, weapon);
            return;
        }
        if (isdefined(self.hud_damagefeedback)) {
            self.hud_damagefeedback.x = -12;
            self.hud_damagefeedback.y = -12;
            self.hud_damagefeedback.alpha = 1;
            self.hud_damagefeedback fadeovertime(1);
            self.hud_damagefeedback.alpha = 0;
        }
    #/
}

// Namespace damagefeedback/damagefeedback_shared
// Params 2, eflags: 0x0
// Checksum 0x9b8033ea, Offset: 0x1fa8
// Size: 0x10c
function damage_feedback_get_stage(victim, fatal) {
    if (!isdefined(victim) || !isdefined(victim.maxhealth) || victim.maxhealth <= 0) {
        return 1;
    }
    var_7d71342b = victim.health / victim.maxhealth;
    if (is_true(victim.laststand)) {
        if (fatal === 1) {
            return 5;
        }
        return 1;
    }
    if (var_7d71342b > 0.74) {
        return 1;
    }
    if (var_7d71342b > 0.49) {
        return 2;
    }
    if (var_7d71342b > 0.24) {
        return 3;
    }
    if (victim.health > 0) {
        return 4;
    }
    return 5;
}

// Namespace damagefeedback/damagefeedback_shared
// Params 4, eflags: 0x0
// Checksum 0xcb64c1ed, Offset: 0x20c0
// Size: 0xf6
function damage_feedback_get_dead(*victim, mod, weapon, stage) {
    return stage == 5 && (mod == "MOD_BULLET" || mod == "MOD_RIFLE_BULLET" || mod == "MOD_PISTOL_BULLET" || mod == "MOD_IMPACT" || mod == "MOD_HEAD_SHOT" || mod == "MOD_BURNED" || mod == "MOD_DOT" || mod == "MOD_MELEE_WEAPON_BUTT") && !weapon.isheavyweapon && !killstreaks::is_killstreak_weapon(weapon);
}

/#

    // Namespace damagefeedback/damagefeedback_shared
    // Params 3, eflags: 0x0
    // Checksum 0xeb19f844, Offset: 0x21c0
    // Size: 0x1c6
    function damage_feedback_growth(victim, mod, weapon) {
        if (isdefined(self.hud_damagefeedback)) {
            stage = damage_feedback_get_stage(victim);
            self.hud_damagefeedback.x = -11 + -1 * stage;
            self.hud_damagefeedback.y = -11 + -1 * stage;
            size_x = 22 + 2 * stage;
            size_y = size_x * 2;
            self.hud_damagefeedback setshader(#"damage_feedback", size_x, size_y);
            if (damage_feedback_get_dead(victim, mod, weapon, stage)) {
                self.hud_damagefeedback setshader(#"damage_feedback_glow_orange", size_x, size_y);
                self thread kill_hitmarker_fade();
                return;
            }
            self.hud_damagefeedback setshader(#"damage_feedback", size_x, size_y);
            self.hud_damagefeedback.alpha = 1;
            self.hud_damagefeedback fadeovertime(1);
            self.hud_damagefeedback.alpha = 0;
        }
    }

    // Namespace damagefeedback/damagefeedback_shared
    // Params 0, eflags: 0x0
    // Checksum 0xf0eb5639, Offset: 0x2390
    // Size: 0x96
    function kill_hitmarker_fade() {
        if (!isdefined(self.hud_damagefeedback)) {
            return;
        }
        self notify(#"kill_hitmarker_fade");
        self endon(#"kill_hitmarker_fade", #"disconnect");
        self.hud_damagefeedback.alpha = 1;
        wait 0.25;
        self.hud_damagefeedback fadeovertime(0.3);
        self.hud_damagefeedback.alpha = 0;
    }

#/

// Namespace damagefeedback/damagefeedback_shared
// Params 3, eflags: 0x0
// Checksum 0x528728cc, Offset: 0x2430
// Size: 0x156
function update_override(icon, sound, additional_icon) {
    if (!isplayer(self)) {
        return;
    }
    self playlocalsound(sound);
    /#
        if (isdefined(self.hud_damagefeedback)) {
            self.hud_damagefeedback setshader(icon, 24, 48);
            self.hud_damagefeedback.alpha = 1;
            self.hud_damagefeedback fadeovertime(1);
            self.hud_damagefeedback.alpha = 0;
        }
        if (isdefined(self.hud_damagefeedback_additional)) {
            if (!isdefined(additional_icon)) {
                self.hud_damagefeedback_additional.alpha = 0;
                return;
            }
            self.hud_damagefeedback_additional setshader(additional_icon, 24, 48);
            self.hud_damagefeedback_additional.alpha = 1;
            self.hud_damagefeedback_additional fadeovertime(1);
            self.hud_damagefeedback_additional.alpha = 0;
        }
    #/
}

// Namespace damagefeedback/damagefeedback_shared
// Params 4, eflags: 0x0
// Checksum 0x6f522891, Offset: 0x2590
// Size: 0xce
function dodamagefeedback(weapon, *einflictor, idamage, smeansofdeath) {
    if (!isdefined(einflictor)) {
        return false;
    }
    if (is_true(einflictor.nohitmarker)) {
        return false;
    }
    if (level.allowhitmarkers == 0) {
        return false;
    }
    if (isdefined(smeansofdeath) && smeansofdeath == "MOD_MELEE_ASSASSINATE") {
        return false;
    }
    if (level.allowhitmarkers == 1) {
        if (isdefined(smeansofdeath) && isdefined(idamage)) {
            if (istacticalhitmarker(einflictor, smeansofdeath, idamage)) {
                return false;
            }
        }
    }
    return true;
}

// Namespace damagefeedback/damagefeedback_shared
// Params 3, eflags: 0x0
// Checksum 0x6cf539c4, Offset: 0x2668
// Size: 0x7c
function istacticalhitmarker(weapon, smeansofdeath, idamage) {
    if (weapons::is_grenade(weapon)) {
        if ("Smoke Grenade" == weapon.offhandclass) {
            if (smeansofdeath == "MOD_GRENADE_SPLASH") {
                return true;
            }
        } else if (idamage == 1) {
            return true;
        }
    }
    return false;
}

