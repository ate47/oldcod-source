#using scripts/core_common/array_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/challenges_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/damagefeedback_shared;
#using scripts/core_common/dev_shared;
#using scripts/core_common/entityheadicons_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/hud_util_shared;
#using scripts/core_common/player_shared;
#using scripts/core_common/scoreevents_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/values_shared;
#using scripts/core_common/vehicle_shared;
#using scripts/core_common/weapons/hive_gun;
#using scripts/core_common/weapons/satchel_charge;
#using scripts/core_common/weapons/trophy_system;
#using scripts/core_common/weapons/weaponobjects;
#using scripts/core_common/weapons_shared;

#namespace weaponobjects;

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0x951bb3aa, Offset: 0xc70
// Size: 0x1c4
function init_shared() {
    callback::on_start_gametype(&start_gametype);
    clientfield::register("toplayer", "proximity_alarm", 1, 2, "int");
    clientfield::register("clientuimodel", "hudItems.proximityAlarm", 1, 2, "int");
    clientfield::register("missile", "retrievable", 1, 1, "int");
    clientfield::register("scriptmover", "retrievable", 1, 1, "int");
    clientfield::register("missile", "enemyequip", 1, 2, "int");
    clientfield::register("scriptmover", "enemyequip", 1, 2, "int");
    clientfield::register("missile", "teamequip", 1, 1, "int");
    level.weaponobjectdebug = getdvarint("scr_weaponobject_debug", 0);
    level.supplementalwatcherobjects = [];
    /#
        level thread updatedvars();
    #/
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0x74cbaf35, Offset: 0xe40
// Size: 0x3c
function updatedvars() {
    while (true) {
        level.weaponobjectdebug = getdvarint("scr_weaponobject_debug", 0);
        wait 1;
    }
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0xdfe76a85, Offset: 0xe88
// Size: 0x294
function start_gametype() {
    coneangle = getdvarint("scr_weaponobject_coneangle", 70);
    mindist = getdvarint("scr_weaponobject_mindist", 20);
    graceperiod = getdvarfloat("scr_weaponobject_graceperiod", 0.6);
    radius = getdvarint("scr_weaponobject_radius", 192);
    callback::on_connect(&on_player_connect);
    callback::on_spawned(&on_player_spawned);
    level.watcherweapons = [];
    level.watcherweapons = getwatcherweapons();
    level.retrievableweapons = [];
    level.retrievableweapons = getretrievableweapons();
    level.weaponobjectexplodethisframe = 0;
    if (getdvarstring("scr_deleteexplosivesonspawn") == "") {
        setdvar("scr_deleteexplosivesonspawn", 1);
    }
    level.deleteexplosivesonspawn = getdvarint("scr_deleteexplosivesonspawn");
    level.var_fe156c8c = "_t6/weapon/claymore/fx_claymore_laser";
    level._equipment_spark_fx = "explosions/fx_exp_equipment_lg";
    level._equipment_fizzleout_fx = "explosions/fx_exp_equipment_lg";
    level._equipment_emp_destroy_fx = "killstreaks/fx_emp_explosion_equip";
    level._equipment_explode_fx = "_t6/explosions/fx_exp_equipment";
    level._equipment_explode_fx_lg = "explosions/fx_exp_equipment_lg";
    level._effect["powerLight"] = "weapon/fx_equip_light_os";
    function_6d94050e();
    level.weaponobjects_hacker_trigger_width = 32;
    level.weaponobjects_hacker_trigger_height = 32;
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0x750cea8c, Offset: 0x1128
// Size: 0x244
function function_6d94050e() {
    function_daf3d8b3("hatchet", %MP_HATCHET_PICKUP);
    function_daf3d8b3("claymore", %MP_CLAYMORE_PICKUP);
    function_daf3d8b3("bouncingbetty", %MP_BOUNCINGBETTY_PICKUP);
    function_daf3d8b3("trophy_system", %MP_TROPHY_SYSTEM_PICKUP);
    function_daf3d8b3("acoustic_sensor", %MP_ACOUSTIC_SENSOR_PICKUP);
    function_daf3d8b3("camera_spike", %MP_CAMERA_SPIKE_PICKUP);
    function_daf3d8b3("satchel_charge", %MP_SATCHEL_CHARGE_PICKUP);
    function_daf3d8b3("scrambler", %MP_SCRAMBLER_PICKUP);
    function_daf3d8b3("proximity_grenade", %MP_SHOCK_CHARGE_PICKUP);
    function_25e68262("trophy_system", %MP_TROPHY_SYSTEM_DESTROY);
    function_25e68262("sensor_grenade", %MP_SENSOR_GRENADE_DESTROY);
    function_eb28ef80("claymore", %MP_CLAYMORE_HACKING);
    function_eb28ef80("bouncingbetty", %MP_BOUNCINGBETTY_HACKING);
    function_eb28ef80("trophy_system", %MP_TROPHY_SYSTEM_HACKING);
    function_eb28ef80("acoustic_sensor", %MP_ACOUSTIC_SENSOR_HACKING);
    function_eb28ef80("camera_spike", %MP_CAMERA_SPIKE_HACKING);
    function_eb28ef80("satchel_charge", %MP_SATCHEL_CHARGE_HACKING);
    function_eb28ef80("scrambler", %MP_SCRAMBLER_HACKING);
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0xb7555c66, Offset: 0x1378
// Size: 0x48
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
// Checksum 0x28c4adcc, Offset: 0x13c8
// Size: 0x1ac
function on_player_spawned() {
    self endon(#"disconnect");
    pixbeginevent("onPlayerSpawned");
    if (!isdefined(self.var_5607d0a8)) {
        self function_59d41911();
        self callback::function_25419ce();
        self createclaymorewatcher();
        self creatercbombwatcher();
        self createqrdronewatcher();
        self createplayerhelicopterwatcher();
        self createhatchetwatcher();
        self function_1a67071e();
        self createtactinsertwatcher();
        self hive_gun::function_2347c7c7();
        self setupretrievablewatcher();
        self thread watchweaponobjectusage();
        self.var_5607d0a8 = 1;
    }
    self function_ffc27c85();
    self trophy_system::ammo_reset();
    pixendevent();
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0xe43f1dfe, Offset: 0x1580
// Size: 0xc2
function function_ffc27c85() {
    if (!isdefined(self.weaponobjectwatcherarray)) {
        return undefined;
    }
    team = self.team;
    foreach (watcher in self.weaponobjectwatcherarray) {
        resetweaponobjectwatcher(watcher, team);
    }
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0x5d831fbd, Offset: 0x1650
// Size: 0x12a
function function_59d41911() {
    foreach (index, weapon in level.watcherweapons) {
        self createweaponobjectwatcher(weapon.name, self.team);
    }
    foreach (weapon in level.retrievableweapons) {
        self createweaponobjectwatcher(weapon.name, self.team);
    }
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0xbbc197d2, Offset: 0x1788
// Size: 0xfa
function setupretrievablewatcher() {
    for (i = 0; i < level.retrievableweapons.size; i++) {
        watcher = getweaponobjectwatcherbyweapon(level.retrievableweapons[i]);
        if (isdefined(watcher)) {
            if (!isdefined(watcher.onspawnretrievetriggers)) {
                watcher.onspawnretrievetriggers = &function_26f3ad87;
            }
            if (!isdefined(watcher.ondestroyed)) {
                watcher.ondestroyed = &ondestroyed;
            }
            if (!isdefined(watcher.pickup)) {
                watcher.pickup = &pickup;
            }
        }
    }
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x82a5068, Offset: 0x1890
// Size: 0x120
function createspecialcrossbowwatchertypes(weaponname) {
    watcher = self createuseweaponobjectwatcher(weaponname, self.team);
    watcher.ondetonatecallback = &deleteent;
    watcher.ondamage = &voidondamage;
    if (isdefined(level.b_crossbow_bolt_destroy_on_impact) && level.b_crossbow_bolt_destroy_on_impact) {
        watcher.onspawn = &onspawncrossbowboltimpact;
        watcher.onspawnretrievetriggers = &voidonspawnretrievetriggers;
        watcher.pickup = &voidpickup;
        return;
    }
    watcher.onspawn = &onspawncrossbowbolt;
    watcher.onspawnretrievetriggers = &function_9d76f10c;
    watcher.pickup = &function_f5c0b7dc;
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0x1fe50d8b, Offset: 0x19b8
// Size: 0x9c
function function_1a67071e() {
    createspecialcrossbowwatchertypes("special_crossbow");
    createspecialcrossbowwatchertypes("special_crossbowlh");
    createspecialcrossbowwatchertypes("special_crossbow_dw");
    if (isdefined(level.b_create_upgraded_crossbow_watchers) && level.b_create_upgraded_crossbow_watchers) {
        createspecialcrossbowwatchertypes("special_crossbowlh_upgraded");
        createspecialcrossbowwatchertypes("special_crossbow_dw_upgraded");
    }
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0x81c34049, Offset: 0x1a60
// Size: 0x98
function createhatchetwatcher() {
    watcher = self createuseweaponobjectwatcher("hatchet", self.team);
    watcher.ondetonatecallback = &deleteent;
    watcher.onspawn = &onspawnhatchet;
    watcher.ondamage = &voidondamage;
    watcher.onspawnretrievetriggers = &function_3dc685f8;
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0xbbe02808, Offset: 0x1b00
// Size: 0x48
function createtactinsertwatcher() {
    watcher = self createuseweaponobjectwatcher("tactical_insertion", self.team);
    watcher.playdestroyeddialog = 0;
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0x2588e809, Offset: 0x1b50
// Size: 0xe0
function creatercbombwatcher() {
    watcher = self createuseweaponobjectwatcher("rcbomb", self.team);
    watcher.altdetonate = 0;
    watcher.headicon = 0;
    watcher.ismovable = 1;
    watcher.ownergetsassist = 1;
    watcher.playdestroyeddialog = 0;
    watcher.deleteonkillbrush = 0;
    watcher.ondetonatecallback = level.rcbombonblowup;
    watcher.stuntime = 1;
    watcher.notequipment = 1;
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0x95886637, Offset: 0x1c38
// Size: 0xf8
function createqrdronewatcher() {
    watcher = self createuseweaponobjectwatcher("qrdrone", self.team);
    watcher.altdetonate = 0;
    watcher.headicon = 0;
    watcher.ismovable = 1;
    watcher.ownergetsassist = 1;
    watcher.playdestroyeddialog = 0;
    watcher.deleteonkillbrush = 0;
    watcher.ondetonatecallback = level.qrdroneonblowup;
    watcher.ondamage = level.qrdroneondamage;
    watcher.stuntime = 5;
    watcher.notequipment = 1;
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0xace0703d, Offset: 0x1d38
// Size: 0xc8
function getspikelauncheractivespikecount(watcher) {
    currentitemcount = 0;
    foreach (obj in watcher.objectarray) {
        if (isdefined(obj) && obj.item !== watcher.weapon) {
            currentitemcount++;
        }
    }
    return currentitemcount;
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x97288dc3, Offset: 0x1e08
// Size: 0x100
function watchspikelauncheritemcountchanged(watcher) {
    self endon(#"death");
    lastitemcount = undefined;
    while (true) {
        waitresult = self waittill("weapon_change");
        for (weapon = waitresult.weapon; weapon.name == "spike_launcher"; weapon = self getcurrentweapon()) {
            currentitemcount = getspikelauncheractivespikecount(watcher);
            if (currentitemcount !== lastitemcount) {
                self setcontrolleruimodelvalue("spikeLauncherCounter.spikesReady", currentitemcount);
                lastitemcount = currentitemcount;
            }
            wait 0.1;
        }
    }
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x9e48256f, Offset: 0x1f10
// Size: 0x84
function spikesdetonating(watcher) {
    spikecount = getspikelauncheractivespikecount(watcher);
    if (spikecount > 0) {
        self setcontrolleruimodelvalue("spikeLauncherCounter.blasting", 1);
        wait 2;
        self setcontrolleruimodelvalue("spikeLauncherCounter.blasting", 0);
    }
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0xff4ccde3, Offset: 0x1fa0
// Size: 0x1ac
function createspikelauncherwatcher(weapon) {
    watcher = self createuseweaponobjectwatcher(weapon, self.team);
    watcher.altname = "spike_charge";
    watcher.altweapon = getweapon("spike_charge");
    watcher.altdetonate = 0;
    watcher.watchforfire = 1;
    watcher.hackable = 1;
    watcher.hackertoolradius = level.equipmenthackertoolradius;
    watcher.hackertooltimems = level.equipmenthackertooltimems;
    watcher.headicon = 0;
    watcher.ondetonatecallback = &spikedetonate;
    watcher.onstun = &weaponstun;
    watcher.stuntime = 1;
    watcher.ownergetsassist = 1;
    watcher.detonatestationary = 0;
    watcher.detonationdelay = 0;
    watcher.detonationsound = "wpn_claymore_alert";
    watcher.ondetonationhandle = &spikesdetonating;
    self thread watchspikelauncheritemcountchanged(watcher);
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0xf7eda515, Offset: 0x2158
// Size: 0x70
function createplayerhelicopterwatcher() {
    watcher = self createuseweaponobjectwatcher("helicopter_player", self.team);
    watcher.altdetonate = 1;
    watcher.headicon = 0;
    watcher.notequipment = 1;
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0xccae41df, Offset: 0x21d0
// Size: 0x1bc
function createclaymorewatcher() {
    watcher = self createproximityweaponobjectwatcher("claymore", self.team);
    watcher.watchforfire = 1;
    watcher.ondetonatecallback = &function_8210f5a9;
    watcher.activatesound = "wpn_claymore_alert";
    watcher.hackable = 1;
    watcher.hackertoolradius = level.equipmenthackertoolradius;
    watcher.hackertooltimems = level.equipmenthackertooltimems;
    watcher.ownergetsassist = 1;
    detectionconeangle = getdvarint("scr_weaponobject_coneangle");
    watcher.detectiondot = cos(detectionconeangle);
    watcher.detectionmindist = getdvarint("scr_weaponobject_mindist");
    watcher.detectiongraceperiod = getdvarfloat("scr_weaponobject_graceperiod");
    watcher.detonateradius = getdvarint("scr_weaponobject_radius");
    watcher.onstun = &weaponstun;
    watcher.stuntime = 1;
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x86ed080d, Offset: 0x2398
// Size: 0x14
function voidonspawn(unused0, unused1) {
    
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x9ae72dce, Offset: 0x23b8
// Size: 0xc
function voidondamage(unused0) {
    
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0xba905c28, Offset: 0x23d0
// Size: 0x14
function voidonspawnretrievetriggers(unused0, unused1) {
    
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x76f7e3b1, Offset: 0x23f0
// Size: 0x14
function voidpickup(unused0, unused1) {
    
}

// Namespace weaponobjects/weaponobjects
// Params 3, eflags: 0x0
// Checksum 0xc6646c9a, Offset: 0x2410
// Size: 0x34
function deleteent(attacker, emp, target) {
    self delete();
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0xa4a9f7eb, Offset: 0x2450
// Size: 0x4c
function clearfxondeath(fx) {
    fx endon(#"death");
    self waittill("death", "hacked");
    fx delete();
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0xb108c56e, Offset: 0x24a8
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
// Checksum 0xf18d43a2, Offset: 0x2538
// Size: 0xb0
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
// Checksum 0x5903b5de, Offset: 0x25f0
// Size: 0x104
function delayedspikedetonation(attacker, weapon) {
    if (!isdefined(self.owner.spikedelay)) {
        self.owner.spikedelay = 0;
    }
    delaytime = self.owner.spikedelay;
    owner = self.owner;
    self.owner.spikedelay += 0.3;
    waittillframeend();
    wait delaytime;
    owner.spikedelay -= 0.3;
    if (isdefined(self)) {
        self weapondetonate(attacker, weapon);
    }
}

// Namespace weaponobjects/weaponobjects
// Params 3, eflags: 0x0
// Checksum 0x3560196c, Offset: 0x2700
// Size: 0x7c
function spikedetonate(attacker, weapon, target) {
    if (isdefined(weapon) && weapon.isvalid) {
        if (isdefined(attacker)) {
            if (self.owner util::isenemyplayer(attacker)) {
            }
        }
    }
    thread delayedspikedetonation(attacker, weapon);
}

// Namespace weaponobjects/weaponobjects
// Params 3, eflags: 0x0
// Checksum 0x91e81296, Offset: 0x2788
// Size: 0xc4
function function_8210f5a9(attacker, weapon, target) {
    if (!isdefined(weapon) || !weapon.isemp) {
    }
    if (isdefined(attacker) && self.owner util::isenemyplayer(attacker)) {
        attacker challenges::destroyedexplosive(weapon);
        scoreevents::processscoreevent("destroyed_claymore", attacker, self.owner, weapon);
    }
    weapondetonate(attacker, weapon);
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0xe24b1d5e, Offset: 0x2858
// Size: 0x144
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
        return;
    }
    if (isdefined(self.owner) && isplayer(self.owner)) {
        self.playdialog = 0;
        self detonate(self.owner);
        return;
    }
    self detonate();
}

// Namespace weaponobjects/weaponobjects
// Params 4, eflags: 0x0
// Checksum 0x3c054891, Offset: 0x29a8
// Size: 0xbc
function detonatewhenstationary(object, delay, attacker, weapon) {
    level endon(#"game_ended");
    object endon(#"death");
    object endon(#"hacked");
    object endon(#"detonating");
    if (object isonground() == 0) {
        object waittill("stationary");
    }
    self thread waitanddetonate(object, delay, attacker, weapon);
}

// Namespace weaponobjects/weaponobjects
// Params 4, eflags: 0x0
// Checksum 0xe1c7b331, Offset: 0x2a70
// Size: 0x410
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
    if (isdefined(attacker) && isplayer(attacker) && isdefined(attacker.pers["team"]) && isdefined(object.owner) && isdefined(object.owner.pers["team"])) {
        if (level.teambased) {
            if (attacker.pers["team"] != object.owner.pers["team"]) {
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
// Checksum 0x83cb4efc, Offset: 0x2e88
// Size: 0xcc
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
    if (!isdefined(self.onfizzleout)) {
        self deleteent();
        return;
    }
    object [[ self.onfizzleout ]]();
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x22e8d503, Offset: 0x2f60
// Size: 0x25c
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
// Checksum 0x2cdd4681, Offset: 0x31c8
// Size: 0x8c
function addweaponobjecttowatcher(watchername, weapon_instance) {
    watcher = getweaponobjectwatcher(watchername);
    /#
        assert(isdefined(watcher), "<dev string:x28>" + watchername + "<dev string:x3f>");
    #/
    self addweaponobject(watcher, weapon_instance);
}

// Namespace weaponobjects/weaponobjects
// Params 3, eflags: 0x0
// Checksum 0x338f4a57, Offset: 0x3260
// Size: 0x33c
function addweaponobject(watcher, weapon_instance, weapon) {
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
    weapon_instance thread delete_on_notify(self);
    weapon_instance thread cleanupwatcherondeath(watcher);
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x55ac1f8, Offset: 0x35a8
// Size: 0x84
function cleanupwatcherondeath(watcher) {
    self waittill("death");
    if (isdefined(watcher) && isdefined(watcher.objectarray)) {
        removeweaponobject(watcher, self);
    }
    if (isdefined(self) && self.delete_on_death === 1) {
        self deleteweaponobjectinstance();
    }
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x1dd15a16, Offset: 0x3638
// Size: 0x3c
function weapon_object_timeout(watcher) {
    self endon(#"death");
    wait watcher.timeout;
    self deleteent();
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x6ad57cf2, Offset: 0x3680
// Size: 0x4c
function delete_on_notify(e_player) {
    e_player endon(#"disconnect");
    self endon(#"death");
    e_player waittill("delete_weapon_objects");
    self delete();
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0xaeb22a8f, Offset: 0x36d8
// Size: 0x5c
function function_ae3283b9(weapon_ent) {
    watcher = self getweaponobjectwatcherbyweapon(weapon_ent.weapon);
    if (!isdefined(watcher)) {
        return;
    }
    removeweaponobject(watcher, weapon_ent);
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0xe5edbd7b, Offset: 0x3740
// Size: 0x64
function removeweaponobject(watcher, weapon_ent) {
    watcher.objectarray = array::remove_undefined(watcher.objectarray);
    arrayremovevalue(watcher.objectarray, weapon_ent);
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x83e295f7, Offset: 0x37b0
// Size: 0x38
function cleanweaponobjectarray(watcher) {
    watcher.objectarray = array::remove_undefined(watcher.objectarray);
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x2e220321, Offset: 0x37f0
// Size: 0xf4
function weapon_object_do_damagefeedback(weapon, attacker) {
    if (isdefined(weapon) && isdefined(attacker)) {
        if (weapon.dodamagefeedback) {
            if (level.teambased && self.owner.team != attacker.team) {
                if (damagefeedback::dodamagefeedback(weapon, attacker)) {
                    attacker damagefeedback::update();
                }
                return;
            }
            if (!level.teambased && self.owner != attacker) {
                if (damagefeedback::dodamagefeedback(weapon, attacker)) {
                    attacker damagefeedback::update();
                }
            }
        }
    }
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x920daef0, Offset: 0x38f0
// Size: 0x47c
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
        waitresult = self waittill("damage");
        attacker = waitresult.attacker;
        weapon = waitresult.weapon;
        damage = waitresult.amount;
        type = waitresult.mod;
        idflags = waitresult.flags;
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
        if (level.teambased && isplayer(attacker) && isdefined(self.owner)) {
            if (!level.hardcoremode && self.owner.team == attacker.pers["team"] && self.owner != attacker) {
                continue;
            }
        }
        if (isdefined(watcher.var_c90f5587) && !self [[ watcher.var_c90f5587 ]](watcher, attacker, weapon, damage)) {
            continue;
        }
        if (!isvehicle(self) && !friendlyfirecheck(self.owner, attacker)) {
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
    if (issubstr(type, "MOD_GRENADE_SPLASH") || issubstr(type, "MOD_GRENADE") || isdefined(type) && issubstr(type, "MOD_EXPLOSIVE")) {
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
// Checksum 0x8c415a24, Offset: 0x3d78
// Size: 0x8c
function playdialogondeath(owner) {
    owner endon(#"death");
    owner endon(#"disconnect");
    self endon(#"hacked");
    self waittill("death");
    if (isdefined(self.playdialog) && self.playdialog) {
        if (isdefined(level.playequipmentdestroyedonplayer)) {
            owner [[ level.playequipmentdestroyedonplayer ]]();
        }
    }
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0xdbebce40, Offset: 0x3e10
// Size: 0xd0
function watchobjectdamage(owner) {
    owner endon(#"death");
    owner endon(#"disconnect");
    self endon(#"hacked");
    self endon(#"death");
    while (true) {
        waitresult = self waittill("damage");
        if (isdefined(waitresult.attacker) && isplayer(waitresult.attacker) && waitresult.attacker != owner) {
            self.playdialog = 1;
            continue;
        }
        self.playdialog = 0;
    }
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x1a8fe231, Offset: 0x3ee8
// Size: 0x12c
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
        self.owner val::set("weaponobjects", "freezecontrols", 1);
    }
    if (isdefined(time)) {
        wait time;
    } else {
        return;
    }
    if (watcher.name == "rcbomb") {
        self.owner val::reset("weaponobjects", "freezecontrols");
    }
    self stunstop();
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0x61f89499, Offset: 0x4020
// Size: 0x20
function stunstop() {
    self notify(#"not_stunned");
    if (isdefined(self.camerahead)) {
    }
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0x65ce4bd0, Offset: 0x4048
// Size: 0x10c
function weaponstun() {
    self endon(#"death");
    self endon(#"not_stunned");
    origin = self gettagorigin("tag_fx");
    if (!isdefined(origin)) {
        origin = self.origin + (0, 0, 10);
    }
    self.stun_fx = spawn("script_model", origin);
    self.stun_fx setmodel("tag_origin");
    self thread stunfxthink(self.stun_fx);
    wait 0.1;
    playfxontag(level._equipment_spark_fx, self.stun_fx, "tag_origin");
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x308b86c9, Offset: 0x4160
// Size: 0x4c
function stunfxthink(fx) {
    fx endon(#"death");
    self waittill("death", "not_stunned");
    fx delete();
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0x974a782, Offset: 0x41b8
// Size: 0x10
function isstunned() {
    return isdefined(self.stun_fx);
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0x8a5c7b86, Offset: 0x41d0
// Size: 0x44
function weaponobjectfizzleout() {
    self endon(#"death");
    playfx(level._equipment_fizzleout_fx, self.origin);
    deleteent();
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0x5d776cfc, Offset: 0x4220
// Size: 0x18
function resetweaponobjectexplodethisframe() {
    waitframe(1);
    level.weaponobjectexplodethisframe = 0;
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x1b82c73b, Offset: 0x4240
// Size: 0xca
function getweaponobjectwatcher(name) {
    if (!isdefined(self.weaponobjectwatcherarray)) {
        return undefined;
    }
    for (watcher = 0; watcher < self.weaponobjectwatcherarray.size; watcher++) {
        if (isdefined(self.weaponobjectwatcherarray[watcher].altname) && (self.weaponobjectwatcherarray[watcher].name == name || self.weaponobjectwatcherarray[watcher].altname == name)) {
            return self.weaponobjectwatcherarray[watcher];
        }
    }
    return undefined;
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x6c83f0a9, Offset: 0x4318
// Size: 0x182
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
            if (isdefined(self.weaponobjectwatcherarray[watcher].var_1ededbfb) && isdefined(self.weaponobjectwatcherarray[watcher].var_1ededbfb[weapon.name])) {
                return self.weaponobjectwatcherarray[watcher];
            }
        }
    }
    return undefined;
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x805567d3, Offset: 0x44a8
// Size: 0x90
function resetweaponobjectwatcher(watcher, ownerteam) {
    if (isdefined(watcher.ownerteam) && (watcher.deleteonplayerspawn == 1 || watcher.ownerteam != ownerteam)) {
        self notify(#"weapon_object_destroyed");
        watcher deleteweaponobjectarray();
    }
    watcher.ownerteam = ownerteam;
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0xec8b031a, Offset: 0x4540
// Size: 0x3a8
function createweaponobjectwatcher(weaponname, ownerteam) {
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
        weaponobjectwatcher.headicon = 0;
        weaponobjectwatcher.stuntime = 0;
        weaponobjectwatcher.timeout = 0;
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
        weaponobjectwatcher.var_c90f5587 = undefined;
        weaponobjectwatcher.onsupplementaldetonatecallback = undefined;
        if (!isdefined(weaponobjectwatcher.objectarray)) {
            weaponobjectwatcher.objectarray = [];
        }
    }
    resetweaponobjectwatcher(weaponobjectwatcher, ownerteam);
    return weaponobjectwatcher;
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0xf8e3daa2, Offset: 0x48f0
// Size: 0x6c
function createuseweaponobjectwatcher(weaponname, ownerteam) {
    weaponobjectwatcher = createweaponobjectwatcher(weaponname, ownerteam);
    weaponobjectwatcher.type = "use";
    weaponobjectwatcher.onspawn = &onspawnuseweaponobject;
    return weaponobjectwatcher;
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x5a6349ea, Offset: 0x4968
// Size: 0x12c
function createproximityweaponobjectwatcher(weaponname, ownerteam) {
    weaponobjectwatcher = createweaponobjectwatcher(weaponname, ownerteam);
    weaponobjectwatcher.type = "proximity";
    weaponobjectwatcher.onspawn = &onspawnproximityweaponobject;
    detectionconeangle = getdvarint("scr_weaponobject_coneangle");
    weaponobjectwatcher.detectiondot = cos(detectionconeangle);
    weaponobjectwatcher.detectionmindist = getdvarint("scr_weaponobject_mindist");
    weaponobjectwatcher.detectiongraceperiod = getdvarfloat("scr_weaponobject_graceperiod");
    weaponobjectwatcher.detonateradius = getdvarint("scr_weaponobject_radius");
    return weaponobjectwatcher;
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x1971acd1, Offset: 0x4aa0
// Size: 0x254
function commononspawnuseweaponobject(watcher, owner) {
    level endon(#"game_ended");
    self endon(#"death");
    self endon(#"hacked");
    if (watcher.detectable) {
        if (watcher.headicon && level.teambased) {
            self util::waittillnotmoving();
            if (isdefined(self)) {
                offset = self.weapon.weaponheadobjectiveheight;
                v_up = anglestoup(self.angles);
                x_offset = abs(v_up[0]);
                y_offset = abs(v_up[1]);
                z_offset = abs(v_up[2]);
                if (x_offset > y_offset && x_offset > z_offset) {
                } else if (y_offset > x_offset && y_offset > z_offset) {
                } else if (z_offset > x_offset && z_offset > y_offset) {
                    v_up *= (0, 0, 1);
                }
                var_c6d8a6a = v_up * offset;
                up_offset = anglestoup(self.angles) * offset;
                objective = getequipmentheadobjective(self.weapon);
                self entityheadicons::setentityheadicon(owner.pers["team"], owner, up_offset, objective);
            }
        }
    }
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0xa36e8171, Offset: 0x4d00
// Size: 0x32
function wasproximityalarmactivatedbyself() {
    return isdefined(self.owner.var_697efff3) && self.owner.var_697efff3 == self;
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x9d76009e, Offset: 0x4d40
// Size: 0x16c
function proximityalarmactivate(active, watcher) {
    if (!isdefined(self.owner) || !isplayer(self.owner)) {
        return;
    }
    if (active && !isdefined(self.owner.var_697efff3)) {
        self.owner.var_697efff3 = self;
        self.owner clientfield::set_to_player("proximity_alarm", 2);
        self.owner clientfield::set_player_uimodel("hudItems.proximityAlarm", 2);
        return;
    }
    if (!isdefined(self) || self wasproximityalarmactivatedbyself() || self.owner clientfield::get_to_player("proximity_alarm") == 1) {
        self.owner.var_697efff3 = undefined;
        self.owner clientfield::set_to_player("proximity_alarm", 0);
        self.owner clientfield::set_player_uimodel("hudItems.proximityAlarm", 0);
    }
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0xbb30bbc8, Offset: 0x4eb8
// Size: 0x6d2
function proximityalarmloop(watcher, owner) {
    level endon(#"game_ended");
    self endon(#"death");
    self endon(#"hacked");
    self endon(#"detonating");
    if (self.weapon.proximityalarminnerradius <= 0) {
        return;
    }
    self util::waittillnotmoving();
    delaytimesec = self.weapon.proximityalarmactivationdelay / 1000;
    if (delaytimesec > 0) {
        wait delaytimesec;
        if (!isdefined(self)) {
            return;
        }
    }
    if (!(isdefined(self.owner._disable_proximity_alarms) && self.owner._disable_proximity_alarms)) {
        self.owner clientfield::set_to_player("proximity_alarm", 1);
        self.owner clientfield::set_player_uimodel("hudItems.proximityAlarm", 1);
    }
    self.proximity_deployed = 1;
    alarmstatusold = "notify";
    alarmstatus = "off";
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
        } else if (alarmstatus == "on" && (alarmstatus != alarmstatusold || !isdefined(self.owner.var_697efff3))) {
            if (alarmstatus == "on") {
                if (alarmstatusold == "off" && isdefined(watcher) && isdefined(watcher.proximityalarmactivatesound)) {
                    playsoundatposition(watcher.proximityalarmactivatesound, self.origin + (0, 0, 32));
                }
                self proximityalarmactivate(1, watcher);
            } else {
                self proximityalarmactivate(0, watcher);
            }
            alarmstatusold = alarmstatus;
        }
        alarmstatus = "off";
        actors = getactorarray();
        players = getplayers();
        detectentities = arraycombine(players, actors, 0, 0);
        foreach (entity in detectentities) {
            wait 0.05;
            if (!isdefined(entity)) {
                continue;
            }
            owner = entity;
            if (!isdefined(entity.isaiclone) || isactor(entity) && !entity.isaiclone) {
                continue;
            } else if (isactor(entity)) {
                owner = entity.owner;
            }
            if (entity.team == "spectator") {
                continue;
            }
            if (level.weaponobjectdebug != 1) {
                if (owner hasperk("specialty_detectexplosive")) {
                    continue;
                }
                if (isdefined(self.owner) && owner == self.owner) {
                    continue;
                }
                if (!friendlyfirecheck(self.owner, owner, 0)) {
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
            break;
        }
    }
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x83891564, Offset: 0x5598
// Size: 0x7c
function commononspawnuseweaponobjectproximityalarm(watcher, owner) {
    /#
        if (level.weaponobjectdebug == 1) {
            self thread proximityalarmweaponobjectdebug(watcher);
        }
    #/
    self proximityalarmloop(watcher, owner);
    self proximityalarmactivate(0, watcher);
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x665be76e, Offset: 0x5620
// Size: 0x54
function onspawnuseweaponobject(watcher, owner) {
    self thread commononspawnuseweaponobject(watcher, owner);
    self thread commononspawnuseweaponobjectproximityalarm(watcher, owner);
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0xc573eb55, Offset: 0x5680
// Size: 0xb4
function onspawnproximityweaponobject(watcher, owner) {
    self.protected_entities = [];
    self thread commononspawnuseweaponobject(watcher, owner);
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
// Checksum 0x31df986a, Offset: 0x5740
// Size: 0xec
function watchweaponobjectusage() {
    self endon(#"disconnect");
    if (!isdefined(self.weaponobjectwatcherarray)) {
        self.weaponobjectwatcherarray = [];
    }
    self thread watchweaponobjectspawn("grenade_fire");
    self thread watchweaponobjectspawn("grenade_launcher_fire");
    self thread watchweaponobjectspawn("missile_fire");
    self thread function_197a78e0();
    self thread function_953cfad3();
    self thread function_efc7ac4();
    self thread function_ca88d4ff();
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x8b5b8a05, Offset: 0x5838
// Size: 0x220
function watchweaponobjectspawn(notify_type) {
    self notify("watchWeaponObjectSpawn_" + notify_type);
    self endon("watchWeaponObjectSpawn_" + notify_type, #"disconnect");
    while (true) {
        waitresult = self waittill(notify_type);
        weapon_instance = waitresult.projectile;
        weapon = waitresult.weapon;
        if (isdefined(level.projectiles_should_ignore_world_pause) && level.projectiles_should_ignore_world_pause && isdefined(weapon_instance)) {
            weapon_instance setignorepauseworld(1);
        }
        if (weapon.setusedstat && !self util::ishacked()) {
            self addweaponstat(weapon, "used", 1);
        }
        watcher = getweaponobjectwatcherbyweapon(weapon);
        if (isdefined(watcher)) {
            cleanweaponobjectarray(watcher);
            if (weapon.maxinstancesallowed) {
                if (watcher.objectarray.size > weapon.maxinstancesallowed - 1) {
                    watcher thread waitandfizzleout(watcher.objectarray[0], 0.1);
                    watcher.objectarray[0] = undefined;
                    cleanweaponobjectarray(watcher);
                }
            }
            self addweaponobject(watcher, weapon_instance, weapon);
        }
    }
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x4d98d4cf, Offset: 0x5a60
// Size: 0xc8
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
    // Checksum 0xa2565d2e, Offset: 0x5b30
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
    // Checksum 0x5f24582, Offset: 0x5be8
    // Size: 0x9c
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
    // Checksum 0x34b67701, Offset: 0x5c90
    // Size: 0x10c
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
    // Checksum 0xcc03d342, Offset: 0x5da8
    // Size: 0x22a
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
// Checksum 0x5506d59c, Offset: 0x5fe0
// Size: 0x80
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
// Checksum 0xc7755d55, Offset: 0x6068
// Size: 0x88
function seticonpos(item, icon, heightincrease) {
    icon.x = item.origin[0];
    icon.y = item.origin[1];
    icon.z = item.origin[2] + heightincrease;
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x7bfafe33, Offset: 0x60f8
// Size: 0x5c
function weaponobjectdetectiontrigger_wait(ownerteam) {
    self endon(#"death");
    self endon(#"hacked");
    self endon(#"detonating");
    util::waittillnotmoving();
    self thread weaponobjectdetectiontrigger(ownerteam);
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0xb3562c82, Offset: 0x6160
// Size: 0x11c
function weaponobjectdetectiontrigger(ownerteam) {
    trigger = spawn("trigger_radius", self.origin - (0, 0, 128), 0, 512, 256);
    trigger.detectid = "trigger" + gettime() + randomint(1000000);
    trigger sethintlowpriority(1);
    self waittill("death", "hacked", "detonating");
    trigger notify(#"end_detection");
    if (isdefined(trigger.bombsquadicon)) {
        trigger.bombsquadicon destroy();
    }
    trigger delete();
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x8aa9a640, Offset: 0x6288
// Size: 0x118
function hackertriggersetvisibility(owner) {
    self endon(#"death");
    /#
        assert(isplayer(owner));
    #/
    ownerteam = owner.pers["team"];
    for (;;) {
        if (level.teambased) {
            self setvisibletoallexceptteam(ownerteam);
            self setexcludeteamfortrigger(ownerteam);
        } else {
            self setvisibletoall();
            self setteamfortrigger("none");
        }
        if (isdefined(owner)) {
            self setinvisibletoplayer(owner);
        }
        level waittill("player_spawned", "joined_team");
    }
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0x6d67c3e4, Offset: 0x63a8
// Size: 0x32
function hackernotmoving() {
    self endon(#"death");
    self util::waittillnotmoving();
    self notify(#"landed");
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x18311e3c, Offset: 0x63e8
// Size: 0x28c
function hackerinit(watcher) {
    self thread hackernotmoving();
    event = self waittill("death", "landed");
    if (event._notify == "death") {
        return;
    }
    if (!isdefined(self)) {
        return;
    }
    triggerorigin = self.origin;
    if ("" != self.weapon.hackertriggerorigintag) {
        triggerorigin = self gettagorigin(self.weapon.hackertriggerorigintag);
    }
    self.hackertrigger = spawn("trigger_radius_use", triggerorigin, 0, level.weaponobjects_hacker_trigger_width, level.weaponobjects_hacker_trigger_height);
    /#
    #/
    self.hackertrigger sethintlowpriority(1);
    self.hackertrigger setcursorhint("HINT_NOICON", self);
    self.hackertrigger setignoreentfortrigger(self);
    self.hackertrigger enablelinkto();
    self.hackertrigger linkto(self);
    if (isdefined(level.var_e496dff3[self.weapon.name])) {
        self.hackertrigger sethintstring(level.var_e496dff3[self.weapon.name].hint);
    } else {
        self.hackertrigger sethintstring(%MP_GENERIC_HACKING);
    }
    self.hackertrigger setperkfortrigger("specialty_disarmexplosive");
    self.hackertrigger thread hackertriggersetvisibility(self.owner);
    self thread hackerthink(self.hackertrigger, watcher);
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x156c6cbe, Offset: 0x6680
// Size: 0xb2
function hackerthink(trigger, watcher) {
    self endon(#"death");
    for (;;) {
        waitresult = trigger waittill("trigger");
        if (!isdefined(waitresult.is_instant) && !trigger hackerresult(waitresult.activator, self.owner)) {
            continue;
        }
        self itemhacked(watcher, waitresult.activator);
        return;
    }
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x188c74cb, Offset: 0x6740
// Size: 0x3cc
function itemhacked(watcher, player) {
    self proximityalarmactivate(0, watcher);
    self.owner hackerremoveweapon(self);
    if (isdefined(level.playequipmenthackedonplayer)) {
        self.owner [[ level.playequipmenthackedonplayer ]]();
    }
    if (self.weapon.ammocountequipment > 0 && isdefined(self.ammo)) {
        ammoleftequipment = self.ammo;
        if (self.weapon.rootweapon == getweapon("trophy_system")) {
            player trophy_system::ammo_weapon_hacked(ammoleftequipment);
        }
    }
    self.hacked = 1;
    self setmissileowner(player);
    self setteam(player.pers["team"]);
    self.owner = player;
    self clientfield::set("retrievable", 0);
    if (self.weapon.dohackedstats) {
        scoreevents::processscoreevent("hacked", player);
        player addweaponstat(getweapon("pda_hack"), "CombatRecordStat", 1);
        player challenges::hackedordestroyedequipment();
    }
    if (self.weapon.rootweapon == level.weaponsatchelcharge && isdefined(player.lowermessage)) {
        player.lowermessage settext(%PLATFORM_SATCHEL_CHARGE_DOUBLE_TAP);
        player.lowermessage.alpha = 1;
        player.lowermessage fadeovertime(2);
        player.lowermessage.alpha = 0;
    }
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
// Checksum 0x74921d56, Offset: 0x6b18
// Size: 0x7c
function hackerunfreezeplayer(player) {
    self endon(#"hack_done");
    self waittill("death");
    if (isdefined(player)) {
        player val::reset("gameobjects", "freezecontrols");
        player val::reset("gameobjects", "disable_weapons");
    }
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x9f5328a0, Offset: 0x6ba0
// Size: 0x31e
function hackerresult(player, owner) {
    success = 1;
    time = gettime();
    hacktime = getdvarfloat("perk_disarmExplosiveTime");
    if (!canhack(player, owner, 1)) {
        return 0;
    }
    self thread hackerunfreezeplayer(player);
    while (time + hacktime * 1000 > gettime()) {
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
        player val::set("gameobjects", "freezecontrols");
        player val::set("gameobjects", "disable_weapons");
        if (!isdefined(self.progressbar)) {
            self.progressbar = player hud::createprimaryprogressbar();
            self.progressbar.lastuserate = -1;
            self.progressbar hud::showelem();
            self.progressbar hud::updatebar(0.01, 1 / hacktime);
            self.progresstext = player hud::createprimaryprogressbartext();
            self.progresstext settext(%MP_HACKING);
            self.progresstext hud::showelem();
            player playlocalsound("evt_hacker_hacking");
        }
        waitframe(1);
    }
    if (isdefined(player)) {
        player val::reset("gameobjects", "freezecontrols");
        player val::reset("gameobjects", "disable_weapons");
    }
    if (isdefined(self.progressbar)) {
        self.progressbar hud::destroyelem();
        self.progresstext hud::destroyelem();
    }
    if (isdefined(self)) {
        self notify(#"hack_done");
    }
    return success;
}

// Namespace weaponobjects/weaponobjects
// Params 3, eflags: 0x0
// Checksum 0xe5a81431, Offset: 0x6ec8
// Size: 0x332
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
    if (!player hasperk("specialty_disarmexplosive")) {
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
// Checksum 0x56826f0f, Offset: 0x7208
// Size: 0x98
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
// Checksum 0xfa16a25f, Offset: 0x72a8
// Size: 0xd8
function proximityweaponobject_createdamagearea(watcher) {
    damagearea = spawn("trigger_radius", self.origin + (0, 0, 0 - watcher.detonateradius), level.aitriggerspawnflags | level.vehicletriggerspawnflags, watcher.detonateradius, watcher.detonateradius * 2);
    damagearea enablelinkto();
    damagearea linkto(self);
    self thread deleteondeath(damagearea);
    return damagearea;
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x2c4828fe, Offset: 0x7388
// Size: 0x216
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
        if (!friendlyfirecheck(self.owner, ent, 0)) {
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
// Checksum 0x14990114, Offset: 0x75a8
// Size: 0x4c
function proximityweaponobject_removespawnprotectondeath(ent) {
    self endon(#"death");
    ent waittill("death", "disconnected");
    arrayremovevalue(self.protected_entities, ent);
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x53ab7086, Offset: 0x7600
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
// Checksum 0xf0a6b8ff, Offset: 0x7710
// Size: 0x12c
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
// Checksum 0x58dfae2d, Offset: 0x7848
// Size: 0x178
function proximityweaponobject_dodetonation(watcher, ent, traceorigin) {
    self endon(#"death");
    self endon(#"hacked");
    self notify(#"kill_target_detection");
    if (isdefined(watcher.activatesound)) {
        self playsound(watcher.activatesound);
    }
    wait watcher.detectiongraceperiod;
    if (isplayer(ent) && ent hasperk("specialty_delayexplosive")) {
        wait getdvarfloat("perk_delayExplosiveTime");
    }
    self entityheadicons::setentityheadicon("none");
    self.origin = traceorigin;
    if (isdefined(self.owner) && isplayer(self.owner)) {
        self [[ watcher.ondetonatecallback ]](self.owner, undefined, ent);
        return;
    }
    self [[ watcher.ondetonatecallback ]](undefined, undefined, ent);
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x432b7b16, Offset: 0x79c8
// Size: 0x44
function proximityweaponobject_activationdelay(watcher) {
    self util::waittillnotmoving();
    if (watcher.activationdelay) {
        wait watcher.activationdelay;
    }
}

// Namespace weaponobjects/weaponobjects
// Params 3, eflags: 0x0
// Checksum 0x6408324b, Offset: 0x7a18
// Size: 0xd4
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
// Checksum 0x7be43e72, Offset: 0x7af8
// Size: 0x178
function proximityweaponobjectdetonation(watcher) {
    self endon(#"death");
    self endon(#"hacked");
    self endon(#"kill_target_detection");
    proximityweaponobject_activationdelay(watcher);
    damagearea = proximityweaponobject_createdamagearea(watcher);
    up = anglestoup(self.angles);
    traceorigin = self.origin + up;
    while (true) {
        waitresult = damagearea waittill("trigger");
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
// Checksum 0x55269088, Offset: 0x7c78
// Size: 0x1ac
function shouldaffectweaponobject(object, watcher) {
    radius = object.weapon.explosionradius;
    distancesqr = distancesquared(self.origin, object.origin);
    if (radius * radius < distancesqr) {
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
// Checksum 0xc85f8960, Offset: 0x7e30
// Size: 0x4c
function deleteondeath(ent) {
    self waittill("death", "hacked");
    waitframe(1);
    if (isdefined(ent)) {
        ent delete();
    }
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0xb490b33f, Offset: 0x7e88
// Size: 0x164
function testkillbrushonstationary(a_killbrushes, player) {
    player endon(#"disconnect");
    self endon(#"death");
    self waittill("stationary");
    foreach (trig in a_killbrushes) {
        if (isdefined(trig) && self istouching(trig)) {
            if (!trig istriggerenabled()) {
                continue;
            }
            if (isdefined(self.spawnflags) && (self.spawnflags & 2) == 2) {
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
// Checksum 0x8b0c6a46, Offset: 0x7ff8
// Size: 0x194
function deleteonkillbrush(player) {
    player endon(#"disconnect");
    self endon(#"death");
    self endon(#"stationary");
    a_killbrushes = getentarray("trigger_hurt", "classname");
    self thread testkillbrushonstationary(a_killbrushes, player);
    while (true) {
        a_killbrushes = getentarray("trigger_hurt", "classname");
        for (i = 0; i < a_killbrushes.size; i++) {
            if (self istouching(a_killbrushes[i])) {
                if (!a_killbrushes[i] istriggerenabled()) {
                    continue;
                }
                if (isdefined(self.spawnflags) && (self.spawnflags & 2) == 2) {
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
// Checksum 0x9ab1c404, Offset: 0x8198
// Size: 0xca
function function_953cfad3() {
    self endon(#"disconnect");
    while (true) {
        self waittill("alt_detonate");
        if (!isalive(self) || self util::isusingremote()) {
            continue;
        }
        for (watcher = 0; watcher < self.weaponobjectwatcherarray.size; watcher++) {
            if (self.weaponobjectwatcherarray[watcher].altdetonate) {
                self.weaponobjectwatcherarray[watcher] detonateweaponobjectarray(0);
            }
        }
    }
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0x2f931774, Offset: 0x8270
// Size: 0x8c
function function_efc7ac4() {
    self endon(#"disconnect");
    level endon(#"game_ended");
    buttontime = 0;
    for (;;) {
        self waittill("doubletap_detonate");
        if (!isalive(self) && !self util::isusingremote()) {
            continue;
        }
        self notify(#"hash_1a071f19");
        waitframe(1);
    }
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0x32eb3bcc, Offset: 0x8308
// Size: 0xf8
function function_197a78e0() {
    self endon(#"disconnect");
    while (true) {
        self waittill("detonate");
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
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0x16d15825, Offset: 0x8408
// Size: 0x146
function function_3f1ca510() {
    if (!isdefined(self.weaponobjectwatcherarray)) {
        /#
            assert("<dev string:x4f>");
        #/
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

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0x1f022bc3, Offset: 0x8558
// Size: 0x24
function function_cdcd002f() {
    self waittill("disconnect");
    function_3f1ca510();
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0x73afee23, Offset: 0x8588
// Size: 0xb0
function function_ca88d4ff() {
    self thread function_cdcd002f();
    self endon(#"disconnect");
    if (!isplayer(self)) {
        return;
    }
    while (true) {
        msg = self waittill("joined_team", "joined_spectators", "death", "disconnect");
        if (msg._notify == "death") {
            continue;
        }
        function_3f1ca510();
    }
}

/#

    // Namespace weaponobjects/weaponobjects
    // Params 2, eflags: 0x0
    // Checksum 0x6e1f15e0, Offset: 0x8640
    // Size: 0x6c
    function saydamaged(orig, amount) {
        for (i = 0; i < 60; i++) {
            print3d(orig, "<dev string:x68>" + amount);
            waitframe(1);
        }
    }

#/

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0xa23cbdc9, Offset: 0x86b8
// Size: 0x2b0
function showheadicon(trigger) {
    var_57765671 = trigger.detectid;
    var_146856e1 = -1;
    for (index = 0; index < 4; index++) {
        detectid = self.var_d1c344c9[index].detectid;
        if (detectid == var_57765671) {
            return;
        }
        if (detectid == "") {
            var_146856e1 = index;
        }
    }
    if (var_146856e1 < 0) {
        return;
    }
    self.var_7d22ed55[var_57765671] = 1;
    self.var_d1c344c9[var_146856e1].x = trigger.origin[0];
    self.var_d1c344c9[var_146856e1].y = trigger.origin[1];
    self.var_d1c344c9[var_146856e1].z = trigger.origin[2] + 24 + 128;
    self.var_d1c344c9[var_146856e1] fadeovertime(0.25);
    self.var_d1c344c9[var_146856e1].alpha = 1;
    self.var_d1c344c9[var_146856e1].detectid = trigger.detectid;
    while (isalive(self) && isdefined(trigger) && self istouching(trigger)) {
        waitframe(1);
    }
    if (!isdefined(self)) {
        return;
    }
    self.var_d1c344c9[var_146856e1].detectid = "";
    self.var_d1c344c9[var_146856e1] fadeovertime(0.25);
    self.var_d1c344c9[var_146856e1].alpha = 0;
    self.var_7d22ed55[var_57765671] = undefined;
}

// Namespace weaponobjects/weaponobjects
// Params 3, eflags: 0x0
// Checksum 0x52c78e4e, Offset: 0x8970
// Size: 0x238
function friendlyfirecheck(owner, attacker, forcedfriendlyfirerule) {
    if (!isdefined(owner)) {
        return true;
    }
    if (!level.teambased) {
        return true;
    }
    friendlyfirerule = [[ level.figure_out_friendly_fire ]](undefined);
    if (isdefined(forcedfriendlyfirerule)) {
        friendlyfirerule = forcedfriendlyfirerule;
    }
    if (friendlyfirerule != 0) {
        return true;
    }
    if (attacker == owner) {
        return true;
    }
    if (isplayer(attacker)) {
        if (!isdefined(attacker.pers["team"])) {
            return true;
        }
        if (attacker.pers["team"] != owner.pers["team"]) {
            return true;
        }
    } else if (isactor(attacker)) {
        if (attacker.team != owner.pers["team"]) {
            return true;
        }
    } else if (isvehicle(attacker)) {
        if (isdefined(attacker.owner) && isplayer(attacker.owner)) {
            if (attacker.owner.pers["team"] != owner.pers["team"]) {
                return true;
            }
        } else {
            occupant_team = attacker vehicle::vehicle_get_occupant_team();
            if (occupant_team != owner.pers["team"] && occupant_team != "spectator") {
                return true;
            }
        }
    }
    return false;
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0xa95ff7e5, Offset: 0x8bb0
// Size: 0x3c
function onspawnhatchet(watcher, player) {
    if (isdefined(level.playthrowhatchet)) {
        player [[ level.playthrowhatchet ]]();
    }
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x1cd87657, Offset: 0x8bf8
// Size: 0x44
function onspawncrossbowbolt(watcher, player) {
    self.delete_on_death = 1;
    self thread onspawncrossbowbolt_internal(watcher, player);
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x8e7fb246, Offset: 0x8c48
// Size: 0xd4
function onspawncrossbowbolt_internal(watcher, player) {
    player endon(#"disconnect");
    self endon(#"death");
    wait 0.25;
    linkedent = self getlinkedent();
    if (!isdefined(linkedent) || !isvehicle(linkedent)) {
        self.takedamage = 0;
        return;
    }
    self.takedamage = 1;
    if (isvehicle(linkedent)) {
        self thread dieonentitydeath(linkedent, player);
    }
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x77853ebd, Offset: 0x8d28
// Size: 0xa2
function dieonentitydeath(entity, player) {
    player endon(#"disconnect");
    self endon(#"death");
    alreadydead = isdefined(entity.health) && (entity.dead === 1 || entity.health < 0);
    if (!alreadydead) {
        entity waittill("death");
    }
    self notify(#"death");
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0xd9f42a95, Offset: 0x8dd8
// Size: 0x44
function onspawncrossbowboltimpact(s_watcher, e_player) {
    self.delete_on_death = 1;
    self thread onspawncrossbowboltimpact_internal(s_watcher, e_player);
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0xec8a119e, Offset: 0x8e28
// Size: 0x10c
function onspawncrossbowboltimpact_internal(s_watcher, e_player) {
    self endon(#"death");
    e_player endon(#"disconnect");
    self waittill("stationary");
    s_watcher thread waitandfizzleout(self, 0);
    foreach (n_index, e_object in s_watcher.objectarray) {
        if (self == e_object) {
            s_watcher.objectarray[n_index] = undefined;
        }
    }
    cleanweaponobjectarray(s_watcher);
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x528d77ec, Offset: 0x8f40
// Size: 0x354
function function_9d76f10c(watcher, player) {
    self endon(#"death");
    self setowner(player);
    self setteam(player.pers["team"]);
    self.owner = player;
    self.oldangles = self.angles;
    self util::waittillnotmoving();
    waittillframeend();
    if (player.pers["team"] == "spectator") {
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
    }
    if (self.weapon.shownretrievable) {
        self clientfield::set("retrievable", 1);
    }
    self.var_11e72e42 = spawn("trigger_radius", triggerorigin, 0, 50, 50);
    self.var_11e72e42 enablelinkto();
    self.var_11e72e42 linkto(self);
    if (isdefined(triggerparentent)) {
        self.var_11e72e42 linkto(triggerparentent);
    }
    self thread function_5c7c8645(self.var_11e72e42, watcher.pickup, watcher.pickupsoundplayer, watcher.pickupsound);
    /#
        thread switch_team(self, watcher, player);
    #/
    self thread watchshutdown(player);
}

// Namespace weaponobjects/weaponobjects
// Params 4, eflags: 0x0
// Checksum 0xc281a466, Offset: 0x92a0
// Size: 0x1a6
function function_5c7c8645(trigger, callback, playersoundonuse, npcsoundonuse) {
    self endon(#"delete");
    self endon(#"hacked");
    while (true) {
        waitresult = trigger waittill("trigger");
        player = waitresult.activator;
        if (!isalive(player)) {
            continue;
        }
        if (isdefined(trigger.claimedby) && player != trigger.claimedby) {
            continue;
        }
        var_3790b778 = player function_5b6b62db();
        if (!isdefined(var_3790b778)) {
            continue;
        }
        stock_ammo = player getweaponammostock(var_3790b778);
        if (stock_ammo >= var_3790b778.maxammo) {
            continue;
        }
        if (isdefined(playersoundonuse)) {
            player playlocalsound(playersoundonuse);
        }
        if (isdefined(npcsoundonuse)) {
            player playsound(npcsoundonuse);
        }
        self thread [[ callback ]](player, var_3790b778);
    }
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0xe0af161d, Offset: 0x9450
// Size: 0x354
function function_3dc685f8(watcher, player) {
    self endon(#"death");
    self setowner(player);
    self setteam(player.pers["team"]);
    self.owner = player;
    self.oldangles = self.angles;
    self util::waittillnotmoving();
    waittillframeend();
    if (player.pers["team"] == "spectator") {
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
    }
    if (self.weapon.shownretrievable) {
        self clientfield::set("retrievable", 1);
    }
    self.var_11e72e42 = spawn("trigger_radius", triggerorigin, 0, 50, 50);
    self.var_11e72e42 enablelinkto();
    self.var_11e72e42 linkto(self);
    if (isdefined(triggerparentent)) {
        self.var_11e72e42 linkto(triggerparentent);
    }
    self thread function_35bc7e69(self.var_11e72e42, watcher.pickup, watcher.pickupsoundplayer, watcher.pickupsound);
    /#
        thread switch_team(self, watcher, player);
    #/
    self thread watchshutdown(player);
}

// Namespace weaponobjects/weaponobjects
// Params 4, eflags: 0x0
// Checksum 0x8ffde8b, Offset: 0x97b0
// Size: 0x2a2
function function_35bc7e69(trigger, callback, playersoundonuse, npcsoundonuse) {
    self endon(#"delete");
    self endon(#"hacked");
    while (true) {
        waitresult = trigger waittill("trigger");
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
        heldweapon = player get_held_weapon_match_or_root_match(self.weapon);
        if (!isdefined(heldweapon)) {
            continue;
        }
        maxammo = 0;
        if (heldweapon == player.grenadetypeprimary && isdefined(player.grenadetypeprimarycount) && player.grenadetypeprimarycount > 0) {
            maxammo = player.grenadetypeprimarycount;
        } else if (heldweapon == player.grenadetypesecondary && isdefined(player.grenadetypesecondarycount) && player.grenadetypesecondarycount > 0) {
            maxammo = player.grenadetypesecondarycount;
        }
        if (maxammo == 0) {
            continue;
        }
        clip_ammo = player getweaponammoclip(heldweapon);
        if (clip_ammo >= maxammo) {
            continue;
        }
        if (isdefined(playersoundonuse)) {
            player playlocalsound(playersoundonuse);
        }
        if (isdefined(npcsoundonuse)) {
            player playsound(npcsoundonuse);
        }
        self thread [[ callback ]](player);
    }
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0xa7099e96, Offset: 0x9a60
// Size: 0x13e
function get_held_weapon_match_or_root_match(weapon) {
    pweapons = self getweaponslist(1);
    foreach (pweapon in pweapons) {
        if (pweapon == weapon) {
            return pweapon;
        }
    }
    foreach (pweapon in pweapons) {
        if (pweapon.rootweapon == weapon.rootweapon) {
            return pweapon;
        }
    }
    return undefined;
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0xeeab12df, Offset: 0x9ba8
// Size: 0x11e
function function_5b6b62db() {
    pweapons = self getweaponslist(1);
    crossbow = getweapon("special_crossbow");
    var_1728524f = getweapon("special_crossbow_dw");
    foreach (pweapon in pweapons) {
        if (pweapon.rootweapon == crossbow || pweapon.rootweapon == var_1728524f) {
            return pweapon;
        }
    }
    return undefined;
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x79ff4bc5, Offset: 0x9cd0
// Size: 0x684
function function_26f3ad87(watcher, player) {
    self endon(#"death");
    self endon(#"hacked");
    self setowner(player);
    self setteam(player.pers["team"]);
    self.owner = player;
    self.oldangles = self.angles;
    self util::waittillnotmoving();
    if (watcher.activationdelay) {
        wait watcher.activationdelay;
    }
    waittillframeend();
    if (player.pers["team"] == "spectator") {
        return;
    }
    triggerorigin = self.origin;
    triggerparentent = undefined;
    if (isdefined(self.stucktoplayer)) {
        if (isalive(self.stucktoplayer) || !isdefined(self.stucktoplayer.body)) {
            triggerparentent = self.stucktoplayer;
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
    var_87c87431 = watcher.var_87c87431 === 1;
    if (!self util::ishacked() && !var_87c87431) {
        if (self.weapon.shownretrievable) {
            self clientfield::set("retrievable", 1);
        }
        self.pickuptrigger = spawn("trigger_radius_use", triggerorigin);
        self.pickuptrigger sethintlowpriority(1);
        self.pickuptrigger setcursorhint("HINT_NOICON", self);
        self.pickuptrigger enablelinkto();
        self.pickuptrigger linkto(self);
        self.pickuptrigger setinvisibletoall();
        self.pickuptrigger setvisibletoplayer(player);
        if (isdefined(level.var_34cd8c6d[watcher.name])) {
            self.pickuptrigger sethintstring(level.var_34cd8c6d[watcher.name].hint);
        } else {
            self.pickuptrigger sethintstring(%MP_GENERIC_PICKUP);
        }
        self.pickuptrigger setteamfortrigger(player.pers["team"]);
        if (isdefined(triggerparentent)) {
            self.pickuptrigger linkto(triggerparentent);
        }
        self thread watchusetrigger(self.pickuptrigger, watcher.pickup, watcher.pickupsoundplayer, watcher.pickupsound);
        if (isdefined(watcher.pickup_trigger_listener)) {
            self thread [[ watcher.pickup_trigger_listener ]](self.pickuptrigger, player);
        }
    }
    if (watcher.enemydestroy) {
        self.enemytrigger = spawn("trigger_radius_use", triggerorigin);
        self.enemytrigger setcursorhint("HINT_NOICON", self);
        self.enemytrigger enablelinkto();
        self.enemytrigger linkto(self);
        self.enemytrigger setinvisibletoplayer(player);
        if (level.teambased) {
            self.enemytrigger setexcludeteamfortrigger(player.team);
            self.enemytrigger.triggerteamignore = self.team;
        }
        if (isdefined(level.var_2f09bdc5[watcher.name])) {
            self.enemytrigger sethintstring(level.var_2f09bdc5[watcher.name].hint);
        } else {
            self.enemytrigger sethintstring(%MP_GENERIC_DESTROY);
        }
        self thread watchusetrigger(self.enemytrigger, watcher.ondestroyed);
    }
    /#
        thread switch_team(self, watcher, player);
    #/
    self thread watchshutdown(player);
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0xdbd82c42, Offset: 0xa360
// Size: 0x1c
function destroyent() {
    self delete();
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0xbf9441f9, Offset: 0xa388
// Size: 0x284
function pickup(player) {
    if (!self.weapon.anyplayercanretrieve && isdefined(self.owner) && self.owner != player) {
        return;
    }
    var_91426b10 = self.weapon;
    if (self.weapon.ammocountequipment > 0 && isdefined(self.ammo)) {
        ammoleftequipment = self.ammo;
    }
    self notify(#"picked_up");
    self.playdialog = 0;
    self destroyent();
    heldweapon = player get_held_weapon_match_or_root_match(self.weapon);
    if (!isdefined(heldweapon)) {
        return;
    }
    maxammo = 0;
    if (heldweapon == player.grenadetypeprimary && isdefined(player.grenadetypeprimarycount) && player.grenadetypeprimarycount > 0) {
        maxammo = player.grenadetypeprimarycount;
    } else if (heldweapon == player.grenadetypesecondary && isdefined(player.grenadetypesecondarycount) && player.grenadetypesecondarycount > 0) {
        maxammo = player.grenadetypesecondarycount;
    }
    if (maxammo == 0) {
        return;
    }
    clip_ammo = player getweaponammoclip(heldweapon);
    if (clip_ammo < maxammo) {
        clip_ammo++;
    }
    if (isdefined(ammoleftequipment)) {
        if (var_91426b10.rootweapon == getweapon("trophy_system")) {
            player trophy_system::ammo_weapon_pickup(ammoleftequipment);
        }
    }
    player setweaponammoclip(heldweapon, clip_ammo);
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0xcdf2b0e8, Offset: 0xa618
// Size: 0x8c
function function_f5c0b7dc(player, heldweapon) {
    self notify(#"picked_up");
    self.playdialog = 0;
    self destroyent();
    stock_ammo = player getweaponammostock(heldweapon);
    stock_ammo++;
    player setweaponammostock(heldweapon, stock_ammo);
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0xaac91b, Offset: 0xa6b0
// Size: 0x9c
function ondestroyed(attacker) {
    playfx(level._effect["tacticalInsertionFizzle"], self.origin);
    self playsound("dst_tac_insert_break");
    if (isdefined(level.playequipmentdestroyedonplayer)) {
        self.owner [[ level.playequipmentdestroyedonplayer ]]();
    }
    self delete();
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x849e8e1d, Offset: 0xa758
// Size: 0x15c
function watchshutdown(player) {
    self waittill("death", "hacked", "detonating");
    pickuptrigger = self.pickuptrigger;
    hackertrigger = self.hackertrigger;
    var_11e72e42 = self.var_11e72e42;
    enemytrigger = self.enemytrigger;
    if (isdefined(pickuptrigger)) {
        pickuptrigger delete();
    }
    if (isdefined(hackertrigger)) {
        if (isdefined(hackertrigger.progressbar)) {
            hackertrigger.progressbar hud::destroyelem();
            hackertrigger.progresstext hud::destroyelem();
        }
        hackertrigger delete();
    }
    if (isdefined(var_11e72e42)) {
        var_11e72e42 delete();
    }
    if (isdefined(enemytrigger)) {
        enemytrigger delete();
    }
}

// Namespace weaponobjects/weaponobjects
// Params 4, eflags: 0x0
// Checksum 0xb4a0d23b, Offset: 0xa8c0
// Size: 0x282
function watchusetrigger(trigger, callback, playersoundonuse, npcsoundonuse) {
    self endon(#"delete");
    self endon(#"hacked");
    while (true) {
        waitresult = trigger waittill("trigger");
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
        if (isdefined(trigger.triggerteam) && player.pers["team"] != trigger.triggerteam) {
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
            self thread [[ callback ]](player);
        }
    }
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0xbe9e42ca, Offset: 0xab50
// Size: 0x6e
function function_daf3d8b3(name, hint) {
    var_662c7da2 = spawnstruct();
    var_662c7da2.name = name;
    var_662c7da2.hint = hint;
    level.var_34cd8c6d[name] = var_662c7da2;
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x100ddb6c, Offset: 0xabc8
// Size: 0x6e
function function_eb28ef80(name, hint) {
    var_cee96f18 = spawnstruct();
    var_cee96f18.name = name;
    var_cee96f18.hint = hint;
    level.var_e496dff3[name] = var_cee96f18;
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x1d7a96c5, Offset: 0xac40
// Size: 0x6e
function function_25e68262(name, hint) {
    var_f598b8a = spawnstruct();
    var_f598b8a.name = name;
    var_f598b8a.hint = hint;
    level.var_2f09bdc5[name] = var_f598b8a;
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0x72046c1, Offset: 0xacb8
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
// Checksum 0x4a4aae86, Offset: 0xad60
// Size: 0x38
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
// Checksum 0x3b8a1f6c, Offset: 0xada0
// Size: 0x9a
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
// Checksum 0x4a448740, Offset: 0xae48
// Size: 0xfc
function destroy_other_teams_supplemental_watcher_objects(attacker, weapon, radius) {
    if (level.teambased) {
        foreach (team in level.teams) {
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
// Checksum 0x661e85d9, Offset: 0xaf50
// Size: 0x1d6
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
// Checksum 0x77762636, Offset: 0xb130
// Size: 0x44
function add_supplemental_object(object) {
    level.supplementalwatcherobjects[level.supplementalwatcherobjects.size] = object;
    object thread watch_supplemental_object_death();
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0x1d7c45cb, Offset: 0xb180
// Size: 0x34
function watch_supplemental_object_death() {
    self waittill("death");
    arrayremovevalue(level.supplementalwatcherobjects, self);
}

/#

    // Namespace weaponobjects/weaponobjects
    // Params 3, eflags: 0x0
    // Checksum 0xf3a0f498, Offset: 0xb1c0
    // Size: 0x1b0
    function switch_team(entity, watcher, owner) {
        self notify(#"stop_disarmthink");
        self endon(#"stop_disarmthink");
        self endon(#"death");
        setdvar("<dev string:x72>", "<dev string:x82>");
        while (true) {
            wait 0.5;
            devgui_int = getdvarint("<dev string:x72>");
            if (devgui_int != 0) {
                team = "<dev string:x83>";
                if (isdefined(level.getenemyteam) && isdefined(owner) && isdefined(owner.team)) {
                    team = [[ level.getenemyteam ]](owner.team);
                }
                if (isdefined(level.devongetormakebot)) {
                    player = [[ level.devongetormakebot ]](team);
                }
                if (!isdefined(player)) {
                    println("<dev string:x8e>");
                    wait 1;
                    continue;
                }
                entity itemhacked(watcher, player);
                setdvar("<dev string:x72>", "<dev string:xa8>");
            }
        }
    }

#/
