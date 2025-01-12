#using script_3819e7a1427df6d2;
#using scripts\core_common\ai\archetype_cover_utility;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicleriders_shared;

#namespace turret;

// Namespace turret/turret_shared
// Params 0, eflags: 0x6
// Checksum 0x70fa9ea, Offset: 0x398
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"turret", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace turret/turret_shared
// Params 0, eflags: 0x5 linked
// Checksum 0x987c0878, Offset: 0x3e0
// Size: 0x5c
function private function_70a657d8() {
    clientfield::register("vehicle", "toggle_lensflare", 1, 1, "int");
    level._turrets = spawnstruct();
    registerbehaviorscriptfunctions();
}

// Namespace turret/turret_shared
// Params 0, eflags: 0x5 linked
// Checksum 0xcf784097, Offset: 0x448
// Size: 0x274
function private registerbehaviorscriptfunctions() {
    assert(isscriptfunctionptr(&function_2c6be6cd));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4da9c87ccb6a9163", &function_2c6be6cd);
    assert(isscriptfunctionptr(&function_90e78f70));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_38b92465454460ba", &function_90e78f70);
    assert(isscriptfunctionptr(&function_38388863));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_400342bceb3fa64e", &function_38388863);
    assert(isscriptfunctionptr(&function_67483ee1));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_211d5dc0934a1e5a", &function_67483ee1);
    assert(isscriptfunctionptr(&function_3628f3da));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2eef1e8d94fa0609", &function_3628f3da);
    assert(isscriptfunctionptr(&function_a979d828));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2cf0541596d5c795", &function_a979d828);
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x5 linked
// Checksum 0x9655e8f3, Offset: 0x6c8
// Size: 0x2a
function private function_2c6be6cd(entity) {
    return entity flag::get(#"hash_1b89f498c2647e6");
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x5 linked
// Checksum 0xb42d08f3, Offset: 0x700
// Size: 0x2a
function private function_90e78f70(entity) {
    return entity flag::get(#"hash_79f73bc0bf703a5d");
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x5 linked
// Checksum 0xbbfabdb4, Offset: 0x738
// Size: 0x18
function private function_38388863(entity) {
    return isdefined(entity.var_2df45b5d);
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x5 linked
// Checksum 0x922aa309, Offset: 0x758
// Size: 0xf2
function private function_67483ee1(entity) {
    aiutility::keepclaimnode(entity);
    if (isdefined(entity.s_turret)) {
        s_turret = entity.s_turret;
        n_index = s_turret.n_index;
        var_d64a504a = s_turret.e_parent;
        s_turret.e_last_target = s_turret.target;
        var_d64a504a function_14223170(n_index);
        var_d64a504a clear_target(n_index);
        var_d64a504a pause(0, n_index);
        var_d64a504a turretsettargetangles(n_index, (0, 0, 0));
        s_turret.var_aa100948 = 1;
    }
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x5 linked
// Checksum 0xed3ac511, Offset: 0x858
// Size: 0xc8
function private function_a979d828(entity) {
    aiutility::resetcoverparameters(entity);
    if (isdefined(entity.s_turret)) {
        s_turret = entity.s_turret;
        n_index = s_turret.n_index;
        var_d64a504a = s_turret.e_parent;
        s_turret.var_aa100948 = 0;
        var_d64a504a unpause(n_index);
        var_d64a504a set_target(s_turret.e_last_target);
        s_turret notify(#"hash_1144f19c16dc1d63");
    }
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x5 linked
// Checksum 0xf3e6a81c, Offset: 0x928
// Size: 0x16
function private function_3628f3da(entity) {
    entity.var_2df45b5d = undefined;
}

// Namespace turret/turret_shared
// Params 12, eflags: 0x5 linked
// Checksum 0xa7fc39ec, Offset: 0x948
// Size: 0xc6
function private function_d72fcb0a(*einflictor, *eattacker, idamage, *idflags, *smeansofdeath, *weapon, *vpoint, *vdir, *shitloc, *psoffsettime, *boneindex, *modelindex) {
    if (isdefined(self.var_72f4d1b7)) {
        level.var_d7e2833c = self.var_72f4d1b7 > 1;
        modelindex = int(self.var_72f4d1b7 * modelindex);
        if (modelindex < 1) {
            modelindex = 1;
        }
    }
    return modelindex;
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x9a3c3dc3, Offset: 0xa18
// Size: 0x5a
function get_weapon(n_index = 0) {
    if (!isalive(self)) {
        return level.weaponnone;
    }
    w_weapon = self seatgetweapon(n_index);
    return w_weapon;
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0xdd806e96, Offset: 0xa80
// Size: 0x2a
function get_parent(n_index) {
    return _get_turret_data(n_index).e_parent;
}

// Namespace turret/turret_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x310becfa, Offset: 0xab8
// Size: 0x54
function laser_death_watcher() {
    self notify(#"laser_death_thread_stop");
    self endon(#"laser_death_thread_stop");
    self waittill(#"death");
    if (isdefined(self)) {
        self laseroff();
    }
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0x639648c7, Offset: 0xb18
// Size: 0xa6
function enable_laser(b_enable, n_index) {
    if (b_enable) {
        _get_turret_data(n_index).has_laser = 1;
        self laseron();
        self thread laser_death_watcher();
        return;
    }
    _get_turret_data(n_index).has_laser = undefined;
    self laseroff();
    self notify(#"laser_death_thread_stop");
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xdeb281b, Offset: 0xbc8
// Size: 0x158
function emp_watcher(n_index) {
    self notify(#"emp_thread_stop");
    self endon(#"emp_thread_stop", #"death");
    while (true) {
        waitresult = self waittill(#"damage");
        if (waitresult.weapon.isemp) {
            if (is_true(self.emped)) {
                continue;
            }
            self.emped = 1;
            if (isdefined(_get_turret_data(n_index).has_laser)) {
                self laseroff();
            }
            stop(n_index, 1);
            wait randomfloatrange(5, 7);
            self.emped = undefined;
            if (isdefined(_get_turret_data(n_index).has_laser)) {
                self laseron();
            }
        }
    }
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0xc00c2b1a, Offset: 0xd28
// Size: 0x86
function enable_emp(b_enable, n_index) {
    if (b_enable) {
        _get_turret_data(n_index).can_emp = 1;
        self thread emp_watcher(n_index);
        return;
    }
    _get_turret_data(n_index).can_emp = undefined;
    self notify(#"emp_thread_stop");
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x94bb48b0, Offset: 0xdb8
// Size: 0x3e
function set_team(str_team, n_index) {
    _get_turret_data(n_index).str_team = str_team;
    self.team = str_team;
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0xba6bff67, Offset: 0xe00
// Size: 0x62
function get_team(n_index) {
    str_team = undefined;
    s_turret = _get_turret_data(n_index);
    str_team = self.team;
    if (!isdefined(s_turret.str_team)) {
        s_turret.str_team = str_team;
    }
    return str_team;
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xe218c296, Offset: 0xe70
// Size: 0x2a
function is_turret_enabled(n_index) {
    return _get_turret_data(n_index).is_enabled;
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x58657e8f, Offset: 0xea8
// Size: 0x3a
function does_need_user(n_index) {
    return is_true(_get_turret_data(n_index).b_needs_user);
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x96ae5eba, Offset: 0xef0
// Size: 0x32
function does_have_user(n_index) {
    return isalive(get_user(n_index));
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x72042866, Offset: 0xf30
// Size: 0x22
function get_user(n_index) {
    return self getseatoccupant(n_index);
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xd084956b, Offset: 0xf60
// Size: 0x42
function _set_turret_needs_user(n_index, b_needs_user) {
    s_turret = _get_turret_data(n_index);
    s_turret.b_needs_user = b_needs_user;
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0x4fbfc60a, Offset: 0xfb0
// Size: 0x56
function is_current_user(ai_user, n_index) {
    ai_current_user = get_user(n_index);
    return isalive(ai_current_user) && ai_user == ai_current_user;
}

// Namespace turret/turret_shared
// Params 5, eflags: 0x0
// Checksum 0xd032f69, Offset: 0x1010
// Size: 0x7e
function set_burst_parameters(n_fire_min, n_fire_max, n_wait_min, n_wait_max, n_index) {
    s_turret = _get_turret_data(n_index);
    s_turret.n_burst_fire_min = n_fire_min;
    s_turret.n_burst_fire_max = n_fire_max;
    s_turret.n_burst_wait_min = n_wait_min;
    s_turret.n_burst_wait_max = n_wait_max;
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xae943ea5, Offset: 0x1098
// Size: 0x52
function set_torso_targetting(n_index, n_torso_targetting_offset = -12) {
    s_turret = _get_turret_data(n_index);
    s_turret.n_torso_targetting_offset = n_torso_targetting_offset;
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x1a632296, Offset: 0x10f8
// Size: 0x52
function set_target_leading(n_index, n_target_leading_factor = 0.1) {
    s_turret = _get_turret_data(n_index);
    s_turret.n_target_leading_factor = n_target_leading_factor;
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x9ba7daf0, Offset: 0x1158
// Size: 0x3c
function set_on_target_angle(n_angle, n_index = 0) {
    self turretsetontargettolerance(n_index, n_angle);
}

// Namespace turret/turret_shared
// Params 5, eflags: 0x1 linked
// Checksum 0xa6759466, Offset: 0x11a0
// Size: 0x19a
function set_target(target, v_offset, n_index = 0, var_6bfa76e = 0, var_d55528ca = 0) {
    self endon(#"death");
    if (!isdefined(target)) {
        clear_target(n_index);
        return 0;
    }
    if (!isentity(target) && !isvec(target) || is_true(target.ignoreme)) {
        return 0;
    }
    s_turret = _get_turret_data(n_index);
    if (!isdefined(v_offset)) {
        v_offset = _get_default_target_offset(target, n_index);
    }
    s_turret.last_target = s_turret.target;
    s_turret.e_next_target = target;
    s_turret.target = target;
    s_turret.v_offset = v_offset;
    s_turret.var_f351ad56 = var_6bfa76e;
    s_turret.var_d55528ca = var_d55528ca;
    self turretsettarget(n_index, target, v_offset);
    return function_12269140(target, n_index);
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x5 linked
// Checksum 0x25ca091a, Offset: 0x1348
// Size: 0x266
function private _get_default_target_offset(e_target, n_index) {
    s_turret = _get_turret_data(n_index);
    if (s_turret.str_weapon_type == "bullet") {
        if (isdefined(e_target)) {
            if (isplayer(e_target)) {
                z_offset = 0;
            } else if (e_target.type === "human") {
                z_offset = randomintrange(20, 60);
            } else if (e_target.type === "robot") {
                z_offset = randomintrange(40, 60);
            } else if (issentient(self) && issentient(e_target)) {
                z_offset = isdefined(s_turret.n_torso_targetting_offset) ? s_turret.n_torso_targetting_offset : isvehicle(e_target) ? 0 : 0;
            }
            if (isdefined(e_target.z_target_offset_override)) {
                if (!isdefined(z_offset)) {
                    z_offset = 0;
                }
                z_offset += e_target.z_target_offset_override;
            }
        }
    }
    if (!isdefined(z_offset)) {
        z_offset = 0;
    }
    v_offset = (0, 0, z_offset);
    if ((isdefined(s_turret.n_target_leading_factor) ? s_turret.n_target_leading_factor : 0) != 0 && isdefined(e_target) && issentient(self) && issentient(e_target) && !isvehicle(e_target)) {
        velocity = e_target getvelocity();
        v_offset += velocity * s_turret.n_target_leading_factor;
    }
    return v_offset;
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xd88c45e, Offset: 0x15b8
// Size: 0x36
function get_target(n_index) {
    s_turret = _get_turret_data(n_index);
    return s_turret.target;
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xfe0bc64f, Offset: 0x15f8
// Size: 0xae
function is_target(target, n_index) {
    current_target = get_target(n_index);
    if (isdefined(current_target) && (isentity(target) && isentity(current_target) || isvec(target) && isvec(current_target))) {
        return (current_target == target);
    }
    return false;
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x461ff846, Offset: 0x16b0
// Size: 0x8c
function clear_target(n_index = 0) {
    s_turret = _get_turret_data(n_index);
    s_turret.e_next_target = undefined;
    s_turret.target = undefined;
    s_turret.var_50fbd548 = undefined;
    s_turret.var_d55528ca = 0;
    s_turret.var_f351ad56 = 0;
    self turretcleartarget(n_index);
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0xd99640d4, Offset: 0x1748
// Size: 0x4a
function function_49c3b892(e_target, n_index = 0) {
    s_turret = _get_turret_data(n_index);
    s_turret.favoriteenemy = e_target;
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0xcb8fe3d3, Offset: 0x17a0
// Size: 0x3e
function get_favorite_enemy(n_index = 0) {
    s_turret = _get_turret_data(n_index);
    return s_turret.favoriteenemy;
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0xe292064a, Offset: 0x17e8
// Size: 0x4a
function function_41c79ce4(b_enable, n_index = 0) {
    s_turret = _get_turret_data(n_index);
    s_turret.perfectaim = b_enable;
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0x1f2396b, Offset: 0x1840
// Size: 0x42
function set_min_target_distance_squared(n_distance_squared, n_index) {
    s_turret = _get_turret_data(n_index);
    s_turret.n_min_target_distance_squared = n_distance_squared;
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x9eca4e26, Offset: 0x1890
// Size: 0x98
function function_9c04d437(var_6a56e517, n_index = 0) {
    s_turret = _get_turret_data(n_index);
    s_turret flag::set("turret manual");
    if (is_true(var_6a56e517)) {
        self notify("turret manual" + _index(n_index));
    }
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xaabcd7ea, Offset: 0x1930
// Size: 0x54
function function_21827343(n_index = 0) {
    s_turret = _get_turret_data(n_index);
    s_turret flag::clear("turret manual");
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0x14966d1a, Offset: 0x1990
// Size: 0x4a
function function_3e5395(n_seconds, n_index = 0) {
    s_turret = _get_turret_data(n_index);
    s_turret.var_b52bbdba = n_seconds;
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0xafe03d7b, Offset: 0x19e8
// Size: 0x82
function function_30a9811a(n_scale, n_index = 0) {
    assert(isdefined(n_scale) && n_scale > 0, "<dev string:x38>");
    s_turret = _get_turret_data(n_index);
    s_turret.var_72f4d1b7 = n_scale;
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x466a6bd9, Offset: 0x1a78
// Size: 0x19e
function fire(n_index) {
    s_turret = _get_turret_data(n_index);
    assert(isdefined(n_index) && n_index >= 0, "<dev string:x83>");
    e_target = isentity(s_turret.target) ? s_turret.target : undefined;
    self.forcefire = is_true(s_turret.var_d55528ca);
    self.var_742d1a8f = is_true(s_turret.var_2890139c);
    if (n_index == 0) {
        self fireweapon(0, e_target);
    } else {
        ai_current_user = get_user(n_index);
        if (isdefined(ai_current_user) && is_true(ai_current_user.is_disabled)) {
            return;
        }
        if (isdefined(e_target)) {
            self turretsettarget(n_index, e_target, s_turret.v_offset);
        }
        self fireweapon(n_index, e_target, s_turret.v_offset, s_turret.e_parent);
    }
    s_turret.n_last_fire_time = gettime();
}

// Namespace turret/turret_shared
// Params 3, eflags: 0x1 linked
// Checksum 0x1ee41d91, Offset: 0x1c20
// Size: 0x1b6
function fire_for_time(n_time, n_index = 0, var_7cd5e5c = "unused") {
    self endon(var_7cd5e5c, #"terminate_all_turrets_firing", #"death", "_stop_turret" + _index(n_index), "turret_disabled" + _index(n_index), "turret manual" + _index(n_index));
    var_17b7891d = "7f41507a84782a1e" + _index(n_index);
    self notify(var_17b7891d);
    self endon(var_17b7891d);
    s_turret = _get_turret_data(n_index);
    w_weapon = get_weapon(n_index);
    n_fire_time = w_weapon.firetime;
    var_f612cac5 = 0;
    var_23ec945b = floor(abs(n_time / n_fire_time));
    while (var_f612cac5 < var_23ec945b) {
        if (n_time > 0) {
            var_f612cac5++;
        }
        self fire(n_index);
        wait n_fire_time;
    }
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xc5d0bf81, Offset: 0x1de0
// Size: 0xc4
function stop(n_index, b_clear_target = 0) {
    s_turret = _get_turret_data(n_index);
    s_turret.e_next_target = undefined;
    s_turret.target = undefined;
    function_21827343(n_index);
    if (b_clear_target) {
        clear_target(n_index);
    }
    self notify("_stop_turret" + _index(n_index));
    function_14223170(n_index);
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xd0648e4b, Offset: 0x1eb0
// Size: 0x20c
function get_in(var_34b21e8e, n_index = 0) {
    if (isalive(var_34b21e8e) && !is_true(var_34b21e8e islinkedto(self))) {
        self usevehicle(var_34b21e8e, n_index);
        var_34b21e8e flag::set(#"hash_1b89f498c2647e6");
        var_34b21e8e.allowpain = 1;
        var_34b21e8e.blockingpain = 0;
        /#
            if (!is_true(var_34b21e8e islinkedto(self))) {
                var_34b21e8e linkto(self);
                println("<dev string:xb6>" + n_index + "<dev string:xf8>" + self.model + "<dev string:x104>");
            }
        #/
        self enable(n_index, 1);
        s_turret = _get_turret_data(n_index);
        var_34b21e8e.s_turret = s_turret;
        var_34b21e8e.var_72f4d1b7 = s_turret.var_72f4d1b7;
        var_34b21e8e.var_41adb97 = undefined;
        aiutility::addaioverridedamagecallback(var_34b21e8e, &function_d72fcb0a);
        self thread handle_rider_death(var_34b21e8e, n_index);
        self thread function_2c718f9e(var_34b21e8e, n_index);
        self thread function_738effc8(var_34b21e8e, n_index);
    }
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x5 linked
// Checksum 0xbf14b8a, Offset: 0x20c8
// Size: 0xd8
function private function_2c718f9e(var_34b21e8e, n_index) {
    self endon(#"death", "turret_disabled" + _index(n_index));
    var_34b21e8e endon(#"death");
    s_turret = _get_turret_data(n_index);
    while (true) {
        var_34b21e8e waittill(#"pain");
        self usevehicle(var_34b21e8e, n_index);
        s_turret waittill(#"hash_1144f19c16dc1d63");
        self usevehicle(var_34b21e8e, n_index);
    }
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x5 linked
// Checksum 0xf3d61d63, Offset: 0x21a8
// Size: 0x6c
function private function_738effc8(var_34b21e8e, n_index) {
    self endon(#"death");
    var_34b21e8e endon(#"death");
    var_34b21e8e waittill(#"goal_changed");
    self _drop_turret(n_index);
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x39115d3d, Offset: 0x2220
// Size: 0x220
function get_out(var_34b21e8e, n_index = 0) {
    /#
        if (getdvarint(#"hash_47a40f04e7c48117", 0)) {
            return;
        }
    #/
    if (isalive(var_34b21e8e) && var_34b21e8e islinkedto(self)) {
        self usevehicle(var_34b21e8e, n_index);
        var_34b21e8e flag::clear(#"hash_1b89f498c2647e6");
        var_34b21e8e.s_turret = undefined;
        var_34b21e8e.var_72f4d1b7 = undefined;
        aiutility::releaseclaimnode(var_34b21e8e);
        aiutility::choosebestcovernodeasap(var_34b21e8e);
        if (isdefined(var_34b21e8e.aioverridedamage)) {
            aiutility::removeaioverridedamagecallback(var_34b21e8e, &function_d72fcb0a);
        }
        var_3b228fdf = isdefined(var_34b21e8e.node) && var_34b21e8e.node.type == "Turret";
        var_3b228fdf |= isdefined(var_34b21e8e.covernode) && var_34b21e8e.covernode.type == "Turret";
        if (var_3b228fdf) {
            var_34b21e8e.var_41adb97 = gettime() + 4000;
            var_34b21e8e setgoal(var_34b21e8e.origin, 0, var_34b21e8e.goalradius);
        }
        self disable(n_index);
        self notify(#"exit_vehicle");
        var_34b21e8e notify(#"exit_vehicle");
    }
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xeeee14bf, Offset: 0x2448
// Size: 0xf4
function handle_rider_death(ai_rider, n_index = 0) {
    self endon(#"death", "turret_disabled" + _index(n_index));
    ai_rider waittill(#"death");
    if (ai_rider flag::get(#"hash_1b89f498c2647e6")) {
        ai_rider flag::clear(#"hash_1b89f498c2647e6");
        ai_rider flag::set(#"hash_79f73bc0bf703a5d");
    }
    self get_out(ai_rider, n_index);
    self disable(n_index);
}

// Namespace turret/turret_shared
// Params 4, eflags: 0x0
// Checksum 0x5ab7ec91, Offset: 0x2548
// Size: 0x154
function function_1bc8c31c(target, v_offset, n_index = 0, b_just_once = 0) {
    assert(isdefined(target), "<dev string:x11a>");
    function_9c04d437(1, n_index);
    self endon(#"drone_death", #"death", "_stop_turret" + _index(n_index), "turret_disabled" + _index(n_index), #"terminate_all_turrets_firing", #"exit_vehicle", "turret manual" + _index(n_index));
    function_14223170(n_index);
    _shoot_turret_at_target(target, v_offset, n_index, b_just_once);
    function_21827343(n_index);
}

// Namespace turret/turret_shared
// Params 5, eflags: 0x0
// Checksum 0x8edc1572, Offset: 0x26a8
// Size: 0x30c
function function_aecc6bed(var_502298b8, var_f612cac5, n_index = 0, var_c3e16ce = undefined, var_702f0a7e = undefined) {
    assert(isarray(var_502298b8), "<dev string:x14b>");
    assert(var_f612cac5 > 0, "<dev string:x180>");
    var_17b7891d = "39fa7aca58ded5b8" + _index(n_index);
    self notify(var_17b7891d);
    self endon(var_17b7891d);
    function_9c04d437(1, n_index);
    self endon(#"drone_death", #"death", "_stop_turret" + _index(n_index), "turret_disabled" + _index(n_index), #"terminate_all_turrets_firing", #"exit_vehicle", "turret manual" + _index(n_index));
    w_weapon = get_weapon(n_index);
    n_fire_time = isdefined(var_c3e16ce) ? var_c3e16ce : w_weapon.firetime;
    function_14223170(n_index);
    foreach (point in var_502298b8) {
        v_origin = isvec(point) ? point : point.origin;
        if (!set_target(v_origin, undefined, n_index)) {
            continue;
        }
        function_259e1449(n_index);
        for (shots = 0; shots < var_f612cac5; shots++) {
            fire(n_index);
            wait n_fire_time;
        }
        if (isdefined(var_702f0a7e)) {
            wait var_702f0a7e;
        }
    }
    function_21827343(n_index);
}

// Namespace turret/turret_shared
// Params 3, eflags: 0x0
// Checksum 0xa71cae89, Offset: 0x29c0
// Size: 0x204
function function_d1ba6eb6(v_start, v_end, n_index = 0) {
    assert(isdefined(v_start) && isdefined(v_end), "<dev string:x1b8>");
    var_17b7891d = "41e7a34cbad85465" + _index(n_index);
    self notify(var_17b7891d);
    self endon(var_17b7891d);
    function_9c04d437(1, n_index);
    self endon(#"drone_death", #"death", "_stop_turret" + _index(n_index), "turret_disabled" + _index(n_index), #"terminate_all_turrets_firing", #"exit_vehicle", "turret manual" + _index(n_index));
    w_weapon = get_weapon(n_index);
    n_fire_time = w_weapon.firetime;
    function_14223170(n_index);
    if (set_target(v_start, undefined, n_index)) {
        function_259e1449(n_index);
        set_target(v_end, undefined, n_index);
        fire_for_time(-1, n_index, function_a8d258ca(n_index));
    }
    function_21827343(n_index);
}

// Namespace turret/turret_shared
// Params 4, eflags: 0x5 linked
// Checksum 0x7da760df, Offset: 0x2bd0
// Size: 0x384
function private _shoot_turret_at_target(target, v_offset, n_index, b_just_once) {
    if (isentity(target)) {
        target endon(#"death");
    }
    self endon(#"drone_death", #"death", "_stop_turret" + _index(n_index), "turret_disabled" + _index(n_index), #"terminate_all_turrets_firing", #"exit_vehicle", "turret manual" + _index(n_index));
    if (!isdefined(b_just_once)) {
        b_just_once = 0;
    }
    s_turret = _get_turret_data(n_index);
    if (s_turret.n_burst_time < s_turret.n_burst_fire_time) {
        return;
    } else {
        n_time_since_last_shot = float(gettime() - s_turret.n_last_fire_time) / 1000;
        if (n_time_since_last_shot < s_turret.n_burst_wait) {
            wait s_turret.n_burst_wait - n_time_since_last_shot;
        }
    }
    var_17b7891d = "5d8bd242e0a7b31a" + _index(n_index);
    self notify(var_17b7891d);
    self endon(var_17b7891d);
    if (is_true(s_turret.var_cd8600bd) && !can_hit_target(target, n_index)) {
        return;
    }
    set_target(target, v_offset, n_index, s_turret.var_f351ad56, 0);
    if (!isdefined(self.aim_only_no_shooting)) {
        function_259e1449(n_index);
        if (b_just_once) {
            fire(n_index);
            return;
        }
        var_e7a43ab0 = !is_true(s_turret.var_cd8600bd) || can_hit_target(target, n_index);
        if (var_e7a43ab0) {
            self thread _burst_fire(n_index);
        }
        while (s_turret.n_burst_time < s_turret.n_burst_fire_time) {
            while (can_hit_target(target, n_index)) {
                set_target(target, v_offset, n_index, s_turret.var_f351ad56, 0);
                s_turret.var_50fbd548 = target.origin;
                wait s_turret.var_b52bbdba;
            }
            if (isdefined(s_turret.var_50fbd548)) {
                set_target(s_turret.var_50fbd548, v_offset, n_index, 0, 1);
            }
            wait s_turret.var_b52bbdba;
        }
    }
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x5 linked
// Checksum 0xefd1ecbb, Offset: 0x2f60
// Size: 0x32
function private function_a8d258ca(n_index) {
    if (!isdefined(n_index) || n_index == 0) {
        return "turret_on_target";
    }
    return "gunner_turret_on_target";
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x8c4836e6, Offset: 0x2fa0
// Size: 0x6a
function function_259e1449(n_index) {
    wait isdefined(self.waittill_turret_on_target_delay) ? self.waittill_turret_on_target_delay : float(function_60d95f53()) / 1000;
    self waittill(function_a8d258ca(n_index));
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xcf364936, Offset: 0x3018
// Size: 0x52
function function_38841344(e_target, n_index) {
    do {
        function_259e1449(n_index);
    } while (isdefined(e_target) && !can_hit_target(e_target, n_index));
}

// Namespace turret/turret_shared
// Params 3, eflags: 0x1 linked
// Checksum 0xf61a7ca8, Offset: 0x3078
// Size: 0xd8
function enable(n_index, b_user_required, v_offset) {
    if (isalive(self) && !is_turret_enabled(n_index)) {
        _get_turret_data(n_index).is_enabled = 1;
        _set_turret_needs_user(n_index, is_true(b_user_required));
        self thread _turret_think(n_index, v_offset);
        self notify("turret_enabled" + _index(n_index));
    }
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0xe78ea09c, Offset: 0x3158
// Size: 0x2a
function enable_auto_use(b_enable = 1) {
    self.script_auto_use = b_enable;
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0xf51a67e, Offset: 0x3190
// Size: 0x42
function disable_ai_getoff(n_index, b_disable = 1) {
    _get_turret_data(n_index).disable_ai_getoff = b_disable;
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x9d32161d, Offset: 0x31e0
// Size: 0xb0
function disable(n_index) {
    if (is_turret_enabled(n_index)) {
        _get_turret_data(n_index).is_enabled = 0;
        function_14223170(n_index);
        clear_target(n_index);
        self turretsettargetangles(n_index, (0, 0, 0));
        self notify("turret_disabled" + _index(n_index));
    }
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x739c37dc, Offset: 0x3298
// Size: 0xb4
function pause(time, n_index) {
    s_turret = _get_turret_data(n_index);
    if (time > 0) {
        time = int(time * 1000);
    }
    if (isdefined(s_turret.pause)) {
        s_turret.pause_time += time;
        return;
    }
    s_turret.pause = 1;
    s_turret.pause_time = time;
    stop(n_index);
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x861d82d2, Offset: 0x3358
// Size: 0x58
function unpause(n_index) {
    s_turret = _get_turret_data(n_index);
    s_turret.pause = undefined;
    self notify("_turret_unpaused" + _index(n_index));
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x76d3f28, Offset: 0x33b8
// Size: 0x144
function function_12269140(target, n_index = 0) {
    s_turret = _get_turret_data(n_index);
    v_pos = isdefined(target.origin) ? target.origin : target;
    if (!isdefined(s_turret.var_bf6d793d)) {
        return true;
    }
    var_8ee48240 = cos(s_turret.var_bf6d793d.aimyawanglel);
    v_angles = isdefined(s_turret.node) ? s_turret.node.angles : self.angles;
    v_to_enemy = vectornormalize(v_pos - self.origin);
    dot = vectordot(v_to_enemy, anglestoforward(v_angles));
    return dot >= var_8ee48240;
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xbbba9f6a, Offset: 0x3508
// Size: 0x4f6
function _turret_think(n_index, v_offset) {
    turret_think_time = max(1.5, get_weapon(n_index).firetime);
    no_target_start_time = 0;
    self endon(#"death", "turret_disabled" + _index(n_index));
    var_17b7891d = "25ecace33b1ca311" + _index(n_index);
    self notify(var_17b7891d);
    self endon(var_17b7891d);
    /#
        self thread _debug_turret_think(n_index);
    #/
    self thread _turret_health_monitor(n_index);
    s_turret = _get_turret_data(n_index);
    if (isdefined(s_turret.has_laser)) {
        self laseron();
    }
    while (true) {
        s_turret flag::wait_till_clear("turret manual");
        n_time_now = gettime();
        if (self _check_for_paused(n_index) || is_true(self.emped) || is_true(self.stunned)) {
            self waittilltimeout(turret_think_time, "_turret_unpaused" + _index(n_index));
            continue;
        }
        target = s_turret.target;
        if (!isdefined(target) || isentity(target) && !isalive(target)) {
            stop(n_index);
        }
        self thread function_1358b930(n_index);
        e_original_next_target = s_turret.e_next_target;
        if (!is_true(s_turret.var_f351ad56) || isactor(s_turret.target) && !isalive(s_turret.target)) {
            s_turret.e_next_target = _get_best_target(n_index);
        }
        if (isdefined(s_turret.e_next_target)) {
            no_target_start_time = 0;
            if (_user_check(n_index)) {
                self thread _shoot_turret_at_target(s_turret.e_next_target, v_offset, n_index);
                if (s_turret.e_next_target !== e_original_next_target) {
                    self notify(#"has_new_target", {#target:s_turret.e_next_target});
                }
            }
        } else {
            if (!isdefined(self.do_not_clear_targets_during_think) || !self.do_not_clear_targets_during_think) {
                clear_target(n_index);
            }
            if (no_target_start_time == 0) {
                no_target_start_time = n_time_now;
            }
            target_wait_time = n_time_now - no_target_start_time;
            if (isdefined(s_turret.occupy_no_target_time)) {
                occupy_time = s_turret.occupy_no_target_time;
            } else {
                occupy_time = 3600;
            }
            if (!is_true(s_turret.disable_ai_getoff)) {
                bwasplayertarget = isdefined(s_turret.e_last_target) && isplayer(s_turret.e_last_target) && isalive(s_turret.e_last_target);
                if (bwasplayertarget) {
                    occupy_time /= 4;
                }
            } else {
                bwasplayertarget = 0;
            }
            if (target_wait_time >= occupy_time) {
                _drop_turret(n_index, !bwasplayertarget);
            }
        }
        wait turret_think_time;
    }
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x97864eb7, Offset: 0x3a08
// Size: 0x54
function _turret_health_monitor(n_index) {
    self endon(#"death");
    waitframe(1);
    _turret_health_monitor_loop(n_index);
    self disable(n_index);
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xc9cd6f7a, Offset: 0x3a68
// Size: 0x88
function _turret_health_monitor_loop(n_index) {
    self endon(#"death", "turret_disabled" + _index(n_index));
    while (true) {
        waitresult = self waittill(#"broken");
        if (waitresult.type === "turret_destroyed_" + n_index) {
            return;
        }
    }
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xf9f3d4ce, Offset: 0x3af8
// Size: 0x3a4
function function_1358b930(n_index) {
    self endon(#"death", "turret_disabled" + _index(n_index), "_turret_think" + _index(n_index), #"exit_vehicle");
    var_17b7891d = "3f1d010475b53910" + _index(n_index);
    self notify(var_17b7891d);
    self endon(var_17b7891d);
    ai_user = self get_user(n_index);
    if (!isdefined(ai_user)) {
        return;
    }
    s_turret = _get_turret_data(n_index);
    var_8bcad4e7 = 0;
    var_f72902ad = undefined;
    var_324bed9c = 0.173648;
    if (isdefined(s_turret.var_bf6d793d)) {
        var_324bed9c = cos(s_turret.var_bf6d793d.aimyawanglel);
    }
    while (!isdefined(var_f72902ad)) {
        time = gettime();
        if (time - var_8bcad4e7 > 500) {
            var_8bcad4e7 = time;
            players = getplayers();
            foreach (player in players) {
                if (!util::function_fbce7263(self.team, player.team)) {
                    continue;
                }
                if (abs(ai_user.origin[2] - player.origin[2]) <= 60 && distance2dsquared(ai_user.origin, player.origin) <= function_a3f6cdac(300)) {
                    var_f72902ad = player;
                    break;
                }
                if (ai_user cansee(player) || is_target(player, n_index)) {
                    toenemy = vectornormalize(player.origin - ai_user.origin);
                    dot = vectordot(toenemy, anglestoforward(s_turret.node.angles));
                    if (dot < var_324bed9c) {
                        var_f72902ad = player;
                        break;
                    }
                }
            }
        }
        waitframe(1);
    }
    ai_user = get_user(n_index);
    ai_user.var_2df45b5d = var_f72902ad;
    self thread _drop_turret(n_index, 0);
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0xb558a2c4, Offset: 0x3ea8
// Size: 0x10e
function _listen_for_damage_on_actor(ai_user, n_index) {
    self endon(#"death");
    ai_user endon(#"death");
    self endon("turret_disabled" + _index(n_index), "_turret_think" + _index(n_index), #"exit_vehicle");
    while (true) {
        waitresult = ai_user waittill(#"damage");
        s_turret = _get_turret_data(n_index);
        if (isdefined(s_turret)) {
            if (!isdefined(s_turret.e_next_target) && !isdefined(s_turret.target)) {
                s_turret.e_last_target = waitresult.attacker;
            }
        }
    }
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0x65928813, Offset: 0x3fc0
// Size: 0xd2
function _waittill_user_change(n_index) {
    ai_user = self getseatoccupant(n_index);
    if (isalive(ai_user)) {
        if (isactor(ai_user)) {
            ai_user endon(#"death");
        } else if (util::function_8e89351(ai_user)) {
            self notify("turret_disabled" + _index(n_index));
        }
    }
    self waittill(#"exit_vehicle", #"enter_vehicle");
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xaede6fe, Offset: 0x40a0
// Size: 0xb6
function _check_for_paused(n_index) {
    s_turret = _get_turret_data(n_index);
    s_turret.pause_start_time = gettime();
    while (isdefined(s_turret.pause)) {
        if (s_turret.pause_time > 0) {
            time = gettime();
            paused_time = time - s_turret.pause_start_time;
            if (paused_time > s_turret.pause_time) {
                s_turret.pause = undefined;
                return true;
            }
        } else {
            return true;
        }
        waitframe(1);
    }
    return false;
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xec517fbd, Offset: 0x4160
// Size: 0x12c
function _drop_turret(n_index, bexitifautomatedonly) {
    ai_user = get_user(n_index);
    if (isalive(ai_user) && !isbot(ai_user) && !isplayer(ai_user) && (is_true(ai_user.turret_auto_use) || !is_true(bexitifautomatedonly))) {
        if (!isdefined(ai_user.vehicle) && ai_user islinkedto(self)) {
            self get_out(ai_user, n_index);
            return;
        }
        vehicle::get_out(self, ai_user, "gunner1");
    }
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0xd95d2313, Offset: 0x4298
// Size: 0x2c
function does_have_target(n_index) {
    return isdefined(_get_turret_data(n_index).e_next_target);
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x92e7b578, Offset: 0x42d0
// Size: 0x76
function _user_check(n_index) {
    s_turret = _get_turret_data(n_index);
    if (does_need_user(n_index)) {
        b_has_user = does_have_user(n_index);
        return b_has_user;
    }
    return 1;
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x73c62140, Offset: 0x4350
// Size: 0x220
function function_2a4a311(n_index) {
    if (!isdefined(self.target)) {
        return;
    }
    self notify("_turret_waiting_for_user" + _index(n_index));
    self endon("_turret_waiting_for_user" + _index(n_index));
    self endon(#"death");
    s_turret = _get_turret_data(n_index);
    if (!isdefined(s_turret.node)) {
        return;
    }
    var_f449d788 = function_a3f6cdac(s_turret.var_43ce86ed);
    while (true) {
        s_notify = self waittill(#"hash_4ecf2bd2fb1d75d9");
        var_34b21e8e = s_notify.entity;
        if (isalive(var_34b21e8e) && !var_34b21e8e flag::get(#"hash_1b89f498c2647e6") && !s_turret.var_aa100948) {
            if (var_34b21e8e.isarriving) {
                while (isalive(var_34b21e8e) && var_34b21e8e.isarriving) {
                    waitframe(1);
                }
                get_in(var_34b21e8e, n_index);
                continue;
            }
            if (distance2dsquared(var_34b21e8e.origin, s_turret.node.origin) <= var_f449d788) {
                if (isdefined(var_34b21e8e.var_41adb97) && gettime() < var_34b21e8e.var_41adb97) {
                    continue;
                }
                get_in(var_34b21e8e, n_index);
            }
        }
    }
}

/#

    // Namespace turret/turret_shared
    // Params 1, eflags: 0x0
    // Checksum 0x3b4e1ddc, Offset: 0x4578
    // Size: 0x6de
    function _debug_turret_think(n_index) {
        self endon(#"death", "<dev string:x1ef>" + _index(n_index), "<dev string:x200>" + _index(n_index));
        s_turret = _get_turret_data(n_index);
        var_34c31abc = (1, 1, 0);
        n_spacing = (0, 0, -7);
        while (true) {
            if (!getdvarint(#"g_debugturrets", 0)) {
                wait 0.2;
                continue;
            }
            var_83570f5f = [];
            var_83570f5f[var_83570f5f.size] = "<dev string:x213>" + self getentnum();
            str_target = "<dev string:x227>";
            target = s_turret.target;
            if (isdefined(target)) {
                if (isvec(target)) {
                    str_target += "<dev string:x234>" + target;
                } else if (isactor(target)) {
                    str_target += "<dev string:x23c>" + target getentnum();
                } else if (isplayer(target)) {
                    str_target += "<dev string:x243>" + target getentnum();
                } else if (isvehicle(target)) {
                    str_target += "<dev string:x24e>" + target getentnum();
                } else if (isdefined(target.targetname) && target.targetname == "<dev string:x25a>") {
                    str_target += "<dev string:x25a>";
                } else if (isdefined(target.classname)) {
                    str_target += target.classname;
                }
            } else {
                str_target += "<dev string:x263>";
            }
            var_83570f5f[var_83570f5f.size] = str_target;
            var_3be47a2d = "<dev string:x26b>";
            if (isdefined(s_turret.pause)) {
                var_3be47a2d += "<dev string:x277>";
            } else if (s_turret.n_burst_time < s_turret.n_burst_fire_time) {
                var_3be47a2d += "<dev string:x281>" + s_turret.n_burst_fire_time - s_turret.n_burst_time;
            } else {
                var_3be47a2d += "<dev string:x28a>";
            }
            var_83570f5f[var_83570f5f.size] = var_3be47a2d;
            var_c88d0be9 = "<dev string:x296>";
            if (isdefined(s_turret.var_50fbd548) && isvec(s_turret.target) && s_turret.target == s_turret.var_50fbd548) {
                var_c88d0be9 += "<dev string:x2a5>";
            } else if (s_turret flag::get(#"turret manual")) {
                var_c88d0be9 += "<dev string:x2bb>";
            } else {
                var_c88d0be9 += "<dev string:x2ca>";
            }
            var_83570f5f[var_83570f5f.size] = var_c88d0be9;
            var_83570f5f[var_83570f5f.size] = "<dev string:x2db>" + (isdefined(s_turret.favoriteenemy) ? "<dev string:x2f0>" + s_turret.favoriteenemy getentnum() : "<dev string:x263>");
            var_83570f5f[var_83570f5f.size] = "<dev string:x2fb>" + is_true(s_turret.var_cd8600bd);
            var_83570f5f[var_83570f5f.size] = "<dev string:x314>" + is_true(s_turret.b_ignore_line_of_sight);
            var_83570f5f[var_83570f5f.size] = "<dev string:x325>" + is_true(s_turret.var_f351ad56);
            var_83570f5f[var_83570f5f.size] = "<dev string:x339>" + is_true(s_turret.perfectaim);
            var_83570f5f[var_83570f5f.size] = "<dev string:x34b>" + is_true(s_turret.var_d55528ca);
            var_83570f5f[var_83570f5f.size] = "<dev string:x35c>" + is_true(s_turret.var_2890139c);
            if (s_turret.n_last_fire_time == gettime()) {
                var_83570f5f[var_83570f5f.size] = "<dev string:x378>";
            }
            for (i = 0; i < var_83570f5f.size; i++) {
                record3dtext(var_83570f5f[i], self.origin + n_spacing * i, var_34c31abc, "<dev string:x38c>", self);
            }
            if (isdefined(s_turret.target)) {
                v_end = isvec(s_turret.target) ? s_turret.target : s_turret.target.origin;
                v_start = isdefined(self gettagorigin(s_turret.str_tag_flash)) ? self gettagorigin(s_turret.str_tag_flash) : self.origin;
                v_color = function_12269140(v_end, n_index) ? (0, 1, 0) : (1, 0, 0);
                line(v_start, v_end, v_color);
            }
            waitframe(1);
        }
    }

#/

// Namespace turret/turret_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x307df887, Offset: 0x4c60
// Size: 0xa2
function _get_turret_data(n_index = 0) {
    s_turret = undefined;
    if (isvehicle(self)) {
        if (isdefined(self.a_turrets) && isdefined(self.a_turrets[n_index])) {
            s_turret = self.a_turrets[n_index];
        }
    } else {
        s_turret = self._turret;
    }
    if (!isdefined(s_turret)) {
        s_turret = _init_turret(n_index);
    }
    return s_turret;
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0x33f5c294, Offset: 0x4d10
// Size: 0x34
function has_turret(n_index) {
    if (isdefined(self.a_turrets) && isdefined(self.a_turrets[n_index])) {
        return true;
    }
    return false;
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x597da800, Offset: 0x4d50
// Size: 0x8e
function _update_turret_arcs(n_index) {
    s_turret = _get_turret_data(n_index);
    s_turret.rightarc = s_turret.w_weapon.rightarc;
    s_turret.leftarc = s_turret.w_weapon.leftarc;
    s_turret.toparc = s_turret.w_weapon.toparc;
    s_turret.bottomarc = s_turret.w_weapon.bottomarc;
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x75895933, Offset: 0x4de8
// Size: 0x2b8
function _init_turret(n_index = 0) {
    self endon(#"death");
    w_weapon = get_weapon(n_index);
    if (w_weapon.name == #"none") {
        assertmsg("<dev string:x396>");
        return;
    }
    util::waittill_asset_loaded("xmodel", self.model);
    s_turret = _init_vehicle_turret(n_index);
    s_turret.w_weapon = w_weapon;
    _update_turret_arcs(n_index);
    s_turret.is_enabled = 0;
    s_turret.target = undefined;
    s_turret.e_parent = self;
    s_turret.var_cd8600bd = 0;
    s_turret.var_30e97b22 = 0;
    s_turret.var_d55528ca = 0;
    s_turret.b_ignore_line_of_sight = 0;
    s_turret.var_2890139c = 0;
    s_turret.var_aa100948 = 0;
    s_turret.var_f351ad56 = 0;
    s_turret.v_offset = (0, 0, 0);
    s_turret.var_50fbd548 = undefined;
    s_turret.n_burst_fire_time = 0;
    s_turret.n_burst_time = 0;
    s_turret.n_burst_wait = 0;
    s_turret.n_index = n_index;
    s_turret.n_last_fire_time = 0;
    s_turret.var_43ce86ed = 32;
    s_turret.var_b52bbdba = 1;
    s_turret.var_72f4d1b7 = 0.5;
    s_turret.str_weapon_type = w_weapon.type;
    s_turret.str_guidance_type = w_weapon.guidedmissiletype;
    if (isdefined(self.target)) {
        s_turret.node = getnode(self.target, "targetname");
    }
    if (isdefined(w_weapon.aiturretanims)) {
        s_turret.var_bf6d793d = getscriptbundle(w_weapon.aiturretanims);
    }
    set_on_target_angle(1, n_index);
    s_turret flag::init("turret manual");
    self thread function_2a4a311(n_index);
    return s_turret;
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xa5739e02, Offset: 0x50a8
// Size: 0x220
function _init_vehicle_turret(n_index) {
    assert(isdefined(n_index) && n_index >= 0, "<dev string:x3c3>");
    s_turret = spawnstruct();
    switch (n_index) {
    case 0:
        s_turret.str_tag_flash = "tag_flash";
        s_turret.str_tag_pivot = "tag_barrel";
        break;
    case 1:
        s_turret.str_tag_flash = "tag_gunner_flash1";
        s_turret.str_tag_pivot = "tag_gunner_barrel1";
        break;
    case 2:
        s_turret.str_tag_flash = "tag_gunner_flash2";
        s_turret.str_tag_pivot = "tag_gunner_barrel2";
        break;
    case 3:
        s_turret.str_tag_flash = "tag_gunner_flash3";
        s_turret.str_tag_pivot = "tag_gunner_barrel3";
        break;
    case 4:
        s_turret.str_tag_flash = "tag_gunner_flash4";
        s_turret.str_tag_pivot = "tag_gunner_barrel4";
        break;
    }
    if (self.vehicleclass === "helicopter") {
        s_turret.e_trace_ignore = self;
    }
    if (!isdefined(self.a_turrets)) {
        self.a_turrets = [];
    }
    self.a_turrets[n_index] = s_turret;
    if (n_index > 0) {
        tag_origin = self gettagorigin(_get_gunner_tag_for_turret_index(n_index));
        if (isdefined(tag_origin)) {
            _set_turret_needs_user(n_index, 1);
        }
    }
    return s_turret;
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x3984a729, Offset: 0x52d0
// Size: 0x5a
function function_14223170(n_index = 0) {
    s_turret = _get_turret_data(n_index);
    s_turret.n_burst_time = 0;
    s_turret.n_burst_fire_time = 0;
    s_turret.n_burst_wait = 0;
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x54b4063d, Offset: 0x5338
// Size: 0x1c8
function _burst_fire(n_index) {
    self endon(#"drone_death", #"death", "_stop_turret" + _index(n_index), "turret_disabled" + _index(n_index), #"terminate_all_turrets_firing", #"exit_vehicle", "turret manual" + _index(n_index));
    s_turret = _get_turret_data(n_index);
    s_turret.n_burst_time = 0;
    s_turret.n_burst_fire_time = _get_burst_fire_time(n_index);
    s_turret.n_burst_wait = _get_burst_wait_time(n_index);
    var_6bb69878 = s_turret.n_burst_fire_time;
    w_weapon = get_weapon(n_index);
    n_fire_time = w_weapon.firetime;
    n_total_time = 0;
    var_a2524721 = 0;
    while (n_total_time < var_6bb69878) {
        n_total_time += n_fire_time;
        s_turret.n_burst_time += n_fire_time;
        var_a2524721 = s_turret.n_burst_time >= s_turret.n_burst_fire_time;
        fire(n_index);
        wait n_fire_time;
    }
    if (var_a2524721) {
        wait s_turret.n_burst_wait;
    }
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x4f0a2d55, Offset: 0x5508
// Size: 0xe2
function _get_burst_fire_time(n_index) {
    s_turret = _get_turret_data(n_index);
    n_time = undefined;
    if (isdefined(s_turret.n_burst_fire_min) && isdefined(s_turret.n_burst_fire_max)) {
        if (s_turret.n_burst_fire_min == s_turret.n_burst_fire_max) {
            n_time = s_turret.n_burst_fire_min;
        } else {
            n_time = randomfloatrange(s_turret.n_burst_fire_min, s_turret.n_burst_fire_max);
        }
    } else if (isdefined(s_turret.n_burst_fire_max)) {
        n_time = randomfloatrange(0, s_turret.n_burst_fire_max);
    }
    return n_time;
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x92227dc1, Offset: 0x55f8
// Size: 0xe2
function _get_burst_wait_time(n_index) {
    s_turret = _get_turret_data(n_index);
    n_time = 0;
    if (isdefined(s_turret.n_burst_wait_min) && isdefined(s_turret.n_burst_wait_max)) {
        if (s_turret.n_burst_wait_min == s_turret.n_burst_wait_max) {
            n_time = s_turret.n_burst_wait_min;
        } else {
            n_time = randomfloatrange(s_turret.n_burst_wait_min, s_turret.n_burst_wait_max);
        }
    } else if (isdefined(s_turret.n_burst_wait_max)) {
        n_time = randomfloatrange(0, s_turret.n_burst_wait_max);
    }
    return n_time;
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x1deb62e, Offset: 0x56e8
// Size: 0x2a
function _index(n_index) {
    return isdefined(n_index) ? "" + n_index : "";
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x8ac056be, Offset: 0x5720
// Size: 0x1ca
function _get_best_target(n_index) {
    e_best_target = undefined;
    self util::make_sentient();
    switch (n_index) {
    case 0:
        e_best_target = self.enemy;
        break;
    case 1:
        e_best_target = self.gunner1enemy;
        break;
    case 2:
        e_best_target = self.gunner2enemy;
        break;
    case 3:
        e_best_target = self.gunner3enemy;
        break;
    case 4:
        e_best_target = self.gunner4enemy;
        break;
    }
    s_turret = _get_turret_data(n_index);
    if (is_true(s_turret.var_30e97b22) && isdefined(self.enemy)) {
        e_best_target = self.enemy;
    }
    if (issentient(self)) {
        self.favoriteenemy = undefined;
        self.perfectaim = is_true(s_turret.perfectaim);
        if (isdefined(s_turret.favoriteenemy) && issentient(s_turret.favoriteenemy)) {
            self.favoriteenemy = s_turret.favoriteenemy;
            e_best_target = s_turret.favoriteenemy;
        }
    }
    return e_best_target;
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xc35d00c, Offset: 0x58f8
// Size: 0x1aa
function can_hit_target(e_target, n_index) {
    s_turret = _get_turret_data(n_index);
    v_offset = _get_default_target_offset(e_target, n_index);
    b_current_target = is_target(e_target, n_index);
    if (isdefined(e_target) && is_true(e_target.ignoreme)) {
        return 0;
    }
    b_trace_passed = 1;
    if (!s_turret.b_ignore_line_of_sight) {
        if (issentient(e_target) && (!isdefined(v_offset) || v_offset === (0, 0, 0))) {
            v_offset = e_target geteyeapprox() - e_target.origin;
        }
        b_trace_passed = trace_test(e_target, v_offset - (0, 0, isdefined(s_turret.n_torso_targetting_offset) ? s_turret.n_torso_targetting_offset : isvehicle(e_target) ? 0 : 0), n_index);
    }
    if (b_current_target && !b_trace_passed && !isdefined(s_turret.n_time_lose_sight)) {
        s_turret.n_time_lose_sight = gettime();
    }
    return b_trace_passed;
}

// Namespace turret/turret_shared
// Params 3, eflags: 0x1 linked
// Checksum 0x55ccfdac, Offset: 0x5ab0
// Size: 0x28e
function trace_test(e_target, v_offset = (0, 0, 0), n_index) {
    if (isdefined(self.good_old_style_turret_tracing)) {
        s_turret = _get_turret_data(n_index);
        v_start_org = self gettagorigin(s_turret.str_tag_pivot);
        if (e_target sightconetrace(v_start_org, self) > 0.2) {
            v_target = e_target.origin + v_offset;
            v_start_org += vectornormalize(v_target - v_start_org) * 50;
            a_trace = bullettrace(v_start_org, v_target, 1, s_turret.e_trace_ignore, 0, 1);
            if (a_trace[#"fraction"] > 0.6) {
                return true;
            }
        }
        return false;
    }
    s_turret = _get_turret_data(n_index);
    v_start_org = self gettagorigin(s_turret.str_tag_pivot);
    v_target = (isvec(e_target) ? e_target : e_target.origin) + v_offset;
    if ((sessionmodeismultiplayergame() || sessionmodeiswarzonegame()) && isplayer(e_target)) {
        v_target = e_target getshootatpos();
    }
    if (distancesquared(v_start_org, v_target) < 10000) {
        return true;
    }
    v_dir_to_target = vectornormalize(v_target - v_start_org);
    v_start_org += v_dir_to_target * 50;
    v_target -= v_dir_to_target * 75;
    if (sighttracepassed(v_start_org, v_target, 0, self, e_target)) {
        return true;
    }
    return false;
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0x766cec3f, Offset: 0x5d48
// Size: 0x42
function set_ignore_line_of_sight(b_ignore, n_index) {
    s_turret = _get_turret_data(n_index);
    s_turret.b_ignore_line_of_sight = b_ignore;
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0xb0561737, Offset: 0x5d98
// Size: 0x42
function function_8bbe7822(b_ignore, n_index) {
    s_turret = _get_turret_data(n_index);
    s_turret.var_2890139c = b_ignore;
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0x57d85eba, Offset: 0x5de8
// Size: 0x42
function function_bb42e3e2(var_7994b8bf, n_index) {
    s_turret = _get_turret_data(n_index);
    s_turret.var_30e97b22 = var_7994b8bf;
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0x9b7ea1ca, Offset: 0x5e38
// Size: 0x42
function function_f5e3e1de(b_enabled, n_index) {
    s_turret = _get_turret_data(n_index);
    s_turret.var_cd8600bd = b_enabled;
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0xb44ce17, Offset: 0x5e88
// Size: 0x42
function set_occupy_no_target_time(time, n_index) {
    s_turret = _get_turret_data(n_index);
    s_turret.occupy_no_target_time = time;
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x7882b8c4, Offset: 0x5ed8
// Size: 0x2c
function toggle_lensflare(bool) {
    self clientfield::set("toggle_lensflare", bool);
}

// Namespace turret/turret_shared
// Params 0, eflags: 0x0
// Checksum 0x334e1b53, Offset: 0x5f10
// Size: 0x15c
function track_lens_flare() {
    self endon(#"death");
    self notify(#"disable_lens_flare");
    self endon(#"disable_lens_flare");
    while (true) {
        e_target = self turretgettarget(0);
        if (self.turretontarget && isdefined(e_target) && isplayer(e_target)) {
            if (isdefined(self gettagorigin("TAG_LASER"))) {
                e_target util::waittill_player_looking_at(self gettagorigin("TAG_LASER"), 90);
                if (isdefined(e_target)) {
                    self toggle_lensflare(1);
                    e_target util::waittill_player_not_looking_at(self gettagorigin("TAG_LASER"));
                }
                self toggle_lensflare(0);
            }
        }
        wait 0.5;
    }
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x36d35634, Offset: 0x6078
// Size: 0xc2
function _get_gunner_tag_for_turret_index(n_index) {
    switch (n_index) {
    case 0:
        return "tag_driver";
    case 1:
        return "tag_gunner1";
    case 2:
        return "tag_gunner2";
    case 3:
        return "tag_gunner3";
    case 4:
        return "tag_gunner4";
    default:
        assertmsg("<dev string:x3fc>");
        break;
    }
}

