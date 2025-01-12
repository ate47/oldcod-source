#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\hostmigration_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;

#namespace vehicle;

// Namespace vehicle
// Method(s) 2 Total 2
class class_3e945617 {

    var riders;
    var var_3788699b;
    var var_632a076b;
    var var_85cb88be;
    var var_d646268b;
    var var_db97b52b;

    // Namespace class_3e945617/vehicleriders_shared
    // Params 0, eflags: 0x8
    // Checksum 0xaf3b2fa4, Offset: 0x9d8
    // Size: 0x4a
    constructor() {
        riders = [];
        var_3788699b = 0;
        var_632a076b = 0;
        var_db97b52b = 0;
        var_d646268b = 0;
        var_85cb88be = 0;
    }

}

// Namespace vehicle/vehicleriders_shared
// Params 0, eflags: 0x2
// Checksum 0xf49f56bd, Offset: 0x1f0
// Size: 0x54
function autoexec init() {
    function_b53ec93a();
    callback::on_vehicle_spawned(&on_vehicle_spawned);
    callback::on_vehicle_killed(&on_vehicle_killed);
}

// Namespace vehicle/vehicleriders_shared
// Params 0, eflags: 0x4
// Checksum 0x12805912, Offset: 0x250
// Size: 0x270
function private function_b53ec93a() {
    a_registered_fields = [];
    foreach (bundle in struct::get_script_bundles("vehicleriders")) {
        foreach (object in bundle.objects) {
            if (isdefined(object.vehicleenteranim)) {
                array::add(a_registered_fields, object.position + "_enter", 0);
            }
            if (isdefined(object.vehicleexitanim)) {
                array::add(a_registered_fields, object.position + "_exit", 0);
            }
            if (isdefined(object.vehiclecloseanim)) {
                array::add(a_registered_fields, object.position + "_close", 0);
            }
            if (isdefined(object.vehicleriderdeathanim)) {
                array::add(a_registered_fields, object.position + "_death", 0);
            }
        }
    }
    foreach (str_clientfield in a_registered_fields) {
        clientfield::register("vehicle", str_clientfield, 1, 1, "counter");
    }
}

// Namespace vehicle/vehicleriders_shared
// Params 1, eflags: 0x0
// Checksum 0x8928fb3f, Offset: 0x4c8
// Size: 0x4c
function function_e7cd057d(vehicle) {
    assert(isvehicle(vehicle));
    if (isdefined(vehicle.vehicleridersbundle)) {
        return true;
    }
    return false;
}

// Namespace vehicle/vehicleriders_shared
// Params 1, eflags: 0x4
// Checksum 0x624081e8, Offset: 0x520
// Size: 0xc
function private function_98372085(vehicle) {
    
}

// Namespace vehicle/vehicleriders_shared
// Params 1, eflags: 0x4
// Checksum 0x83e8fd89, Offset: 0x538
// Size: 0xf0
function private function_4e08da91(vehicle) {
    assert(isvehicle(vehicle));
    var_3788699b = function_e7440fe(vehicle);
    bundle = struct::get_script_bundle("vehicleriders", vehicle.vehicleridersbundle);
    for (seat = 0; seat < var_3788699b; seat++) {
        position = bundle.objects[seat].position;
        if (issubstr(position, "driver")) {
            return true;
        }
    }
    return false;
}

// Namespace vehicle/vehicleriders_shared
// Params 1, eflags: 0x4
// Checksum 0x96829da7, Offset: 0x630
// Size: 0xe6
function private function_80c169ff(vehicle) {
    assert(isvehicle(vehicle));
    var_3788699b = function_e7440fe(vehicle);
    bundle = struct::get_script_bundle("vehicleriders", vehicle.vehicleridersbundle);
    for (seat = 0; seat < var_3788699b; seat++) {
        position = bundle.objects[seat].position;
        if (position == "passenger1") {
            return true;
        }
    }
    return false;
}

// Namespace vehicle/vehicleriders_shared
// Params 1, eflags: 0x4
// Checksum 0x16aa5e13, Offset: 0x720
// Size: 0xe6
function private function_d789426a(vehicle) {
    assert(isvehicle(vehicle));
    var_3788699b = function_e7440fe(vehicle);
    bundle = struct::get_script_bundle("vehicleriders", vehicle.vehicleridersbundle);
    for (seat = 0; seat < var_3788699b; seat++) {
        position = bundle.objects[seat].position;
        if (position == "gunner1") {
            return true;
        }
    }
    return false;
}

// Namespace vehicle/vehicleriders_shared
// Params 1, eflags: 0x4
// Checksum 0xb2e3d06f, Offset: 0x810
// Size: 0xfa
function private function_b3a42957(vehicle) {
    assert(isvehicle(vehicle));
    var_3788699b = function_e7440fe(vehicle);
    var_632a076b = 0;
    bundle = struct::get_script_bundle("vehicleriders", vehicle.vehicleridersbundle);
    for (seat = 0; seat < var_3788699b; seat++) {
        position = bundle.objects[seat].position;
        if (issubstr(position, "crew")) {
            var_632a076b++;
        }
    }
    return var_632a076b;
}

// Namespace vehicle/vehicleriders_shared
// Params 1, eflags: 0x0
// Checksum 0xb6dc977b, Offset: 0x918
// Size: 0xb6
function function_e7440fe(vehicle) {
    assert(isvehicle(vehicle));
    if (!function_e7cd057d(vehicle)) {
        return 0;
    }
    assert(isdefined(vehicle.vehicleridersbundle));
    var_3788699b = struct::get_script_bundle("vehicleriders", vehicle.vehicleridersbundle).var_3788699b;
    if (isdefined(var_3788699b)) {
        return var_3788699b;
    }
    return 0;
}

// Namespace vehicle/vehicleriders_shared
// Params 0, eflags: 0x4
// Checksum 0x742af61e, Offset: 0xad0
// Size: 0x448
function private on_vehicle_spawned() {
    assert(isvehicle(self));
    if (!function_e7cd057d(self)) {
        return;
    }
    function_98372085(self);
    var_3788699b = function_e7440fe(self);
    if (!isdefined(var_3788699b) || var_3788699b <= 0) {
        return;
    }
    self.var_3d635c37 = new class_3e945617();
    self.var_3d635c37.riders = [];
    self.var_3d635c37.var_3788699b = var_3788699b;
    self flag::init("driver_occupied", 0);
    self flag::init("passenger1_occupied", 0);
    self flag::init("gunner1_occupied", 0);
    if (function_4e08da91(self)) {
        self.var_3d635c37.var_db97b52b = 1;
    }
    if (function_80c169ff(self)) {
        self.var_3d635c37.var_d646268b = 1;
    }
    if (function_d789426a(self)) {
        self.var_3d635c37.var_85cb88be = 1;
    }
    var_632a076b = function_b3a42957(self);
    self.var_3d635c37.var_632a076b = var_632a076b;
    for (position = 1; position <= 9; position++) {
        flag::init("crew" + position + "_occupied", 0);
    }
    if (isdefined(self.script_vehicleride)) {
        a_spawners = getactorspawnerarray(self.script_vehicleride, "script_vehicleride");
        foreach (sp in a_spawners) {
            if (isdefined(sp)) {
                if (self.spawner !== sp) {
                    ai_rider = sp spawner::spawn(1);
                    if (isdefined(ai_rider)) {
                        seat = undefined;
                        if (isdefined(ai_rider.script_startingposition) && ai_rider.script_startingposition != "undefined") {
                            seat = ai_rider.script_startingposition;
                            if (issubstr(seat, "crew")) {
                                seat = "crew";
                            } else if (issubstr(seat, "pass")) {
                                seat = "passenger1";
                            } else if (issubstr(seat, "driver")) {
                                seat = "driver";
                            } else {
                                seat = undefined;
                            }
                            if (isdefined(seat)) {
                                ai_rider get_in(ai_rider, self, seat, 1);
                            }
                            continue;
                        }
                        ai_rider get_in(ai_rider, self, undefined, 1);
                    }
                }
            }
        }
    }
}

// Namespace vehicle/vehicleriders_shared
// Params 1, eflags: 0x4
// Checksum 0xc44f1c56, Offset: 0xf20
// Size: 0xe6
function private function_afd5288e(vehicle) {
    assert(isdefined(vehicle));
    assert(isdefined(vehicle.var_3d635c37));
    assert(isdefined(vehicle.var_3d635c37.var_632a076b));
    for (position = 1; position <= vehicle.var_3d635c37.var_632a076b; position++) {
        if (!vehicle flag::get("crew" + position + "_occupied")) {
            return ("crew" + position);
        }
    }
    return "none";
}

// Namespace vehicle/vehicleriders_shared
// Params 2, eflags: 0x4
// Checksum 0x975c4d53, Offset: 0x1010
// Size: 0xa4
function private function_8872056d(vehicle, seat) {
    flag = seat + "_occupied";
    assert(vehicle flag::exists(flag));
    assert(!vehicle flag::get(flag));
    vehicle flag::set(flag);
}

// Namespace vehicle/vehicleriders_shared
// Params 2, eflags: 0x4
// Checksum 0xec173b70, Offset: 0x10c0
// Size: 0xa4
function private function_f22691ac(vehicle, seat) {
    flag = seat + "_occupied";
    assert(vehicle flag::exists(flag));
    assert(!vehicle flag::get(flag));
    vehicle flag::clear(flag);
}

// Namespace vehicle/vehicleriders_shared
// Params 1, eflags: 0x0
// Checksum 0xb63db81c, Offset: 0x1170
// Size: 0x6a
function get_human_bundle(assertifneeded = 1) {
    if (assertifneeded) {
        assert(isdefined(self.vehicleridersbundle), "<dev string:x30>");
    }
    return struct::get_script_bundle("vehicleriders", self.vehicleridersbundle);
}

// Namespace vehicle/vehicleriders_shared
// Params 1, eflags: 0x0
// Checksum 0xd99aea09, Offset: 0x11e8
// Size: 0x6a
function get_robot_bundle(assertifneeded = 1) {
    if (assertifneeded) {
        assert(isdefined(self.vehicleridersrobotbundle), "<dev string:x81>");
    }
    return struct::get_script_bundle("vehicleriders", self.vehicleridersrobotbundle);
}

// Namespace vehicle/vehicleriders_shared
// Params 1, eflags: 0x0
// Checksum 0xccf6c24d, Offset: 0x1260
// Size: 0x6a
function get_warlord_bundle(assertifneeded = 1) {
    if (assertifneeded) {
        assert(isdefined(self.vehicleriderswarlordbundle), "<dev string:xd8>");
    }
    return struct::get_script_bundle("vehicleriders", self.vehicleriderswarlordbundle);
}

// Namespace vehicle/vehicleriders_shared
// Params 2, eflags: 0x4
// Checksum 0x4c4f9d8e, Offset: 0x12d8
// Size: 0x13a
function private function_b5d876ce(ai, vehicle) {
    assert(isactor(ai));
    assert(isdefined(ai.archetype));
    assert(function_e7cd057d(vehicle));
    if (ai.archetype == "robot") {
        return vehicle get_robot_bundle();
    }
    if (ai.archetype == "warlord") {
        return vehicle get_warlord_bundle();
    }
    assert(ai.archetype == "<dev string:x131>", "<dev string:x137>" + ai.archetype);
    return vehicle get_human_bundle();
}

// Namespace vehicle/vehicleriders_shared
// Params 3, eflags: 0x0
// Checksum 0xa38e724c, Offset: 0x1420
// Size: 0xee
function function_fac25bb1(ai, vehicle, seat) {
    assert(isactor(ai));
    bundle = undefined;
    bundle = vehicle function_b5d876ce(ai, vehicle);
    foreach (s_rider in bundle.objects) {
        if (s_rider.position == seat) {
            return s_rider;
        }
    }
}

// Namespace vehicle/vehicleriders_shared
// Params 3, eflags: 0x4
// Checksum 0xef0c2a70, Offset: 0x1518
// Size: 0x26c
function private init_rider(ai, vehicle, seat) {
    assert(isdefined(vehicle));
    assert(isactor(ai));
    assert(!isdefined(ai.var_f96d0a4c));
    ai.var_f96d0a4c = function_fac25bb1(ai, vehicle, seat);
    ai.vehicle = vehicle;
    ai.var_ccc29c03 = seat;
    if (isdefined(ai.var_f96d0a4c.rideanim) && !isanimlooping(ai.var_f96d0a4c.rideanim)) {
        assertmsg("<dev string:x16a>" + seat + "<dev string:x18d>" + function_15979fa9(ai.vehicle.vehicletype) + "<dev string:x19b>");
    }
    if (isdefined(ai.var_f96d0a4c.aligntag) && !isdefined(ai.vehicle gettagorigin(ai.var_f96d0a4c.aligntag))) {
        assertmsg("<dev string:x16a>" + seat + "<dev string:x18d>" + function_15979fa9(ai.vehicle.vehicletype) + "<dev string:x1b4>" + ai.var_f96d0a4c.aligntag + "<dev string:x1c7>");
    }
    ai flag::init("in_vehicle");
    ai flag::init("riding_vehicle");
}

// Namespace vehicle/vehicleriders_shared
// Params 3, eflags: 0x0
// Checksum 0x3ffe49d8, Offset: 0x1790
// Size: 0x48e
function fill_riders(a_ai, vehicle, seat) {
    assert(isvehicle(vehicle));
    if (!function_e7cd057d(vehicle)) {
        assertmsg("<dev string:x1ca>" + function_15979fa9(vehicle.vehicletype) + "<dev string:x1db>");
        return;
    }
    if (isdefined(seat)) {
        assert(seat == "<dev string:x1fe>" || seat == "<dev string:x205>" || seat == "<dev string:x210>");
    } else {
        seat = "all";
    }
    if (!isalive(vehicle)) {
        return;
    }
    a_ai_remaining = arraycopy(a_ai);
    switch (seat) {
    case #"driver":
        if (get_in(a_ai[0], vehicle, "driver", 0)) {
            arrayremovevalue(a_ai_remaining, a_ai[0]);
        }
        break;
    case #"passenger1":
        if (get_in(a_ai[0], vehicle, "passenger1", 0)) {
            arrayremovevalue(a_ai_remaining, a_ai[0]);
        }
        break;
    case #"gunner1":
        if (get_in(a_ai[0], vehicle, "gunner1", 0)) {
            arrayremovevalue(a_ai_remaining, a_ai[0]);
        }
        break;
    case #"crew":
        foreach (ai in a_ai) {
            if (get_in(ai, vehicle, "crew", 0)) {
                arrayremovevalue(a_ai_remaining, ai);
            }
        }
        break;
    case #"all":
        index = 0;
        if (get_in(a_ai[index], vehicle, "driver", 0)) {
            arrayremovevalue(a_ai_remaining, a_ai[index]);
            index++;
        }
        if (get_in(a_ai[index], vehicle, "passenger1", 0)) {
            arrayremovevalue(a_ai_remaining, a_ai[index]);
            index++;
        }
        for (i = index; i < a_ai.size; i++) {
            if (get_in(a_ai[index], vehicle, "crew", 0)) {
                arrayremovevalue(a_ai_remaining, a_ai[index]);
                index++;
            }
        }
        if (get_in(a_ai[index], vehicle, "gunner1", 0)) {
            arrayremovevalue(a_ai_remaining, a_ai[index]);
        }
        break;
    }
    return a_ai_remaining;
}

// Namespace vehicle/vehicleriders_shared
// Params 1, eflags: 0x0
// Checksum 0x1e98b522, Offset: 0x1c28
// Size: 0x322
function unload(seat) {
    assert(isvehicle(self));
    if (!function_e7cd057d(self)) {
        assertmsg("<dev string:x1ca>" + function_15979fa9(self.vehicletype) + "<dev string:x1db>");
        return;
    }
    if (isdefined(seat) && seat != "undefined") {
        if (seat == "passengers") {
            seat = "passenger1";
        } else if (seat == "gunners") {
            seat = "gunner1";
        }
        assert(seat == "<dev string:x1fe>" || seat == "<dev string:x205>" || seat == "<dev string:x210>" || seat == "<dev string:x215>" || seat == "<dev string:x21d>");
    } else {
        seat = "all";
    }
    if (!isdefined(self.var_3d635c37.riders)) {
        return;
    }
    self.var_3d635c37.riders = array::remove_undefined(self.var_3d635c37.riders, 1);
    if (self.var_3d635c37.riders.size <= 0) {
        return;
    }
    var_3788699b = self.var_3d635c37.var_3788699b;
    assert(var_3788699b > 0);
    switch (seat) {
    case #"driver":
        function_fa27faa1(self);
        break;
    case #"passenger1":
        function_34f83e8d(self);
        break;
    case #"gunner1":
        function_127b5ba2(self);
        break;
    case #"crew":
        function_2db5aa14(self);
        break;
    default:
        function_fa27faa1(self);
        function_34f83e8d(self);
        function_2db5aa14(self);
        function_127b5ba2(self);
        break;
    }
}

// Namespace vehicle/vehicleriders_shared
// Params 1, eflags: 0x4
// Checksum 0xf5fd7012, Offset: 0x1f58
// Size: 0x1d4
function private function_fa27faa1(vehicle) {
    if (!vehicle.var_3d635c37.var_db97b52b) {
        return;
    }
    if (vehicle flag::get("driver_occupied") && isdefined(vehicle.var_3d635c37.riders[#"driver"]) && isalive(vehicle.var_3d635c37.riders[#"driver"])) {
        ai = vehicle.var_3d635c37.riders[#"driver"];
        assert(ai flag::get("<dev string:x221>"));
        closeanim = undefined;
        if (isdefined(ai.var_f96d0a4c.vehiclecloseanim)) {
            closeanim = ai.var_f96d0a4c.vehiclecloseanim;
        }
        ai get_out(vehicle, ai, "driver");
        if (isdefined(closeanim) && isdefined(vehicle)) {
            vehicle clientfield::increment("driver" + "_close", 1);
            vehicle setanim(closeanim, 1, 0, 1);
        }
    }
}

// Namespace vehicle/vehicleriders_shared
// Params 1, eflags: 0x4
// Checksum 0x8bb19dd8, Offset: 0x2138
// Size: 0x1d4
function private function_34f83e8d(vehicle) {
    if (!vehicle.var_3d635c37.var_d646268b) {
        return;
    }
    if (vehicle flag::get("passenger1_occupied") && isdefined(vehicle.var_3d635c37.riders[#"passenger1"]) && isalive(vehicle.var_3d635c37.riders[#"passenger1"])) {
        ai = vehicle.var_3d635c37.riders[#"passenger1"];
        assert(ai flag::get("<dev string:x221>"));
        closeanim = undefined;
        if (isdefined(ai.var_f96d0a4c.vehiclecloseanim)) {
            closeanim = ai.var_f96d0a4c.vehiclecloseanim;
        }
        ai get_out(vehicle, ai, "passenger1");
        if (isdefined(closeanim) && isdefined(vehicle)) {
            vehicle clientfield::increment("passenger1" + "_close", 1);
            vehicle setanim(closeanim, 1, 0, 1);
        }
    }
}

// Namespace vehicle/vehicleriders_shared
// Params 1, eflags: 0x4
// Checksum 0xdc1cd183, Offset: 0x2318
// Size: 0x1d4
function private function_127b5ba2(vehicle) {
    if (!vehicle.var_3d635c37.var_85cb88be) {
        return;
    }
    if (vehicle flag::get("gunner1_occupied") && isdefined(vehicle.var_3d635c37.riders[#"gunner1"]) && isalive(vehicle.var_3d635c37.riders[#"gunner1"])) {
        ai = vehicle.var_3d635c37.riders[#"gunner1"];
        assert(ai flag::get("<dev string:x221>"));
        closeanim = undefined;
        if (isdefined(ai.var_f96d0a4c.vehiclecloseanim)) {
            closeanim = ai.var_f96d0a4c.vehiclecloseanim;
        }
        ai get_out(vehicle, ai, "gunner1");
        if (isdefined(closeanim) && isdefined(vehicle)) {
            vehicle clientfield::increment("gunner1" + "_close", 1);
            vehicle setanim(closeanim, 1, 0, 1);
        }
    }
}

// Namespace vehicle/vehicleriders_shared
// Params 1, eflags: 0x4
// Checksum 0x94d00c05, Offset: 0x24f8
// Size: 0x374
function private function_2db5aa14(vehicle) {
    assert(isdefined(vehicle.var_3d635c37.var_3788699b) && vehicle.var_3d635c37.var_3788699b > 0);
    if (!isdefined(vehicle.var_3d635c37.var_632a076b)) {
        return;
    }
    if (vehicle.var_3d635c37.var_632a076b <= 0) {
        return;
    }
    var_ceaf4a9f = [];
    var_4d4dbfb6 = undefined;
    n_crew_door_close_position = undefined;
    for (position = 1; position <= vehicle.var_3d635c37.var_632a076b; position++) {
        seat = "crew" + position;
        flag = seat + "_occupied";
        if (vehicle flag::get(flag) && isdefined(vehicle.var_3d635c37.riders[seat]) && isalive(vehicle.var_3d635c37.riders[seat])) {
            ai = vehicle.var_3d635c37.riders[seat];
            assert(ai flag::get("<dev string:x221>"));
            if (!isdefined(var_4d4dbfb6)) {
                if (isdefined(ai.var_f96d0a4c.vehiclecloseanim)) {
                    n_crew_door_close_position = seat;
                    var_4d4dbfb6 = ai.var_f96d0a4c.vehiclecloseanim;
                }
            }
            ai thread get_out(vehicle, vehicle.var_3d635c37.riders[seat], seat);
            array::add(var_ceaf4a9f, ai);
        }
    }
    if (var_ceaf4a9f.size > 0) {
        timeout = vehicle.unloadtimeout;
        array::wait_till(var_ceaf4a9f, "exited_vehicle");
        array::flagsys_wait_clear(var_ceaf4a9f, "in_vehicle", isdefined(timeout) ? timeout : 4);
        if (isdefined(vehicle)) {
            vehicle notify(#"unload", var_ceaf4a9f);
            vehicle remove_riders_after_wait(vehicle, var_ceaf4a9f);
        }
    }
    if (isdefined(var_4d4dbfb6) && isdefined(vehicle)) {
        vehicle clientfield::increment(n_crew_door_close_position + "_close", 1);
        vehicle setanim(var_4d4dbfb6, 1, 0, 1);
    }
}

// Namespace vehicle/vehicleriders_shared
// Params 3, eflags: 0x0
// Checksum 0x57b9d5c1, Offset: 0x2878
// Size: 0x458
function get_out(vehicle, ai, seat) {
    assert(isdefined(ai));
    assert(isalive(ai), "<dev string:x22c>");
    assert(isactor(ai), "<dev string:x24d>");
    assert(isdefined(ai.vehicle), "<dev string:x282>");
    assert(isdefined(ai.var_f96d0a4c));
    assert(seat == "<dev string:x1fe>" || seat == "<dev string:x205>" || issubstr(seat, "<dev string:x210>") || seat == "<dev string:x215>");
    ai notify(#"exiting_vehicle");
    if (isdefined(ai.var_f96d0a4c.vehicleexitanim)) {
        ai.vehicle clientfield::increment(ai.var_f96d0a4c.position + "_exit", 1);
        ai.vehicle setanim(ai.var_f96d0a4c.vehicleexitanim, 1, 0, 1);
    }
    if (isdefined(vehicle) && isalive(vehicle)) {
        switch (seat) {
        case #"driver":
            vehicle flag::clear("driver_occupied");
            break;
        case #"passenger1":
            vehicle flag::clear("passenger1_occupied");
            break;
        case #"gunner1":
            vehicle flag::clear("gunner1_occupied");
            break;
        case #"crew":
            seat = "crew" + seat;
            flag = seat + "_occupied";
            vehicle flag::clear(flag);
            break;
        }
    }
    str_mode = "ground";
    if (vehicle.vehicleclass === "helicopter") {
        str_mode = "variable";
    }
    switch (str_mode) {
    case #"ground":
        exit_ground(ai);
        break;
    case #"variable":
        exit_variable(ai);
        break;
    default:
        assertmsg("<dev string:x298>");
        return;
    }
    if (isdefined(ai)) {
        ai flag::clear("in_vehicle");
        ai flag::clear("riding_vehicle");
        ai.vehicle = undefined;
        ai.var_f96d0a4c = undefined;
        ai animation::set_death_anim(undefined);
        ai notify(#"exited_vehicle");
    }
}

// Namespace vehicle/vehicleriders_shared
// Params 1, eflags: 0x0
// Checksum 0x3f6702fa, Offset: 0x2cd8
// Size: 0x13c
function exit_ground(ai) {
    assert(isdefined(ai));
    ai endon(#"death");
    if (!isdefined(self.var_f96d0a4c.exitgrounddeathanim)) {
        ai thread ragdoll_dead_exit_rider(ai);
    } else {
        ai animation::set_death_anim(ai.var_f96d0a4c.exitgrounddeathanim);
    }
    assert(isdefined(ai.var_f96d0a4c.exitgroundanim), "<dev string:x2b8>" + ai.var_f96d0a4c.position + "<dev string:x2d0>");
    if (isdefined(ai.var_f96d0a4c.exitgroundanim)) {
        animation::play(ai.var_f96d0a4c.exitgroundanim, ai.vehicle, ai.var_f96d0a4c.aligntag);
    }
}

// Namespace vehicle/vehicleriders_shared
// Params 2, eflags: 0x0
// Checksum 0xaf968893, Offset: 0x2e20
// Size: 0xf8
function remove_riders_after_wait(vehicle, a_riders_to_remove) {
    assert(isdefined(vehicle) && isdefined(a_riders_to_remove));
    assert(isdefined(vehicle.var_3d635c37.riders));
    if (isdefined(a_riders_to_remove)) {
        foreach (ai in a_riders_to_remove) {
            arrayremovevalue(vehicle.var_3d635c37.riders, ai, 1);
        }
    }
}

// Namespace vehicle/vehicleriders_shared
// Params 0, eflags: 0x4
// Checksum 0x5252bd08, Offset: 0x2f20
// Size: 0x6c
function private handle_falling_death() {
    self endon(#"landed");
    self waittill(#"death");
    if (isactor(self)) {
        self unlink();
        self startragdoll();
    }
}

// Namespace vehicle/vehicleriders_shared
// Params 1, eflags: 0x0
// Checksum 0x87e22492, Offset: 0x2f98
// Size: 0xc8
function ragdoll_dead_exit_rider(ai) {
    assert(isactor(ai));
    ai endon(#"exited_vehicle");
    ai waittill(#"death");
    if (isdefined(ai) && !ai isragdoll()) {
        ai unlink();
        ai startragdoll();
    }
    ai notify(#"exited_vehicle");
}

// Namespace vehicle/vehicleriders_shared
// Params 3, eflags: 0x4
// Checksum 0x3f58def9, Offset: 0x3068
// Size: 0x180
function private forward_euler_integration(e_move, v_target_landing, n_initial_speed) {
    landed = 0;
    position = self.origin;
    velocity = (0, 0, n_initial_speed * -1);
    gravity = (0, 0, -385.8);
    while (!landed) {
        previousposition = position;
        velocity += gravity * 0.1;
        position += velocity * 0.1;
        if (position[2] + velocity[2] * 0.1 <= v_target_landing[2]) {
            landed = 1;
            position = v_target_landing;
        }
        /#
            recordline(previousposition, position, (1, 0.5, 0), "<dev string:x2f1>", self);
        #/
        hostmigration::waittillhostmigrationdone();
        e_move moveto(position, 0.1);
        if (!landed) {
            wait 0.1;
        }
    }
}

// Namespace vehicle/vehicleriders_shared
// Params 1, eflags: 0x0
// Checksum 0x1a26b82e, Offset: 0x31f0
// Size: 0x540
function exit_variable(ai) {
    assert(isdefined(ai));
    ai endon(#"death");
    ai notify(#"exiting_vehicle");
    ai thread handle_falling_death();
    ai animation::set_death_anim(ai.var_f96d0a4c.exithighdeathanim);
    assert(isdefined(ai.var_f96d0a4c.exithighanim), "<dev string:x2b8>" + ai.var_f96d0a4c.position + "<dev string:x2d0>");
    animation::play(ai.var_f96d0a4c.exithighanim, ai.vehicle, ai.var_f96d0a4c.aligntag, 1, 0, 0);
    ai animation::set_death_anim(ai.var_f96d0a4c.exithighloopdeathanim);
    n_cur_height = get_height(ai.vehicle);
    bundle = ai.vehicle function_b5d876ce(ai, ai.vehicle);
    n_target_height = bundle.highexitlandheight;
    if (isdefined(ai.var_f96d0a4c.dropundervehicleorigin) && ai.var_f96d0a4c.dropundervehicleorigin || isdefined(ai.dropundervehicleoriginoverride) && ai.dropundervehicleoriginoverride) {
        v_target_landing = (ai.vehicle.origin[0], ai.vehicle.origin[1], ai.origin[2] - n_cur_height + n_target_height);
    } else {
        v_target_landing = (ai.origin[0], ai.origin[1], ai.origin[2] - n_cur_height + n_target_height);
    }
    if (isdefined(ai.overridedropposition)) {
        v_target_landing = (ai.overridedropposition[0], ai.overridedropposition[1], v_target_landing[2]);
    }
    if (isdefined(ai.targetangles)) {
        angles = ai.targetangles;
    } else {
        angles = ai.angles;
    }
    e_move = util::spawn_model("tag_origin", ai.origin, angles);
    ai thread exit_high_loop_anim(e_move);
    distance = n_target_height - n_cur_height;
    initialspeed = bundle.dropspeed;
    n_fall_time = (initialspeed * -1 + sqrt(pow(initialspeed, 2) - 2 * 385.8 * distance)) / 385.8;
    ai notify(#"falling", {#fall_time:n_fall_time});
    forward_euler_integration(e_move, v_target_landing, bundle.dropspeed);
    e_move waittill(#"movedone");
    ai notify(#"landing");
    ai animation::set_death_anim(ai.var_f96d0a4c.exithighlanddeathanim);
    animation::play(ai.var_f96d0a4c.exithighlandanim, e_move, "tag_origin");
    ai notify(#"landed");
    ai unlink();
    waitframe(1);
    e_move delete();
    ai notify(#"exited_vehicle");
}

// Namespace vehicle/vehicleriders_shared
// Params 1, eflags: 0x0
// Checksum 0xd40d213a, Offset: 0x3738
// Size: 0x68
function exit_high_loop_anim(e_parent) {
    self endon(#"death");
    self endon(#"landing");
    while (true) {
        animation::play(self.var_f96d0a4c.exithighloopanim, e_parent, "tag_origin");
    }
}

// Namespace vehicle/vehicleriders_shared
// Params 1, eflags: 0x0
// Checksum 0x619cfae0, Offset: 0x37a8
// Size: 0xea
function get_height(e_ignore = self) {
    trace = groundtrace(self.origin + (0, 0, 10), self.origin + (0, 0, -10000), 0, e_ignore, 0);
    /#
        recordline(self.origin + (0, 0, 10), trace[#"position"], (1, 0.5, 0), "<dev string:x2f1>", self);
    #/
    return distance(self.origin, trace[#"position"]);
}

// Namespace vehicle/vehicleriders_shared
// Params 4, eflags: 0x0
// Checksum 0xdf991c25, Offset: 0x38a0
// Size: 0x6d8
function get_in(ai, vehicle, seat, var_cc2f276a = 1) {
    vehicle endon(#"death");
    if (!isdefined(ai)) {
        return 0;
    }
    if (!isdefined(seat) || seat == "undefined") {
        if (vehicle.var_3d635c37.var_db97b52b && !vehicle flag::get("driver_occupied")) {
            seat = "driver";
        } else if (vehicle.var_3d635c37.var_d646268b && !vehicle flag::get("passenger1_occupied")) {
            seat = "passenger1";
        } else {
            seat = "crew";
        }
    }
    assert(isactor(ai));
    assert(isdefined(seat) && (seat == "<dev string:x1fe>" || seat == "<dev string:x205>" || seat == "<dev string:x210>"));
    switch (seat) {
    case #"driver":
        if (vehicle.var_3d635c37.var_db97b52b && vehicle flag::get("driver_occupied")) {
            /#
                if (var_cc2f276a) {
                    assertmsg("<dev string:x2fc>" + function_15979fa9(vehicle.vehicletype) + "<dev string:x321>");
                }
            #/
            return 0;
        }
        init_rider(ai, vehicle, "driver");
        break;
    case #"passenger1":
        if (vehicle.var_3d635c37.var_d646268b && vehicle flag::get("passenger1_occupied")) {
            /#
                if (var_cc2f276a) {
                    assertmsg("<dev string:x34b>" + function_15979fa9(vehicle.vehicletype) + "<dev string:x373>");
                }
            #/
            return 0;
        }
        init_rider(ai, vehicle, "passenger1");
        break;
    case #"gunner1":
        if (vehicle.var_3d635c37.var_85cb88be && vehicle flag::get("gunner1_occupied")) {
            /#
                if (var_cc2f276a) {
                    assertmsg("<dev string:x3a0>" + function_15979fa9(vehicle.vehicletype) + "<dev string:x3c5>");
                }
            #/
            return 0;
        }
        init_rider(ai, vehicle, "gunner1");
        break;
    default:
        var_1ec05361 = function_afd5288e(vehicle);
        if (var_1ec05361 == "none") {
            /#
                if (var_cc2f276a) {
                    assertmsg("<dev string:x3ef>" + function_15979fa9(vehicle.vehicletype) + "<dev string:x412>");
                }
            #/
            return 0;
        }
        init_rider(ai, vehicle, var_1ec05361);
        seat = var_1ec05361;
        break;
    }
    assert(isdefined(ai.var_f96d0a4c));
    assert(isdefined(ai.vehicle));
    if (!isdefined(ai.var_f96d0a4c.rideanim)) {
        assertmsg("<dev string:x44d>" + seat + "<dev string:x18d>" + function_15979fa9(vehicle.vehicletype) + "<dev string:x46e>" + function_b5d876ce(ai, vehicle));
        return;
    }
    assert(isdefined(vehicle.var_3d635c37.riders));
    assert(!isdefined(vehicle.var_3d635c37.riders[seat]));
    vehicle.var_3d635c37.riders[seat] = ai;
    if (seat != "none") {
        function_8872056d(vehicle, seat);
    }
    ai flag::set("in_vehicle");
    ai flag::set("riding_vehicle");
    ai thread animation::play(ai.var_f96d0a4c.rideanim, ai.vehicle, ai.var_f96d0a4c.aligntag, 1, 0.2, 0.2, 0, 0, 0, 0);
    ai thread handle_rider_death(ai, vehicle);
    return 1;
}

// Namespace vehicle/vehicleriders_shared
// Params 2, eflags: 0x4
// Checksum 0x8e484057, Offset: 0x3f80
// Size: 0xdc
function private handle_rider_death(ai, vehicle) {
    ai endon(#"death");
    ai endon(#"exiting_vehicle");
    vehicle endon(#"death");
    assert(isdefined(ai.var_f96d0a4c));
    if (isdefined(ai.var_f96d0a4c.ridedeathanim)) {
        ai animation::set_death_anim(ai.var_f96d0a4c.ridedeathanim);
    }
    callback::on_ai_killed(&function_b23c75b5);
}

// Namespace vehicle/vehicleriders_shared
// Params 1, eflags: 0x4
// Checksum 0xaf7dd475, Offset: 0x4068
// Size: 0xec
function private function_b23c75b5(params) {
    if (self flag::exists("riding_vehicle") && self flag::get("riding_vehicle") && isdefined(self.vehicle) && isdefined(self.var_f96d0a4c) && isdefined(self.var_f96d0a4c.vehicleriderdeathanim)) {
        self.vehicle clientfield::increment(self.var_f96d0a4c.position + "_death", 1);
        self.vehicle setanimknobrestart(self.var_f96d0a4c.vehicleriderdeathanim, 1, 0, 1);
    }
}

// Namespace vehicle/vehicleriders_shared
// Params 0, eflags: 0x4
// Checksum 0x5b89b234, Offset: 0x4160
// Size: 0xa8
function private on_vehicle_killed() {
    if (!isdefined(self.var_3d635c37)) {
        return;
    }
    if (!isdefined(self.var_3d635c37.riders)) {
        return;
    }
    foreach (rider in self.var_3d635c37.riders) {
        kill_rider(rider);
    }
}

// Namespace vehicle/vehicleriders_shared
// Params 1, eflags: 0x0
// Checksum 0xd12e41e0, Offset: 0x4210
// Size: 0x17c
function kill_rider(entity) {
    if (isdefined(entity)) {
        if (isalive(entity) && !gibserverutils::isgibbed(entity, 2)) {
            if (entity isplayinganimscripted()) {
                entity stopanimscripted();
            }
            if (getdvarint(#"tu1_vehicleridersinvincibility", 1)) {
                util::stop_magic_bullet_shield(entity);
            }
            gibserverutils::gibleftarm(entity);
            gibserverutils::gibrightarm(entity);
            gibserverutils::giblegs(entity);
            gibserverutils::annihilate(entity);
            entity unlink();
            entity kill();
        }
        entity ghost();
        level thread delete_rider_asap(entity);
    }
}

// Namespace vehicle/vehicleriders_shared
// Params 1, eflags: 0x0
// Checksum 0x29586c8b, Offset: 0x4398
// Size: 0x2c
function delete_rider_asap(entity) {
    waitframe(1);
    if (isdefined(entity)) {
        entity delete();
    }
}

// Namespace vehicle/vehicleriders_shared
// Params 1, eflags: 0x0
// Checksum 0x6b4b4c6f, Offset: 0x43d0
// Size: 0x2de
function function_67f91f5(seat = "all") {
    assert(isdefined(self) && isvehicle(self) && isdefined(seat));
    ais = [];
    if (!isdefined(self.var_3d635c37)) {
        return ais;
    }
    if (!isdefined(self.var_3d635c37.riders)) {
        return ais;
    }
    if (isdefined(seat)) {
        if (seat == "passengers") {
            seat = "passenger1";
        } else if (seat == "gunners") {
            seat = "gunner1";
        }
        assert(seat == "<dev string:x1fe>" || seat == "<dev string:x205>" || seat == "<dev string:x210>" || seat == "<dev string:x215>" || seat == "<dev string:x21d>");
    } else {
        seat = "all";
    }
    if (isdefined(self.var_3d635c37.riders)) {
        if (seat == "all") {
            foreach (ai in self.var_3d635c37.riders) {
                if (isdefined(ai) && isalive(ai)) {
                    ais[ais.size] = ai;
                }
            }
            return ais;
        } else {
            foreach (ai in self.var_3d635c37.riders) {
                if (isdefined(ai) && isalive(ai) && ai.var_ccc29c03 === seat) {
                    ais[ais.size] = ai;
                }
            }
            return ais;
        }
    }
    return ais;
}

