#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\oob;
#using scripts\core_common\system_shared;

#namespace deployable;

// Namespace deployable/deployable
// Params 0, eflags: 0x2
// Checksum 0xaec6a389, Offset: 0xc0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"deployable", &__init__, undefined, undefined);
}

// Namespace deployable/deployable
// Params 0, eflags: 0x0
// Checksum 0x818d3385, Offset: 0x108
// Size: 0xb4
function __init__() {
    callback::on_spawned(&on_player_spawned);
    level.var_8d7f86d3 = spawnstruct();
    level.var_8d7f86d3.var_e324f60e = [];
    level.var_8d7f86d3.var_edd30eba = 0;
    level.var_8d7f86d3.var_341b3baf = [];
    /#
        level.var_8d7f86d3.var_8d551105 = [];
        setdvar(#"hash_8d4e58d73e3f876", 0);
    #/
}

// Namespace deployable/deployable
// Params 6, eflags: 0x0
// Checksum 0x19844043, Offset: 0x1c8
// Size: 0x1de
function register_deployable(weapon, var_4b755b46, var_a5d50f77 = undefined, placehintstr = undefined, var_9f526638 = undefined, var_aacfb942 = undefined) {
    if (!isdefined(level._deployable_weapons)) {
        level._deployable_weapons = [];
    }
    if (weapon.name == "#none") {
        return;
    }
    assert(weapon.name != "<dev string:x30>");
    level._deployable_weapons[weapon.statindex] = spawnstruct();
    level._deployable_weapons[weapon.statindex].var_4c61a529 = &function_f8ef5ac7;
    level._deployable_weapons[weapon.statindex].var_a9d83861 = var_4b755b46;
    level._deployable_weapons[weapon.statindex].var_ca61a5e0 = var_a5d50f77;
    level._deployable_weapons[weapon.statindex].placehintstr = placehintstr;
    level._deployable_weapons[weapon.statindex].var_9f526638 = var_9f526638;
    level._deployable_weapons[weapon.statindex].var_aacfb942 = var_aacfb942;
}

// Namespace deployable/deployable
// Params 1, eflags: 0x0
// Checksum 0x2b7e0347, Offset: 0x3b0
// Size: 0x90
function function_1d161d95(weapon) {
    if (!isdefined(level._deployable_weapons)) {
        level._deployable_weapons = [];
    }
    if (isdefined(level._deployable_weapons[weapon.statindex]) && isdefined(level._deployable_weapons[weapon.statindex].var_4c61a529)) {
        self [[ level._deployable_weapons[weapon.statindex].var_4c61a529 ]](weapon);
    }
}

/#

    // Namespace deployable/deployable
    // Params 1, eflags: 0x0
    // Checksum 0xfa696b0e, Offset: 0x448
    // Size: 0x2c
    function function_97fb14cf(weapon) {
        println("<dev string:x36>");
    }

#/

// Namespace deployable/deployable
// Params 1, eflags: 0x0
// Checksum 0x31717355, Offset: 0x480
// Size: 0x4c
function function_d403fc64(weapon) {
    println("<dev string:x43>");
    self clientfield::set_to_player("gameplay_allows_deploy", 1);
}

// Namespace deployable/deployable
// Params 2, eflags: 0x0
// Checksum 0x51fc4564, Offset: 0x4d8
// Size: 0x150
function function_94621b37(center, radius) {
    var_fe446557 = spawnstruct();
    var_fe446557.origin = center;
    var_fe446557.radiussqr = radius * radius;
    var_fe446557._id = level.var_8d7f86d3.var_edd30eba;
    if (!isdefined(level.var_8d7f86d3.var_e324f60e)) {
        level.var_8d7f86d3.var_e324f60e = [];
    } else if (!isarray(level.var_8d7f86d3.var_e324f60e)) {
        level.var_8d7f86d3.var_e324f60e = array(level.var_8d7f86d3.var_e324f60e);
    }
    level.var_8d7f86d3.var_e324f60e[level.var_8d7f86d3.var_e324f60e.size] = var_fe446557;
    returnid = level.var_8d7f86d3.var_edd30eba;
    level.var_8d7f86d3.var_edd30eba++;
    return returnid;
}

// Namespace deployable/deployable
// Params 1, eflags: 0x0
// Checksum 0xc11e01c9, Offset: 0x630
// Size: 0xa0
function function_4b1687ca(zoneid) {
    for (index = 0; index < level.var_8d7f86d3.var_e324f60e.size; index++) {
        if (level.var_8d7f86d3.var_e324f60e[index]._id == zoneid) {
            level.var_8d7f86d3.var_e324f60e = array::remove_index(level.var_8d7f86d3.var_e324f60e, index, 0);
            break;
        }
    }
}

// Namespace deployable/deployable
// Params 1, eflags: 0x0
// Checksum 0x61d8a353, Offset: 0x6d8
// Size: 0xae
function function_c90a17ce(origin) {
    foreach (var_fe446557 in level.var_8d7f86d3.var_e324f60e) {
        if (distance2dsquared(var_fe446557.origin, origin) < var_fe446557.radiussqr) {
            return true;
        }
    }
    return false;
}

// Namespace deployable/deployable
// Params 2, eflags: 0x0
// Checksum 0xfd8ded1d, Offset: 0x790
// Size: 0x9c
function function_c0980d61(var_c04a97ea, deployable_weapon) {
    if (isdefined(level.var_33b45d0b)) {
        self [[ level.var_33b45d0b ]](deployable_weapon);
    }
    var_c04a97ea.weapon = deployable_weapon;
    var_c04a97ea thread function_9a01f62f();
    var_81f40084 = self gadgetgetslot(deployable_weapon);
    self function_6a67b266(var_81f40084, 0);
}

// Namespace deployable/deployable
// Params 1, eflags: 0x0
// Checksum 0x27c435fc, Offset: 0x838
// Size: 0x24
function function_2cefe05a(var_c04a97ea) {
    var_c04a97ea function_a11dac5();
}

// Namespace deployable/deployable
// Params 1, eflags: 0x0
// Checksum 0xc674d240, Offset: 0x868
// Size: 0x74
function function_76d9b29b(deployableweapon) {
    if (!isdefined(self)) {
        return;
    }
    var_81f40084 = self gadgetgetslot(deployableweapon);
    if (isdefined(deployableweapon)) {
        self function_6a67b266(var_81f40084, 0);
    }
    self setriotshieldfailhint();
}

// Namespace deployable/deployable
// Params 2, eflags: 0x0
// Checksum 0x7e007252, Offset: 0x8e8
// Size: 0x1c2
function function_c1fe55ef(deployable_weapon, sethintstring = 0) {
    player = self;
    if (deployable_weapon.var_49f876e1) {
        player function_d83e9f0e(1, (0, 0, 0), (0, 0, 0));
        return 1;
    }
    var_ad31a706 = player function_bb48412f(deployable_weapon, sethintstring);
    player.var_3f2d5683 = function_fcf5d5c7(deployable_weapon, sethintstring) && var_ad31a706.isvalid && function_efd8cf00(deployable_weapon, player, var_ad31a706.origin, var_ad31a706.angles);
    player setplacementhint(player.var_3f2d5683);
    player function_d83e9f0e(player.var_3f2d5683, var_ad31a706.origin, var_ad31a706.angles);
    player clientfield::set_to_player("gameplay_allows_deploy", player.var_3f2d5683);
    if (player.var_3f2d5683) {
        self.var_ac6d9bd1 = var_ad31a706.origin;
        self.var_fc43d05f = var_ad31a706.angles;
    } else {
        self.var_ac6d9bd1 = undefined;
        self.var_fc43d05f = undefined;
    }
    return player.var_3f2d5683;
}

// Namespace deployable/deployable
// Params 2, eflags: 0x4
// Checksum 0xf001192f, Offset: 0xab8
// Size: 0x9e
function private function_fcf5d5c7(weapon, sethintstring) {
    if (self isplayerswimming() && !(isdefined(weapon.canuseunderwater) ? weapon.canuseunderwater : 0)) {
        self sethintstring(#"hash_37605398dce96965");
        return false;
    }
    if (!self isonground()) {
        return false;
    }
    return true;
}

// Namespace deployable/deployable
// Params 2, eflags: 0x4
// Checksum 0xff5a7bd5, Offset: 0xb60
// Size: 0x2ce
function private function_bb48412f(deployable_weapon, sethintstring = 0) {
    var_337bf70d = level._deployable_weapons[deployable_weapon.statindex].var_ca61a5e0;
    if (!isdefined(var_337bf70d)) {
        results = self function_65c2da47(deployable_weapon);
    } else {
        results = [[ var_337bf70d ]](self);
    }
    assert(isdefined(results));
    assert(isdefined(results.isvalid));
    assert(isdefined(results.origin));
    assert(isdefined(results.angles));
    if (!isdefined(results.waterdepth)) {
        results.waterdepth = 0;
    }
    var_410a4e2a = 1;
    if (results.waterdepth > (isdefined(deployable_weapon.var_7f880c8e) ? deployable_weapon.var_7f880c8e : 0)) {
        self sethintstring(#"hash_37605398dce96965");
        results.isvalid = 0;
    } else if ((isdefined(results.waterdepth) ? results.waterdepth : 0) > 0 && isdefined(results.waterbottom)) {
        results.origin = results.waterbottom;
    }
    results.isvalid = results.isvalid && !oob::function_f84f2990(results.origin);
    results.isvalid = results.isvalid && function_2a9275c2(results.hitent);
    results.isvalid = results.isvalid && !function_c90a17ce(results.origin);
    results.isvalid = results.isvalid && !function_faeab28a(results.origin);
    return results;
}

// Namespace deployable/deployable
// Params 4, eflags: 0x4
// Checksum 0xbb66bbd3, Offset: 0xe38
// Size: 0x6c
function private function_efd8cf00(deployable_weapon, player, origin, angles) {
    var_a9d83861 = level._deployable_weapons[deployable_weapon.statindex].var_a9d83861;
    if (!isdefined(var_a9d83861)) {
        return 1;
    }
    return [[ var_a9d83861 ]](origin, angles, player);
}

// Namespace deployable/deployable
// Params 1, eflags: 0x4
// Checksum 0xd8c4896f, Offset: 0xeb0
// Size: 0xa0
function private function_f8ef5ac7(weapon) {
    player = self;
    if (level.time == player.var_9b10c6e7) {
        return;
    }
    player.var_9b10c6e7 = level.time;
    var_3f2d5683 = player function_c1fe55ef(weapon);
    if (!var_3f2d5683 && isdefined(level.var_57918348)) {
        player [[ level.var_57918348 ]](weapon);
    }
}

// Namespace deployable/deployable
// Params 0, eflags: 0x0
// Checksum 0xa6b41be7, Offset: 0xf58
// Size: 0xc
function location_valid() {
    return isdefined(self.var_ac6d9bd1);
}

// Namespace deployable/deployable
// Params 1, eflags: 0x0
// Checksum 0xf6b1a41f, Offset: 0xf70
// Size: 0x6a
function function_c334d8f9(owner) {
    if (isdefined(owner) && isdefined(owner.var_ac6d9bd1)) {
        self.origin = owner.var_ac6d9bd1;
    }
    if (isdefined(owner) && isdefined(owner.var_fc43d05f)) {
        self.angles = owner.var_fc43d05f;
    }
}

// Namespace deployable/deployable
// Params 0, eflags: 0x0
// Checksum 0xf9720e2c, Offset: 0xfe8
// Size: 0x64
function on_player_spawned() {
    self.var_9b10c6e7 = 0;
    self clientfield::set_to_player("gameplay_allows_deploy", 1);
    self thread function_41f2d3a();
    self callback::on_weapon_change(&on_weapon_change);
}

// Namespace deployable/deployable
// Params 0, eflags: 0x4
// Checksum 0x4831aef6, Offset: 0x1058
// Size: 0x288
function private function_41f2d3a() {
    player = self;
    player endon(#"death", #"disconnect");
    player notify(#"hash_47917fb2887353f2");
    player endon(#"hash_47917fb2887353f2");
    wait 1;
    player clientfield::set_to_player("gameplay_allows_deploy", 1);
    var_2ec43bab = 0;
    gameplay_allows_deploy = 1;
    var_bffb3ba7 = 0;
    while (true) {
        if (!var_2ec43bab) {
            wait 0.2;
        } else {
            waitframe(1);
        }
        if (!gameplay_allows_deploy) {
            player setplacementhint(1);
            gameplay_allows_deploy = 1;
        }
        var_2ec43bab = 0;
        deployable_weapon = undefined;
        if (player isusingoffhand()) {
            deployable_weapon = player getcurrentoffhand();
        } else {
            deployable_weapon = player getcurrentweapon();
        }
        if (!deployable_weapon.deployable || deployable_weapon.var_49f876e1) {
            if (var_bffb3ba7) {
                player sethintstring("");
                var_bffb3ba7 = 0;
            }
            continue;
        }
        var_2ec43bab = 1;
        var_bffb3ba7 = 1;
        var_3f2d5683 = player function_c1fe55ef(deployable_weapon);
        if (var_3f2d5683) {
            if (isdefined(level._deployable_weapons[deployable_weapon.statindex].placehintstr)) {
                player sethintstring(level._deployable_weapons[deployable_weapon.statindex].placehintstr);
            }
            continue;
        }
        if (isdefined(level._deployable_weapons[deployable_weapon.statindex].var_9f526638)) {
            player sethintstring(level._deployable_weapons[deployable_weapon.statindex].var_9f526638);
        }
    }
}

// Namespace deployable/deployable
// Params 1, eflags: 0x0
// Checksum 0xb013ff03, Offset: 0x12e8
// Size: 0x8e
function function_2a9275c2(entity) {
    if (!isdefined(entity)) {
        return true;
    }
    if (isvehicle(entity) || isai(entity) || entity ismovingplatform()) {
        return false;
    }
    if (isdefined(entity.weapon) || isdefined(entity.killstreakid)) {
        return false;
    }
    return true;
}

// Namespace deployable/deployable
// Params 5, eflags: 0x0
// Checksum 0xa024fccb, Offset: 0x1380
// Size: 0xa4e
function function_50e68132(client_pos, client_angles, var_c3153045, previs_weapon, ignore_entity) {
    results = spawnstruct();
    var_6efea0d9 = 0;
    var_1f54cf98 = 0;
    var_4c970e80 = 0;
    var_f300e118 = 0;
    var_7bcb1d63 = 0;
    var_df4df01e = 0;
    var_2d2e3319 = 2;
    var_c7f00507 = (0, 0, 0);
    var_ae83a669 = (0, 0, 0);
    forward = anglestoforward(client_angles);
    var_a42f0eda = previs_weapon.var_993e4b3a;
    if (previs_weapon.var_f2ffe344 && previs_weapon.var_e3e58b4e > previs_weapon.var_993e4b3a) {
        var_a42f0eda = previs_weapon.var_e3e58b4e;
    }
    trace_distance = var_a42f0eda / abs(cos(client_angles[0]));
    forward_vector = vectorscale(forward, trace_distance);
    trace_start = var_c3153045;
    trace_result = bullettrace(trace_start, trace_start + forward_vector, 0, ignore_entity);
    hit_location = trace_start + forward_vector;
    hit_normal = (0, 0, 1);
    hit_distance = 10;
    var_df7cd762 = previs_weapon.var_f2ffe344;
    hitent = undefined;
    var_2d3111bb = 0;
    if (trace_result[#"fraction"] < 1) {
        hit_location = trace_result[#"position"];
        hit_normal = trace_result[#"normal"];
        var_98813d36 = hit_normal[2] < 0.7;
        hit_distance = trace_result[#"fraction"] * trace_distance;
        if (distance2dsquared(client_pos, hit_location) < previs_weapon.var_993e4b3a * previs_weapon.var_993e4b3a) {
            var_1f54cf98 = 1;
        }
        height_offset = hit_location[2] - client_pos[2];
        if (var_df7cd762 && var_98813d36) {
            if (height_offset <= previs_weapon.var_efa152d3 && height_offset >= previs_weapon.var_2a478d1) {
                var_4c970e80 = 1;
            }
            var_f300e118 = 1;
            wall_dot = vectordot(forward * -1, hit_normal);
            if (wall_dot > cos(previs_weapon.var_d8a5de46)) {
                var_7bcb1d63 = 1;
            }
            if (!var_7bcb1d63) {
                var_2d3111bb = 1;
            }
            hitent = trace_result[#"entity"];
        } else {
            if (height_offset <= previs_weapon.var_9a21053b && height_offset >= previs_weapon.var_2a478d1) {
                var_4c970e80 = 1;
            }
            out_of_range = hit_distance > previs_weapon.var_993e4b3a;
            if (out_of_range) {
                var_2d3111bb = 1;
            }
            if (!var_df7cd762 && var_98813d36) {
                hit_location = client_pos + (forward_vector[0], forward_vector[1], 0) * trace_result[#"fraction"];
                hit_normal = (0, 0, 1);
                var_df4df01e = 1;
                var_2d3111bb = 0;
            }
        }
    } else {
        var_2d3111bb = 1;
    }
    water_depth = 0;
    water_bottom = hit_location;
    if (var_2d3111bb) {
        forward2d = anglestoforward((0, client_angles[1], 0));
        var_993e4b3a = previs_weapon.var_993e4b3a;
        var_63c1a56f = client_pos + (0, 0, previs_weapon.var_9a21053b);
        var_a1d55004 = var_63c1a56f + forward2d * var_993e4b3a;
        var_b36eac72 = bullettrace(var_63c1a56f, var_a1d55004, 0, ignore_entity);
        if (var_b36eac72[#"fraction"] > 0) {
            var_993e4b3a = previs_weapon.var_993e4b3a * var_b36eac72[#"fraction"] - var_2d2e3319;
            ground_trace_start = client_pos + forward2d * var_993e4b3a + (0, 0, previs_weapon.var_9a21053b);
            ground_trace_end = ground_trace_start - (0, 0, previs_weapon.var_9a21053b - previs_weapon.var_2a478d1);
            var_d08e5796 = groundtrace(ground_trace_start, ground_trace_end, 0, ignore_entity);
            hitent = var_d08e5796[#"entity"];
            if (var_d08e5796[#"fraction"] > 0.01 && var_d08e5796[#"fraction"] < 1 && var_d08e5796[#"normal"][2] > 0.9) {
                hit_location = var_d08e5796[#"position"];
                hit_normal = var_d08e5796[#"normal"];
                hit_distance = var_d08e5796[#"fraction"] * var_993e4b3a;
                var_1f54cf98 = 1;
                var_4c970e80 = 1;
                if (isdefined(var_d08e5796[#"waterdepth"])) {
                    water_depth = var_d08e5796[#"waterdepth"];
                    water_bottom = var_d08e5796[#"waterbottom"];
                }
            }
        }
    }
    if (isdefined(hit_location)) {
        var_c7f00507 = hit_location;
        if (hit_normal[2] < 0.7) {
            var_a249c14f = angleclamp180(vectortoangles(hit_normal)[0] + 90);
            var_20702254 = vectortoangles(hit_normal)[1];
            var_df6f264e = 0;
        } else {
            hit_angles = vectortoangles(hit_normal);
            var_20702254 = client_angles[1];
            pitch = angleclamp180(hit_angles[0] + 90);
            var_cef64081 = absangleclamp360(hit_angles[1] - client_angles[1]);
            var_624fa542 = cos(var_cef64081);
            var_d091d485 = sin(var_cef64081) * -1;
            var_a249c14f = pitch * var_624fa542;
            var_df6f264e = pitch * var_d091d485;
        }
        var_ae83a669 = (var_a249c14f, var_20702254, var_df6f264e);
    }
    var_6efea0d9 = var_1f54cf98 && var_4c970e80 && (!var_f300e118 || var_7bcb1d63) && !var_df4df01e;
    if (var_6efea0d9 && !(isdefined(previs_weapon.var_7460107b) && previs_weapon.var_7460107b)) {
        var_7f8d4f3 = var_c7f00507 + (0, 0, 1) * 30;
        var_cf48c09f = physicstrace(var_c3153045, var_7f8d4f3, (-16, -16, -16), (16, 16, 16), ignore_entity);
        var_6efea0d9 = var_cf48c09f[#"fraction"] == 1;
    }
    results.isvalid = var_6efea0d9;
    results.origin = var_c7f00507;
    results.angles = var_ae83a669;
    results.hitent = hitent;
    results.waterdepth = water_depth;
    results.waterbottom = water_bottom;
    return results;
}

// Namespace deployable/deployable
// Params 1, eflags: 0x4
// Checksum 0x897b517a, Offset: 0x1dd8
// Size: 0x44
function private on_weapon_change(params) {
    self setplacementhint(1);
    self clientfield::set_to_player("gameplay_allows_deploy", 1);
}

// Namespace deployable/deployable
// Params 0, eflags: 0x0
// Checksum 0x6e7fef45, Offset: 0x1e28
// Size: 0x80
function function_9a01f62f() {
    self endon(#"death");
    self.var_67ba89f5 = [];
    while (true) {
        waitresult = self waittill(#"grenade_stuck");
        if (isdefined(waitresult.projectile)) {
            array::add(self.var_67ba89f5, waitresult.projectile);
        }
    }
}

// Namespace deployable/deployable
// Params 0, eflags: 0x0
// Checksum 0x4cc59b5f, Offset: 0x1eb0
// Size: 0xb0
function function_a11dac5() {
    if (!isdefined(self.var_67ba89f5)) {
        return;
    }
    foreach (var_55e2e87a in self.var_67ba89f5) {
        if (!isdefined(var_55e2e87a)) {
            continue;
        }
        var_55e2e87a dodamage(500, self.origin, undefined, undefined, undefined, "MOD_EXPLOSIVE");
    }
}

