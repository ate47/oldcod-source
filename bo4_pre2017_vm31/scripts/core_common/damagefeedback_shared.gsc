#using scripts/core_common/abilities/gadgets/gadget_armor;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/killstreaks_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/weapons_shared;

#namespace damagefeedback;

// Namespace damagefeedback/damagefeedback_shared
// Params 0, eflags: 0x2
// Checksum 0xf69d14fa, Offset: 0x4d8
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("damagefeedback", &__init__, undefined, undefined);
}

// Namespace damagefeedback/damagefeedback_shared
// Params 0, eflags: 0x0
// Checksum 0xf761ad5d, Offset: 0x518
// Size: 0x44
function __init__() {
    callback::on_start_gametype(&init);
    callback::on_connect(&on_player_connect);
}

// Namespace damagefeedback/damagefeedback_shared
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x568
// Size: 0x4
function init() {
    
}

// Namespace damagefeedback/damagefeedback_shared
// Params 0, eflags: 0x0
// Checksum 0x26d9a695, Offset: 0x578
// Size: 0x1dc
function on_player_connect() {
    if (!sessionmodeismultiplayergame() && !sessionmodeiscampaigngame()) {
        self.hud_damagefeedback = newdamageindicatorhudelem(self);
        self.hud_damagefeedback.horzalign = "center";
        self.hud_damagefeedback.vertalign = "middle";
        self.hud_damagefeedback.x = -11;
        self.hud_damagefeedback.y = -11;
        self.hud_damagefeedback.alpha = 0;
        self.hud_damagefeedback.archived = 1;
        self.hud_damagefeedback setshader("damage_feedback", 22, 44);
        self.hud_damagefeedback_additional = newdamageindicatorhudelem(self);
        self.hud_damagefeedback_additional.horzalign = "center";
        self.hud_damagefeedback_additional.vertalign = "middle";
        self.hud_damagefeedback_additional.x = -12;
        self.hud_damagefeedback_additional.y = -12;
        self.hud_damagefeedback_additional.alpha = 0;
        self.hud_damagefeedback_additional.archived = 1;
        self.hud_damagefeedback_additional setshader("damage_feedback", 24, 48);
    }
}

// Namespace damagefeedback/damagefeedback_shared
// Params 1, eflags: 0x0
// Checksum 0x10d11f69, Offset: 0x760
// Size: 0x66
function should_play_sound(mod) {
    if (!isdefined(mod)) {
        return false;
    }
    switch (mod) {
    case #"mod_crush":
    case #"mod_grenade_splash":
    case #"mod_hit_by_object":
    case #"mod_melee":
    case #"mod_melee_assassinate":
    case #"mod_melee_weapon_butt":
        return false;
    }
    return true;
}

// Namespace damagefeedback/damagefeedback_shared
// Params 7, eflags: 0x0
// Checksum 0x64dc27a0, Offset: 0x7d0
// Size: 0x11c
function play_hit_alert_sfx(mod, inflictor, perkfeedback, weapon, victim, psoffsettime, shitloc) {
    if (sessionmodeiscampaigngame()) {
        hitalias = hit_alert_sfx_cp(mod, inflictor, perkfeedback, weapon, victim, psoffsettime, shitloc);
    }
    if (sessionmodeismultiplayergame()) {
        hitalias = hit_alert_sfx_mp(mod, inflictor, perkfeedback, weapon, victim, psoffsettime, shitloc);
    }
    if (sessionmodeiszombiesgame()) {
        hitalias = hit_alert_sfx_zm(mod, inflictor, perkfeedback, weapon, victim, psoffsettime, shitloc);
    }
    return hitalias;
}

// Namespace damagefeedback/damagefeedback_shared
// Params 7, eflags: 0x0
// Checksum 0x6429b143, Offset: 0x8f8
// Size: 0x1da
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
            hitalias = "chr_hitmarker_robot";
        } else if (victim.archetype == "human" || victim.archetype == "human_riotshield" || victim.archetype == "human_rpg" || isdefined(victim.archetype) && victim.archetype == "civilian") {
            hitalias = "chr_hitmarker_human";
        }
        if (isdefined(hitalias)) {
            hitalias += suffix;
        }
    }
    return hitalias;
}

// Namespace damagefeedback/damagefeedback_shared
// Params 7, eflags: 0x0
// Checksum 0x3208e3e6, Offset: 0xae0
// Size: 0x3d0
function hit_alert_sfx_mp(mod, inflictor, perkfeedback, weapon, victim, psoffsettime, shitloc) {
    hitalias = undefined;
    if (should_play_sound(mod)) {
        if (isdefined(victim) && isdefined(victim.victimsoundmod)) {
            switch (victim.victimsoundmod) {
            case #"safeguard_robot":
                hitalias = "mpl_hit_alert_escort";
                break;
            default:
                hitalias = "mpl_hit_alert";
                break;
            }
        } else if (isdefined(inflictor) && isdefined(inflictor.soundmod)) {
            switch (inflictor.soundmod) {
            case #"player":
                if (isdefined(victim.isaiclone) && isdefined(victim) && victim.isaiclone) {
                    hitalias = "mpl_hit_alert_clone";
                } else if (isdefined(victim) && isplayer(victim) && victim flagsys::get("gadget_armor_on") && armor::armor_should_take_damage(inflictor, weapon, mod, shitloc)) {
                    hitalias = "mpl_hit_alert_armor";
                } else if (isdefined(victim) && isplayer(victim) && isdefined(victim.carryobject) && isdefined(victim.carryobject.hitsound) && isdefined(perkfeedback) && perkfeedback == "armor") {
                    hitalias = victim.carryobject.hitsound;
                } else if (mod == "MOD_BURNED") {
                    hitalias = "mpl_hit_alert_burn";
                } else {
                    hitalias = "mpl_hit_alert";
                }
                break;
            case #"heatwave":
                hitalias = "mpl_hit_alert_heatwave";
                break;
            case #"heli":
                hitalias = "mpl_hit_alert_air";
                break;
            case #"hpm":
                hitalias = "mpl_hit_alert_hpm";
                break;
            case #"taser_spike":
                hitalias = "mpl_hit_alert_taser_spike";
                break;
            case #"dog":
            case #"straferun":
                break;
            case #"firefly":
                hitalias = "mpl_hit_alert_firefly";
                break;
            case #"drone_land":
                hitalias = "mpl_hit_alert_air";
                break;
            case #"mini_turret":
                hitalias = "mpl_hit_alert_quiet";
                break;
            case #"raps":
                hitalias = "mpl_hit_alert_air";
                break;
            case #"default_loud":
                hitalias = "mpl_hit_heli_gunner";
                break;
            default:
                hitalias = "mpl_hit_alert";
                break;
            }
        } else if (mod == "MOD_BURNED") {
            hitalias = "mpl_hit_alert_burn";
        } else {
            hitalias = "mpl_hit_alert";
        }
    }
    return hitalias;
}

// Namespace damagefeedback/damagefeedback_shared
// Params 7, eflags: 0x0
// Checksum 0xe59bdd6d, Offset: 0xeb8
// Size: 0x50
function hit_alert_sfx_zm(mod, inflictor, perkfeedback, weapon, victim, psoffsettime, shitloc) {
    hitalias = undefined;
    return hitalias;
}

// Namespace damagefeedback/damagefeedback_shared
// Params 7, eflags: 0x0
// Checksum 0xdb2913a2, Offset: 0xf10
// Size: 0x538
function update(mod, inflictor, perkfeedback, weapon, victim, psoffsettime, shitloc) {
    if (!isplayer(self)) {
        return;
    }
    if (isdefined(self.nohitmarkers) && self.nohitmarkers) {
        return 0;
    }
    if (isdefined(weapon.nohitmarker) && isdefined(weapon) && weapon.nohitmarker) {
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
    hitalias = play_hit_alert_sfx(mod, inflictor, perkfeedback, weapon, victim, psoffsettime, shitloc);
    if (isdefined(victim.isaiclone) && isdefined(victim) && victim.isaiclone) {
        self playhitmarker(hitalias);
        return;
    }
    damagestage = 1;
    if (sessionmodeiscampaigngame() || isdefined(level.growing_hitmarker) && isdefined(victim) && isplayer(victim)) {
        damagestage = damage_feedback_get_stage(victim);
    }
    self playhitmarker(hitalias, damagestage, perkfeedback, damage_feedback_get_dead(victim, mod, weapon, damagestage));
    if (isdefined(perkfeedback)) {
        if (isdefined(self.hud_damagefeedback_additional)) {
            switch (perkfeedback) {
            case #"flakjacket":
                self.hud_damagefeedback_additional setshader("damage_feedback_flak", 24, 48);
                break;
            case #"tacticalmask":
                self.hud_damagefeedback_additional setshader("damage_feedback_tac", 24, 48);
                break;
            case #"armor":
                self.hud_damagefeedback_additional setshader("damage_feedback_armor", 24, 48);
                break;
            }
            self.hud_damagefeedback_additional.alpha = 1;
            self.hud_damagefeedback_additional fadeovertime(1);
            self.hud_damagefeedback_additional.alpha = 0;
        }
    } else if (isdefined(self.hud_damagefeedback)) {
        self.hud_damagefeedback setshader("damage_feedback", 24, 48);
    }
    if (sessionmodeiscampaigngame() || isdefined(self.hud_damagefeedback) && isdefined(level.growing_hitmarker) && isdefined(victim) && isplayer(victim)) {
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
}

// Namespace damagefeedback/damagefeedback_shared
// Params 1, eflags: 0x0
// Checksum 0x14cbeab3, Offset: 0x1450
// Size: 0xf2
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
// Checksum 0xbfcb9a90, Offset: 0x1550
// Size: 0x9c
function damage_feedback_get_dead(victim, mod, weapon, stage) {
    return (mod == "MOD_BULLET" || mod == "MOD_RIFLE_BULLET" || mod == "MOD_PISTOL_BULLET" || stage == 5 && mod == "MOD_HEAD_SHOT") && !weapon.isheavyweapon && !killstreaks::is_killstreak_weapon(weapon);
}

// Namespace damagefeedback/damagefeedback_shared
// Params 3, eflags: 0x0
// Checksum 0x7ddaf4aa, Offset: 0x15f8
// Size: 0x1d0
function damage_feedback_growth(victim, mod, weapon) {
    if (isdefined(self.hud_damagefeedback)) {
        stage = damage_feedback_get_stage(victim);
        self.hud_damagefeedback.x = -11 + -1 * stage;
        self.hud_damagefeedback.y = -11 + -1 * stage;
        size_x = 22 + 2 * stage;
        size_y = size_x * 2;
        self.hud_damagefeedback setshader("damage_feedback", size_x, size_y);
        if (damage_feedback_get_dead(victim, mod, weapon, stage)) {
            self.hud_damagefeedback setshader("damage_feedback_glow_orange", size_x, size_y);
            self thread kill_hitmarker_fade();
            return;
        }
        self.hud_damagefeedback setshader("damage_feedback", size_x, size_y);
        self.hud_damagefeedback.alpha = 1;
        self.hud_damagefeedback fadeovertime(1);
        self.hud_damagefeedback.alpha = 0;
    }
}

// Namespace damagefeedback/damagefeedback_shared
// Params 0, eflags: 0x0
// Checksum 0x83712a2f, Offset: 0x17d0
// Size: 0x80
function kill_hitmarker_fade() {
    self notify(#"kill_hitmarker_fade");
    self endon(#"kill_hitmarker_fade");
    self endon(#"disconnect");
    self.hud_damagefeedback.alpha = 1;
    wait 0.25;
    self.hud_damagefeedback fadeovertime(0.3);
    self.hud_damagefeedback.alpha = 0;
}

// Namespace damagefeedback/damagefeedback_shared
// Params 3, eflags: 0x0
// Checksum 0x74fd7d92, Offset: 0x1858
// Size: 0x180
function update_override(icon, sound, additional_icon) {
    if (!isplayer(self)) {
        return;
    }
    self playlocalsound(sound);
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
}

// Namespace damagefeedback/damagefeedback_shared
// Params 1, eflags: 0x0
// Checksum 0x400b6bc5, Offset: 0x19e0
// Size: 0xee
function function_7fef183e(hitent) {
    if (!isplayer(self)) {
        return;
    }
    if (!isdefined(hitent)) {
        return;
    }
    if (!isplayer(hitent)) {
        return;
    }
    waitframe(1);
    if (!isdefined(self.var_3f443551)) {
        self.var_3f443551 = [];
        var_1dbcf329 = hitent getentitynumber();
        self.var_3f443551[var_1dbcf329] = 1;
        self thread function_353402e0(hitent);
        return;
    }
    var_1dbcf329 = hitent getentitynumber();
    self.var_3f443551[var_1dbcf329] = 1;
}

// Namespace damagefeedback/damagefeedback_shared
// Params 1, eflags: 0x0
// Checksum 0xd31ef1d6, Offset: 0x1ad8
// Size: 0x186
function function_353402e0(hitent) {
    self endon(#"disconnect");
    waittillframeend();
    var_e1c02941 = 0;
    value = 1;
    var_4f484664 = 0;
    for (i = 0; i < 32; i++) {
        if (isdefined(self.var_3f443551[i]) && self.var_3f443551[i] != 0) {
            var_4f484664 += value;
            var_e1c02941++;
        }
        value *= 2;
    }
    var_754ac0cd = 0;
    for (i = 33; i < 64; i++) {
        if (isdefined(self.var_3f443551[i]) && self.var_3f443551[i] != 0) {
            var_754ac0cd += value;
            var_e1c02941++;
        }
        value *= 2;
    }
    if (var_e1c02941) {
        self directionalhitindicator(var_4f484664, var_754ac0cd);
    }
    self.var_3f443551 = undefined;
    var_4f484664 = 0;
    var_754ac0cd = 0;
}

// Namespace damagefeedback/damagefeedback_shared
// Params 4, eflags: 0x0
// Checksum 0x50f0b479, Offset: 0x1c68
// Size: 0xc6
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
// Checksum 0x82472544, Offset: 0x1d38
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

