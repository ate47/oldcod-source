#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\hostmigration_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\throttle_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;

#namespace oob;

// Namespace oob/oob
// Params 0, eflags: 0x6
// Checksum 0xdcfd0893, Offset: 0x1c0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"out_of_bounds", &preinit, undefined, undefined, undefined);
}

// Namespace oob/oob
// Params 0, eflags: 0x4
// Checksum 0xd5d8278, Offset: 0x208
// Size: 0x5ec
function private preinit() {
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
    level.var_8db0a45a = new throttle();
    [[ level.var_8db0a45a ]]->initialize(5, float(function_60d95f53()) / 1000);
    oobtriggers = getentarray("trigger_out_of_bounds", "classname");
    foreach (trigger in oobtriggers) {
        trigger thread run_oob_trigger();
        if (is_true(trigger.script_disconnectpaths)) {
            trigger disconnectpaths();
        }
    }
    var_2734aa30 = getentarray("trigger_within_airspace", "classname");
    if (var_2734aa30.size > 0) {
        function_218b23a0(var_2734aa30);
    }
    val::register("disable_oob", 1, "$self", &disableplayeroob, "$value");
    val::default_value("disable_oob", 0);
    clientfield::register("toplayer", "out_of_bounds", 1, 5, "int");
    clientfield::register("toplayer", "nonplayer_oob_usage", 1, 1, "int");
    /#
        init_debug();
    #/
}

/#

    // Namespace oob/oob
    // Params 0, eflags: 0x4
    // Checksum 0x4a6f32bb, Offset: 0x800
    // Size: 0x24
    function private init_debug() {
        adddebugcommand("<dev string:x38>");
    }

#/

// Namespace oob/oob
// Params 0, eflags: 0x0
// Checksum 0x118723c2, Offset: 0x830
// Size: 0xa4
function run_oob_trigger() {
    self.oob_players = [];
    if (!isdefined(level.oob_triggers)) {
        level.oob_triggers = [];
    } else if (!isarray(level.oob_triggers)) {
        level.oob_triggers = array(level.oob_triggers);
    }
    level.oob_triggers[level.oob_triggers.size] = self;
    self callback::on_trigger(&function_637edff);
}

// Namespace oob/oob
// Params 1, eflags: 0x0
// Checksum 0xc9d1634f, Offset: 0x8e0
// Size: 0x24
function function_5e18416d(var_f90fc07b) {
    level thread function_802adb65(var_f90fc07b);
}

// Namespace oob/oob
// Params 1, eflags: 0x0
// Checksum 0x94c64733, Offset: 0x910
// Size: 0x19a
function function_802adb65(var_f90fc07b) {
    if (!isarray(var_f90fc07b)) {
        assert(0);
        return;
    }
    arrayremovevalue(var_f90fc07b, undefined);
    level.var_f90fc07b = var_f90fc07b;
    while (true) {
        players = getplayers();
        foreach (player in players) {
            if (!isdefined(player)) {
                continue;
            }
            [[ level.var_8db0a45a ]]->waitinqueue(player);
            if (!isdefined(player)) {
                continue;
            }
            /#
                if (player isinmovemode("<dev string:x97>", "<dev string:x9e>")) {
                    continue;
                }
            #/
            if (player isoutofbounds()) {
                continue;
            }
            if (!player function_323d32db()) {
                player enter_oob(player);
            }
        }
        waitframe(1);
    }
}

// Namespace oob/oob
// Params 2, eflags: 0x0
// Checksum 0x42bd46e1, Offset: 0xab8
// Size: 0x34
function function_376ddafd(origin, radius) {
    level thread function_c1e8a50a(origin, radius);
}

// Namespace oob/oob
// Params 2, eflags: 0x4
// Checksum 0xa367e765, Offset: 0xaf8
// Size: 0x192
function private function_c1e8a50a(origin, radius) {
    radiussq = radius * radius;
    level.var_48f13f65 = {#origin:origin, #radiussq:radiussq};
    while (true) {
        players = getplayers();
        foreach (player in players) {
            if (!isdefined(player)) {
                continue;
            }
            [[ level.var_8db0a45a ]]->waitinqueue(player);
            if (!isdefined(player)) {
                continue;
            }
            /#
                if (player isinmovemode("<dev string:x97>", "<dev string:x9e>")) {
                    continue;
                }
            #/
            if (player isoutofbounds()) {
                continue;
            }
            if (!player function_b347269d()) {
                player enter_oob(player);
            }
        }
        waitframe(1);
    }
}

// Namespace oob/oob
// Params 0, eflags: 0x0
// Checksum 0x290a5ebe, Offset: 0xc98
// Size: 0xe
function function_c3f3c47f() {
    level.var_f90fc07b = undefined;
}

// Namespace oob/oob
// Params 1, eflags: 0x0
// Checksum 0xb6007955, Offset: 0xcb0
// Size: 0x24
function function_218b23a0(var_f90fc07b) {
    level thread function_d298702c(var_f90fc07b);
}

// Namespace oob/oob
// Params 1, eflags: 0x0
// Checksum 0x77109d63, Offset: 0xce0
// Size: 0x28c
function function_d298702c(var_f90fc07b) {
    if (!isarray(var_f90fc07b)) {
        assert(0);
        return;
    }
    arrayremovevalue(var_f90fc07b, undefined);
    level.var_2734aa30 = var_f90fc07b;
    while (true) {
        if (isdefined(level.var_40225902)) {
            arrayremovevalue(level.var_40225902, undefined);
            foreach (vehicle in level.var_40225902) {
                assert(isvehicle(vehicle), "<dev string:xa8>");
                if (isalive(vehicle)) {
                    player = vehicle getseatoccupant(0);
                    if (!isdefined(player) || !isplayer(player)) {
                        continue;
                    }
                    if (is_true(vehicle.var_206b039a)) {
                        continue;
                    }
                } else {
                    continue;
                }
                assert(isdefined(player));
                if (player function_65b20()) {
                    continue;
                }
                if (player isoutofbounds()) {
                    continue;
                }
                /#
                    if (player isinmovemode("<dev string:x97>", "<dev string:x9e>")) {
                        continue;
                    }
                #/
                if (!vehicle function_7aac4469()) {
                    profilestart();
                    player enter_oob(vehicle);
                    profilestop();
                }
            }
        }
        waitframe(1);
    }
}

// Namespace oob/oob
// Params 0, eflags: 0x0
// Checksum 0xc6e1dce6, Offset: 0xf78
// Size: 0x20
function isoutofbounds() {
    if (!isdefined(self.oob_start_time)) {
        return false;
    }
    return self.oob_start_time != -1;
}

// Namespace oob/oob
// Params 0, eflags: 0x0
// Checksum 0xf889714c, Offset: 0xfa0
// Size: 0x152
function function_323d32db() {
    if (getdvarint(#"hash_627b0c790443f8e5", 0)) {
        return 1;
    }
    if (!isdefined(level.var_f90fc07b)) {
        return 1;
    }
    if (isplayer(self) && function_65b20()) {
        return 1;
    }
    if (self.var_e28b2990 === 1) {
        return 1;
    }
    result = 0;
    foreach (trigger in level.var_f90fc07b) {
        if (!trigger istriggerenabled()) {
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
// Params 0, eflags: 0x0
// Checksum 0x76d32a6f, Offset: 0x1100
// Size: 0xf2
function function_7aac4469() {
    if (getdvarint(#"hash_627b0c790443f8e5", 0)) {
        return true;
    }
    if (!isdefined(level.var_2734aa30)) {
        return true;
    }
    foreach (trigger in level.var_2734aa30) {
        if (!trigger istriggerenabled()) {
            continue;
        }
        if (self istouching(trigger)) {
            return true;
        }
    }
    return false;
}

// Namespace oob/oob
// Params 0, eflags: 0x0
// Checksum 0x52278eb1, Offset: 0x1200
// Size: 0x1ba
function istouchinganyoobtrigger() {
    result = 0;
    if (isplayer(self) && function_65b20()) {
        return 0;
    }
    if (self.var_e28b2990 === 1) {
        return 0;
    }
    arrayremovevalue(level.oob_triggers, undefined);
    foreach (trigger in level.oob_triggers) {
        if (!trigger istriggerenabled()) {
            continue;
        }
        n_flags = function_27f2ef17(trigger);
        if (trigger.classname == "trigger_out_of_bounds" && self.team == #"axis" && !(n_flags & 1) || self.team == #"allies" && !(n_flags & 2)) {
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
// Params 2, eflags: 0x0
// Checksum 0xc613cd17, Offset: 0x13c8
// Size: 0x102
function chr_party(point, var_b158c6d8 = (0, 0, 0)) {
    if (!isdefined(level.oob_triggers)) {
        return false;
    }
    arrayremovevalue(level.oob_triggers, undefined);
    foreach (trigger in level.oob_triggers) {
        if (!trigger istriggerenabled()) {
            continue;
        }
        if (istouching(point, trigger, var_b158c6d8)) {
            return true;
        }
    }
    return false;
}

// Namespace oob/oob
// Params 1, eflags: 0x0
// Checksum 0x70f95c02, Offset: 0x14d8
// Size: 0x32
function function_1a0f9f54(point) {
    return chr_party(point, (15, 15, 15));
}

// Namespace oob/oob
// Params 0, eflags: 0x0
// Checksum 0x87574a48, Offset: 0x1518
// Size: 0xdc
function function_b347269d() {
    if (getdvarint(#"hash_627b0c790443f8e5", 0)) {
        return true;
    }
    if (!isstruct(level.var_48f13f65)) {
        return true;
    }
    if (isplayer(self) && function_65b20()) {
        return true;
    }
    if (self.var_e28b2990 === 1) {
        return true;
    }
    return distance2dsquared(self.origin, level.var_48f13f65.origin) < level.var_48f13f65.radiussq;
}

// Namespace oob/oob
// Params 2, eflags: 0x0
// Checksum 0x1eebdde9, Offset: 0x1600
// Size: 0x10e
function resetoobtimer(is_host_migrating, b_disable_timekeep) {
    self.oob_lastvalidplayerloc = undefined;
    self.oob_lastvalidplayerdir = undefined;
    self clientfield::set_to_player("out_of_bounds", 0);
    self val::reset(#"oob", "show_hud");
    self.oob_start_time = -1;
    self function_20431d45(0);
    if (isdefined(level.oob_timekeep_ms)) {
        if (is_true(b_disable_timekeep)) {
            self.last_oob_timekeep_ms = undefined;
        } else {
            self.last_oob_timekeep_ms = gettime();
        }
    }
    if (!is_true(is_host_migrating)) {
        self notify(#"oob_host_migration_exit");
    }
    self notify(#"oob_exit");
}

// Namespace oob/oob
// Params 1, eflags: 0x0
// Checksum 0x4bdc0986, Offset: 0x1718
// Size: 0x48
function getadjusedplayer(player) {
    if (isdefined(player.hijacked_vehicle_entity) && isalive(player.hijacked_vehicle_entity)) {
        return player.hijacked_vehicle_entity;
    }
    return player;
}

// Namespace oob/oob
// Params 1, eflags: 0x0
// Checksum 0x8ee759ac, Offset: 0x1768
// Size: 0x1d6
function function_637edff(trigger_struct) {
    entity = trigger_struct.activator;
    var_890473a4 = 0;
    if (chr_party(entity.origin)) {
        var_890473a4 = 1;
    }
    if (isplayer(entity)) {
        player = entity;
    } else if (isvehicle(entity) && isalive(entity)) {
        player = entity getseatoccupant(0);
        if (!isdefined(player) || !isplayer(player)) {
            return;
        }
        if (is_true(entity.var_50e3187f)) {
            return;
        }
    } else if (isactor(entity) && isdefined(entity.isaiclone) && entity.isaiclone && !entity isplayinganimscripted()) {
        entity notify(#"clone_shutdown");
        return;
    } else {
        return;
    }
    if (player function_65b20()) {
        return;
    }
    if (player isoutofbounds()) {
        return;
    }
    profilestart();
    player enter_oob(entity);
    profilestop();
}

// Namespace oob/oob
// Params 1, eflags: 0x0
// Checksum 0x75714c9c, Offset: 0x1948
// Size: 0x1c4
function enter_oob(entity) {
    player = self;
    player notify(#"oob_enter");
    if (isdefined(level.oob_timekeep_ms) && isdefined(player.last_oob_timekeep_ms) && isdefined(player.last_oob_duration_ms) && gettime() - player.last_oob_timekeep_ms < level.oob_timekeep_ms) {
        var_e09617 = player function_54e69ee4();
        player.oob_start_time = gettime() - var_e09617 - player.last_oob_duration_ms;
    } else {
        player.oob_start_time = gettime();
    }
    player.oob_lastvalidplayerloc = entity.origin;
    player.oob_lastvalidplayerdir = vectornormalize(entity getvelocity());
    player clientfield::set_to_player("nonplayer_oob_usage", 0);
    player val::set(#"oob", "show_hud", 0);
    player thread watchforleave(entity);
    player thread watchfordeath(entity);
    if (sessionmodeismultiplayergame() || sessionmodeiswarzonegame()) {
        player thread watchforhostmigration(entity);
    }
}

// Namespace oob/oob
// Params 0, eflags: 0x0
// Checksum 0x5d589ed8, Offset: 0x1b18
// Size: 0xc2
function function_65b20() {
    if (self scene::is_igc_active()) {
        return true;
    }
    if (is_true(self.oobdisabled)) {
        return true;
    }
    if (level flag::exists("draft_complete") && !level flag::get("draft_complete")) {
        return true;
    }
    /#
        if (getdvarint(#"hash_2b58bf75b6021e78", 0) != 0) {
            return true;
        }
    #/
    return false;
}

// Namespace oob/oob
// Params 1, eflags: 0x0
// Checksum 0xb30c8aef, Offset: 0x1be8
// Size: 0xd0
function getdistancefromlastvalidplayerloc(entity) {
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
// Params 0, eflags: 0x4
// Checksum 0xbb4c10bc, Offset: 0x1cc0
// Size: 0x5e
function private function_f896a102() {
    timeremaining = 0;
    var_e09617 = self function_54e69ee4();
    if (isdefined(var_e09617) && isdefined(self.oob_start_time)) {
        timeremaining = var_e09617 - gettime() - self.oob_start_time;
    }
    return timeremaining;
}

// Namespace oob/oob
// Params 1, eflags: 0x0
// Checksum 0x3fc2766e, Offset: 0x1d28
// Size: 0x264
function updatevisualeffects(entity) {
    timeremaining = function_f896a102();
    if (entity.var_c5d65381 === 1 && isplayer(self) && !self isremotecontrolling() && isvehicle(entity)) {
        self clientfield::set_to_player("out_of_bounds", 0);
        self val::reset(#"oob", "show_hud");
        self function_20431d45(0);
        return;
    }
    if (isdefined(level.oob_timekeep_ms)) {
        self.last_oob_duration_ms = timeremaining;
    }
    oob_effectvalue = 0;
    if (timeremaining <= level.oob_time_remaining_before_black) {
        if (!isdefined(self.oob_lasteffectvalue)) {
            self.oob_lasteffectvalue = getdistancefromlastvalidplayerloc(entity);
        }
        time_val = 1 - timeremaining / level.oob_time_remaining_before_black;
        if (time_val > 1) {
            time_val = 1;
        }
        oob_effectvalue = self.oob_lasteffectvalue + (1 - self.oob_lasteffectvalue) * time_val;
    } else {
        oob_effectvalue = getdistancefromlastvalidplayerloc(entity);
        if (oob_effectvalue > 0.9) {
            oob_effectvalue = 0.9;
        } else if (oob_effectvalue < 0.05) {
            oob_effectvalue = 0.05;
        }
        self.oob_lasteffectvalue = oob_effectvalue;
    }
    oob_effectvalue = ceil(oob_effectvalue * 31);
    self clientfield::set_to_player("out_of_bounds", int(oob_effectvalue));
    self function_20431d45(1);
}

// Namespace oob/oob
// Params 1, eflags: 0x0
// Checksum 0xf68544ae, Offset: 0x1f98
// Size: 0x274
function killentity(entity) {
    self resetoobtimer();
    if (isdefined(level.var_bde3d03)) {
        [[ level.var_bde3d03 ]](entity);
        return;
    }
    entity val::set(#"oob", "takedamage", 1);
    if (isplayer(entity) && entity isinvehicle()) {
        vehicle = entity getvehicleoccupied();
        vehicle val::set(#"oob", "takedamage", 1);
        occupants = vehicle getvehoccupants();
        foreach (occupant in occupants) {
            occupant unlink();
        }
        if (!is_false(vehicle.allowdeath)) {
            vehicle dodamage(vehicle.health + 10000, vehicle.origin, undefined, undefined, "none", "MOD_EXPLOSIVE", 8192);
        }
    }
    entity dodamage(entity.health + 10000, entity.origin, undefined, undefined, "none", "MOD_TRIGGER_HURT", 8192 | 16384);
    if (isplayer(entity)) {
        entity suicide();
    }
}

// Namespace oob/oob
// Params 1, eflags: 0x0
// Checksum 0x4b13a6b3, Offset: 0x2218
// Size: 0x278
function watchforleave(entity) {
    self endon(#"oob_exit", #"disconnect");
    entity endon(#"death");
    var_e09617 = self function_54e69ee4();
    while (true) {
        if ((is_true(entity.var_e28b2990) && !entity function_7aac4469() || entity istouchinganyoobtrigger() || !entity function_323d32db() || !entity function_b347269d()) && (isplayer(entity) || isplayer(self) && self isremotecontrolling() || entity.var_c5d65381 === 1)) {
            updatevisualeffects(entity);
            cur_time = gettime();
            elapsed_time = cur_time - self.oob_start_time;
            if (elapsed_time > var_e09617) {
                if (isplayer(entity)) {
                    entity val::set(#"oob_touch", "ignoreme", 0);
                    entity.laststand = undefined;
                    if (isdefined(entity.revivetrigger)) {
                        entity.revivetrigger delete();
                    }
                }
                if (self !== entity) {
                    self.last_oob_duration_ms = var_e09617;
                    self clientfield::set_to_player("nonplayer_oob_usage", 1);
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
// Params 1, eflags: 0x0
// Checksum 0x7a4e1f7b, Offset: 0x2498
// Size: 0x74
function watchfordeath(entity) {
    self endon(#"disconnect", #"oob_exit");
    util::waittill_any_ents_two(self, "death", entity, "death");
    self resetoobtimer();
}

// Namespace oob/oob
// Params 1, eflags: 0x0
// Checksum 0x4a7215cb, Offset: 0x2518
// Size: 0x54
function watchforhostmigration(*entity) {
    self endon(#"oob_host_migration_exit");
    level waittill(#"host_migration_begin");
    self resetoobtimer(1, 1);
}

// Namespace oob/oob
// Params 1, eflags: 0x4
// Checksum 0xc4cba67c, Offset: 0x2578
// Size: 0x4a
function private disableplayeroob(disabled) {
    if (disabled) {
        self resetoobtimer();
        self.oobdisabled = 1;
        return;
    }
    self.oobdisabled = 0;
}

// Namespace oob/oob
// Params 1, eflags: 0x4
// Checksum 0xa017d16d, Offset: 0x25d0
// Size: 0x12c
function private function_20431d45(var_952a24b5) {
    player = self;
    if (!sessionmodeiscampaigngame()) {
        return;
    }
    if (!is_true(player.var_fe73e6f8) && var_952a24b5) {
        player.var_fe73e6f8 = 1;
        timeremaining = player function_f896a102();
        callback::callback(#"oob_toggle", {#countdowntime:timeremaining});
        return;
    }
    if (is_true(player.var_fe73e6f8) && !var_952a24b5) {
        player.var_fe73e6f8 = undefined;
        callback::callback(#"oob_toggle", {#countdowntime:0});
    }
}

// Namespace oob/oob
// Params 2, eflags: 0x0
// Checksum 0x9fac0181, Offset: 0x2708
// Size: 0x70
function function_93bd17f6(id, time) {
    if (!isdefined(self.var_2ae9ee7e)) {
        self.var_2ae9ee7e = [];
    } else if (!isarray(self.var_2ae9ee7e)) {
        self.var_2ae9ee7e = array(self.var_2ae9ee7e);
    }
    self.var_2ae9ee7e[id] = time;
}

// Namespace oob/oob
// Params 1, eflags: 0x0
// Checksum 0xafc8a727, Offset: 0x2780
// Size: 0x44
function function_e2d18c01(id) {
    if (isarray(self.var_2ae9ee7e)) {
        arrayremoveindex(self.var_2ae9ee7e, id, 1);
    }
}

// Namespace oob/oob
// Params 0, eflags: 0x0
// Checksum 0xac9bc077, Offset: 0x27d0
// Size: 0xf2
function function_54e69ee4() {
    if (!isarray(self.var_2ae9ee7e) || !self.var_2ae9ee7e.size) {
        return level.oob_timelimit_ms;
    }
    var_56afe472 = undefined;
    foreach (time in self.var_2ae9ee7e) {
        if (!isdefined(var_56afe472) || time < var_56afe472) {
            var_56afe472 = time;
        }
    }
    return int(var_56afe472 * 1000);
}

