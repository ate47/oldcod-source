#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\helicopter_shared;
#using scripts\killstreaks\killstreak_bundles;
#using scripts\killstreaks\killstreaks_util;

#namespace ir_strobe;

// Namespace ir_strobe/namespace_e9f92442
// Params 0, eflags: 0x0
// Checksum 0xe5ed6781, Offset: 0x128
// Size: 0x54
function init_shared() {
    if (!isdefined(level.var_94b11dc4)) {
        level.var_94b11dc4 = {};
        clientfield::register("toplayer", "marker_state", 1, 2, "int");
    }
}

// Namespace ir_strobe/namespace_e9f92442
// Params 2, eflags: 0x0
// Checksum 0x6afe610d, Offset: 0x188
// Size: 0x82
function function_aede4f7c(ksweap, activatefunc) {
    if (!isdefined(level.var_8dee3b91)) {
        level.var_8dee3b91 = [];
    } else if (isdefined(level.var_8dee3b91[ksweap])) {
        return;
    }
    level.var_8dee3b91[ksweap] = activatefunc;
    level.var_8dee3b91["inventory_" + ksweap] = activatefunc;
}

// Namespace ir_strobe/namespace_e9f92442
// Params 3, eflags: 0x0
// Checksum 0xe21aa901, Offset: 0x218
// Size: 0x6e
function function_4cccbb7f(owner, context, position) {
    if (isdefined(context.killstreaktype) && isdefined(level.var_8dee3b91[context.killstreaktype])) {
        [[ level.var_8dee3b91[context.killstreaktype] ]](owner, context, position);
    }
}

// Namespace ir_strobe/namespace_e9f92442
// Params 2, eflags: 0x0
// Checksum 0xd8a1934e, Offset: 0x290
// Size: 0x21c
function function_7707d9be(killstreak_id, context) {
    player = self;
    self endon(#"disconnect");
    self endon(#"spawned_player");
    var_12232d8f = level.weaponnone;
    currentweapon = self getcurrentweapon();
    prevweapon = currentweapon;
    if (currentweapon.issupplydropweapon) {
        var_12232d8f = currentweapon;
    }
    if (var_12232d8f.isgrenadeweapon) {
        trigger_event = "grenade_fire";
    } else {
        trigger_event = "weapon_fired";
    }
    self thread function_76eccb19(killstreak_id, trigger_event, var_12232d8f, context);
    while (true) {
        player allowmelee(0);
        notifystring = self waittill(#"weapon_change", trigger_event, #"disconnect", #"spawned_player");
        player allowmelee(1);
        if (trigger_event != "none") {
            if (notifystring._notify != trigger_event) {
                cleanup(context, player);
                return false;
            }
        }
        if (isdefined(player.markerposition)) {
            break;
        }
    }
    self notify(#"trigger_weapon_shutdown");
    if (var_12232d8f == level.weaponnone) {
        cleanup(context, player);
        return false;
    }
    return true;
}

// Namespace ir_strobe/namespace_e9f92442
// Params 2, eflags: 0x0
// Checksum 0x5e1416b2, Offset: 0x4b8
// Size: 0x102
function cleanup(context, player) {
    if (isdefined(context) && isdefined(context.marker)) {
        context.marker delete();
        context.marker = undefined;
        if (isdefined(context.markerfxhandle)) {
            context.markerfxhandle delete();
            context.markerfxhandle = undefined;
        }
        if (isdefined(player)) {
            player clientfield::set_to_player("marker_state", 0);
        }
    }
    if (isdefined(context) && isdefined(context.var_b222d13d) && isdefined(context.var_5e08dfac)) {
        [[ context.var_b222d13d ]](context);
        context.var_b222d13d = undefined;
    }
}

// Namespace ir_strobe/namespace_e9f92442
// Params 1, eflags: 0x0
// Checksum 0xdaf44ad0, Offset: 0x5c8
// Size: 0xc4
function markercleanupthread(context) {
    player = self;
    player waittill(#"death", #"disconnect", #"joined_team", #"joined_spectators", #"cleanup_marker", #"changed_specialist");
    if (player flagsys::get(#"marking_done")) {
        return;
    }
    cleanup(context, player);
}

// Namespace ir_strobe/namespace_e9f92442
// Params 1, eflags: 0x0
// Checksum 0xfba55cd, Offset: 0x698
// Size: 0x4ee
function markerupdatethread(context) {
    player = self;
    player endon(#"hash_27be2db04a0908d5", #"spawned_player", #"disconnect", #"weapon_change", #"death");
    markermodel = spawn("script_model", (0, 0, 0));
    context.marker = markermodel;
    player thread markercleanupthread(context);
    while (true) {
        if (player flagsys::get(#"marking_done")) {
            break;
        }
        ksbundle = killstreak_bundles::get_bundle(context);
        minrange = 20;
        maxrange = 500;
        if (isdefined(ksbundle) && isdefined(ksbundle.var_c7d2fd84)) {
            minrange = ksbundle.var_c7d2fd84;
            maxrange = ksbundle.var_846815ca;
        }
        forwardvector = vectorscale(anglestoforward(player getplayerangles()), maxrange);
        mask = 1;
        if (isdefined(context.tracemask)) {
            mask = context.tracemask;
        }
        weapon = getweapon("ir_strobe");
        eye = player getweaponmuzzlepoint();
        angles = player getplayerangles();
        results = function_3348176f(weapon, eye, angles, player);
        markermodel.origin = results[#"position"] + (0, 0, 6);
        node = helicopter::getvalidrandomstartnode(markermodel.origin);
        var_799562a = undefined;
        if (isdefined(node)) {
            var_799562a = node.origin;
        }
        if (getdvarint(#"hash_7ccc40e85206e0a5", 1)) {
            player.markerposition = markermodel.origin;
            player clientfield::set_to_player("marker_state", 1);
            player function_d83e9f0e(1, markermodel.origin, markermodel.angles);
        } else {
            tooclose = distancesquared(markermodel.origin, player.origin) < minrange * minrange;
            waterheight = getwaterheight(markermodel.origin);
            inwater = markermodel.origin[2] < waterheight;
            if (isdefined(var_799562a) && !tooclose && !inwater && isdefined(context.islocationgood) && [[ context.islocationgood ]](markermodel.origin, context)) {
                player.markerposition = markermodel.origin;
                player clientfield::set_to_player("marker_state", 1);
                player function_d83e9f0e(1, markermodel.origin, markermodel.angles);
            } else {
                player.markerposition = undefined;
                player clientfield::set_to_player("marker_state", 2);
                player function_d83e9f0e(0, (0, 0, 0), (0, 0, 0));
            }
        }
        waitframe(1);
    }
}

// Namespace ir_strobe/namespace_e9f92442
// Params 4, eflags: 0x0
// Checksum 0x119439de, Offset: 0xb90
// Size: 0x49c
function function_76eccb19(killstreak_id, trigger_event, supplydropweapon, context) {
    player = self;
    self notify(#"hash_27be2db04a0908d5");
    self endon(#"hash_27be2db04a0908d5", #"spawned_player", #"disconnect", #"weapon_change");
    team = self.team;
    if (isdefined(killstreak_id) && killstreak_id == -1) {
        return;
    }
    context.killstreak_id = killstreak_id;
    player flagsys::clear(#"marking_done");
    self thread checkforemp();
    if (trigger_event != "none") {
        self thread markerupdatethread(context);
    }
    self thread cleanupwatcherondeath(killstreak_id, supplydropweapon);
    while (true) {
        waitframe(1);
        if (trigger_event == "none") {
            weapon = supplydropweapon;
            weapon_instance = weapon;
        } else {
            waitresult = self waittill(trigger_event, #"deployable_plant_failed");
            if (waitresult._notify == "deployable_plant_failed") {
                self killstreaks::switch_to_last_non_killstreak_weapon();
                break;
            }
            weapon = waitresult.weapon;
            weapon_instance = waitresult.projectile;
        }
        issupplydropweapon = 1;
        if (trigger_event == "grenade_fire") {
            issupplydropweapon = weapon.issupplydropweapon;
        }
        if (isdefined(self) && issupplydropweapon) {
            if (isdefined(context)) {
                if (!getdvarint(#"hash_7ccc40e85206e0a5", 1)) {
                    if (!isdefined(player.markerposition) || !(isdefined(context.islocationgood) && [[ context.islocationgood ]](player.markerposition, context))) {
                        if (isdefined(level.killstreakcorebundle.ksinvalidlocationsound)) {
                            player playsoundtoplayer(level.killstreakcorebundle.ksinvalidlocationsound, player);
                        }
                        if (isdefined(level.killstreakcorebundle.ksinvalidlocationstring)) {
                            player iprintlnbold(level.killstreakcorebundle.ksinvalidlocationstring);
                        }
                        continue;
                    }
                }
                if (isdefined(context.validlocationsound)) {
                    player playsoundtoplayer(context.validlocationsound, player);
                }
                ksbundle = killstreak_bundles::get_bundle(context);
                if (isdefined(ksbundle)) {
                    context.time = ksbundle.kstime;
                    context.fx_name = ksbundle.var_4e9eb452;
                }
                var_599a0d2 = player.markerposition;
                player flagsys::set(#"marking_done");
                player clientfield::set_to_player("marker_state", 0);
                if (!isdefined(var_599a0d2)) {
                    continue;
                }
                self thread function_4cccbb7f(self, context, var_599a0d2);
            }
            self killstreaks::switch_to_last_non_killstreak_weapon();
        }
        break;
    }
    player flagsys::set(#"marking_done");
    player clientfield::set_to_player("marker_state", 0);
}

// Namespace ir_strobe/namespace_e9f92442
// Params 2, eflags: 0x0
// Checksum 0x9add2d6c, Offset: 0x1038
// Size: 0xce
function cleanupwatcherondeath(killstreak_id, var_8c22f2e) {
    player = self;
    self endon(#"disconnect", #"supplydropwatcher", #"trigger_weapon_shutdown", #"spawned_player", #"weapon_change");
    self waittill(#"death", #"joined_team", #"joined_spectators", #"changed_specialist");
    self notify(#"cleanup_marker");
}

// Namespace ir_strobe/namespace_e9f92442
// Params 0, eflags: 0x0
// Checksum 0x191b5c9d, Offset: 0x1110
// Size: 0x8c
function checkforemp() {
    self endon(#"supplydropwatcher");
    self endon(#"spawned_player");
    self endon(#"disconnect");
    self endon(#"weapon_change");
    self endon(#"death");
    self endon(#"trigger_weapon_shutdown");
    self waittill(#"emp_jammed");
    self killstreaks::switch_to_last_non_killstreak_weapon();
}

// Namespace ir_strobe/grenade_fire
// Params 1, eflags: 0x40
// Checksum 0xbccc6bbb, Offset: 0x11a8
// Size: 0xfc
function event_handler[grenade_fire] function_3c4488a3(eventstruct) {
    if (!isdefined(level.var_8dee3b91)) {
        return;
    }
    if (!isplayer(self)) {
        return;
    }
    grenade = eventstruct.projectile;
    if (grenade util::ishacked()) {
        return;
    }
    weapon = eventstruct.weapon;
    if (!isdefined(level.var_8dee3b91[weapon.rootweapon.name])) {
        return;
    }
    if (isdefined(self.markerposition)) {
        grenade thread function_21dbb9a2(self);
        return;
    }
    grenade notify(#"death");
    waittillframeend();
    grenade delete();
}

// Namespace ir_strobe/namespace_e9f92442
// Params 1, eflags: 0x0
// Checksum 0x651e515f, Offset: 0x12b0
// Size: 0x10c
function function_21dbb9a2(player) {
    self endon(#"death");
    self.team = player.team;
    self waittill(#"rolling");
    if (!isdefined(player)) {
        return;
    }
    player notify(#"strobe_marked");
    if (!isdefined(self)) {
        return;
    }
    self function_6ed57be7();
    player waittilltimeout(90, #"strobe_marked", #"payload_delivered", #"payload_fail", #"disconnect");
    if (!isdefined(self)) {
        return;
    }
    self.sndent delete();
    self delete();
}

// Namespace ir_strobe/namespace_e9f92442
// Params 2, eflags: 0x4
// Checksum 0x1efc2462, Offset: 0x13c8
// Size: 0xe4
function private function_6ed57be7(var_c94f167b = #"weapon/fx8_equip_swat_smk_signal", var_d1e308de = "tag_flash") {
    playfxontag(var_c94f167b, self, var_d1e308de);
    self playsound(#"hash_6c91edfde8408dad");
    self.sndent = spawn("script_origin", self.origin);
    self.sndent linkto(self);
    self.sndent playloopsound(#"hash_63e34e1932c25073");
}

// Namespace ir_strobe/namespace_e9f92442
// Params 5, eflags: 0x0
// Checksum 0xe56087f, Offset: 0x14b8
// Size: 0xd0
function function_aebde85a(origin, model, timeout = undefined, var_c94f167b = undefined, var_d1e308de = undefined) {
    strobe = spawn("script_model", origin);
    strobe setmodel(model);
    strobe function_6ed57be7(var_c94f167b, var_d1e308de);
    strobe thread function_6a9731e8(timeout);
    return strobe;
}

// Namespace ir_strobe/namespace_e9f92442
// Params 1, eflags: 0x4
// Checksum 0x83737a42, Offset: 0x1590
// Size: 0xa4
function private function_6a9731e8(timeout) {
    if (isdefined(timeout)) {
        self waittilltimeout(timeout, #"death", #"strobe_stop");
    } else {
        self waittill(#"death", #"strobe_stop");
    }
    if (!isdefined(self)) {
        return;
    }
    self.sndent delete();
    self delete();
}

