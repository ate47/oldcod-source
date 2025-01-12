#using scripts\core_common\laststand_shared;
#using scripts\core_common\oob;
#using scripts\core_common\scene_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\weapons\deployable;

#namespace placeables;

// Namespace placeables/placeables
// Params 20, eflags: 0x0
// Checksum 0x22f906c1, Offset: 0x100
// Size: 0x4e0
function spawnplaceable(onplacecallback, oncancelcallback, onmovecallback, onshutdowncallback, ondeathcallback, onempcallback, ondamagecallback, var_1cebc6ef, model, validmodel, invalidmodel, spawnsvehicle, pickupstring, timeout, health, empdamage, placehintstring, invalidlocationhintstring, placeimmediately = 0, var_78eae2a6 = undefined) {
    player = self;
    placeable = spawn("script_model", player.origin);
    placeable.cancelable = 1;
    placeable.held = 0;
    placeable.validmodel = validmodel;
    placeable.invalidmodel = invalidmodel;
    placeable.oncancel = oncancelcallback;
    placeable.onemp = onempcallback;
    placeable.onmove = onmovecallback;
    placeable.onplace = onplacecallback;
    placeable.onshutdown = onshutdowncallback;
    placeable.ondeath = ondeathcallback;
    placeable.ondamagecallback = ondamagecallback;
    placeable.var_1cebc6ef = var_1cebc6ef;
    placeable.owner = player;
    placeable.originalowner = player;
    placeable.ownerentnum = player.entnum;
    placeable.originalownerentnum = player.entnum;
    placeable.pickupstring = pickupstring;
    placeable.placedmodel = model;
    placeable.spawnsvehicle = spawnsvehicle;
    placeable.originalteam = player.team;
    placeable.team = player.team;
    placeable.timedout = 0;
    placeable.timeout = timeout;
    placeable.timeoutstarted = 0;
    placeable.angles = (0, player.angles[1], 0);
    placeable.placehintstring = placehintstring;
    placeable.invalidlocationhintstring = invalidlocationhintstring;
    placeable.placeimmediately = placeimmediately;
    if (!isdefined(placeable.placehintstring)) {
        placeable.placehintstring = "";
    }
    if (!isdefined(placeable.invalidlocationhintstring)) {
        placeable.invalidlocationhintstring = "";
    }
    placeable notsolid();
    if (isdefined(placeable.vehicle)) {
        placeable.vehicle notsolid();
    }
    placeable.othermodel = spawn("script_model", player.origin);
    placeable.othermodel setmodel(placeable.placedmodel);
    placeable.othermodel setinvisibletoplayer(player);
    placeable.othermodel notsolid();
    if (isdefined(health) && health > 0 && isdefined(var_78eae2a6)) {
        placeable.health = health;
        placeable setcandamage(0);
        placeable thread [[ var_78eae2a6 ]](ondamagecallback, &ondeath, empdamage, &onemp);
    }
    player thread carryplaceable(placeable);
    level thread cancelongameend(placeable);
    player thread shutdownoncancelevent(placeable);
    player thread cancelonplayerdisconnect(placeable);
    placeable thread watchownergameevents();
    return placeable;
}

// Namespace placeables/placeables
// Params 1, eflags: 0x0
// Checksum 0x2e3598af, Offset: 0x5e8
// Size: 0x104
function function_33a21108(placeable) {
    player = self;
    if (isdefined(placeable)) {
        if (isdefined(placeable.weapon)) {
            if (placeable.weapon.deployable) {
                deployable::register_deployable(placeable.weapon, placeable.var_f272c85b, undefined, placeable.placehintstring, placeable.invalidlocationhintstring);
                if (isplayer(player)) {
                    player giveweapon(placeable.weapon);
                    player givestartammo(placeable.weapon);
                    player switchtoweapon(placeable.weapon);
                }
            }
        }
    }
}

// Namespace placeables/placeables
// Params 1, eflags: 0x0
// Checksum 0xbffc55d8, Offset: 0x6f8
// Size: 0x7c
function function_7add3c1e(placeable) {
    player = self;
    if (isdefined(placeable)) {
        if (isdefined(placeable.weapon)) {
            if (placeable.weapon.deployable) {
                if (isplayer(player)) {
                    player takeweapon(placeable.weapon);
                }
            }
        }
    }
}

// Namespace placeables/placeables
// Params 14, eflags: 0x0
// Checksum 0x3920b307, Offset: 0x780
// Size: 0x330
function function_9f65ced6(onplacecallback, oncancelcallback, onmovecallback, onshutdowncallback, ondeathcallback, onempcallback, ondamagecallback, var_1cebc6ef, var_e84680fe, weapon, pickupstring, placehintstring, invalidlocationhintstring, timeout) {
    player = self;
    placeable = spawn("script_model", player.origin);
    placeable.cancelable = 1;
    placeable.held = 0;
    placeable.oncancel = oncancelcallback;
    placeable.onemp = onempcallback;
    placeable.onmove = onmovecallback;
    placeable.onplace = onplacecallback;
    placeable.onshutdown = onshutdowncallback;
    placeable.ondeath = ondeathcallback;
    placeable.ondamagecallback = ondamagecallback;
    placeable.var_1cebc6ef = var_1cebc6ef;
    placeable.owner = player;
    placeable.originalowner = player;
    placeable.ownerentnum = player.entnum;
    placeable.originalownerentnum = player.entnum;
    placeable.pickupstring = pickupstring;
    placeable.placehintstring = placehintstring;
    placeable.invalidlocationhintstring = invalidlocationhintstring;
    placeable.originalteam = player.team;
    placeable.team = player.team;
    placeable.timedout = 0;
    placeable.timeout = timeout;
    placeable.timeoutstarted = 0;
    placeable.angles = (0, player.angles[1], 0);
    placeable.placeimmediately = 0;
    placeable.weapon = weapon;
    placeable.var_f272c85b = var_e84680fe;
    if (!isdefined(placeable.placehintstring)) {
        placeable.placehintstring = "";
    }
    if (!isdefined(placeable.invalidlocationhintstring)) {
        placeable.invalidlocationhintstring = "";
    }
    player function_33a21108(placeable);
    player thread function_8a561896(placeable);
    player thread shutdownoncancelevent(placeable);
    player thread cancelonplayerdisconnect(placeable);
    placeable thread watchownergameevents();
    return placeable;
}

// Namespace placeables/placeables
// Params 1, eflags: 0x0
// Checksum 0xa480474a, Offset: 0xab8
// Size: 0x272
function function_8a561896(placeable) {
    player = self;
    player endon(#"disconnect");
    player endon(#"death");
    placeable endon(#"placed");
    placeable endon(#"cancelled");
    player notify(#"placeable_deployable");
    player endon(#"placeable_deployable");
    placeable notsolid();
    if (isdefined(placeable.vehicle)) {
        placeable.vehicle notsolid();
    }
    player thread watchcarrycancelevents(placeable);
    player thread function_f5212217(placeable);
    while (player getcurrentweapon() != placeable.weapon) {
        waitframe(1);
    }
    while (true) {
        waitresult = player waittill(#"weapon_fired", #"weapon_switch_started");
        if (waitresult.weapon != placeable.weapon) {
            placeable notify(#"cancelled");
            return;
        }
        if (isdefined(level.var_d280b204)) {
            [[ level.var_d280b204 ]](placeable.weapon);
        }
        if (isdefined(self.var_3f2d5683) && self.var_3f2d5683 && isdefined(self.var_ac6d9bd1) && isdefined(self.var_ac6d9bd1)) {
            placeable.held = 0;
            player.holding_placeable = undefined;
            placeable.cancelable = 0;
            placeable.origin = self.var_ac6d9bd1;
            placeable.angles = self.var_fc43d05f;
            player onplace(placeable);
            return;
        }
    }
}

// Namespace placeables/placeables
// Params 3, eflags: 0x0
// Checksum 0x6d4b2853, Offset: 0xd38
// Size: 0x5a
function updateplacementmodels(model, validmodel, invalidmodel) {
    placeable = self;
    placeable.placedmodel = model;
    placeable.validmodel = validmodel;
    placeable.invalidmodel = invalidmodel;
}

// Namespace placeables/placeables
// Params 1, eflags: 0x0
// Checksum 0x5c811d33, Offset: 0xda0
// Size: 0x174
function carryplaceable(placeable) {
    player = self;
    placeable show();
    placeable notsolid();
    if (isdefined(placeable.vehicle)) {
        placeable.vehicle notsolid();
    }
    if (isdefined(placeable.othermodel)) {
        placeable thread util::ghost_wait_show_to_player(player, 0.05, "abort_ghost_wait_show");
        placeable.othermodel thread util::ghost_wait_show_to_others(player, 0.05, "abort_ghost_wait_show");
        placeable.othermodel notsolid();
    }
    placeable.held = 1;
    player.holding_placeable = placeable;
    player carryturret(placeable, (40, 0, 0), (0, 0, 0));
    player val::set(#"placeable", "disable_weapons");
    player thread watchplacement(placeable);
}

// Namespace placeables/placeables
// Params 0, eflags: 0x0
// Checksum 0x2567e611, Offset: 0xf20
// Size: 0xf6
function innoplacementtrigger() {
    placeable = self;
    if (isdefined(level.noturretplacementtriggers)) {
        for (i = 0; i < level.noturretplacementtriggers.size; i++) {
            if (placeable istouching(level.noturretplacementtriggers[i])) {
                return true;
            }
        }
    }
    if (isdefined(level.fatal_triggers)) {
        for (i = 0; i < level.fatal_triggers.size; i++) {
            if (placeable istouching(level.fatal_triggers[i])) {
                return true;
            }
        }
    }
    if (placeable oob::istouchinganyoobtrigger()) {
        return true;
    }
    return false;
}

// Namespace placeables/placeables
// Params 1, eflags: 0x0
// Checksum 0x66d78ba3, Offset: 0x1020
// Size: 0x170
function waitforplaceabletobebuilt(player) {
    placeable = self;
    buildlength = int(placeable.buildtime * 1000);
    if (isdefined(placeable.buildstartedfunc)) {
        if (![[ placeable.buildstartedfunc ]](placeable, player)) {
            return 0;
        }
    }
    starttime = gettime();
    endtime = starttime + buildlength;
    finishedbuilding = 1;
    while (gettime() < endtime) {
        if (!player attackbuttonpressed()) {
            finishedbuilding = 0;
            break;
        }
        if (isdefined(placeable.buildprogressfunc)) {
            [[ placeable.buildprogressfunc ]](placeable, player, (gettime() - starttime) / buildlength);
        }
        waitframe(1);
    }
    finished = player attackbuttonpressed();
    if (isdefined(placeable.buildfinishedfunc)) {
        [[ placeable.buildfinishedfunc ]](placeable, player, finishedbuilding);
    }
    return finishedbuilding;
}

// Namespace placeables/placeables
// Params 1, eflags: 0x0
// Checksum 0x17bf020d, Offset: 0x1198
// Size: 0x2a
function function_62fe4623(callbackfunc) {
    placeable = self;
    placeable.var_c789348f = callbackfunc;
}

// Namespace placeables/placeables
// Params 0, eflags: 0x0
// Checksum 0xe6cd771d, Offset: 0x11d0
// Size: 0x12
function function_d3de2a7b() {
    self.var_55646b69 = 1;
}

// Namespace placeables/placeables
// Params 1, eflags: 0x0
// Checksum 0x2ca555f5, Offset: 0x11f0
// Size: 0x76e
function watchplacement(placeable) {
    player = self;
    player endon(#"disconnect");
    player endon(#"death");
    placeable endon(#"placed");
    placeable endon(#"cancelled");
    player thread watchcarrycancelevents(placeable);
    player thread function_f5212217(placeable);
    lastattempt = -1;
    placeable.canbeplaced = 0;
    waitingforattackbuttonrelease = 1;
    while (true) {
        placement = player canplayerplaceturret();
        placeable.origin = placement[#"origin"];
        placeable.angles = placement[#"angles"];
        placeable.canbeplaced = placement[#"result"] && !placeable innoplacementtrigger();
        laststand = player laststand::player_is_in_laststand();
        in_igc = player scene::is_igc_active();
        if (laststand || in_igc) {
            placeable.canbeplaced = 0;
        }
        if (isdefined(placeable.othermodel)) {
            placeable.othermodel.origin = placement[#"origin"];
            placeable.othermodel.angles = placement[#"angles"];
        }
        if (placeable.canbeplaced != lastattempt) {
            if (placeable.canbeplaced) {
                placeable setmodel(placeable.validmodel);
                player sethintstring(placeable.placehintstring);
            } else {
                placeable setmodel(placeable.invalidmodel);
                player sethintstring(placeable.invalidlocationhintstring);
            }
            lastattempt = placeable.canbeplaced;
        }
        while (waitingforattackbuttonrelease && !player attackbuttonpressed()) {
            waitingforattackbuttonrelease = 0;
        }
        if (!waitingforattackbuttonrelease && placeable.canbeplaced && player attackbuttonpressed() || placeable.placeimmediately) {
            buildallowed = 1;
            if (isdefined(placeable.buildtime) && placeable.buildtime > 0) {
                player sethintstring(placeable.buildinghintstring);
                finishedbuilding = placeable waitforplaceabletobebuilt(player);
                if (!finishedbuilding) {
                    buildallowed = 0;
                    player sethintstring(placeable.placehintstring);
                }
            }
            if (placement[#"result"] && buildallowed && isdefined(placeable.var_c789348f)) {
                buildallowed = placeable [[ placeable.var_c789348f ]](placement[#"origin"], player);
            }
            if (placement[#"result"] && buildallowed) {
                placeable.origin = placement[#"origin"];
                placeable.angles = placement[#"angles"];
                player sethintstring("");
                player stopcarryturret(placeable);
                player val::reset(#"placeable", "disable_weapons");
                placeable.held = 0;
                player.holding_placeable = undefined;
                placeable.cancelable = 0;
                if (isdefined(placeable.health) && placeable.health) {
                    placeable setcandamage(1);
                    placeable solid();
                }
                if (isdefined(placeable.placedmodel) && !placeable.spawnsvehicle) {
                    placeable setmodel(placeable.placedmodel);
                } else {
                    placeable notify(#"abort_ghost_wait_show");
                    placeable.abort_ghost_wait_show_to_player = 1;
                    placeable.abort_ghost_wait_show_to_others = 1;
                    placeable ghost();
                    if (isdefined(placeable.othermodel)) {
                        placeable.othermodel notify(#"abort_ghost_wait_show");
                        placeable.othermodel.abort_ghost_wait_show_to_player = 1;
                        placeable.othermodel.abort_ghost_wait_show_to_others = 1;
                        placeable.othermodel ghost();
                    }
                }
                if (isdefined(placeable.timeout)) {
                    if (!placeable.timeoutstarted) {
                        placeable.timeoutstarted = 1;
                        if (isdefined(placeable.var_1cebc6ef)) {
                            placeable thread [[ placeable.var_1cebc6ef ]](placeable.timeout, &ontimeout, "death", "cancelled");
                        }
                    } else if (placeable.timedout) {
                        placeable thread [[ placeable.var_1cebc6ef ]](5000, &ontimeout, "cancelled");
                    }
                }
                player onplace(placeable);
            }
        }
        waitframe(1);
    }
}

// Namespace placeables/placeables
// Params 1, eflags: 0x0
// Checksum 0xa74631a7, Offset: 0x1968
// Size: 0x1a
function function_e5e352ad(allow_alt) {
    self.var_f5f22a5f = allow_alt;
}

// Namespace placeables/placeables
// Params 1, eflags: 0x0
// Checksum 0x83cc6329, Offset: 0x1990
// Size: 0xe0
function watchcarrycancelevents(placeable) {
    player = self;
    assert(isplayer(player));
    placeable endon(#"cancelled");
    placeable endon(#"placed");
    player waittill(#"death", #"emp_jammed", #"emp_grenaded", #"disconnect", #"joined_team");
    placeable notify(#"cancelled");
}

// Namespace placeables/placeables
// Params 1, eflags: 0x0
// Checksum 0xfe18a121, Offset: 0x1a78
// Size: 0x232
function function_f5212217(placeable) {
    player = self;
    assert(isplayer(player));
    player endon(#"disconnect");
    player endon(#"death");
    placeable endon(#"placed");
    placeable endon(#"cancelled");
    while (true) {
        if ((isdefined(placeable.var_f5f22a5f) ? placeable.var_f5f22a5f : 0) && player changeseatbuttonpressed()) {
            placeable notify(#"cancelled");
        } else if (!(isdefined(placeable.var_f5f22a5f) ? placeable.var_f5f22a5f : 0) && placeable.cancelable && player actionslotfourbuttonpressed()) {
            placeable notify(#"cancelled");
        } else if (isdefined(placeable.var_ec2d3cdc) && placeable.var_ec2d3cdc && player laststand::player_is_in_laststand()) {
            placeable notify(#"cancelled");
        } else if (player scene::is_igc_active()) {
            placeable notify(#"cancelled");
        } else if (player isinvehicle()) {
            placeable notify(#"cancelled");
        }
        waitframe(1);
    }
}

// Namespace placeables/placeables
// Params 0, eflags: 0x0
// Checksum 0x357bcde9, Offset: 0x1cb8
// Size: 0x8c
function ontimeout() {
    placeable = self;
    if (isdefined(placeable.held) && placeable.held) {
        placeable.timedout = 1;
        return;
    }
    placeable notify(#"delete_placeable_trigger");
    placeable thread [[ placeable.var_1cebc6ef ]](5000, &forceshutdown, "cancelled");
}

// Namespace placeables/placeables
// Params 1, eflags: 0x0
// Checksum 0x3c3519fa, Offset: 0x1d50
// Size: 0xf0
function onplace(placeable) {
    player = self;
    if (isdefined(placeable.vehicle)) {
        placeable.vehicle setcandamage(1);
        placeable.vehicle solid();
    }
    player function_7add3c1e(placeable);
    if (isdefined(placeable.onplace)) {
        player [[ placeable.onplace ]](placeable);
        if (isdefined(placeable.onmove) && !placeable.timedout) {
            spawnmovetrigger(placeable, player);
        }
    }
    placeable notify(#"placed");
}

// Namespace placeables/placeables
// Params 1, eflags: 0x0
// Checksum 0x18d12b42, Offset: 0x1e48
// Size: 0xdc
function onmove(placeable) {
    player = self;
    player function_33a21108(placeable);
    assert(isdefined(placeable.onmove));
    if (isdefined(placeable.onmove)) {
        player [[ placeable.onmove ]](placeable);
    }
    if (isdefined(placeable.weapon) && placeable.weapon.deployable) {
        player thread function_8a561896(placeable);
        return;
    }
    player thread carryplaceable(placeable);
}

// Namespace placeables/placeables
// Params 1, eflags: 0x0
// Checksum 0x829c95f5, Offset: 0x1f30
// Size: 0x5c
function oncancel(placeable) {
    player = self;
    player function_7add3c1e(placeable);
    if (isdefined(placeable.oncancel)) {
        player [[ placeable.oncancel ]](placeable);
    }
}

// Namespace placeables/placeables
// Params 2, eflags: 0x0
// Checksum 0x9bfd2282, Offset: 0x1f98
// Size: 0x60
function ondeath(attacker, weapon) {
    placeable = self;
    if (isdefined(placeable.ondeath)) {
        [[ placeable.ondeath ]](attacker, weapon);
    }
    placeable notify(#"cancelled");
}

// Namespace placeables/placeables
// Params 1, eflags: 0x0
// Checksum 0x4f51b051, Offset: 0x2000
// Size: 0x44
function onemp(attacker) {
    placeable = self;
    if (isdefined(placeable.onemp)) {
        placeable [[ placeable.onemp ]](attacker);
    }
}

// Namespace placeables/placeables
// Params 1, eflags: 0x0
// Checksum 0x11fdf9d9, Offset: 0x2050
// Size: 0xc8
function cancelonplayerdisconnect(placeable) {
    placeable endon(#"hacked");
    player = self;
    assert(isplayer(player));
    placeable endon(#"cancelled");
    placeable endon(#"death");
    player waittill(#"disconnect", #"joined_team");
    placeable notify(#"cancelled");
}

// Namespace placeables/placeables
// Params 1, eflags: 0x0
// Checksum 0x82d8fbe6, Offset: 0x2120
// Size: 0x68
function cancelongameend(placeable) {
    placeable endon(#"cancelled");
    placeable endon(#"death");
    level waittill(#"game_ended");
    placeable notify(#"cancelled");
}

// Namespace placeables/placeables
// Params 2, eflags: 0x0
// Checksum 0x8661a816, Offset: 0x2190
// Size: 0x12c
function spawnmovetrigger(placeable, player) {
    pos = placeable.origin + (0, 0, 15);
    placeable.pickuptrigger = spawn("trigger_radius_use", pos);
    placeable.pickuptrigger setcursorhint("HINT_NOICON", placeable);
    placeable.pickuptrigger sethintstring(placeable.pickupstring);
    placeable.pickuptrigger setteamfortrigger(player.team);
    player clientclaimtrigger(placeable.pickuptrigger);
    placeable thread watchpickup(player);
    placeable.pickuptrigger thread watchmovetriggershutdown(placeable);
}

// Namespace placeables/placeables
// Params 1, eflags: 0x0
// Checksum 0x833b92db, Offset: 0x22c8
// Size: 0x8c
function watchmovetriggershutdown(placeable) {
    trigger = self;
    placeable waittill(#"cancelled", #"picked_up", #"death", #"delete_placeable_trigger", #"hacker_delete_placeable_trigger");
    placeable.pickuptrigger delete();
}

// Namespace placeables/placeables
// Params 1, eflags: 0x0
// Checksum 0x6dcafd72, Offset: 0x2360
// Size: 0x332
function watchpickup(player) {
    placeable = self;
    placeable endon(#"death");
    placeable endon(#"cancelled");
    assert(isdefined(placeable.pickuptrigger));
    trigger = placeable.pickuptrigger;
    while (true) {
        waitresult = trigger waittill(#"trigger");
        player = waitresult.activator;
        if (!isalive(player)) {
            continue;
        }
        if (player isusingoffhand()) {
            continue;
        }
        if (!player isonground()) {
            continue;
        }
        if (isdefined(placeable.vehicle) && placeable.vehicle.control_initiated === 1) {
            continue;
        }
        if (isdefined(player.carryobject) && player.carryobject.disallowplaceablepickup === 1) {
            continue;
        }
        if (isdefined(trigger.triggerteam) && player.team != trigger.triggerteam) {
            continue;
        }
        if (isdefined(trigger.claimedby) && player != trigger.claimedby) {
            continue;
        }
        if (player usebuttonpressed() && !player.throwinggrenade && !player meleebuttonpressed() && !player attackbuttonpressed() && !(isdefined(player.isplanting) && player.isplanting) && !(isdefined(player.isdefusing) && player.isdefusing) && !player isremotecontrolling() && !isdefined(player.holding_placeable)) {
            placeable notify(#"picked_up");
            if (isdefined(placeable.weapon_instance)) {
                placeable.weapon_instance notify(#"picked_up");
            }
            placeable.held = 1;
            placeable setcandamage(0);
            player onmove(placeable);
            return;
        }
    }
}

// Namespace placeables/placeables
// Params 0, eflags: 0x0
// Checksum 0x4c7db05a, Offset: 0x26a0
// Size: 0x30
function forceshutdown() {
    placeable = self;
    placeable.cancelable = 0;
    placeable notify(#"cancelled");
}

// Namespace placeables/placeables
// Params 0, eflags: 0x0
// Checksum 0x4615a9bb, Offset: 0x26d8
// Size: 0xb4
function watchownergameevents() {
    self notify(#"watchownergameevents_singleton");
    self endon(#"watchownergameevents_singleton");
    placeable = self;
    placeable endon(#"cancelled");
    placeable.owner waittill(#"joined_team", #"disconnect", #"joined_spectators");
    if (isdefined(placeable)) {
        placeable.abandoned = 1;
        placeable forceshutdown();
    }
}

// Namespace placeables/placeables
// Params 1, eflags: 0x0
// Checksum 0x468322f4, Offset: 0x2798
// Size: 0x3f4
function shutdownoncancelevent(placeable) {
    placeable endon(#"hacked");
    player = self;
    assert(isplayer(player));
    vehicle = placeable.vehicle;
    othermodel = placeable.othermodel;
    for (var_20689f6c = 1; var_20689f6c; var_20689f6c = 0) {
        waitresult = placeable waittill(#"cancelled", #"death");
        if ((isdefined(placeable.var_55646b69) ? placeable.var_55646b69 : 0) && waitresult._notify == "death") {
            continue;
        }
    }
    if (isdefined(placeable.weapon) && placeable.weapon.deployable) {
        if (isdefined(level.var_d280b204)) {
            [[ level.var_d280b204 ]](placeable.weapon);
        }
        if (isdefined(self.var_3f2d5683) && self.var_3f2d5683 && isdefined(player.var_ac6d9bd1) && isdefined(player.var_ac6d9bd1)) {
            placeable.origin = player.var_ac6d9bd1;
            placeable.angles = player.var_fc43d05f;
        }
    }
    if (isdefined(player) && isdefined(placeable) && placeable.held === 1) {
        player sethintstring("");
        player stopcarryturret(placeable);
        player val::reset(#"placeable", "disable_weapons");
    }
    if (isdefined(placeable)) {
        if (placeable.cancelable) {
            player oncancel(placeable);
        } else if (isdefined(placeable.onshutdown)) {
            [[ placeable.onshutdown ]](placeable);
        }
        if (isdefined(placeable)) {
            if (isdefined(placeable.vehicle)) {
                placeable.vehicle.selfdestruct = 1;
                placeable.vehicle._no_death_state = 1;
                placeable.vehicle kill();
                vehicle = undefined;
            }
            placeable.vehicle = undefined;
            if (isdefined(placeable.othermodel)) {
                placeable.othermodel delete();
            }
            placeable.othermodel = undefined;
            placeable delete();
        }
    }
    if (function_f68f5e32(placeable)) {
        if (isdefined(vehicle)) {
            vehicle.selfdestruct = 1;
            vehicle._no_death_state = 1;
            vehicle kill();
        }
        if (isdefined(othermodel)) {
            othermodel delete();
        }
    }
}

// Namespace placeables/placeables
// Params 5, eflags: 0x0
// Checksum 0x2b3e6fb3, Offset: 0x2b98
// Size: 0x8a
function setbuildable(buildtime, buildstartfunction, buildprogressupdatedfunction, buildfinishedfunction, buildingstring) {
    placeable = self;
    placeable.buildtime = buildtime;
    placeable.buildstartedfunc = buildstartfunction;
    placeable.buildprogressfunc = buildprogressupdatedfunction;
    placeable.buildfinishedfunc = buildfinishedfunction;
    placeable.buildinghintstring = buildingstring;
}

