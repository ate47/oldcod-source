#using scripts\abilities\ability_player;
#using scripts\abilities\ability_power;
#using scripts\abilities\gadgets\gadget_radiation_field;
#using scripts\core_common\audio_shared;
#using scripts\core_common\bots\bot_stance;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\damage;
#using scripts\core_common\damagefeedback_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\globallogic\globallogic_score;
#using scripts\core_common\killcam_shared;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\weapons_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\weapons\weaponobjects;

#namespace shockrifle;

// Namespace shockrifle/shockrifle
// Params 0, eflags: 0x0
// Checksum 0x158feceb, Offset: 0x268
// Size: 0x1cc
function init_shared() {
    clientfield::register("toplayer", "shock_rifle_shocked", 1, 1, "int");
    clientfield::register("toplayer", "shock_rifle_damage", 1, 1, "int");
    clientfield::register("allplayers", "shock_rifle_sound", 1, 1, "int");
    level.shockrifleweapon = getweapon(#"shock_rifle");
    if (isdefined(level.shockrifleweapon.customsettings)) {
        level.var_be1d80e5 = getscriptbundle(level.shockrifleweapon.customsettings);
    } else {
        level.var_be1d80e5 = getscriptbundle("shock_rifle_custom_settings");
    }
    weaponobjects::function_f298eae6(#"shock_rifle", &function_975fc5fb, 0);
    globallogic_score::function_4f0048ef(#"shock_rifle_shock", &function_ab674881);
    callback::on_connecting(&onplayerconnect);
    callback::on_spawned(&on_player_spawned);
}

// Namespace shockrifle/shockrifle
// Params 0, eflags: 0x0
// Checksum 0x2b0fb52c, Offset: 0x440
// Size: 0x44
function on_player_spawned() {
    self clientfield::set_to_player("shock_rifle_damage", 0);
    self clientfield::set("shock_rifle_sound", 0);
}

// Namespace shockrifle/shockrifle
// Params 0, eflags: 0x0
// Checksum 0xa255165e, Offset: 0x490
// Size: 0x26
function onplayerconnect() {
    profilestart();
    self callback::on_player_killed(&onplayerkilled);
    profilestop();
}

// Namespace shockrifle/shockrifle
// Params 0, eflags: 0x0
// Checksum 0x5a3364cb, Offset: 0x4c0
// Size: 0x1c
function onplayerkilled() {
    self function_e858d6c5();
}

// Namespace shockrifle/shockrifle
// Params 5, eflags: 0x0
// Checksum 0xb490f762, Offset: 0x4e8
// Size: 0x5a
function function_ab674881(attacker, victim, var_ed5f2f94, attackerweapon, meansofdeath) {
    if (!isdefined(var_ed5f2f94) || !isdefined(attackerweapon) || var_ed5f2f94 == attackerweapon) {
        return false;
    }
    return true;
}

// Namespace shockrifle/shockrifle
// Params 1, eflags: 0x0
// Checksum 0x7d079f0e, Offset: 0x550
// Size: 0x1be
function function_975fc5fb(watcher) {
    watcher.watchforfire = 1;
    watcher.hackable = 1;
    watcher.hackertoolradius = level.equipmenthackertoolradius;
    watcher.hackertooltimems = level.equipmenthackertooltimems;
    watcher.activatefx = 1;
    watcher.ownergetsassist = 1;
    watcher.ignoredirection = 1;
    watcher.immediatedetonation = 1;
    watcher.detectiongraceperiod = 0;
    watcher.detonateradius = level.var_be1d80e5.var_d58d8e29 + 50;
    watcher.onstun = &weaponobjects::weaponstun;
    watcher.stuntime = 1;
    watcher.timeout = level.var_be1d80e5.shockduration;
    watcher.ondetonatecallback = &function_d4095326;
    watcher.activationdelay = 0;
    watcher.activatesound = #"wpn_claymore_alert";
    watcher.immunespecialty = "specialty_immunetriggershock";
    watcher.onspawn = &function_568cf04e;
    watcher.ondamage = &function_900a44ea;
    watcher.ontimeout = &function_d4095326;
    watcher.onfizzleout = &function_d4095326;
}

// Namespace shockrifle/shockrifle
// Params 1, eflags: 0x0
// Checksum 0x5818e481, Offset: 0x718
// Size: 0x4c
function function_717e3029(ent) {
    self endon(#"death");
    ent waittill(#"death");
    self function_d4095326(undefined, undefined, undefined);
}

// Namespace shockrifle/shockrifle
// Params 2, eflags: 0x0
// Checksum 0x7e5730e4, Offset: 0x770
// Size: 0x1ba
function function_568cf04e(watcher, owner) {
    self endon(#"death");
    self.protected_entities = [];
    self.hit_ents = [];
    self.var_9978fb3b = 0;
    waitresult = self waittill(#"grenade_stuck");
    if (!isdefined(waitresult.hitent)) {
        return;
    }
    if (isdefined(waitresult.hitent.isdog) && waitresult.hitent.isdog) {
        watcher.timeout = 0.75;
    } else {
        watcher.timeout = level.var_be1d80e5.shockduration;
    }
    self playsound("prj_lightning_impact_human_fatal");
    self thread function_717e3029(waitresult.hitent);
    self function_161233f(waitresult.hitent, 1);
    playfxontag("weapon/fx8_hero_sig_shockrifle_spike_active", self, "tag_fx");
    wait isdefined(level.var_be1d80e5.var_1a6bc8f2) ? level.var_be1d80e5.var_1a6bc8f2 : 0;
    self thread function_4a741f5a(watcher);
    self.owner = owner;
}

// Namespace shockrifle/shockrifle
// Params 1, eflags: 0x0
// Checksum 0x5f76c9f6, Offset: 0x938
// Size: 0x5a
function function_c75340fc(ent) {
    if (distancesquared(self.origin, ent.origin) <= level.var_be1d80e5.var_d58d8e29 * level.var_be1d80e5.var_d58d8e29) {
        return true;
    }
    return false;
}

// Namespace shockrifle/shockrifle
// Params 1, eflags: 0x0
// Checksum 0xb53a3fb, Offset: 0x9a0
// Size: 0x1ec
function function_4a741f5a(watcher) {
    self endon(#"death");
    self endon(#"hacked");
    self endon(#"kill_target_detection");
    damagearea = weaponobjects::proximityweaponobject_createdamagearea(watcher);
    up = anglestoup(self.angles);
    traceorigin = self.origin + up;
    while (self.var_9978fb3b < level.var_be1d80e5.var_e41239b1) {
        waitresult = damagearea waittill(#"trigger");
        ent = waitresult.activator;
        if (isdefined(self.detonating) && self.detonating) {
            return;
        }
        if (!weaponobjects::proximityweaponobject_validtriggerentity(watcher, ent)) {
            continue;
        }
        if (weaponobjects::proximityweaponobject_isspawnprotected(watcher, ent)) {
            continue;
        }
        if (!function_c75340fc(ent)) {
            continue;
        }
        if (function_8e6c4d51(ent)) {
            continue;
        }
        if (!isplayer(ent)) {
            continue;
        }
        if (ent damageconetrace(traceorigin, self) > 0) {
            self thread function_161233f(ent, 0);
        }
    }
    function_d4095326(undefined, undefined, undefined);
}

// Namespace shockrifle/shockrifle
// Params 1, eflags: 0x0
// Checksum 0xe341d8fe, Offset: 0xb98
// Size: 0x54
function function_8e6c4d51(ent) {
    for (i = 0; i < self.hit_ents.size; i++) {
        if (self.hit_ents[i] == ent) {
            return true;
        }
    }
    return false;
}

// Namespace shockrifle/shockrifle
// Params 2, eflags: 0x0
// Checksum 0xa1e95758, Offset: 0xbf8
// Size: 0x8e
function function_28fbd06c(ent, shockduration) {
    if (isdefined(ent.hittime) && ent.hittime + shockduration + int((isdefined(level.var_be1d80e5.var_77dc56d4) ? level.var_be1d80e5.var_77dc56d4 : 0) * 1000) > gettime()) {
        return true;
    }
    return false;
}

// Namespace shockrifle/shockrifle
// Params 0, eflags: 0x0
// Checksum 0xb2e04c4, Offset: 0xc90
// Size: 0x70
function function_a9cdeff7() {
    shockduration = level.var_be1d80e5.shockduration;
    if (isplayer(self)) {
        var_4ad4dfa5 = self function_ec2f9c7();
        if (var_4ad4dfa5) {
            shockduration *= var_4ad4dfa5;
        }
    }
    return shockduration;
}

// Namespace shockrifle/shockrifle
// Params 1, eflags: 0x0
// Checksum 0xee526148, Offset: 0xd08
// Size: 0x3c
function deleteobjective(objectiveid) {
    objective_delete(objectiveid);
    gameobjects::release_obj_id(objectiveid);
}

// Namespace shockrifle/shockrifle
// Params 1, eflags: 0x0
// Checksum 0x9364736e, Offset: 0xd50
// Size: 0x142
function function_bd25ebbc(owner) {
    if (isdefined(self.var_4073fce5)) {
        return;
    }
    obj_id = gameobjects::get_next_obj_id();
    objective_add(obj_id, "invisible", self.origin, #"shockrifle_shocked");
    objective_onentity(obj_id, self);
    objective_setvisibletoall(obj_id);
    objective_setteam(obj_id, owner getteam());
    function_eeba3a5c(obj_id, 1);
    objective_setinvisibletoplayer(obj_id, self);
    function_c3a2445a(obj_id, owner getteam(), 0);
    objective_setstate(obj_id, "active");
    self.var_4073fce5 = obj_id;
}

// Namespace shockrifle/shockrifle
// Params 0, eflags: 0x0
// Checksum 0xcb9cf203, Offset: 0xea0
// Size: 0x36
function function_e858d6c5() {
    if (!isdefined(self.var_4073fce5)) {
        return;
    }
    deleteobjective(self.var_4073fce5);
    self.var_4073fce5 = undefined;
}

// Namespace shockrifle/shockrifle
// Params 1, eflags: 0x0
// Checksum 0x4b6df853, Offset: 0xee0
// Size: 0xe0
function function_a61cc4f0(shockcharge) {
    self endon(#"death");
    self endon(#"shock_end");
    while (isdefined(self)) {
        if (self isplayerswimming()) {
            if (isdefined(shockcharge)) {
                self dodamage(10000, shockcharge.origin, shockcharge.owner, shockcharge, undefined, "MOD_UNKNOWN", 0, level.shockrifleweapon);
                return;
            }
            self dodamage(10000, self.origin, undefined, undefined, undefined, "MOD_UNKNOWN", 0, level.shockrifleweapon);
            return;
        }
        waitframe(1);
    }
}

// Namespace shockrifle/shockrifle
// Params 0, eflags: 0x0
// Checksum 0x89e8a0e0, Offset: 0xfc8
// Size: 0x3c
function watchfordeath() {
    self waittill(#"death");
    self clientfield::set("shock_rifle_sound", 0);
}

// Namespace shockrifle/shockrifle
// Params 3, eflags: 0x0
// Checksum 0x348457e4, Offset: 0x1010
// Size: 0x52e
function function_69cb71f9(shockcharge, var_41686b, shockduration) {
    self endon(#"death");
    self ability_player::function_40b227b1(1);
    self.hittime = gettime();
    owner = shockcharge.owner;
    damagepos = shockcharge.origin;
    var_1d0553ad = 0;
    if (var_1d0553ad) {
        self function_bd25ebbc(owner);
    }
    self playsound("wpn_shockrifle_bounce");
    if (isplayer(self)) {
        self thread function_a61cc4f0(shockcharge);
        self freezecontrolsallowlook(1);
    }
    shocked_hands = getweapon(#"shocked_hands");
    var_73463bc5 = getweapon(#"hash_19abd3767bd1566d");
    self giveweapon(shocked_hands);
    self switchtoweaponimmediate(shocked_hands, 1);
    prevstance = self getstance();
    self setstance("crouch");
    self disableweaponcycling();
    firstraisetime = isdefined(shocked_hands.firstraisetime) ? shocked_hands.firstraisetime : 1;
    wait firstraisetime;
    self allowcrouch(1);
    self allowprone(0);
    self allowstand(0);
    self giveweapon(var_73463bc5);
    self switchtoweaponimmediate(var_73463bc5, 1);
    if (isplayer(self)) {
        self freezecontrolsallowlook(0);
        self clientfield::set_to_player("shock_rifle_shocked", 1);
        self clientfield::set("shock_rifle_sound", 1);
    }
    if (var_41686b) {
        scoreevents::processscoreevent(#"hash_6f0ec202863eacd", owner, self, level.shockrifleweapon);
    } else {
        scoreevents::processscoreevent(#"tempest_shock_chain", owner, self, level.shockrifleweapon);
    }
    wait shockduration;
    self.var_db63b8ae = 0;
    self function_e858d6c5();
    playsoundatposition(#"hash_f2b6a97233cbeb2", self.origin);
    if (isplayer(self)) {
        self clientfield::set_to_player("shock_rifle_shocked", 0);
        self clientfield::set_to_player("shock_rifle_damage", 0);
        self clientfield::set("shock_rifle_sound", 0);
    }
    self enableweaponcycling();
    self takeweapon(var_73463bc5);
    self takeweapon(shocked_hands);
    self killstreaks::switch_to_last_non_killstreak_weapon(1, 0, 0);
    self waittill(#"weapon_change");
    self setstance(prevstance);
    self allowprone(1);
    self allowstand(1);
    self notify(#"shock_end");
}

// Namespace shockrifle/shockrifle
// Params 2, eflags: 0x0
// Checksum 0xebe82477, Offset: 0x1548
// Size: 0x1cc
function function_6e466940(ent, var_41686b) {
    damage = var_41686b ? level.var_be1d80e5.impactdamage : level.var_be1d80e5.shockdamage;
    isplayer = isplayer(ent);
    if (isdefined(ent.var_db63b8ae) && ent.var_db63b8ae) {
        damage = 10000;
    } else if (isdefined(ent.var_40726073) && isdefined(ent.var_40726073.isshocked) && ent.var_40726073.isshocked) {
        damage = 10000;
    } else if (isplayer && ent isplayerswimming()) {
        damage = 10000;
    } else if ((isplayer || isbot(ent)) && (ent isremotecontrolling() || ent.currentweapon == getweapon(#"recon_car"))) {
        damage = 10000;
    }
    damagescalar = isplayer ? ent function_eff56a3c() : 1;
    return damage * damagescalar;
}

// Namespace shockrifle/shockrifle
// Params 2, eflags: 0x0
// Checksum 0xb784e653, Offset: 0x1720
// Size: 0x3dc
function function_161233f(ent, var_41686b) {
    ent endon(#"death");
    self endon(#"death");
    self.hit_ents[self.hit_ents.size] = ent;
    self.var_9978fb3b++;
    if (isplayer(ent) && isdefined(ent.var_1dee8972)) {
        ent gadget_radiation_field::shutdown(1);
    }
    if (!var_41686b) {
        var_8c9462ec = spawn("script_model", self.origin);
        var_8c9462ec setmodel("tag_origin");
        var_4f80e42e = spawn("script_model", ent gettagorigin("j_spineupper"));
        var_4f80e42e setmodel("tag_origin");
        beamlaunch(var_8c9462ec, var_4f80e42e, "tag_origin", "tag_origin", level.shockrifleweapon);
        level thread function_cb4535af(var_8c9462ec);
        level thread function_cb4535af(var_4f80e42e);
    }
    ent.var_7c4064a2 = self.owner;
    damage = function_6e466940(ent, var_41686b);
    ent dodamage(damage, self.origin, self.owner, self, undefined, "MOD_UNKNOWN", 0, level.shockrifleweapon);
    ent.var_db63b8ae = 1;
    shockduration = ent function_a9cdeff7();
    params = getstatuseffect(#"shock_rifle_shock");
    ent status_effect::status_effect_apply(params, level.shockrifleweapon, self.owner, 0, int((shockduration + level.var_be1d80e5.var_6f256338) * 1000), undefined, self.origin);
    isplayer = isplayer(ent);
    if (isplayer) {
        ent clientfield::set_to_player("shock_rifle_damage", 1);
    }
    if (!function_28fbd06c(ent, shockduration) && isplayer) {
        if (ent clientfield::get_to_player("vision_pulse_active") == 1) {
            ent [[ level.shutdown_vision_pulse ]](0, 1, ent.var_5d66498);
            waitframe(1);
        }
        ent thread function_69cb71f9(self, var_41686b, shockduration);
        return;
    }
    ent playsound("wpn_shockrifle_bounce");
}

// Namespace shockrifle/shockrifle
// Params 3, eflags: 0x0
// Checksum 0xa9c3e66c, Offset: 0x1b08
// Size: 0xfc
function function_d4095326(attacker, weapon, target) {
    self endon(#"death");
    if (isdefined(self.detonating) && self.detonating) {
        return;
    }
    self.detonating = 1;
    playfx(#"hash_788f36f3ae067065", self.origin);
    self ghost();
    self notsolid();
    self stoploopsound(0.5);
    wait level.var_be1d80e5.shockduration + 1;
    self delete();
}

// Namespace shockrifle/shockrifle
// Params 1, eflags: 0x0
// Checksum 0x99ffc419, Offset: 0x1c10
// Size: 0x24
function function_cb4535af(object) {
    wait 5;
    object delete();
}

// Namespace shockrifle/shockrifle
// Params 1, eflags: 0x0
// Checksum 0x2e87ea22, Offset: 0x1c40
// Size: 0x31a
function function_900a44ea(watcher) {
    self endon(#"death");
    self setcandamage(1);
    damagemax = 20;
    self.maxhealth = 100000;
    self.health = self.maxhealth;
    self.damagetaken = 0;
    attacker = undefined;
    while (true) {
        waitresult = self waittill(#"damage");
        attacker = waitresult.attacker;
        weapon = waitresult.weapon;
        damage = waitresult.amount;
        type = waitresult.mod;
        idflags = waitresult.flags;
        if (weapon == level.shockrifleweapon) {
            continue;
        }
        damage = weapons::function_fa5602(damage, weapon, self.weapon);
        attacker = self [[ level.figure_out_attacker ]](waitresult.attacker);
        if (!isplayer(attacker)) {
            continue;
        }
        if (level.teambased) {
            if (!level.hardcoremode && self.owner.team == attacker.pers[#"team"] && self.owner != attacker) {
                continue;
            }
        }
        if (watcher.stuntime > 0 && weapon.dostun) {
            self thread weaponobjects::stunstart(watcher, watcher.stuntime);
        }
        if (damage::friendlyfirecheck(self.owner, attacker)) {
            if (damagefeedback::dodamagefeedback(weapon, attacker)) {
                attacker damagefeedback::update();
            }
        }
        if (type == "MOD_MELEE" || weapon.isemp || weapon.destroysequipment) {
            self.damagetaken = damagemax;
        } else {
            self.damagetaken += damage;
        }
        if (self.damagetaken >= damagemax) {
            watcher thread weaponobjects::waitanddetonate(self, 0.05, attacker, weapon);
            return;
        }
    }
}

