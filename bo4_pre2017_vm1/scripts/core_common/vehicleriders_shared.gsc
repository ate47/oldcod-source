#using scripts/core_common/ai/systems/gib;
#using scripts/core_common/ai_shared;
#using scripts/core_common/animation_shared;
#using scripts/core_common/array_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/colors_shared;
#using scripts/core_common/flag_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/hostmigration_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/trigger_shared;
#using scripts/core_common/turret_shared;
#using scripts/core_common/util_shared;

#namespace vehicle;

// Namespace vehicle/vehicleriders_shared
// Params 0, eflags: 0x2
// Checksum 0xdc1cbc0f, Offset: 0x460
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("vehicleriders", &__init__, undefined, undefined);
}

// Namespace vehicle/vehicleriders_shared
// Params 0, eflags: 0x0
// Checksum 0x90bbe19e, Offset: 0x4a0
// Size: 0x59c
function __init__() {
    level.var_ca190c08 = [];
    level.var_ca190c08["all"] = "all";
    level.var_ca190c08["driver"] = "driver";
    level.var_ca190c08["passengers"] = "passenger";
    level.var_ca190c08["crew"] = "crew";
    level.var_ca190c08["gunners"] = "gunner";
    a_registered_fields = [];
    foreach (bundle in struct::get_script_bundles("vehicleriders")) {
        foreach (object in bundle.objects) {
            if (isstring(object.vehicleenteranim)) {
                array::add(a_registered_fields, object.position + "_enter", 0);
            }
            if (isstring(object.vehicleexitanim)) {
                array::add(a_registered_fields, object.position + "_exit", 0);
            }
            if (isstring(object.vehiclecloseanim)) {
                array::add(a_registered_fields, object.position + "_close", 0);
            }
            if (isstring(object.vehicleriderdeathanim)) {
                array::add(a_registered_fields, object.position + "_death", 0);
            }
        }
    }
    foreach (str_clientfield in a_registered_fields) {
        clientfield::register("vehicle", str_clientfield, 1, 1, "counter");
    }
    level.var_14c128 = [];
    level.var_14c128["driver"] = 0;
    for (i = 1; i <= 4; i++) {
        level.var_14c128["gunner" + i] = i;
    }
    var_2a391571 = 1;
    for (i = 4 + 1; i <= 10; i++) {
        level.var_14c128["passenger" + var_2a391571] = i;
        var_2a391571++;
    }
    foreach (s in struct::get_script_bundles("vehicleriders")) {
        if (!isdefined(s.var_1b5b8330)) {
            s.var_1b5b8330 = 0;
        }
        if (!isdefined(s.highexitlandheight)) {
            s.highexitlandheight = 32;
        }
    }
    callback::on_vehicle_spawned(&on_vehicle_spawned);
    callback::on_ai_spawned(&on_ai_spawned);
    callback::on_vehicle_killed(&on_vehicle_killed);
}

// Namespace vehicle/vehicleriders_shared
// Params 0, eflags: 0x0
// Checksum 0x6e2eb074, Offset: 0xa48
// Size: 0x14
function on_vehicle_spawned() {
    spawn_riders();
}

// Namespace vehicle/vehicleriders_shared
// Params 0, eflags: 0x0
// Checksum 0xad2c9446, Offset: 0xa68
// Size: 0x34
function on_ai_spawned() {
    if (isvehicle(self)) {
        self spawn_riders();
    }
}

// Namespace vehicle/vehicleriders_shared
// Params 2, eflags: 0x0
// Checksum 0x84805b17, Offset: 0xaa8
// Size: 0x9c
function function_cd99e01f(vh, str_pos) {
    array::add(vh.riders, self, 0);
    vh flagsys::set(str_pos + "occupied");
    self flagsys::set("vehiclerider");
    self thread function_86bcb302(vh, str_pos);
}

// Namespace vehicle/vehicleriders_shared
// Params 2, eflags: 0x0
// Checksum 0x37de682a, Offset: 0xb50
// Size: 0x7c
function function_d3fa882a(vh, str_pos) {
    arrayremovevalue(vh.riders, self);
    vh flagsys::clear(str_pos + "occupied");
    self flagsys::clear("vehiclerider");
}

// Namespace vehicle/vehicleriders_shared
// Params 2, eflags: 0x4
// Checksum 0x6acb3ee9, Offset: 0xbd8
// Size: 0x64
function private function_86bcb302(vh, str_pos) {
    vh endon(#"death");
    vh endon(str_pos + "occupied");
    self waittill("death");
    function_d3fa882a(vh, str_pos);
}

// Namespace vehicle/vehicleriders_shared
// Params 1, eflags: 0x0
// Checksum 0xe7c06f78, Offset: 0xc48
// Size: 0xd2
function function_5a2fe36b(ai) {
    foreach (s_rider in function_45c6f51b(ai).objects) {
        if (!flagsys::get(s_rider.position + "occupied")) {
            return s_rider.position;
        }
    }
}

// Namespace vehicle/vehicleriders_shared
// Params 0, eflags: 0x0
// Checksum 0x4de5d2e5, Offset: 0xd28
// Size: 0x122
function spawn_riders() {
    self endon(#"death");
    self.riders = [];
    if (isdefined(self.script_vehicleride)) {
        a_spawners = getspawnerarray(self.script_vehicleride, "script_vehicleride");
        foreach (sp in a_spawners) {
            ai_rider = sp spawner::spawn(1);
            if (isdefined(ai_rider)) {
                ai_rider get_in(self, ai_rider.script_startingposition, 1);
            }
        }
    }
}

// Namespace vehicle/vehicleriders_shared
// Params 1, eflags: 0x0
// Checksum 0x66f7f8da, Offset: 0xe58
// Size: 0xe4
function function_45c6f51b(ai) {
    vh = self;
    if (isdefined(ai.archetype) && ai.archetype == "robot") {
        bundle = vh get_robot_bundle();
    } else if (isdefined(ai.archetype) && ai.archetype == "warlord") {
        bundle = vh get_warlord_bundle();
    } else {
        bundle = vh get_human_bundle();
    }
    return bundle;
}

// Namespace vehicle/vehicleriders_shared
// Params 2, eflags: 0x0
// Checksum 0x59e2be0, Offset: 0xf48
// Size: 0xfc
function function_eedc9d25(vh, str_pos) {
    if (!isdefined(str_pos)) {
        str_pos = "driver";
    }
    ai = self;
    bundle = undefined;
    bundle = vh function_45c6f51b(ai);
    foreach (s_rider in bundle.objects) {
        if (s_rider.position == str_pos) {
            return s_rider;
        }
    }
}

// Namespace vehicle/vehicleriders_shared
// Params 2, eflags: 0x0
// Checksum 0xf883e928, Offset: 0x1050
// Size: 0x108
function function_6cc185fe(vh, str_archetype) {
    if (!isdefined(str_archetype)) {
        str_archetype = "human";
    }
    if (str_archetype == "robot") {
        bundle = vh get_robot_bundle();
    } else if (str_archetype == "warlord") {
        bundle = vh get_warlord_bundle();
    } else {
        assert(str_archetype == "<dev string:x28>");
        bundle = vh get_human_bundle();
    }
    if (isdefined(bundle) && isdefined(bundle.objects)) {
        return bundle.objects.size;
    }
    return 0;
}

// Namespace vehicle/vehicleriders_shared
// Params 3, eflags: 0x0
// Checksum 0xea820c3a, Offset: 0x1160
// Size: 0x494
function get_in(vh, str_pos, var_b98c3119) {
    if (!isdefined(var_b98c3119)) {
        var_b98c3119 = 1;
    }
    self endon(#"death");
    vh endon(#"death");
    if (!isdefined(str_pos)) {
        str_pos = vh function_5a2fe36b(self);
        assert(isdefined(str_pos), "<dev string:x2e>");
    }
    function_cd99e01f(vh, str_pos);
    if (!var_b98c3119 && self flagsys::get("in_vehicle")) {
        get_out();
    }
    if (colors::is_color_ai()) {
        colors::disable();
    }
    function_ce794bff(vh, str_pos);
    if (!var_b98c3119) {
        self animation::set_death_anim(self.var_1b425382.var_77094522);
        animation::reach(self.var_1b425382.enteranim, self.vehicle, self.var_1b425382.aligntag);
        if (isdefined(self.var_1b425382.vehicleenteranim)) {
            vh clientfield::increment(self.var_1b425382.position + "_enter", 1);
            self setanim(self.var_1b425382.vehicleenteranim, 1, 0, 1);
        }
        self animation::play(self.var_1b425382.enteranim, self.vehicle, self.var_1b425382.aligntag);
    }
    if (isdefined(self.var_1b425382) && isdefined(self.var_1b425382.rideanim)) {
        self thread animation::play(self.var_1b425382.rideanim, self.vehicle, self.var_1b425382.aligntag, 1, 0.2, 0.2, 0, 0, 0, 0);
    } else if (!isdefined(level.var_14c128[str_pos])) {
        assert("<dev string:x55>" + str_pos);
    } else if (isdefined(self.var_1b425382)) {
        v_tag_pos = vh gettagorigin(self.var_1b425382.aligntag);
        v_tag_ang = vh gettagangles(self.var_1b425382.aligntag);
        if (isdefined(v_tag_pos)) {
            self forceteleport(v_tag_pos, v_tag_ang);
        }
    } else {
        errormsg("<dev string:x80>");
    }
    if (isactor(self)) {
        self pathmode("dont move");
        if (isdefined(self.dontdropweapon)) {
            self.var_617fa4c7 = self.dontdropweapon;
        }
        self.disableammodrop = 1;
        self.dontdropweapon = 1;
    }
    if (isdefined(level.var_14c128[str_pos])) {
    }
    self flagsys::set("in_vehicle");
    self thread handle_rider_death();
}

// Namespace vehicle/vehicleriders_shared
// Params 0, eflags: 0x0
// Checksum 0xebb490f7, Offset: 0x1600
// Size: 0x11c
function handle_rider_death() {
    self endon(#"exiting_vehicle");
    self.vehicle endon(#"death");
    if (isdefined(self.var_1b425382.ridedeathanim)) {
        self animation::set_death_anim(self.var_1b425382.ridedeathanim);
    }
    self waittill("death");
    if (!isdefined(self)) {
        return;
    }
    if (isdefined(self.vehicle) && isdefined(self.var_1b425382) && isdefined(self.var_1b425382.vehicleriderdeathanim)) {
        self.vehicle clientfield::increment(self.var_1b425382.position + "_death", 1);
        self.vehicle setanimknobrestart(self.var_1b425382.vehicleriderdeathanim, 1, 0, 1);
    }
}

// Namespace vehicle/vehicleriders_shared
// Params 1, eflags: 0x0
// Checksum 0xb0525c01, Offset: 0x1728
// Size: 0x34
function delete_rider_asap(entity) {
    waitframe(1);
    if (isdefined(entity)) {
        entity delete();
    }
}

// Namespace vehicle/vehicleriders_shared
// Params 1, eflags: 0x0
// Checksum 0x789652dd, Offset: 0x1768
// Size: 0x174
function kill_rider(entity) {
    if (isdefined(entity)) {
        if (isalive(entity) && !gibserverutils::isgibbed(entity, 2)) {
            if (entity isplayinganimscripted()) {
                entity stopanimscripted();
            }
            if (getdvarint("tu1_vehicleRidersInvincibility", 1)) {
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
// Checksum 0xf6f518f, Offset: 0x18e8
// Size: 0xaa
function on_vehicle_killed(params) {
    if (isdefined(self.riders)) {
        foreach (rider in self.riders) {
            kill_rider(rider);
        }
    }
}

// Namespace vehicle/vehicleriders_shared
// Params 2, eflags: 0x0
// Checksum 0xea5162af, Offset: 0x19a0
// Size: 0x15e
function function_293281a2(vh, str_pos) {
    if (vh flagsys::get(str_pos + "occupied")) {
        return false;
    }
    if (anglestoup(vh.angles)[2] < 0.3) {
        return false;
    }
    var_1b425382 = self function_eedc9d25(vh, str_pos);
    v_tag_org = vh gettagorigin(var_1b425382.aligntag);
    v_tag_ang = vh gettagangles(var_1b425382.aligntag);
    var_1a48cfbd = getstartorigin(v_tag_org, v_tag_ang, var_1b425382.enteranim);
    if (!self findpath(self.origin, var_1a48cfbd)) {
        return false;
    }
    return true;
}

// Namespace vehicle/vehicleriders_shared
// Params 1, eflags: 0x0
// Checksum 0x25fc38c8, Offset: 0x1b08
// Size: 0x39a
function get_out(str_mode) {
    ai = self;
    self endon(#"death");
    self notify(#"exiting_vehicle");
    assert(isalive(self), "<dev string:x93>");
    assert(isdefined(self.vehicle), "<dev string:xb4>");
    if (self.vehicle.vehicleclass === "helicopter" || self.vehicle.vehicleclass === "plane") {
        if (!isdefined(str_mode)) {
            str_mode = "variable";
        }
    } else if (!isdefined(str_mode)) {
        str_mode = "ground";
    }
    bundle = self.vehicle function_45c6f51b(ai);
    var_6580426c = bundle.var_1b5b8330;
    if (isdefined(self.var_1b425382.vehicleexitanim)) {
        self.vehicle clientfield::increment(self.var_1b425382.position + "_exit", 1);
        self.vehicle setanim(self.var_1b425382.vehicleexitanim, 1, 0, 1);
    }
    switch (str_mode) {
    case #"ground":
        exit_ground();
        break;
    case #"low":
        function_63b86466();
        break;
    case #"variable":
        exit_variable();
        break;
    default:
        assertmsg("<dev string:xca>");
        break;
    }
    if (isactor(self)) {
        self pathmode("move allowed");
        self.disableammodrop = 0;
        self.dontdropweapon = 0;
        if (isdefined(self.var_617fa4c7)) {
            self.dontdropweapon = self.var_617fa4c7;
            self.var_617fa4c7 = undefined;
        }
    }
    self flagsys::clear("in_vehicle");
    if (isdefined(self.vehicle)) {
        function_d3fa882a(self.vehicle, self.var_1b425382.position);
        if (isdefined(level.var_14c128[self.var_1b425382.position])) {
        }
    }
    self.vehicle = undefined;
    self.var_1b425382 = undefined;
    self animation::set_death_anim(undefined);
    set_goal();
    self notify(#"exited_vehicle");
}

// Namespace vehicle/vehicleriders_shared
// Params 0, eflags: 0x0
// Checksum 0x21a832d0, Offset: 0x1eb0
// Size: 0x5c
function set_goal() {
    if (colors::is_color_ai()) {
        colors::enable();
        return;
    }
    if (!isdefined(self.target)) {
        self setgoal(self.origin);
    }
}

// Namespace vehicle/vehicleriders_shared
// Params 5, eflags: 0x0
// Checksum 0xf78ccef1, Offset: 0x1f18
// Size: 0x464
function unload(str_group, str_mode, var_86f1d254, var_bfe5d67f, var_2df0ea6c) {
    if (!isdefined(str_group)) {
        str_group = "all";
    }
    if (!isdefined(var_86f1d254)) {
        var_86f1d254 = 1;
    }
    if (!isdefined(var_2df0ea6c)) {
        var_2df0ea6c = 1;
    }
    self notify(#"unload", str_group);
    assert(isdefined(level.var_ca190c08[str_group]), str_group + "<dev string:xeb>");
    str_group = level.var_ca190c08[str_group];
    var_3346855c = [];
    foreach (ai_rider in self.riders) {
        if (isalive(ai_rider) && (str_group == "all" || issubstr(ai_rider.var_1b425382.position, str_group))) {
            if (!isalive(ai_rider)) {
                continue;
            }
            ai_rider thread get_out(str_mode);
            if (!isdefined(var_3346855c)) {
                var_3346855c = [];
            } else if (!isarray(var_3346855c)) {
                var_3346855c = array(var_3346855c);
            }
            var_3346855c[var_3346855c.size] = ai_rider;
        }
    }
    var_258ee00c = undefined;
    n_crew_door_close_position = undefined;
    var_636c0540 = undefined;
    if (var_2df0ea6c) {
        foreach (ai_rider in self.riders) {
            if (isdefined(ai_rider) && isdefined(ai_rider.var_1b425382) && isdefined(ai_rider.var_1b425382.vehiclecloseanim)) {
                var_258ee00c = ai_rider.var_1b425382.vehiclecloseanim;
                n_crew_door_close_position = ai_rider.var_1b425382.position;
                break;
            }
        }
    }
    if (var_3346855c.size > 0) {
        array::wait_till(var_3346855c, "exited_vehicle");
        array::flagsys_wait_clear(var_3346855c, "in_vehicle", isdefined(self.unloadtimeout) ? self.unloadtimeout : 4);
        self notify(#"unload", var_3346855c);
        if (var_86f1d254 === 1) {
            remove_riders_after_wait(var_3346855c);
        }
    }
    if (isdefined(var_258ee00c) && isdefined(self) && isalive(self)) {
        self clientfield::increment(n_crew_door_close_position + "_close", 1);
        self setanim(var_258ee00c, 1, 0, 1);
    }
}

// Namespace vehicle/vehicleriders_shared
// Params 1, eflags: 0x0
// Checksum 0x3a886646, Offset: 0x2388
// Size: 0xa2
function remove_riders_after_wait(a_riders_to_remove) {
    if (isdefined(a_riders_to_remove)) {
        foreach (ai in a_riders_to_remove) {
            arrayremovevalue(self.riders, ai);
        }
    }
}

// Namespace vehicle/vehicleriders_shared
// Params 0, eflags: 0x0
// Checksum 0xcaf1e993, Offset: 0x2438
// Size: 0x8a
function ragdoll_dead_exit_rider() {
    self endon(#"exited_vehicle");
    self waittill("death");
    if (isactor(self) && !self isragdoll()) {
        self unlink();
        self startragdoll();
    }
    self notify(#"exited_vehicle");
}

// Namespace vehicle/vehicleriders_shared
// Params 0, eflags: 0x0
// Checksum 0x5e402c72, Offset: 0x24d0
// Size: 0x114
function exit_ground() {
    self animation::set_death_anim(self.var_1b425382.exitgrounddeathanim);
    if (!isdefined(self.var_1b425382.exitgrounddeathanim)) {
        self thread ragdoll_dead_exit_rider();
    }
    assert(isstring(self.var_1b425382.exitgroundanim), "<dev string:x109>" + self.var_1b425382.position + "<dev string:x121>");
    if (isstring(self.var_1b425382.exitgroundanim)) {
        animation::play(self.var_1b425382.exitgroundanim, self.vehicle, self.var_1b425382.aligntag);
    }
}

// Namespace vehicle/vehicleriders_shared
// Params 0, eflags: 0x0
// Checksum 0x6e9b43fe, Offset: 0x25f0
// Size: 0xb4
function function_63b86466() {
    self animation::set_death_anim(self.var_1b425382.var_24c6bf4e);
    assert(isdefined(self.var_1b425382.var_60cf8622), "<dev string:x109>" + self.var_1b425382.position + "<dev string:x121>");
    animation::play(self.var_1b425382.var_60cf8622, self.vehicle, self.var_1b425382.aligntag);
}

// Namespace vehicle/vehicleriders_shared
// Params 0, eflags: 0x4
// Checksum 0x7962074b, Offset: 0x26b0
// Size: 0x64
function private handle_falling_death() {
    self endon(#"landed");
    self waittill("death");
    if (isactor(self)) {
        self unlink();
        self startragdoll();
    }
}

// Namespace vehicle/vehicleriders_shared
// Params 3, eflags: 0x4
// Checksum 0xda992071, Offset: 0x2720
// Size: 0x18e
function private forward_euler_integration(e_move, v_target_landing, n_initial_speed) {
    landed = 0;
    var_af0234d7 = 0.1;
    position = self.origin;
    velocity = (0, 0, n_initial_speed * -1);
    gravity = (0, 0, -385.8);
    while (!landed) {
        previousposition = position;
        velocity += gravity * var_af0234d7;
        position += velocity * var_af0234d7;
        if (position[2] + velocity[2] * var_af0234d7 <= v_target_landing[2]) {
            landed = 1;
            position = v_target_landing;
        }
        /#
            recordline(previousposition, position, (1, 0.5, 0), "<dev string:x142>", self);
        #/
        hostmigration::waittillhostmigrationdone();
        e_move moveto(position, var_af0234d7);
        if (!landed) {
            wait var_af0234d7;
        }
    }
}

// Namespace vehicle/vehicleriders_shared
// Params 0, eflags: 0x0
// Checksum 0x49aa9e5f, Offset: 0x28b8
// Size: 0x4d4
function exit_variable() {
    ai = self;
    self endon(#"death");
    self notify(#"exiting_vehicle");
    self thread handle_falling_death();
    self animation::set_death_anim(self.var_1b425382.exithighdeathanim);
    assert(isdefined(self.var_1b425382.exithighanim), "<dev string:x109>" + self.var_1b425382.position + "<dev string:x121>");
    animation::play(self.var_1b425382.exithighanim, self.vehicle, self.var_1b425382.aligntag, 1, 0, 0);
    self animation::set_death_anim(self.var_1b425382.exithighloopdeathanim);
    n_cur_height = get_height(self.vehicle);
    bundle = self.vehicle function_45c6f51b(ai);
    n_target_height = bundle.highexitlandheight;
    if (isdefined(self.dropundervehicleoriginoverride) && (isdefined(self.var_1b425382.dropundervehicleorigin) && self.var_1b425382.dropundervehicleorigin || self.dropundervehicleoriginoverride)) {
        v_target_landing = (self.vehicle.origin[0], self.vehicle.origin[1], self.origin[2] - n_cur_height + n_target_height);
    } else {
        v_target_landing = (self.origin[0], self.origin[1], self.origin[2] - n_cur_height + n_target_height);
    }
    if (isdefined(self.overridedropposition)) {
        v_target_landing = (self.overridedropposition[0], self.overridedropposition[1], v_target_landing[2]);
    }
    if (isdefined(self.targetangles)) {
        angles = self.targetangles;
    } else {
        angles = self.angles;
    }
    e_move = util::spawn_model("tag_origin", self.origin, angles);
    self thread exit_high_loop_anim(e_move);
    distance = n_target_height - n_cur_height;
    initialspeed = bundle.dropspeed;
    acceleration = 385.8;
    n_fall_time = (initialspeed * -1 + sqrt(pow(initialspeed, 2) - 2 * acceleration * distance)) / acceleration;
    self notify(#"falling", {#fall_time:n_fall_time});
    forward_euler_integration(e_move, v_target_landing, bundle.dropspeed);
    e_move waittill("movedone");
    self notify(#"landing");
    self animation::set_death_anim(self.var_1b425382.exithighlanddeathanim);
    animation::play(self.var_1b425382.exithighlandanim, e_move, "tag_origin");
    self notify(#"landed");
    self unlink();
    waitframe(1);
    e_move delete();
}

// Namespace vehicle/vehicleriders_shared
// Params 1, eflags: 0x0
// Checksum 0x94bae6b2, Offset: 0x2d98
// Size: 0x60
function exit_high_loop_anim(e_parent) {
    self endon(#"death");
    self endon(#"landing");
    while (true) {
        animation::play(self.var_1b425382.exithighloopanim, e_parent, "tag_origin");
    }
}

// Namespace vehicle/vehicleriders_shared
// Params 1, eflags: 0x0
// Checksum 0x2a44d603, Offset: 0x2e00
// Size: 0xea
function get_height(e_ignore) {
    if (!isdefined(e_ignore)) {
        e_ignore = self;
    }
    trace = groundtrace(self.origin + (0, 0, 10), self.origin + (0, 0, -10000), 0, e_ignore, 0);
    /#
        recordline(self.origin + (0, 0, 10), trace["<dev string:x14d>"], (1, 0.5, 0), "<dev string:x142>", self);
    #/
    return distance(self.origin, trace["position"]);
}

// Namespace vehicle/vehicleriders_shared
// Params 1, eflags: 0x0
// Checksum 0x6d2094d3, Offset: 0x2ef8
// Size: 0x72
function get_human_bundle(assertifneeded) {
    if (!isdefined(assertifneeded)) {
        assertifneeded = 1;
    }
    if (assertifneeded) {
        assert(isdefined(self.vehicleridersbundle), "<dev string:x156>");
    }
    return struct::get_script_bundle("vehicleriders", self.vehicleridersbundle);
}

// Namespace vehicle/vehicleriders_shared
// Params 1, eflags: 0x0
// Checksum 0xee025a3c, Offset: 0x2f78
// Size: 0x72
function get_robot_bundle(assertifneeded) {
    if (!isdefined(assertifneeded)) {
        assertifneeded = 1;
    }
    if (assertifneeded) {
        assert(isdefined(self.vehicleridersrobotbundle), "<dev string:x1a7>");
    }
    return struct::get_script_bundle("vehicleriders", self.vehicleridersrobotbundle);
}

// Namespace vehicle/vehicleriders_shared
// Params 1, eflags: 0x0
// Checksum 0xa10e69f8, Offset: 0x2ff8
// Size: 0x72
function get_warlord_bundle(assertifneeded) {
    if (!isdefined(assertifneeded)) {
        assertifneeded = 1;
    }
    if (assertifneeded) {
        assert(isdefined(self.vehicleriderswarlordbundle), "<dev string:x1fe>");
    }
    return struct::get_script_bundle("vehicleriders", self.vehicleriderswarlordbundle);
}

// Namespace vehicle/vehicleriders_shared
// Params 1, eflags: 0x0
// Checksum 0x208dd30f, Offset: 0x3078
// Size: 0xc0
function function_ad4ec07a(str_pos) {
    if (isdefined(self.riders)) {
        foreach (ai in self.riders) {
            if (isdefined(ai) && ai.var_1b425382.position == str_pos) {
                return ai;
            }
        }
    }
}

// Namespace vehicle/vehicleriders_shared
// Params 1, eflags: 0x0
// Checksum 0xb3627f17, Offset: 0x3140
// Size: 0x218
function fill_riders(a_ai) {
    a_ai_remaining = arraycopy(a_ai);
    do {
        var_159d6b20 = 0;
        if (!isalive(self)) {
            return;
        }
        foreach (ai in a_ai_remaining) {
            if (ai.archetype == "human" || ai.archetype == "human_riotshield" || ai.archetype == "human_rpg" || isdefined(ai.archetype) && ai.archetype == "civilian") {
                str_pos = self function_5a2fe36b(ai);
                if (isdefined(str_pos)) {
                    ai get_in(self, str_pos, 1);
                    arrayremovevalue(a_ai_remaining, ai);
                    var_159d6b20 = 1;
                    break;
                }
            }
        }
    } while (var_159d6b20);
    if (isdefined(self.turretweapon) && self.turretweapon !== getweapon("none")) {
        self thread enable_turrets();
    }
    return a_ai_remaining;
}

// Namespace vehicle/vehicleriders_shared
// Params 0, eflags: 0x4
// Checksum 0x4ff3beaa, Offset: 0x3360
// Size: 0xfc
function private enable_turrets() {
    if (isalive(self)) {
        self turret::enable(1);
        self turret::enable(2);
        self turret::enable(3);
        self turret::enable(4);
        self turret::disable_ai_getoff(1, 1);
        self turret::disable_ai_getoff(2, 1);
        self turret::disable_ai_getoff(3, 1);
        self turret::disable_ai_getoff(4, 1);
    }
}

// Namespace vehicle/vehicleriders_shared
// Params 2, eflags: 0x4
// Checksum 0x2ba377f7, Offset: 0x3468
// Size: 0x204
function private function_ce794bff(vh, str_pos) {
    assert(isdefined(self.vehicle) || isdefined(vh), "<dev string:x257>");
    assert(isdefined(self.var_1b425382) || isdefined(str_pos), "<dev string:x277>");
    if (isdefined(vh)) {
        self.vehicle = vh;
    }
    if (!isdefined(str_pos)) {
        str_pos = self.var_1b425382.position;
    }
    self.var_1b425382 = self function_eedc9d25(self.vehicle, str_pos);
    if (isdefined(self.var_1b425382.rideanim) && !isanimlooping(self.var_1b425382.rideanim)) {
        assertmsg("<dev string:x298>" + str_pos + "<dev string:x2bb>" + self.vehicle.vehicletype + "<dev string:x2c9>");
    }
    if (isdefined(self.var_1b425382.aligntag) && !isdefined(self.vehicle gettagorigin(self.var_1b425382.aligntag))) {
        assertmsg("<dev string:x298>" + str_pos + "<dev string:x2bb>" + self.vehicle.vehicletype + "<dev string:x2e2>" + self.var_1b425382.aligntag + "<dev string:x2f5>");
    }
}

