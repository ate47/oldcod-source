#using script_16b1b77a76492c6a;
#using script_19367cd29a4485db;
#using script_1cc417743d7c262d;
#using script_3357acf79ce92f4b;
#using script_34ab99a4ca1a43d;
#using script_7fc996fe8678852;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\item_supply_drop;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_death_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\zm_common\zm_utility;

#namespace namespace_12a6a726;

// Namespace namespace_12a6a726/namespace_12a6a726
// Params 0, eflags: 0x6
// Checksum 0xf199ebd3, Offset: 0x240
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"hash_72a9f15f4124442", &function_70a657d8, undefined, undefined, #"hash_f81b9dea74f0ee");
}

// Namespace namespace_12a6a726/namespace_12a6a726
// Params 0, eflags: 0x1 linked
// Checksum 0x666aa9a, Offset: 0x290
// Size: 0xcc
function function_70a657d8() {
    if (!zm_utility::is_survival()) {
        return;
    }
    clientfield::register("scriptmover", "helicopter_crash_fx", 1, 1, "int");
    namespace_8b6a9d79::function_b3464a7c(#"supply_portal", &function_8ba92985);
    level.var_183bdb80 = &supply_drop_portal_fx;
    level.var_a16ff74d = &function_9678a483;
    /#
        level thread namespace_420b39d3::function_2fab7a62("<dev string:x38>");
    #/
}

// Namespace namespace_12a6a726/namespace_12a6a726
// Params 1, eflags: 0x1 linked
// Checksum 0xcece7265, Offset: 0x368
// Size: 0x250
function spawn_supply_drop(destination) {
    var_ba9835cd = [];
    foreach (s_location in destination.locations) {
        if (namespace_8b6a9d79::function_fe9fb6fd(s_location) && !getdvarint(#"hash_730311c63805303a", 0)) {
            continue;
        }
        if (isdefined(s_location.instances[#"supply_portal"])) {
            if (!isdefined(var_ba9835cd)) {
                var_ba9835cd = [];
            } else if (!isarray(var_ba9835cd)) {
                var_ba9835cd = array(var_ba9835cd);
            }
            var_ba9835cd[var_ba9835cd.size] = s_location.instances[#"supply_portal"];
        }
    }
    if (getdvarint(#"hash_730311c63805303a", 0)) {
        n_to_spawn = 3;
    } else {
        n_to_spawn = randomintrangeinclusive(0, 1);
    }
    var_ba9835cd = array::randomize(var_ba9835cd);
    foreach (i, s_instance in var_ba9835cd) {
        if (i >= n_to_spawn) {
            return;
        }
        if (isdefined(s_instance)) {
            namespace_8b6a9d79::function_20d7e9c7(s_instance);
        }
    }
}

// Namespace namespace_12a6a726/namespace_12a6a726
// Params 1, eflags: 0x4
// Checksum 0xd28f9008, Offset: 0x5c0
// Size: 0x594
function private function_4d2cdcd4(s_instance) {
    s_instance endon(#"cleanup");
    s_instance flag::clear("cleanup");
    s_instance callback::function_d8abfc3d(#"hash_345e9169ebba28fb", &function_aa8eac18);
    s_chest = s_instance.var_fe2612fe[#"hash_6b1e5d8f9e70a70e"][0];
    s_trigger = s_instance.var_fe2612fe[#"trigger_spawn"][0];
    var_f4b11f6a = isdefined(s_instance.var_fe2612fe[#"hash_385496bc16a00598"]) ? s_instance.var_fe2612fe[#"hash_385496bc16a00598"] : [];
    var_bd05ff6a = s_instance.var_fe2612fe[#"hash_3e83fb475294d5b0"][0];
    s_fx = s_instance.var_fe2612fe[#"hash_73bcc681598d4cfb"][0];
    var_442fa2aa = spawn("trigger_radius", s_trigger.origin, 0, s_trigger.radius, s_trigger.height);
    s_instance.var_442fa2aa = var_442fa2aa;
    while (true) {
        var_442fa2aa waittill(#"trigger");
        if (level flag::get(#"objective_locked")) {
            level flag::wait_till_clear(#"objective_locked");
            continue;
        }
        break;
    }
    var_8f9fbf19 = spawnvehicle("vehicle_t8_mil_helicopter_light_gunner_wz_black", var_bd05ff6a.origin, var_bd05ff6a.angles);
    s_instance.var_8f9fbf19 = var_8f9fbf19;
    var_8f9fbf19 thread vehicle::toggle_sounds(1);
    var_8f9fbf19 playloopsound(#"hash_19a1dca265f41131");
    var_8f9fbf19 setforcenocull();
    var_8f9fbf19 setspeed(100);
    var_8f9fbf19 setrotorspeed(1);
    var_8f9fbf19 vehicle_ai::start_scripted();
    var_8f9fbf19 vehicle_ai::get_state_callbacks("death").update_func = &function_4b5646b1;
    var_57e06aea = function_eafcba42(var_bd05ff6a.origin, s_chest.origin, undefined, 5000, 150);
    var_8f9fbf19 thread function_c2edbefb(var_57e06aea, undefined, 0, undefined, s_instance);
    level thread globallogic_audio::leader_dialog("worldEventHelicopterCrashPilot");
    var_8f9fbf19 waittill(#"hash_2f49edbef203405f");
    wait 0.5;
    level util::delay(2.5, undefined, &globallogic_audio::leader_dialog, "worldEventHelicopterCrashInvestigate");
    var_8f9fbf19 stoploopsound();
    var_8f9fbf19 kill();
    var_442fa2aa delete();
    foreach (var_3db3394e in var_f4b11f6a) {
        var_3db3394e.var_332bea31 = namespace_8b6a9d79::spawn_script_model(var_3db3394e, var_3db3394e.model, 1);
        var_3db3394e.var_332bea31 solid();
    }
    array::thread_all(function_a1ef346b(), &function_b05e27da, 0.75, 1);
    s_instance thread helicopter_crash_fx(s_fx);
    playsoundatposition(#"hash_43ceb234ba919126", s_chest.origin);
    namespace_58949729::function_25979f32(s_chest, 1, s_instance);
    awareness::function_e732359c(0, s_chest.origin, s_chest.radius);
}

// Namespace namespace_12a6a726/namespace_12a6a726
// Params 0, eflags: 0x1 linked
// Checksum 0x6147e0f7, Offset: 0xb60
// Size: 0x1d0
function function_aa8eac18() {
    self callback::function_52ac9652(#"hash_345e9169ebba28fb", &function_aa8eac18);
    self flag::set("cleanup");
    s_chest = self.var_fe2612fe[#"hash_6b1e5d8f9e70a70e"][0];
    namespace_58949729::function_a3852ab5(s_chest);
    if (isdefined(self.var_442fa2aa)) {
        self.var_442fa2aa delete();
    }
    if (isdefined(self.var_8f9fbf19)) {
        self.var_8f9fbf19 stoploopsound();
        self.var_8f9fbf19 kill();
    }
    var_f4b11f6a = isdefined(self.var_fe2612fe[#"hash_385496bc16a00598"]) ? self.var_fe2612fe[#"hash_385496bc16a00598"] : [];
    foreach (var_3db3394e in var_f4b11f6a) {
        if (isdefined(var_3db3394e.var_332bea31)) {
            var_3db3394e.var_332bea31 delete();
        }
    }
}

// Namespace namespace_12a6a726/namespace_12a6a726
// Params 1, eflags: 0x1 linked
// Checksum 0xfb71bf57, Offset: 0xd38
// Size: 0xa4
function function_4b5646b1(params) {
    self endon(#"death");
    self vehicle_death::death_fx();
    self thread vehicle_death::death_radius_damage("MOD_EXPLOSIVE", params.attacker);
    self notsolid();
    self ghost();
    self vehicle_death::deletewhensafe();
}

// Namespace namespace_12a6a726/namespace_12a6a726
// Params 1, eflags: 0x1 linked
// Checksum 0x9c5e8dc8, Offset: 0xde8
// Size: 0xb4
function helicopter_crash_fx(s_fx) {
    mdl_fx = util::spawn_model("tag_origin", s_fx.origin, s_fx.angles);
    mdl_fx clientfield::set("helicopter_crash_fx", 1);
    self flag::wait_till_timeout(60, "cleanup");
    mdl_fx clientfield::set("helicopter_crash_fx", 0);
    wait 3;
    mdl_fx delete();
}

// Namespace namespace_12a6a726/namespace_12a6a726
// Params 1, eflags: 0x5 linked
// Checksum 0xbbcc936f, Offset: 0xea8
// Size: 0x324
function private function_8ba92985(s_instance) {
    s_instance endon(#"cleanup");
    s_instance flag::clear("cleanup");
    s_instance callback::function_d8abfc3d(#"hash_345e9169ebba28fb", &function_db97f0ee);
    s_chest = s_instance.var_fe2612fe[#"hash_6b1e5d8f9e70a70e"][0];
    var_3ba64fe9 = s_instance.var_fe2612fe[#"trigger_spawn"][0];
    var_950b702f = s_instance.var_fe2612fe[#"hash_1520b4ce335b2a90"][0];
    var_8e27c3fd = spawn("trigger_radius", var_3ba64fe9.origin, 256, var_3ba64fe9.radius, var_3ba64fe9.height);
    s_instance.var_8e27c3fd = var_8e27c3fd;
    var_8e27c3fd.target = s_chest.targetname;
    ambush_trigger = spawn("trigger_radius", var_950b702f.origin, 0, var_950b702f.radius, var_950b702f.height);
    s_instance.ambush_trigger = ambush_trigger;
    while (true) {
        var_8e27c3fd waittill(#"trigger_look");
        if (level flag::get(#"objective_locked")) {
            level flag::wait_till_clear(#"objective_locked");
            continue;
        }
        break;
    }
    s_instance util::delay(3, "cleanup", &item_supply_drop::function_9771c7db, s_chest.origin + (0, 0, 3000), #"hash_5f4c110f01c55af9", 1, s_instance);
    s_chest thread supply_drop_portal_fx(s_instance);
    array::thread_all(function_a1ef346b(), &function_b05e27da, 0.5, 6, "buzz_high");
    var_8e27c3fd delete();
    ambush_trigger waittill(#"trigger");
    namespace_2c949ef8::function_be6ec6c(var_950b702f.origin);
    ambush_trigger delete();
}

// Namespace namespace_12a6a726/namespace_12a6a726
// Params 0, eflags: 0x1 linked
// Checksum 0x5074314b, Offset: 0x11d8
// Size: 0xbc
function function_db97f0ee() {
    self callback::function_52ac9652(#"hash_345e9169ebba28fb", &function_aa8eac18);
    self flag::set("cleanup");
    namespace_58949729::function_ccf9be41(self);
    if (isdefined(self.var_8e27c3fd)) {
        self.var_8e27c3fd delete();
    }
    if (isdefined(self.ambush_trigger)) {
        self.ambush_trigger delete();
    }
}

// Namespace namespace_12a6a726/namespace_12a6a726
// Params 3, eflags: 0x1 linked
// Checksum 0x919d6918, Offset: 0x12a0
// Size: 0xc4
function function_b05e27da(magnitude = 0.3, duration = 3, rumble = "damage_heavy") {
    self endon(#"disconnect");
    earthquake(magnitude, duration, self.origin, 64);
    self playrumblelooponentity(rumble);
    wait duration;
    self stoprumble(rumble);
}

// Namespace namespace_12a6a726/namespace_12a6a726
// Params 1, eflags: 0x1 linked
// Checksum 0x426af191, Offset: 0x1370
// Size: 0x1d4
function supply_drop_portal_fx(s_instance) {
    start = self.origin;
    end = start + (0, 0, -8000);
    trace = bullettrace(start, end, 0, self, 0);
    v_loc = trace[#"position"];
    if (isdefined(v_loc)) {
        mdl_fx = util::spawn_model("tag_origin", v_loc);
        mdl_fx clientfield::set("payload_teleport", 2);
        mdl_fx playsound(#"hash_4ca84d69902e28f0");
        mdl_fx playloopsound(#"hash_405936dc98db4120");
        if (isdefined(s_instance)) {
            s_instance flag::wait_till_timeout(3, "cleanup");
        } else {
            wait 3;
        }
        glassradiusdamage(self.origin, 600, 800, 400);
        mdl_fx clientfield::set("payload_teleport", 1);
        mdl_fx stoploopsound();
        mdl_fx playsound(#"hash_7f3e03d7e76384d1");
        wait 3;
        mdl_fx delete();
    }
}

// Namespace namespace_12a6a726/namespace_12a6a726
// Params 2, eflags: 0x1 linked
// Checksum 0x7b5a145b, Offset: 0x1550
// Size: 0x1dc
function function_9678a483(var_93fe96a6 = 0, s_instance) {
    neworigin = self.origin + anglestoup(self.angles) * 27.5;
    self.angles = item_supply_drop::function_ee19f0b0(self.angles);
    self.origin = neworigin - anglestoup(self.angles) * 27.5;
    struct = spawnstruct();
    struct.origin = self.origin;
    struct.angles = self.angles;
    namespace_58949729::function_25979f32(struct, var_93fe96a6, s_instance);
    mdl_fx = util::spawn_model("tag_origin", struct.origin);
    mdl_fx clientfield::set("supply_drop_fx", 1);
    self hide();
    self notsolid();
    wait 60;
    if (isdefined(mdl_fx)) {
        mdl_fx clientfield::set("supply_drop_fx", 0);
        wait 3;
        mdl_fx delete();
    }
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace namespace_12a6a726/namespace_12a6a726
// Params 5, eflags: 0x5 linked
// Checksum 0x3c5cb60e, Offset: 0x1738
// Size: 0x20c
function private function_eafcba42(startpoint, endpoint, droppoint, maxheight, minheight) {
    points = [];
    startpoint = trace_point(startpoint, undefined, maxheight, minheight);
    endpoint = trace_point(endpoint, undefined, maxheight, minheight);
    var_bb96e272 = vectornormalize(endpoint - startpoint);
    pathlength = distance2d(startpoint, endpoint);
    var_28021cac = int(pathlength / 5000);
    points[0] = startpoint;
    if (isdefined(droppoint)) {
        var_66d25ef4 = distancesquared(startpoint, droppoint);
    }
    for (var_c742cad6 = 1; var_c742cad6 <= var_28021cac; var_c742cad6++) {
        var_a1bc57e1 = startpoint + var_bb96e272 * 5000 * var_c742cad6;
        if (isdefined(droppoint)) {
            if (distancesquared(startpoint, var_a1bc57e1) >= var_66d25ef4 && distancesquared(startpoint, points[points.size - 1]) <= var_66d25ef4) {
                points[points.size] = droppoint;
            }
        }
        points[points.size] = trace_point(var_a1bc57e1, undefined, maxheight, minheight + 1000);
        waitframe(1);
    }
    points[points.size] = endpoint;
    return points;
}

// Namespace namespace_12a6a726/namespace_12a6a726
// Params 4, eflags: 0x5 linked
// Checksum 0x89eb015d, Offset: 0x1950
// Size: 0x134
function private trace_point(point, var_5fd22b95 = 1, maxheight = 10000, minheight = 5000) {
    startpoint = (point[0], point[1], maxheight);
    endpoint = (point[0], point[1], minheight);
    trace = groundtrace(startpoint, endpoint, 0, undefined, var_5fd22b95);
    if (!var_5fd22b95) {
        if (trace[#"surfacetype"] == "water" || trace[#"surfacetype"] == "watershallow") {
            return;
        }
    }
    if (isdefined(trace[#"position"])) {
        return trace[#"position"];
    }
    return startpoint;
}

// Namespace namespace_12a6a726/namespace_12a6a726
// Params 5, eflags: 0x5 linked
// Checksum 0x4710321b, Offset: 0x1a90
// Size: 0x216
function private function_c2edbefb(path, droppoint, var_86928932, *var_2118f785 = 1, s_instance) {
    self endon(#"death", #"emergency_exit");
    for (pathindex = 1; pathindex < droppoint.size; pathindex++) {
        var_f155e743 = 0;
        if (isdefined(var_86928932)) {
            var_f155e743 = distancesquared(droppoint[pathindex], var_86928932) < function_a3f6cdac(128);
        }
        self function_a57c34b7(droppoint[pathindex], var_f155e743 && var_2118f785, 0);
        while (true) {
            if (var_f155e743) {
                if (distancesquared(var_86928932, self.origin) < function_a3f6cdac(128)) {
                    if (var_2118f785) {
                        wait 2;
                    }
                    item_supply_drop::function_9771c7db(var_86928932, #"hash_5f4c110f01c55af9", 1, s_instance);
                    if (var_2118f785) {
                        wait 1;
                    }
                    break;
                }
            } else if (distancesquared(droppoint[pathindex], self.origin) < function_a3f6cdac(1500)) {
                break;
            }
            waitframe(1);
        }
    }
    if (isdefined(var_86928932)) {
        self delete();
        return;
    }
    self notify(#"hash_2f49edbef203405f");
}

