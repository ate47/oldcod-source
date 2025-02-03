#using script_1160d62024d6945b;
#using script_40fc784c60f9fa7b;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\death_circle;
#using scripts\core_common\math_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_death_shared;
#using scripts\core_common\vehicle_shared;

#namespace namespace_c8fb02a7;

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x0
// Checksum 0x211b3ad5, Offset: 0x218
// Size: 0x204
function function_a01726dd() {
    self.var_d6691161 = 3000;
    self.var_5002d77c = 0.7;
    self.var_56b349b4 = 0;
    self.var_cd4099ea = 0;
    self.var_38800c0 = 1;
    self.var_c82ffc5e = 0;
    self.rotor_radius = 380;
    self.var_f3652bd = "tag_main_rotor";
    self setheliheightcap(1);
    callback::function_d8abfc3d(#"hash_666d48a558881a36", &function_1435d6c2);
    callback::function_d8abfc3d(#"hash_666d48a558881a36", &function_6ad9ed56);
    callback::function_d8abfc3d(#"hash_2c1cafe2a67dfef8", &function_6ad9ed56);
    callback::function_d8abfc3d(#"hash_2c1cafe2a67dfef8", &function_b515cb89);
    callback::function_d8abfc3d(#"hash_55f29e0747697500", &function_6258a76c);
    self callback::on_vehicle_collision(&function_adbcb48d);
    self.overridevehiclekilled = &function_f7f4dbf0;
    self thread function_97305c79();
    self thread function_d6742832();
    self thread function_638d1ade();
    self thread function_4f8aa02d();
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 1, eflags: 0x4
// Checksum 0x355aeaf5, Offset: 0x428
// Size: 0x374
function private function_727338d1(triggerstruct) {
    victim = triggerstruct.activator;
    if (!isplayer(victim)) {
        return;
    }
    if (victim isinvehicle() && victim getvehicleoccupied().vehicleclass === "helicopter") {
        return;
    }
    vehicle = self getlinkedent();
    victim_origin = victim.origin + (0, 0, 40);
    var_38c235fa = vehicle gettagorigin(vehicle.var_f3652bd);
    /#
        if (getdvarint(#"hash_3b9aedd563f16da4", 0) > 0) {
            sphere(var_38c235fa, vehicle.rotor_radius, (0, 1, 1), 0.3);
            sphere(victim_origin, 40, (1, 1, 0), 0.3);
        }
    #/
    if (distancesquared(var_38c235fa, victim_origin) > sqr(40 + vehicle.rotor_radius)) {
        return;
    }
    var_38609e65 = anglestoup(vehicle getangles());
    /#
        if (getdvarint(#"hash_3b9aedd563f16da4", 0) > 0) {
            line(var_38c235fa, var_38c235fa + var_38609e65 * 100, (1, 0, 0));
        }
    #/
    projected = vectorprojection(victim_origin - var_38c235fa, var_38609e65);
    if (lengthsquared(projected) > sqr(40)) {
        return;
    }
    trace = bullettrace(var_38c235fa, victim_origin, 0, vehicle, 1, 1);
    if (trace[#"fraction"] == 1) {
        killer = isdefined(vehicle getseatoccupant(0)) ? vehicle getseatoccupant(0) : vehicle;
        victim.var_f5dc0dbf = 1;
        victim dodamage(victim.health, var_38c235fa, killer, vehicle, "", "MOD_CRUSH", 0, vehicle.settings.var_81a2bc21);
    }
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x4
// Checksum 0x1931e87f, Offset: 0x7a8
// Size: 0x17c
function private function_b5c0079f() {
    var_38c235fa = self gettagorigin(self.var_f3652bd);
    if (isdefined(var_38c235fa)) {
        self.rotor_trigger = spawn("trigger_radius", var_38c235fa - (0, 0, self.rotor_radius * 0.5), 0, self.rotor_radius, self.rotor_radius);
        driver = self getseatoccupant(0);
        self.rotor_trigger enablelinkto();
        self.rotor_trigger linkto(self, self.var_f3652bd);
        self.rotor_trigger setexcludeteamfortrigger(driver.team);
        self.rotor_trigger triggerenable(1);
        self.rotor_trigger callback::on_trigger(&function_727338d1);
        return;
    }
    println("<dev string:x38>" + self.var_f3652bd + "<dev string:x51>");
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x4
// Checksum 0xd772c291, Offset: 0x930
// Size: 0x84
function private function_6ad9ed56() {
    if (getdvarint(#"hash_6e660633f2dbac2a", 1) > 0) {
        driver = self getseatoccupant(0);
        if (isdefined(driver) && isplayer(driver)) {
            self thread player_vehicle::function_d3da7e1e();
        }
    }
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 1, eflags: 0x0
// Checksum 0x62ca75ec, Offset: 0x9c0
// Size: 0xc8
function function_56ee2902(state) {
    foreach (occupant in self getvehoccupants()) {
        if (!isplayer(occupant)) {
            continue;
        }
        occupant clientfield::set_player_uimodel("vehicle.malfunction", state);
    }
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x4
// Checksum 0x29dcf0d5, Offset: 0xa90
// Size: 0xca
function private function_455f2b9b() {
    self function_803e9bf3(2);
    self setrotorspeed(0.7);
    /#
        if (getdvarint(#"hash_26be05fed16f7abd", 0) > 0) {
            print("<dev string:x68>" + self getentnum() + "<dev string:x87>" + self getentnum() + "<dev string:x8c>");
        }
    #/
    self.var_38800c0 = 2;
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x4
// Checksum 0x8690fd41, Offset: 0xb68
// Size: 0xaa
function private function_2ea47d8() {
    self function_803e9bf3(3);
    self setrotorspeed(0.7);
    /#
        if (getdvarint(#"hash_26be05fed16f7abd", 0) > 0) {
            print("<dev string:x91>" + self getentnum() + "<dev string:x8c>");
        }
    #/
    self.var_38800c0 = 3;
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x4
// Checksum 0xd7852fc9, Offset: 0xc20
// Size: 0xa2
function private function_b80bf20f() {
    self function_803e9bf3(3);
    self setrotorspeed(1);
    /#
        if (getdvarint(#"hash_26be05fed16f7abd", 0) > 0) {
            print("<dev string:xac>" + self getentnum() + "<dev string:x8c>");
        }
    #/
    self.var_38800c0 = 4;
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x0
// Checksum 0x32732811, Offset: 0xcd0
// Size: 0xb6
function function_a2b127e3() {
    self returnplayercontrol();
    self setrotorspeed(1);
    self function_803e9bf3(1);
    /#
        if (getdvarint(#"hash_26be05fed16f7abd", 0) > 0) {
            print("<dev string:xcc>" + self getentnum() + "<dev string:x8c>");
        }
    #/
    self.var_38800c0 = 0;
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x4
// Checksum 0xafe0d288, Offset: 0xd90
// Size: 0xba
function private function_edd50d7d() {
    self takeplayercontrol();
    self function_803e9bf3(0);
    self setrotorspeed(1);
    /#
        if (getdvarint(#"hash_26be05fed16f7abd", 0) > 0) {
            print("<dev string:xe6>" + self getentnum() + "<dev string:x8c>");
        }
    #/
    self.var_38800c0 = 1;
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x4
// Checksum 0x2b418bc, Offset: 0xe58
// Size: 0xba
function private function_6aa62d8b() {
    self player_vehicle::function_8cf138bb();
    self function_e55e182a();
    self function_803e9bf3(0);
    /#
        if (getdvarint(#"hash_26be05fed16f7abd", 0) > 0) {
            print("<dev string:x100>" + self getentnum() + "<dev string:x8c>");
        }
    #/
    self.var_38800c0 = 5;
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x4
// Checksum 0x2506288b, Offset: 0xf20
// Size: 0xba
function private function_8b99abde() {
    self function_803e9bf3(1);
    self setrotorspeed(1);
    self thread function_7b63d976();
    /#
        if (getdvarint(#"hash_26be05fed16f7abd", 0) > 0) {
            print("<dev string:x11f>" + self getentnum() + "<dev string:x8c>");
        }
    #/
    self.var_38800c0 = 6;
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x0
// Checksum 0xc693b7cf, Offset: 0xfe8
// Size: 0xc2
function function_2a0f9c3c() {
    self takeplayercontrol();
    self function_803e9bf3(3);
    self setrotorspeed(0.7);
    /#
        if (getdvarint(#"hash_26be05fed16f7abd", 0) > 0) {
            print("<dev string:x141>" + self getentnum() + "<dev string:x8c>");
        }
    #/
    self.var_38800c0 = 7;
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x4
// Checksum 0x7054ba21, Offset: 0x10b8
// Size: 0x5be
function private function_97305c79() {
    self endon(#"death");
    while (isalive(self)) {
        if (!is_true(self.var_52e23e90) && self.var_38800c0 != 5) {
            /#
                if (getdvarint(#"hash_26be05fed16f7abd", 0) > 0) {
                    print("<dev string:x15e>" + self getentnum() + "<dev string:x8c>");
                }
            #/
            self waittill(#"exit_off");
            continue;
        }
        if (self.var_38800c0 == 0) {
            self thread check_landed();
            /#
                if (getdvarint(#"hash_26be05fed16f7abd", 0) > 0) {
                    print("<dev string:x174>" + self getentnum() + "<dev string:x8c>");
                }
            #/
            self waittill(#"exit_flying");
            continue;
        }
        if (self.var_38800c0 == 1) {
            self thread check_takeoff();
            /#
                if (getdvarint(#"hash_26be05fed16f7abd", 0) > 0) {
                    print("<dev string:x18d>" + self getentnum() + "<dev string:x8c>");
                }
            #/
            self waittill(#"exit_landed");
            continue;
        }
        if (self.var_38800c0 == 2) {
            self thread function_7a66682a();
            self thread function_55a21c7f();
            /#
                if (getdvarint(#"hash_26be05fed16f7abd", 0) > 0) {
                    print("<dev string:x1a6>" + self getentnum() + "<dev string:x8c>");
                }
            #/
            self waittill(#"hash_74bba4f3dddf9fc3");
            continue;
        }
        if (self.var_38800c0 == 3) {
            /#
                if (getdvarint(#"hash_26be05fed16f7abd", 0) > 0) {
                    print("<dev string:x1c4>" + self getentnum() + "<dev string:x8c>");
                }
            #/
            self thread function_637d1595();
            self waittill(#"hash_573e89d990d75799");
            continue;
        }
        if (self.var_38800c0 == 4) {
            self thread function_158a4c05();
            /#
                if (getdvarint(#"hash_26be05fed16f7abd", 0) > 0) {
                    print("<dev string:x1de>" + self getentnum() + "<dev string:x8c>");
                }
            #/
            self waittill(#"hash_1df27f53ba982860");
            continue;
        }
        if (self.var_38800c0 == 5) {
            /#
                if (getdvarint(#"hash_26be05fed16f7abd", 0) > 0) {
                    print("<dev string:x1fd>" + self getentnum() + "<dev string:x8c>");
                }
            #/
            self waittill(#"hash_b87b2afaca5829c");
            continue;
        }
        if (self.var_38800c0 == 6) {
            self thread function_b2cbe3f8();
            /#
                if (getdvarint(#"hash_26be05fed16f7abd", 0) > 0) {
                    print("<dev string:x21b>" + self getentnum() + "<dev string:x8c>");
                }
            #/
            self waittill(#"hash_ecab417d1ae9d64");
            continue;
        }
        if (self.var_38800c0 == 7) {
            /#
                if (getdvarint(#"hash_26be05fed16f7abd", 0) > 0) {
                    print("<dev string:x23c>" + self getentnum() + "<dev string:x8c>");
                }
            #/
            self waittill(#"hash_453082d0b252c039");
        }
    }
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x4
// Checksum 0x1b11d970, Offset: 0x1680
// Size: 0x1de
function private function_d6742832() {
    self endon(#"death");
    while (isalive(self)) {
        if (self.var_c82ffc5e == 0) {
            /#
                if (getdvarint(#"hash_26be05fed16f7abd", 0) > 0) {
                    print("<dev string:x258>" + self getentnum() + "<dev string:x8c>");
                }
            #/
            self waittill(#"hash_1c3dc90bd345b165");
            continue;
        }
        if (self.var_c82ffc5e == 1) {
            self thread function_a133d262();
            /#
                if (getdvarint(#"hash_26be05fed16f7abd", 0) > 0) {
                    print("<dev string:x27a>" + self getentnum() + "<dev string:x8c>");
                }
            #/
            self waittill(#"hash_275d130720063641");
            continue;
        }
        if (self.var_c82ffc5e == 2) {
            /#
                if (getdvarint(#"hash_26be05fed16f7abd", 0) > 0) {
                    print("<dev string:x29c>" + self getentnum() + "<dev string:x8c>");
                }
            #/
            self waittill(#"hash_b52e63b6ac3646a");
        }
    }
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x4
// Checksum 0x7aafb59b, Offset: 0x1868
// Size: 0xe8
function private function_638d1ade() {
    self endon(#"death");
    while (true) {
        if (death_circle::is_active()) {
            if (death_circle::function_f8dae197() <= 4298) {
                function_825bbe3f();
            } else if (death_circle::function_65cb78e7(self.origin) > 0) {
                function_c060273d();
            } else {
                function_586d9fee();
            }
            wait 0.1;
            continue;
        }
        function_586d9fee();
        wait 2;
    }
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x4
// Checksum 0x3223066f, Offset: 0x1958
// Size: 0x6e
function private function_586d9fee() {
    if (self.var_c82ffc5e == 1) {
        function_5b6643c1();
        self notify(#"hash_275d130720063641");
        return;
    }
    if (self.var_c82ffc5e == 2) {
        function_5b6643c1();
        self notify(#"hash_b52e63b6ac3646a");
    }
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x4
// Checksum 0xf569f484, Offset: 0x19d0
// Size: 0x36
function private function_c060273d() {
    if (self.var_c82ffc5e == 0) {
        function_3705cb9a();
        self notify(#"hash_1c3dc90bd345b165");
    }
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x4
// Checksum 0xb1d87ef3, Offset: 0x1a10
// Size: 0x6e
function private function_825bbe3f() {
    if (self.var_c82ffc5e == 0) {
        function_cfb0d0ad();
        self notify(#"hash_1c3dc90bd345b165");
        return;
    }
    if (self.var_c82ffc5e == 1) {
        function_cfb0d0ad();
        self notify(#"hash_275d130720063641");
    }
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x4
// Checksum 0x225341e0, Offset: 0x1a88
// Size: 0x186
function private function_5b6643c1() {
    self function_56ee2902(0);
    self clientfield::set("update_malfunction", 0);
    self clientfield::set("flickerlights", 3);
    if (!is_true(self.var_52e23e90) && self.var_38800c0 == 5) {
        self function_e55e182a();
        self notify(#"hash_b87b2afaca5829c");
    } else if (self.var_38800c0 == 6) {
        function_a2b127e3();
        self notify(#"hash_ecab417d1ae9d64");
    } else if (self.var_38800c0 == 7) {
        function_a2b127e3();
        self notify(#"hash_453082d0b252c039");
    }
    /#
        if (getdvarint(#"hash_26be05fed16f7abd", 0) > 0) {
            print("<dev string:x2c0>" + self getentnum() + "<dev string:x8c>");
        }
    #/
    self.var_c82ffc5e = 0;
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x4
// Checksum 0x4f4ec5ab, Offset: 0x1c18
// Size: 0x1a2
function private function_3705cb9a() {
    self function_56ee2902(1);
    self clientfield::set("update_malfunction", 1);
    self clientfield::set("flickerlights", 2);
    if (!is_true(self.var_52e23e90)) {
        function_6aa62d8b();
        self notify(#"exit_off");
    } else if (self.var_38800c0 == 0 && !getdvarint(#"hash_4381be5e131dc9aa", 0)) {
        function_8b99abde();
        self notify(#"exit_flying");
    } else if (self.var_38800c0 == 1) {
        function_6aa62d8b();
        self notify(#"exit_landed");
    }
    /#
        if (getdvarint(#"hash_26be05fed16f7abd", 0) > 0) {
            print("<dev string:x2e3>" + self getentnum() + "<dev string:x8c>");
        }
    #/
    self.var_c82ffc5e = 1;
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x4
// Checksum 0xc17a310c, Offset: 0x1dc8
// Size: 0x282
function private function_cfb0d0ad() {
    self clientfield::set("update_malfunction", 2);
    self clientfield::set("flickerlights", 3);
    self function_56ee2902(2);
    if (!is_true(self.var_52e23e90)) {
        function_6aa62d8b();
        self notify(#"exit_off");
    } else if (self.var_38800c0 == 1) {
        function_6aa62d8b();
        self notify(#"exit_landed");
    } else if (self.var_38800c0 == 0 && !getdvarint(#"hash_4381be5e131dc9aa", 0)) {
        function_2a0f9c3c();
        self notify(#"exit_flying");
    } else if (self.var_38800c0 == 2) {
        function_2a0f9c3c();
        self notify(#"hash_74bba4f3dddf9fc3");
    } else if (self.var_38800c0 == 3) {
        function_2a0f9c3c();
        self notify(#"hash_573e89d990d75799");
    } else if (self.var_38800c0 == 4) {
        function_2a0f9c3c();
        self notify(#"hash_1df27f53ba982860");
    } else if (self.var_38800c0 == 6) {
        function_2a0f9c3c();
        self notify(#"hash_ecab417d1ae9d64");
    }
    /#
        if (getdvarint(#"hash_26be05fed16f7abd", 0) > 0) {
            print("<dev string:x306>" + self getentnum() + "<dev string:x8c>");
        }
    #/
    self.var_c82ffc5e = 2;
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x4
// Checksum 0x6bfa855a, Offset: 0x2058
// Size: 0x76
function private function_a133d262() {
    self notify(#"hash_1707434571fb5e82");
    self endon(#"death", #"hash_275d130720063641", #"hash_1707434571fb5e82");
    waitframe(1);
    wait 30;
    function_cfb0d0ad();
    self notify(#"hash_275d130720063641");
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 1, eflags: 0x0
// Checksum 0xe51896b6, Offset: 0x20d8
// Size: 0xc6
function function_82224f4b(scale) {
    self notify("3ea44ad3f5ffe4a3");
    self endon("3ea44ad3f5ffe4a3");
    self endon(#"death", #"hash_ecab417d1ae9d64", #"hash_1d3acb3966f46517");
    while (true) {
        accel = anglestoup(self.angles) * scale;
        self setphysacceleration((accel[0], accel[1], -200));
        waitframe(1);
    }
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x4
// Checksum 0xfb568952, Offset: 0x21a8
// Size: 0xb4
function private function_838515ae() {
    self takeplayercontrol();
    self clientfield::set("update_malfunction", 2);
    self setrotorspeed(0.7);
    self clientfield::set("flickerlights", 3);
    self function_56ee2902(2);
    self thread function_82224f4b(1600);
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x4
// Checksum 0xadaf553f, Offset: 0x2268
// Size: 0x150
function private function_7b63d976() {
    self endon(#"death", #"hash_ecab417d1ae9d64");
    wait 5;
    self clientfield::set("flickerlights", 2);
    while (true) {
        self function_838515ae();
        wait randomfloatrange(1, 3);
        self notify(#"hash_1d3acb3966f46517");
        self returnplayercontrol();
        self setrotorspeed(1);
        self function_56ee2902(1);
        self clientfield::set("update_malfunction", 1);
        self clientfield::set("flickerlights", 2);
        wait randomfloatrange(3, 10);
    }
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x4
// Checksum 0x389dbc4e, Offset: 0x23c0
// Size: 0x36
function private function_54f9ca32() {
    return self.var_38800c0 === 3 || self.var_38800c0 === 4 || self.var_38800c0 === 7;
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 1, eflags: 0x4
// Checksum 0x8b5c1015, Offset: 0x2400
// Size: 0x6e
function private function_adbcb48d(*params) {
    if (is_true(self function_54f9ca32())) {
        self dodamage(self.health, self.origin, undefined, undefined, "", "MOD_IMPACT");
        return;
    }
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x4
// Checksum 0x615230fe, Offset: 0x2478
// Size: 0x14a
function private function_4f8aa02d() {
    self endon(#"death");
    while (true) {
        waterheight = getwaterheight(self.origin, 100, -10000);
        if (waterheight != -131072) {
            var_19dbcac7 = self.origin[2] + -70 - waterheight;
            if (var_19dbcac7 <= 0) {
                self dodamage(self.health, self.origin, undefined, undefined, "", "MOD_IMPACT");
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

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 8, eflags: 0x4
// Checksum 0x44867077, Offset: 0x25d0
// Size: 0xcc
function private function_f7f4dbf0(*einflictor, *eattacker, *idamage, *smeansofdeath, *weapon, *vdir, *shitloc, *psoffsettime) {
    self function_e55e182a();
    self function_56ee2902(0);
    self clientfield::set("update_malfunction", 0);
    self clientfield::set("flickerlights", 3);
    self function_803e9bf3(0);
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x4
// Checksum 0x1fa96240, Offset: 0x26a8
// Size: 0x64
function private function_e55e182a() {
    self function_803e9bf3(0);
    self.var_38800c0 = 1;
    player_vehicle::turn_off();
    if (isdefined(self.rotor_trigger)) {
        self.rotor_trigger delete();
    }
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 2, eflags: 0x0
// Checksum 0x6c92944f, Offset: 0x2718
// Size: 0x2a
function function_9ffa5fd(var_92eb9b7d, var_6d872cea) {
    return self function_47fb62f4(var_92eb9b7d, var_6d872cea);
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 3, eflags: 0x0
// Checksum 0x91d997e0, Offset: 0x2750
// Size: 0x9c
function function_60bfc90(player, var_92eb9b7d, var_6d872cea) {
    self endon(#"death");
    player function_a61cb23e(1);
    tweentime = self function_ff1bf59c(var_92eb9b7d, var_6d872cea);
    wait tweentime * 2;
    if (isdefined(player)) {
        player function_a61cb23e(0);
    }
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 3, eflags: 0x0
// Checksum 0xba1e5f31, Offset: 0x27f8
// Size: 0x74
function function_b1088764(player, var_92eb9b7d, var_6d872cea) {
    player luinotifyevent(#"quick_fade", 0);
    player luinotifyeventtospectators(#"quick_fade", 0);
    self thread function_60bfc90(player, var_92eb9b7d, var_6d872cea);
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 1, eflags: 0x4
// Checksum 0x454b5a1b, Offset: 0x2878
// Size: 0x10c
function private function_b515cb89(params) {
    if (isalive(self)) {
        if (params.eventstruct.seat_index === 0) {
            function_dce84927();
        } else if (params.eventstruct.old_seat_index === 0) {
            function_d7021cf2();
        }
        if (isdefined(params.player)) {
            enter_seat = params.eventstruct.seat_index;
            exit_seat = params.eventstruct.old_seat_index;
            if (function_9ffa5fd(exit_seat, enter_seat)) {
                self function_b1088764(params.player, exit_seat, enter_seat);
            }
        }
    }
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 1, eflags: 0x4
// Checksum 0x2f7c7dce, Offset: 0x2990
// Size: 0xc4
function private function_1435d6c2(params) {
    if (isalive(self)) {
        if (params.eventstruct.seat_index === 0) {
            function_dce84927();
        }
        if (isdefined(params.player)) {
            enter_seat = params.eventstruct.seat_index;
            if (function_9ffa5fd(undefined, enter_seat)) {
                self function_b1088764(params.player, undefined, enter_seat);
            }
        }
    }
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 1, eflags: 0x4
// Checksum 0xb3ea8d03, Offset: 0x2a60
// Size: 0xf4
function private function_6258a76c(params) {
    if (isalive(self)) {
        occupants = self getvehoccupants();
        if (!isdefined(occupants) || !occupants.size) {
            if (self.var_38800c0 == 1) {
                self function_e55e182a();
                self notify(#"exit_landed");
            }
        }
        if (params.eventstruct.seat_index === 0) {
            function_d7021cf2();
        }
    }
    if (isdefined(params.player)) {
        params.player clientfield::set_player_uimodel("vehicle.malfunction", 0);
    }
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x4
// Checksum 0x774a30a9, Offset: 0x2b60
// Size: 0x1d6
function private function_dce84927() {
    if (!is_true(self.var_52e23e90)) {
        params = spawnstruct();
        params.var_30a04b16 = 1;
        player_vehicle::turn_on(params);
        /#
            if (getdvarint(#"hash_26be05fed16f7abd", 0) > 0) {
                print("<dev string:xe6>" + self getentnum() + "<dev string:x8c>");
            }
        #/
        self.var_38800c0 = 1;
        self.var_cd532f2c = gettime() + 3000;
        if (getdvarint(#"hash_68addfc92e304f21", 1) && is_true(self.var_dc20225f)) {
            self function_b5c0079f();
        }
        self notify(#"exit_off");
        return;
    }
    if (self.var_38800c0 == 2) {
        if (self.var_c82ffc5e == 0) {
            function_a2b127e3();
        } else {
            function_8b99abde();
        }
        self notify(#"hash_74bba4f3dddf9fc3");
        return;
    }
    if (self.var_38800c0 == 3) {
        function_b80bf20f();
        self notify(#"hash_573e89d990d75799");
    }
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x4
// Checksum 0x625718bf, Offset: 0x2d40
// Size: 0x96
function private function_d7021cf2() {
    if (self.var_38800c0 == 0 && !getdvarint(#"hash_4381be5e131dc9aa", 0)) {
        function_455f2b9b();
        self notify(#"exit_flying");
        return;
    }
    if (self.var_38800c0 == 4) {
        function_2ea47d8();
        self notify(#"hash_1df27f53ba982860");
    }
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x4
// Checksum 0x3d9a7e23, Offset: 0x2de0
// Size: 0x184
function private check_takeoff() {
    self notify(#"check_takeoff");
    self endon(#"death", #"exit_landed", #"check_takeoff");
    waitframe(1);
    while (true) {
        player = self getseatoccupant(0);
        if (isdefined(player) && (!isdefined(self.var_cd532f2c) || gettime() - self.var_cd532f2c >= 0)) {
            self.var_cd532f2c = undefined;
            move = player getnormalizedmovement();
            var_d4865741 = player vehiclemoveupbuttonpressed() || isdefined(move) && (abs(move[0]) > 0.2 || abs(move[1]) > 0.2);
            if (var_d4865741) {
                function_a2b127e3();
                self notify(#"exit_landed");
                break;
            }
        }
        waitframe(1);
    }
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x4
// Checksum 0x5c8bed6c, Offset: 0x2f70
// Size: 0x1ac
function private check_landed() {
    self notify(#"check_landed");
    self endon(#"death", #"exit_flying", #"check_landed");
    waitframe(1);
    while (true) {
        player = self getseatoccupant(0);
        if (!isdefined(player) || !player vehiclemovedownbuttonpressed() || player vehiclemoveupbuttonpressed()) {
            waitframe(1);
            continue;
        }
        move = player getnormalizedmovement();
        if (isdefined(move) && (abs(move[0]) > 0.2 || abs(move[1]) > 0.2)) {
            waitframe(1);
            continue;
        }
        if (self function_479389f3() && !getdvarint(#"hash_4381be5e131dc9aa", 0)) {
            function_edd50d7d();
            self notify(#"exit_flying");
            break;
        }
        waitframe(1);
    }
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x4
// Checksum 0x28246b7f, Offset: 0x3128
// Size: 0xf4
function private function_7a66682a() {
    self notify(#"hash_73b33f91c657e33e");
    self endon(#"death", #"hash_74bba4f3dddf9fc3", #"hash_73b33f91c657e33e");
    waitframe(1);
    while (true) {
        if (self function_479389f3()) {
            occupants = self getvehoccupants();
            if (!isdefined(occupants) || !occupants.size) {
                self function_e55e182a();
            } else {
                function_edd50d7d();
            }
            self notify(#"hash_74bba4f3dddf9fc3");
            break;
        }
        waitframe(1);
    }
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x4
// Checksum 0x4591291e, Offset: 0x3228
// Size: 0xf4
function private function_637d1595() {
    self notify(#"hash_d4c7c76098ff4b8");
    self endon(#"death", #"hash_573e89d990d75799", #"hash_d4c7c76098ff4b8");
    waitframe(1);
    while (true) {
        if (self function_479389f3()) {
            occupants = self getvehoccupants();
            if (!isdefined(occupants) || !occupants.size) {
                self function_e55e182a();
            } else {
                function_edd50d7d();
            }
            self notify(#"hash_573e89d990d75799");
            break;
        }
        waitframe(1);
    }
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x4
// Checksum 0xd4239375, Offset: 0x3328
// Size: 0xa4
function private function_b2cbe3f8() {
    self notify(#"hash_5b78f14ae4e8dc43");
    self endon(#"death", #"hash_ecab417d1ae9d64", #"hash_5b78f14ae4e8dc43");
    waitframe(1);
    while (true) {
        if (self function_479389f3()) {
            function_6aa62d8b();
            self notify(#"hash_ecab417d1ae9d64");
            break;
        }
        waitframe(1);
    }
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x4
// Checksum 0x4c4a777e, Offset: 0x33d8
// Size: 0x76
function private function_55a21c7f() {
    self notify(#"hash_655e0e5013875cda");
    self endon(#"death", #"hash_74bba4f3dddf9fc3", #"hash_655e0e5013875cda");
    waitframe(1);
    wait 1;
    function_2ea47d8();
    self notify(#"hash_74bba4f3dddf9fc3");
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x4
// Checksum 0x4f02137f, Offset: 0x3458
// Size: 0xa6
function private function_158a4c05() {
    self notify(#"hash_413db73113f75c85");
    self endon(#"death", #"hash_1df27f53ba982860", #"hash_413db73113f75c85");
    waitframe(1);
    wait 0.8;
    if (self.var_c82ffc5e == 0) {
        function_a2b127e3();
    } else {
        function_8b99abde();
    }
    self notify(#"hash_1df27f53ba982860");
}

// Namespace namespace_c8fb02a7/namespace_c8fb02a7
// Params 0, eflags: 0x4
// Checksum 0x1181a51b, Offset: 0x3508
// Size: 0x682
function private function_479389f3() {
    if (self function_5e768331() > 200) {
        return false;
    }
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

