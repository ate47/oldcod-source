#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/hostmigration_shared;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/values_shared;

#namespace oob;

// Namespace oob/oob
// Params 0, eflags: 0x2
// Checksum 0x5a427479, Offset: 0x298
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("out_of_bounds", &__init__, undefined, undefined);
}

// Namespace oob/oob
// Params 0, eflags: 0x0
// Checksum 0xc42aa028, Offset: 0x2d8
// Size: 0x2ec
function __init__() {
    level.oob_triggers = [];
    if (sessionmodeismultiplayergame()) {
        level.oob_timekeep_ms = getdvarint("oob_timekeep_ms", 3000);
        level.oob_timelimit_ms = getdvarint("oob_timelimit_ms", 3000);
        level.oob_damage_interval_ms = getdvarint("oob_damage_interval_ms", 3000);
        level.oob_damage_per_interval = getdvarint("oob_damage_per_interval", 999);
        level.oob_max_distance_before_black = getdvarint("oob_max_distance_before_black", 100000);
        level.oob_time_remaining_before_black = getdvarint("oob_time_remaining_before_black", -1);
    } else {
        level.oob_timelimit_ms = getdvarint("oob_timelimit_ms", 6000);
        level.oob_damage_interval_ms = getdvarint("oob_damage_interval_ms", 1000);
        level.oob_damage_per_interval = getdvarint("oob_damage_per_interval", 5);
        level.oob_max_distance_before_black = getdvarint("oob_max_distance_before_black", 400);
        level.oob_time_remaining_before_black = getdvarint("oob_time_remaining_before_black", 1000);
    }
    level.oob_damage_interval_sec = level.oob_damage_interval_ms / 1000;
    var_7d1bc4f6 = getentarray("trigger_out_of_bounds", "classname");
    foreach (trigger in var_7d1bc4f6) {
        trigger thread run_oob_trigger();
    }
    clientfield::register("toplayer", "out_of_bounds", 1, 5, "int");
}

// Namespace oob/oob
// Params 0, eflags: 0x0
// Checksum 0xf24fa637, Offset: 0x5d0
// Size: 0xcc
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
// Checksum 0x845b115e, Offset: 0x6a8
// Size: 0x28
function isoutofbounds() {
    if (!isdefined(self.oob_start_time)) {
        return false;
    }
    return self.oob_start_time != -1;
}

// Namespace oob/oob
// Params 0, eflags: 0x0
// Checksum 0x4b50142f, Offset: 0x6d8
// Size: 0x1e6
function istouchinganyoobtrigger() {
    var_41383ff5 = [];
    result = 0;
    foreach (trigger in level.oob_triggers) {
        if (!isdefined(trigger)) {
            if (!isdefined(var_41383ff5)) {
                var_41383ff5 = [];
            } else if (!isarray(var_41383ff5)) {
                var_41383ff5 = array(var_41383ff5);
            }
            var_41383ff5[var_41383ff5.size] = trigger;
            continue;
        }
        if (!trigger istriggerenabled()) {
            continue;
        }
        if (self istouching(trigger)) {
            result = 1;
            break;
        }
    }
    foreach (trigger in var_41383ff5) {
        arrayremovevalue(level.oob_triggers, trigger);
    }
    var_41383ff5 = [];
    var_41383ff5 = undefined;
    return result;
}

// Namespace oob/oob
// Params 2, eflags: 0x0
// Checksum 0x1975fcc5, Offset: 0x8c8
// Size: 0xe2
function resetoobtimer(is_host_migrating, b_disable_timekeep) {
    self.oob_lastvalidplayerloc = undefined;
    self.oob_lastvalidplayerdir = undefined;
    self clientfield::set_to_player("out_of_bounds", 0);
    self val::reset("oob", "show_hud");
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
// Checksum 0x4628bc96, Offset: 0x9b8
// Size: 0xbc
function waitforclonetouch() {
    self endon(#"death");
    while (true) {
        waitresult = self waittill("trigger");
        clone = waitresult.activator;
        if (isactor(clone) && isdefined(clone.isaiclone) && clone.isaiclone && !clone isplayinganimscripted()) {
            clone notify(#"clone_shutdown");
        }
    }
}

// Namespace oob/oob
// Params 1, eflags: 0x0
// Checksum 0x818d03e5, Offset: 0xa80
// Size: 0x50
function getadjusedplayer(player) {
    if (isdefined(player.hijacked_vehicle_entity) && isalive(player.hijacked_vehicle_entity)) {
        return player.hijacked_vehicle_entity;
    }
    return player;
}

// Namespace oob/oob
// Params 0, eflags: 0x0
// Checksum 0x60618708, Offset: 0xad8
// Size: 0x310
function waitforplayertouch() {
    self endon(#"death");
    while (true) {
        if (sessionmodeismultiplayergame()) {
            hostmigration::waittillhostmigrationdone();
        }
        waitresult = self waittill("trigger");
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
        if (!player isoutofbounds() && !player isplayinganimscripted() && !(isdefined(player.oobdisabled) && player.oobdisabled)) {
            player notify(#"oob_enter");
            if (isdefined(level.oob_timekeep_ms) && isdefined(player.last_oob_timekeep_ms) && isdefined(player.last_oob_duration_ms) && gettime() - player.last_oob_timekeep_ms < level.oob_timekeep_ms) {
                player.oob_start_time = gettime() - level.oob_timelimit_ms - player.last_oob_duration_ms;
            } else {
                player.oob_start_time = gettime();
            }
            player.oob_lastvalidplayerloc = entity.origin;
            player.oob_lastvalidplayerdir = vectornormalize(entity getvelocity());
            player val::set("oob", "show_hud", 0);
            player thread watchforleave(self, entity);
            player thread watchfordeath(self, entity);
            if (sessionmodeismultiplayergame()) {
                player thread watchforhostmigration(self, entity);
            }
        }
    }
}

// Namespace oob/oob
// Params 2, eflags: 0x0
// Checksum 0x4d17002d, Offset: 0xdf0
// Size: 0x100
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
// Checksum 0xa9fc285f, Offset: 0xef8
// Size: 0x1dc
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
// Checksum 0x771adf6f, Offset: 0x10e0
// Size: 0x94
function killentity(entity) {
    self resetoobtimer();
    self val::set("oob", "takedamage", 1);
    entity dodamage(entity.health + 10000, entity.origin, undefined, undefined, "none", "MOD_TRIGGER_HURT");
}

// Namespace oob/oob
// Params 2, eflags: 0x0
// Checksum 0x6990042d, Offset: 0x1180
// Size: 0x148
function watchforleave(trigger, entity) {
    self endon(#"oob_exit");
    entity endon(#"death");
    while (true) {
        if (entity istouchinganyoobtrigger()) {
            updatevisualeffects(trigger, entity);
            if (level.oob_timelimit_ms - gettime() - self.oob_start_time <= 0) {
                if (isplayer(entity)) {
                    entity val::set("oob_touch", "ignoreme", 0);
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
// Checksum 0xad8974ad, Offset: 0x12d0
// Size: 0x6c
function watchfordeath(trigger, entity) {
    self endon(#"disconnect");
    self endon(#"oob_exit");
    util::waittill_any_ents_two(self, "death", entity, "death");
    self resetoobtimer();
}

// Namespace oob/oob
// Params 2, eflags: 0x0
// Checksum 0x5a0922cd, Offset: 0x1348
// Size: 0x4c
function watchforhostmigration(trigger, entity) {
    self endon(#"oob_host_migration_exit");
    level waittill("host_migration_begin");
    self resetoobtimer(1, 1);
}

// Namespace oob/oob
// Params 1, eflags: 0x0
// Checksum 0xd9e60f5e, Offset: 0x13a0
// Size: 0x4c
function disableplayeroob(disabled) {
    if (disabled) {
        self resetoobtimer();
        self.oobdisabled = 1;
        return;
    }
    self.oobdisabled = 0;
}

