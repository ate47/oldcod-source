#using script_396f7d71538c9677;
#using scripts\core_common\battlechatter;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\globallogic\globallogic_score;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\sound_shared;
#using scripts\core_common\util_shared;

#namespace smokegrenade;

// Namespace smokegrenade/smokegrenade
// Params 0, eflags: 0x0
// Checksum 0xd242f657, Offset: 0x188
// Size: 0x154
function init_shared() {
    level.willypetedamageradius = 300;
    level.willypetedamageheight = 128;
    level.smokegrenadeduration = 8;
    level.smokegrenadedissipation = 4;
    level.smokegrenadetotaltime = level.smokegrenadeduration + level.smokegrenadedissipation;
    level.fx_smokegrenade_single = "smoke_center";
    level.smoke_grenade_triggers = [];
    clientfield::register("allplayers", "inenemysmoke", 14000, 1, "int");
    clientfield::register("allplayers", "insmoke", 16000, 2, "int");
    clientfield::register("scriptmover", "smoke_state", 16000, 1, "int");
    globallogic_score::register_kill_callback(getweapon(#"willy_pete"), &function_b4a975f1);
}

// Namespace smokegrenade/smokegrenade
// Params 1, eflags: 0x0
// Checksum 0xb4f9029, Offset: 0x2e8
// Size: 0x66
function function_79d42bea(weapon) {
    if (!isdefined(weapon.customsettings)) {
        return 128;
    }
    var_b0b958b3 = getscriptbundle(weapon.customsettings);
    return isdefined(var_b0b958b3.var_40dfefd1) ? var_b0b958b3.var_40dfefd1 : 128;
}

// Namespace smokegrenade/smokegrenade
// Params 1, eflags: 0x0
// Checksum 0xdb578ade, Offset: 0x358
// Size: 0x72
function function_f199623f(weapon) {
    if (!isdefined(weapon.customsettings)) {
        return level.smokegrenadeduration;
    }
    var_b0b958b3 = getscriptbundle(weapon.customsettings);
    return isdefined(var_b0b958b3.smokegrenadeduration) ? var_b0b958b3.smokegrenadeduration : level.smokegrenadeduration;
}

// Namespace smokegrenade/smokegrenade
// Params 1, eflags: 0x0
// Checksum 0xd38e508f, Offset: 0x3d8
// Size: 0x72
function function_184e15d2(weapon) {
    if (!isdefined(weapon.customsettings)) {
        return level.smokegrenadedissipation;
    }
    var_b0b958b3 = getscriptbundle(weapon.customsettings);
    return isdefined(var_b0b958b3.smokegrenadedissipation) ? var_b0b958b3.smokegrenadedissipation : level.smokegrenadedissipation;
}

// Namespace smokegrenade/smokegrenade
// Params 5, eflags: 0x0
// Checksum 0xe1e0248a, Offset: 0x458
// Size: 0x16c
function watchsmokegrenadedetonation(owner, statweapon, smokeweapon, duration, totaltime) {
    self endon(#"trophy_destroyed");
    if (isplayer(owner)) {
        owner stats::function_e24eec31(statweapon, #"used", 1);
    }
    waitresult = self waittill(#"explode", #"death");
    if (waitresult._notify != "explode") {
        return;
    }
    onefoot = (0, 0, 12);
    startpos = waitresult.position + onefoot;
    smokedetonate(owner, statweapon, smokeweapon, waitresult.position, function_79d42bea(smokeweapon), totaltime, duration);
    damageeffectarea(owner, startpos, smokeweapon.explosionradius, level.willypetedamageheight);
}

// Namespace smokegrenade/smokegrenade
// Params 7, eflags: 0x0
// Checksum 0x447aee16, Offset: 0x5d0
// Size: 0x1d8
function smokedetonate(owner, statweapon, smokeweapon, position, radius, effectlifetime, smokeblockduration) {
    dir_up = (0, 0, 1);
    if (!isdefined(effectlifetime)) {
        effectlifetime = 10;
    }
    ent = spawn("script_model", position);
    if (isdefined(owner)) {
        ent setteam(owner.team);
        if (isplayer(owner)) {
            ent setowner(owner);
        }
    }
    if (ent function_c7b93adf(smokeweapon)) {
        ent smokeblocksight(radius);
    }
    ent thread spawnsmokegrenadetrigger(smokeweapon, smokeblockduration, owner);
    if (isdefined(owner)) {
        owner.smokegrenadetime = gettime();
        owner.smokegrenadeposition = position;
    }
    thread playsmokesound(position, smokeblockduration, statweapon.projsmokestartsound, statweapon.projsmokeendsound, statweapon.projsmokeloopsound);
    if (sessionmodeiscampaigngame() && self.var_3791d005 !== 0) {
        badplace_cylinder("", effectlifetime, position, radius, radius, "axis", "allies", "neutral");
    }
    return ent;
}

// Namespace smokegrenade/smokegrenade
// Params 4, eflags: 0x0
// Checksum 0x6f500d5b, Offset: 0x7b0
// Size: 0x94
function damageeffectarea(owner, position, radius, height) {
    effectarea = spawn("trigger_radius", position, 0, radius, height);
    if (isdefined(level.dogsonflashdogs)) {
        owner thread [[ level.dogsonflashdogs ]](effectarea);
    }
    effectarea delete();
}

// Namespace smokegrenade/smokegrenade
// Params 1, eflags: 0x0
// Checksum 0x9dfd90f6, Offset: 0x850
// Size: 0x64
function smokeblocksight(radius) {
    fxblocksight(self, radius);
    /#
        if (getdvarint(#"scr_smokegrenade_debug", 0)) {
            self thread function_f02a8a0b(radius);
        }
    #/
}

// Namespace smokegrenade/smokegrenade
// Params 1, eflags: 0x0
// Checksum 0x4a0cef36, Offset: 0x8c0
// Size: 0x68
function function_f02a8a0b(radius) {
    self endon(#"death");
    /#
        while (true) {
            sphere(self.origin, radius, (1, 0, 0), 0.25, 0, 20, 15);
            wait 0.75;
        }
    #/
}

// Namespace smokegrenade/smokegrenade
// Params 1, eflags: 0x0
// Checksum 0x8518c380, Offset: 0x930
// Size: 0x62
function function_c7b93adf(weapon) {
    if (!isdefined(weapon.customsettings)) {
        return 1;
    }
    var_b0b958b3 = getscriptbundle(weapon.customsettings);
    return is_true(var_b0b958b3.var_afa9a0c4);
}

// Namespace smokegrenade/smokegrenade
// Params 1, eflags: 0x0
// Checksum 0x237b2a95, Offset: 0x9a0
// Size: 0x54
function waitanddelete(time) {
    self ghost();
    self endon(#"death");
    wait time;
    self delete();
}

// Namespace smokegrenade/smokegrenade
// Params 3, eflags: 0x0
// Checksum 0x1c6476c0, Offset: 0xa00
// Size: 0x1b4
function spawnsmokegrenadetrigger(smokeweapon, duration, owner) {
    team = self.team;
    radius = function_79d42bea(smokeweapon);
    trigger = spawn("trigger_radius", self.origin, 0, radius, radius);
    trigger.owner = owner;
    self.smoketrigger = trigger;
    if (!isdefined(level.smoke_grenade_triggers)) {
        level.smoke_grenade_triggers = [];
    } else if (!isarray(level.smoke_grenade_triggers)) {
        level.smoke_grenade_triggers = array(level.smoke_grenade_triggers);
    }
    level.smoke_grenade_triggers[level.smoke_grenade_triggers.size] = trigger;
    if (function_579815a1(smokeweapon)) {
        thread function_8b6ddd71(self, smokeweapon);
    }
    self waittilltimeout(duration, #"death");
    arrayremovevalue(level.smoke_grenade_triggers, trigger);
    if (isdefined(self)) {
        self thread waitanddelete(1);
    }
    if (isdefined(trigger)) {
        trigger delete();
    }
}

// Namespace smokegrenade/smokegrenade
// Params 5, eflags: 0x0
// Checksum 0x60d433f1, Offset: 0xbc0
// Size: 0x24e
function function_b4a975f1(attacker, victim, *weapon, attackerweapon, *meansofdeath) {
    if (!isdefined(weapon) || !isdefined(attackerweapon)) {
        return false;
    }
    smoketrigger = attackerweapon function_367ce00e();
    if (isdefined(smoketrigger)) {
        if (weapon === smoketrigger.owner) {
            if (isdefined(meansofdeath) && meansofdeath !== level.weaponsigblade) {
                if (!isdefined(smoketrigger.var_25db02aa)) {
                    smoketrigger.kills = (isdefined(smoketrigger.kills) ? smoketrigger.kills : 0) + 1;
                    var_9194a036 = battlechatter::mpdialog_value("muteSmokeSuccessLineCount", 0);
                    if (smoketrigger.kills == (isdefined(var_9194a036) ? var_9194a036 : 3)) {
                        weapon battlechatter::play_gadget_success(getweapon(#"willy_pete"), undefined, attackerweapon, undefined);
                        smoketrigger.var_25db02aa = 1;
                    }
                }
            }
            return true;
        } else if (isdefined(smoketrigger.owner) && isplayer(smoketrigger.owner) && isalive(smoketrigger.owner) && util::function_fbce7263(smoketrigger.owner.team, attackerweapon.team)) {
            if (level.teambased) {
                scoreevents::processscoreevent(#"smoke_assist", smoketrigger.owner, undefined, getweapon(#"willy_pete"));
            }
        }
    }
    return false;
}

// Namespace smokegrenade/smokegrenade
// Params 1, eflags: 0x0
// Checksum 0xb8dcd53, Offset: 0xe18
// Size: 0xbe
function function_367ce00e(skiptrigger) {
    foreach (trigger in level.smoke_grenade_triggers) {
        if (self istouching(trigger)) {
            if (isdefined(skiptrigger)) {
                if (skiptrigger != trigger) {
                    return trigger;
                }
                continue;
            }
            return trigger;
        }
    }
    return undefined;
}

// Namespace smokegrenade/smokegrenade
// Params 2, eflags: 0x0
// Checksum 0xe316b453, Offset: 0xee0
// Size: 0xe0
function function_4cc4db89(team, skiptrigger) {
    foreach (trigger in level.smoke_grenade_triggers) {
        if (!trigger util::isenemyteam(team) && self istouching(trigger)) {
            if (isdefined(skiptrigger)) {
                if (skiptrigger != trigger) {
                    return trigger;
                }
                continue;
            }
            return trigger;
        }
    }
    return undefined;
}

// Namespace smokegrenade/smokegrenade
// Params 1, eflags: 0x0
// Checksum 0xd813d438, Offset: 0xfc8
// Size: 0x130
function function_50ef4b12(weapon) {
    if (getweapon(#"eq_smoke") == weapon.rootweapon) {
        return true;
    }
    if (getweapon(#"willy_pete") == weapon.rootweapon) {
        return true;
    }
    if (getweapon(#"hash_615e6c73989c85b4") == weapon.rootweapon) {
        return true;
    }
    if (getweapon(#"hash_7a88daffaea7a9cf") == weapon.rootweapon) {
        return true;
    }
    if (getweapon(#"spectre_grenade") == weapon.rootweapon) {
        return true;
    }
    if (getweapon(#"hash_34fa23e332e34886") == weapon.rootweapon) {
        return true;
    }
    return false;
}

// Namespace smokegrenade/smokegrenade
// Params 1, eflags: 0x4
// Checksum 0xf5f015c2, Offset: 0x1100
// Size: 0x78
function private function_579815a1(weapon) {
    if (!isdefined(weapon.customsettings)) {
        return false;
    }
    var_e6fbac16 = getscriptbundle(weapon.customsettings);
    if (var_e6fbac16.var_8ceb6ac8 === 1) {
        return true;
    }
    if (var_e6fbac16.var_6942aad6 === 1) {
        return true;
    }
    return false;
}

// Namespace smokegrenade/smokegrenade
// Params 2, eflags: 0x0
// Checksum 0xf3a6f8ca, Offset: 0x1180
// Size: 0x16a
function function_87d0a127(grenadeent, *smokeweapon) {
    if (!isdefined(smokeweapon.smoketrigger)) {
        return;
    }
    grenadeteam = smokeweapon.team;
    owner = smokeweapon.smoketrigger.owner;
    while (true) {
        waitresult = smokeweapon waittilltimeout(0.25, #"death");
        if (isdefined(owner)) {
            if (isdefined(smokeweapon) && isdefined(smokeweapon.smoketrigger) && owner istouching(smokeweapon.smoketrigger) && waitresult._notify == #"timeout") {
                owner clientfield::set("inenemysmoke", 1);
            } else {
                owner clientfield::set("inenemysmoke", 0);
            }
        }
        if (!isdefined(owner) || !isdefined(smokeweapon) || waitresult._notify != "timeout") {
            break;
        }
    }
}

// Namespace smokegrenade/smokegrenade
// Params 2, eflags: 0x0
// Checksum 0xef73222f, Offset: 0x12f8
// Size: 0x2f4
function function_8b6ddd71(grenadeent, *smokeweapon) {
    if (!isdefined(smokeweapon.smoketrigger)) {
        return;
    }
    grenadeteam = smokeweapon.team;
    while (true) {
        waitresult = smokeweapon waittilltimeout(0.25, #"death");
        foreach (player in level.players) {
            if (!isdefined(player)) {
                continue;
            }
            curval = player clientfield::get("insmoke");
            if (isdefined(smokeweapon) && isdefined(smokeweapon.smoketrigger) && player istouching(smokeweapon.smoketrigger) && waitresult._notify == #"timeout") {
                if (player util::isenemyteam(grenadeteam)) {
                    player clientfield::set("insmoke", curval | 1);
                } else {
                    player clientfield::set("insmoke", curval | 2);
                }
                continue;
            }
            if (player util::isenemyteam(grenadeteam)) {
                mask = 1;
            } else {
                mask = 2;
            }
            if (curval & mask) {
                trig = undefined;
                if (isdefined(smokeweapon)) {
                    trig = function_4cc4db89(grenadeteam, smokeweapon.smoketrigger);
                }
                if (!isdefined(trig)) {
                    player clientfield::set("insmoke", curval & ~mask);
                }
            }
        }
        if (!isdefined(smokeweapon) || waitresult._notify != "timeout" || !isdefined(smokeweapon.smoketrigger) && smokeweapon.item === getweapon(#"spectre_grenade")) {
            break;
        }
    }
}

// Namespace smokegrenade/grenade_fire
// Params 1, eflags: 0x40
// Checksum 0xfbe734be, Offset: 0x15f8
// Size: 0x204
function event_handler[grenade_fire] function_debb0d4e(eventstruct) {
    weapon = eventstruct.weapon;
    if (!function_50ef4b12(weapon)) {
        return;
    }
    if (weapon.rootweapon == getweapon(#"eq_smoke")) {
        weapon_smoke = getweapon(#"eq_smoke");
    } else if (weapon.rootweapon == getweapon(#"hash_34fa23e332e34886")) {
        weapon_smoke = getweapon(#"hash_34fa23e332e34886");
    } else if (weapon.rootweapon == getweapon(#"spectre_grenade")) {
        weapon_smoke = getweapon(#"spectre_grenade");
    } else {
        weapon_smoke = getweapon(#"willy_pete");
    }
    duration = function_f199623f(weapon_smoke);
    totaltime = duration + function_184e15d2(weapon_smoke);
    grenade = eventstruct.projectile;
    if (grenade util::ishacked()) {
        return;
    }
    grenade thread watchsmokegrenadedetonation(self, weapon_smoke, weapon_smoke, duration, totaltime);
}

// Namespace smokegrenade/smokegrenade
// Params 5, eflags: 0x0
// Checksum 0x74541b2f, Offset: 0x1808
// Size: 0x13c
function playsmokesound(position, duration, startsound, stopsound, loopsound) {
    smokesound = spawn("script_origin", (0, 0, 1));
    if (isdefined(smokesound)) {
        smokesound endon(#"death");
        smokesound.origin = position;
        if (isdefined(startsound)) {
            smokesound playsound(startsound);
        }
        if (isdefined(loopsound)) {
            smokesound playloopsound(loopsound);
        }
        if (duration > 0.5) {
            wait duration - 0.5;
        }
        if (isdefined(stopsound)) {
            thread sound::play_in_space(stopsound, position);
        }
        smokesound stoploopsound(0.5);
        wait 0.5;
        smokesound delete();
    }
}

