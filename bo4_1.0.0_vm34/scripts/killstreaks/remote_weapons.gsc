#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\killstreaks\killstreaks_shared;

#namespace remote_weapons;

// Namespace remote_weapons/remote_weapons
// Params 0, eflags: 0x0
// Checksum 0xc0628e36, Offset: 0x128
// Size: 0x64
function init_shared() {
    if (!isdefined(level.var_8ebe70f9)) {
        level.var_8ebe70f9 = {};
        level.remoteweapons = [];
        level.remoteexithint = #"mp/remote_exit";
        callback::on_spawned(&on_player_spawned);
    }
}

// Namespace remote_weapons/remote_weapons
// Params 0, eflags: 0x0
// Checksum 0x1f88b2cb, Offset: 0x198
// Size: 0x2c
function on_player_spawned() {
    self endon(#"disconnect");
    self assignremotecontroltrigger();
}

// Namespace remote_weapons/remote_weapons
// Params 1, eflags: 0x0
// Checksum 0xee263375, Offset: 0x1d0
// Size: 0x3c
function removeandassignnewremotecontroltrigger(remotecontroltrigger) {
    arrayremovevalue(self.activeremotecontroltriggers, remotecontroltrigger);
    self assignremotecontroltrigger(1);
}

// Namespace remote_weapons/remote_weapons
// Params 1, eflags: 0x0
// Checksum 0x4b5c243d, Offset: 0x218
// Size: 0xdc
function assignremotecontroltrigger(force_new_assignment = 0) {
    if (!isdefined(self.activeremotecontroltriggers)) {
        self.activeremotecontroltriggers = [];
    }
    arrayremovevalue(self.activeremotecontroltriggers, undefined);
    if ((!isdefined(self.remotecontroltrigger) || force_new_assignment) && self.activeremotecontroltriggers.size > 0) {
        self.remotecontroltrigger = self.activeremotecontroltriggers[self.activeremotecontroltriggers.size - 1];
    }
    if (isdefined(self.remotecontroltrigger)) {
        self.remotecontroltrigger.origin = self.origin;
        self.remotecontroltrigger linkto(self);
    }
}

// Namespace remote_weapons/remote_weapons
// Params 5, eflags: 0x0
// Checksum 0xbfefc978, Offset: 0x300
// Size: 0xee
function registerremoteweapon(weaponname, hintstring, usecallback, endusecallback, hidecompassonuse = 1) {
    assert(isdefined(level.remoteweapons));
    level.remoteweapons[weaponname] = spawnstruct();
    level.remoteweapons[weaponname].hintstring = hintstring;
    level.remoteweapons[weaponname].usecallback = usecallback;
    level.remoteweapons[weaponname].endusecallback = endusecallback;
    level.remoteweapons[weaponname].hidecompassonuse = hidecompassonuse;
}

// Namespace remote_weapons/remote_weapons
// Params 5, eflags: 0x0
// Checksum 0x32875e7b, Offset: 0x3f8
// Size: 0x12c
function useremoteweapon(weapon, weaponname, immediate, allowmanualdeactivation = 1, always_allow_ride = 0) {
    player = self;
    assert(isplayer(player));
    weapon.remoteowner = player;
    weapon.inittime = gettime();
    weapon.remotename = weaponname;
    weapon.remoteweaponallowmanualdeactivation = allowmanualdeactivation;
    weapon thread watchremoveremotecontrolledweapon();
    if (!immediate) {
        weapon createremoteweapontrigger();
        return;
    }
    weapon thread watchownerdisconnect();
    weapon useremotecontrolweapon(allowmanualdeactivation, always_allow_ride);
}

// Namespace remote_weapons/remote_weapons
// Params 0, eflags: 0x0
// Checksum 0x25c595ea, Offset: 0x530
// Size: 0x9a
function watchforhack() {
    weapon = self;
    weapon endon(#"death");
    waitresult = weapon waittill(#"killstreak_hacked");
    if (isdefined(weapon.remoteweaponallowmanualdeactivation) && weapon.remoteweaponallowmanualdeactivation) {
        weapon thread watchremotecontroldeactivate();
    }
    weapon.remoteowner = waitresult.hacker;
}

// Namespace remote_weapons/remote_weapons
// Params 0, eflags: 0x0
// Checksum 0xdd2938fc, Offset: 0x5d8
// Size: 0x2c
function on_game_ended() {
    weapon = self;
    weapon endremotecontrolweaponuse(0, 1);
}

// Namespace remote_weapons/remote_weapons
// Params 0, eflags: 0x0
// Checksum 0x903e91ce, Offset: 0x610
// Size: 0xf6
function watchremoveremotecontrolledweapon() {
    weapon = self;
    weapon endon(#"remote_weapon_end");
    waitresult = weapon waittill(#"death", #"remote_weapon_shutdown");
    if (weapon.watch_remote_weapon_death === 1 && isdefined(waitresult._notify) && waitresult._notify == "remote_weapon_shutdown") {
        weapon notify(#"hash_59b25025ce93a142");
        weapon waittill(#"death");
    }
    weapon endremotecontrolweaponuse(0);
    while (isdefined(weapon)) {
        waitframe(1);
    }
}

// Namespace remote_weapons/remote_weapons
// Params 0, eflags: 0x0
// Checksum 0x1f3bdb08, Offset: 0x710
// Size: 0x27c
function createremoteweapontrigger() {
    weapon = self;
    player = weapon.remoteowner;
    if (isdefined(weapon.usetrigger)) {
        weapon.usetrigger delete();
    }
    weapon.usetrigger = spawn("trigger_radius_use", player.origin, 0, 32, 32);
    weapon.usetrigger enablelinkto();
    weapon.usetrigger linkto(player);
    weapon.usetrigger sethintlowpriority(1);
    weapon.usetrigger setcursorhint("HINT_NOICON");
    if (isdefined(level.remoteweapons[weapon.remotename])) {
        weapon.usetrigger sethintstring(level.remoteweapons[weapon.remotename].hintstring);
    }
    weapon.usetrigger setteamfortrigger(player.team);
    weapon.usetrigger.team = player.team;
    player clientclaimtrigger(weapon.usetrigger);
    player.remotecontroltrigger = weapon.usetrigger;
    player.activeremotecontroltriggers[player.activeremotecontroltriggers.size] = weapon.usetrigger;
    weapon.usetrigger.claimedby = player;
    weapon thread watchweapondeath();
    weapon thread watchownerdisconnect();
    weapon thread watchremotetriggeruse();
    weapon thread watchremotetriggerdisable();
}

// Namespace remote_weapons/remote_weapons
// Params 0, eflags: 0x0
// Checksum 0x52af07e2, Offset: 0x998
// Size: 0xac
function watchweapondeath() {
    weapon = self;
    weapon.usetrigger endon(#"death");
    weapon waittill(#"death", #"remote_weapon_end");
    if (isdefined(weapon.remoteowner)) {
        weapon.remoteowner removeandassignnewremotecontroltrigger(weapon.usetrigger);
    }
    weapon.usetrigger delete();
}

// Namespace remote_weapons/remote_weapons
// Params 0, eflags: 0x0
// Checksum 0x240aedbf, Offset: 0xa50
// Size: 0x104
function watchownerdisconnect() {
    weapon = self;
    weapon endon(#"remote_weapon_end");
    weapon endon(#"remote_weapon_shutdown");
    if (isdefined(weapon.usetrigger)) {
        weapon.usetrigger endon(#"death");
    }
    weapon.remoteowner waittill(#"joined_team", #"disconnect", #"joined_spectators");
    endremotecontrolweaponuse(0);
    if (isdefined(weapon) && isdefined(weapon.usetrigger)) {
        weapon.usetrigger delete();
    }
}

// Namespace remote_weapons/remote_weapons
// Params 0, eflags: 0x0
// Checksum 0xdb7e947, Offset: 0xb60
// Size: 0xc8
function watchremotetriggerdisable() {
    weapon = self;
    weapon endon(#"remote_weapon_end");
    weapon endon(#"remote_weapon_shutdown");
    weapon.usetrigger endon(#"death");
    weapon.remoteowner endon(#"disconnect");
    while (true) {
        weapon.usetrigger triggerenable(!weapon.remoteowner iswallrunning());
        wait 0.1;
    }
}

// Namespace remote_weapons/remote_weapons
// Params 1, eflags: 0x0
// Checksum 0x9252d684, Offset: 0xc30
// Size: 0xe0
function allowremotestart(var_f9592f13) {
    player = self;
    if ((isdefined(var_f9592f13) && var_f9592f13 || player usebuttonpressed()) && !player.throwinggrenade && !player meleebuttonpressed() && !player util::isusingremote() && !(isdefined(player.carryobject) && isdefined(player.carryobject.disallowremotecontrol) && player.carryobject.disallowremotecontrol)) {
        return 1;
    }
    return 0;
}

// Namespace remote_weapons/remote_weapons
// Params 0, eflags: 0x0
// Checksum 0xa6c7b5fd, Offset: 0xd18
// Size: 0x1e0
function watchremotetriggeruse() {
    weapon = self;
    weapon endon(#"death");
    weapon endon(#"remote_weapon_end");
    if (isbot(weapon.remoteowner)) {
        return;
    }
    while (true) {
        res = weapon.usetrigger waittill(#"trigger", #"death");
        if (res._notify == "death") {
            return;
        }
        if (weapon.remoteowner isusingoffhand() || weapon.remoteowner iswallrunning()) {
            continue;
        }
        if (isdefined(weapon.hackertrigger) && isdefined(weapon.hackertrigger.progressbar)) {
            if (weapon.remotename == "killstreak_remote_turret") {
                weapon.remoteowner iprintlnbold(#"hash_7b4c84d5307fea60");
            }
            continue;
        }
        if (weapon.remoteowner allowremotestart()) {
            var_bbff4951 = gettime() - (isdefined(weapon.lastusetime) ? weapon.lastusetime : 0);
            if (var_bbff4951 > 700) {
                useremotecontrolweapon();
            }
        }
    }
}

// Namespace remote_weapons/remote_weapons
// Params 2, eflags: 0x0
// Checksum 0xdb399078, Offset: 0xf00
// Size: 0x470
function useremotecontrolweapon(allowmanualdeactivation = 1, always_allow_ride = 0) {
    self endon(#"death");
    weapon = self;
    assert(isdefined(weapon.remoteowner));
    weapon.control_initiated = 1;
    weapon.endremotecontrolweapon = 0;
    weapon.remoteowner endon(#"disconnect");
    weapon.remoteowner endon(#"joined_team");
    weapon.remoteowner disableoffhandweapons();
    weapon.remoteowner disableweaponcycling();
    weapon.remoteowner.dofutz = 0;
    if (!isdefined(weapon.disableremoteweaponswitch)) {
        remoteweapon = getweapon(#"killstreak_remote");
        weapon.remoteowner giveweapon(remoteweapon);
        weapon.remoteowner switchtoweapon(remoteweapon);
        if (always_allow_ride) {
            weapon.remoteowner waittill(#"weapon_change", #"death");
        } else {
            waitresult = weapon.remoteowner waittill(#"weapon_change");
            newweapon = waitresult.weapon;
        }
    }
    if (isdefined(newweapon)) {
        if (newweapon != remoteweapon) {
            weapon.remoteowner killstreaks::clear_using_remote(1, 1);
            return;
        }
    }
    weapon callback::function_1dea870d(#"on_end_game", &on_game_ended);
    weapon.var_5cd6e100 = 1;
    weapon.remoteowner thread killstreaks::watch_for_remove_remote_weapon();
    weapon.remoteowner util::setusingremote(weapon.remotename);
    weapon.remoteowner val::set(#"useremotecontrolweapon", "freezecontrols");
    weapon.remoteowner thread resetcontrols(weapon);
    result = weapon.remoteowner killstreaks::init_ride_killstreak(weapon.remotename, always_allow_ride);
    if (result != "success") {
        if (result != "disconnect") {
            weapon.remoteowner killstreaks::clear_using_remote();
            weapon thread resetcontrolinitiateduponownerrespawn();
        }
    } else {
        weapon.controlled = 1;
        weapon.killcament = self;
        weapon notify(#"remote_start");
        if (allowmanualdeactivation) {
            weapon thread watchremotecontroldeactivate();
        }
        weapon.remoteowner thread [[ level.remoteweapons[weapon.remotename].usecallback ]](weapon);
        if (level.remoteweapons[weapon.remotename].hidecompassonuse) {
            weapon.remoteowner killstreaks::hide_compass();
        }
    }
    weapon notify(#"reset_controls");
}

// Namespace remote_weapons/remote_weapons
// Params 1, eflags: 0x0
// Checksum 0x3033ed6e, Offset: 0x1378
// Size: 0x6c
function resetcontrols(weapon) {
    self endon(#"death");
    weapon waittill(#"death", #"reset_controls");
    self val::reset(#"useremotecontrolweapon", "freezecontrols");
}

// Namespace remote_weapons/remote_weapons
// Params 0, eflags: 0x0
// Checksum 0x8a6ec586, Offset: 0x13f0
// Size: 0x3a
function resetcontrolinitiateduponownerrespawn() {
    self endon(#"death");
    self.remoteowner waittill(#"spawned");
    self.control_initiated = 0;
}

// Namespace remote_weapons/remote_weapons
// Params 0, eflags: 0x0
// Checksum 0xf9002da9, Offset: 0x1438
// Size: 0x140
function watchremotecontroldeactivate() {
    self notify(#"watchremotecontroldeactivate_remoteweapons");
    self endon(#"watchremotecontroldeactivate_remoteweapons");
    weapon = self;
    weapon endon(#"remote_weapon_end");
    weapon endon(#"death");
    weapon.remoteowner endon(#"disconnect");
    while (weapon.remoteowner usebuttonpressed()) {
        waitframe(1);
    }
    while (true) {
        timeused = 0;
        while (weapon.remoteowner usebuttonpressed()) {
            timeused += 0.05;
            if (timeused > 0.25) {
                weapon thread endremotecontrolweaponuse(1);
                weapon.lastusetime = gettime();
                return;
            }
            waitframe(1);
        }
        waitframe(1);
    }
}

// Namespace remote_weapons/remote_weapons
// Params 2, eflags: 0x0
// Checksum 0xb1d3aa17, Offset: 0x1580
// Size: 0x530
function endremotecontrolweaponuse(exitrequestedbyowner, gameended) {
    weapon = self;
    if (!isdefined(weapon) || isdefined(weapon.endremotecontrolweapon) && weapon.endremotecontrolweapon) {
        return;
    }
    weapon.endremotecontrolweapon = 1;
    remote_controlled = isdefined(weapon.control_initiated) && weapon.control_initiated || isdefined(weapon.controlled) && weapon.controlled;
    while (isdefined(weapon) && weapon.forcewaitremotecontrol === 1 && remote_controlled == 0) {
        remote_controlled = isdefined(weapon.control_initiated) && weapon.control_initiated || isdefined(weapon.controlled) && weapon.controlled;
        waitframe(1);
    }
    if (!isdefined(weapon)) {
        return;
    }
    if (isdefined(weapon.remoteowner) && remote_controlled) {
        if (isdefined(weapon.remoteweaponshutdowndelay)) {
            wait weapon.remoteweaponshutdowndelay;
        }
        player = weapon.remoteowner;
        if (player.dofutz === 1) {
            player clientfield::set_to_player("static_postfx", 1);
            wait 1;
            if (isdefined(player)) {
                player clientfield::set_to_player("static_postfx", 0);
                player.dofutz = 0;
            }
        } else if (!exitrequestedbyowner && weapon.watch_remote_weapon_death === 1 && !isalive(weapon)) {
            weapon.dontfreeme = 1;
            wait isdefined(weapon.watch_remote_weapon_death_duration) ? weapon.watch_remote_weapon_death_duration : 1;
            weapon.dontfreeme = undefined;
        }
        if (isdefined(player)) {
            player thread fadetoblackandbackin();
            player waittill(#"fade2black");
            if (remote_controlled) {
                player unlink();
            }
            player killstreaks::clear_using_remote(1, undefined, gameended);
            cleared_killstreak_delay = 1;
            player enableusability();
        }
    }
    if (isdefined(weapon) && isdefined(weapon.remotename)) {
        self [[ level.remoteweapons[weapon.remotename].endusecallback ]](weapon, exitrequestedbyowner);
    }
    if (isdefined(weapon)) {
        weapon.killcament = weapon;
        if (isdefined(weapon.remoteowner)) {
            if (remote_controlled) {
                weapon.remoteowner unlink();
                if (!(isdefined(cleared_killstreak_delay) && cleared_killstreak_delay)) {
                    weapon.remoteowner killstreaks::reset_killstreak_delay_killcam();
                }
                weapon.remoteowner util::clientnotify("nofutz");
            }
            if (isdefined(level.gameended) && level.gameended) {
                weapon.remoteowner val::set(#"game_end", "freezecontrols");
            }
        }
    }
    if (isdefined(weapon)) {
        if (isdefined(weapon.var_5cd6e100) && weapon.var_5cd6e100) {
            weapon callback::function_1f42556c(#"on_end_game", &on_game_ended);
        }
        weapon.control_initiated = 0;
        weapon.controlled = 0;
        if (isdefined(weapon.remoteowner)) {
            weapon.remoteowner killstreaks::unhide_compass();
        }
        if (!exitrequestedbyowner || isdefined(weapon.one_remote_use) && weapon.one_remote_use) {
            weapon notify(#"remote_weapon_end");
        }
    }
}

// Namespace remote_weapons/remote_weapons
// Params 0, eflags: 0x0
// Checksum 0x4acc126, Offset: 0x1ab8
// Size: 0x7c
function fadetoblackandbackin() {
    self endon(#"disconnect");
    lui::screen_fade_out(0.1);
    self destroyhud();
    waitframe(1);
    self notify(#"fade2black");
    lui::screen_fade_in(0.2);
}

// Namespace remote_weapons/remote_weapons
// Params 1, eflags: 0x0
// Checksum 0x2c347f25, Offset: 0x1b40
// Size: 0x70
function stunstaticfx(duration) {
    self endon(#"remove_remote_weapon");
    wait duration - 0.5;
    for (time = duration - 0.5; time < duration; time += 0.05) {
        waitframe(1);
    }
}

// Namespace remote_weapons/remote_weapons
// Params 0, eflags: 0x0
// Checksum 0x7fe57ab6, Offset: 0x1bb8
// Size: 0x84
function destroyhud() {
    if (isdefined(self)) {
        self notify(#"stop_signal_failure");
        self.flashingsignalfailure = 0;
        self clientfield::set_to_player("static_postfx", 0);
        self destroyremotehud();
        self util::clientnotify("nofutz");
    }
}

// Namespace remote_weapons/remote_weapons
// Params 0, eflags: 0x0
// Checksum 0x7bc4f57e, Offset: 0x1c48
// Size: 0x34
function destroyremotehud() {
    self useservervisionset(0);
    self setinfraredvision(0);
}

// Namespace remote_weapons/remote_weapons
// Params 1, eflags: 0x0
// Checksum 0x262d83c1, Offset: 0x1c88
// Size: 0xac
function set_static(val) {
    owner = self.owner;
    if (val) {
        if (isdefined(owner) && owner.usingvehicle && isdefined(owner.viewlockedentity) && owner.viewlockedentity == self) {
            owner clientfield::set_to_player("static_postfx", 1);
        }
        return;
    }
    if (isdefined(owner)) {
        owner function_f5ab8f3();
    }
}

// Namespace remote_weapons/remote_weapons
// Params 0, eflags: 0x0
// Checksum 0x3ad5d538, Offset: 0x1d40
// Size: 0x24
function function_f5ab8f3() {
    self clientfield::set_to_player("static_postfx", 0);
}

// Namespace remote_weapons/remote_weapons
// Params 0, eflags: 0x0
// Checksum 0x8275e6a5, Offset: 0x1d70
// Size: 0x6e
function do_static_fx() {
    self set_static(1);
    owner = self.owner;
    wait 2;
    if (isdefined(owner)) {
        owner function_f5ab8f3();
    }
    if (isdefined(self)) {
        self notify(#"static_fx_done");
    }
}

