#using script_6b221588ece2c4aa;
#using scripts\core_common\battlechatter;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\damage;
#using scripts\core_common\damagefeedback_shared;
#using scripts\core_common\dev_shared;
#using scripts\core_common\entityheadicons_shared;
#using scripts\core_common\globallogic\globallogic_score;
#using scripts\core_common\hud_util_shared;
#using scripts\core_common\placeables;
#using scripts\core_common\player\player_loadout;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\weapons_shared;
#using scripts\killstreaks\killstreaks_util;

#namespace weaponobjects;

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0xa29fb59e, Offset: 0x380
// Size: 0x2bc
function init_shared() {
    callback::on_start_gametype(&start_gametype);
    callback::on_detonate(&on_detonate);
    callback::on_double_tap_detonate(&on_double_tap_detonate);
    clientfield::register("toplayer", "proximity_alarm", 1, 3, "int");
    clientfield::register_clientuimodel("hudItems.proximityAlarm", 1, 3, "int");
    clientfield::register("missile", "retrievable", 1, 1, "int");
    clientfield::register("scriptmover", "retrievable", 1, 1, "int");
    clientfield::register("missile", "enemyequip", 1, 2, "int");
    clientfield::register("scriptmover", "enemyequip", 1, 2, "int");
    clientfield::register("missile", "teamequip", 1, 1, "int");
    clientfield::register("missile", "friendlyequip", 1, 1, "int");
    clientfield::register("scriptmover", "friendlyequip", 1, 1, "int");
    level.weaponobjectdebug = getdvarint(#"scr_weaponobject_debug", 0);
    level.supplementalwatcherobjects = [];
    /#
        level thread updatedvars();
    #/
    level.proximitygrenadedotdamagetime = getdvarfloat(#"scr_proximitygrenadedotdamagetime", 0.2);
    level.proximitygrenadedotdamageinstances = getdvarint(#"scr_proximitygrenadedotdamageinstances", 4);
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0xcab30434, Offset: 0x648
// Size: 0x40
function updatedvars() {
    while (true) {
        level.weaponobjectdebug = getdvarint(#"scr_weaponobject_debug", 0);
        wait 1;
    }
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0x79e46dcd, Offset: 0x690
// Size: 0x244
function start_gametype() {
    callback::on_connect(&on_player_connect);
    callback::on_spawned(&on_player_spawned);
    callback::on_disconnect(&function_ac7c2bf9);
    callback::on_joined_team(&function_ac7c2bf9);
    callback::on_joined_spectate(&function_ac7c2bf9);
    if (!isdefined(level.retrievableweapons)) {
        level.retrievableweapons = [];
    }
    retrievables = getretrievableweapons();
    foreach (weapon in retrievables) {
        weaponstruct = spawnstruct();
        level.retrievableweapons[weapon.name] = weaponstruct;
    }
    level.weaponobjectexplodethisframe = 0;
    level._equipment_spark_fx = #"hash_28e1ed61483962d0";
    level._equipment_fizzleout_fx = #"hash_565dc21878e3cfbe";
    level._equipment_emp_destroy_fx = #"hash_4a466a3be8d20fe9";
    level._equipment_explode_fx = #"hash_4a466a3be8d20fe9";
    level._equipment_explode_fx_lg = #"hash_4a466a3be8d20fe9";
    level.weaponobjects_hacker_trigger_width = 32;
    level.weaponobjects_hacker_trigger_height = 32;
    function_db765b94();
    function_b455d5d8();
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0xbf8907cf, Offset: 0x8e0
// Size: 0x4e
function on_player_connect() {
    if (isdefined(level._weaponobjects_on_player_connect_override)) {
        level thread [[ level._weaponobjects_on_player_connect_override ]]();
        return;
    }
    self.usedweapons = 0;
    self.hits = 0;
    self.headshothits = 0;
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0x617344da, Offset: 0x938
// Size: 0x3c
function on_player_spawned() {
    self endon(#"disconnect");
    pixbeginevent(#"");
    if (!isdefined(self.weaponobjectwatcherarray)) {
        self.weaponobjectwatcherarray = [];
    }
    profilestop();
}

// Namespace weaponobjects/weaponobjects
// Params 3, eflags: 0x0
// Checksum 0x8bfd1a12, Offset: 0x980
// Size: 0xe4
function function_e6400478(name, func, var_8411d55d) {
    if (!isdefined(level.watcherregisters)) {
        level.watcherregisters = [];
    }
    if (isdefined(name)) {
        struct = level.watcherregisters[name];
        if (isdefined(struct)) {
            if (isdefined(var_8411d55d) && var_8411d55d != 2) {
                struct.func = func;
                struct.var_8411d55d = var_8411d55d;
                level.watcherregisters[name] = struct;
            }
            return;
        }
        struct = spawnstruct();
        struct.func = func;
        struct.type = var_8411d55d;
        level.watcherregisters[name] = struct;
    }
}

// Namespace weaponobjects/player_loadoutchanged
// Params 1, eflags: 0x40
// Checksum 0x31b56301, Offset: 0xa70
// Size: 0x7a
function event_handler[player_loadoutchanged] loadout_changed(eventstruct) {
    switch (eventstruct.event) {
    case #"give_weapon":
    case #"give_weapon_dual":
        weapon = eventstruct.weapon;
        self snipinterfaceattributes(weapon);
        break;
    }
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x4
// Checksum 0xdf25499b, Offset: 0xaf8
// Size: 0xbc
function private snipinterfaceattributes(weapon) {
    if (isdefined(level.watcherregisters)) {
        struct = level.watcherregisters[weapon.name];
        if (isdefined(struct)) {
            self createwatcher(weapon.name, struct.func, struct.type);
        }
        if (weapon.ischargeshot && weapon.nextchargelevelweapon != level.weaponnone) {
            self snipinterfaceattributes(weapon.nextchargelevelweapon);
        }
    }
}

// Namespace weaponobjects/weaponobjects
// Params 3, eflags: 0x0
// Checksum 0x467e2396, Offset: 0xbc0
// Size: 0x148
function createwatcher(weaponname, createfunc, var_7b2908f = 2) {
    watcher = undefined;
    switch (var_7b2908f) {
    case 0:
        watcher = self createproximityweaponobjectwatcher(weaponname, self.team);
        break;
    case 1:
        watcher = self createuseweaponobjectwatcher(weaponname, self.team);
        break;
    default:
        watcher = self createweaponobjectwatcher(weaponname, self.team);
        break;
    }
    if (isdefined(createfunc)) {
        self [[ createfunc ]](watcher);
    }
    retrievable = level.retrievableweapons[weaponname];
    if (isdefined(retrievable)) {
        setupretrievablewatcher(watcher);
    }
    return watcher;
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x4
// Checksum 0xfc003a24, Offset: 0xd10
// Size: 0x130
function private function_db765b94() {
    watcherweapons = getwatcherweapons();
    foreach (weapon in watcherweapons) {
        function_e6400478(weapon.name);
    }
    foreach (name, struct in level.retrievableweapons) {
        function_e6400478(name);
    }
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x4
// Checksum 0x615b1b6b, Offset: 0xe48
// Size: 0x72
function private setupretrievablewatcher(watcher) {
    if (!isdefined(watcher.onspawnretrievetriggers)) {
        watcher.onspawnretrievetriggers = &function_23b0aea9;
    }
    if (!isdefined(watcher.ondestroyed)) {
        watcher.ondestroyed = &ondestroyed;
    }
    if (!isdefined(watcher.pickup)) {
        watcher.pickup = &function_db70257;
    }
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x4c812f80, Offset: 0xec8
// Size: 0x64
function function_db70257(player, heldweapon) {
    if (heldweapon.var_7d4c12af == "Automatic") {
        function_d9219ce2(player, heldweapon);
        return;
    }
    function_a6616b9c(player, heldweapon);
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0xd8b71c41, Offset: 0xf38
// Size: 0x5c
function clearfxondeath(fx) {
    fx endon(#"death");
    self waittill(#"death", #"hacked");
    fx delete();
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0x5255ea86, Offset: 0xfa0
// Size: 0x84
function deleteweaponobjectinstance() {
    if (!isdefined(self)) {
        return;
    }
    if (isdefined(self.minemover)) {
        if (isdefined(self.minemover.killcament)) {
            self.minemover.killcament delete();
        }
        self.minemover delete();
    }
    self deletedelay();
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0xe6831621, Offset: 0x1030
// Size: 0xf2
function deleteweaponobjectarray() {
    if (isdefined(self.objectarray)) {
        keys = getarraykeys(self.objectarray);
        foreach (key in keys) {
            if (!isdefined(self.objectarray[key])) {
                continue;
            }
            self.objectarray[key] deleteweaponobjectinstance();
            self.objectarray[key] = undefined;
        }
    }
    self.objectarray = [];
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0xf8e3d965, Offset: 0x1130
// Size: 0x18c
function weapondetonate(attacker, weapon) {
    if (isdefined(weapon) && weapon.isemp) {
        self delete();
        return;
    }
    function_b4793bda(self, self.weapon);
    if (isdefined(attacker)) {
        if (isdefined(self.owner) && attacker != self.owner) {
            self.playdialog = 1;
        }
        if (isplayer(attacker)) {
            self detonate(attacker);
        } else {
            self detonate();
        }
    } else if (isdefined(self.owner) && isplayer(self.owner)) {
        self.playdialog = 0;
        self detonate(self.owner);
    } else {
        self detonate();
    }
    if (isdefined(self.owner) && isplayer(self.owner)) {
        self setstate(4);
    }
}

// Namespace weaponobjects/weaponobjects
// Params 4, eflags: 0x0
// Checksum 0x2568a83a, Offset: 0x12c8
// Size: 0xc4
function detonatewhenstationary(object, delay, attacker, weapon) {
    level endon(#"game_ended");
    object endon(#"death", #"hacked", #"detonating");
    if (object isonground() == 0) {
        object waittill(#"stationary");
    }
    self thread waitanddetonate(object, delay, attacker, weapon);
}

// Namespace weaponobjects/weaponobjects
// Params 4, eflags: 0x0
// Checksum 0x63343b85, Offset: 0x1398
// Size: 0x400
function waitanddetonate(object, delay, attacker, weapon) {
    object endon(#"death", #"hacked");
    if (!isdefined(attacker) && !isdefined(weapon) && object.weapon.proximityalarmactivationdelay > 0) {
        if (is_true(object.armed_detonation_wait)) {
            return;
        }
        object.armed_detonation_wait = 1;
        while (!is_true(object.proximity_deployed)) {
            waitframe(1);
        }
    }
    if (is_true(object.detonated)) {
        return;
    }
    object.detonated = 1;
    object notify(#"detonating");
    isempdetonated = isdefined(weapon) && weapon.isemp;
    if (isempdetonated && object.weapon.doempdestroyfx) {
        object.stun_fx = 1;
        randangle = randomfloat(360);
        playfx(level._equipment_emp_destroy_fx, object.origin + (0, 0, 5), (cos(randangle), sin(randangle), 0), anglestoup(object.angles));
        empfxdelay = 1.1;
    }
    if (isdefined(object.var_cea6a2fb)) {
        object.var_cea6a2fb placeables::forceshutdown();
    }
    if (!isdefined(self.ondetonatecallback)) {
        return;
    }
    if (!isempdetonated && !isdefined(weapon)) {
        if (isdefined(self.detonationdelay) && self.detonationdelay > 0) {
            if (isdefined(self.detonationsound)) {
                object playsound(self.detonationsound);
            }
            delay = self.detonationdelay;
        }
    } else if (isdefined(empfxdelay)) {
        delay = empfxdelay;
    }
    if (delay > 0) {
        wait delay;
    }
    if (isdefined(attacker) && isplayer(attacker) && isdefined(attacker.pers[#"team"]) && isdefined(object.owner) && isdefined(object.owner.pers) && isdefined(object.owner.pers[#"team"])) {
        if (level.teambased) {
            if (util::function_fbce7263(attacker.pers[#"team"], object.owner.pers[#"team"])) {
                attacker notify(#"destroyed_explosive");
            }
        } else if (attacker != object.owner) {
            attacker notify(#"destroyed_explosive");
        }
    }
    object [[ self.ondetonatecallback ]](attacker, weapon, undefined);
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x7ac60376, Offset: 0x17a0
// Size: 0xf0
function waitandfizzleout(object, delay) {
    object endon(#"death", #"hacked");
    if (isdefined(object.detonated) && object.detonated == 1) {
        return;
    }
    object.detonated = 1;
    object notify(#"fizzleout");
    if (delay > 0) {
        wait delay;
    }
    if (isdefined(object.var_cea6a2fb)) {
        object.var_cea6a2fb placeables::forceshutdown();
    }
    if (!isdefined(self.onfizzleout)) {
        object delete();
        return;
    }
    object [[ self.onfizzleout ]]();
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x4afd8836, Offset: 0x1898
// Size: 0x222
function detonateweaponobjectarray(forcedetonation, weapon) {
    undetonated = [];
    if (isdefined(self.objectarray)) {
        for (i = 0; i < self.objectarray.size; i++) {
            if (isdefined(self.objectarray[i])) {
                if (self.objectarray[i] isstunned() && forcedetonation == 0) {
                    undetonated[undetonated.size] = self.objectarray[i];
                    continue;
                }
                if (isdefined(weapon)) {
                    if (weapon util::ishacked() && weapon.name != self.objectarray[i].weapon.name) {
                        undetonated[undetonated.size] = self.objectarray[i];
                        continue;
                    } else if (self.objectarray[i] util::ishacked() && weapon.name != self.objectarray[i].weapon.name) {
                        undetonated[undetonated.size] = self.objectarray[i];
                        continue;
                    }
                }
                if (isdefined(self.detonatestationary) && self.detonatestationary && forcedetonation == 0) {
                    self thread detonatewhenstationary(self.objectarray[i], 0, undefined, weapon);
                    continue;
                }
                self thread waitanddetonate(self.objectarray[i], 0, undefined, weapon);
            }
        }
    }
    self.objectarray = undetonated;
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x9e706f6f, Offset: 0x1ac8
// Size: 0x7c
function addweaponobjecttowatcher(watchername, weapon_instance) {
    watcher = getweaponobjectwatcher(watchername);
    assert(isdefined(watcher), "<dev string:x38>" + watchername + "<dev string:x52>");
    self addweaponobject(watcher, weapon_instance);
}

// Namespace weaponobjects/weaponobjects
// Params 3, eflags: 0x0
// Checksum 0xdd5f2ded, Offset: 0x1b50
// Size: 0x2f4
function addweaponobject(watcher, weapon_instance, weapon) {
    if (!isdefined(weapon_instance)) {
        return;
    }
    if (!isdefined(watcher.storedifferentobject)) {
        watcher.objectarray[watcher.objectarray.size] = weapon_instance;
    }
    if (!isdefined(weapon)) {
        weapon = watcher.weapon;
    }
    weapon_instance.owner = self;
    weapon_instance.detonated = 0;
    weapon_instance.weapon = weapon;
    if (isdefined(watcher.ondamage)) {
        weapon_instance thread [[ watcher.ondamage ]](watcher);
    } else {
        weapon_instance thread weaponobjectdamage(watcher);
    }
    weapon_instance.ownergetsassist = watcher.ownergetsassist;
    weapon_instance.destroyedbyemp = watcher.destroyedbyemp;
    if (isdefined(watcher.onspawn)) {
        weapon_instance thread [[ watcher.onspawn ]](watcher, self);
    }
    if (isdefined(watcher.onspawnfx)) {
        weapon_instance thread [[ watcher.onspawnfx ]]();
    }
    weapon_instance setupreconeffect();
    if (isdefined(watcher.onspawnretrievetriggers)) {
        weapon_instance thread [[ watcher.onspawnretrievetriggers ]](watcher, self);
    }
    if (watcher.hackable) {
        weapon_instance thread hackerinit(watcher);
    }
    if (watcher.playdestroyeddialog) {
        weapon_instance thread playdialogondeath(self);
        weapon_instance thread watchobjectdamage(self);
    }
    if (watcher.deleteonkillbrush) {
        if (isdefined(level.deleteonkillbrushoverride)) {
            weapon_instance thread [[ level.deleteonkillbrushoverride ]](self, watcher);
        } else {
            weapon_instance thread deleteonkillbrush(self);
        }
    }
    if (weapon_instance useteamequipmentclientfield(watcher)) {
        weapon_instance clientfield::set("teamequip", 1);
    }
    if (watcher.timeout) {
        weapon_instance thread weapon_object_timeout(watcher, undefined);
    }
    if (isdefined(watcher.var_994b472b)) {
        weapon_instance thread function_6d8aa6a0(self, watcher);
    }
    weapon_instance thread delete_on_notify(self);
    weapon_instance thread cleanupwatcherondeath(watcher);
    weapon_instance thread function_b9ade2b();
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0xfbf7e064, Offset: 0x1e50
// Size: 0x19c
function function_6d8aa6a0(player, watcher) {
    self endon(#"death", #"hacked", #"hash_3a9500a4f045d0f3");
    var_e1d8c33c = ["joined_team", "joined_spectators", "disconnect", "changed_specialist"];
    if (isdefined(watcher.weapon.dieonrespawn) ? watcher.weapon.dieonrespawn : 0) {
        var_e1d8c33c[var_e1d8c33c.size] = "spawned";
    }
    if (isdefined(watcher.var_10efd558)) {
        var_e1d8c33c[var_e1d8c33c.size] = watcher.var_10efd558;
    }
    while (isdefined(player)) {
        result = player waittill(var_e1d8c33c);
        if (is_true(result.var_51246a31) && is_true(self.ishacked)) {
            continue;
        }
        break;
    }
    if (isdefined(self) && isdefined(player) && isdefined(watcher.var_994b472b)) {
        self [[ watcher.var_994b472b ]](player);
    }
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0xbde074bf, Offset: 0x1ff8
// Size: 0x64
function function_b9ade2b() {
    weapon_instance = self;
    weapon_instance endon(#"death");
    weapon_instance waittill(#"picked_up");
    weapon_instance.playdialog = 0;
    weapon_instance delete();
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x4d237bf8, Offset: 0x2068
// Size: 0x94
function cleanupwatcherondeath(watcher) {
    weapon_instance = self;
    weapon_instance waittill(#"death");
    if (isdefined(watcher) && isdefined(watcher.objectarray)) {
        removeweaponobject(watcher, weapon_instance);
    }
    if (isdefined(weapon_instance) && weapon_instance.delete_on_death === 1) {
        weapon_instance deleteweaponobjectinstance();
    }
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x9cc75ffa, Offset: 0x2108
// Size: 0xbc
function weapon_object_timeout(watcher, timeoutoverride) {
    weapon_instance = self;
    weapon_instance endon(#"death", #"cancel_timeout");
    timeoutval = isdefined(timeoutoverride) ? timeoutoverride : watcher.timeout;
    wait timeoutval;
    if (isdefined(watcher) && isdefined(watcher.ontimeout)) {
        weapon_instance thread [[ watcher.ontimeout ]]();
        return;
    }
    weapon_instance delete();
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x5a26959e, Offset: 0x21d0
// Size: 0xa4
function delete_on_notify(e_player) {
    weapon_instance = self;
    if (isplayer(e_player)) {
        e_player endon(#"disconnect");
    } else {
        e_player endon(#"death");
    }
    weapon_instance endon(#"death");
    e_player waittill(#"hash_5af33713e88a6df7");
    weapon_instance delete();
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x6433bec8, Offset: 0x2280
// Size: 0x54
function removeweaponobject(watcher, weapon_instance) {
    arrayremovevalue(watcher.objectarray, undefined);
    arrayremovevalue(watcher.objectarray, weapon_instance);
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0xff39132d, Offset: 0x22e0
// Size: 0x2c
function cleanweaponobjectarray(watcher) {
    arrayremovevalue(watcher.objectarray, undefined);
}

// Namespace weaponobjects/weaponobjects
// Params 4, eflags: 0x0
// Checksum 0xc3bbbee2, Offset: 0x2318
// Size: 0x94
function weapon_object_do_damagefeedback(weapon, attacker, mod, inflictor) {
    if (isdefined(weapon) && isdefined(attacker)) {
        if (damage::friendlyfirecheck(self.owner, attacker)) {
            if (damagefeedback::dodamagefeedback(weapon, attacker)) {
                attacker damagefeedback::update(mod, inflictor, undefined, weapon, self);
            }
        }
    }
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0xae2fa9fd, Offset: 0x23b8
// Size: 0x4b4
function weaponobjectdamage(watcher) {
    self endon(#"death", #"hacked", #"detonating");
    self setcandamage(1);
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
        damage = weapons::function_74bbb3fa(damage, weapon, self.weapon);
        self.damagetaken += damage;
        if (!isplayer(attacker) && isdefined(attacker.owner)) {
            attacker = attacker.owner;
        }
        if (isdefined(weapon)) {
            self weapon_object_do_damagefeedback(weapon, attacker, type, waitresult.inflictor);
            if (watcher.stuntime > 0 && weapon.dostun) {
                self thread stunstart(watcher, watcher.stuntime);
                continue;
            }
        }
        if (!level.weaponobjectdebug && level.teambased && isplayer(attacker) && isdefined(self.owner)) {
            if (!level.hardcoremode && !util::function_fbce7263(self.owner.team, attacker.pers[#"team"]) && self.owner != attacker) {
                continue;
            }
        }
        if (isdefined(watcher.isfataldamage) && !self [[ watcher.isfataldamage ]](watcher, attacker, weapon, damage)) {
            continue;
        }
        if (!isvehicle(self) && !damage::friendlyfirecheck(self.owner, attacker)) {
            continue;
        }
        if (util::function_fbce7263(attacker.team, self.team)) {
            killstreaks::function_e729ccee(attacker, weapon);
        }
        break;
    }
    if (level.weaponobjectexplodethisframe) {
        wait 0.1 + randomfloat(0.4);
    } else {
        waitframe(1);
    }
    if (!isdefined(self)) {
        return;
    }
    level.weaponobjectexplodethisframe = 1;
    thread resetweaponobjectexplodethisframe();
    self entityheadicons::setentityheadicon("none");
    if (isdefined(type) && (issubstr(type, "MOD_GRENADE_SPLASH") || issubstr(type, "MOD_GRENADE") || issubstr(type, "MOD_EXPLOSIVE"))) {
        self.waschained = 1;
    }
    if (isdefined(idflags) && idflags & 8) {
        self.wasdamagedfrombulletpenetration = 1;
    }
    self.wasdamaged = 1;
    watcher thread waitanddetonate(self, 0, attacker, weapon);
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0xb78ab3bd, Offset: 0x2878
// Size: 0x90
function playdialogondeath(owner) {
    owner endon(#"death");
    self endon(#"hacked");
    self waittill(#"death");
    if (isdefined(self.playdialog) && self.playdialog) {
        if (isdefined(owner) && isdefined(level.playequipmentdestroyedonplayer)) {
            owner [[ level.playequipmentdestroyedonplayer ]]();
        }
    }
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0xe30c1f0f, Offset: 0x2910
// Size: 0xd6
function watchobjectdamage(owner) {
    owner endon(#"death");
    self endon(#"hacked", #"death");
    while (true) {
        waitresult = self waittill(#"damage");
        if (isdefined(waitresult.attacker) && isplayer(waitresult.attacker) && waitresult.attacker != owner) {
            self.playdialog = 1;
            continue;
        }
        self.playdialog = 0;
    }
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x3539b235, Offset: 0x29f0
// Size: 0x134
function stunstart(watcher, time) {
    self endon(#"death");
    if (self isstunned()) {
        return;
    }
    if (isdefined(self.camerahead)) {
    }
    if (isdefined(watcher.onstun)) {
        self thread [[ watcher.onstun ]]();
    }
    if (watcher.name == "rcbomb") {
        self.owner val::set(#"weaponobjects", "freezecontrols", 1);
    }
    if (isdefined(time)) {
        wait time;
    } else {
        return;
    }
    if (watcher.name == "rcbomb") {
        self.owner val::reset(#"weaponobjects", "freezecontrols");
    }
    self stunstop();
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0x107a4485, Offset: 0x2b30
// Size: 0x24
function stunstop() {
    self notify(#"not_stunned");
    if (isdefined(self.camerahead)) {
    }
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0xaae63f16, Offset: 0x2b60
// Size: 0x10c
function weaponstun() {
    self endon(#"death", #"not_stunned");
    origin = self gettagorigin("tag_fx");
    if (!isdefined(origin)) {
        origin = self.origin + (0, 0, 10);
    }
    self.stun_fx = spawn("script_model", origin);
    self.stun_fx setmodel(#"tag_origin");
    self thread stunfxthink(self.stun_fx);
    wait 0.1;
    playfxontag(level._equipment_spark_fx, self.stun_fx, "tag_origin");
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x23c780e8, Offset: 0x2c78
// Size: 0x5c
function stunfxthink(fx) {
    fx endon(#"death");
    self waittill(#"death", #"not_stunned");
    fx delete();
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0xf4b4a180, Offset: 0x2ce0
// Size: 0xc
function isstunned() {
    return isdefined(self.stun_fx);
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0x9e72af08, Offset: 0x2cf8
// Size: 0x4c
function weaponobjectfizzleout() {
    self endon(#"death");
    function_f2a06099(self, self.weapon);
    self delete();
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0xddbb0e9c, Offset: 0x2d50
// Size: 0xcc
function function_f245df1e() {
    self endon(#"death");
    randangle = randomfloat(360);
    playfx(level._equipment_emp_destroy_fx, self.origin + (0, 0, 5), (cos(randangle), sin(randangle), 0), anglestoup(self.angles));
    wait 1.1;
    self delete();
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x395d5c80, Offset: 0x2e28
// Size: 0x94
function function_127fb8f3(var_983dc34, attackingplayer) {
    if (isdefined(var_983dc34) && isdefined(var_983dc34.var_2d045452)) {
        var_983dc34.var_2d045452 thread waitanddetonate(var_983dc34, 0.05, attackingplayer, getweapon(#"eq_emp_grenade"));
        return;
    }
    var_983dc34 function_f245df1e();
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0xace8225e, Offset: 0x2ec8
// Size: 0x18c
function function_b4793bda(entity, weapon) {
    if (!isdefined(weapon.customsettings)) {
        return;
    }
    customsettings = weapons::function_7a677105(weapon);
    fx = customsettings.detonatefx;
    if (isdefined(fx)) {
        tag = customsettings.var_abd3e497;
        if (isdefined(tag)) {
            origin = entity gettagorigin(tag);
            angles = entity gettagangles(tag);
        }
        origin = isdefined(origin) ? origin : entity.origin;
        angles = isdefined(angles) ? angles : entity.angles;
        if (isdefined(tag)) {
            fxforward = anglestoforward(angles);
            fxup = anglestoup(angles);
        } else {
            fxforward = anglestoup(angles);
            fxup = anglestoforward(angles);
        }
        playfx(fx, origin, fxforward, fxup);
    }
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x1e408bfc, Offset: 0x3060
// Size: 0x1a4
function function_f2a06099(entity, weapon) {
    if (isdefined(weapon.customsettings)) {
        customsettings = weapons::function_7a677105(weapon);
        fx = customsettings.var_9fed82b8;
        tag = customsettings.var_41d39c92;
    }
    fx = isdefined(fx) ? fx : level._equipment_fizzleout_fx;
    if (isdefined(tag)) {
        origin = entity gettagorigin(tag);
        angles = entity gettagangles(tag);
    }
    origin = isdefined(origin) ? origin : entity.origin;
    angles = isdefined(angles) ? angles : entity.angles;
    if (isdefined(tag)) {
        fxforward = anglestoforward(angles);
        fxup = anglestoup(angles);
    } else {
        fxforward = anglestoup(angles);
        fxup = anglestoforward(angles);
    }
    playfx(fx, origin, fxforward, fxup);
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0xfb033b8, Offset: 0x3210
// Size: 0x18
function resetweaponobjectexplodethisframe() {
    waitframe(1);
    level.weaponobjectexplodethisframe = 0;
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0xb08ecb16, Offset: 0x3230
// Size: 0xb4
function getweaponobjectwatcher(name) {
    if (!isdefined(self.weaponobjectwatcherarray) || !isdefined(name)) {
        return undefined;
    }
    for (watcher = 0; watcher < self.weaponobjectwatcherarray.size; watcher++) {
        if (self.weaponobjectwatcherarray[watcher].name == name || isdefined(self.weaponobjectwatcherarray[watcher].altname) && self.weaponobjectwatcherarray[watcher].altname == name) {
            return self.weaponobjectwatcherarray[watcher];
        }
    }
    return undefined;
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0xe7f75637, Offset: 0x32f0
// Size: 0xf8
function getweaponobjectwatcherbyweapon(weapon) {
    if (!isdefined(self.weaponobjectwatcherarray)) {
        return undefined;
    }
    for (watcher = 0; watcher < self.weaponobjectwatcherarray.size; watcher++) {
        if (isdefined(self.weaponobjectwatcherarray[watcher].weapon)) {
            if (self.weaponobjectwatcherarray[watcher].weapon == weapon || self.weaponobjectwatcherarray[watcher].weapon == weapon.rootweapon) {
                return self.weaponobjectwatcherarray[watcher];
            }
            if (isdefined(self.weaponobjectwatcherarray[watcher].altweapon) && self.weaponobjectwatcherarray[watcher].altweapon == weapon.rootweapon) {
                return self.weaponobjectwatcherarray[watcher];
            }
        }
    }
    return undefined;
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0xe5e4b7a2, Offset: 0x33f0
// Size: 0x82
function resetweaponobjectwatcher(watcher, ownerteam) {
    if (watcher.deleteonplayerspawn || isdefined(watcher.ownerteam) && watcher.ownerteam != ownerteam) {
        self notify(#"weapon_object_destroyed");
        watcher deleteweaponobjectarray();
    }
    watcher.ownerteam = ownerteam;
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x4
// Checksum 0x37138f19, Offset: 0x3480
// Size: 0x308
function private createweaponobjectwatcher(weaponname, ownerteam) {
    if (!isdefined(self.weaponobjectwatcherarray)) {
        self.weaponobjectwatcherarray = [];
    }
    weaponobjectwatcher = getweaponobjectwatcher(weaponname);
    if (!isdefined(weaponobjectwatcher)) {
        weaponobjectwatcher = spawnstruct();
        self.weaponobjectwatcherarray[self.weaponobjectwatcherarray.size] = weaponobjectwatcher;
        weaponobjectwatcher.name = weaponname;
        weaponobjectwatcher.type = "use";
        weaponobjectwatcher.weapon = getweapon(weaponname);
        weaponobjectwatcher.watchforfire = 0;
        weaponobjectwatcher.hackable = 0;
        weaponobjectwatcher.altdetonate = 0;
        weaponobjectwatcher.detectable = 1;
        weaponobjectwatcher.stuntime = 0;
        weaponobjectwatcher.timeout = getweapon(weaponname).lifetime;
        weaponobjectwatcher.destroyedbyemp = 1;
        weaponobjectwatcher.activatesound = undefined;
        weaponobjectwatcher.ignoredirection = undefined;
        weaponobjectwatcher.immediatedetonation = undefined;
        weaponobjectwatcher.deploysound = weaponobjectwatcher.weapon.firesound;
        weaponobjectwatcher.deploysoundplayer = weaponobjectwatcher.weapon.firesoundplayer;
        weaponobjectwatcher.pickupsound = weaponobjectwatcher.weapon.pickupsound;
        weaponobjectwatcher.pickupsoundplayer = weaponobjectwatcher.weapon.pickupsoundplayer;
        weaponobjectwatcher.altweapon = weaponobjectwatcher.weapon.altweapon;
        weaponobjectwatcher.ownergetsassist = 0;
        weaponobjectwatcher.playdestroyeddialog = 1;
        weaponobjectwatcher.deleteonkillbrush = 1;
        weaponobjectwatcher.deleteondifferentobjectspawn = 1;
        weaponobjectwatcher.enemydestroy = 0;
        weaponobjectwatcher.deleteonplayerspawn = weaponobjectwatcher.weapon.dieonrespawn;
        weaponobjectwatcher.ignorevehicles = 0;
        weaponobjectwatcher.ignoreai = 0;
        weaponobjectwatcher.activationdelay = 0;
        weaponobjectwatcher.onspawn = undefined;
        weaponobjectwatcher.onspawnfx = undefined;
        weaponobjectwatcher.onspawnretrievetriggers = undefined;
        weaponobjectwatcher.ondetonatecallback = undefined;
        weaponobjectwatcher.onstun = undefined;
        weaponobjectwatcher.onstunfinished = undefined;
        weaponobjectwatcher.ondestroyed = undefined;
        weaponobjectwatcher.onfizzleout = &weaponobjectfizzleout;
        weaponobjectwatcher.isfataldamage = undefined;
        weaponobjectwatcher.onsupplementaldetonatecallback = undefined;
        weaponobjectwatcher.ontimeout = undefined;
        weaponobjectwatcher.var_994b472b = undefined;
        if (!isdefined(weaponobjectwatcher.objectarray)) {
            weaponobjectwatcher.objectarray = [];
        }
    }
    resetweaponobjectwatcher(weaponobjectwatcher, ownerteam);
    return weaponobjectwatcher;
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x4
// Checksum 0x65964564, Offset: 0x3790
// Size: 0x5e
function private createuseweaponobjectwatcher(weaponname, ownerteam) {
    weaponobjectwatcher = createweaponobjectwatcher(weaponname, ownerteam);
    weaponobjectwatcher.type = "use";
    weaponobjectwatcher.onspawn = &onspawnuseweaponobject;
    return weaponobjectwatcher;
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x4
// Checksum 0xa9cff0fb, Offset: 0x37f8
// Size: 0x126
function private createproximityweaponobjectwatcher(weaponname, ownerteam) {
    weaponobjectwatcher = createweaponobjectwatcher(weaponname, ownerteam);
    weaponobjectwatcher.type = "proximity";
    weaponobjectwatcher.onspawn = &onspawnproximityweaponobject;
    detectionconeangle = getdvarint(#"scr_weaponobject_coneangle", 70);
    weaponobjectwatcher.detectiondot = cos(detectionconeangle);
    weaponobjectwatcher.detectionmindist = getdvarint(#"scr_weaponobject_mindist", 20);
    weaponobjectwatcher.detectiongraceperiod = getdvarfloat(#"scr_weaponobject_graceperiod", 0.6);
    weaponobjectwatcher.detonateradius = getdvarint(#"scr_weaponobject_radius", 180);
    return weaponobjectwatcher;
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0x1ab18389, Offset: 0x3928
// Size: 0x2c
function wasproximityalarmactivatedbyself() {
    return isdefined(self.owner.var_4cd6885) && self.owner.var_4cd6885 == self;
}

// Namespace weaponobjects/weaponobjects
// Params 3, eflags: 0x0
// Checksum 0xc8f43e10, Offset: 0x3960
// Size: 0x1d4
function proximityalarmactivate(active, watcher, *var_af12fba0) {
    if (!isplayer(self.owner)) {
        return;
    }
    var_9292c6b5 = var_af12fba0.var_82aa8ec4 === 1;
    if (watcher && !isdefined(self.owner.var_4cd6885)) {
        self.owner.var_4cd6885 = self;
        state = var_9292c6b5 ? 3 : 2;
        self setstate(state);
        return;
    }
    if (!isdefined(self) || self wasproximityalarmactivatedbyself() || !var_9292c6b5 && self.owner clientfield::get_to_player("proximity_alarm") == 1) {
        self.owner.var_4cd6885 = undefined;
        state = 0;
        if (var_9292c6b5) {
            curstate = self.owner clientfield::get_to_player("proximity_alarm");
            switch (curstate) {
            case 4:
            case 5:
                state = curstate;
                break;
            default:
                state = 2;
                break;
            }
        }
        self setstate(state);
    }
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x133f3fb5, Offset: 0x3b40
// Size: 0x108
function setstate(newstate) {
    player = self.owner;
    if (!isplayer(player)) {
        return;
    }
    curstate = player clientfield::get_to_player("proximity_alarm");
    if (curstate != newstate) {
        player clientfield::set_to_player("proximity_alarm", newstate);
        player clientfield::set_player_uimodel("hudItems.proximityAlarm", newstate);
        watcher = player getweaponobjectwatcherbyweapon(self.weapon);
        if (isdefined(watcher) && isdefined(watcher.var_cfc18899)) {
            self [[ watcher.var_cfc18899 ]](curstate, newstate, player.var_4cd6885);
        }
    }
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0xfdd7d82, Offset: 0x3c50
// Size: 0x6c2
function proximityalarmloop(watcher, owner) {
    level endon(#"game_ended");
    self endon(#"death", #"hacked", #"detonating");
    if (self.weapon.proximityalarminnerradius <= 0) {
        return;
    }
    self util::waittillnotmoving();
    var_9292c6b5 = watcher.var_82aa8ec4 === 1;
    if (var_9292c6b5 && !is_true(self.owner._disable_proximity_alarms)) {
        curstate = self.owner clientfield::get_to_player("proximity_alarm");
        if (curstate != 5) {
            self setstate(1);
        }
    }
    delaytimesec = float(self.weapon.proximityalarmactivationdelay) / 1000;
    if (delaytimesec > 0) {
        wait delaytimesec;
        if (!isdefined(self)) {
            return;
        }
    }
    if (!is_true(self.owner._disable_proximity_alarms)) {
        state = var_9292c6b5 ? 2 : 1;
        self setstate(state);
    }
    self.proximity_deployed = 1;
    alarmstatusold = "notify";
    alarmstatus = "off";
    var_af12fba0 = undefined;
    while (true) {
        wait 0.05;
        if (!isdefined(self.owner) || !isplayer(self.owner)) {
            return;
        }
        if (isalive(self.owner) == 0 && self.owner util::isusingremote() == 0) {
            self proximityalarmactivate(0, watcher);
            return;
        }
        if (is_true(self.owner._disable_proximity_alarms)) {
            self proximityalarmactivate(0, watcher);
        } else if (alarmstatus != alarmstatusold || alarmstatus == "on" && !isdefined(self.owner.var_4cd6885)) {
            if (alarmstatus == "on") {
                self proximityalarmactivate(1, watcher, var_af12fba0);
            } else {
                self proximityalarmactivate(0, watcher);
            }
            alarmstatusold = alarmstatus;
        }
        alarmstatus = "off";
        var_af12fba0 = undefined;
        actors = getactorarray();
        players = getplayers();
        detectentities = arraycombine(players, actors, 0, 0);
        foreach (entity in detectentities) {
            wait 0.05;
            if (!isdefined(entity)) {
                continue;
            }
            owner = entity;
            if (isactor(entity) && (!isdefined(entity.isaiclone) || !entity.isaiclone)) {
                continue;
            } else if (isactor(entity)) {
                owner = entity.owner;
            }
            if (entity.team == #"spectator") {
                continue;
            }
            if (level.weaponobjectdebug != 1) {
                if (owner hasperk(#"specialty_detectexplosive")) {
                    continue;
                }
                if (isdefined(self.owner) && owner == self.owner) {
                    continue;
                }
                if (!damage::friendlyfirecheck(self.owner, owner, 0)) {
                    continue;
                }
            }
            if (self isstunned()) {
                continue;
            }
            if (!isalive(entity)) {
                continue;
            }
            if (isdefined(watcher.immunespecialty) && owner hasperk(watcher.immunespecialty)) {
                continue;
            }
            radius = self.weapon.proximityalarmouterradius;
            distancesqr = distancesquared(self.origin, entity.origin);
            if (radius * radius < distancesqr) {
                continue;
            }
            if (entity damageconetrace(self.origin, self) == 0) {
                continue;
            }
            if (alarmstatusold == "on") {
                alarmstatus = "on";
                break;
            }
            radius = self.weapon.proximityalarminnerradius;
            if (radius * radius < distancesqr) {
                continue;
            }
            alarmstatus = "on";
            var_af12fba0 = entity;
            break;
        }
    }
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0xe847ac09, Offset: 0x4320
// Size: 0x17c
function commononspawnuseweaponobjectproximityalarm(watcher, owner) {
    /#
        if (level.weaponobjectdebug == 1) {
            self thread proximityalarmweaponobjectdebug(watcher);
        }
    #/
    if (is_true(watcher.var_82aa8ec4)) {
        curstate = self.owner clientfield::get_to_player("proximity_alarm");
        if (curstate != 5) {
            self setstate(0);
        }
    }
    self proximityalarmloop(watcher, owner);
    self proximityalarmactivate(0, watcher);
    if (is_true(watcher.var_82aa8ec4)) {
        owner = self.owner;
        curstate = owner clientfield::get_to_player("proximity_alarm");
        if (curstate != 4 && curstate != 5) {
            owner clientfield::set_to_player("proximity_alarm", 0);
            owner clientfield::set_player_uimodel("hudItems.proximityAlarm", 0);
        }
    }
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0xcd771d93, Offset: 0x44a8
// Size: 0x2c
function onspawnuseweaponobject(watcher, owner) {
    self thread commononspawnuseweaponobjectproximityalarm(watcher, owner);
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0xb70569b7, Offset: 0x44e0
// Size: 0xac
function onspawnproximityweaponobject(watcher, *owner) {
    self.protected_entities = [];
    if (isdefined(level._proximityweaponobjectdetonation_override)) {
        self thread [[ level._proximityweaponobjectdetonation_override ]](owner);
    } else if (isdefined(self._proximityweaponobjectdetonation_override)) {
        self thread [[ self._proximityweaponobjectdetonation_override ]](owner);
    } else {
        self thread proximityweaponobjectdetonation(owner);
    }
    /#
        if (level.weaponobjectdebug == 1) {
            self thread proximityweaponobjectdebug(owner);
        }
    #/
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x4598
// Size: 0x4
function watchweaponobjectusage() {
    
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0xf867cfdb, Offset: 0x45a8
// Size: 0x22
function function_1c430dad(entity, isjammed) {
    entity.isjammed = isjammed;
}

// Namespace weaponobjects/grenade_fire
// Params 1, eflags: 0x40
// Checksum 0xd552f971, Offset: 0x45d8
// Size: 0x24
function event_handler[grenade_fire] function_9c78a35b(eventstruct) {
    function_d5d6b91(eventstruct);
}

// Namespace weaponobjects/grenade_launcher_fire
// Params 1, eflags: 0x40
// Checksum 0x74ca14e6, Offset: 0x4608
// Size: 0x24
function event_handler[grenade_launcher_fire] function_523f5c2e(eventstruct) {
    function_d5d6b91(eventstruct);
}

// Namespace weaponobjects/missile_fire
// Params 1, eflags: 0x40
// Checksum 0x1cf8e87f, Offset: 0x4638
// Size: 0x24
function event_handler[missile_fire] function_8cd77cf6(eventstruct) {
    function_d5d6b91(eventstruct);
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x6ec55424, Offset: 0x4668
// Size: 0x1fc
function function_d5d6b91(params) {
    weapon_instance = params.projectile;
    weapon = params.weapon;
    if (is_true(level.projectiles_should_ignore_world_pause) && isdefined(weapon_instance)) {
        weapon_instance setignorepauseworld(1);
    }
    if (isplayer(self) && weapon.setusedstat && !self util::ishacked()) {
        self stats::function_e24eec31(weapon, #"used", 1);
    }
    watcher = getweaponobjectwatcherbyweapon(weapon);
    if (isdefined(watcher)) {
        cleanweaponobjectarray(watcher);
        if (weapon.maxinstancesallowed) {
            if (watcher.objectarray.size > weapon.maxinstancesallowed - 1) {
                watcher thread waitandfizzleout(watcher.objectarray[0], 0.1);
                if (is_true(watcher.var_82aa8ec4)) {
                    watcher.objectarray[0] setstate(5);
                }
                watcher.objectarray[0] = undefined;
                cleanweaponobjectarray(watcher);
            }
        }
        self addweaponobject(watcher, weapon_instance, weapon);
    }
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x5cf41eef, Offset: 0x4870
// Size: 0x108
function watchweaponobjectspawn(notify_type, endonnotify = undefined) {
    if (isdefined(endonnotify)) {
        self endon(endonnotify);
    }
    self endon(#"death");
    self notify(#"watchweaponobjectspawn");
    self endon(#"watchweaponobjectspawn", #"disconnect");
    while (true) {
        if (isdefined(notify_type)) {
            waitresult = self waittill(notify_type);
        } else {
            waitresult = self waittill(#"grenade_fire", #"grenade_launcher_fire", #"missile_fire");
        }
        function_d5d6b91(waitresult);
    }
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0xea7b34e, Offset: 0x4980
// Size: 0xa6
function anyobjectsinworld(weapon) {
    objectsinworld = 0;
    for (i = 0; i < self.weaponobjectwatcherarray.size; i++) {
        if (self.weaponobjectwatcherarray[i].weapon != weapon) {
            continue;
        }
        if (isdefined(self.weaponobjectwatcherarray[i].ondetonatecallback) && self.weaponobjectwatcherarray[i].objectarray.size > 0) {
            objectsinworld = 1;
            break;
        }
    }
    return objectsinworld;
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0xd2baa6b2, Offset: 0x4a30
// Size: 0x42
function function_8481fc06(weapon) {
    watcher = getweaponobjectwatcherbyweapon(weapon);
    return function_7cdcc8ba(watcher);
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x640ccb8e, Offset: 0x4a80
// Size: 0xc6
function function_7cdcc8ba(watcher) {
    count = 0;
    if (isdefined(watcher)) {
        foreach (var_3fa20979 in watcher.objectarray) {
            if (isdefined(var_3fa20979.owner) && var_3fa20979.owner == self) {
                count += 1;
            }
        }
    }
    return count;
}

/#

    // Namespace weaponobjects/weaponobjects
    // Params 5, eflags: 0x0
    // Checksum 0x4762a242, Offset: 0x4b50
    // Size: 0xae
    function proximitysphere(origin, innerradius, incolor, outerradius, outcolor) {
        self endon(#"death");
        while (true) {
            if (isdefined(innerradius)) {
                dev::debug_sphere(origin, innerradius, incolor, 0.25, 1);
            }
            if (isdefined(outerradius)) {
                dev::debug_sphere(origin, outerradius, outcolor, 0.25, 1);
            }
            waitframe(1);
        }
    }

    // Namespace weaponobjects/weaponobjects
    // Params 1, eflags: 0x0
    // Checksum 0x8f406fb0, Offset: 0x4c08
    // Size: 0x94
    function proximityalarmweaponobjectdebug(*watcher) {
        self endon(#"death");
        self util::waittillnotmoving();
        if (!isdefined(self)) {
            return;
        }
        self thread proximitysphere(self.origin, self.weapon.proximityalarminnerradius, (0, 0.75, 0), self.weapon.proximityalarmouterradius, (0, 0.75, 0));
    }

    // Namespace weaponobjects/weaponobjects
    // Params 1, eflags: 0x0
    // Checksum 0xdfef964e, Offset: 0x4ca8
    // Size: 0xfc
    function proximityweaponobjectdebug(watcher) {
        self endon(#"death");
        self util::waittillnotmoving();
        if (!isdefined(self)) {
            return;
        }
        if (isdefined(watcher.ignoredirection)) {
            self thread proximitysphere(self.origin, watcher.detonateradius, (1, 0.85, 0), self.weapon.explosionradius, (1, 0, 0));
            return;
        }
        self thread showcone(acos(watcher.detectiondot), watcher.detonateradius, (1, 0.85, 0));
        self thread showcone(60, 256, (1, 0, 0));
    }

    // Namespace weaponobjects/weaponobjects
    // Params 3, eflags: 0x0
    // Checksum 0x2e32d63, Offset: 0x4db0
    // Size: 0x1f6
    function showcone(angle, range, color) {
        self endon(#"death");
        start = self.origin;
        forward = anglestoforward(self.angles);
        right = vectorcross(forward, (0, 0, 1));
        up = vectorcross(forward, right);
        fullforward = forward * range * cos(angle);
        sideamnt = range * sin(angle);
        while (true) {
            prevpoint = (0, 0, 0);
            for (i = 0; i <= 20; i++) {
                coneangle = i / 20 * 360;
                point = start + fullforward + sideamnt * (right * cos(coneangle) + up * sin(coneangle));
                if (i > 0) {
                    line(start, point, color);
                    line(prevpoint, point, color);
                }
                prevpoint = point;
            }
            waitframe(1);
        }
    }

#/

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x57e355dc, Offset: 0x4fb0
// Size: 0x8e
function weaponobjectdetectionmovable(*ownerteam) {
    self endon(#"end_detection", #"death", #"hacked");
    level endon(#"game_ended");
    if (!level.teambased) {
        return;
    }
    self.detectid = "rcBomb" + gettime() + randomint(1000000);
}

// Namespace weaponobjects/weaponobjects
// Params 3, eflags: 0x0
// Checksum 0xfdbf19a0, Offset: 0x5048
// Size: 0x66
function seticonpos(item, icon, heightincrease) {
    icon.x = item.origin[0];
    icon.y = item.origin[1];
    icon.z = item.origin[2] + heightincrease;
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x10f0ff08, Offset: 0x50b8
// Size: 0x6c
function weaponobjectdetectiontrigger_wait(ownerteam) {
    self endon(#"death", #"hacked", #"detonating");
    util::waittillnotmoving();
    self thread weaponobjectdetectiontrigger(ownerteam);
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x27ea5ef4, Offset: 0x5130
// Size: 0x12c
function weaponobjectdetectiontrigger(*ownerteam) {
    trigger = spawn("trigger_radius", self.origin - (0, 0, 128), 0, 512, 256);
    trigger.detectid = "trigger" + gettime() + randomint(1000000);
    trigger sethintlowpriority(1);
    self waittill(#"death", #"hacked", #"detonating");
    trigger notify(#"end_detection");
    /#
        if (isdefined(trigger.bombsquadicon)) {
            trigger.bombsquadicon destroy();
        }
    #/
    trigger delete();
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x4c313f7, Offset: 0x5268
// Size: 0x130
function hackertriggersetvisibility(owner) {
    self endon(#"death");
    assert(isplayer(owner));
    ownerteam = owner.pers[#"team"];
    for (;;) {
        if (level.teambased) {
            self setvisibletoallexceptteam(ownerteam);
            self setexcludeteamfortrigger(ownerteam);
        } else {
            self setvisibletoall();
            self setteamfortrigger(#"none");
        }
        if (isdefined(owner)) {
            self setinvisibletoplayer(owner);
        }
        level waittill(#"player_spawned", #"joined_team");
    }
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0x5f67db5, Offset: 0x53a0
// Size: 0x3e
function hackernotmoving() {
    self endon(#"death");
    self util::waittillnotmoving();
    self notify(#"landed");
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x4
// Checksum 0x9ffbfba9, Offset: 0x53e8
// Size: 0x5c
function private set_hint_string(hint_string, default_string) {
    if (isdefined(hint_string) && hint_string != "") {
        self sethintstring(hint_string);
        return;
    }
    self sethintstring(default_string);
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0xb72308b2, Offset: 0x5450
// Size: 0x1f4
function hackerinit(watcher) {
    self thread hackernotmoving();
    event = self waittill(#"death", #"landed");
    if (event._notify == "death") {
        return;
    }
    if (!isdefined(self)) {
        return;
    }
    triggerorigin = self.origin;
    if (isdefined(self.weapon.hackertriggerorigintag) && "" != self.weapon.hackertriggerorigintag) {
        triggerorigin = self gettagorigin(self.weapon.hackertriggerorigintag);
    }
    self.hackertrigger = function_c7cdf243(triggerorigin, level.weaponobjects_hacker_trigger_width, level.weaponobjects_hacker_trigger_height);
    self.hackertrigger set_hint_string(self.weapon.var_2f3ca476, #"mp/generic_hacking");
    self.hackertrigger setignoreentfortrigger(self);
    self.hackertrigger setperkfortrigger(#"specialty_disarmexplosive");
    self.hackertrigger thread hackertriggersetvisibility(self.owner);
    /#
    #/
    self thread hackerthink(self.hackertrigger, watcher);
    self thread watchshutdown(self.owner);
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0xbaa99233, Offset: 0x5650
// Size: 0xca
function hackerthink(trigger, watcher) {
    self endon(#"death");
    trigger endon(#"death");
    for (;;) {
        waitresult = trigger waittill(#"trigger");
        if (!isdefined(waitresult.is_instant) && !trigger hackerresult(waitresult.activator, self.owner)) {
            continue;
        }
        self itemhacked(watcher, waitresult.activator);
        return;
    }
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0xd55cf1a2, Offset: 0x5728
// Size: 0x3a4
function itemhacked(watcher, player) {
    self proximityalarmactivate(0, watcher);
    self.owner hackerremoveweapon(self);
    if (isdefined(level.playequipmenthackedonplayer)) {
        self.owner [[ level.playequipmenthackedonplayer ]]();
    }
    if (self.weapon.ammocountequipment > 0 && isdefined(self.ammo)) {
        ammoleftequipment = self.ammo;
    }
    self.hacked = 1;
    self setmissileowner(player);
    self setteam(player.pers[#"team"]);
    self.owner = player;
    self clientfield::set("retrievable", 0);
    if (self.weapon.dohackedstats) {
        scoreevents::processscoreevent(#"hacked", player, undefined, undefined);
        player stats::function_e24eec31(getweapon(#"pda_hack"), #"combatrecordstat", 1);
        player challenges::hackedordestroyedequipment();
    }
    /#
        if (self.weapon.rootweapon == level.weaponsatchelcharge && isdefined(player.lowermessage)) {
            player.lowermessage settext(#"hash_5723526a77b686b2");
            player.lowermessage.alpha = 1;
            player.lowermessage fadeovertime(2);
            player.lowermessage.alpha = 0;
        }
    #/
    self notify(#"hacked", {#player:player});
    level notify(#"hacked", {#target:self, #player:player});
    if (isdefined(self.camerahead)) {
        self.camerahead notify(#"hacked", {#player:player});
    }
    /#
    #/
    waitframe(1);
    if (isdefined(player) && player.sessionstate == "playing") {
        player notify(#"grenade_fire", {#projectile:self, #weapon:self.weapon, #respawn_from_hack:1});
        return;
    }
    watcher thread waitanddetonate(self, 0, undefined, self.weapon);
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x60308939, Offset: 0x5ad8
// Size: 0x8c
function hackerunfreezeplayer(player) {
    self endon(#"hack_done");
    self waittill(#"death");
    if (isdefined(player)) {
        player val::reset(#"gameobjects", "freezecontrols");
        player val::reset(#"gameobjects", "disable_weapons");
    }
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x620de3fe, Offset: 0x5b70
// Size: 0x32a
function hackerresult(player, owner) {
    success = 1;
    time = gettime();
    hacktime = getdvarfloat(#"perk_disarmexplosivetime", 0);
    if (!canhack(player, owner, 1)) {
        return 0;
    }
    self thread hackerunfreezeplayer(player);
    while (time + int(hacktime * 1000) > gettime()) {
        if (!canhack(player, owner, 0)) {
            success = 0;
            break;
        }
        if (!player usebuttonpressed()) {
            success = 0;
            break;
        }
        if (!isdefined(self)) {
            success = 0;
            break;
        }
        player val::set(#"gameobjects", "freezecontrols");
        player val::set(#"gameobjects", "disable_weapons");
        /#
            if (!isdefined(self.progressbar)) {
                self.progressbar = player hud::function_5037fb7f();
                self.progressbar.lastuserate = -1;
                self.progressbar hud::showelem();
                self.progressbar hud::updatebar(0.01, 1 / hacktime);
                self.progresstext = player hud::function_48badcf4();
                self.progresstext settext(#"mp/hacking");
                self.progresstext hud::showelem();
                player playlocalsound(#"evt_hacker_hacking");
            }
        #/
        waitframe(1);
    }
    if (isdefined(player)) {
        player val::reset(#"gameobjects", "freezecontrols");
        player val::reset(#"gameobjects", "disable_weapons");
    }
    /#
        if (isdefined(self.progressbar)) {
            self.progressbar hud::destroyelem();
            self.progresstext hud::destroyelem();
        }
    #/
    if (isdefined(self)) {
        self notify(#"hack_done");
    }
    return success;
}

// Namespace weaponobjects/weaponobjects
// Params 3, eflags: 0x0
// Checksum 0x87e7b4b3, Offset: 0x5ea8
// Size: 0x2ca
function canhack(player, owner, weapon_check) {
    if (!isdefined(player)) {
        return false;
    }
    if (!isplayer(player)) {
        return false;
    }
    if (!isalive(player)) {
        return false;
    }
    if (!isdefined(owner)) {
        return false;
    }
    if (owner == player) {
        return false;
    }
    if (level.teambased && !util::function_fbce7263(player.team, owner.team)) {
        return false;
    }
    if (isdefined(player.isdefusing) && player.isdefusing) {
        return false;
    }
    if (isdefined(player.isplanting) && player.isplanting) {
        return false;
    }
    if (isdefined(player.proxbar) && !player.proxbar.hidden) {
        return false;
    }
    if (isdefined(player.revivingteammate) && player.revivingteammate == 1) {
        return false;
    }
    if (!player isonground()) {
        return false;
    }
    if (player isinvehicle()) {
        return false;
    }
    if (player isweaponviewonlylinked()) {
        return false;
    }
    if (!player hasperk(#"specialty_disarmexplosive")) {
        return false;
    }
    if (player isempjammed()) {
        return false;
    }
    if (isdefined(player.laststand) && player.laststand) {
        return false;
    }
    if (weapon_check) {
        if (player isthrowinggrenade()) {
            return false;
        }
        if (player isswitchingweapons()) {
            return false;
        }
        if (player ismeleeing()) {
            return false;
        }
        weapon = player getcurrentweapon();
        if (!isdefined(weapon)) {
            return false;
        }
        if (weapon == level.weaponnone) {
            return false;
        }
        if (weapon.isequipment && player isfiring()) {
            return false;
        }
        if (weapon.isspecificuse) {
            return false;
        }
    }
    return true;
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x724ba82e, Offset: 0x6180
// Size: 0x96
function hackerremoveweapon(weapon_instance) {
    if (isdefined(self) && isdefined(self.weaponobjectwatcherarray)) {
        for (i = 0; i < self.weaponobjectwatcherarray.size; i++) {
            if (self.weaponobjectwatcherarray[i].weapon != weapon_instance.weapon.rootweapon) {
                continue;
            }
            removeweaponobject(self.weaponobjectwatcherarray[i], weapon_instance);
            return;
        }
    }
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x2bf0d00b, Offset: 0x6220
// Size: 0xd0
function proximityweaponobject_createdamagearea(watcher) {
    damagearea = spawn("trigger_radius", self.origin + (0, 0, 0 - watcher.detonateradius), 4096 | 16384 | level.aitriggerspawnflags | level.vehicletriggerspawnflags, watcher.detonateradius, watcher.detonateradius * 2);
    damagearea enablelinkto();
    damagearea linkto(self);
    self thread deleteondeath(damagearea);
    return damagearea;
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0xf4935abf, Offset: 0x62f8
// Size: 0x1f8
function proximityweaponobject_validtriggerentity(watcher, ent) {
    if (level.weaponobjectdebug != 1) {
        if (isdefined(self.owner) && ent == self.owner) {
            return false;
        }
        if (isvehicle(ent)) {
            if (watcher.ignorevehicles) {
                return false;
            }
            if (!ent getvehoccupants().size) {
                return false;
            }
            if (self.owner === ent.owner) {
                return false;
            }
        }
        if (!damage::friendlyfirecheck(self.owner, ent, 0)) {
            return false;
        }
        if (watcher.ignorevehicles && isai(ent) && !is_true(ent.isaiclone)) {
            return false;
        }
    }
    if (lengthsquared(ent getvelocity()) < 10 && !isdefined(watcher.immediatedetonation)) {
        return false;
    }
    if (!ent shouldaffectweaponobject(self, watcher)) {
        return false;
    }
    if (self isstunned()) {
        return false;
    }
    if (isplayer(ent)) {
        if (!isalive(ent)) {
            return false;
        }
        if (isdefined(watcher.immunespecialty) && ent hasperk(watcher.immunespecialty)) {
            return false;
        }
    }
    return true;
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x11da4f32, Offset: 0x64f8
// Size: 0x5c
function proximityweaponobject_removespawnprotectondeath(ent) {
    self endon(#"death");
    ent waittill(#"death", #"disconnect");
    arrayremovevalue(self.protected_entities, ent);
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x560f1624, Offset: 0x6560
// Size: 0xe4
function proximityweaponobject_spawnprotect(watcher, ent) {
    self endon(#"death");
    ent endon(#"death");
    self.protected_entities[self.protected_entities.size] = ent;
    self thread proximityweaponobject_removespawnprotectondeath(ent);
    radius_sqr = watcher.detonateradius * watcher.detonateradius;
    while (true) {
        if (distancesquared(ent.origin, self.origin) > radius_sqr) {
            arrayremovevalue(self.protected_entities, ent);
            return;
        }
        wait 0.5;
    }
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x29bdc8de, Offset: 0x6650
// Size: 0x134
function proximityweaponobject_isspawnprotected(watcher, ent) {
    if (!isplayer(ent)) {
        return false;
    }
    if (!isdefined(self.protected_entities)) {
        self.protected_entities = [];
    }
    foreach (protected_ent in self.protected_entities) {
        if (protected_ent == ent) {
            return true;
        }
    }
    linked_to = self getlinkedent();
    if (linked_to === ent) {
        return false;
    }
    if (ent player::is_spawn_protected()) {
        self thread proximityweaponobject_spawnprotect(watcher, ent);
        return true;
    }
    return false;
}

// Namespace weaponobjects/weaponobjects
// Params 3, eflags: 0x0
// Checksum 0x7d2de8f, Offset: 0x6790
// Size: 0x1b4
function proximityweaponobject_dodetonation(watcher, ent, traceorigin) {
    self endon(#"death", #"hacked");
    self notify(#"kill_target_detection");
    self.detonating = 1;
    if (isdefined(watcher.activatesound)) {
        self playsound(watcher.activatesound);
    }
    wait watcher.detectiongraceperiod;
    if (isplayer(ent) && ent hasperk(#"specialty_delayexplosive")) {
        wait getdvarfloat(#"perk_delayexplosivetime", 0);
    }
    self entityheadicons::setentityheadicon("none");
    self.origin = traceorigin;
    if (isdefined(self.var_cea6a2fb)) {
        self.var_cea6a2fb placeables::forceshutdown();
    }
    if (isdefined(self.owner) && isplayer(self.owner)) {
        self [[ watcher.ondetonatecallback ]](self.owner, undefined, ent);
        return;
    }
    self [[ watcher.ondetonatecallback ]](undefined, undefined, ent);
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x280504b7, Offset: 0x6950
// Size: 0x3c
function proximityweaponobject_activationdelay(watcher) {
    self util::waittillnotmoving();
    if (watcher.activationdelay) {
        wait watcher.activationdelay;
    }
}

// Namespace weaponobjects/weaponobjects
// Params 3, eflags: 0x0
// Checksum 0x6ff0c141, Offset: 0x6998
// Size: 0xd4
function proximityweaponobject_waittillframeendanddodetonation(watcher, ent, entityorigin) {
    self endon(#"death");
    dist = distance(ent.origin, self.origin);
    if (isdefined(self.activated_entity_distance)) {
        if (dist < self.activated_entity_distance) {
            self notify(#"better_target");
        } else {
            return;
        }
    }
    self endon(#"better_target");
    self.activated_entity_distance = dist;
    waitframe(1);
    proximityweaponobject_dodetonation(watcher, ent, entityorigin);
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x93b9696, Offset: 0x6a78
// Size: 0x168
function proximityweaponobjectdetonation(s_watcher) {
    self endon(#"death", #"hacked", #"kill_target_detection");
    proximityweaponobject_activationdelay(s_watcher);
    var_6e4025f7 = proximityweaponobject_createdamagearea(s_watcher);
    triggertime = isdefined(s_watcher.triggertime) ? s_watcher.triggertime : 0;
    if (triggertime) {
        triggertime = int(triggertime * 1000);
        self thread function_f5b8ea19(s_watcher, var_6e4025f7, triggertime);
        return;
    }
    while (true) {
        waitresult = var_6e4025f7 waittill(#"trigger");
        ent = waitresult.activator;
        if (function_5b0e3a9e(s_watcher, ent)) {
            self thread proximityweaponobject_waittillframeendanddodetonation(s_watcher, ent, self.origin);
        }
    }
}

// Namespace weaponobjects/weaponobjects
// Params 3, eflags: 0x0
// Checksum 0xfef01724, Offset: 0x6be8
// Size: 0x1b2
function function_f5b8ea19(s_watcher, *var_6e4025f7, triggertime) {
    self endon(#"death", #"hacked", #"kill_target_detection");
    var_bccce0e1 = undefined;
    detonating = 0;
    while (true) {
        if (isdefined(var_bccce0e1)) {
            var_8dc1cd0d = gettime() - var_bccce0e1;
        }
        triggered = 0;
        foreach (ent in self getenemiesinradius(self.origin, var_6e4025f7.detonateradius)) {
            if (function_5b0e3a9e(var_6e4025f7, ent)) {
                triggered = 1;
                if (!isdefined(var_bccce0e1)) {
                    var_bccce0e1 = gettime();
                    continue;
                }
                if (var_8dc1cd0d >= triggertime) {
                    self thread proximityweaponobject_waittillframeendanddodetonation(var_6e4025f7, ent, self.origin);
                    detonating = 1;
                }
            }
        }
        if (!triggered) {
            var_bccce0e1 = undefined;
        }
        if (detonating) {
            return;
        }
        waitframe(1);
    }
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x51d26eda, Offset: 0x6da8
// Size: 0x118
function function_5b0e3a9e(s_watcher, ent) {
    if (!proximityweaponobject_validtriggerentity(s_watcher, ent)) {
        return false;
    }
    if (proximityweaponobject_isspawnprotected(s_watcher, ent)) {
        return false;
    }
    if (self isjammed()) {
        return false;
    }
    v_up = anglestoup(self.angles);
    var_81fd2297 = 1;
    if (isdefined(self.weapon)) {
        if (self.weapon.explosionnormaloffset > 0) {
            var_81fd2297 = self.weapon.explosionnormaloffset;
        }
    }
    var_f1e2d68b = self.origin + v_up * var_81fd2297;
    if (ent damageconetrace(var_f1e2d68b, self) > 0) {
        return true;
    }
    return false;
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0x4d9270d, Offset: 0x6ec8
// Size: 0x1a
function isjammed() {
    return is_true(self.isjammed);
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0xa57fda8e, Offset: 0x6ef0
// Size: 0x18c
function shouldaffectweaponobject(object, watcher) {
    radius = object.weapon.explosionradius;
    distancesqr = distancesquared(self.origin, object.origin);
    if (radius != 0 && radius * radius < distancesqr) {
        return false;
    }
    if (isdefined(watcher.ignoredirection)) {
        return true;
    }
    pos = self.origin + (isdefined(watcher.var_8eda8949) ? watcher.var_8eda8949 : (0, 0, 32));
    dirtopos = pos - object.origin;
    objectforward = anglestoforward(object.angles);
    dist = vectordot(dirtopos, objectforward);
    if (dist < watcher.detectionmindist) {
        return false;
    }
    dirtopos = vectornormalize(dirtopos);
    dot = vectordot(dirtopos, objectforward);
    return dot > watcher.detectiondot;
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0xedcb548f, Offset: 0x7088
// Size: 0x54
function deleteondeath(ent) {
    self waittill(#"death", #"hacked");
    waitframe(1);
    if (isdefined(ent)) {
        ent delete();
    }
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x5b1d0c6f, Offset: 0x70e8
// Size: 0x1c2
function testkillbrushonstationary(a_killbrushes, player) {
    player endon(#"disconnect");
    self endon(#"death");
    self waittill(#"stationary");
    foreach (trig in a_killbrushes) {
        if (isdefined(trig) && self istouching(trig)) {
            if (!trig istriggerenabled()) {
                continue;
            }
            if (!(isdefined(self.spawnflags) && (self.spawnflags & 8) == 8) && !(isdefined(self.spawnflags) && (self.spawnflags & 512) == 512) && !(isdefined(self.spawnflags) && (self.spawnflags & 32768) == 32768)) {
                continue;
            }
            if (self.origin[2] > player.origin[2]) {
                break;
            }
            if (isdefined(self)) {
                self delete();
            }
            return;
        }
    }
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x29cdb561, Offset: 0x72b8
// Size: 0x1ec
function deleteonkillbrush(player) {
    player endon(#"disconnect");
    self endon(#"death", #"stationary");
    a_killbrushes = getentarray("trigger_hurt", "classname");
    self thread testkillbrushonstationary(a_killbrushes, player);
    while (true) {
        a_killbrushes = getentarray("trigger_hurt", "classname");
        for (i = 0; i < a_killbrushes.size; i++) {
            if (self istouching(a_killbrushes[i])) {
                if (!a_killbrushes[i] istriggerenabled()) {
                    continue;
                }
                if (!(isdefined(self.spawnflags) && (self.spawnflags & 8) == 8) && !(isdefined(self.spawnflags) && (self.spawnflags & 512) == 512) && !(isdefined(self.spawnflags) && (self.spawnflags & 32768) == 32768)) {
                    continue;
                }
                if (self.origin[2] > player.origin[2]) {
                    break;
                }
                if (isdefined(self)) {
                    self delete();
                }
                return;
            }
        }
        wait 0.1;
    }
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0xe6790987, Offset: 0x74b0
// Size: 0xf8
function on_double_tap_detonate() {
    if (!isalive(self) && !self util::isusingremote()) {
        return;
    }
    foreach (watcher in self.weaponobjectwatcherarray) {
        if (watcher.altdetonate) {
            if (isdefined(watcher.var_e7ebbd38)) {
                self thread [[ watcher.var_e7ebbd38 ]](watcher);
                continue;
            }
            watcher detonateweaponobjectarray(0);
        }
    }
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0x5e4d64ad, Offset: 0x75b0
// Size: 0xbc
function on_detonate() {
    if (self isusingoffhand()) {
        weap = self getcurrentoffhand();
    } else {
        weap = self getcurrentweapon();
    }
    watcher = getweaponobjectwatcherbyweapon(weap);
    if (isdefined(watcher)) {
        if (isdefined(watcher.ondetonationhandle)) {
            self thread [[ watcher.ondetonationhandle ]](watcher);
        }
        watcher detonateweaponobjectarray(0);
    }
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x60fc8cf2, Offset: 0x7678
// Size: 0xf4
function function_ac7c2bf9(*params) {
    if (!isdefined(self.weaponobjectwatcherarray)) {
        return;
    }
    watchers = [];
    for (watcher = 0; watcher < self.weaponobjectwatcherarray.size; watcher++) {
        weaponobjectwatcher = spawnstruct();
        watchers[watchers.size] = weaponobjectwatcher;
        weaponobjectwatcher.objectarray = [];
        if (isdefined(self.weaponobjectwatcherarray[watcher].objectarray)) {
            weaponobjectwatcher.objectarray = self.weaponobjectwatcherarray[watcher].objectarray;
        }
    }
    waitframe(1);
    for (watcher = 0; watcher < watchers.size; watcher++) {
        watchers[watcher] deleteweaponobjectarray();
    }
}

/#

    // Namespace weaponobjects/weaponobjects
    // Params 2, eflags: 0x0
    // Checksum 0x792ba60b, Offset: 0x7778
    // Size: 0x62
    function saydamaged(orig, amount) {
        for (i = 0; i < 60; i++) {
            print3d(orig, "<dev string:x65>" + amount);
            waitframe(1);
        }
    }

#/

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x4
// Checksum 0xaf73c68, Offset: 0x77e8
// Size: 0x14c
function private function_c9fc5521(player, weapon) {
    maxammo = 0;
    loadout = player loadout::find_loadout_slot(weapon);
    if (isdefined(loadout)) {
        if (loadout.count > 0) {
            maxammo = loadout.count;
        } else {
            maxammo = weapon.maxammo + weapon.clipsize;
        }
    } else if (isdefined(player.grenadetypeprimary) && weapon == player.grenadetypeprimary && isdefined(player.grenadetypeprimarycount) && player.grenadetypeprimarycount > 0) {
        maxammo = player.grenadetypeprimarycount;
    } else if (isdefined(player.grenadetypesecondary) && weapon == player.grenadetypesecondary && isdefined(player.grenadetypesecondarycount) && player.grenadetypesecondarycount > 0) {
        maxammo = player.grenadetypesecondarycount;
    } else {
        maxammo = weapon.maxammo + weapon.clipsize;
    }
    return maxammo;
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x4
// Checksum 0x35d25cce, Offset: 0x7940
// Size: 0x64
function private get_ammo(player, weapon) {
    ammo = player getweaponammoclip(weapon);
    if (!weapon.iscliponly) {
        ammo += player getweaponammostock(weapon);
    }
    return ammo;
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x4
// Checksum 0xc159deba, Offset: 0x79b0
// Size: 0x78
function private function_e0093db1(player, weapon) {
    maxammo = function_c9fc5521(player, weapon);
    if (maxammo == 0) {
        return false;
    }
    ammo = get_ammo(player, weapon);
    if (ammo >= maxammo) {
        return false;
    }
    return true;
}

// Namespace weaponobjects/weaponobjects
// Params 4, eflags: 0x0
// Checksum 0xca6369c1, Offset: 0x7a30
// Size: 0x1f2
function function_d831baf0(trigger, callback, playersoundonuse, npcsoundonuse) {
    self endon(#"death", #"explode", #"hacked");
    trigger endon(#"death");
    while (true) {
        waitresult = trigger waittill(#"trigger");
        player = waitresult.activator;
        if (!isalive(player)) {
            continue;
        }
        if (!player isonground() && !player isplayerswimming()) {
            continue;
        }
        if (isdefined(trigger.claimedby) && player != trigger.claimedby) {
            continue;
        }
        heldweapon = player function_672ba881(self.weapon);
        if (!isdefined(heldweapon)) {
            continue;
        }
        if (!function_e0093db1(player, heldweapon)) {
            continue;
        }
        if (isdefined(playersoundonuse)) {
            player playlocalsound(playersoundonuse);
        }
        if (isdefined(npcsoundonuse)) {
            player playsound(npcsoundonuse);
        }
        if (isdefined(level.var_b8e083d0)) {
            player [[ level.var_b8e083d0 ]](self.weapon);
        }
        self [[ callback ]](player, heldweapon);
        return;
    }
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0xf17931c7, Offset: 0x7c30
// Size: 0x92
function function_e3030545(pweapons, weapon) {
    foreach (pweapon in pweapons) {
        if (pweapon == weapon) {
            return pweapon;
        }
    }
    return undefined;
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x864b5790, Offset: 0x7cd0
// Size: 0xa0
function function_7f47d8b8(pweapons, weapon) {
    foreach (pweapon in pweapons) {
        if (pweapon.rootweapon == weapon.rootweapon) {
            return pweapon;
        }
    }
    return undefined;
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x33c0ffd6, Offset: 0x7d78
// Size: 0x72
function get_held_weapon_match_or_root_match(weapon) {
    pweapons = self getweaponslist(1);
    match = function_e3030545(pweapons, weapon);
    if (isdefined(match)) {
        return match;
    }
    return function_7f47d8b8(pweapons, weapon);
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x985e15a7, Offset: 0x7df8
// Size: 0xa0
function function_42e13419(pweapons, weapon) {
    foreach (pweapon in pweapons) {
        if (pweapon.ammoindex == weapon.ammoindex) {
            return pweapon;
        }
    }
    return undefined;
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x1c4e51ce, Offset: 0x7ea0
// Size: 0xa0
function function_3eca329f(pweapons, weapon) {
    foreach (pweapon in pweapons) {
        if (pweapon.clipindex == weapon.clipindex) {
            return pweapon;
        }
    }
    return undefined;
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x3889062d, Offset: 0x7f48
// Size: 0x72
function function_672ba881(weapon) {
    pweapons = self getweaponslist(1);
    match = function_3eca329f(pweapons, weapon);
    if (isdefined(match)) {
        return match;
    }
    return function_42e13419(pweapons, weapon);
}

// Namespace weaponobjects/weaponobjects
// Params 5, eflags: 0x4
// Checksum 0xdad8d918, Offset: 0x7fc8
// Size: 0x118
function private spawn_interact_trigger(type, origin, width, height, var_c16194e2) {
    if (isdefined(width) && isdefined(height)) {
        trigger = spawn(type, origin, 0, width, height);
    } else {
        trigger = spawn(type, origin);
        trigger setignoreentfortrigger(self);
    }
    if (var_c16194e2 !== 1) {
        trigger sethintlowpriority(1);
        trigger setcursorhint("HINT_NOICON", self);
    }
    trigger enablelinkto();
    trigger linkto(self);
    return trigger;
}

// Namespace weaponobjects/weaponobjects
// Params 3, eflags: 0x4
// Checksum 0xbb252d54, Offset: 0x80e8
// Size: 0x3a
function private function_c7cdf243(origin, width, height) {
    return spawn_interact_trigger("trigger_radius_use", origin, width, height);
}

// Namespace weaponobjects/weaponobjects
// Params 3, eflags: 0x4
// Checksum 0x5782e7e5, Offset: 0x8130
// Size: 0x42
function private function_d5e8c3d0(origin, width, height) {
    return spawn_interact_trigger("trigger_radius", origin, width, height, 1);
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0xd9f6cecb, Offset: 0x8180
// Size: 0x3bc
function function_23b0aea9(watcher, player) {
    self endon(#"death");
    self setowner(player);
    self setteam(player.pers[#"team"]);
    self.owner = player;
    self.oldangles = self.angles;
    self util::waittillnotmoving();
    waittillframeend();
    if (!isdefined(player) || !isdefined(player.pers)) {
        return;
    }
    if (player.pers[#"team"] == #"spectator") {
        return;
    }
    triggerorigin = self.origin;
    triggerparentent = undefined;
    if (isdefined(self.stucktoplayer)) {
        if (isalive(self.stucktoplayer) || !isdefined(self.stucktoplayer.body)) {
            if (isalive(self.stucktoplayer)) {
                triggerparentent = self;
                self unlink();
                self.angles = self.oldangles;
                self launch((5, 5, 5));
                self util::waittillnotmoving();
                waittillframeend();
            } else {
                triggerparentent = self.stucktoplayer;
            }
        } else {
            triggerparentent = self.stucktoplayer.body;
        }
    }
    if (!isdefined(self) || !isdefined(player)) {
        return;
    }
    if (isdefined(triggerparentent)) {
        triggerorigin = triggerparentent.origin + (0, 0, 10);
    } else {
        up = anglestoup(self.angles);
        triggerorigin = self.origin + vectorscale(up, 3);
    }
    weapon = watcher.weapon;
    if (!self util::ishacked() && "None" != weapon.var_7d4c12af) {
        if (self.weapon.shownretrievable) {
            self clientfield::set("retrievable", 1);
        }
        if (weapon.var_7d4c12af == "Automatic") {
            function_57152a5(watcher, player, triggerorigin);
        } else {
            function_ac27aef5(watcher, player, triggerorigin);
        }
        if (isdefined(triggerparentent)) {
            self.pickuptrigger linkto(triggerparentent);
        }
    }
    if ("None" != weapon.var_38eb7f9e) {
        function_9dbd349e(watcher, player, triggerorigin);
    }
    /#
        thread switch_team(self, watcher, player);
    #/
    self thread watchshutdown(player);
}

// Namespace weaponobjects/weaponobjects
// Params 3, eflags: 0x0
// Checksum 0x90a7bf25, Offset: 0x8548
// Size: 0x108
function function_ac27aef5(watcher, player, origin) {
    self.pickuptrigger = function_c7cdf243(origin);
    self.pickuptrigger setinvisibletoall();
    self.pickuptrigger setvisibletoplayer(player);
    self.pickuptrigger setteamfortrigger(player.pers[#"team"]);
    self thread watchusetrigger(self.pickuptrigger, watcher.pickup, watcher.pickupsoundplayer, watcher.pickupsound, watcher.weapon, 1);
    if (isdefined(watcher.pickup_trigger_listener)) {
        self thread [[ watcher.pickup_trigger_listener ]](self.pickuptrigger, player);
    }
}

// Namespace weaponobjects/weaponobjects
// Params 3, eflags: 0x0
// Checksum 0xc500adf1, Offset: 0x8658
// Size: 0x10c
function function_57152a5(watcher, player, origin) {
    height = 50;
    if (isdefined(watcher.weapon) && isdefined(watcher.weapon.var_ac36c1db) && watcher.weapon.var_ac36c1db > 0) {
        height = watcher.weapon.var_ac36c1db;
        origin -= (0, 0, height * 0.5);
    }
    self.pickuptrigger = function_d5e8c3d0(origin, 50, 50);
    self.pickuptrigger.claimedby = player;
    self thread function_d831baf0(self.pickuptrigger, watcher.pickup, watcher.pickupsoundplayer, watcher.pickupsound);
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x4e12ea8e, Offset: 0x8770
// Size: 0x7a
function function_386fa470(player) {
    if (!isdefined(self.enemytrigger)) {
        return;
    }
    self.enemytrigger setinvisibletoplayer(player);
    if (level.teambased) {
        self.enemytrigger setexcludeteamfortrigger(player.team);
        self.enemytrigger.triggerteamignore = self.team;
    }
}

// Namespace weaponobjects/weaponobjects
// Params 3, eflags: 0x0
// Checksum 0x5b95ffbe, Offset: 0x87f8
// Size: 0x114
function function_9dbd349e(watcher, player, origin) {
    self.enemytrigger = function_c7cdf243(origin);
    self.enemytrigger setinvisibletoplayer(player);
    if (level.teambased) {
        self.enemytrigger setexcludeteamfortrigger(player.team);
        self.enemytrigger.triggerteamignore = self.team;
    }
    self.enemytrigger set_hint_string(self.weapon.var_5c29f743, #"hash_d77107fb749d77f");
    self thread watchusetrigger(self.enemytrigger, watcher.ondestroyed);
    self thread watchshutdown(player);
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x4
// Checksum 0x1150148d, Offset: 0x8918
// Size: 0xfc
function private add_ammo(player, weapon) {
    if (weapon.iscliponly || weapon.var_d98594b2 == "Clip Then Ammo") {
        ammo = player getweaponammoclip(weapon);
        ammo++;
        clip_size = player getweaponammoclipsize(weapon);
        if (ammo <= clip_size) {
            player setweaponammoclip(weapon, ammo);
            return;
        }
    }
    if (!weapon.iscliponly) {
        stock_ammo = player getweaponammostock(weapon);
        stock_ammo++;
        player setweaponammostock(weapon, stock_ammo);
    }
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x7894048, Offset: 0x8a20
// Size: 0x124
function function_a6616b9c(player, heldweapon) {
    if (!self.weapon.anyplayercanretrieve && isdefined(self.owner) && self.owner != player) {
        return;
    }
    pickedweapon = self.weapon;
    self notify(#"picked_up");
    heldweapon = player function_672ba881(self.weapon);
    if (!isdefined(heldweapon)) {
        return;
    }
    if ("ammo" != heldweapon.gadget_powerusetype) {
        slot = player gadgetgetslot(heldweapon);
        player gadgetpowerchange(slot, heldweapon.gadget_powergainonretrieve);
        return;
    }
    if (!function_e0093db1(player, heldweapon)) {
        return;
    }
    add_ammo(player, heldweapon);
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0xbd785daf, Offset: 0x8b50
// Size: 0x116
function function_d9219ce2(player, weapon) {
    if (weapon.gadget_powergainonretrieve > 0) {
        slot = player gadgetgetslot(weapon);
        if (slot >= 0) {
            clipsize = player function_b7f1fd2c(weapon);
            if (clipsize && weapon.var_ce34bb7e) {
                powergain = weapon.gadget_powergainonretrieve / clipsize;
            } else {
                powergain = weapon.gadget_powergainonretrieve;
            }
            player gadgetpowerchange(slot, powergain);
            self notify(#"picked_up");
            return;
        }
    }
    add_ammo(player, weapon);
    self notify(#"picked_up");
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0xb6c7936e, Offset: 0x8c70
// Size: 0xac
function ondestroyed(*attacker, *data) {
    playfx(level._effect[#"tacticalinsertionfizzle"], self.origin);
    self playsound(#"dst_tac_insert_break");
    if (isdefined(self.owner) && isdefined(level.playequipmentdestroyedonplayer)) {
        self.owner [[ level.playequipmentdestroyedonplayer ]]();
    }
    self delete();
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x4b208f4b, Offset: 0x8d28
// Size: 0x13c
function watchshutdown(*player) {
    self notify("57c15ec23b458b0b");
    self endon("57c15ec23b458b0b");
    self waittill(#"death", #"hacked", #"detonating");
    pickuptrigger = self.pickuptrigger;
    hackertrigger = self.hackertrigger;
    enemytrigger = self.enemytrigger;
    if (isdefined(pickuptrigger)) {
        pickuptrigger delete();
    }
    if (isdefined(hackertrigger)) {
        /#
            if (isdefined(hackertrigger.progressbar)) {
                hackertrigger.progressbar hud::destroyelem();
                hackertrigger.progresstext hud::destroyelem();
            }
        #/
        hackertrigger delete();
    }
    if (isdefined(enemytrigger)) {
        enemytrigger delete();
    }
}

// Namespace weaponobjects/weaponobjects
// Params 6, eflags: 0x0
// Checksum 0x63a6e97c, Offset: 0x8e70
// Size: 0x2c8
function watchusetrigger(trigger, callback, playersoundonuse, npcsoundonuse, callback_data, var_acddd81e) {
    self endon(#"death", #"delete");
    trigger endon(#"death");
    while (true) {
        waitresult = trigger waittill(#"trigger");
        player = waitresult.activator;
        if (isdefined(self.detonated) && self.detonated == 1) {
            if (isdefined(trigger)) {
                trigger delete();
            }
            return;
        }
        if (!isalive(player)) {
            continue;
        }
        if (isdefined(trigger.triggerteam) && player.pers[#"team"] != trigger.triggerteam) {
            continue;
        }
        if (isdefined(trigger.triggerteamignore) && player.team == trigger.triggerteamignore) {
            continue;
        }
        if (isdefined(trigger.claimedby) && player != trigger.claimedby) {
            continue;
        }
        if (is_true(player.var_5e6eba64)) {
            continue;
        }
        grenade = player.throwinggrenade;
        weapon = player getcurrentweapon();
        if (weapon.isequipment) {
            grenade = 0;
        }
        if (player usebuttonpressed() && !is_true(grenade) && !player meleebuttonpressed()) {
            if (isdefined(playersoundonuse)) {
                player playlocalsound(playersoundonuse);
            }
            if (isdefined(npcsoundonuse)) {
                player playsound(npcsoundonuse);
            }
            if (isdefined(var_acddd81e) && isdefined(level.var_b8e083d0)) {
                player [[ level.var_b8e083d0 ]](self.weapon);
            }
            self thread [[ callback ]](player, callback_data);
        }
    }
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0x284d8b10, Offset: 0x9140
// Size: 0xa6
function setupreconeffect() {
    profilestart();
    if (!isdefined(self)) {
        profilestop();
        return;
    }
    if (self.weapon.shownenemyexplo === 1 || self.weapon.shownenemyequip === 1) {
        if (is_true(self.hacked)) {
            self clientfield::set("enemyequip", 2);
        } else {
            self clientfield::set("enemyequip", 1);
        }
    }
    profilestop();
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x28c59abd, Offset: 0x91f0
// Size: 0x34
function useteamequipmentclientfield(watcher) {
    if (isdefined(watcher)) {
        if (!isdefined(watcher.notequipment)) {
            if (isdefined(self)) {
                return true;
            }
        }
    }
    return false;
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0xc2ed24e8, Offset: 0x9230
// Size: 0x88
function getwatcherforweapon(weapon) {
    if (!isdefined(self)) {
        return undefined;
    }
    if (!isplayer(self)) {
        return undefined;
    }
    for (i = 0; i < self.weaponobjectwatcherarray.size; i++) {
        if (self.weaponobjectwatcherarray[i].weapon != weapon) {
            continue;
        }
        return self.weaponobjectwatcherarray[i];
    }
    return undefined;
}

// Namespace weaponobjects/weaponobjects
// Params 3, eflags: 0x0
// Checksum 0xebee5291, Offset: 0x92c0
// Size: 0xf4
function destroy_other_teams_supplemental_watcher_objects(attacker, weapon, radius) {
    if (level.teambased) {
        foreach (team, _ in level.teams) {
            if (!attacker util::isenemyteam(team)) {
                continue;
            }
            destroy_supplemental_watcher_objects(attacker, team, weapon, radius);
        }
    }
    destroy_supplemental_watcher_objects(attacker, #"none", weapon, radius);
}

// Namespace weaponobjects/weaponobjects
// Params 4, eflags: 0x0
// Checksum 0x73b038f9, Offset: 0x93c0
// Size: 0x1a8
function destroy_supplemental_watcher_objects(attacker, team, *weapon, radius) {
    radiussq = radius * radius;
    foreach (item in level.supplementalwatcherobjects) {
        if (!isdefined(item.weapon)) {
            continue;
        }
        if (distancesquared(item.origin, team.origin) > radiussq) {
            continue;
        }
        if (!isdefined(item.owner)) {
            continue;
        }
        if (isdefined(weapon) && util::function_fbce7263(item.owner.team, weapon)) {
            continue;
        } else if (item.owner == team) {
            continue;
        }
        watcher = item.owner getwatcherforweapon(item.weapon);
        if (!isdefined(watcher) || !isdefined(watcher.onsupplementaldetonatecallback)) {
            continue;
        }
        item thread [[ watcher.onsupplementaldetonatecallback ]]();
    }
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x677f174c, Offset: 0x9570
// Size: 0x3c
function add_supplemental_object(object) {
    level.supplementalwatcherobjects[level.supplementalwatcherobjects.size] = object;
    object thread watch_supplemental_object_death();
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0x4feb3d67, Offset: 0x95b8
// Size: 0x34
function watch_supplemental_object_death() {
    self waittill(#"death");
    arrayremovevalue(level.supplementalwatcherobjects, self);
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x1deed2f2, Offset: 0x95f8
// Size: 0x8c
function function_d9c08e94(var_2f190eaf, var_46f3f2d3) {
    self endon(#"cancel_timeout");
    if (!isdefined(var_2f190eaf) || var_2f190eaf <= 0) {
        return;
    }
    self endon(#"death");
    wait float(var_2f190eaf) / 1000;
    if (isdefined(var_46f3f2d3)) {
        self [[ var_46f3f2d3 ]]();
    }
}

// Namespace weaponobjects/weaponobjects
// Params 3, eflags: 0x0
// Checksum 0xf0a20a81, Offset: 0x9690
// Size: 0x10c
function proximitydetonate(attacker, weapon, *target) {
    if (isdefined(target) && target.isvalid) {
        if (isdefined(weapon)) {
            if (self.owner util::isenemyplayer(weapon)) {
                if (sessionmodeismultiplayergame() || sessionmodeiswarzonegame()) {
                    weapon challenges::destroyedexplosive(target);
                    self.owner globallogic_score::function_5829abe3(weapon, target, self.weapon);
                    self battlechatter::function_d2600afc(weapon, self.owner, self.weapon, target);
                }
            }
        }
    }
    weapondetonate(weapon, target);
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x2f9b879d, Offset: 0x97a8
// Size: 0xf2
function onspawnproximitygrenadeweaponobject(watcher, owner) {
    self thread function_219766eb();
    if (isplayer(owner)) {
        owner stats::function_e24eec31(self.weapon, #"used", 1);
    }
    if (isdefined(self.weapon) && self.weapon.proximitydetonation > 0) {
        watcher.detonateradius = self.weapon.proximitydetonation;
    }
    onspawnproximityweaponobject(watcher, owner);
    self function_931041f8(self.owner);
    self.originalowner = owner;
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0xdf83d8f0, Offset: 0x98a8
// Size: 0x9c
function function_219766eb() {
    self endon(#"death");
    self util::waittillnotmoving();
    self.killcament = spawn("script_model", self.origin + (0, 0, 8));
    self.killcament setweapon(self.weapon);
    self thread function_6f135b92();
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0xc464683c, Offset: 0x9950
// Size: 0x7c
function function_6f135b92() {
    self waittill(#"death");
    var_b2ed661a = isdefined(self.var_b2ed661a) ? self.var_b2ed661a : 4 + level.proximitygrenadedotdamagetime * level.proximitygrenadedotdamageinstances;
    if (isdefined(self.killcament)) {
        self.killcament util::deleteaftertime(var_b2ed661a);
    }
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0xe594cb87, Offset: 0x99d8
// Size: 0x4c
function function_fb7b0024(owner) {
    if (isdefined(owner.activeproximitygrenades) && owner.activeproximitygrenades.size > 0) {
        arrayremovevalue(owner.activeproximitygrenades, self);
    }
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x2b438126, Offset: 0x9a30
// Size: 0x7c
function function_931041f8(owner) {
    if (level.trackproximitygrenadesonowner === 1) {
        if (!isdefined(owner)) {
            return;
        }
        if (!isdefined(owner.activeproximitygrenades)) {
            owner.activeproximitygrenades = [];
        } else {
            arrayremovevalue(owner.activeproximitygrenades, undefined);
        }
        owner.activeproximitygrenades[owner.activeproximitygrenades.size] = self;
    }
}

/#

    // Namespace weaponobjects/weaponobjects
    // Params 3, eflags: 0x0
    // Checksum 0x36533e9a, Offset: 0x9ab8
    // Size: 0x1b0
    function switch_team(entity, watcher, owner) {
        self notify(#"stop_disarmthink");
        self endon(#"stop_disarmthink", #"death");
        setdvar(#"scr_switch_team", "<dev string:x72>");
        while (true) {
            wait 0.5;
            devgui_int = getdvarint(#"scr_switch_team", 0);
            if (devgui_int != 0) {
                team = "<dev string:x76>";
                if (isdefined(level.getenemyteam) && isdefined(owner) && isdefined(owner.team)) {
                    team = [[ level.getenemyteam ]](owner.team);
                }
                if (isdefined(level.devongetormakebot)) {
                    player = [[ level.devongetormakebot ]](team);
                }
                if (!isdefined(player)) {
                    println("<dev string:x84>");
                    wait 1;
                    continue;
                }
                entity itemhacked(watcher, player);
                setdvar(#"scr_switch_team", 0);
            }
        }
    }

#/
