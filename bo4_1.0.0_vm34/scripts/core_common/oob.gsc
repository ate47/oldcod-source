#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\hostmigration_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;

#namespace oob;

// Namespace oob/oob
// Params 0, eflags: 0x2
// Checksum 0x8c1631d6, Offset: 0x168
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"out_of_bounds", &__init__, undefined, undefined);
}

// Namespace oob/oob
// Params 0, eflags: 0x0
// Checksum 0x34e92fdc, Offset: 0x1b0
// Size: 0x534
function __init__() {
    level.oob_triggers = [];
    if (sessionmodeismultiplayergame()) {
        level.oob_timekeep_ms = getdvarint(#"oob_timekeep_ms", 3000);
        level.oob_timelimit_ms = getdvarint(#"oob_timelimit_ms", 3000);
        level.oob_damage_interval_ms = getdvarint(#"oob_damage_interval_ms", 3000);
        level.oob_damage_per_interval = getdvarint(#"oob_damage_per_interval", 999);
        level.oob_max_distance_before_black = getdvarint(#"oob_max_distance_before_black", 100000);
        level.oob_time_remaining_before_black = getdvarint(#"oob_time_remaining_before_black", -1);
    } else if (sessionmodeiswarzonegame()) {
        level.oob_timekeep_ms = getdvarint(#"oob_timekeep_ms", 3000);
        level.oob_timelimit_ms = getdvarint(#"oob_timelimit_ms", 10000);
        level.oob_damage_interval_ms = getdvarint(#"oob_damage_interval_ms", 3000);
        level.oob_damage_per_interval = getdvarint(#"oob_damage_per_interval", 999);
        level.oob_max_distance_before_black = getdvarint(#"oob_max_distance_before_black", 100000);
        level.oob_time_remaining_before_black = getdvarint(#"oob_time_remaining_before_black", -1);
    } else {
        level.oob_timelimit_ms = getdvarint(#"oob_timelimit_ms", 6000);
        level.oob_damage_interval_ms = getdvarint(#"oob_damage_interval_ms", 1000);
        level.oob_damage_per_interval = getdvarint(#"oob_damage_per_interval", 5);
        level.oob_max_distance_before_black = getdvarint(#"oob_max_distance_before_black", 400);
        level.oob_time_remaining_before_black = getdvarint(#"oob_time_remaining_before_black", 1000);
    }
    level.oob_damage_interval_sec = float(level.oob_damage_interval_ms) / 1000;
    var_cd9ab294 = getentarray("trigger_out_of_bounds", "classname");
    /#
        if (var_cd9ab294.size) {
            level thread function_3dce35d6();
        }
    #/
    var_e58c7771 = getentarray("trigger_out_of_bounds_new", "classname");
    var_acf4fa32 = arraycombine(var_cd9ab294, var_e58c7771, 1, 0);
    foreach (trigger in var_acf4fa32) {
        trigger thread run_oob_trigger();
    }
    val::register("disable_oob", 1, "$self", &disableplayeroob, "$value");
    val::default_value("disable_oob", 0);
    clientfield::register("toplayer", "out_of_bounds", 1, 5, "int");
}

/#

    // Namespace oob/oob
    // Params 0, eflags: 0x0
    // Checksum 0xca28fc36, Offset: 0x6f0
    // Size: 0x3c
    function function_3dce35d6() {
        level flagsys::wait_till("<dev string:x30>");
        iprintlnbold("<dev string:x44>");
    }

#/

// Namespace oob/oob
// Params 0, eflags: 0x0
// Checksum 0x54ce6af1, Offset: 0x738
// Size: 0xbc
function run_oob_trigger() {
    self.oob_players = [];
    if (!isdefined(level.oob_triggers)) {
        level.oob_triggers = [];
    } else if (!isarray(level.oob_triggers)) {
        level.oob_triggers = array(level.oob_triggers);
    }
    level.oob_triggers[level.oob_triggers.size] = self;
    self thread waitforplayertouch();
    self thread waitforclonetouch();
}

// Namespace oob/oob
// Params 0, eflags: 0x0
// Checksum 0x183817b0, Offset: 0x800
// Size: 0x20
function isoutofbounds() {
    if (!isdefined(self.oob_start_time)) {
        return false;
    }
    return self.oob_start_time != -1;
}

// Namespace oob/oob
// Params 0, eflags: 0x0
// Checksum 0xe3a811b0, Offset: 0x828
// Size: 0x1a2
function istouchinganyoobtrigger() {
    result = 0;
    if (isplayer(self) && function_81433fa5()) {
        return 0;
    }
    level.oob_triggers = array::remove_undefined(level.oob_triggers);
    foreach (trigger in level.oob_triggers) {
        if (!trigger istriggerenabled()) {
            continue;
        }
        n_flags = function_dcb65892(trigger);
        if (trigger.classname == "trigger_out_of_bounds_new" && self.team == #"axis" && !(n_flags & 1) || self.team == #"allies" && !(n_flags & 2)) {
            continue;
        }
        if (self istouching(trigger)) {
            result = 1;
            break;
        }
    }
    return result;
}

// Namespace oob/oob
// Params 1, eflags: 0x0
// Checksum 0x252b82c5, Offset: 0x9d8
// Size: 0xd2
function function_f84f2990(point) {
    level.oob_triggers = array::remove_undefined(level.oob_triggers);
    foreach (trigger in level.oob_triggers) {
        if (!trigger istriggerenabled()) {
            continue;
        }
        if (istouching(point, trigger)) {
            return true;
        }
    }
    return false;
}

// Namespace oob/oob
// Params 2, eflags: 0x0
// Checksum 0xea16275, Offset: 0xab8
// Size: 0xe6
function resetoobtimer(is_host_migrating, b_disable_timekeep) {
    self.oob_lastvalidplayerloc = undefined;
    self.oob_lastvalidplayerdir = undefined;
    self clientfield::set_to_player("out_of_bounds", 0);
    self val::reset(#"oob", "show_hud");
    self.oob_start_time = -1;
    if (isdefined(level.oob_timekeep_ms)) {
        if (isdefined(b_disable_timekeep) && b_disable_timekeep) {
            self.last_oob_timekeep_ms = undefined;
        } else {
            self.last_oob_timekeep_ms = gettime();
        }
    }
    if (!(isdefined(is_host_migrating) && is_host_migrating)) {
        self notify(#"oob_host_migration_exit");
    }
    self notify(#"oob_exit");
}

// Namespace oob/oob
// Params 0, eflags: 0x0
// Checksum 0x52487803, Offset: 0xba8
// Size: 0xc4
function waitforclonetouch() {
    self endon(#"death");
    while (true) {
        waitresult = self waittill(#"trigger");
        clone = waitresult.activator;
        if (isactor(clone) && isdefined(clone.isaiclone) && clone.isaiclone && !clone isplayinganimscripted()) {
            clone notify(#"clone_shutdown");
        }
    }
}

// Namespace oob/oob
// Params 1, eflags: 0x0
// Checksum 0x7b6378b6, Offset: 0xc78
// Size: 0x48
function getadjusedplayer(player) {
    if (isdefined(player.hijacked_vehicle_entity) && isalive(player.hijacked_vehicle_entity)) {
        return player.hijacked_vehicle_entity;
    }
    return player;
}

// Namespace oob/oob
// Params 0, eflags: 0x0
// Checksum 0x8ac855bb, Offset: 0xcc8
// Size: 0x308
function waitforplayertouch() {
    self endon(#"death");
    while (true) {
        if (sessionmodeismultiplayergame() || sessionmodeiswarzonegame()) {
            hostmigration::waittillhostmigrationdone();
        }
        waitresult = self waittill(#"trigger");
        entity = waitresult.activator;
        if (isplayer(entity)) {
            player = entity;
        } else if (isvehicle(entity) && isalive(entity)) {
            player = entity getseatoccupant(0);
            if (!isdefined(player) || !isplayer(player)) {
                continue;
            }
        } else {
            continue;
        }
        if (player function_81433fa5()) {
            continue;
        }
        if (player isoutofbounds()) {
            continue;
        }
        player notify(#"oob_enter");
        if (isdefined(level.oob_timekeep_ms) && isdefined(player.last_oob_timekeep_ms) && isdefined(player.last_oob_duration_ms) && gettime() - player.last_oob_timekeep_ms < level.oob_timekeep_ms) {
            player.oob_start_time = gettime() - level.oob_timelimit_ms - player.last_oob_duration_ms;
        } else {
            player.oob_start_time = gettime();
        }
        player.oob_lastvalidplayerloc = entity.origin;
        player.oob_lastvalidplayerdir = vectornormalize(entity getvelocity());
        player val::set(#"oob", "show_hud", 0);
        player thread watchforleave(self, entity);
        player thread watchfordeath(self, entity);
        if (sessionmodeismultiplayergame() || sessionmodeiswarzonegame()) {
            player thread watchforhostmigration(self, entity);
        }
    }
}

// Namespace oob/oob
// Params 0, eflags: 0x0
// Checksum 0x689df039, Offset: 0xfd8
// Size: 0x8a
function function_81433fa5() {
    if (self scene::is_igc_active()) {
        return true;
    }
    if (isdefined(self.oobdisabled) && self.oobdisabled) {
        return true;
    }
    if (level flag::exists("draft_complete") && !level flag::get("draft_complete")) {
        return true;
    }
    return false;
}

// Namespace oob/oob
// Params 2, eflags: 0x0
// Checksum 0xbe7e397a, Offset: 0x1070
// Size: 0xe0
function getdistancefromlastvalidplayerloc(trigger, entity) {
    if (isdefined(self.oob_lastvalidplayerdir) && self.oob_lastvalidplayerdir != (0, 0, 0)) {
        vectoplayerlocfromorigin = entity.origin - self.oob_lastvalidplayerloc;
        distance = vectordot(vectoplayerlocfromorigin, self.oob_lastvalidplayerdir);
    } else {
        distance = distance(entity.origin, self.oob_lastvalidplayerloc);
    }
    if (distance < 0) {
        distance = 0;
    }
    if (distance > level.oob_max_distance_before_black) {
        distance = level.oob_max_distance_before_black;
    }
    return distance / level.oob_max_distance_before_black;
}

// Namespace oob/oob
// Params 2, eflags: 0x0
// Checksum 0x1a29cd3a, Offset: 0x1158
// Size: 0x1ac
function updatevisualeffects(trigger, entity) {
    timeremaining = level.oob_timelimit_ms - gettime() - self.oob_start_time;
    if (isdefined(level.oob_timekeep_ms)) {
        self.last_oob_duration_ms = timeremaining;
    }
    oob_effectvalue = 0;
    if (timeremaining <= level.oob_time_remaining_before_black) {
        if (!isdefined(self.oob_lasteffectvalue)) {
            self.oob_lasteffectvalue = getdistancefromlastvalidplayerloc(trigger, entity);
        }
        time_val = 1 - timeremaining / level.oob_time_remaining_before_black;
        if (time_val > 1) {
            time_val = 1;
        }
        oob_effectvalue = self.oob_lasteffectvalue + (1 - self.oob_lasteffectvalue) * time_val;
    } else {
        oob_effectvalue = getdistancefromlastvalidplayerloc(trigger, entity);
        if (oob_effectvalue > 0.9) {
            oob_effectvalue = 0.9;
        } else if (oob_effectvalue < 0.05) {
            oob_effectvalue = 0.05;
        }
        self.oob_lasteffectvalue = oob_effectvalue;
    }
    oob_effectvalue = ceil(oob_effectvalue * 31);
    self clientfield::set_to_player("out_of_bounds", int(oob_effectvalue));
}

// Namespace oob/oob
// Params 1, eflags: 0x0
// Checksum 0x7601e48e, Offset: 0x1310
// Size: 0x18c
function killentity(entity) {
    self resetoobtimer();
    if (isdefined(level.var_36ef23d2)) {
        [[ level.var_36ef23d2 ]](entity);
        return;
    }
    entity val::set(#"oob", "takedamage", 1);
    if (isplayer(entity) && entity isinvehicle()) {
        vehicle = entity getvehicleoccupied();
        vehicle val::set(#"oob", "takedamage", 1);
        vehicle kill();
    }
    entity dodamage(entity.health + 10000, entity.origin, undefined, undefined, "none", "MOD_TRIGGER_HURT", 8192);
    if (isplayer(entity)) {
        entity suicide();
    }
}

// Namespace oob/oob
// Params 2, eflags: 0x0
// Checksum 0x61e84a17, Offset: 0x14a8
// Size: 0x140
function watchforleave(trigger, entity) {
    self endon(#"oob_exit");
    entity endon(#"death");
    while (true) {
        if (entity istouchinganyoobtrigger()) {
            updatevisualeffects(trigger, entity);
            if (level.oob_timelimit_ms - gettime() - self.oob_start_time <= 0) {
                if (isplayer(entity)) {
                    entity val::set(#"oob_touch", "ignoreme", 0);
                    entity.laststand = undefined;
                    if (isdefined(entity.revivetrigger)) {
                        entity.revivetrigger delete();
                    }
                }
                self thread killentity(entity);
            }
        } else {
            self resetoobtimer();
        }
        wait 0.1;
    }
}

// Namespace oob/oob
// Params 2, eflags: 0x0
// Checksum 0x8f2c5e7, Offset: 0x15f0
// Size: 0x7c
function watchfordeath(trigger, entity) {
    self endon(#"disconnect");
    self endon(#"oob_exit");
    util::waittill_any_ents_two(self, "death", entity, "death");
    self resetoobtimer();
}

// Namespace oob/oob
// Params 2, eflags: 0x0
// Checksum 0x705763f7, Offset: 0x1678
// Size: 0x5c
function watchforhostmigration(trigger, entity) {
    self endon(#"oob_host_migration_exit");
    level waittill(#"host_migration_begin");
    self resetoobtimer(1, 1);
}

// Namespace oob/oob
// Params 1, eflags: 0x4
// Checksum 0x518c58b9, Offset: 0x16e0
// Size: 0x4a
function private disableplayeroob(disabled) {
    if (disabled) {
        self resetoobtimer();
        self.oobdisabled = 1;
        return;
    }
    self.oobdisabled = 0;
}

