#using script_1cd491b1807da8f7;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gestures;
#using scripts\core_common\system_shared;

#namespace namespace_f3e83343;

// Namespace namespace_f3e83343/namespace_f3e83343
// Params 0, eflags: 0x6
// Checksum 0xbb008f01, Offset: 0x138
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_56764d013a0eb19c", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace namespace_f3e83343/namespace_f3e83343
// Params 0, eflags: 0x1 linked
// Checksum 0x3a62518f, Offset: 0x180
// Size: 0x25c
function function_70a657d8() {
    dynents = getdynentarray("dynent_garage_button");
    foreach (dynent in dynents) {
        dynent.onuse = &function_51a020;
        dynent.ondamaged = &function_724a2fa5;
    }
    dynents = getdynentarray("dynent_door_check_for_vehicles");
    foreach (dynent in dynents) {
        dynent.onuse = &function_d7b6ee00;
    }
    dynents = getdynentarray("dynent_destroyable_door");
    foreach (dynent in dynents) {
        dynent.ondamaged = &function_5d409a7b;
        dynent.maxhealth = dynent.health;
    }
    doors = function_f3e164a9(#"hash_4d1fb8524fdfd254");
    if (isdefined(doors) && doors.size > 0) {
        level thread function_92f2f8cf(doors);
        level thread function_160e40a2();
    }
}

// Namespace namespace_f3e83343/namespace_f3e83343
// Params 0, eflags: 0x1 linked
// Checksum 0xce1212ff, Offset: 0x3e8
// Size: 0x93c
function function_160e40a2() {
    level endon(#"game_ended");
    var_1a1c0d86 = 0;
    cosangle = cos(20);
    var_3393f5fe = cos(50);
    var_2c51fa57 = function_a3f6cdac(64);
    while (true) {
        foreach (i, player in getplayers()) {
            time = gettime();
            if (i % 5 == var_1a1c0d86) {
                if (!isdefined(player.var_8a022726)) {
                    continue;
                }
                if (player issprinting() || player issliding()) {
                    var_42b5b0df = player getvelocity() * 0.25;
                    var_40676129 = player.origin + var_42b5b0df;
                    playerorigin = player.origin;
                    bounds = (150, 150, 75);
                    var_5ed7231a = player getcentroid();
                    var_e86a4d9 = function_db4bc717(var_5ed7231a, bounds);
                    foreach (dynent in var_e86a4d9) {
                        if (isdefined(dynent.var_a548ec11) && dynent.var_a548ec11 > time) {
                            continue;
                        }
                        if (dynent.script_noteworthy !== #"hash_4d1fb8524fdfd254") {
                            continue;
                        }
                        bundle = function_489009c1(dynent);
                        v_offset = (isdefined(bundle.var_aa0fba03) ? bundle.var_aa0fba03 : 0, isdefined(bundle.var_f8525687) ? bundle.var_f8525687 : 0, isdefined(bundle.var_54b28eee) ? bundle.var_54b28eee : 0);
                        v_offset = rotatepoint(v_offset, dynent.angles);
                        var_dea242aa = dynent.origin + v_offset;
                        playerdir = var_dea242aa - playerorigin;
                        playerdir = vectornormalize((playerdir[0], playerdir[1], 0));
                        var_f8682cca = vectordot(anglestoforward(player.angles), playerdir);
                        var_772fc240 = distance2dsquared(playerorigin, var_dea242aa);
                        isnear = var_772fc240 <= var_2c51fa57;
                        if (!isnear && var_f8682cca <= cosangle || isnear && var_f8682cca <= var_3393f5fe) {
                            continue;
                        }
                        var_df2e06ad = distance2dsquared(var_40676129, var_dea242aa);
                        var_cdc68fb8 = distance2dsquared(playerorigin, var_dea242aa);
                        if (var_df2e06ad <= function_a3f6cdac(75) || var_cdc68fb8 <= function_a3f6cdac(100)) {
                            stateindex = function_ffdbe8c2(dynent);
                            if (stateindex == 1 || stateindex == 2) {
                                if (var_df2e06ad > function_a3f6cdac(75 * 0.5) && var_cdc68fb8 > function_a3f6cdac(100 * 0.5)) {
                                    continue;
                                }
                                var_b4b3af4c = anglestoforward(dynent.angles);
                                playerdir = var_dea242aa - playerorigin;
                                playerdir = vectornormalize((playerdir[0], playerdir[1], 0));
                                dot = vectordot(var_b4b3af4c, playerdir);
                                if (dot >= 0 && stateindex == 1) {
                                    continue;
                                } else if (dot <= 0 && stateindex == 2) {
                                    continue;
                                }
                            } else if (stateindex == 0) {
                                var_b4b3af4c = anglestoforward(dynent.angles);
                                var_4df98d7a = anglestoforward(player.angles);
                                dot = abs(vectordot(var_b4b3af4c, var_4df98d7a));
                                if (dot < cos(45)) {
                                    continue;
                                }
                            } else if (stateindex == 3) {
                                continue;
                            }
                            var_dbfa3e4e = bullettrace(player.origin, var_dea242aa, 0, player, 0);
                            if (!isdefined(var_dbfa3e4e[#"dynent"])) {
                                continue;
                            }
                            bundle = function_489009c1(dynent);
                            if (isdefined(bundle) && isdefined(bundle.dynentstates) && isdefined(bundle.dynentstates[stateindex])) {
                                var_bb075e98 = {#origin:var_dea242aa};
                                var_a852a7dd = var_bb075e98 dynent_use::use_dynent(dynent, player, 1, 1);
                                player gestures::play_gesture("ges_t9_door_shove", undefined, 0);
                                playrumbleonposition("door_shove", dynent.origin);
                                playsoundatposition("evt_door_bash", dynent.origin);
                                playfx("debris/fx9_door_bash", dynent.origin, anglestoforward(dynent.angles), anglestoup(dynent.angles));
                                var_a548ec11 = 1;
                                dynent.var_a548ec11 = gettime() + int(var_a852a7dd * 1000) + int(var_a548ec11 * 1000);
                            }
                        }
                    }
                }
            }
        }
        var_1a1c0d86 = (var_1a1c0d86 + 1) % 5;
        waitframe(1);
    }
}

// Namespace namespace_f3e83343/namespace_f3e83343
// Params 1, eflags: 0x1 linked
// Checksum 0x6a37a350, Offset: 0xd30
// Size: 0x8e
function function_92f2f8cf(doors) {
    foreach (door in doors) {
        door.ondamaged = &function_c743094d;
    }
}

// Namespace namespace_f3e83343/namespace_f3e83343
// Params 1, eflags: 0x1 linked
// Checksum 0xb2b12248, Offset: 0xdc8
// Size: 0x292
function function_c743094d(eventstruct) {
    dynent = eventstruct.ent;
    activator = eventstruct.attacker;
    if (is_true(eventstruct.melee) && isplayer(activator) && isdefined(activator.var_8a022726) && activator.var_8a022726 istriggerenabled()) {
        dynent.health += eventstruct.amount;
        stateindex = function_ffdbe8c2(dynent);
        if (stateindex == 1 || stateindex == 2) {
            var_b4b3af4c = anglestoforward(dynent.angles);
            playerdir = activator.var_8a022726.origin - activator.origin;
            playerdir = vectornormalize((playerdir[0], playerdir[1], 0));
            dot = vectordot(var_b4b3af4c, playerdir);
            if (dot >= 0 && stateindex == 1) {
                return;
            } else if (dot <= 0 && stateindex == 2) {
                return;
            }
        }
        bundle = function_489009c1(dynent);
        if (isdefined(bundle) && isdefined(bundle.dynentstates) && isdefined(bundle.dynentstates[stateindex])) {
            var_a852a7dd = eventstruct.attacker.var_8a022726 dynent_use::use_dynent(dynent, eventstruct.attacker);
            playrumbleonposition("door_shove", dynent.origin);
            dynent.var_a548ec11 = gettime() + var_a852a7dd * 1000;
        }
    }
}

// Namespace namespace_f3e83343/namespace_f3e83343
// Params 0, eflags: 0x0
// Checksum 0xd2286710, Offset: 0x1068
// Size: 0x1a8
function function_ded5d217() {
    var_7b969086 = getdynentarray("wind_turbine");
    foreach (turbine in var_7b969086) {
        if (randomint(100) > 20) {
            function_e2a06860(turbine, randomintrange(1, 4));
        }
    }
    level flag::wait_till(#"hash_507a4486c4a79f1d");
    foreach (turbine in var_7b969086) {
        if (randomint(100) > 20) {
            function_e2a06860(turbine, randomintrange(1, 4));
        }
    }
}

// Namespace namespace_f3e83343/namespace_f3e83343
// Params 3, eflags: 0x1 linked
// Checksum 0x45fa9d69, Offset: 0x1218
// Size: 0x1f4
function function_d7b6ee00(activator, laststate, state) {
    if (laststate == state) {
        return;
    }
    if (state != 0) {
        forward = anglestoforward(self.angles);
        right = anglestoright(self.angles);
        bounds = function_c440d28e(self.var_15d44120);
        start = self.origin + (0, 0, 35);
        start -= right * (bounds.mins[1] + bounds.maxs[1]) * 0.5;
        if (state == 1) {
            start += forward * 5;
            end = start + forward * 35;
        } else {
            start -= forward * 5;
            end = start - forward * 35;
        }
        /#
            line(start, end, (1, 1, 1), 1, 1, 300);
        #/
        results = bullettracepassed(start, end, 0, activator);
        if (!results) {
            if (state == 1) {
                state = 2;
            } else if (state == 2) {
                state = 1;
            }
            function_e2a06860(self, state);
            return 0;
        }
    }
    return 1;
}

// Namespace namespace_f3e83343/namespace_f3e83343
// Params 3, eflags: 0x1 linked
// Checksum 0x99271847, Offset: 0x1418
// Size: 0x230
function function_51a020(activator, laststate, state) {
    if (isdefined(self.target)) {
        if (laststate == state) {
            return false;
        }
        var_a9309589 = getdynent(self.target);
        currentstate = function_ffdbe8c2(var_a9309589);
        if (state == 0) {
            right = anglestoright(var_a9309589.angles);
            bounds = function_c440d28e(var_a9309589.var_15d44120);
            center = var_a9309589.origin + (0, 0, 25);
            start = center + right * bounds.mins[1] * 0.85;
            end = center + right * bounds.maxs[1] * 0.85;
            results = bullettracepassed(start, end, 0, activator);
            if (!results) {
                return false;
            }
            center = var_a9309589.origin + (0, 0, 40);
            start = center + right * bounds.mins[1] * 0.85;
            end = center + right * bounds.maxs[1] * 0.85;
            results = bullettracepassed(start, end, 0, activator);
            if (!results) {
                return false;
            }
        }
        if (currentstate != state) {
            function_e2a06860(var_a9309589, state);
        }
    }
    return true;
}

// Namespace namespace_f3e83343/namespace_f3e83343
// Params 1, eflags: 0x5 linked
// Checksum 0xb12b88f8, Offset: 0x1650
// Size: 0xee
function private function_724a2fa5(eventstruct) {
    dynent = eventstruct.ent;
    if (isdefined(eventstruct)) {
        dynent.health += eventstruct.amount;
    }
    if (isdefined(dynent.var_a548ec11) && gettime() <= dynent.var_a548ec11) {
        return;
    }
    if (distancesquared(eventstruct.ent.origin, eventstruct.position) > function_a3f6cdac(15)) {
        return;
    }
    var_a852a7dd = dynent_use::use_dynent(dynent);
    dynent.var_a548ec11 = gettime() + var_a852a7dd * 1000;
}

// Namespace namespace_f3e83343/namespace_f3e83343
// Params 1, eflags: 0x5 linked
// Checksum 0xfeb7556d, Offset: 0x1748
// Size: 0x9c
function private function_5d409a7b(eventstruct) {
    dynent = eventstruct.ent;
    state = function_ffdbe8c2(dynent);
    if (state <= 2) {
        var_6c9f448d = dynent.health / dynent.maxhealth;
        if (var_6c9f448d <= 0.5) {
            function_e2a06860(dynent, state + 3);
        }
    }
}

