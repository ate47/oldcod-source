#using scripts/core_common/ai_shared;
#using scripts/core_common/array_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flag_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/vehicleriders_shared;

#namespace turret;

// Namespace turret/turret_shared
// Params 0, eflags: 0x2
// Checksum 0x3c88ae9, Offset: 0x430
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("turret", &__init__, undefined, undefined);
}

// Namespace turret/turret_shared
// Params 0, eflags: 0x0
// Checksum 0xebf11138, Offset: 0x470
// Size: 0x50
function __init__() {
    clientfield::register("vehicle", "toggle_lensflare", 1, 1, "int");
    level._turrets = spawnstruct();
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0x7dfbace0, Offset: 0x4c8
// Size: 0x44
function get_weapon(n_index) {
    if (!isdefined(n_index)) {
        n_index = 0;
    }
    w_weapon = self seatgetweapon(n_index);
    return w_weapon;
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0x9e3a4278, Offset: 0x518
// Size: 0x2a
function get_parent(n_index) {
    return _get_turret_data(n_index).e_parent;
}

// Namespace turret/turret_shared
// Params 0, eflags: 0x0
// Checksum 0xac6d9c5, Offset: 0x550
// Size: 0x4c
function laser_death_watcher() {
    self notify(#"laser_death_thread_stop");
    self endon(#"laser_death_thread_stop");
    self waittill("death");
    if (isdefined(self)) {
        self laseroff();
    }
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0x2608a275, Offset: 0x5a8
// Size: 0xaa
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
// Params 0, eflags: 0x0
// Checksum 0xcc94932a, Offset: 0x660
// Size: 0x86
function watch_for_flash() {
    self endon(#"watch_for_flash_and_stun");
    self endon(#"death");
    while (true) {
        waitresult = self waittill("flashbang");
        self notify(#"damage", {#amount:1, #attacker:waitresult.attacker, #weapon:"flash_grenade"});
    }
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0x5f8f541d, Offset: 0x6f0
// Size: 0xea
function watch_for_flash_and_stun(n_index) {
    self notify(#"watch_for_flash_and_stun_end");
    self endon(#"watch_for_flash_and_stun");
    self endon(#"death");
    self thread watch_for_flash();
    while (true) {
        waitresult = self waittill("damage");
        if (waitresult.weapon.dostun) {
            if (isdefined(self.stunned)) {
                continue;
            }
            self.stunned = 1;
            stop(n_index, 1);
            wait randomfloatrange(5, 7);
            self.stunned = undefined;
        }
    }
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0x15b137d5, Offset: 0x7e8
// Size: 0x138
function emp_watcher(n_index) {
    self notify(#"emp_thread_stop");
    self endon(#"emp_thread_stop");
    self endon(#"death");
    while (true) {
        waitresult = self waittill("damage");
        if (waitresult.weapon.isemp) {
            if (isdefined(self.emped)) {
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
// Checksum 0xe33eb5b2, Offset: 0x928
// Size: 0x8e
function enable_emp(b_enable, n_index) {
    if (b_enable) {
        _get_turret_data(n_index).can_emp = 1;
        self thread emp_watcher(n_index);
        self.takedamage = 1;
        return;
    }
    _get_turret_data(n_index).can_emp = undefined;
    self notify(#"emp_thread_stop");
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0xdbb1817e, Offset: 0x9c0
// Size: 0x44
function set_team(str_team, n_index) {
    _get_turret_data(n_index).str_team = str_team;
    self.team = str_team;
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0x60cbf4c0, Offset: 0xa10
// Size: 0x7c
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
// Params 1, eflags: 0x0
// Checksum 0xcfcf35f3, Offset: 0xa98
// Size: 0x2a
function is_turret_enabled(n_index) {
    return _get_turret_data(n_index).is_enabled;
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0xc17513ab, Offset: 0xad0
// Size: 0x4a
function does_need_user(n_index) {
    return isdefined(_get_turret_data(n_index).b_needs_user) && _get_turret_data(n_index).b_needs_user;
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0xf0c3ae6d, Offset: 0xb28
// Size: 0x32
function does_have_user(n_index) {
    return isalive(get_user(n_index));
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0x8697c44e, Offset: 0xb68
// Size: 0x22
function get_user(n_index) {
    return self getseatoccupant(n_index);
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0xc56ef592, Offset: 0xb98
// Size: 0x90
function _set_turret_needs_user(n_index, b_needs_user) {
    s_turret = _get_turret_data(n_index);
    if (b_needs_user) {
        s_turret.b_needs_user = 1;
        self thread watch_for_flash_and_stun(n_index);
        return;
    }
    self notify(#"watch_for_flash_and_stun_end");
    s_turret.b_needs_user = 0;
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0x6b740259, Offset: 0xc30
// Size: 0x50
function _wait_for_current_user_to_finish(n_index) {
    self endon(#"death");
    while (isalive(get_user(n_index))) {
        waitframe(1);
    }
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0xc1095281, Offset: 0xc88
// Size: 0x58
function is_current_user(ai_user, n_index) {
    ai_current_user = get_user(n_index);
    return isalive(ai_current_user) && ai_user == ai_current_user;
}

// Namespace turret/turret_shared
// Params 5, eflags: 0x0
// Checksum 0xd7974e11, Offset: 0xce8
// Size: 0xa0
function set_burst_parameters(n_fire_min, n_fire_max, n_wait_min, n_wait_max, n_index) {
    s_turret = _get_turret_data(n_index);
    s_turret.n_burst_fire_min = n_fire_min;
    s_turret.n_burst_fire_max = n_fire_max;
    s_turret.n_burst_wait_min = n_wait_min;
    s_turret.n_burst_wait_max = n_wait_max;
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0x68b15a29, Offset: 0xd90
// Size: 0x5c
function set_torso_targetting(n_index, n_torso_targetting_offset) {
    if (!isdefined(n_torso_targetting_offset)) {
        n_torso_targetting_offset = -12;
    }
    s_turret = _get_turret_data(n_index);
    s_turret.n_torso_targetting_offset = n_torso_targetting_offset;
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0x2324ec74, Offset: 0xdf8
// Size: 0x64
function set_target_leading(n_index, n_target_leading_factor) {
    if (!isdefined(n_target_leading_factor)) {
        n_target_leading_factor = 0.1;
    }
    s_turret = _get_turret_data(n_index);
    s_turret.n_target_leading_factor = n_target_leading_factor;
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0x35dd5dad, Offset: 0xe68
// Size: 0x74
function set_on_target_angle(n_angle, n_index) {
    s_turret = _get_turret_data(n_index);
    if (!isdefined(n_angle)) {
        if (s_turret.str_guidance_type != "none") {
            n_angle = 10;
            return;
        }
        n_angle = 2;
    }
}

// Namespace turret/turret_shared
// Params 3, eflags: 0x0
// Checksum 0x1da6fbe9, Offset: 0xee8
// Size: 0x108
function set_target(e_target, v_offset, n_index) {
    self endon(#"death");
    s_turret = _get_turret_data(n_index);
    if (!isdefined(v_offset)) {
        v_offset = _get_default_target_offset(e_target, n_index);
    }
    if (!isdefined(n_index) || n_index == 0) {
        self turretsettarget(0, e_target, v_offset);
    } else {
        self turretsettarget(n_index, e_target, v_offset);
    }
    s_turret.e_target = e_target;
    s_turret.e_last_target = e_target;
    s_turret.v_offset = v_offset;
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0x5930270e, Offset: 0xff8
// Size: 0x2cc
function _get_default_target_offset(e_target, n_index) {
    s_turret = _get_turret_data(n_index);
    if (s_turret.str_weapon_type == "bullet") {
        if (isdefined(e_target)) {
            if (issentient(self) && issentient(e_target)) {
                z_offset = isdefined(s_turret.n_torso_targetting_offset) ? s_turret.n_torso_targetting_offset : isvehicle(e_target) ? 0 : 0;
            } else if (isplayer(e_target)) {
                z_offset = randomintrange(40, 50);
            } else if (e_target.type === "human") {
                z_offset = randomintrange(20, 60);
            } else if (e_target.type === "robot") {
                z_offset = randomintrange(40, 60);
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
// Params 1, eflags: 0x0
// Checksum 0xdfb9bcab, Offset: 0x12d0
// Size: 0xb2
function get_target(n_index) {
    if (isdefined(_get_turret_data(n_index).e_target.ignoreme) && isdefined(_get_turret_data(n_index).e_target) && _get_turret_data(n_index).e_target.ignoreme) {
        clear_target(n_index);
    }
    return _get_turret_data(n_index).e_target;
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0x753c679f, Offset: 0x1390
// Size: 0x50
function is_target(e_target, n_index) {
    e_current_target = get_target(n_index);
    if (isdefined(e_current_target)) {
        return (e_current_target == e_target);
    }
    return false;
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0xcac42dc4, Offset: 0x13e8
// Size: 0xb4
function clear_target(n_index) {
    s_turret = _get_turret_data(n_index);
    s_turret flag::clear("turret manual");
    s_turret.e_next_target = undefined;
    s_turret.e_target = undefined;
    if (!isdefined(n_index) || n_index == 0) {
        self turretcleartarget(0);
        return;
    }
    self turretcleartarget(n_index);
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0x46fd10e9, Offset: 0x14a8
// Size: 0x4c
function set_min_target_distance_squared(n_distance_squared, n_index) {
    s_turret = _get_turret_data(n_index);
    s_turret.n_min_target_distance_squared = n_distance_squared;
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0xdd5d1cab, Offset: 0x1500
// Size: 0x17c
function fire(n_index) {
    s_turret = _get_turret_data(n_index);
    /#
        assert(isdefined(n_index) && n_index >= 0, "<dev string:x28>");
    #/
    if (n_index == 0) {
        self fireweapon(0, s_turret.e_target);
    } else {
        ai_current_user = get_user(n_index);
        if (isdefined(ai_current_user.is_disabled) && isdefined(ai_current_user) && ai_current_user.is_disabled) {
            return;
        }
        if (isdefined(s_turret.e_target)) {
            self turretsettarget(n_index, s_turret.e_target, s_turret.v_offset);
        }
        self fireweapon(n_index, s_turret.e_target, s_turret.v_offset, s_turret.e_parent);
    }
    s_turret.n_last_fire_time = gettime();
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0xcf64519b, Offset: 0x1688
// Size: 0xc0
function stop(n_index, b_clear_target) {
    if (!isdefined(b_clear_target)) {
        b_clear_target = 0;
    }
    s_turret = _get_turret_data(n_index);
    s_turret.e_next_target = undefined;
    s_turret.e_target = undefined;
    s_turret flag::clear("turret manual");
    if (b_clear_target) {
        clear_target(n_index);
    }
    self notify("_stop_turret" + _index(n_index));
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0xb5db0f9c, Offset: 0x1750
// Size: 0x1f4
function fire_for_time(n_time, n_index) {
    if (!isdefined(n_index)) {
        n_index = 0;
    }
    /#
        assert(isdefined(n_time), "<dev string:x58>");
    #/
    self endon(#"death");
    self endon(#"drone_death");
    self endon("_stop_turret" + _index(n_index));
    self endon("turret_disabled" + _index(n_index));
    self notify("_fire_turret_for_time" + _index(n_index));
    self endon("_fire_turret_for_time" + _index(n_index));
    b_fire_forever = 0;
    if (n_time < 0) {
        b_fire_forever = 1;
    } else {
        /#
            w_weapon = get_weapon(n_index);
            /#
                assert(n_time >= w_weapon.firetime, "<dev string:x92>" + n_time + "<dev string:x9e>" + w_weapon.firetime);
            #/
        #/
    }
    while (n_time > 0 || b_fire_forever) {
        n_burst_time = _burst_fire(n_time, n_index);
        if (!b_fire_forever) {
            n_time -= n_burst_time;
        }
    }
}

// Namespace turret/turret_shared
// Params 5, eflags: 0x0
// Checksum 0x19256c3a, Offset: 0x1950
// Size: 0xf4
function shoot_at_target(e_target, n_time, v_offset, n_index, b_just_once) {
    /#
        assert(isdefined(e_target), "<dev string:xe1>");
    #/
    self endon(#"drone_death");
    self endon(#"death");
    s_turret = _get_turret_data(n_index);
    s_turret flag::set("turret manual");
    _shoot_turret_at_target(e_target, n_time, v_offset, n_index, b_just_once);
    s_turret flag::clear("turret manual");
}

// Namespace turret/turret_shared
// Params 5, eflags: 0x0
// Checksum 0x7e1dc5d1, Offset: 0x1a50
// Size: 0x18c
function _shoot_turret_at_target(e_target, n_time, v_offset, n_index, b_just_once) {
    self endon(#"drone_death");
    self endon(#"death");
    self endon("_stop_turret" + _index(n_index));
    self endon("turret_disabled" + _index(n_index));
    self notify("_shoot_turret_at_target" + _index(n_index));
    self endon("_shoot_turret_at_target" + _index(n_index));
    if (n_time == -1) {
        e_target endon(#"death");
    }
    if (!isdefined(b_just_once)) {
        b_just_once = 0;
    }
    set_target(e_target, v_offset, n_index);
    if (!isdefined(self.aim_only_no_shooting)) {
        _waittill_turret_on_target(e_target, n_index);
        if (b_just_once) {
            fire(n_index);
            return;
        }
        fire_for_time(n_time, n_index);
    }
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0x1bee0728, Offset: 0x1be8
// Size: 0xa0
function _waittill_turret_on_target(e_target, n_index) {
    do {
        wait isdefined(self.waittill_turret_on_target_delay) ? self.waittill_turret_on_target_delay : 0.5;
        if (!isdefined(n_index) || n_index == 0) {
            self waittill("turret_on_target");
            continue;
        }
        self waittill("gunner_turret_on_target");
    } while (isdefined(e_target) && !can_hit_target(e_target, n_index));
}

// Namespace turret/turret_shared
// Params 3, eflags: 0x0
// Checksum 0x236275bc, Offset: 0x1c90
// Size: 0x44
function shoot_at_target_once(e_target, v_offset, n_index) {
    shoot_at_target(e_target, 0, v_offset, n_index, 1);
}

// Namespace turret/turret_shared
// Params 3, eflags: 0x0
// Checksum 0xcd8d6473, Offset: 0x1ce0
// Size: 0x104
function enable(n_index, b_user_required, v_offset) {
    if (isalive(self) && !is_turret_enabled(n_index)) {
        _get_turret_data(n_index).is_enabled = 1;
        self thread _turret_think(n_index, v_offset);
        self notify("turret_enabled" + _index(n_index));
        if (isdefined(b_user_required) && !b_user_required) {
            _set_turret_needs_user(n_index, 0);
            return;
        }
        _set_turret_needs_user(n_index, 1);
    }
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0xd7d5d3ef, Offset: 0x1df0
// Size: 0x30
function enable_auto_use(b_enable) {
    if (!isdefined(b_enable)) {
        b_enable = 1;
    }
    self.script_auto_use = b_enable;
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0x2a6c4065, Offset: 0x1e28
// Size: 0x4c
function disable_ai_getoff(n_index, b_disable) {
    if (!isdefined(b_disable)) {
        b_disable = 1;
    }
    _get_turret_data(n_index).disable_ai_getoff = b_disable;
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0xc3083e83, Offset: 0x1e80
// Size: 0x98
function disable(n_index) {
    if (is_turret_enabled(n_index)) {
        _drop_turret(n_index);
        clear_target(n_index);
        _get_turret_data(n_index).is_enabled = 0;
        self notify("turret_disabled" + _index(n_index));
    }
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0xe77ed927, Offset: 0x1f20
// Size: 0xcc
function pause(time, n_index) {
    s_turret = _get_turret_data(n_index);
    if (time > 0) {
        time *= 1000;
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
// Params 1, eflags: 0x0
// Checksum 0x713e65d8, Offset: 0x1ff8
// Size: 0x3e
function unpause(n_index) {
    s_turret = _get_turret_data(n_index);
    s_turret.pause = undefined;
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0x70eb6b7b, Offset: 0x2040
// Size: 0x506
function _turret_think(n_index, v_offset) {
    turret_think_time = max(1.5, get_weapon(n_index).firetime);
    no_target_start_time = 0;
    self endon(#"death");
    self endon("turret_disabled" + _index(n_index));
    self notify("_turret_think" + _index(n_index));
    self endon("_turret_think" + _index(n_index));
    /#
        self thread _debug_turret_think(n_index);
    #/
    self thread function_50f8f315(n_index);
    self thread function_b5dd89ec(n_index);
    self thread _turret_health_monitor(n_index);
    s_turret = _get_turret_data(n_index);
    if (isdefined(s_turret.has_laser)) {
        self laseron();
    }
    while (true) {
        s_turret flag::wait_till_clear("turret manual");
        n_time_now = gettime();
        if (self _check_for_paused(n_index) || isdefined(self.emped) || isdefined(self.stunned)) {
            wait turret_think_time;
            continue;
        }
        if (!isdefined(s_turret.e_target) || s_turret.e_target.health < 0) {
            stop(n_index);
        }
        e_original_next_target = s_turret.e_next_target;
        s_turret.e_next_target = _get_best_target(n_index);
        if (isdefined(s_turret.e_next_target)) {
            no_target_start_time = 0;
            if (_user_check(n_index)) {
                self thread _shoot_turret_at_target(s_turret.e_next_target, turret_think_time, v_offset, n_index);
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
            if (!(isdefined(s_turret.disable_ai_getoff) && s_turret.disable_ai_getoff)) {
                bwasplayertarget = isdefined(s_turret.e_last_target) && s_turret.e_last_target.health > 0 && isplayer(s_turret.e_last_target);
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
        if (!(isdefined(s_turret.disable_ai_getoff) && s_turret.disable_ai_getoff) && _has_nearby_player_enemy(n_index, self)) {
            _drop_turret(n_index, 0);
        }
        wait turret_think_time;
    }
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0x7f50b3d5, Offset: 0x2550
// Size: 0x1b4
function _turret_health_monitor(n_index) {
    self endon(#"death");
    waitframe(1);
    if (isdefined(self.var_e95f572e) && self.var_e95f572e) {
        str_tag = "tag_barrel";
        if (isdefined(n_index) && n_index > 0) {
            str_tag = "tag_gunner_barrel" + n_index;
        }
        turret_target = spawn("script_model", self gettagorigin(str_tag) + (0, 0, 0));
        turret_target setmodel("tag_origin");
        turret_target linkto(self, str_tag);
        turret_target.team = self.team;
        target_set(turret_target, (0, 0, 0));
        turret_target.parent = self;
        _turret_health_monitor_loop(n_index);
        if (isdefined(turret_target)) {
            turret_target delete();
        }
        self disable(n_index);
        return;
    }
    _turret_health_monitor_loop(n_index);
    self disable(n_index);
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0xda226f0e, Offset: 0x2710
// Size: 0x84
function _turret_health_monitor_loop(n_index) {
    self endon(#"death");
    self endon("turret_disabled" + _index(n_index));
    while (true) {
        waitresult = self waittill("broken");
        if (waitresult.type === "turret_destroyed_" + n_index) {
            return;
        }
    }
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0xcce33087, Offset: 0x27a0
// Size: 0x1fc
function _has_nearby_player_enemy(index, turret) {
    has_nearby_enemy = 0;
    time = gettime();
    ai_user = turret get_user(index);
    if (!isdefined(ai_user)) {
        return has_nearby_enemy;
    }
    if (!isdefined(turret.next_nearby_enemy_time)) {
        turret.next_nearby_enemy_time = time;
    }
    if (time >= turret.next_nearby_enemy_time) {
        players = getplayers();
        foreach (player in players) {
            if (turret.team == player.team) {
                continue;
            }
            if (abs(ai_user.origin[2] - player.origin[2]) <= 60 && distance2dsquared(ai_user.origin, player.origin) <= 300 * 300) {
                has_nearby_enemy = 1;
                break;
            }
        }
        turret.next_nearby_enemy_time = time + 1000;
    }
    return has_nearby_enemy;
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0x6bb23df3, Offset: 0x29a8
// Size: 0x198
function function_50f8f315(n_index) {
    self endon(#"death");
    self endon("turret_disabled" + _index(n_index));
    self endon("_turret_think" + _index(n_index));
    s_turret = _get_turret_data(n_index);
    ai_user = self getseatoccupant(n_index);
    if (isactor(ai_user)) {
        self thread _listen_for_damage_on_actor(ai_user, n_index);
    }
    while (true) {
        _waittill_user_change(n_index);
        if (!_user_check(n_index)) {
            stop(n_index, 1);
            continue;
        }
        ai_user = self getseatoccupant(n_index);
        if (isactor(ai_user)) {
            self thread _listen_for_damage_on_actor(ai_user, n_index);
        }
    }
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0x7327ba6, Offset: 0x2b48
// Size: 0x120
function _listen_for_damage_on_actor(ai_user, n_index) {
    self endon(#"death");
    ai_user endon(#"death");
    self endon("turret_disabled" + _index(n_index));
    self endon("_turret_think" + _index(n_index));
    self endon(#"exit_vehicle");
    while (true) {
        waitresult = ai_user waittill("damage");
        s_turret = _get_turret_data(n_index);
        if (isdefined(s_turret)) {
            if (!isdefined(s_turret.e_next_target) && !isdefined(s_turret.e_target)) {
                s_turret.e_last_target = waitresult.attacker;
            }
        }
    }
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0xd23f37, Offset: 0x2c70
// Size: 0xd4
function _waittill_user_change(n_index) {
    ai_user = self getseatoccupant(n_index);
    if (isalive(ai_user)) {
        if (isactor(ai_user)) {
            ai_user endon(#"death");
        } else if (isplayer(ai_user)) {
            self notify("turret_disabled" + _index(n_index));
        }
    }
    self util::waittill_either("exit_vehicle", "enter_vehicle");
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0x51e0bca, Offset: 0x2d50
// Size: 0xd0
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
        }
        waitframe(1);
    }
    return false;
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0xf40defd1, Offset: 0x2e28
// Size: 0x9c
function _drop_turret(n_index, bexitifautomatedonly) {
    ai_user = get_user(n_index);
    if (isdefined(bexitifautomatedonly) && (isdefined(ai_user.turret_auto_use) && ai_user.turret_auto_use || isalive(ai_user) && !bexitifautomatedonly)) {
        ai_user vehicle::get_out();
    }
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0xe57f1226, Offset: 0x2ed0
// Size: 0x410
function function_b5dd89ec(n_index) {
    self endon(#"death");
    self endon("_turret_think" + _index(n_index));
    self endon("turret_disabled" + _index(n_index));
    s_turret = _get_turret_data(n_index);
    if (n_index == 0) {
        var_7f7aca6b = "driver";
    } else {
        var_7f7aca6b = "gunner" + n_index;
    }
    while (true) {
        wait 3;
        if (isdefined(self.script_auto_use) && does_have_target(n_index) && !_user_check(n_index) && self.script_auto_use) {
            str_team = get_team(n_index);
            var_bb65a987 = getaiarchetypearray("human", str_team);
            var_2260972c = arraysortclosest(getaiarray(), self.origin, 99999, 0, 300);
            if (var_bb65a987.size > 0) {
                var_4d8961b4 = [];
                if (isdefined(self.var_4e7785d7)) {
                    var_4d8961b4 = arraysort(var_bb65a987, self.origin, 1, var_4d8961b4.size, self.var_4e7785d7);
                } else {
                    var_4d8961b4 = arraysort(var_bb65a987, self.origin, 1);
                }
                ai_user = undefined;
                foreach (ai in var_4d8961b4) {
                    var_f2486e4d = 0;
                    foreach (ai_enemy in var_2260972c) {
                        if (ai_enemy.team != ai.team) {
                            var_f2486e4d = 1;
                            break;
                        }
                    }
                    if (var_f2486e4d) {
                        continue;
                    }
                    if (ai flagsys::get("vehiclerider")) {
                        continue;
                    }
                    if (!ai vehicle::function_293281a2(self, var_7f7aca6b)) {
                        continue;
                    }
                    ai_user = ai;
                    break;
                }
                if (isalive(ai_user)) {
                    ai_user.turret_auto_use = 1;
                    ai_user vehicle::get_in(self, var_7f7aca6b);
                }
            }
        }
    }
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0x2857e570, Offset: 0x32e8
// Size: 0x2c
function does_have_target(n_index) {
    return isdefined(_get_turret_data(n_index).e_next_target);
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0xa65e2b68, Offset: 0x3320
// Size: 0x78
function _user_check(n_index) {
    s_turret = _get_turret_data(n_index);
    if (does_need_user(n_index)) {
        b_has_user = does_have_user(n_index);
        return b_has_user;
    }
    return 1;
}

/#

    // Namespace turret/turret_shared
    // Params 1, eflags: 0x0
    // Checksum 0x21e33e16, Offset: 0x33a0
    // Size: 0x35e
    function _debug_turret_think(n_index) {
        self endon(#"death");
        self endon("<dev string:x10f>" + _index(n_index));
        self endon("<dev string:x11d>" + _index(n_index));
        s_turret = _get_turret_data(n_index);
        v_color = (0, 0, 1);
        while (true) {
            if (!getdvarint("<dev string:x12d>")) {
                wait 0.2;
                continue;
            }
            has_target = isdefined(get_target(n_index));
            if (does_need_user(n_index) && !does_have_user(n_index) || !has_target) {
                v_color = (1, 1, 0);
            } else {
                v_color = (0, 1, 0);
            }
            str_team = get_team(n_index);
            if (!isdefined(str_team)) {
                str_team = "<dev string:x13c>";
            }
            str_target = "<dev string:x144>";
            e_target = s_turret.e_next_target;
            if (isdefined(e_target)) {
                if (isactor(e_target)) {
                    str_target += "<dev string:x14e>";
                } else if (isplayer(e_target)) {
                    str_target += "<dev string:x151>";
                } else if (isvehicle(e_target)) {
                    str_target += "<dev string:x158>";
                } else if (isdefined(e_target.targetname) && e_target.targetname == "<dev string:x160>") {
                    str_target += "<dev string:x160>";
                } else if (isdefined(e_target.classname)) {
                    str_target += e_target.classname;
                }
            } else {
                str_target += "<dev string:x166>";
            }
            str_debug = self getentnum() + "<dev string:x16b>" + str_team + "<dev string:x16b>" + str_target;
            record3dtext(str_debug, self.origin, v_color, "<dev string:x16d>", self);
            waitframe(1);
        }
    }

#/

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0x2ce0b9e2, Offset: 0x3708
// Size: 0xac
function _get_turret_data(n_index) {
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
// Checksum 0x57c12924, Offset: 0x37c0
// Size: 0x3a
function has_turret(n_index) {
    if (isdefined(self.a_turrets) && isdefined(self.a_turrets[n_index])) {
        return true;
    }
    return false;
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0xa08d35eb, Offset: 0x3808
// Size: 0xc0
function _update_turret_arcs(n_index) {
    s_turret = _get_turret_data(n_index);
    s_turret.rightarc = s_turret.w_weapon.rightarc;
    s_turret.leftarc = s_turret.w_weapon.leftarc;
    s_turret.toparc = s_turret.w_weapon.toparc;
    s_turret.bottomarc = s_turret.w_weapon.bottomarc;
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0xc94e29ba, Offset: 0x38d0
// Size: 0x1d8
function _init_turret(n_index) {
    if (!isdefined(n_index)) {
        n_index = 0;
    }
    self endon(#"death");
    w_weapon = get_weapon(n_index);
    if (w_weapon == level.weaponnone) {
        /#
            assertmsg("<dev string:x174>");
        #/
        return;
    }
    util::waittill_asset_loaded("xmodel", self.model);
    s_turret = _init_vehicle_turret(n_index);
    s_turret.w_weapon = w_weapon;
    _update_turret_arcs(n_index);
    s_turret.is_enabled = 0;
    s_turret.e_parent = self;
    s_turret.e_target = undefined;
    s_turret.b_ignore_line_of_sight = 0;
    s_turret.v_offset = (0, 0, 0);
    s_turret.n_burst_fire_time = 0;
    s_turret.str_weapon_type = w_weapon.type;
    s_turret.str_guidance_type = w_weapon.guidedmissiletype;
    set_on_target_angle(undefined, n_index);
    s_turret flag::init("turret manual");
    return s_turret;
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0xf9fc03db, Offset: 0x3ab0
// Size: 0x230
function _init_vehicle_turret(n_index) {
    /#
        assert(isdefined(n_index) && n_index >= 0, "<dev string:x19e>");
    #/
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
// Params 2, eflags: 0x0
// Checksum 0x72322427, Offset: 0x3ce8
// Size: 0x20e
function _burst_fire(n_max_time, n_index) {
    self endon(#"terminate_all_turrets_firing");
    if (n_max_time < 0) {
        n_max_time = 9999;
    }
    s_turret = _get_turret_data(n_index);
    n_burst_time = _get_burst_fire_time(n_index);
    n_burst_wait = _get_burst_wait_time(n_index);
    if (!isdefined(n_burst_time) || n_burst_time > n_max_time) {
        n_burst_time = n_max_time;
    }
    if (s_turret.n_burst_fire_time >= n_burst_time) {
        s_turret.n_burst_fire_time = 0;
        n_time_since_last_shot = (gettime() - s_turret.n_last_fire_time) / 1000;
        if (n_time_since_last_shot < n_burst_wait) {
            wait n_burst_wait - n_time_since_last_shot;
        }
    } else {
        n_burst_time -= s_turret.n_burst_fire_time;
    }
    w_weapon = get_weapon(n_index);
    n_fire_time = w_weapon.firetime;
    n_total_time = 0;
    while (n_total_time < n_burst_time) {
        fire(n_index);
        n_total_time += n_fire_time;
        s_turret.n_burst_fire_time += n_fire_time;
        wait n_fire_time;
    }
    if (n_burst_wait > 0) {
        wait n_burst_wait;
    }
    return n_burst_time + n_burst_wait;
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0x8033d957, Offset: 0x3f00
// Size: 0x114
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
// Params 1, eflags: 0x0
// Checksum 0x4c12faea, Offset: 0x4020
// Size: 0x114
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
// Params 1, eflags: 0x0
// Checksum 0x6111f337, Offset: 0x4140
// Size: 0x2e
function _index(n_index) {
    return isdefined(n_index) ? "" + n_index : "";
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0x23af0da, Offset: 0x4178
// Size: 0xea
function _get_best_target(n_index) {
    e_best_target = undefined;
    if (!issentient(self)) {
        self makesentient();
    }
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
    return e_best_target;
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0x7093a226, Offset: 0x4270
// Size: 0x18c
function can_hit_target(e_target, n_index) {
    s_turret = _get_turret_data(n_index);
    v_offset = _get_default_target_offset(e_target, n_index);
    b_current_target = is_target(e_target, n_index);
    if (isdefined(e_target.ignoreme) && isdefined(e_target) && e_target.ignoreme) {
        return 0;
    }
    b_trace_passed = 1;
    if (!s_turret.b_ignore_line_of_sight) {
        b_trace_passed = trace_test(e_target, v_offset - (0, 0, isdefined(s_turret.n_torso_targetting_offset) ? s_turret.n_torso_targetting_offset : isvehicle(e_target) ? 0 : 0), n_index);
    }
    if (b_current_target && !b_trace_passed && !isdefined(s_turret.n_time_lose_sight)) {
        s_turret.n_time_lose_sight = gettime();
    }
    return b_trace_passed;
}

// Namespace turret/turret_shared
// Params 3, eflags: 0x0
// Checksum 0xcfec5b7f, Offset: 0x4408
// Size: 0x2b6
function trace_test(e_target, v_offset, n_index) {
    if (!isdefined(v_offset)) {
        v_offset = (0, 0, 0);
    }
    if (isdefined(self.good_old_style_turret_tracing)) {
        s_turret = _get_turret_data(n_index);
        v_start_org = self gettagorigin(s_turret.str_tag_pivot);
        if (e_target sightconetrace(v_start_org, self) > 0.2) {
            v_target = e_target.origin + v_offset;
            v_start_org += vectornormalize(v_target - v_start_org) * 50;
            a_trace = bullettrace(v_start_org, v_target, 1, s_turret.e_trace_ignore, 1, 1);
            if (a_trace["fraction"] > 0.6) {
                return true;
            }
        }
        return false;
    }
    s_turret = _get_turret_data(n_index);
    v_start_org = self gettagorigin(s_turret.str_tag_pivot);
    v_target = e_target.origin + v_offset;
    if (sessionmodeismultiplayergame() && isplayer(e_target)) {
        v_target = e_target getshootatpos();
    }
    if (distancesquared(v_start_org, v_target) < 10000) {
        return true;
    }
    v_dir_to_target = vectornormalize(v_target - v_start_org);
    v_start_org += v_dir_to_target * 50;
    v_target -= v_dir_to_target * 75;
    if (sighttracepassed(v_start_org, v_target, 0, self)) {
        return true;
    }
    return false;
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0x8d859124, Offset: 0x46c8
// Size: 0x4c
function set_ignore_line_of_sight(b_ignore, n_index) {
    s_turret = _get_turret_data(n_index);
    s_turret.b_ignore_line_of_sight = b_ignore;
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0xaba2a69b, Offset: 0x4720
// Size: 0x4c
function set_occupy_no_target_time(time, n_index) {
    s_turret = _get_turret_data(n_index);
    s_turret.occupy_no_target_time = time;
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0x6fe04b48, Offset: 0x4778
// Size: 0x2c
function toggle_lensflare(bool) {
    self clientfield::set("toggle_lensflare", bool);
}

// Namespace turret/turret_shared
// Params 0, eflags: 0x0
// Checksum 0x314f9464, Offset: 0x47b0
// Size: 0x154
function track_lens_flare() {
    self endon(#"death");
    self notify(#"disable_lens_flare");
    self endon(#"disable_lens_flare");
    while (true) {
        e_target = self turretgettarget(0);
        if (isdefined(e_target) && self.turretontarget && isplayer(e_target)) {
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
// Params 1, eflags: 0x0
// Checksum 0x30afadc8, Offset: 0x4910
// Size: 0x82
function _get_gunner_tag_for_turret_index(n_index) {
    switch (n_index) {
    case 1:
        return "tag_gunner1";
    case 2:
        return "tag_gunner2";
    case 3:
        return "tag_gunner3";
    case 4:
        return "tag_gunner4";
    default:
        /#
            assertmsg("<dev string:x1d4>");
        #/
        break;
    }
}

