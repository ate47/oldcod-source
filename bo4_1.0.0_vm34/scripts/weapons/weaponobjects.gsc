#using script_6b221588ece2c4aa;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\damage;
#using scripts\core_common\damagefeedback_shared;
#using scripts\core_common\dev_shared;
#using scripts\core_common\entityheadicons_shared;
#using scripts\core_common\hud_util_shared;
#using scripts\core_common\placeables;
#using scripts\core_common\player\player_loadout;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\weapons_shared;
#using scripts\weapons\trophy_system;

#namespace weaponobjects;

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0x10477056, Offset: 0x2a8
// Size: 0x224
function init_shared() {
    callback::on_start_gametype(&start_gametype);
    clientfield::register("toplayer", "proximity_alarm", 1, 3, "int");
    clientfield::register("clientuimodel", "hudItems.proximityAlarm", 1, 3, "int");
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
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0x81fcae13, Offset: 0x4d8
// Size: 0x44
function updatedvars() {
    while (true) {
        level.weaponobjectdebug = getdvarint(#"scr_weaponobject_debug", 0);
        wait 1;
    }
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0x9db4bf94, Offset: 0x528
// Size: 0x2bc
function start_gametype() {
    callback::on_connect(&on_player_connect);
    callback::on_spawned(&on_player_spawned);
    callback::on_disconnect(&function_465e8e68);
    callback::on_joined_team(&function_465e8e68);
    callback::on_joined_spectate(&function_465e8e68);
    if (!isdefined(level.retrievableweapons)) {
        level.retrievableweapons = [];
    }
    retrievables = getretrievableweapons();
    foreach (weapon in retrievables) {
        weaponstruct = spawnstruct();
        level.retrievableweapons[weapon.name] = weaponstruct;
    }
    level.weaponobjectexplodethisframe = 0;
    if (getdvarstring(#"scr_deleteexplosivesonspawn") == "") {
        setdvar(#"scr_deleteexplosivesonspawn", 1);
    }
    level.deleteexplosivesonspawn = getdvarint(#"scr_deleteexplosivesonspawn", 0);
    level._equipment_spark_fx = #"hash_25a99eb176affd8d";
    level._equipment_fizzleout_fx = #"hash_25a99eb176affd8d";
    level._equipment_emp_destroy_fx = #"killstreaks/fx_emp_explosion_equip";
    level._equipment_explode_fx = #"_t6/explosions/fx_exp_equipment";
    level._equipment_explode_fx_lg = #"hash_25a99eb176affd8d";
    level.weaponobjects_hacker_trigger_width = 32;
    level.weaponobjects_hacker_trigger_height = 32;
    function_abf89933();
    function_c41c3bf1();
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0xaa0d045, Offset: 0x7f0
// Size: 0x42
function on_player_connect() {
    if (isdefined(level._weaponobjects_on_player_connect_override)) {
        level thread [[ level._weaponobjects_on_player_connect_override ]]();
        return;
    }
    self.usedweapons = 0;
    self.hits = 0;
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0x747de1a, Offset: 0x840
// Size: 0xcc
function on_player_spawned() {
    self endon(#"disconnect");
    pixbeginevent(#"onplayerspawned");
    if (!isdefined(self.weaponobjectwatcherarray)) {
        self.weaponobjectwatcherarray = [];
    }
    self thread watchweaponobjectspawn();
    self callback::on_detonate(&on_detonate);
    self callback::on_double_tap_detonate(&on_double_tap_detonate);
    self trophy_system::ammo_reset();
    pixendevent();
}

// Namespace weaponobjects/weaponobjects
// Params 3, eflags: 0x0
// Checksum 0x4d4dfa84, Offset: 0x918
// Size: 0x106
function function_f298eae6(name, func, var_f113badb) {
    if (!isdefined(level.watcherregisters)) {
        level.watcherregisters = [];
    }
    if (isdefined(name)) {
        struct = level.watcherregisters[name];
        if (isdefined(struct)) {
            if (isdefined(var_f113badb) && var_f113badb != 2) {
                struct.func = func;
                struct.var_f113badb = var_f113badb;
                level.watcherregisters[name] = struct;
            }
            return;
        }
        struct = spawnstruct();
        struct.func = func;
        struct.type = var_f113badb;
        level.watcherregisters[name] = struct;
    }
}

// Namespace weaponobjects/player_loadoutchanged
// Params 1, eflags: 0x40
// Checksum 0x94c5af9a, Offset: 0xa28
// Size: 0x6a
function event_handler[player_loadoutchanged] loadout_changed(eventstruct) {
    switch (eventstruct.event) {
    case #"give_weapon":
        weapon = eventstruct.weapon;
        self function_2a5b887(weapon);
        break;
    }
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x4
// Checksum 0xf4371803, Offset: 0xaa0
// Size: 0xc4
function private function_2a5b887(weapon) {
    if (isdefined(level.watcherregisters)) {
        struct = level.watcherregisters[weapon.name];
        if (isdefined(struct)) {
            self createwatcher(weapon.name, struct.func, struct.type);
        }
        if (weapon.ischargeshot && weapon.nextchargelevelweapon != level.weaponnone) {
            self function_2a5b887(weapon.nextchargelevelweapon);
        }
    }
}

// Namespace weaponobjects/weaponobjects
// Params 3, eflags: 0x0
// Checksum 0x192304d7, Offset: 0xb70
// Size: 0x148
function createwatcher(weaponname, createfunc, var_6b8940db = 2) {
    watcher = undefined;
    switch (var_6b8940db) {
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
// Checksum 0xc6a0940a, Offset: 0xcc0
// Size: 0x110
function private function_abf89933() {
    watcherweapons = getwatcherweapons();
    foreach (weapon in watcherweapons) {
        function_f298eae6(weapon.name);
    }
    foreach (name, struct in level.retrievableweapons) {
        function_f298eae6(name);
    }
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x4
// Checksum 0x6811acca, Offset: 0xdd8
// Size: 0x86
function private setupretrievablewatcher(watcher) {
    if (!isdefined(watcher.onspawnretrievetriggers)) {
        watcher.onspawnretrievetriggers = &function_62336657;
    }
    if (!isdefined(watcher.ondestroyed)) {
        watcher.ondestroyed = &ondestroyed;
    }
    if (!isdefined(watcher.pickup)) {
        watcher.pickup = &function_e00a2820;
    }
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0xba5d0c9, Offset: 0xe68
// Size: 0x64
function function_e00a2820(player, heldweapon) {
    if (heldweapon.var_11155358 == "Automatic") {
        return function_a07674ea(player, heldweapon);
    }
    return function_449fc98b(player, heldweapon);
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x53396a78, Offset: 0xed8
// Size: 0x14
function voidonspawn(unused0, unused1) {
    
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0xb745b549, Offset: 0xef8
// Size: 0xc
function voidondamage(unused0) {
    
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0xf9f69f20, Offset: 0xf10
// Size: 0x14
function voidonspawnretrievetriggers(unused0, unused1) {
    
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x8e83ac91, Offset: 0xf30
// Size: 0x14
function voidpickup(unused0, unused1) {
    
}

// Namespace weaponobjects/weaponobjects
// Params 3, eflags: 0x0
// Checksum 0x55e61d7a, Offset: 0xf50
// Size: 0x34
function deleteent(attacker, emp, target) {
    self delete();
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0xf2d39494, Offset: 0xf90
// Size: 0x5c
function clearfxondeath(fx) {
    fx endon(#"death");
    self waittill(#"death", #"hacked");
    fx delete();
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0x413bb6cf, Offset: 0xff8
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
    self delete();
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0xe159848d, Offset: 0x1088
// Size: 0x92
function deleteweaponobjectarray() {
    if (isdefined(self.objectarray)) {
        foreach (weaponobject in self.objectarray) {
            weaponobject deleteweaponobjectinstance();
        }
    }
    self.objectarray = [];
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x79dc8a6, Offset: 0x1128
// Size: 0x16c
function weapondetonate(attacker, weapon) {
    if (isdefined(weapon) && weapon.isemp) {
        self delete();
        return;
    }
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
// Checksum 0xd4e91850, Offset: 0x12a0
// Size: 0xd4
function detonatewhenstationary(object, delay, attacker, weapon) {
    level endon(#"game_ended");
    object endon(#"death");
    object endon(#"hacked");
    object endon(#"detonating");
    if (object isonground() == 0) {
        object waittill(#"stationary");
    }
    self thread waitanddetonate(object, delay, attacker, weapon);
}

// Namespace weaponobjects/weaponobjects
// Params 4, eflags: 0x0
// Checksum 0xddaf6dc1, Offset: 0x1380
// Size: 0x42c
function waitanddetonate(object, delay, attacker, weapon) {
    object endon(#"death");
    object endon(#"hacked");
    if (!isdefined(attacker) && !isdefined(weapon) && object.weapon.proximityalarmactivationdelay > 0) {
        if (isdefined(object.armed_detonation_wait) && object.armed_detonation_wait) {
            return;
        }
        object.armed_detonation_wait = 1;
        while (!(isdefined(object.proximity_deployed) && object.proximity_deployed)) {
            waitframe(1);
        }
    }
    if (isdefined(object.detonated) && object.detonated) {
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
    if (isdefined(object.var_93ab7acc)) {
        object.var_93ab7acc placeables::forceshutdown();
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
            if (attacker.pers[#"team"] != object.owner.pers[#"team"]) {
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
// Checksum 0x5a981d14, Offset: 0x17b8
// Size: 0x100
function waitandfizzleout(object, delay) {
    object endon(#"death");
    object endon(#"hacked");
    if (isdefined(object.detonated) && object.detonated == 1) {
        return;
    }
    object.detonated = 1;
    object notify(#"fizzleout");
    if (delay > 0) {
        wait delay;
    }
    if (isdefined(object.var_93ab7acc)) {
        object.var_93ab7acc placeables::forceshutdown();
    }
    if (!isdefined(self.onfizzleout)) {
        self deleteent();
        return;
    }
    object [[ self.onfizzleout ]]();
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x4a1d674c, Offset: 0x18c0
// Size: 0x232
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
// Checksum 0x1aeb29b4, Offset: 0x1b00
// Size: 0x7c
function addweaponobjecttowatcher(watchername, weapon_instance) {
    watcher = getweaponobjectwatcher(watchername);
    assert(isdefined(watcher), "<dev string:x30>" + watchername + "<dev string:x47>");
    self addweaponobject(watcher, weapon_instance);
}

// Namespace weaponobjects/weaponobjects
// Params 4, eflags: 0x0
// Checksum 0x2fbda27e, Offset: 0x1b88
// Size: 0x32c
function addweaponobject(watcher, weapon_instance, weapon, endonnotify) {
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
    weapon_instance thread setupreconeffect();
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
        weapon_instance thread weapon_object_timeout(watcher);
    }
    if (isdefined(watcher.var_46869d39)) {
        weapon_instance thread function_a6e114fc(self, watcher);
    }
    weapon_instance thread delete_on_notify(self, endonnotify);
    weapon_instance thread cleanupwatcherondeath(watcher);
    weapon_instance thread function_4b55df08();
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x6dc75edf, Offset: 0x1ec0
// Size: 0x94
function function_a6e114fc(player, watcher) {
    self endon(#"death");
    player waittill(#"joined_team", #"joined_spectators", #"disconnect", #"changed_specialist", #"changed_specialist_death");
    self [[ watcher.var_46869d39 ]](player);
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0x845ba2f8, Offset: 0x1f60
// Size: 0x64
function function_4b55df08() {
    weapon_instance = self;
    weapon_instance endon(#"death");
    weapon_instance waittill(#"picked_up");
    weapon_instance.playdialog = 0;
    weapon_instance destroyent();
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0xdd260249, Offset: 0x1fd0
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
// Params 1, eflags: 0x0
// Checksum 0x4d1c5325, Offset: 0x2070
// Size: 0x7c
function weapon_object_timeout(watcher) {
    weapon_instance = self;
    weapon_instance endon(#"death");
    wait watcher.timeout;
    if (isdefined(watcher.ontimeout)) {
        weapon_instance thread [[ watcher.ontimeout ]]();
        return;
    }
    weapon_instance deleteent();
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x27405cae, Offset: 0x20f8
// Size: 0xcc
function delete_on_notify(e_player, endonnotify = undefined) {
    weapon_instance = self;
    if (isdefined(endonnotify)) {
        e_player endon(endonnotify);
    }
    e_player endon(#"disconnect");
    if (isai(e_player)) {
        e_player endon(#"death");
    }
    weapon_instance endon(#"death");
    e_player waittill(#"delete_weapon_objects");
    weapon_instance delete();
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x8eb9137c, Offset: 0x21d0
// Size: 0x54
function removeweaponobject(watcher, weapon_instance) {
    watcher.objectarray = array::remove_undefined(watcher.objectarray);
    arrayremovevalue(watcher.objectarray, weapon_instance);
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x7e7850ea, Offset: 0x2230
// Size: 0x2e
function cleanweaponobjectarray(watcher) {
    watcher.objectarray = array::remove_undefined(watcher.objectarray);
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x7a578fbe, Offset: 0x2268
// Size: 0x74
function weapon_object_do_damagefeedback(weapon, attacker) {
    if (isdefined(weapon) && isdefined(attacker)) {
        if (damage::friendlyfirecheck(self.owner, attacker)) {
            if (damagefeedback::dodamagefeedback(weapon, attacker)) {
                attacker damagefeedback::update();
            }
        }
    }
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x844e0e74, Offset: 0x22e8
// Size: 0x48c
function weaponobjectdamage(watcher) {
    self endon(#"death");
    self endon(#"hacked");
    self endon(#"detonating");
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
        damage = weapons::function_fa5602(damage, weapon, self.weapon);
        self.damagetaken += damage;
        if (!isplayer(attacker) && isdefined(attacker.owner)) {
            attacker = attacker.owner;
        }
        if (isdefined(weapon)) {
            self weapon_object_do_damagefeedback(weapon, attacker);
            if (watcher.stuntime > 0 && weapon.dostun) {
                self thread stunstart(watcher, watcher.stuntime);
                continue;
            }
        }
        if (!level.weaponobjectdebug && level.teambased && isplayer(attacker) && isdefined(self.owner)) {
            if (!level.hardcoremode && self.owner.team == attacker.pers[#"team"] && self.owner != attacker) {
                continue;
            }
        }
        if (isdefined(watcher.isfataldamage) && !self [[ watcher.isfataldamage ]](watcher, attacker, weapon, damage)) {
            continue;
        }
        if (!isvehicle(self) && !damage::friendlyfirecheck(self.owner, attacker)) {
            continue;
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
// Checksum 0x803d031e, Offset: 0x2780
// Size: 0xa0
function playdialogondeath(owner) {
    owner endon(#"death");
    owner endon(#"disconnect");
    self endon(#"hacked");
    self waittill(#"death");
    if (isdefined(self.playdialog) && self.playdialog) {
        if (isdefined(level.playequipmentdestroyedonplayer)) {
            owner [[ level.playequipmentdestroyedonplayer ]]();
        }
    }
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x4f09e497, Offset: 0x2828
// Size: 0xe6
function watchobjectdamage(owner) {
    owner endon(#"death");
    owner endon(#"disconnect");
    self endon(#"hacked");
    self endon(#"death");
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
// Checksum 0x24f36871, Offset: 0x2918
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
// Checksum 0xc162c069, Offset: 0x2a58
// Size: 0x24
function stunstop() {
    self notify(#"not_stunned");
    if (isdefined(self.camerahead)) {
    }
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0x10bf415a, Offset: 0x2a88
// Size: 0x10c
function weaponstun() {
    self endon(#"death");
    self endon(#"not_stunned");
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
// Checksum 0x53858c4c, Offset: 0x2ba0
// Size: 0x5c
function stunfxthink(fx) {
    fx endon(#"death");
    self waittill(#"death", #"not_stunned");
    fx delete();
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0xa2ce211d, Offset: 0x2c08
// Size: 0xc
function isstunned() {
    return isdefined(self.stun_fx);
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0xcbdf457b, Offset: 0x2c20
// Size: 0x4c
function weaponobjectfizzleout() {
    self endon(#"death");
    playfx(level._equipment_fizzleout_fx, self.origin);
    deleteent();
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0x5fcc0c33, Offset: 0x2c78
// Size: 0x16
function resetweaponobjectexplodethisframe() {
    waitframe(1);
    level.weaponobjectexplodethisframe = 0;
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x7b40b13d, Offset: 0x2c98
// Size: 0xb6
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
// Checksum 0xaa696f4a, Offset: 0x2d58
// Size: 0xfa
function getweaponobjectwatcherbyweapon(weapon) {
    if (!isdefined(self.weaponobjectwatcherarray)) {
        return undefined;
    }
    for (watcher = 0; watcher < self.weaponobjectwatcherarray.size; watcher++) {
        if (isdefined(self.weaponobjectwatcherarray[watcher].weapon)) {
            if (self.weaponobjectwatcherarray[watcher].weapon == weapon || self.weaponobjectwatcherarray[watcher].weapon == weapon.rootweapon) {
                return self.weaponobjectwatcherarray[watcher];
            }
            if (isdefined(self.weaponobjectwatcherarray[watcher].altweapon) && self.weaponobjectwatcherarray[watcher].altweapon == weapon) {
                return self.weaponobjectwatcherarray[watcher];
            }
        }
    }
    return undefined;
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x22666b25, Offset: 0x2e60
// Size: 0x8a
function resetweaponobjectwatcher(watcher, ownerteam) {
    if (watcher.deleteonplayerspawn == 1 || isdefined(watcher.ownerteam) && watcher.ownerteam != ownerteam) {
        self notify(#"weapon_object_destroyed");
        watcher deleteweaponobjectarray();
    }
    watcher.ownerteam = ownerteam;
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x4
// Checksum 0x28a556ed, Offset: 0x2ef8
// Size: 0x358
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
        weaponobjectwatcher.deleteonplayerspawn = level.deleteexplosivesonspawn;
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
        weaponobjectwatcher.var_46869d39 = undefined;
        if (!isdefined(weaponobjectwatcher.objectarray)) {
            weaponobjectwatcher.objectarray = [];
        }
    }
    resetweaponobjectwatcher(weaponobjectwatcher, ownerteam);
    return weaponobjectwatcher;
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x4
// Checksum 0x902d1e8e, Offset: 0x3258
// Size: 0x6a
function private createuseweaponobjectwatcher(weaponname, ownerteam) {
    weaponobjectwatcher = createweaponobjectwatcher(weaponname, ownerteam);
    weaponobjectwatcher.type = "use";
    weaponobjectwatcher.onspawn = &onspawnuseweaponobject;
    return weaponobjectwatcher;
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x4
// Checksum 0xddec4ab8, Offset: 0x32d0
// Size: 0x14a
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
// Checksum 0xa97156db, Offset: 0x3428
// Size: 0x2c
function wasproximityalarmactivatedbyself() {
    return isdefined(self.owner.var_a85739ee) && self.owner.var_a85739ee == self;
}

// Namespace weaponobjects/weaponobjects
// Params 3, eflags: 0x0
// Checksum 0x9399497, Offset: 0x3460
// Size: 0x1e4
function proximityalarmactivate(active, watcher, var_355a60a8 = undefined) {
    if (!isplayer(self.owner)) {
        return;
    }
    var_7b136921 = watcher.var_f4383e3a === 1;
    if (active && !isdefined(self.owner.var_a85739ee)) {
        self.owner.var_a85739ee = self;
        state = var_7b136921 ? 3 : 2;
        self setstate(state);
        return;
    }
    if (!isdefined(self) || self wasproximityalarmactivatedbyself() || !var_7b136921 && self.owner clientfield::get_to_player("proximity_alarm") == 1) {
        self.owner.var_a85739ee = undefined;
        state = 0;
        if (var_7b136921) {
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
// Checksum 0xae3bb982, Offset: 0x3650
// Size: 0x118
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
        if (isdefined(watcher) && isdefined(watcher.var_5db8ab6d)) {
            self [[ watcher.var_5db8ab6d ]](curstate, newstate, player.var_a85739ee);
        }
    }
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0xce9a2e1e, Offset: 0x3770
// Size: 0x6f6
function proximityalarmloop(watcher, owner) {
    level endon(#"game_ended");
    self endon(#"death");
    self endon(#"hacked");
    self endon(#"detonating");
    if (self.weapon.proximityalarminnerradius <= 0) {
        return;
    }
    self util::waittillnotmoving();
    var_7b136921 = watcher.var_f4383e3a === 1;
    if (var_7b136921 && !(isdefined(self.owner._disable_proximity_alarms) && self.owner._disable_proximity_alarms)) {
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
    if (!(isdefined(self.owner._disable_proximity_alarms) && self.owner._disable_proximity_alarms)) {
        state = var_7b136921 ? 2 : 1;
        self setstate(state);
    }
    self.proximity_deployed = 1;
    alarmstatusold = "notify";
    alarmstatus = "off";
    var_355a60a8 = undefined;
    while (true) {
        wait 0.05;
        if (!isdefined(self.owner) || !isplayer(self.owner)) {
            return;
        }
        if (isalive(self.owner) == 0 && self.owner util::isusingremote() == 0) {
            self proximityalarmactivate(0, watcher);
            return;
        }
        if (isdefined(self.owner._disable_proximity_alarms) && self.owner._disable_proximity_alarms) {
            self proximityalarmactivate(0, watcher);
        } else if (alarmstatus != alarmstatusold || alarmstatus == "on" && !isdefined(self.owner.var_a85739ee)) {
            if (alarmstatus == "on") {
                self proximityalarmactivate(1, watcher, var_355a60a8);
            } else {
                self proximityalarmactivate(0, watcher);
            }
            alarmstatusold = alarmstatus;
        }
        alarmstatus = "off";
        var_355a60a8 = undefined;
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
            var_355a60a8 = entity;
            break;
        }
    }
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0xc4af08e7, Offset: 0x3e70
// Size: 0x18c
function commononspawnuseweaponobjectproximityalarm(watcher, owner) {
    /#
        if (level.weaponobjectdebug == 1) {
            self thread proximityalarmweaponobjectdebug(watcher);
        }
    #/
    if (isdefined(watcher.var_f4383e3a) && watcher.var_f4383e3a) {
        curstate = self.owner clientfield::get_to_player("proximity_alarm");
        if (curstate != 5) {
            self setstate(0);
        }
    }
    self proximityalarmloop(watcher, owner);
    self proximityalarmactivate(0, watcher);
    if (isdefined(watcher.var_f4383e3a) && watcher.var_f4383e3a) {
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
// Checksum 0xce7aad5f, Offset: 0x4008
// Size: 0x2c
function onspawnuseweaponobject(watcher, owner) {
    self thread commononspawnuseweaponobjectproximityalarm(watcher, owner);
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x9c2d9f95, Offset: 0x4040
// Size: 0x8c
function onspawnproximityweaponobject(watcher, owner) {
    self.protected_entities = [];
    if (isdefined(level._proximityweaponobjectdetonation_override)) {
        self thread [[ level._proximityweaponobjectdetonation_override ]](watcher);
    } else {
        self thread proximityweaponobjectdetonation(watcher);
    }
    /#
        if (level.weaponobjectdebug == 1) {
            self thread proximityweaponobjectdebug(watcher);
        }
    #/
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x40d8
// Size: 0x4
function watchweaponobjectusage() {
    
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0xa118de50, Offset: 0x40e8
// Size: 0x308
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
            waitresult = self waittill(#"grenade_fire", #"grenade_launcher_fire", #"missile_fire", #"placeables_plant");
        }
        weapon_instance = waitresult.projectile;
        weapon = waitresult.weapon;
        if (isdefined(level.projectiles_should_ignore_world_pause) && level.projectiles_should_ignore_world_pause && isdefined(weapon_instance)) {
            weapon_instance setignorepauseworld(1);
        }
        if (isplayer(self) && weapon.setusedstat && !self util::ishacked()) {
            self stats::function_4f10b697(weapon, #"used", 1);
        }
        watcher = getweaponobjectwatcherbyweapon(weapon);
        if (isdefined(watcher)) {
            cleanweaponobjectarray(watcher);
            if (weapon.maxinstancesallowed) {
                if (watcher.objectarray.size > weapon.maxinstancesallowed - 1) {
                    watcher thread waitandfizzleout(watcher.objectarray[0], 0.1);
                    if (isdefined(watcher.var_f4383e3a) && watcher.var_f4383e3a) {
                        watcher.objectarray[0] setstate(5);
                    }
                    watcher.objectarray[0] = undefined;
                    cleanweaponobjectarray(watcher);
                }
            }
            self addweaponobject(watcher, weapon_instance, weapon, endonnotify);
        }
    }
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0xffce9481, Offset: 0x43f8
// Size: 0xa8
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

/#

    // Namespace weaponobjects/weaponobjects
    // Params 5, eflags: 0x0
    // Checksum 0xaeef4919, Offset: 0x44a8
    // Size: 0xb6
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
    // Checksum 0x4aed5fa9, Offset: 0x4568
    // Size: 0x94
    function proximityalarmweaponobjectdebug(watcher) {
        self endon(#"death");
        self util::waittillnotmoving();
        if (!isdefined(self)) {
            return;
        }
        self thread proximitysphere(self.origin, self.weapon.proximityalarminnerradius, (0, 0.75, 0), self.weapon.proximityalarmouterradius, (0, 0.75, 0));
    }

    // Namespace weaponobjects/weaponobjects
    // Params 1, eflags: 0x0
    // Checksum 0x8cedd49f, Offset: 0x4608
    // Size: 0x104
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
    // Checksum 0x804ea9a1, Offset: 0x4718
    // Size: 0x208
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
// Checksum 0x26f5ae60, Offset: 0x4928
// Size: 0x96
function weaponobjectdetectionmovable(ownerteam) {
    self endon(#"end_detection");
    level endon(#"game_ended");
    self endon(#"death");
    self endon(#"hacked");
    if (!level.teambased) {
        return;
    }
    self.detectid = "rcBomb" + gettime() + randomint(1000000);
}

// Namespace weaponobjects/weaponobjects
// Params 3, eflags: 0x0
// Checksum 0x61098d08, Offset: 0x49c8
// Size: 0x76
function seticonpos(item, icon, heightincrease) {
    icon.x = item.origin[0];
    icon.y = item.origin[1];
    icon.z = item.origin[2] + heightincrease;
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0xd6e8373b, Offset: 0x4a48
// Size: 0x6c
function weaponobjectdetectiontrigger_wait(ownerteam) {
    self endon(#"death");
    self endon(#"hacked");
    self endon(#"detonating");
    util::waittillnotmoving();
    self thread weaponobjectdetectiontrigger(ownerteam);
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x7d715a88, Offset: 0x4ac0
// Size: 0x12c
function weaponobjectdetectiontrigger(ownerteam) {
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
// Checksum 0x76c35c4c, Offset: 0x4bf8
// Size: 0x138
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
// Checksum 0x622e4840, Offset: 0x4d38
// Size: 0x3e
function hackernotmoving() {
    self endon(#"death");
    self util::waittillnotmoving();
    self notify(#"landed");
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x4
// Checksum 0xf7bdc852, Offset: 0x4d80
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
// Checksum 0xfc7bdb9, Offset: 0x4de8
// Size: 0x1cc
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
    self.hackertrigger = function_c21b631d(triggerorigin, level.weaponobjects_hacker_trigger_width, level.weaponobjects_hacker_trigger_height);
    self.hackertrigger set_hint_string(self.weapon.var_84bdde4d, #"mp/generic_hacking");
    self.hackertrigger setignoreentfortrigger(self);
    self.hackertrigger setperkfortrigger(#"specialty_disarmexplosive");
    self.hackertrigger thread hackertriggersetvisibility(self.owner);
    /#
    #/
    self thread hackerthink(self.hackertrigger, watcher);
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x60bf1901, Offset: 0x4fc0
// Size: 0xd2
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
// Checksum 0x304fc5, Offset: 0x50a0
// Size: 0x40c
function itemhacked(watcher, player) {
    self proximityalarmactivate(0, watcher);
    self.owner hackerremoveweapon(self);
    if (isdefined(level.playequipmenthackedonplayer)) {
        self.owner [[ level.playequipmenthackedonplayer ]]();
    }
    if (self.weapon.ammocountequipment > 0 && isdefined(self.ammo)) {
        ammoleftequipment = self.ammo;
        if (self.weapon.rootweapon == getweapon(#"trophy_system")) {
            player trophy_system::ammo_weapon_hacked(ammoleftequipment);
        }
    }
    self.hacked = 1;
    self setmissileowner(player);
    self setteam(player.pers[#"team"]);
    self.owner = player;
    self clientfield::set("retrievable", 0);
    if (self.weapon.dohackedstats) {
        scoreevents::processscoreevent(#"hacked", player, undefined, undefined);
        player stats::function_4f10b697(getweapon(#"pda_hack"), #"combatrecordstat", 1);
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
// Checksum 0xc64f600c, Offset: 0x54b8
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
// Checksum 0x52b41ad7, Offset: 0x5550
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
                self.progressbar = player hud::function_8655910c();
                self.progressbar.lastuserate = -1;
                self.progressbar hud::showelem();
                self.progressbar hud::updatebar(0.01, 1 / hacktime);
                self.progresstext = player hud::function_5fc06869();
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
// Checksum 0x195e6c19, Offset: 0x5888
// Size: 0x2d2
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
    if (level.teambased && player.team == owner.team) {
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
// Checksum 0x60846c35, Offset: 0x5b68
// Size: 0x88
function hackerremoveweapon(weapon_instance) {
    for (i = 0; i < self.weaponobjectwatcherarray.size; i++) {
        if (self.weaponobjectwatcherarray[i].weapon != weapon_instance.weapon.rootweapon) {
            continue;
        }
        removeweaponobject(self.weaponobjectwatcherarray[i], weapon_instance);
        return;
    }
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x3c80c893, Offset: 0x5bf8
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
// Checksum 0x3f379eb9, Offset: 0x5cd0
// Size: 0x1e8
function proximityweaponobject_validtriggerentity(watcher, ent) {
    if (level.weaponobjectdebug != 1) {
        if (isdefined(self.owner) && ent == self.owner) {
            return false;
        }
        if (isvehicle(ent)) {
            if (watcher.ignorevehicles) {
                return false;
            }
            if (self.owner === ent.owner) {
                return false;
            }
        }
        if (!damage::friendlyfirecheck(self.owner, ent, 0)) {
            return false;
        }
        if (watcher.ignorevehicles && isai(ent) && !(isdefined(ent.isaiclone) && ent.isaiclone)) {
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
// Checksum 0x198fbff, Offset: 0x5ec0
// Size: 0x5c
function proximityweaponobject_removespawnprotectondeath(ent) {
    self endon(#"death");
    ent waittill(#"death", #"disconnect");
    arrayremovevalue(self.protected_entities, ent);
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x8701ace, Offset: 0x5f28
// Size: 0x104
function proximityweaponobject_spawnprotect(watcher, ent) {
    self endon(#"death");
    ent endon(#"death");
    ent endon(#"disconnect");
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
// Checksum 0xf5de977b, Offset: 0x6038
// Size: 0x114
function proximityweaponobject_isspawnprotected(watcher, ent) {
    if (!isplayer(ent)) {
        return false;
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
// Checksum 0x352dda2c, Offset: 0x6158
// Size: 0x1b0
function proximityweaponobject_dodetonation(watcher, ent, traceorigin) {
    self endon(#"death");
    self endon(#"hacked");
    self notify(#"kill_target_detection");
    if (isdefined(watcher.activatesound)) {
        self playsound(watcher.activatesound);
    }
    wait watcher.detectiongraceperiod;
    if (isplayer(ent) && ent hasperk(#"specialty_delayexplosive")) {
        wait getdvarfloat(#"perk_delayexplosivetime", 0);
    }
    self entityheadicons::setentityheadicon("none");
    self.origin = traceorigin;
    if (isdefined(self.var_93ab7acc)) {
        self.var_93ab7acc placeables::forceshutdown();
    }
    if (isdefined(self.owner) && isplayer(self.owner)) {
        self [[ watcher.ondetonatecallback ]](self.owner, undefined, ent);
        return;
    }
    self [[ watcher.ondetonatecallback ]](undefined, undefined, ent);
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0xdc8c33d4, Offset: 0x6310
// Size: 0x40
function proximityweaponobject_activationdelay(watcher) {
    self util::waittillnotmoving();
    if (watcher.activationdelay) {
        wait watcher.activationdelay;
    }
}

// Namespace weaponobjects/weaponobjects
// Params 3, eflags: 0x0
// Checksum 0xd04e213d, Offset: 0x6358
// Size: 0xdc
function proximityweaponobject_waittillframeendanddodetonation(watcher, ent, traceorigin) {
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
    proximityweaponobject_dodetonation(watcher, ent, traceorigin);
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x9d0fef5d, Offset: 0x6440
// Size: 0x168
function proximityweaponobjectdetonation(watcher) {
    self endon(#"death");
    self endon(#"hacked");
    self endon(#"kill_target_detection");
    proximityweaponobject_activationdelay(watcher);
    damagearea = proximityweaponobject_createdamagearea(watcher);
    up = anglestoup(self.angles);
    traceorigin = self.origin + up;
    while (true) {
        waitresult = damagearea waittill(#"trigger");
        ent = waitresult.activator;
        if (!proximityweaponobject_validtriggerentity(watcher, ent)) {
            continue;
        }
        if (proximityweaponobject_isspawnprotected(watcher, ent)) {
            continue;
        }
        if (ent damageconetrace(traceorigin, self) > 0) {
            thread proximityweaponobject_waittillframeendanddodetonation(watcher, ent, traceorigin);
        }
    }
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x2a2e6373, Offset: 0x65b0
// Size: 0x180
function shouldaffectweaponobject(object, watcher) {
    radius = object.weapon.explosionradius;
    distancesqr = distancesquared(self.origin, object.origin);
    if (radius != 0 && radius * radius < distancesqr) {
        return false;
    }
    pos = self.origin + (0, 0, 32);
    if (isdefined(watcher.ignoredirection)) {
        return true;
    }
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
// Checksum 0x7d7be336, Offset: 0x6738
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
// Checksum 0x36652d67, Offset: 0x6798
// Size: 0x1b2
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
// Checksum 0x103f1fa4, Offset: 0x6958
// Size: 0x1f4
function deleteonkillbrush(player) {
    player endon(#"disconnect");
    self endon(#"death");
    self endon(#"stationary");
    a_killbrushes = getentarray("trigger_hurt_new", "classname");
    self thread testkillbrushonstationary(a_killbrushes, player);
    while (true) {
        a_killbrushes = getentarray("trigger_hurt_new", "classname");
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
// Checksum 0xc4006684, Offset: 0x6b58
// Size: 0xa6
function on_double_tap_detonate() {
    buttontime = 0;
    if (!isalive(self) && !self util::isusingremote()) {
        return;
    }
    for (watcher = 0; watcher < self.weaponobjectwatcherarray.size; watcher++) {
        if (self.weaponobjectwatcherarray[watcher].altdetonate) {
            self.weaponobjectwatcherarray[watcher] detonateweaponobjectarray(0);
        }
    }
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0xea3df7d6, Offset: 0x6c08
// Size: 0xc4
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
// Checksum 0xfb485e, Offset: 0x6cd8
// Size: 0x116
function function_465e8e68(params = undefined) {
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
    // Checksum 0x5af96c67, Offset: 0x6df8
    // Size: 0x64
    function saydamaged(orig, amount) {
        for (i = 0; i < 60; i++) {
            print3d(orig, "<dev string:x57>" + amount);
            waitframe(1);
        }
    }

#/

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x4
// Checksum 0x46827ef6, Offset: 0x6e68
// Size: 0x17c
function private function_2c0c0cac(player, weapon) {
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
// Checksum 0x312553f8, Offset: 0x6ff0
// Size: 0x6c
function private get_ammo(player, weapon) {
    ammo = player getweaponammoclip(weapon);
    if (!weapon.iscliponly) {
        ammo += player getweaponammostock(weapon);
    }
    return ammo;
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x4
// Checksum 0x95d60837, Offset: 0x7068
// Size: 0x7c
function private function_94fffd3d(player, weapon) {
    maxammo = function_2c0c0cac(player, weapon);
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
// Checksum 0x449f96c3, Offset: 0x70f0
// Size: 0x1d6
function function_7971b725(trigger, callback, playersoundonuse, npcsoundonuse) {
    self endon(#"death");
    self endon(#"explode");
    self endon(#"hacked");
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
        heldweapon = player function_9a2e7c7d(self.weapon);
        if (!isdefined(heldweapon)) {
            continue;
        }
        if (!function_94fffd3d(player, heldweapon)) {
            continue;
        }
        if (isdefined(playersoundonuse)) {
            player playlocalsound(playersoundonuse);
        }
        if (isdefined(npcsoundonuse)) {
            player playsound(npcsoundonuse);
        }
        self [[ callback ]](player, heldweapon);
        return;
    }
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0xc478a156, Offset: 0x72d0
// Size: 0x88
function function_f45679a0(pweapons, weapon) {
    foreach (pweapon in pweapons) {
        if (pweapon == weapon) {
            return pweapon;
        }
    }
    return undefined;
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x156f0647, Offset: 0x7360
// Size: 0x98
function function_eefa2f68(pweapons, weapon) {
    foreach (pweapon in pweapons) {
        if (pweapon.rootweapon == weapon.rootweapon) {
            return pweapon;
        }
    }
    return undefined;
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x28ba186e, Offset: 0x7400
// Size: 0x72
function get_held_weapon_match_or_root_match(weapon) {
    pweapons = self getweaponslist(1);
    match = function_f45679a0(pweapons, weapon);
    if (isdefined(match)) {
        return match;
    }
    return function_eefa2f68(pweapons, weapon);
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x24f7f06d, Offset: 0x7480
// Size: 0x98
function function_8d93317(pweapons, weapon) {
    foreach (pweapon in pweapons) {
        if (pweapon.ammoindex == weapon.ammoindex) {
            return pweapon;
        }
    }
    return undefined;
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x49358cd7, Offset: 0x7520
// Size: 0x98
function function_184c5ae3(pweapons, weapon) {
    foreach (pweapon in pweapons) {
        if (pweapon.clipindex == weapon.clipindex) {
            return pweapon;
        }
    }
    return undefined;
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x203ac6cb, Offset: 0x75c0
// Size: 0x72
function function_9a2e7c7d(weapon) {
    pweapons = self getweaponslist(1);
    match = function_184c5ae3(pweapons, weapon);
    if (isdefined(match)) {
        return match;
    }
    return function_8d93317(pweapons, weapon);
}

// Namespace weaponobjects/weaponobjects
// Params 4, eflags: 0x4
// Checksum 0x8337c3e6, Offset: 0x7640
// Size: 0xf8
function private spawn_interact_trigger(type, origin, width, height) {
    if (isdefined(width) && isdefined(height)) {
        trigger = spawn(type, origin, 0, width, height);
    } else {
        trigger = spawn(type, origin);
    }
    trigger sethintlowpriority(1);
    trigger setcursorhint("HINT_NOICON", self);
    trigger enablelinkto();
    trigger linkto(self);
    return trigger;
}

// Namespace weaponobjects/weaponobjects
// Params 3, eflags: 0x4
// Checksum 0xb5d1c749, Offset: 0x7740
// Size: 0x3a
function private function_c21b631d(origin, width, height) {
    return spawn_interact_trigger("trigger_radius_use", origin, width, height);
}

// Namespace weaponobjects/weaponobjects
// Params 3, eflags: 0x4
// Checksum 0x719be577, Offset: 0x7788
// Size: 0x3a
function private function_9ff4df98(origin, width, height) {
    return spawn_interact_trigger("trigger_radius", origin, width, height);
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0xc53936f, Offset: 0x77d0
// Size: 0x3a4
function function_62336657(watcher, player) {
    self endon(#"death");
    self setowner(player);
    self setteam(player.pers[#"team"]);
    self.owner = player;
    self.oldangles = self.angles;
    self util::waittillnotmoving();
    waittillframeend();
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
    if (isdefined(triggerparentent)) {
        triggerorigin = triggerparentent.origin + (0, 0, 10);
    } else {
        up = anglestoup(self.angles);
        triggerorigin = self.origin + up;
    }
    weapon = watcher.weapon;
    if (!self util::ishacked() && "None" != weapon.var_11155358) {
        if (self.weapon.shownretrievable) {
            self clientfield::set("retrievable", 1);
        }
        if (weapon.var_11155358 == "Automatic") {
            function_6a681c9a(watcher, player, triggerorigin);
        } else {
            function_9f128d7f(watcher, player, triggerorigin);
        }
        if (isdefined(triggerparentent)) {
            self.pickuptrigger linkto(triggerparentent);
        }
    }
    if ("None" != weapon.var_ea72b289) {
        function_2c63e01d(watcher, player, triggerorigin);
    }
    /#
        thread switch_team(self, watcher, player);
    #/
    self thread watchshutdown(player);
}

// Namespace weaponobjects/weaponobjects
// Params 3, eflags: 0x0
// Checksum 0xc6fd8e0e, Offset: 0x7b80
// Size: 0x148
function function_9f128d7f(watcher, player, origin) {
    self.pickuptrigger = function_c21b631d(origin);
    self.pickuptrigger setinvisibletoall();
    self.pickuptrigger setvisibletoplayer(player);
    self.pickuptrigger setteamfortrigger(player.pers[#"team"]);
    self.pickuptrigger set_hint_string(self.weapon.var_dc7af9df, #"mp/generic_pickup");
    self thread watchusetrigger(self.pickuptrigger, watcher.pickup, watcher.pickupsoundplayer, watcher.pickupsound, watcher.weapon);
    if (isdefined(watcher.pickup_trigger_listener)) {
        self thread [[ watcher.pickup_trigger_listener ]](self.pickuptrigger, player);
    }
}

// Namespace weaponobjects/weaponobjects
// Params 3, eflags: 0x0
// Checksum 0xa4785f49, Offset: 0x7cd0
// Size: 0x94
function function_6a681c9a(watcher, player, origin) {
    self.pickuptrigger = function_9ff4df98(origin, 50, 50);
    self.pickuptrigger.claimedby = player;
    self thread function_7971b725(self.pickuptrigger, watcher.pickup, watcher.pickupsoundplayer, watcher.pickupsound);
}

// Namespace weaponobjects/weaponobjects
// Params 3, eflags: 0x0
// Checksum 0x6c1cfff7, Offset: 0x7d70
// Size: 0xfc
function function_2c63e01d(watcher, player, origin) {
    self.enemytrigger = function_c21b631d(origin);
    self.enemytrigger setinvisibletoplayer(player);
    if (level.teambased) {
        self.enemytrigger setexcludeteamfortrigger(player.team);
        self.enemytrigger.triggerteamignore = self.team;
    }
    self.enemytrigger set_hint_string(self.weapon.var_15fdec35, #"mp_generic_destroy");
    self thread watchusetrigger(self.enemytrigger, watcher.ondestroyed);
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0x835f796f, Offset: 0x7e78
// Size: 0x1c
function destroyent() {
    self delete();
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x4
// Checksum 0xb0960286, Offset: 0x7ea0
// Size: 0xfc
function private add_ammo(player, weapon) {
    if (weapon.iscliponly || weapon.var_60fc5376 == "Clip Then Ammo") {
        ammo = player getweaponammoclip(weapon);
        ammo++;
        clip_size = weapon.clipsize;
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
// Checksum 0x604dc943, Offset: 0x7fa8
// Size: 0x1c4
function function_449fc98b(player, heldweapon) {
    if (!self.weapon.anyplayercanretrieve && isdefined(self.owner) && self.owner != player) {
        return;
    }
    pickedweapon = self.weapon;
    if (self.weapon.ammocountequipment > 0 && isdefined(self.ammo)) {
        ammoleftequipment = self.ammo;
    }
    self notify(#"picked_up");
    heldweapon = player function_9a2e7c7d(self.weapon);
    if (!isdefined(heldweapon)) {
        return;
    }
    if (isdefined(ammoleftequipment)) {
        if (pickedweapon.rootweapon == getweapon(#"trophy_system")) {
            player trophy_system::ammo_weapon_pickup(ammoleftequipment);
        }
    }
    if ("ammo" != heldweapon.gadget_powerusetype) {
        slot = player gadgetgetslot(heldweapon);
        player gadgetpowerchange(slot, heldweapon.gadget_powergainonretrieve);
        return;
    }
    if (!function_94fffd3d(player, heldweapon)) {
        return;
    }
    add_ammo(player, heldweapon);
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x4ee9455e, Offset: 0x8178
// Size: 0x10c
function function_a07674ea(player, weapon) {
    self notify(#"picked_up");
    if (weapon.gadget_powergainonretrieve > 0) {
        slot = player gadgetgetslot(weapon);
        if (slot >= 0) {
            clipsize = player function_a6978ffa(weapon);
            if (clipsize && weapon.var_1098b992) {
                powergain = weapon.gadget_powergainonretrieve / clipsize;
            } else {
                powergain = weapon.gadget_powergainonretrieve;
            }
            player gadgetpowerchange(slot, powergain);
            return;
        }
    }
    add_ammo(player, weapon);
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x65165f3a, Offset: 0x8290
// Size: 0xa4
function ondestroyed(attacker, data) {
    playfx(level._effect[#"tacticalinsertionfizzle"], self.origin);
    self playsound(#"dst_tac_insert_break");
    if (isdefined(level.playequipmentdestroyedonplayer)) {
        self.owner [[ level.playequipmentdestroyedonplayer ]]();
    }
    self delete();
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0xf2bcc3c, Offset: 0x8340
// Size: 0x124
function watchshutdown(player) {
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
// Params 5, eflags: 0x0
// Checksum 0xa15f6ce4, Offset: 0x8470
// Size: 0x29c
function watchusetrigger(trigger, callback, playersoundonuse, npcsoundonuse, callback_data) {
    self endon(#"death");
    self endon(#"delete");
    self endon(#"hacked");
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
        grenade = player.throwinggrenade;
        weapon = player getcurrentweapon();
        if (weapon.isequipment) {
            grenade = 0;
        }
        if (player usebuttonpressed() && !grenade && !player meleebuttonpressed()) {
            if (isdefined(playersoundonuse)) {
                player playlocalsound(playersoundonuse);
            }
            if (isdefined(npcsoundonuse)) {
                player playsound(npcsoundonuse);
            }
            self thread [[ callback ]](player, callback_data);
        }
    }
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0x966fa59d, Offset: 0x8718
// Size: 0x9c
function setupreconeffect() {
    if (!isdefined(self)) {
        return;
    }
    if (self.weapon.shownenemyexplo || self.weapon.shownenemyequip) {
        if (isdefined(self.hacked) && self.hacked) {
            self clientfield::set("enemyequip", 2);
            return;
        }
        self clientfield::set("enemyequip", 1);
    }
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x3d48c9c1, Offset: 0x87c0
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
// Checksum 0xc0bf693e, Offset: 0x8800
// Size: 0x8a
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
// Checksum 0xd5ff81a5, Offset: 0x8898
// Size: 0xec
function destroy_other_teams_supplemental_watcher_objects(attacker, weapon, radius) {
    if (level.teambased) {
        foreach (team, _ in level.teams) {
            if (team == attacker.team) {
                continue;
            }
            destroy_supplemental_watcher_objects(attacker, team, weapon, radius);
        }
    }
    destroy_supplemental_watcher_objects(attacker, "free", weapon, radius);
}

// Namespace weaponobjects/weaponobjects
// Params 4, eflags: 0x0
// Checksum 0x1c62d733, Offset: 0x8990
// Size: 0x1a8
function destroy_supplemental_watcher_objects(attacker, team, weapon, radius) {
    radiussq = radius * radius;
    foreach (item in level.supplementalwatcherobjects) {
        if (!isdefined(item.weapon)) {
            continue;
        }
        if (distancesquared(item.origin, attacker.origin) > radiussq) {
            continue;
        }
        if (!isdefined(item.owner)) {
            continue;
        }
        if (isdefined(team) && item.owner.team != team) {
            continue;
        } else if (item.owner == attacker) {
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
// Checksum 0xc6a2144b, Offset: 0x8b40
// Size: 0x3c
function add_supplemental_object(object) {
    level.supplementalwatcherobjects[level.supplementalwatcherobjects.size] = object;
    object thread watch_supplemental_object_death();
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0x40923c4d, Offset: 0x8b88
// Size: 0x34
function watch_supplemental_object_death() {
    self waittill(#"death");
    arrayremovevalue(level.supplementalwatcherobjects, self);
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x20ca6586, Offset: 0x8bc8
// Size: 0x74
function function_15617e5c(var_669152f1, var_b5faff62) {
    if (!isdefined(var_669152f1) || var_669152f1 <= 0) {
        return;
    }
    self endon(#"death");
    wait float(var_669152f1) / 1000;
    if (isdefined(var_b5faff62)) {
        self [[ var_b5faff62 ]]();
    }
}

/#

    // Namespace weaponobjects/weaponobjects
    // Params 3, eflags: 0x0
    // Checksum 0x3f30f807, Offset: 0x8c48
    // Size: 0x1c0
    function switch_team(entity, watcher, owner) {
        self notify(#"stop_disarmthink");
        self endon(#"stop_disarmthink");
        self endon(#"death");
        setdvar(#"scr_switch_team", "<dev string:x61>");
        while (true) {
            wait 0.5;
            devgui_int = getdvarint(#"scr_switch_team", 0);
            if (devgui_int != 0) {
                team = "<dev string:x62>";
                if (isdefined(level.getenemyteam) && isdefined(owner) && isdefined(owner.team)) {
                    team = [[ level.getenemyteam ]](owner.team);
                }
                if (isdefined(level.devongetormakebot)) {
                    player = [[ level.devongetormakebot ]](team);
                }
                if (!isdefined(player)) {
                    println("<dev string:x6d>");
                    wait 1;
                    continue;
                }
                entity itemhacked(watcher, player);
                setdvar(#"scr_switch_team", 0);
            }
        }
    }

#/
