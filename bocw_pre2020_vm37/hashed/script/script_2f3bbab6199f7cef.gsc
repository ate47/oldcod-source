#using script_1160d62024d6945b;
#using script_40fc784c60f9fa7b;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\death_circle;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_death_shared;
#using scripts\core_common\vehicle_shared;

#namespace namespace_d916460b;

// Namespace namespace_d916460b/namespace_d916460b
// Params 0, eflags: 0x6
// Checksum 0x6bfc9b74, Offset: 0x380
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"hash_2d940adae179fd01", &function_70a657d8, undefined, undefined, #"player_vehicle");
}

// Namespace namespace_d916460b/namespace_d916460b
// Params 0, eflags: 0x5 linked
// Checksum 0xfdf783f3, Offset: 0x3d0
// Size: 0x5c
function private function_70a657d8() {
    vehicle::add_main_callback("helicopter_light", &function_aa9ec3fb);
    clientfield::register("scriptmover", "deathfx", 1, 1, "int");
}

// Namespace namespace_d916460b/namespace_d916460b
// Params 0, eflags: 0x5 linked
// Checksum 0xdc6238e7, Offset: 0x438
// Size: 0x50e
function private function_aa9ec3fb() {
    self.death_type = "gibbed";
    self.var_18a9fdc = &function_32607cfc;
    self.var_96c0f900[2] = 1000;
    self.var_96c0f900[1] = 1000;
    if (!isdefined(self) || function_3132f113(self)) {
        return;
    }
    callback::function_d8abfc3d(#"hash_666d48a558881a36", &function_87a5feec);
    callback::function_d8abfc3d(#"hash_55f29e0747697500", &function_4a0470a0);
    callback::function_d8abfc3d(#"hash_2c1cafe2a67dfef8", &function_44587f1e);
    self player_vehicle::function_bc79899e();
    self vehicle_ai::get_state_callbacks("off").enter_func = &function_92270eeb;
    self vehicle_ai::get_state_callbacks("off").exit_func = &function_365e033d;
    self vehicle_ai::get_state_callbacks("death").update_func = &function_4b5646b1;
    self vehicle_ai::add_state("spiral", &function_1f014f43, &function_2e3fb54c, &function_aaa84ac);
    self vehicle_ai::add_state("recovery", &function_d344c3f, &function_e291246d, &function_ad15f5e8);
    self vehicle_ai::add_state("water_landing", &function_976267bc, &function_eadfd579, &function_e13c4d09);
    self vehicle_ai::add_state("landing", &function_200c3bd0, &function_3a7426cf, &function_3b1d3bf1);
    self vehicle_ai::add_state("landed", &function_d39845f, &function_b705c816, &function_7db28345);
    self vehicle_ai::function_b94a7666("driving", "exit_vehicle");
    self vehicle_ai::function_b94a7666("off", "enter_vehicle");
    self vehicle_ai::add_interrupt_connection("landing", "driving", "enter_vehicle", &vehicle_ai::function_329f45a4);
    self vehicle_ai::add_interrupt_connection("off", "landed", "enter_vehicle", &vehicle_ai::function_329f45a4);
    self vehicle_ai::add_interrupt_connection("off", "landed", "heli_emp_done", &vehicle_ai::function_329f45a4);
    self vehicle_ai::add_interrupt_connection("landed", "off", "exit_vehicle", &function_a1fd6110);
    self thread function_b0dd571a();
    self thread function_638d1ade();
    self callback::on_vehicle_collision(&function_4885ce1);
    self thread player_vehicle::function_5bce3f3a(2, 1000);
    self thread player_vehicle::function_5bce3f3a(1, 1000);
    self.is_staircase_up = &function_4e74bed7;
    self.var_1b8798f0 = 1;
    self.var_93dc9da9 = "veh_heli_wall_imp";
}

// Namespace namespace_d916460b/namespace_d916460b
// Params 4, eflags: 0x5 linked
// Checksum 0x78e5ab3b, Offset: 0x950
// Size: 0x44
function private function_a1fd6110(current_state, to_state, connection, params) {
    return !vehicle_ai::function_329f45a4(current_state, to_state, connection, params);
}

// Namespace namespace_d916460b/namespace_d916460b
// Params 0, eflags: 0x5 linked
// Checksum 0xdcd97504, Offset: 0x9a0
// Size: 0x1ba
function private function_b0dd571a() {
    self endon(#"death");
    self waittill(#"enter_vehicle");
    offset = getdvarint(#"hash_626d3139a5fd29ca", -70);
    while (true) {
        waterheight = getwaterheight(self.origin, 100, -10000);
        if (waterheight != -131072) {
            var_19dbcac7 = self.origin[2] + offset - waterheight;
            if (var_19dbcac7 <= 0) {
                if (self getspeedmph() > 40) {
                    self dodamage(self.health, self.origin, undefined, undefined, "", "MOD_IMPACT");
                } else {
                    self vehicle_ai::set_state("water_landing");
                }
            }
            if (var_19dbcac7 < 1000) {
                wait 0.25;
            } else if (var_19dbcac7 < 2000) {
                wait 1;
            } else {
                time = math::clamp(int(var_19dbcac7 / 1000), 1, 5);
                wait time;
            }
            continue;
        }
        wait 2;
    }
}

// Namespace namespace_d916460b/namespace_d916460b
// Params 0, eflags: 0x5 linked
// Checksum 0xde51dc81, Offset: 0xb68
// Size: 0x164
function private function_638d1ade() {
    self endon(#"death", #"hash_41dbbf5434aab9e0");
    while (true) {
        if (death_circle::is_active()) {
            var_86eedc = death_circle::function_f8dae197() <= 4298;
            if (death_circle::function_65cb78e7(self.origin) > 0 || var_86eedc) {
                if (var_86eedc) {
                    self.var_1ba362d5 = 1;
                    state = self vehicle_ai::get_current_state();
                    if (state === "off" || state === "landed") {
                        self function_41a269b3();
                    }
                }
                if (!isdefined(self.var_8382289e)) {
                    self function_b8c2b27d();
                }
            } else if (isdefined(self.var_8382289e)) {
                self function_f11207a9();
            }
            wait 0.1;
            continue;
        }
        wait 1;
    }
}

// Namespace namespace_d916460b/namespace_d916460b
// Params 0, eflags: 0x5 linked
// Checksum 0xfdc8b14f, Offset: 0xcd8
// Size: 0x7c
function private function_b8c2b27d() {
    self function_56ee2902(1);
    self clientfield::set("update_malfunction", 1);
    self clientfield::set("flickerlights", 2);
    self.var_8382289e = gettime();
    self thread function_f46dd7b0();
}

// Namespace namespace_d916460b/namespace_d916460b
// Params 0, eflags: 0x5 linked
// Checksum 0xdf0ee8bf, Offset: 0xd60
// Size: 0x4c
function private function_f11207a9() {
    self endon(#"death");
    self.var_8382289e = undefined;
    self notify(#"cancel_malfunction");
    self function_260f32b3(1);
}

// Namespace namespace_d916460b/namespace_d916460b
// Params 0, eflags: 0x5 linked
// Checksum 0xf0fb7df, Offset: 0xdb8
// Size: 0xfc
function private function_dae7aaf3() {
    self takeplayercontrol();
    self clientfield::set("update_malfunction", 2);
    self thread function_82224f4b(1600);
    self setrotorspeed(0.7);
    if (self vehicle_ai::get_current_state() === "landed") {
        self.var_b3e4af16 = 1;
    }
    self clientfield::set("flickerlights", 3);
    self function_a98ae5fe();
    self function_56ee2902(2);
}

// Namespace namespace_d916460b/namespace_d916460b
// Params 1, eflags: 0x5 linked
// Checksum 0x40545d44, Offset: 0xec0
// Size: 0x1b4
function private function_260f32b3(exit = 0) {
    self notify(#"cancel_acceleration");
    if (!is_true(self.emped) && !is_true(self.jammed)) {
        if (self vehicle_ai::get_current_state() === "landed") {
            self.var_b3e4af16 = undefined;
        } else {
            self returnplayercontrol();
        }
        if (self vehicle_ai::function_329f45a4()) {
            self setrotorspeed(1);
        }
    }
    if (exit) {
        self function_56ee2902(0);
        self clientfield::set("update_malfunction", 0);
        self clientfield::set("flickerlights", 3);
        self function_2418736c();
        return;
    }
    self function_56ee2902(1);
    self clientfield::set("update_malfunction", 1);
    self clientfield::set("flickerlights", 2);
}

// Namespace namespace_d916460b/namespace_d916460b
// Params 0, eflags: 0x5 linked
// Checksum 0x464b0647, Offset: 0x1080
// Size: 0x120
function private function_8bb6a990() {
    self endon(#"death", #"cancel_malfunction", #"hash_3c7ae83e462fe4e2", #"pilot_exit", #"hash_41dbbf5434aab9e0");
    wait 5;
    self clientfield::set("flickerlights", 2);
    while (true) {
        self function_dae7aaf3();
        wait randomfloatrange(1, 3);
        self function_260f32b3();
        self clientfield::set("flickerlights", 2);
        wait randomfloatrange(3, 10);
    }
}

// Namespace namespace_d916460b/namespace_d916460b
// Params 0, eflags: 0x5 linked
// Checksum 0x4273712c, Offset: 0x11a8
// Size: 0x214
function private function_f46dd7b0() {
    self notify("59c60bc9614e2852");
    self endon("59c60bc9614e2852");
    self endon(#"death", #"cancel_malfunction", #"hash_41dbbf5434aab9e0");
    if (vehicle_ai::function_329f45a4()) {
        self thread function_8bb6a990();
    } else {
        self waittill(#"pilot_enter");
    }
    shutdowntime = gettime() + 30000;
    while (true) {
        if (gettime() < shutdowntime) {
            wait 0.5;
            continue;
        }
        self function_a98ae5fe();
        state = self vehicle_ai::get_current_state();
        if (state === "off") {
            self function_41a269b3();
        } else if (state === "landed") {
            params = spawnstruct();
            params.makeunusable = 1;
            self vehicle_ai::set_state("off", params);
        } else {
            self.var_4e76046a = 1;
            self.var_d271cf82 = 1;
            self function_56ee2902(2);
            params = spawnstruct();
            params.var_52c5850b = 60;
            self vehicle_ai::set_state("spiral", params);
        }
        self notify(#"hash_41dbbf5434aab9e0");
        return;
    }
}

// Namespace namespace_d916460b/namespace_d916460b
// Params 1, eflags: 0x1 linked
// Checksum 0x599189aa, Offset: 0x13c8
// Size: 0xc8
function function_56ee2902(state) {
    foreach (occupant in self getvehoccupants()) {
        if (!isplayer(occupant)) {
            continue;
        }
        occupant clientfield::set_player_uimodel("vehicle.malfunction", state);
    }
}

// Namespace namespace_d916460b/namespace_d916460b
// Params 1, eflags: 0x1 linked
// Checksum 0xd2f16041, Offset: 0x1498
// Size: 0xd6
function function_82224f4b(scale) {
    self notify("5d19522423d348fb");
    self endon("5d19522423d348fb");
    self endon(#"death", #"cancel_malfunction", #"cancel_acceleration", #"hash_41dbbf5434aab9e0");
    while (true) {
        accel = anglestoup(self.angles) * scale;
        self setphysacceleration((accel[0], accel[1], -200));
        waitframe(1);
    }
}

// Namespace namespace_d916460b/namespace_d916460b
// Params 0, eflags: 0x5 linked
// Checksum 0xcb5ad0a2, Offset: 0x1578
// Size: 0x74
function private function_2418736c() {
    groups = 3;
    if (self vehicle_ai::function_329f45a4()) {
        groups = 4;
    }
    for (group = 1; group <= groups; group++) {
        self vehicle::toggle_lights_group(group, 1);
    }
}

// Namespace namespace_d916460b/namespace_d916460b
// Params 0, eflags: 0x5 linked
// Checksum 0xb2abf8f5, Offset: 0x15f8
// Size: 0x64
function private function_a98ae5fe() {
    self clientfield::set("flickerlights", 3);
    for (group = 1; group <= 4; group++) {
        self vehicle::toggle_lights_group(group, 0);
    }
}

// Namespace namespace_d916460b/namespace_d916460b
// Params 2, eflags: 0x5 linked
// Checksum 0xf3563b66, Offset: 0x1668
// Size: 0x8c
function private function_2ba6be18(player, eventstruct) {
    seatindex = eventstruct.seat_index;
    if (seatindex === 0) {
        self function_b985a0f1(player);
    }
    if (isdefined(self.var_8382289e)) {
        self function_56ee2902(1);
    }
    player setsunshadowsplitdistance(6000);
}

// Namespace namespace_d916460b/namespace_d916460b
// Params 2, eflags: 0x5 linked
// Checksum 0xc34883e7, Offset: 0x1700
// Size: 0x8c
function private function_3af01392(player, eventstruct) {
    seatindex = eventstruct.seat_index;
    oldseatindex = eventstruct.old_seat_index;
    if (oldseatindex === 0) {
        self function_2205f6bf(player);
        return;
    }
    if (seatindex === 0) {
        self function_b985a0f1(player);
    }
}

// Namespace namespace_d916460b/namespace_d916460b
// Params 2, eflags: 0x5 linked
// Checksum 0x83655ecd, Offset: 0x1798
// Size: 0x84
function private function_ff490dad(player, eventstruct) {
    seatindex = eventstruct.seat_index;
    if (seatindex === 0) {
        self function_2205f6bf(player);
    }
    player clientfield::set_player_uimodel("vehicle.malfunction", 0);
    player setsunshadowsplitdistance(0);
}

// Namespace namespace_d916460b/namespace_d916460b
// Params 1, eflags: 0x5 linked
// Checksum 0xebadd5aa, Offset: 0x1828
// Size: 0x6c
function private function_b985a0f1(player) {
    self notify(#"pilot_enter");
    self setheliheightcap(1);
    if (isdefined(self.var_8382289e)) {
        self thread function_8bb6a990();
    }
    self thread function_ab36338c(player);
}

// Namespace namespace_d916460b/namespace_d916460b
// Params 1, eflags: 0x5 linked
// Checksum 0x2eb25991, Offset: 0x18a0
// Size: 0xc4
function private function_2205f6bf(*player) {
    state = self vehicle_ai::get_current_state();
    self notify(#"hash_3c7ae83e462fe4e2");
    self notify(#"pilot_exit");
    if (state === "landed" || state === "off" || state === "death") {
        return;
    }
    if (state === "spiral") {
        self.var_4e76046a = 1;
        return;
    }
    self function_d929b41();
}

// Namespace namespace_d916460b/namespace_d916460b
// Params 1, eflags: 0x1 linked
// Checksum 0xbc1aeb2d, Offset: 0x1970
// Size: 0x54
function function_87a5feec(params) {
    player = params.player;
    eventstruct = params.eventstruct;
    self function_2ba6be18(player, eventstruct);
}

// Namespace namespace_d916460b/namespace_d916460b
// Params 1, eflags: 0x1 linked
// Checksum 0xfdfedaba, Offset: 0x19d0
// Size: 0x54
function function_4a0470a0(params) {
    player = params.player;
    eventstruct = params.eventstruct;
    self function_ff490dad(player, eventstruct);
}

// Namespace namespace_d916460b/namespace_d916460b
// Params 1, eflags: 0x1 linked
// Checksum 0x20328faa, Offset: 0x1a30
// Size: 0x54
function function_44587f1e(params) {
    player = params.player;
    eventstruct = params.eventstruct;
    self function_3af01392(player, eventstruct);
}

// Namespace namespace_d916460b/namespace_d916460b
// Params 1, eflags: 0x5 linked
// Checksum 0xf72e43aa, Offset: 0x1a90
// Size: 0x74
function private function_ab36338c(player) {
    self endon(#"death");
    player endon(#"exit_vehicle", #"change_seat");
    player waittill(#"disconnect");
    self function_2205f6bf(player);
}

// Namespace namespace_d916460b/namespace_d916460b
// Params 3, eflags: 0x1 linked
// Checksum 0xeb5f6a4c, Offset: 0x1b10
// Size: 0x2b4
function function_6c8cff7e(normal, origin = self.origin, offset = 0) {
    self notify("7423b703d5be89c7");
    self endon("7423b703d5be89c7");
    self endon(#"death", #"hash_7f30c56005fe2b32");
    if (!isdefined(normal)) {
        return 0;
    }
    if (isdefined(self.rotatemover)) {
        self.rotatemover delete();
        self.rotatemover = undefined;
    }
    self.rotatemover = spawn("script_model", origin);
    self.rotatemover.targetname = "heli_rotatemover";
    if (isdefined(self.rotatemover)) {
        self.rotatemover thread player_vehicle::deletemeonnotify(self, "death");
        self.rotatemover.angles = self.angles;
        targetangles = function_c1fa62a2(self.rotatemover.angles, normal);
        self linkto(self.rotatemover);
        self.rotatemover rotateto(targetangles, 0.5, 0, 0.5);
        self.rotatemover moveto(origin + (0, 0, offset), 0.5, 0, 0.5);
        self.rotatemover waittill(#"rotatedone");
        self.rotatemover delete();
        self.rotatemover = undefined;
    }
    self setvehvelocity((0, 0, 0));
    self setangularvelocity((0, 0, 0));
    self setphysacceleration((0, 0, 0));
    self sethoverparams(0);
    self setgoal(self.origin, 1, 0);
}

// Namespace namespace_d916460b/namespace_d916460b
// Params 0, eflags: 0x5 linked
// Checksum 0x85b198c1, Offset: 0x1dd0
// Size: 0x2a
function private function_f4d358df() {
    self.var_c1764af8 = 0;
    self.var_4dab0a63 = 0;
    self.var_67136cb0 = undefined;
    self.var_6fac6f50 = undefined;
}

// Namespace namespace_d916460b/namespace_d916460b
// Params 0, eflags: 0x5 linked
// Checksum 0x4f680b98, Offset: 0x1e08
// Size: 0x194
function private function_d929b41() {
    self.var_4dab0a63 = 0;
    speed = self getspeedmph();
    heighttrace = physicstrace(self.origin, self.origin - (0, 0, 1536), (0, 0, 0), (0, 0, 0), self, 2);
    if (speed < 15 && heighttrace[#"fraction"] < 0.260417) {
        self.var_4dab0a63 = 1;
        self.var_c1764af8 = 1;
        self vehicle_ai::set_state("landing");
        return;
    }
    if (speed < 80 && heighttrace[#"fraction"] < 1) {
        self.var_c1764af8 = 1;
        params = spawnstruct();
        params.var_6249a386 = 1;
        self vehicle_ai::set_state("spiral", params);
        return;
    }
    self.var_4e76046a = 1;
    self vehicle_ai::set_state("spiral");
}

// Namespace namespace_d916460b/namespace_d916460b
// Params 0, eflags: 0x5 linked
// Checksum 0x7e066186, Offset: 0x1fa8
// Size: 0x10c
function private function_3b841f4() {
    heighttrace = physicstrace(self.origin, self.origin - (0, 0, 1536), (0, 0, 0), (0, 0, 0), self, 2);
    if (heighttrace[#"fraction"] >= 1) {
        self.var_4e76046a = 1;
        self vehicle_ai::set_state("spiral");
        return;
    }
    if (heighttrace[#"fraction"] > 0.260417) {
        self.var_c1764af8 = 1;
        params = spawnstruct();
        params.var_6249a386 = 1;
        self vehicle_ai::set_state("spiral", params);
    }
}

// Namespace namespace_d916460b/namespace_d916460b
// Params 1, eflags: 0x5 linked
// Checksum 0xc4e99144, Offset: 0x20c0
// Size: 0x1cc
function private function_92270eeb(params) {
    self setvehvelocity((0, 0, 0));
    self setangularvelocity((0, 0, 0));
    self setphysacceleration((0, 0, 0));
    self sethoverparams(0);
    self setgoal(self.origin, 1, 0);
    self setrotorspeed(0);
    if (is_true(params.makeunusable) || is_true(self.var_1ba362d5)) {
        self function_41a269b3();
    }
    self vehicle::toggle_tread_fx(0);
    self vehicle::toggle_exhaust_fx(0);
    self vehicle::toggle_sounds(0);
    self vehicle::function_bbc1d940(0);
    self disableaimassist();
    vehicle_ai::turnoffallambientanims();
    vehicle_ai::clearalllookingandtargeting();
    vehicle_ai::clearallmovement();
    if (!is_true(params.isinitialstate)) {
        self vehicle::function_7f0bbde3();
    }
}

// Namespace namespace_d916460b/namespace_d916460b
// Params 1, eflags: 0x5 linked
// Checksum 0xfe64765c, Offset: 0x2298
// Size: 0x15c
function private function_365e033d(params) {
    params.var_32a85fa1 = 2;
    params.var_1751c737 = 1;
    params.var_da88902a = 1;
    params.var_30a04b16 = 1;
    self vehicle::toggle_tread_fx(1);
    self vehicle::toggle_exhaust_fx(1);
    self thread vehicle::function_fa4236af(params);
    self enableaimassist();
    self setphysacceleration((0, 0, 0));
    self thread vehicle_ai::nudge_collision();
    self setrotorspeed(1);
    if (isdefined(level.enable_thermal)) {
        if (self vehicle_ai::get_next_state() !== "death") {
            [[ level.enable_thermal ]]();
        }
    }
    if (!is_true(self.nolights)) {
        self vehicle::lights_on();
    }
}

// Namespace namespace_d916460b/namespace_d916460b
// Params 1, eflags: 0x5 linked
// Checksum 0x7ad43be, Offset: 0x2400
// Size: 0x264
function private function_4b5646b1(params) {
    self endon(#"death");
    if (isdefined(level.vehicle_destructer_cb)) {
        [[ level.vehicle_destructer_cb ]](self);
    }
    self vehicle_death::death_fx();
    self thread vehicle_death::death_radius_damage("MOD_EXPLOSIVE", params.attacker);
    self vehicle::do_death_dynents();
    self notsolid();
    self ghost();
    if (isdefined(self.deathmodel)) {
        if (!isdefined(level.var_82eb1dab)) {
            level.var_82eb1dab = [];
        }
        util::wait_network_frame();
        deathmodel = spawn("script_model", self.origin);
        deathmodel.targetname = "heli_deathmodel";
        deathmodel setmodel(self.deathmodel);
        deathmodel.angles = self.angles;
        deathmodel physicslaunch((0, 0, 0), self getvelocity() * 0.8);
        deathmodel clientfield::set("deathfx", 1);
        if (!isdefined(level.var_82eb1dab)) {
            level.var_82eb1dab = [];
        } else if (!isarray(level.var_82eb1dab)) {
            level.var_82eb1dab = array(level.var_82eb1dab);
        }
        level.var_82eb1dab[level.var_82eb1dab.size] = deathmodel;
        self namespace_d0eacb0d::function_2265d46b(deathmodel);
    }
    vehicle_death::deletewhensafe();
}

// Namespace namespace_d916460b/namespace_d916460b
// Params 1, eflags: 0x1 linked
// Checksum 0x64b8417d, Offset: 0x2670
// Size: 0x10c
function function_976267bc(*params) {
    self takeplayercontrol();
    self setphysacceleration((0, 0, -100));
    self setvehvelocity((0, 0, 0));
    self setangularvelocity((0, 0, 0));
    self.var_4e76046a = 0;
    self function_41a269b3();
    self.takedamage = 0;
    self setrotorspeed(0);
    self clientfield::set("stopallfx", 1);
    self clientfield::set("flickerlights", 1);
    self vehicle::toggle_sounds(0);
}

// Namespace namespace_d916460b/namespace_d916460b
// Params 1, eflags: 0x1 linked
// Checksum 0x80d417b0, Offset: 0x2788
// Size: 0xc
function function_eadfd579(*params) {
    
}

// Namespace namespace_d916460b/namespace_d916460b
// Params 1, eflags: 0x1 linked
// Checksum 0xa37e6f2f, Offset: 0x27a0
// Size: 0xc
function function_e13c4d09(*params) {
    
}

// Namespace namespace_d916460b/namespace_d916460b
// Params 1, eflags: 0x1 linked
// Checksum 0x98317283, Offset: 0x27b8
// Size: 0x9c
function function_1f014f43(params) {
    if (!isdefined(params.rotorspeed)) {
        params.rotorspeed = 0.7;
    }
    occupants = self getvehoccupants();
    if (occupants.size == 0) {
        params.var_52c5850b = 60;
    }
    self setrotorspeed(params.rotorspeed);
    self takeplayercontrol();
}

// Namespace namespace_d916460b/namespace_d916460b
// Params 1, eflags: 0x1 linked
// Checksum 0x2642d54c, Offset: 0x2860
// Size: 0x35e
function function_2e3fb54c(params) {
    self endon(#"change_state", #"death");
    if (!isdefined(params.var_52c5850b)) {
        params.var_52c5850b = 25;
    }
    if (is_true(params.var_6249a386)) {
        params.var_746f2b2f = 1;
        params.var_96a3f4c7 = 1;
    }
    targetyaw = randomintrange(50, 150);
    if (targetyaw % 2 == 0) {
        targetyaw *= -1;
    }
    pitch = 0;
    roll = 0;
    yaw = 0;
    if (!is_true(params.var_96a3f4c7)) {
        roll = targetyaw * -1 * randomfloatrange(0.125, 0.25);
    }
    if (!is_true(params.var_746f2b2f)) {
        pitch = abs(targetyaw) * randomfloatrange(0.075, 0.15);
    }
    starttime = gettime();
    while (true) {
        if (abs(yaw) < abs(targetyaw)) {
            yaw = lerpfloat(0, targetyaw, (gettime() - starttime) / 3000);
        }
        if ((pitch || roll) && asin(anglestoup(self.angles)[2]) < 90 - params.var_52c5850b) {
            pitch = 0;
            roll = 0;
        }
        self setangularvelocity((pitch, yaw, roll));
        up = anglestoup(self.angles);
        accel = 1200;
        if (params.var_52c5850b < 45) {
            accel = 1600;
        }
        self setphysacceleration((up[0] * accel, up[1] * accel, -386 * max(0.4, 1.2 - up[2])));
        waitframe(1);
    }
}

// Namespace namespace_d916460b/namespace_d916460b
// Params 1, eflags: 0x1 linked
// Checksum 0x133dd436, Offset: 0x2bc8
// Size: 0xc
function function_aaa84ac(*params) {
    
}

// Namespace namespace_d916460b/namespace_d916460b
// Params 1, eflags: 0x1 linked
// Checksum 0x5b40315e, Offset: 0x2be0
// Size: 0x44
function function_d344c3f(*params) {
    self setrotorspeed(1);
    self takeplayercontrol();
}

// Namespace namespace_d916460b/namespace_d916460b
// Params 1, eflags: 0x1 linked
// Checksum 0x19bb13a8, Offset: 0x2c30
// Size: 0x15a
function function_e291246d(*params) {
    self endon(#"death", #"change_state");
    while (true) {
        pilot = self getseatoccupant(0);
        if (!isdefined(pilot)) {
            self vehicle_ai::set_state("spiral");
            break;
        }
        move = pilot getnormalizedmovement();
        if (pilot vehiclemoveupbuttonpressed() || isdefined(move) && (abs(move[0]) > 0.2 || abs(move[1]) > 0.2)) {
            self.var_4e76046a = undefined;
            self returnplayercontrol();
            self vehicle_ai::set_state("driving");
            break;
        }
        waitframe(1);
    }
}

// Namespace namespace_d916460b/namespace_d916460b
// Params 1, eflags: 0x1 linked
// Checksum 0x11dbe05d, Offset: 0x2d98
// Size: 0xc
function function_ad15f5e8(*params) {
    
}

// Namespace namespace_d916460b/namespace_d916460b
// Params 1, eflags: 0x1 linked
// Checksum 0x88e23fba, Offset: 0x2db0
// Size: 0x74
function function_200c3bd0(*params) {
    self setvehvelocity((0, 0, 0));
    self setangularvelocity((0, 0, 0));
    self setphysacceleration((0, 0, -386));
    self setheliheightcap(1);
}

// Namespace namespace_d916460b/namespace_d916460b
// Params 1, eflags: 0x1 linked
// Checksum 0x6cdfdb92, Offset: 0x2e30
// Size: 0xe8
function function_3a7426cf(*params) {
    self endon(#"change_state", #"death");
    damagetime = gettime() + 15000;
    while (true) {
        wait 0.25;
        if (self function_479389f3()) {
            self vehicle_ai::set_state("landed");
            return;
        } else {
            function_3b841f4();
        }
        if (gettime() > damagetime) {
            self dodamage(250, self.origin, undefined, undefined, "", "MOD_IMPACT");
        }
    }
}

// Namespace namespace_d916460b/namespace_d916460b
// Params 1, eflags: 0x1 linked
// Checksum 0xfc516e83, Offset: 0x2f20
// Size: 0xc
function function_3b1d3bf1(*params) {
    
}

// Namespace namespace_d916460b/namespace_d916460b
// Params 1, eflags: 0x1 linked
// Checksum 0xb83fd951, Offset: 0x2f38
// Size: 0xdc
function function_d39845f(*params) {
    self takeplayercontrol();
    self setvehvelocity((0, 0, 0));
    self setangularvelocity((0, 0, 0));
    self setphysacceleration((0, 0, 0));
    self sethoverparams(0);
    self setgoal(self.origin, 1, 0);
    self thread function_6c8cff7e(self.var_67136cb0, self.helilandingorigin, self.var_6fac6f50);
}

// Namespace namespace_d916460b/namespace_d916460b
// Params 1, eflags: 0x1 linked
// Checksum 0x2c962c84, Offset: 0x3020
// Size: 0x28a
function function_b705c816(params) {
    self endon(#"death", #"state_changed");
    if (!isdefined(params)) {
        params = spawnstruct();
    }
    if (is_true(self.emped) || is_true(self.jammed)) {
        params.var_c1273f91 = 1;
        self vehicle_ai::set_state("off", params);
        return;
    }
    if (self vehicle_ai::get_previous_state() === "off") {
        wait 2;
    }
    while (true) {
        if (is_true(self.emped) || is_true(self.jammed)) {
            params.var_c1273f91 = 1;
            self vehicle_ai::set_state("off", params);
            break;
        }
        if (is_true(self.var_b3e4af16)) {
            waitframe(1);
            continue;
        }
        player = self getseatoccupant(0);
        if (!isdefined(player)) {
            params.no_falling = 1;
            params.var_c1273f91 = 1;
            self vehicle_ai::set_state("off", params);
            break;
        }
        move = player getnormalizedmovement();
        if (player vehiclemoveupbuttonpressed() || isdefined(move) && (abs(move[0]) > 0.2 || abs(move[1]) > 0.2)) {
            self vehicle_ai::set_state("driving");
            break;
        }
        waitframe(1);
    }
}

// Namespace namespace_d916460b/namespace_d916460b
// Params 1, eflags: 0x1 linked
// Checksum 0x9349b4ea, Offset: 0x32b8
// Size: 0xa4
function function_7db28345(*params) {
    if (vehicle_ai::function_329f45a4()) {
        self notify(#"hash_7f30c56005fe2b32");
        self returnplayercontrol();
        if (isdefined(self.rotatemover)) {
            self.rotatemover delete();
            self.rotatemover = undefined;
        }
    }
    self function_f4d358df();
    self setheliheightcap(1);
}

// Namespace namespace_d916460b/namespace_d916460b
// Params 0, eflags: 0x5 linked
// Checksum 0xa878f6b5, Offset: 0x3368
// Size: 0x65a
function private function_479389f3() {
    height = self.height;
    assert(isdefined(self.radius));
    assert(isdefined(self.height));
    var_33a206d0 = [];
    var_33a206d0[#"leftrear"] = self gettagorigin("tag_ground_contact_left_rear");
    var_33a206d0[#"leftmiddle"] = self gettagorigin("tag_ground_contact_left_middle");
    var_33a206d0[#"leftfront"] = self gettagorigin("tag_ground_contact_left_front");
    var_8fc02d3b = [];
    var_8fc02d3b[#"rightrear"] = self gettagorigin("tag_ground_contact_right_rear");
    var_8fc02d3b[#"rightmiddle"] = self gettagorigin("tag_ground_contact_right_middle");
    var_8fc02d3b[#"rightfront"] = self gettagorigin("tag_ground_contact_right_front");
    var_df47b913 = [];
    foreach (tag, origin in var_33a206d0) {
        if (!isdefined(origin)) {
            return false;
        }
        var_df47b913[tag] = physicstrace(origin + (0, 0, 25), origin - (0, 0, 75), (0, 0, 0), (0, 0, 0), self, 2);
    }
    var_dc8469e2 = [];
    foreach (tag, origin in var_8fc02d3b) {
        if (!isdefined(origin)) {
            return false;
        }
        var_dc8469e2[tag] = physicstrace(origin + (0, 0, 25), origin - (0, 0, 75), (0, 0, 0), (0, 0, 0), self, 2);
    }
    var_d643c4fc = 0;
    var_e10b67f7 = [];
    var_b0e8278f = (0, 0, 0);
    avgnormal = (0, 0, 0);
    var_4c962569 = 0;
    foreach (tag, trace in var_df47b913) {
        if (isdefined(trace[#"entity"])) {
            var_d643c4fc = 1;
            continue;
        }
        if (trace[#"fraction"] < 1) {
            var_b0e8278f += var_33a206d0[tag];
            var_4c962569 += trace[#"position"][2] - var_33a206d0[tag][2];
            avgnormal += trace[#"normal"];
            var_e10b67f7[tag] = trace;
        }
    }
    var_d3532cfe = [];
    foreach (tag, trace in var_dc8469e2) {
        if (isdefined(trace[#"entity"])) {
            var_d643c4fc = 1;
            continue;
        }
        if (trace[#"fraction"] < 1) {
            var_b0e8278f += var_8fc02d3b[tag];
            var_4c962569 += trace[#"position"][2] - var_8fc02d3b[tag][2];
            avgnormal += trace[#"normal"];
            var_d3532cfe[tag] = trace;
        }
    }
    if (var_e10b67f7.size > 0 || var_d3532cfe.size > 0) {
        avgnormal /= var_d3532cfe.size + var_e10b67f7.size;
        self.var_eb4e4182 = avgnormal;
    }
    if (avgnormal[2] < 0.94) {
        return false;
    }
    if (var_e10b67f7.size == 0 || var_d3532cfe.size == 0 || var_d3532cfe.size + var_e10b67f7.size < 3) {
        return false;
    }
    if (var_d643c4fc) {
        return false;
    }
    var_4c962569 /= var_d3532cfe.size + var_e10b67f7.size + 1;
    if (var_4c962569 > 20) {
        return false;
    }
    var_b0e8278f /= var_d3532cfe.size + var_e10b67f7.size;
    self.helilandingorigin = var_b0e8278f;
    self.var_6fac6f50 = var_4c962569;
    self.var_67136cb0 = avgnormal;
    return true;
}

// Namespace namespace_d916460b/namespace_d916460b
// Params 1, eflags: 0x5 linked
// Checksum 0xcafd88bf, Offset: 0x39d0
// Size: 0x5cc
function private function_4885ce1(params) {
    if (params.stype === "player") {
        return;
    }
    if (isdefined(params.entity) && isvehicle(params.entity) && params.entity function_dcef0ba1(0) && !params.entity isvehicleseatoccupied(0)) {
        force = vectornormalize(params.entity.origin - self.origin) * 1.2;
        params.entity launchvehicle(force);
    }
    if (is_true(self.var_4e76046a)) {
        self dodamage(self.health, self.origin, undefined, undefined, "", "MOD_IMPACT");
        return;
    }
    if (!is_true(self.var_4dab0a63)) {
        var_1fdf316c = getdvarfloat(#"hash_54a2c2e9555f2e5e", 35);
        var_a7796a79 = getdvarfloat(#"hash_70c1f7e69c442750", 140);
        mindamage = getdvarfloat(#"hash_42dae76d8ea47a8e", 75);
        maxdamage = getdvarfloat(#"hash_55d628640db7ed48", 3000);
        speed = self getspeedmph();
        if (isdefined(params.entity) && isvehicle(params.entity)) {
            var_b219fafb = params.entity getspeedmph();
            if (var_b219fafb > speed) {
                speed = var_b219fafb;
            }
        }
        if (speed > var_1fdf316c) {
            applydamage = mapfloat(var_1fdf316c, var_a7796a79, mindamage, maxdamage, speed);
            normal = params.normal;
            sourceposition = self.origin - 100 * normal;
            if (isdefined(params.entity) && isvehicle(params.entity)) {
                riders = params.entity getvehoccupants();
                if (isdefined(riders) && isdefined(riders[0])) {
                    attacker = riders[0];
                }
            }
            self dodamage(applydamage, sourceposition, attacker);
        }
    }
    state = self vehicle_ai::get_current_state();
    if (state === "driving") {
        player = self getseatoccupant(0);
        if (!isdefined(player) || !player function_6947dde2()) {
            return;
        }
        move = player getnormalizedmovement();
        if (isdefined(move) && (abs(move[0]) > 0.2 || abs(move[1]) > 0.2)) {
            return;
        }
        if (isdefined(params.entity)) {
            return;
        }
        if (self function_479389f3()) {
            self vehicle_ai::set_state("landed", params);
        } else {
            player clientfield::set_player_uimodel("vehicle.invalidLanding", 1);
        }
        return;
    }
    if (state === "landing" || state === "spiral") {
        self function_479389f3();
        if (isdefined(self.var_67136cb0)) {
            self vehicle_ai::set_state("landed");
            return;
        }
        if (isdefined(self.var_eb4e4182)) {
            if (self vehicle_ai::get_current_state() === "spiral") {
                self vehicle_ai::set_state("landing");
            }
            self function_9dd58750();
        }
    }
}

// Namespace namespace_d916460b/namespace_d916460b
// Params 0, eflags: 0x1 linked
// Checksum 0x58cc38e3, Offset: 0x3fa8
// Size: 0xac
function function_9dd58750() {
    if (!isdefined(self.var_eb4e4182)) {
        return;
    }
    if (self.var_eb4e4182[2] < 0.99) {
        verticalspeed = self getvelocity()[2];
        slidemove = (self.var_eb4e4182[0] * 300, self.var_eb4e4182[1] * 300, verticalspeed);
    } else {
        slidemove = (1, 0, 0) * 300;
    }
    self setvehvelocity(slidemove);
}

// Namespace namespace_d916460b/namespace_d916460b
// Params 0, eflags: 0x1 linked
// Checksum 0x980cbb06, Offset: 0x4060
// Size: 0xcc
function function_41a269b3() {
    occupants = self getvehoccupants();
    if (isdefined(occupants) && occupants.size) {
        for (i = 0; i < occupants.size; i++) {
            if (isdefined(occupants[i])) {
                seatidx = self getoccupantseat(occupants[i]);
                if (isdefined(seatidx)) {
                    self usevehicle(occupants[i], seatidx);
                }
            }
        }
    }
    self makevehicleunusable();
}

// Namespace namespace_d916460b/namespace_d916460b
// Params 1, eflags: 0x1 linked
// Checksum 0x41a355c5, Offset: 0x4138
// Size: 0xd0
function function_32607cfc(vehicle) {
    if (isdefined(vehicle) && isdefined(vehicle.settings) && is_true(vehicle.settings.var_2627e80a)) {
        return true;
    }
    /#
        if (getdvarint(#"hash_6a34a21ac687e5ce", 0)) {
            return true;
        }
    #/
    distancetraveled = self stats::get_stat_global(#"distance_traveled_vehicle_air");
    if (!isdefined(distancetraveled)) {
        return false;
    }
    return distancetraveled >= 1647360;
}

// Namespace namespace_d916460b/namespace_d916460b
// Params 1, eflags: 0x1 linked
// Checksum 0x1ffc12dc, Offset: 0x4210
// Size: 0x186
function heli_emp_done(*params) {
    if (isdefined(self)) {
        if (isdefined(level.var_fc1bbaef)) {
            [[ level.var_fc1bbaef ]](self);
        }
        self.abnormal_status.emped = 0;
        self.var_b3e4af16 = undefined;
        self clientfield::set("flickerlights", 3);
        self function_2418736c();
        self vehicle::toggle_emp_fx(0);
        self vehicle_ai::emp_startup_fx();
        self player_vehicle::function_388973e4(0);
        if (vehicle_ai::function_329f45a4()) {
            currentstate = self vehicle_ai::get_current_state();
            if (currentstate === "spiral") {
                if (self vehicle_ai::has_state("recovery")) {
                    self vehicle_ai::set_state("recovery");
                }
            }
        } else {
            self vehicle_ai::set_state("off");
        }
        self notify(#"heli_emp_done");
    }
}

// Namespace namespace_d916460b/namespace_d916460b
// Params 1, eflags: 0x1 linked
// Checksum 0x1f67840c, Offset: 0x43a0
// Size: 0x2c4
function function_4e74bed7(params) {
    self function_a98ae5fe();
    self vehicle::toggle_emp_fx(1);
    self takeplayercontrol();
    self.var_b3e4af16 = 1;
    currentstate = self vehicle_ai::get_current_state();
    if (currentstate === "off") {
    } else {
        if (currentstate === "landed") {
        } else if (currentstate === "spiral") {
            self.var_4e76046a = 1;
        } else {
            self function_d929b41();
        }
        self playsound(#"hash_d6643b88d0186ae");
    }
    self player_vehicle::function_388973e4(1);
    if (!isdefined(self.abnormal_status)) {
        self.abnormal_status = spawnstruct();
    }
    self.abnormal_status.emped = 1;
    self.abnormal_status.attacker = params.param1;
    self.abnormal_status.inflictor = params.param2;
    self vehicle::function_bbc1d940(0);
    if (isdefined(self.settings) && is_true(self.settings.var_2627e80a)) {
        params.var_d8ceeba3 = 0;
        self player_vehicle::function_ef44d420(params);
    }
    time = params.param0;
    assert(isdefined(time));
    util::cooldown("emped_timer", time);
    while (!util::iscooldownready("emped_timer") && isalive(self)) {
        timeleft = max(util::getcooldownleft("emped_timer"), 0.5);
        wait timeleft;
    }
    self heli_emp_done(params);
}

/#

    // Namespace namespace_d916460b/namespace_d916460b
    // Params 0, eflags: 0x0
    // Checksum 0x2c8c8fde, Offset: 0x4670
    // Size: 0x328
    function function_4ead318d() {
        self endon(#"death");
        height = self.height;
        assert(isdefined(self.radius));
        assert(isdefined(self.height));
        while (true) {
            waitframe(1);
            leftrear = self gettagorigin("<dev string:x38>");
            leftmiddle = self gettagorigin("<dev string:x58>");
            leftfront = self gettagorigin("<dev string:x7a>");
            rightrear = self gettagorigin("<dev string:x9b>");
            rightmiddle = self gettagorigin("<dev string:xbc>");
            rightfront = self gettagorigin("<dev string:xdf>");
            if (!isdefined(leftrear)) {
                break;
            }
            line(leftrear + (0, 0, 25), leftrear - (0, 0, 75), (1, 1, 0), 1);
            line(leftmiddle + (0, 0, 25), leftmiddle - (0, 0, 75), (1, 1, 0), 1);
            line(leftfront + (0, 0, 25), leftfront - (0, 0, 75), (1, 1, 0), 1);
            line(rightrear + (0, 0, 25), rightrear - (0, 0, 75), (1, 1, 0), 1);
            line(rightmiddle + (0, 0, 25), rightmiddle - (0, 0, 75), (1, 1, 0), 1);
            line(rightfront + (0, 0, 25), rightfront - (0, 0, 75), (1, 1, 0), 1);
        }
    }

#/
