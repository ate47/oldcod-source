#using scripts\core_common\player\player_stats;
#using scripts\core_common\util_shared;
#using scripts\weapons\weaponobjects;

#namespace weaponobjects;

// Namespace weaponobjects/namespace_4c668920
// Params 0, eflags: 0x0
// Checksum 0xe3ce4f8f, Offset: 0x90
// Size: 0x16c
function function_b455d5d8() {
    function_f297d773();
    function_e6400478(#"tactical_insertion", &createtactinsertwatcher, 1);
    function_e6400478(#"rcbomb", &creatercbombwatcher, 1);
    function_e6400478(#"qrdrone", &createqrdronewatcher, 1);
    function_e6400478(#"helicopter_player", &createplayerhelicopterwatcher, 1);
    function_e6400478(#"tr_flechette_t8", &function_1eaa3e20);
    if (is_true(level.var_b68902c4)) {
        function_e6400478(#"tr_flechette_t8_upgraded", &function_1eaa3e20);
    }
}

// Namespace weaponobjects/namespace_4c668920
// Params 1, eflags: 0x0
// Checksum 0xbc5a9395, Offset: 0x208
// Size: 0xe2
function createspecialcrossbowwatchertypes(watcher) {
    watcher.ondetonatecallback = &delete;
    watcher.ondamage = &util::void;
    if (is_true(level.b_crossbow_bolt_destroy_on_impact)) {
        watcher.onspawn = &onspawncrossbowboltimpact;
        watcher.onspawnretrievetriggers = &util::void;
        watcher.pickup = &util::void;
        return;
    }
    watcher.onspawn = &onspawncrossbowbolt;
    watcher.onspawnretrievetriggers = &function_23b0aea9;
    watcher.pickup = &function_d9219ce2;
}

// Namespace weaponobjects/namespace_4c668920
// Params 0, eflags: 0x0
// Checksum 0x107cef19, Offset: 0x2f8
// Size: 0x134
function function_f297d773() {
    function_e6400478(#"special_crossbow", &createspecialcrossbowwatchertypes, 1);
    function_e6400478(#"special_crossbowlh", &createspecialcrossbowwatchertypes, 1);
    function_e6400478(#"special_crossbow_dw", &createspecialcrossbowwatchertypes, 1);
    if (is_true(level.b_create_upgraded_crossbow_watchers)) {
        function_e6400478(#"hash_4ed22f83f048d5ee", &createspecialcrossbowwatchertypes, 1);
        function_e6400478(#"hash_2ae5acccecbfffb8", &createspecialcrossbowwatchertypes, 1);
    }
}

// Namespace weaponobjects/namespace_4c668920
// Params 1, eflags: 0x0
// Checksum 0xc7fca52b, Offset: 0x438
// Size: 0x26
function function_1eaa3e20(watcher) {
    watcher.notequipment = 1;
    watcher.onfizzleout = undefined;
}

// Namespace weaponobjects/namespace_4c668920
// Params 1, eflags: 0x0
// Checksum 0xb340dbb4, Offset: 0x468
// Size: 0x16
function createtactinsertwatcher(watcher) {
    watcher.playdestroyeddialog = 0;
}

// Namespace weaponobjects/namespace_4c668920
// Params 1, eflags: 0x0
// Checksum 0x3b5393a9, Offset: 0x488
// Size: 0x6e
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

// Namespace weaponobjects/namespace_4c668920
// Params 1, eflags: 0x0
// Checksum 0x676ab9b9, Offset: 0x500
// Size: 0x7e
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

// Namespace weaponobjects/namespace_4c668920
// Params 1, eflags: 0x0
// Checksum 0x67352f9a, Offset: 0x588
// Size: 0xb2
function getspikelauncheractivespikecount(watcher) {
    currentitemcount = 0;
    foreach (obj in watcher.objectarray) {
        if (isdefined(obj) && obj.item !== watcher.weapon) {
            currentitemcount++;
        }
    }
    return currentitemcount;
}

// Namespace weaponobjects/namespace_4c668920
// Params 1, eflags: 0x0
// Checksum 0x9477f6e6, Offset: 0x648
// Size: 0xe6
function watchspikelauncheritemcountchanged(watcher) {
    self endon(#"death");
    lastitemcount = undefined;
    while (true) {
        waitresult = self waittill(#"weapon_change");
        for (weapon = waitresult.weapon; weapon.name == #"spike_launcher"; weapon = self getcurrentweapon()) {
            currentitemcount = getspikelauncheractivespikecount(watcher);
            if (currentitemcount !== lastitemcount) {
                lastitemcount = currentitemcount;
            }
            wait 0.1;
        }
    }
}

// Namespace weaponobjects/namespace_4c668920
// Params 1, eflags: 0x0
// Checksum 0x404f9584, Offset: 0x738
// Size: 0x3e
function spikesdetonating(watcher) {
    spikecount = getspikelauncheractivespikecount(watcher);
    if (spikecount > 0) {
        wait 2;
    }
}

// Namespace weaponobjects/namespace_4c668920
// Params 1, eflags: 0x0
// Checksum 0x3e456462, Offset: 0x780
// Size: 0x11a
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

// Namespace weaponobjects/namespace_4c668920
// Params 1, eflags: 0x0
// Checksum 0x18d16f9f, Offset: 0x8a8
// Size: 0x26
function createplayerhelicopterwatcher(watcher) {
    watcher.altdetonate = 1;
    watcher.notequipment = 1;
}

// Namespace weaponobjects/namespace_4c668920
// Params 1, eflags: 0x0
// Checksum 0xdf6c0fcb, Offset: 0x8d8
// Size: 0x42
function function_50d4198b(watcher) {
    watcher.hackable = 0;
    watcher.headicon = 0;
    watcher.enemydestroy = 0;
    watcher.onspawn = &function_f0e307a2;
}

// Namespace weaponobjects/namespace_4c668920
// Params 2, eflags: 0x0
// Checksum 0x42fa1a9a, Offset: 0x928
// Size: 0xc4
function function_f0e307a2(watcher, player) {
    level endon(#"game_ended");
    self endon(#"death");
    if (isdefined(player)) {
        player stats::function_e24eec31(self.weapon, #"used", 1);
    }
    self playloopsound(#"uin_c4_air_alarm_loop");
    self waittilltimeout(10, #"stationary");
    function_b70eb3a9(watcher, player);
}

// Namespace weaponobjects/namespace_4c668920
// Params 2, eflags: 0x0
// Checksum 0x87141c61, Offset: 0x9f8
// Size: 0xc4
function function_b70eb3a9(*watcher, player) {
    pos = self.origin + (0, 0, 15);
    self.ammo_trigger = spawn("trigger_radius", pos, 0, 50, 50);
    self.ammo_trigger setteamfortrigger(player.team);
    self.ammo_trigger.owner = player;
    self thread function_5742754c();
    self thread function_42eeab72(self);
}

// Namespace weaponobjects/namespace_4c668920
// Params 0, eflags: 0x0
// Checksum 0x2c1248a3, Offset: 0xac8
// Size: 0x150
function function_5742754c() {
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
        if (isdefined(trigger.team) && util::function_fbce7263(player.team, trigger.team)) {
            continue;
        }
        station function_e98cee52(player, station);
    }
}

// Namespace weaponobjects/namespace_4c668920
// Params 2, eflags: 0x0
// Checksum 0xc7705002, Offset: 0xc20
// Size: 0x16c
function function_e98cee52(player, station) {
    primary_weapons = player getweaponslistprimaries();
    gaveammo = 0;
    foreach (weapon in primary_weapons) {
        gaveammo |= player function_61bdb626(weapon);
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
        station function_f47cd4cb();
        station delete();
    }
}

// Namespace weaponobjects/namespace_4c668920
// Params 1, eflags: 0x0
// Checksum 0x3c77e038, Offset: 0xd98
// Size: 0xa4
function function_61bdb626(weapon) {
    player = self;
    new_ammo = weapon.clipsize;
    stockammo = player getweaponammostock(weapon);
    player setweaponammostock(weapon, int(stockammo + new_ammo));
    newammo = player getweaponammostock(weapon);
    return newammo > stockammo;
}

// Namespace weaponobjects/namespace_4c668920
// Params 1, eflags: 0x0
// Checksum 0x4730084f, Offset: 0xe48
// Size: 0x34
function function_42eeab72(*station) {
    self waittill(#"death");
    self function_f47cd4cb();
}

// Namespace weaponobjects/namespace_4c668920
// Params 0, eflags: 0x0
// Checksum 0x19201895, Offset: 0xe88
// Size: 0x2c
function function_f47cd4cb() {
    if (isdefined(self.ammo_trigger)) {
        self.ammo_trigger delete();
    }
}

// Namespace weaponobjects/namespace_4c668920
// Params 2, eflags: 0x0
// Checksum 0xb5628cb4, Offset: 0xec0
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

// Namespace weaponobjects/namespace_4c668920
// Params 3, eflags: 0x0
// Checksum 0x4a27dfde, Offset: 0xfb0
// Size: 0x6c
function spikedetonate(attacker, weapon, *target) {
    if (isdefined(target) && target.isvalid) {
        if (isdefined(weapon)) {
            if (self.owner util::isenemyplayer(weapon)) {
            }
        }
    }
    thread delayedspikedetonation(weapon, target);
}

// Namespace weaponobjects/namespace_4c668920
// Params 2, eflags: 0x0
// Checksum 0x6088c54d, Offset: 0x1028
// Size: 0x3c
function onspawncrossbowbolt(watcher, player) {
    self.delete_on_death = 1;
    self thread onspawncrossbowbolt_internal(watcher, player);
}

// Namespace weaponobjects/namespace_4c668920
// Params 2, eflags: 0x0
// Checksum 0x42896c43, Offset: 0x1070
// Size: 0xdc
function onspawncrossbowbolt_internal(*watcher, player) {
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

// Namespace weaponobjects/namespace_4c668920
// Params 2, eflags: 0x0
// Checksum 0x1788b9a, Offset: 0x1158
// Size: 0x3c
function onspawncrossbowboltimpact(s_watcher, e_player) {
    self.delete_on_death = 1;
    self thread onspawncrossbowboltimpact_internal(s_watcher, e_player);
}

// Namespace weaponobjects/namespace_4c668920
// Params 2, eflags: 0x0
// Checksum 0x59f17aef, Offset: 0x11a0
// Size: 0x10c
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

// Namespace weaponobjects/namespace_4c668920
// Params 2, eflags: 0x0
// Checksum 0x16b77dad, Offset: 0x12b8
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

