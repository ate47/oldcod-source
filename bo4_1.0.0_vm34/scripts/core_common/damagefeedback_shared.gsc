#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\weapons_shared;
#using scripts\killstreaks\killstreaks_util;

#namespace damagefeedback;

/#

    // Namespace damagefeedback/damagefeedback_shared
    // Params 0, eflags: 0x2
    // Checksum 0xb7f40f64, Offset: 0x170
    // Size: 0x3c
    function autoexec __init__system__() {
        system::register(#"damagefeedback", &__init__, undefined, undefined);
    }

    // Namespace damagefeedback/damagefeedback_shared
    // Params 0, eflags: 0x0
    // Checksum 0x152e3002, Offset: 0x1b8
    // Size: 0x2c
    function __init__() {
        callback::on_connect(&on_player_connect);
    }

    // Namespace damagefeedback/damagefeedback_shared
    // Params 0, eflags: 0x0
    // Checksum 0xada8b523, Offset: 0x1f0
    // Size: 0x1ac
    function on_player_connect() {
        if (sessionmodeiszombiesgame()) {
            self.hud_damagefeedback = newdebughudelem(self);
            self.hud_damagefeedback.horzalign = "<dev string:x30>";
            self.hud_damagefeedback.vertalign = "<dev string:x37>";
            self.hud_damagefeedback.x = -11;
            self.hud_damagefeedback.y = -11;
            self.hud_damagefeedback.alpha = 0;
            self.hud_damagefeedback.archived = 1;
            self.hud_damagefeedback setshader(#"damage_feedback", 22, 44);
            self.hud_damagefeedback_additional = newdebughudelem(self);
            self.hud_damagefeedback_additional.horzalign = "<dev string:x30>";
            self.hud_damagefeedback_additional.vertalign = "<dev string:x37>";
            self.hud_damagefeedback_additional.x = -12;
            self.hud_damagefeedback_additional.y = -12;
            self.hud_damagefeedback_additional.alpha = 0;
            self.hud_damagefeedback_additional.archived = 1;
            self.hud_damagefeedback_additional setshader(#"damage_feedback", 24, 48);
        }
    }

#/

// Namespace damagefeedback/damagefeedback_shared
// Params 1, eflags: 0x0
// Checksum 0x220e910e, Offset: 0x3a8
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
// Checksum 0xbbd99ae4, Offset: 0x448
// Size: 0x14a
function play_hit_alert_sfx(mod, inflictor, perkfeedback, weapon, victim, psoffsettime, shitloc, fatal, idflags) {
    if (sessionmodeiscampaigngame()) {
        hitalias = hit_alert_sfx_cp(mod, inflictor, perkfeedback, weapon, victim, psoffsettime, shitloc);
    }
    if (sessionmodeismultiplayergame() || sessionmodeiswarzonegame()) {
        hitalias = hit_alert_sfx_mp(mod, inflictor, perkfeedback, weapon, victim, psoffsettime, shitloc, fatal, idflags);
    }
    if (sessionmodeiszombiesgame()) {
        hitalias = hit_alert_sfx_zm(mod, inflictor, perkfeedback, weapon, victim, psoffsettime, shitloc);
    }
    return hitalias;
}

// Namespace damagefeedback/damagefeedback_shared
// Params 7, eflags: 0x0
// Checksum 0xb8cfc214, Offset: 0x5a0
// Size: 0x210
function hit_alert_sfx_cp(mod, inflictor, perkfeedback, weapon, victim, psoffsettime, shitloc) {
    hitalias = undefined;
    suffix = "";
    if (should_play_sound(mod)) {
        if (isdefined(level.growing_hitmarker) && isdefined(victim)) {
            damagestage = damage_feedback_get_stage(victim);
        }
        if (damage_feedback_get_dead(victim, mod, weapon, damagestage)) {
            suffix = "_kill";
        }
        if (isdefined(victim.archetype) && victim.archetype == "robot") {
            hitalias = #"chr_hitmarker_robot";
        } else if (isdefined(victim.archetype) && (victim.archetype == "human" || victim.archetype == "human_riotshield" || victim.archetype == "human_rpg" || victim.archetype == "civilian")) {
            hitalias = #"chr_hitmarker_human";
        } else if (isbot(victim)) {
            hitalias = #"chr_hitmarker_human";
        } else if (isplayer(victim)) {
            hitalias = #"chr_hitmarker_human";
        }
        if (isdefined(hitalias)) {
            hitalias += suffix;
        }
    }
    return hitalias;
}

// Namespace damagefeedback/damagefeedback_shared
// Params 9, eflags: 0x0
// Checksum 0xd8cae3c, Offset: 0x7b8
// Size: 0x6ae
function hit_alert_sfx_mp(mod, inflictor, perkfeedback, weapon, victim, psoffsettime, shitloc, fatal, idflags) {
    hitalias = undefined;
    if (!isdefined(weapon)) {
        return;
    }
    if (should_play_sound(mod)) {
        if (isdefined(weapon.hitsound) && weapon.hitsound != "") {
            hitalias = weapon.hitsound;
        } else if (weapon.grappleweapon) {
            hitalias = #"hash_671bc9a2de453f2e";
        } else if (isvehicle(victim)) {
            hitalias = #"hash_2ce81d103e923201";
        } else if (isdefined(victim) && isdefined(victim.victimsoundmod)) {
            switch (victim.victimsoundmod) {
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
        } else if (isdefined(inflictor) && isdefined(inflictor.soundmod)) {
            switch (inflictor.soundmod) {
            case #"player":
                if (isdefined(idflags) && idflags & 2048 && isdefined(victim)) {
                    if (isdefined(victim.var_dec85f5f)) {
                        hitalias = #"mpl_hit_alert_armor_broke";
                    } else {
                        hitalias = #"mpl_hit_alert";
                    }
                } else if (isdefined(victim) && isdefined(victim.isaiclone) && victim.isaiclone) {
                    hitalias = #"mpl_hit_alert_clone";
                } else if (isdefined(victim) && isdefined(victim.isaiclone) && victim.isaiclone) {
                    hitalias = #"mpl_hit_alert_clone";
                } else if (isdefined(victim) && isdefined(victim.var_a541ee78) && victim.var_a541ee78) {
                    hitalias = #"mpl_hit_alert_rad";
                } else if (isdefined(victim) && isplayer(victim) && isdefined(victim.carryobject) && isdefined(victim.carryobject.hitsound) && isdefined(perkfeedback) && perkfeedback == "armor") {
                    hitalias = victim.carryobject.hitsound;
                } else if (mod == "MOD_BURNED") {
                    hitalias = #"mpl_hit_alert_burn";
                } else if (isdefined(fatal) && fatal) {
                    if (weapons::isheadshot(shitloc, mod)) {
                        hitalias = #"hash_616dd8ea01d089ac";
                    } else {
                        hitalias = #"hash_31e38d8520839566";
                    }
                } else if (weapons::isheadshot(shitloc, mod)) {
                    hitalias = #"hash_29ca1afa9209bfc6";
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
        } else if (mod == "MOD_BURNED" || mod == "MOD_DOT") {
            hitalias = #"mpl_hit_alert_burn";
        } else {
            hitalias = #"mpl_hit_alert";
        }
    }
    if (isdefined(weapon.hitsound) && weapon.hitsound != "") {
        hitalias = weapon.hitsound;
    }
    return hitalias;
}

// Namespace damagefeedback/damagefeedback_shared
// Params 7, eflags: 0x0
// Checksum 0x56ab24ee, Offset: 0xe70
// Size: 0x4e
function hit_alert_sfx_zm(mod, inflictor, perkfeedback, weapon, victim, psoffsettime, shitloc) {
    hitalias = undefined;
    return hitalias;
}

// Namespace damagefeedback/damagefeedback_shared
// Params 2, eflags: 0x0
// Checksum 0x10a1d8b7, Offset: 0xec8
// Size: 0x7e
function function_89ab784(weapon, mod) {
    if (isdefined(weapon) && isdefined(weapon.var_2e32def5) && weapon.var_2e32def5) {
        return true;
    }
    if (isdefined(weapon) && weapon === level.shockrifleweapon && mod === "MOD_DOT") {
        return true;
    }
    return false;
}

// Namespace damagefeedback/damagefeedback_shared
// Params 9, eflags: 0x0
// Checksum 0x561a18df, Offset: 0xf50
// Size: 0x66e
function update(mod, inflictor, perkfeedback, weapon, victim, psoffsettime, shitloc, fatal, idflags) {
    if (!isplayer(self)) {
        return;
    }
    if (isdefined(self.nohitmarkers) && self.nohitmarkers) {
        return 0;
    }
    if (isdefined(weapon) && weapon == getweapon(#"recon_car") && isdefined(victim) && isdefined(victim.owner) && inflictor === victim.owner) {
        return;
    }
    if (isdefined(weapon) && isdefined(weapon.nohitmarker) && weapon.nohitmarker) {
        return;
    }
    if ((mod === "MOD_DOT" || mod === "MOD_DOT_SELF") && !isdefined(self.var_74a21aed)) {
        return;
    }
    if (!isdefined(self.lasthitmarkertime)) {
        self.lasthitmarkertimes = [];
        self.lasthitmarkertime = 0;
        self.lasthitmarkeroffsettime = 0;
    }
    if (isdefined(psoffsettime)) {
        victim_id = victim getentitynumber();
        if (!isdefined(self.lasthitmarkertimes[victim_id])) {
            self.lasthitmarkertimes[victim_id] = 0;
        }
        if (self.lasthitmarkertime == gettime()) {
            if (self.lasthitmarkertimes[victim_id] === psoffsettime) {
                return;
            }
        }
        self.lasthitmarkeroffsettime = psoffsettime;
        self.lasthitmarkertimes[victim_id] = psoffsettime;
    } else if (self.lasthitmarkertime == gettime()) {
        return;
    }
    self.lasthitmarkertime = gettime();
    hitalias = play_hit_alert_sfx(mod, inflictor, perkfeedback, weapon, victim, psoffsettime, shitloc, fatal, idflags);
    if (isdefined(victim) && isdefined(victim.isaiclone) && victim.isaiclone) {
        self playhitmarker(hitalias);
        return;
    }
    damagestage = 1;
    if (isdefined(level.growing_hitmarker) && isdefined(victim) && (sessionmodeiscampaigngame() || isplayer(victim))) {
        damagestage = damage_feedback_get_stage(victim);
    }
    var_144f0193 = function_89ab784(weapon, mod);
    if (isdefined(victim) && isdefined(victim.var_c0cd58ea) && victim.var_c0cd58ea && var_144f0193) {
        return;
    }
    self playhitmarker(hitalias, damagestage, perkfeedback, damagestage == 5, var_144f0193);
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
// Params 1, eflags: 0x0
// Checksum 0x708123f8, Offset: 0x15c8
// Size: 0xdc
function damage_feedback_get_stage(victim) {
    if (isdefined(victim.laststand) && victim.laststand) {
        return 5;
    }
    if (victim.health / victim.maxhealth > 0.74) {
        return 1;
    }
    if (victim.health / victim.maxhealth > 0.49) {
        return 2;
    }
    if (victim.health / victim.maxhealth > 0.24) {
        return 3;
    }
    if (victim.health > 0) {
        return 4;
    }
    return 5;
}

// Namespace damagefeedback/damagefeedback_shared
// Params 4, eflags: 0x0
// Checksum 0x4dede1ac, Offset: 0x16b0
// Size: 0xe6
function damage_feedback_get_dead(victim, mod, weapon, stage) {
    return stage == 5 && (mod == "MOD_BULLET" || mod == "MOD_RIFLE_BULLET" || mod == "MOD_PISTOL_BULLET" || mod == "MOD_HEAD_SHOT" || mod == "MOD_BURNED" || mod == "MOD_DOT" || mod == "MOD_MELEE_WEAPON_BUTT") && !weapon.isheavyweapon && !killstreaks::is_killstreak_weapon(weapon);
}

/#

    // Namespace damagefeedback/damagefeedback_shared
    // Params 3, eflags: 0x0
    // Checksum 0xac586bcd, Offset: 0x17a0
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
    // Checksum 0x21f48bb7, Offset: 0x1970
    // Size: 0x96
    function kill_hitmarker_fade() {
        if (!isdefined(self.hud_damagefeedback)) {
            return;
        }
        self notify(#"kill_hitmarker_fade");
        self endon(#"kill_hitmarker_fade");
        self endon(#"disconnect");
        self.hud_damagefeedback.alpha = 1;
        wait 0.25;
        self.hud_damagefeedback fadeovertime(0.3);
        self.hud_damagefeedback.alpha = 0;
    }

#/

// Namespace damagefeedback/damagefeedback_shared
// Params 3, eflags: 0x0
// Checksum 0x981b61ec, Offset: 0x1a10
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
// Checksum 0x2793ac98, Offset: 0x1b70
// Size: 0xb6
function dodamagefeedback(weapon, einflictor, idamage, smeansofdeath) {
    if (!isdefined(weapon)) {
        return false;
    }
    if (isdefined(weapon.nohitmarker) && weapon.nohitmarker) {
        return false;
    }
    if (level.allowhitmarkers == 0) {
        return false;
    }
    if (level.allowhitmarkers == 1) {
        if (isdefined(smeansofdeath) && isdefined(idamage)) {
            if (istacticalhitmarker(weapon, smeansofdeath, idamage)) {
                return false;
            }
        }
    }
    return true;
}

// Namespace damagefeedback/damagefeedback_shared
// Params 3, eflags: 0x0
// Checksum 0x5e81da50, Offset: 0x1c30
// Size: 0x80
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

