#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_a9076ee3;

// Namespace namespace_a9076ee3
// Method(s) 22 Total 22
class class_d5e68311 {

    var var_2d9de19e;
    var var_3d18872;
    var var_450307dc;
    var var_4fc15b0b;
    var var_76c10824;
    var var_884ed4f;
    var var_89c30c57;
    var var_b228f30;
    var var_e1c25a48;
    var var_e7fdf736;
    var var_e93e3086;
    var var_ec13f56d;
    var var_f141235b;
    var var_fef76413;

    // Namespace class_d5e68311/namespace_a9076ee3
    // Params 0, eflags: 0x8
    // Checksum 0x517286f1, Offset: 0xd8
    // Size: 0xbe
    constructor() {
        var_f141235b = 0;
        var_884ed4f = undefined;
        var_e93e3086 = (15, -3, 0);
        var_3d18872 = (0, 0, 0);
        var_4fc15b0b = (15, -3, 0);
        var_2d9de19e = (0, 0, 0);
        var_450307dc = "";
        var_fef76413 = 0;
        var_76c10824 = 1;
        var_b228f30 = 0;
        var_89c30c57 = 0;
        var_ec13f56d = 1;
        var_e7fdf736 = 5;
        var_e1c25a48 = 0;
    }

    // Namespace namespace_d5e68311/namespace_a9076ee3
    // Params 0, eflags: 0x0
    // Checksum 0x29de4e8e, Offset: 0x788
    // Size: 0xa
    function function_7c6cd9d() {
        return var_f141235b;
    }

    // Namespace namespace_d5e68311/namespace_a9076ee3
    // Params 0, eflags: 0x0
    // Checksum 0xecd00ee, Offset: 0x8a8
    // Size: 0x34
    function function_13f1dc62() {
        return {#enabled:var_ec13f56d, #max:var_e7fdf736};
    }

    // Namespace namespace_d5e68311/namespace_a9076ee3
    // Params 2, eflags: 0x0
    // Checksum 0xc9992490, Offset: 0x268
    // Size: 0x294
    function update_model(var_53008658 = "", is_hidden = 0) {
        var_38d97d58 = getscriptbundle(var_53008658);
        if (!isdefined(var_38d97d58)) {
            var_38d97d58 = {};
        }
        model_name = isdefined(var_38d97d58.uimodel) ? var_38d97d58.uimodel : "";
        var_4efbbcfe = isdefined(var_38d97d58.var_4efbbcfe) ? var_38d97d58.var_4efbbcfe : 0;
        var_4138e7ed = isdefined(var_38d97d58.var_4138e7ed) ? var_38d97d58.var_4138e7ed : 0;
        if (var_450307dc == model_name) {
            return;
        }
        var_450307dc = model_name;
        var_b228f30 = var_4efbbcfe;
        var_89c30c57 = var_4138e7ed;
        var_e1c25a48 = is_hidden;
        function_f710ecd0();
        if (model_name != "") {
            if (!isdefined(var_884ed4f)) {
                var_884ed4f = spawn(var_f141235b, (0, 0, 0), "script_model");
            }
            var_884ed4f setmodel(model_name);
            set_position(var_4fc15b0b, var_2d9de19e);
            var_fef76413 = 1;
        } else if (is_true(var_fef76413)) {
            var_884ed4f function_a052b638();
            var_fef76413 = 0;
            var_884ed4f delete();
        }
        if (isdefined(var_884ed4f)) {
            if (is_hidden) {
                var_884ed4f playrenderoverridebundle(#"hash_1d4878635b5ea5a3");
                return;
            }
            var_884ed4f stoprenderoverridebundle(#"hash_1d4878635b5ea5a3");
        }
    }

    // Namespace namespace_d5e68311/namespace_a9076ee3
    // Params 1, eflags: 0x0
    // Checksum 0x9b4fd626, Offset: 0x600
    // Size: 0x2a
    function function_2e66587b(var_4c987939 = 1) {
        var_ec13f56d = var_4c987939;
    }

    // Namespace namespace_d5e68311/namespace_a9076ee3
    // Params 0, eflags: 0x0
    // Checksum 0x7d8ca5f, Offset: 0x508
    // Size: 0x44
    function reset() {
        var_f141235b = 0;
        update_model();
        function_56293490();
        function_f710ecd0();
    }

    // Namespace namespace_d5e68311/namespace_a9076ee3
    // Params 0, eflags: 0x0
    // Checksum 0xd80caac, Offset: 0x728
    // Size: 0x26
    function function_56293490() {
        var_e93e3086 = (15, -3, 0);
        var_3d18872 = (0, 0, 0);
    }

    // Namespace namespace_d5e68311/namespace_a9076ee3
    // Params 0, eflags: 0x0
    // Checksum 0x317f5337, Offset: 0x828
    // Size: 0x1a
    function is_hidden() {
        return is_true(var_e1c25a48);
    }

    // Namespace namespace_d5e68311/namespace_a9076ee3
    // Params 0, eflags: 0x0
    // Checksum 0xf392337c, Offset: 0x7b8
    // Size: 0xa
    function function_62571daf() {
        return var_3d18872;
    }

    // Namespace namespace_d5e68311/namespace_a9076ee3
    // Params 0, eflags: 0x0
    // Checksum 0xe5824dff, Offset: 0x7a0
    // Size: 0xa
    function function_6e7ad37e() {
        return var_e93e3086;
    }

    // Namespace namespace_d5e68311/namespace_a9076ee3
    // Params 0, eflags: 0x0
    // Checksum 0x497d21f2, Offset: 0x800
    // Size: 0x1a
    function function_75aa931a() {
        return is_true(var_fef76413);
    }

    // Namespace namespace_d5e68311/namespace_a9076ee3
    // Params 1, eflags: 0x0
    // Checksum 0xe085160b, Offset: 0x638
    // Size: 0x32
    function function_77f3574b(var_4ce74bd9 = (15, -3, 0)) {
        var_e93e3086 = var_4ce74bd9;
    }

    // Namespace namespace_d5e68311/namespace_a9076ee3
    // Params 1, eflags: 0x0
    // Checksum 0x1a846e7b, Offset: 0x558
    // Size: 0x62
    function set_client(local_client_num = 0) {
        assert(local_client_num >= 0 && local_client_num < getmaxlocalclients());
        var_f141235b = local_client_num;
    }

    // Namespace namespace_d5e68311/namespace_a9076ee3
    // Params 0, eflags: 0x0
    // Checksum 0xae070e0e, Offset: 0x7e8
    // Size: 0xa
    function get_angle() {
        return var_2d9de19e;
    }

    // Namespace namespace_d5e68311/namespace_a9076ee3
    // Params 5, eflags: 0x0
    // Checksum 0xadfc48b9, Offset: 0x1a0
    // Size: 0xbe
    function function_b4ecf5f4(local_client_num = 0, origin = (15, -3, 0), angle = (0, 0, 0), var_447b7d9b = 1, var_4c987939 = 1) {
        var_f141235b = local_client_num;
        var_e93e3086 = origin;
        var_3d18872 = angle;
        var_76c10824 = var_447b7d9b;
        var_ec13f56d = var_4c987939;
    }

    // Namespace namespace_d5e68311/namespace_a9076ee3
    // Params 2, eflags: 0x0
    // Checksum 0xdecf0166, Offset: 0x6b0
    // Size: 0x6c
    function set_position(origin, angle) {
        if (isdefined(origin)) {
            var_4fc15b0b = origin;
        }
        if (isdefined(angle)) {
            var_2d9de19e = angle;
        }
        var_884ed4f linktocamera(4, var_4fc15b0b, var_2d9de19e);
    }

    // Namespace namespace_d5e68311/namespace_a9076ee3
    // Params 1, eflags: 0x0
    // Checksum 0xe51d2d49, Offset: 0x678
    // Size: 0x2a
    function function_d5f29651(var_40779d0d = (0, 0, 0)) {
        var_3d18872 = var_40779d0d;
    }

    // Namespace namespace_d5e68311/namespace_a9076ee3
    // Params 1, eflags: 0x0
    // Checksum 0x7a9aa37d, Offset: 0x5c8
    // Size: 0x2a
    function function_e3f38520(var_447b7d9b = 1) {
        var_76c10824 = var_447b7d9b;
    }

    // Namespace namespace_d5e68311/namespace_a9076ee3
    // Params 0, eflags: 0x0
    // Checksum 0x5357f4a1, Offset: 0x7d0
    // Size: 0xa
    function get_origin() {
        return var_4fc15b0b;
    }

    // Namespace namespace_d5e68311/namespace_a9076ee3
    // Params 0, eflags: 0x0
    // Checksum 0x90839676, Offset: 0x758
    // Size: 0x22
    function function_f710ecd0() {
        var_4fc15b0b = var_e93e3086;
        var_2d9de19e = var_3d18872;
    }

    // Namespace namespace_d5e68311/namespace_a9076ee3
    // Params 0, eflags: 0x0
    // Checksum 0xbf3a1892, Offset: 0x850
    // Size: 0x4c
    function function_fbdfd5f9() {
        return {#enabled:var_76c10824, #var_71fe4b43:var_b228f30, #var_8d3781b5:var_89c30c57};
    }

}

// Namespace namespace_a9076ee3/namespace_a9076ee3
// Params 0, eflags: 0x6
// Checksum 0x8c03a236, Offset: 0x90
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_19a39574bfda1b56", &preinit, undefined, undefined, undefined);
}

// Namespace namespace_a9076ee3/namespace_a9076ee3
// Params 1, eflags: 0x0
// Checksum 0x71d260d5, Offset: 0xd40
// Size: 0xcc
function function_5128ed40(var_56c2f5d3) {
    components = [];
    components = strtok(var_56c2f5d3, ",");
    if (!isdefined(components[0])) {
        components[0] = 0;
    }
    if (!isdefined(components[1])) {
        components[1] = 0;
    }
    if (!isdefined(components[2])) {
        components[2] = 0;
    }
    return (int(components[0]), int(components[1]), int(components[2]));
}

// Namespace namespace_a9076ee3/namespace_a9076ee3
// Params 0, eflags: 0x4
// Checksum 0xad17e0b5, Offset: 0xe18
// Size: 0x44
function private preinit() {
    var_5d7dbefc = new class_d5e68311();
    level.var_5d7dbefc = var_5d7dbefc;
    level thread function_3adc69b0();
}

// Namespace namespace_a9076ee3/namespace_a9076ee3
// Params 0, eflags: 0x0
// Checksum 0x76194245, Offset: 0xe68
// Size: 0x1ae
function function_3adc69b0() {
    level endon(#"disconnect");
    while (true) {
        waitresult = level waittill(#"collectibleinspect");
        switch (waitresult.event_name) {
        case #"start":
            if (isdefined(waitresult.origin) && isstring(waitresult.origin)) {
                waitresult.origin = function_5128ed40(waitresult.origin);
            }
            if (isdefined(waitresult.angle) && isstring(waitresult.angle)) {
                waitresult.angle = function_5128ed40(waitresult.angle);
            }
            function_98095ab5(waitresult.local_client_num, waitresult.origin, waitresult.angle, waitresult.var_447b7d9b, waitresult.var_4c987939);
            break;
        case #"update":
            function_6a6b82f1(waitresult.var_53008658, waitresult.is_hidden);
            break;
        case #"stop":
            function_fdff8886();
            break;
        }
    }
}

// Namespace namespace_a9076ee3/namespace_a9076ee3
// Params 5, eflags: 0x0
// Checksum 0x5e959c81, Offset: 0x1020
// Size: 0x74
function function_98095ab5(local_client_num, origin, angle, var_447b7d9b, var_4c987939) {
    level notify(#"hash_44d89707d01c9949");
    [[ level.var_5d7dbefc ]]->function_b4ecf5f4(local_client_num, origin, angle, var_447b7d9b, var_4c987939);
    level thread function_aab851cf();
}

// Namespace namespace_a9076ee3/namespace_a9076ee3
// Params 2, eflags: 0x0
// Checksum 0xef24e649, Offset: 0x10a0
// Size: 0x30
function function_6a6b82f1(var_53008658, is_hidden) {
    [[ level.var_5d7dbefc ]]->update_model(var_53008658, is_hidden);
}

// Namespace namespace_a9076ee3/namespace_a9076ee3
// Params 0, eflags: 0x0
// Checksum 0xa59d3b1a, Offset: 0x10d8
// Size: 0x2c
function function_fdff8886() {
    level notify(#"hash_553672f4d62ba043");
    [[ level.var_5d7dbefc ]]->reset();
}

// Namespace namespace_a9076ee3/namespace_a9076ee3
// Params 1, eflags: 0x4
// Checksum 0xc50731c8, Offset: 0x1110
// Size: 0xca
function private function_5fb947f1(localclientnum) {
    input = {};
    if (gamepadusedlast(localclientnum)) {
        right_stick = util::function_11f127f0(localclientnum);
        var_fc5fe2b2 = util::function_b5338ccb(right_stick.x, 0.2);
        var_a7ae3950 = util::function_b5338ccb(right_stick.y, 0.2);
        input = (var_fc5fe2b2, var_a7ae3950, 0);
    } else {
        input = util::function_3ec868ea(localclientnum);
    }
    return input;
}

// Namespace namespace_a9076ee3/namespace_a9076ee3
// Params 1, eflags: 0x4
// Checksum 0x66f9d37e, Offset: 0x11e8
// Size: 0xe4
function private function_58df12d3(localclientnum) {
    input = {};
    if (gamepadusedlast(localclientnum)) {
        var_43bc2604 = util::function_57f1ac46(localclientnum);
        var_b16a628 = util::function_f35576c(localclientnum);
        input = var_43bc2604 - var_b16a628;
    } else {
        input = (isbuttonpressed(localclientnum, 73) ? 1 : 0) + (isbuttonpressed(localclientnum, 74) ? -1 : 0);
    }
    return input;
}

// Namespace namespace_a9076ee3/namespace_a9076ee3
// Params 0, eflags: 0x4
// Checksum 0x2e692986, Offset: 0x12d8
// Size: 0x52a
function private function_aab851cf() {
    level endon(#"disconnect", #"hash_44d89707d01c9949", #"hash_553672f4d62ba043");
    var_4ce74bd9 = [[ level.var_5d7dbefc ]]->function_6e7ad37e();
    var_40779d0d = [[ level.var_5d7dbefc ]]->function_62571daf();
    while (isdefined(level.var_5d7dbefc)) {
        if (![[ level.var_5d7dbefc ]]->function_75aa931a()) {
            waitframe(1);
            continue;
        }
        local_client_num = [[ level.var_5d7dbefc ]]->function_7c6cd9d();
        player = function_5c10bd79(local_client_num);
        time = player getclienttime();
        waitframe(1);
        player = function_5c10bd79(local_client_num);
        delta_time = player getclienttime() - time;
        var_59ab9a62 = [[ level.var_5d7dbefc ]]->function_fbdfd5f9();
        var_20eb713c = [[ level.var_5d7dbefc ]]->function_13f1dc62();
        v_origin = [[ level.var_5d7dbefc ]]->get_origin();
        v_angle = [[ level.var_5d7dbefc ]]->get_angle();
        var_dbceb0e1 = 0;
        if (is_true(var_59ab9a62.enabled) && ![[ level.var_5d7dbefc ]]->is_hidden()) {
            var_1b56e5cf = function_5fb947f1(local_client_num);
            if (var_1b56e5cf != (0, 0, 0)) {
                var_dbceb0e1 = 1;
                rotation_speed = float(60) / 1000;
                angle_offset = var_1b56e5cf * rotation_speed * delta_time;
                yaw = angle_offset[0];
                pitch = angle_offset[1];
                v_angle += (pitch, yaw, 0);
                var_3faba1b8 = v_angle[1];
                clamped_pitch = v_angle[0];
                if (isdefined(var_59ab9a62.var_71fe4b43) && var_59ab9a62.var_71fe4b43 !== 0) {
                    if (var_3faba1b8 < var_59ab9a62.var_71fe4b43 * -1) {
                        var_3faba1b8 = var_59ab9a62.var_71fe4b43 * -1;
                    } else if (var_3faba1b8 > var_59ab9a62.var_71fe4b43) {
                        var_3faba1b8 = var_59ab9a62.var_71fe4b43;
                    }
                }
                if (isdefined(var_59ab9a62.var_8d3781b5) && var_59ab9a62.var_8d3781b5 !== 0) {
                    if (clamped_pitch < var_59ab9a62.var_8d3781b5 * -1) {
                        clamped_pitch = var_59ab9a62.var_8d3781b5 * -1;
                    } else if (clamped_pitch > var_59ab9a62.var_8d3781b5) {
                        clamped_pitch = var_59ab9a62.var_8d3781b5;
                    }
                }
                v_angle = (clamped_pitch, var_3faba1b8, 0);
            }
        }
        if (is_true(var_20eb713c.enabled) && ![[ level.var_5d7dbefc ]]->is_hidden()) {
            var_a23c6f11 = function_58df12d3(local_client_num);
            if (var_a23c6f11 != 0) {
                var_dbceb0e1 = 1;
                var_cf138deb = float(6) / 1000;
                dist = v_origin[0] + var_a23c6f11 * var_cf138deb * delta_time;
                min_distance = var_4ce74bd9[0] - var_20eb713c.max;
                max_distance = var_4ce74bd9[0];
                if (dist < min_distance) {
                    dist = min_distance;
                } else if (dist > max_distance) {
                    dist = max_distance;
                }
                v_origin = (dist, v_origin[1], v_origin[2]);
            }
        }
        if (var_dbceb0e1 == 1) {
            [[ level.var_5d7dbefc ]]->set_position(v_origin, v_angle);
        }
        time = player getclienttime();
    }
}

