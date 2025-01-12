#using scripts\core_common\player\player_stats;
#using scripts\core_common\util_shared;
#using scripts\weapons\weaponobjects;

#namespace weaponobjects;

// Namespace weaponobjects/namespace_d26d8bf2
// Params 0, eflags: 0x0
// Checksum 0x1f70cc3d, Offset: 0xd0
// Size: 0x12c
function function_c41c3bf1() {
    function_f85aaa85();
    function_f298eae6(#"hatchet", &createhatchetwatcher, 1);
    function_f298eae6(#"tactical_insertion", &createtactinsertwatcher, 1);
    function_f298eae6(#"rcbomb", &creatercbombwatcher, 1);
    function_f298eae6(#"qrdrone", &createqrdronewatcher, 1);
    function_f298eae6(#"helicopter_player", &createplayerhelicopterwatcher, 1);
}

// Namespace weaponobjects/namespace_d26d8bf2
// Params 1, eflags: 0x0
// Checksum 0x17ca4125, Offset: 0x208
// Size: 0xf6
function createspecialcrossbowwatchertypes(watcher) {
    watcher.ondetonatecallback = &deleteent;
    watcher.ondamage = &voidondamage;
    if (isdefined(level.b_crossbow_bolt_destroy_on_impact) && level.b_crossbow_bolt_destroy_on_impact) {
        watcher.onspawn = &onspawncrossbowboltimpact;
        watcher.onspawnretrievetriggers = &voidonspawnretrievetriggers;
        watcher.pickup = &voidpickup;
        return;
    }
    watcher.onspawn = &onspawncrossbowbolt;
    watcher.onspawnretrievetriggers = &function_62336657;
    watcher.pickup = &function_a07674ea;
}

// Namespace weaponobjects/namespace_d26d8bf2
// Params 0, eflags: 0x0
// Checksum 0xabccc5f, Offset: 0x308
// Size: 0x13c
function function_f85aaa85() {
    function_f298eae6(#"special_crossbow", &createspecialcrossbowwatchertypes, 1);
    function_f298eae6(#"special_crossbowlh", &createspecialcrossbowwatchertypes, 1);
    function_f298eae6(#"special_crossbow_dw", &createspecialcrossbowwatchertypes, 1);
    if (isdefined(level.b_create_upgraded_crossbow_watchers) && level.b_create_upgraded_crossbow_watchers) {
        function_f298eae6(#"hash_4ed22f83f048d5ee", &createspecialcrossbowwatchertypes, 1);
        function_f298eae6(#"hash_2ae5acccecbfffb8", &createspecialcrossbowwatchertypes, 1);
    }
}

// Namespace weaponobjects/namespace_d26d8bf2
// Params 1, eflags: 0x0
// Checksum 0xb47a2d3, Offset: 0x450
// Size: 0x96
function createhatchetwatcher(watcher) {
    watcher.ondetonatecallback = &deleteent;
    watcher.onspawn = &onspawnhatchet;
    watcher.ondamage = &voidondamage;
    watcher.onspawnretrievetriggers = &function_62336657;
    watcher.timeout = 120;
    watcher.pickup = &function_a07674ea;
}

// Namespace weaponobjects/namespace_d26d8bf2
// Params 1, eflags: 0x0
// Checksum 0x6034c311, Offset: 0x4f0
// Size: 0x1a
function createtactinsertwatcher(watcher) {
    watcher.playdestroyeddialog = 0;
}

// Namespace weaponobjects/namespace_d26d8bf2
// Params 1, eflags: 0x0
// Checksum 0x3c040b0e, Offset: 0x518
// Size: 0x86
function creatercbombwatcher(watcher) {
    watcher.altdetonate = 0;
    watcher.ismovable = 1;
    watcher.ownergetsassist = 1;
    watcher.playdestroyeddialog = 0;
    watcher.deleteonkillbrush = 0;
    watcher.ondetonatecallback = level.rcbombonblowup;
    watcher.stuntime = 1;
    watcher.notequipment = 1;
}

// Namespace weaponobjects/namespace_d26d8bf2
// Params 1, eflags: 0x0
// Checksum 0xa705c914, Offset: 0x5a8
// Size: 0x9a
function createqrdronewatcher(watcher) {
    watcher.altdetonate = 0;
    watcher.ismovable = 1;
    watcher.ownergetsassist = 1;
    watcher.playdestroyeddialog = 0;
    watcher.deleteonkillbrush = 0;
    watcher.ondetonatecallback = level.qrdroneonblowup;
    watcher.ondamage = level.qrdroneondamage;
    watcher.stuntime = 5;
    watcher.notequipment = 1;
}

// Namespace weaponobjects/namespace_d26d8bf2
// Params 1, eflags: 0x0
// Checksum 0xfe9cb3aa, Offset: 0x650
// Size: 0xb0
function getspikelauncheractivespikecount(watcher) {
    currentitemcount = 0;
    foreach (obj in watcher.objectarray) {
        if (isdefined(obj) && obj.item !== watcher.weapon) {
            currentitemcount++;
        }
    }
    return currentitemcount;
}

// Namespace weaponobjects/namespace_d26d8bf2
// Params 1, eflags: 0x0
// Checksum 0xb6c4455, Offset: 0x708
// Size: 0x106
function watchspikelauncheritemcountchanged(watcher) {
    self endon(#"death");
    lastitemcount = undefined;
    while (true) {
        waitresult = self waittill(#"weapon_change");
        for (weapon = waitresult.weapon; weapon.name == #"spike_launcher"; weapon = self getcurrentweapon()) {
            currentitemcount = getspikelauncheractivespikecount(watcher);
            if (currentitemcount !== lastitemcount) {
                self setcontrolleruimodelvalue("spikeLauncherCounter.spikesReady", currentitemcount);
                lastitemcount = currentitemcount;
            }
            wait 0.1;
        }
    }
}

// Namespace weaponobjects/namespace_d26d8bf2
// Params 1, eflags: 0x0
// Checksum 0x4b39e2b2, Offset: 0x818
// Size: 0x84
function spikesdetonating(watcher) {
    spikecount = getspikelauncheractivespikecount(watcher);
    if (spikecount > 0) {
        self setcontrolleruimodelvalue("spikeLauncherCounter.blasting", 1);
        wait 2;
        self setcontrolleruimodelvalue("spikeLauncherCounter.blasting", 0);
    }
}

// Namespace weaponobjects/namespace_d26d8bf2
// Params 1, eflags: 0x0
// Checksum 0x8ce1bdaa, Offset: 0x8a8
// Size: 0x146
function createspikelauncherwatcher(watcher) {
    watcher.altname = #"spike_charge";
    watcher.altweapon = getweapon(#"spike_charge");
    watcher.altdetonate = 0;
    watcher.watchforfire = 1;
    watcher.hackable = 1;
    watcher.hackertoolradius = level.equipmenthackertoolradius;
    watcher.hackertooltimems = level.equipmenthackertooltimems;
    watcher.ondetonatecallback = &spikedetonate;
    watcher.onstun = &weaponstun;
    watcher.stuntime = 1;
    watcher.ownergetsassist = 1;
    watcher.detonatestationary = 0;
    watcher.detonationdelay = 0;
    watcher.detonationsound = #"wpn_claymore_alert";
    watcher.ondetonationhandle = &spikesdetonating;
}

// Namespace weaponobjects/namespace_d26d8bf2
// Params 1, eflags: 0x0
// Checksum 0x6bbd2ed5, Offset: 0x9f8
// Size: 0x2a
function createplayerhelicopterwatcher(watcher) {
    watcher.altdetonate = 1;
    watcher.notequipment = 1;
}

// Namespace weaponobjects/namespace_d26d8bf2
// Params 1, eflags: 0x0
// Checksum 0x94e5d392, Offset: 0xa30
// Size: 0x56
function function_e45d5e95(watcher) {
    watcher.hackable = 0;
    watcher.headicon = 0;
    watcher.deleteonplayerspawn = 0;
    watcher.enemydestroy = 0;
    watcher.onspawn = &function_db699195;
}

// Namespace weaponobjects/namespace_d26d8bf2
// Params 2, eflags: 0x0
// Checksum 0x9cb787a9, Offset: 0xa90
// Size: 0xc4
function function_db699195(watcher, player) {
    level endon(#"game_ended");
    self endon(#"death");
    if (isdefined(player)) {
        player stats::function_4f10b697(self.weapon, #"used", 1);
    }
    self playloopsound(#"uin_c4_air_alarm_loop");
    self waittilltimeout(10, #"stationary");
    function_7c58c6e1(watcher, player);
}

// Namespace weaponobjects/namespace_d26d8bf2
// Params 2, eflags: 0x0
// Checksum 0x8dee0c1b, Offset: 0xb60
// Size: 0xc4
function function_7c58c6e1(watcher, player) {
    pos = self.origin + (0, 0, 15);
    self.ammo_trigger = spawn("trigger_radius", pos, 0, 50, 50);
    self.ammo_trigger setteamfortrigger(player.team);
    self.ammo_trigger.owner = player;
    self thread function_25861e17();
    self thread function_489f8a5e(self);
}

// Namespace weaponobjects/namespace_d26d8bf2
// Params 0, eflags: 0x0
// Checksum 0xc1487639, Offset: 0xc30
// Size: 0x160
function function_25861e17() {
    station = self;
    station endon(#"death");
    if (!isdefined(station.ammo_resupplies_given)) {
        station.ammo_resupplies_given = 0;
    }
    assert(isdefined(station.ammo_trigger));
    trigger = station.ammo_trigger;
    while (isdefined(trigger)) {
        waitresult = trigger waittill(#"touch");
        player = waitresult.entity;
        if (!isplayer(player)) {
            continue;
        }
        if (!isalive(player)) {
            continue;
        }
        if (isdefined(trigger.team) && player.team != trigger.team) {
            continue;
        }
        station function_3e76a11b(player, station);
    }
}

// Namespace weaponobjects/namespace_d26d8bf2
// Params 2, eflags: 0x0
// Checksum 0x869374fb, Offset: 0xd98
// Size: 0x16c
function function_3e76a11b(player, station) {
    primary_weapons = player getweaponslistprimaries();
    gaveammo = 0;
    foreach (weapon in primary_weapons) {
        gaveammo |= player function_ba47f1ab(weapon);
    }
    if (!gaveammo) {
        return;
    }
    if (!isdefined(station.last_ammo_resupply_time)) {
        station.last_ammo_resupply_time = [];
    }
    station.last_ammo_resupply_time[player getentitynumber()] = gettime();
    station.ammo_resupplies_given++;
    if (station.ammo_resupplies_given >= 1) {
        station function_7a4e2927();
        station delete();
    }
}

// Namespace weaponobjects/namespace_d26d8bf2
// Params 1, eflags: 0x0
// Checksum 0x2b09677d, Offset: 0xf10
// Size: 0xb8
function function_ba47f1ab(weapon) {
    player = self;
    new_ammo = weapon.clipsize;
    stockammo = player getweaponammostock(weapon);
    player setweaponammostock(weapon, int(stockammo + new_ammo));
    newammo = player getweaponammostock(weapon);
    return newammo > stockammo;
}

// Namespace weaponobjects/namespace_d26d8bf2
// Params 1, eflags: 0x0
// Checksum 0xeac50443, Offset: 0xfd0
// Size: 0x34
function function_489f8a5e(station) {
    self waittill(#"death");
    self function_7a4e2927();
}

// Namespace weaponobjects/namespace_d26d8bf2
// Params 0, eflags: 0x0
// Checksum 0x478d834b, Offset: 0x1010
// Size: 0x2c
function function_7a4e2927() {
    if (isdefined(self.ammo_trigger)) {
        self.ammo_trigger delete();
    }
}

// Namespace weaponobjects/namespace_d26d8bf2
// Params 2, eflags: 0x0
// Checksum 0xb7ca3a6e, Offset: 0x1048
// Size: 0xe4
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

// Namespace weaponobjects/namespace_d26d8bf2
// Params 3, eflags: 0x0
// Checksum 0xc72571f1, Offset: 0x1138
// Size: 0x6c
function spikedetonate(attacker, weapon, target) {
    if (isdefined(weapon) && weapon.isvalid) {
        if (isdefined(attacker)) {
            if (self.owner util::isenemyplayer(attacker)) {
            }
        }
    }
    thread delayedspikedetonation(attacker, weapon);
}

// Namespace weaponobjects/namespace_d26d8bf2
// Params 2, eflags: 0x0
// Checksum 0x7fcc9c7c, Offset: 0x11b0
// Size: 0x38
function onspawnhatchet(watcher, player) {
    if (isdefined(level.playthrowhatchet)) {
        player [[ level.playthrowhatchet ]]();
    }
}

// Namespace weaponobjects/namespace_d26d8bf2
// Params 2, eflags: 0x0
// Checksum 0xcd837a40, Offset: 0x11f0
// Size: 0x3c
function onspawncrossbowbolt(watcher, player) {
    self.delete_on_death = 1;
    self thread onspawncrossbowbolt_internal(watcher, player);
}

// Namespace weaponobjects/namespace_d26d8bf2
// Params 2, eflags: 0x0
// Checksum 0xbcde7d5a, Offset: 0x1238
// Size: 0xdc
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

// Namespace weaponobjects/namespace_d26d8bf2
// Params 2, eflags: 0x0
// Checksum 0xed3611c3, Offset: 0x1320
// Size: 0x3c
function onspawncrossbowboltimpact(s_watcher, e_player) {
    self.delete_on_death = 1;
    self thread onspawncrossbowboltimpact_internal(s_watcher, e_player);
}

// Namespace weaponobjects/namespace_d26d8bf2
// Params 2, eflags: 0x0
// Checksum 0x8a8255b9, Offset: 0x1368
// Size: 0x104
function onspawncrossbowboltimpact_internal(s_watcher, e_player) {
    self endon(#"death");
    e_player endon(#"disconnect");
    self waittill(#"stationary");
    s_watcher thread waitandfizzleout(self, 0);
    foreach (n_index, e_object in s_watcher.objectarray) {
        if (self == e_object) {
            s_watcher.objectarray[n_index] = undefined;
        }
    }
    cleanweaponobjectarray(s_watcher);
}

// Namespace weaponobjects/namespace_d26d8bf2
// Params 2, eflags: 0x0
// Checksum 0x22fda8a2, Offset: 0x1478
// Size: 0xb6
function dieonentitydeath(entity, player) {
    player endon(#"disconnect");
    self endon(#"death");
    alreadydead = entity.dead === 1 || isdefined(entity.health) && entity.health < 0;
    if (!alreadydead) {
        entity waittill(#"death");
    }
    self notify(#"death");
}

