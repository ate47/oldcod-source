#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicleriders_shared;

#namespace turret;

// Namespace turret/turret_shared
// Params 0, eflags: 0x2
// Checksum 0xcf74edbc, Offset: 0x278
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"turret", &__init__, undefined, undefined);
}

// Namespace turret/turret_shared
// Params 0, eflags: 0x0
// Checksum 0xd0712838, Offset: 0x2c0
// Size: 0x4e
function __init__() {
    clientfield::register("vehicle", "toggle_lensflare", 1, 1, "int");
    level._turrets = spawnstruct();
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0xff6c6237, Offset: 0x318
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
// Checksum 0xa145003b, Offset: 0x380
// Size: 0x2a
function get_parent(n_index) {
    return _get_turret_data(n_index).e_parent;
}

// Namespace turret/turret_shared
// Params 0, eflags: 0x0
// Checksum 0x170922bb, Offset: 0x3b8
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
// Checksum 0xb79cf7ec, Offset: 0x418
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
// Params 0, eflags: 0x0
// Checksum 0x729a9c20, Offset: 0x4c8
// Size: 0xa2
function watch_for_flash() {
    self endon(#"watch_for_flash_and_stun");
    self endon(#"death");
    while (true) {
        waitresult = self waittill(#"flashbang");
        self notify(#"damage", {#amount:1, #attacker:waitresult.attacker, #weapon:"flash_grenade"});
    }
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0x795783c3, Offset: 0x578
// Size: 0xf2
function watch_for_flash_and_stun(n_index) {
    self notify(#"watch_for_flash_and_stun_end");
    self endon(#"watch_for_flash_and_stun");
    self endon(#"death");
    self thread watch_for_flash();
    while (true) {
        waitresult = self waittill(#"damage");
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
// Checksum 0xfe129ec1, Offset: 0x678
// Size: 0x140
function emp_watcher(n_index) {
    self notify(#"emp_thread_stop");
    self endon(#"emp_thread_stop");
    self endon(#"death");
    while (true) {
        waitresult = self waittill(#"damage");
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
// Checksum 0xac6cb78e, Offset: 0x7c0
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
// Params 2, eflags: 0x0
// Checksum 0x4933c947, Offset: 0x850
// Size: 0x3e
function set_team(str_team, n_index) {
    _get_turret_data(n_index).str_team = str_team;
    self.team = str_team;
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0xc91397bc, Offset: 0x898
// Size: 0x66
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
// Checksum 0x190bb00e, Offset: 0x908
// Size: 0x2a
function is_turret_enabled(n_index) {
    return _get_turret_data(n_index).is_enabled;
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0xc510eb1e, Offset: 0x940
// Size: 0x4c
function does_need_user(n_index) {
    return isdefined(_get_turret_data(n_index).b_needs_user) && _get_turret_data(n_index).b_needs_user;
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0xcac48cc7, Offset: 0x998
// Size: 0x32
function does_have_user(n_index) {
    return isalive(get_user(n_index));
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0x692c5970, Offset: 0x9d8
// Size: 0x22
function get_user(n_index) {
    return self getseatoccupant(n_index);
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0x960d0077, Offset: 0xa08
// Size: 0x8a
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
// Checksum 0x9786bf32, Offset: 0xaa0
// Size: 0x50
function _wait_for_current_user_to_finish(n_index) {
    self endon(#"death");
    while (isalive(get_user(n_index))) {
        waitframe(1);
    }
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0xc7a4c8f5, Offset: 0xaf8
// Size: 0x5a
function is_current_user(ai_user, n_index) {
    ai_current_user = get_user(n_index);
    return isalive(ai_current_user) && ai_user == ai_current_user;
}

// Namespace turret/turret_shared
// Params 5, eflags: 0x0
// Checksum 0xbc586ad0, Offset: 0xb60
// Size: 0x8e
function set_burst_parameters(n_fire_min, n_fire_max, n_wait_min, n_wait_max, n_index) {
    s_turret = _get_turret_data(n_index);
    s_turret.n_burst_fire_min = n_fire_min;
    s_turret.n_burst_fire_max = n_fire_max;
    s_turret.n_burst_wait_min = n_wait_min;
    s_turret.n_burst_wait_max = n_wait_max;
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0xf4a5d28a, Offset: 0xbf8
// Size: 0x56
function set_torso_targetting(n_index, n_torso_targetting_offset = -12) {
    s_turret = _get_turret_data(n_index);
    s_turret.n_torso_targetting_offset = n_torso_targetting_offset;
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0xbeb6c1ea, Offset: 0xc58
// Size: 0x56
function set_target_leading(n_index, n_target_leading_factor = 0.1) {
    s_turret = _get_turret_data(n_index);
    s_turret.n_target_leading_factor = n_target_leading_factor;
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0x3b1a87f3, Offset: 0xcb8
// Size: 0x6c
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
// Checksum 0xafd2f3de, Offset: 0xd30
// Size: 0xf2
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
// Checksum 0xa7e2f1b4, Offset: 0xe30
// Size: 0x286
function _get_default_target_offset(e_target, n_index) {
    s_turret = _get_turret_data(n_index);
    if (s_turret.str_weapon_type == "bullet") {
        if (isdefined(e_target)) {
            if (isplayer(e_target)) {
                z_offset = randomintrange(40, 50);
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
// Params 1, eflags: 0x0
// Checksum 0xfa9fca22, Offset: 0x10c0
// Size: 0xb2
function get_target(n_index) {
    if (isdefined(_get_turret_data(n_index).e_target) && isdefined(_get_turret_data(n_index).e_target.ignoreme) && _get_turret_data(n_index).e_target.ignoreme) {
        clear_target(n_index);
    }
    return _get_turret_data(n_index).e_target;
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0x8b8f0b65, Offset: 0x1180
// Size: 0x4c
function is_target(e_target, n_index) {
    e_current_target = get_target(n_index);
    if (isdefined(e_current_target)) {
        return (e_current_target == e_target);
    }
    return false;
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0x343f8ec4, Offset: 0x11d8
// Size: 0xac
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
// Checksum 0x4ce0f751, Offset: 0x1290
// Size: 0x46
function set_min_target_distance_squared(n_distance_squared, n_index) {
    s_turret = _get_turret_data(n_index);
    s_turret.n_min_target_distance_squared = n_distance_squared;
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0xacf4a51, Offset: 0x12e0
// Size: 0x15a
function fire(n_index) {
    s_turret = _get_turret_data(n_index);
    assert(isdefined(n_index) && n_index >= 0, "<dev string:x30>");
    if (n_index == 0) {
        self fireweapon(0, s_turret.e_target);
    } else {
        ai_current_user = get_user(n_index);
        if (isdefined(ai_current_user) && isdefined(ai_current_user.is_disabled) && ai_current_user.is_disabled) {
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
// Checksum 0x93855c2b, Offset: 0x1448
// Size: 0xb8
function stop(n_index, b_clear_target = 0) {
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
// Checksum 0xcc2268f3, Offset: 0x1508
// Size: 0x1c8
function fire_for_time(n_time, n_index = 0) {
    assert(isdefined(n_time), "<dev string:x60>");
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
            assert(n_time >= w_weapon.firetime, "<dev string:x9a>" + n_time + "<dev string:xa6>" + w_weapon.firetime);
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
// Checksum 0x26e54f76, Offset: 0x16d8
// Size: 0xf4
function shoot_at_target(e_target, n_time, v_offset, n_index, b_just_once) {
    assert(isdefined(e_target), "<dev string:xe9>");
    self endon(#"drone_death");
    self endon(#"death");
    s_turret = _get_turret_data(n_index);
    s_turret flag::set("turret manual");
    _shoot_turret_at_target(e_target, n_time, v_offset, n_index, b_just_once);
    s_turret flag::clear("turret manual");
}

// Namespace turret/turret_shared
// Params 5, eflags: 0x0
// Checksum 0x70e6f59c, Offset: 0x17d8
// Size: 0x184
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
// Checksum 0x4f31f67b, Offset: 0x1968
// Size: 0xa2
function _waittill_turret_on_target(e_target, n_index) {
    do {
        wait isdefined(self.waittill_turret_on_target_delay) ? self.waittill_turret_on_target_delay : 0.5;
        if (!isdefined(n_index) || n_index == 0) {
            self waittill(#"turret_on_target");
            continue;
        }
        self waittill(#"gunner_turret_on_target");
    } while (isdefined(e_target) && !can_hit_target(e_target, n_index));
}

// Namespace turret/turret_shared
// Params 3, eflags: 0x0
// Checksum 0xddae47e, Offset: 0x1a18
// Size: 0x44
function shoot_at_target_once(e_target, v_offset, n_index) {
    shoot_at_target(e_target, 0, v_offset, n_index, 1);
}

// Namespace turret/turret_shared
// Params 3, eflags: 0x0
// Checksum 0xde1f38b5, Offset: 0x1a68
// Size: 0xfc
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
// Checksum 0x4e8b8ddc, Offset: 0x1b70
// Size: 0x2a
function enable_auto_use(b_enable = 1) {
    self.script_auto_use = b_enable;
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0xce1e5e1e, Offset: 0x1ba8
// Size: 0x42
function disable_ai_getoff(n_index, b_disable = 1) {
    _get_turret_data(n_index).disable_ai_getoff = b_disable;
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0x12584d4e, Offset: 0x1bf8
// Size: 0x90
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
// Checksum 0x1cee5c48, Offset: 0x1c90
// Size: 0xc4
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
// Params 1, eflags: 0x0
// Checksum 0x4df0558c, Offset: 0x1d60
// Size: 0x3a
function unpause(n_index) {
    s_turret = _get_turret_data(n_index);
    s_turret.pause = undefined;
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0xb55602a0, Offset: 0x1da8
// Size: 0x49e
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
// Checksum 0xee14f88c, Offset: 0x2250
// Size: 0x54
function _turret_health_monitor(n_index) {
    self endon(#"death");
    waitframe(1);
    _turret_health_monitor_loop(n_index);
    self disable(n_index);
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0x2da36f1e, Offset: 0x22b0
// Size: 0x90
function _turret_health_monitor_loop(n_index) {
    self endon(#"death");
    self endon("turret_disabled" + _index(n_index));
    while (true) {
        waitresult = self waittill(#"broken");
        if (waitresult.type === "turret_destroyed_" + n_index) {
            return;
        }
    }
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0xb05b6fe1, Offset: 0x2348
// Size: 0x1ce
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
// Params 2, eflags: 0x0
// Checksum 0x1dc06cb9, Offset: 0x2520
// Size: 0x122
function _listen_for_damage_on_actor(ai_user, n_index) {
    self endon(#"death");
    ai_user endon(#"death");
    self endon("turret_disabled" + _index(n_index));
    self endon("_turret_think" + _index(n_index));
    self endon(#"exit_vehicle");
    while (true) {
        waitresult = ai_user waittill(#"damage");
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
// Checksum 0x807f914e, Offset: 0x2650
// Size: 0xd4
function _waittill_user_change(n_index) {
    ai_user = self getseatoccupant(n_index);
    if (isalive(ai_user)) {
        if (isactor(ai_user)) {
            ai_user endon(#"death");
        } else if (util::function_30b386cd(ai_user)) {
            self notify("turret_disabled" + _index(n_index));
        }
    }
    self util::waittill_either("exit_vehicle", "enter_vehicle");
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0xf793c296, Offset: 0x2730
// Size: 0xb8
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
// Checksum 0x3f309fb9, Offset: 0x27f0
// Size: 0xdc
function _drop_turret(n_index, bexitifautomatedonly) {
    ai_user = get_user(n_index);
    if (isalive(ai_user) && !isbot(ai_user) && !isplayer(ai_user) && (isdefined(ai_user.turret_auto_use) && ai_user.turret_auto_use || !(isdefined(bexitifautomatedonly) && bexitifautomatedonly))) {
        vehicle::get_out(self, ai_user, "gunner1");
    }
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0x950a077a, Offset: 0x28d8
// Size: 0x2c
function does_have_target(n_index) {
    return isdefined(_get_turret_data(n_index).e_next_target);
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0x31e2e6ff, Offset: 0x2910
// Size: 0x76
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
    // Checksum 0xe396976e, Offset: 0x2990
    // Size: 0x326
    function _debug_turret_think(n_index) {
        self endon(#"death");
        self endon("<dev string:x117>" + _index(n_index));
        self endon("<dev string:x125>" + _index(n_index));
        s_turret = _get_turret_data(n_index);
        v_color = (0, 0, 1);
        while (true) {
            if (!getdvarint(#"g_debugturrets", 0)) {
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
                str_team = "<dev string:x135>";
            }
            str_target = "<dev string:x13d>";
            e_target = s_turret.e_next_target;
            if (isdefined(e_target)) {
                if (isactor(e_target)) {
                    str_target += "<dev string:x147>";
                } else if (isplayer(e_target)) {
                    str_target += "<dev string:x14a>";
                } else if (isvehicle(e_target)) {
                    str_target += "<dev string:x151>";
                } else if (isdefined(e_target.targetname) && e_target.targetname == "<dev string:x159>") {
                    str_target += "<dev string:x159>";
                } else if (isdefined(e_target.classname)) {
                    str_target += e_target.classname;
                }
            } else {
                str_target += "<dev string:x15f>";
            }
            str_debug = self getentnum() + "<dev string:x164>" + str_team + "<dev string:x164>" + str_target;
            record3dtext(str_debug, self.origin, v_color, "<dev string:x166>", self);
            waitframe(1);
        }
    }

#/

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0xf60aeb50, Offset: 0x2cc0
// Size: 0x92
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
// Checksum 0xa81ec033, Offset: 0x2d60
// Size: 0x34
function has_turret(n_index) {
    if (isdefined(self.a_turrets) && isdefined(self.a_turrets[n_index])) {
        return true;
    }
    return false;
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0xf148278f, Offset: 0x2da0
// Size: 0xae
function _update_turret_arcs(n_index) {
    s_turret = _get_turret_data(n_index);
    s_turret.rightarc = s_turret.w_weapon.rightarc;
    s_turret.leftarc = s_turret.w_weapon.leftarc;
    s_turret.toparc = s_turret.w_weapon.toparc;
    s_turret.bottomarc = s_turret.w_weapon.bottomarc;
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0xe62354f, Offset: 0x2e58
// Size: 0x1b0
function _init_turret(n_index = 0) {
    self endon(#"death");
    w_weapon = get_weapon(n_index);
    if (w_weapon.name == #"none") {
        assertmsg("<dev string:x16d>");
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
// Checksum 0x64518ce9, Offset: 0x3010
// Size: 0x250
function _init_vehicle_turret(n_index) {
    assert(isdefined(n_index) && n_index >= 0, "<dev string:x197>");
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
// Checksum 0xb150e276, Offset: 0x3268
// Size: 0x1f2
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
        n_time_since_last_shot = float(gettime() - s_turret.n_last_fire_time) / 1000;
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
// Checksum 0xd75cd2a6, Offset: 0x3468
// Size: 0xf2
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
// Checksum 0xe677eb18, Offset: 0x3568
// Size: 0xf2
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
// Checksum 0x3fc18040, Offset: 0x3668
// Size: 0x2a
function _index(n_index) {
    return isdefined(n_index) ? "" + n_index : "";
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0xc8e7f620, Offset: 0x36a0
// Size: 0xfe
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
// Checksum 0xb5cafbd6, Offset: 0x37a8
// Size: 0x16a
function can_hit_target(e_target, n_index) {
    s_turret = _get_turret_data(n_index);
    v_offset = _get_default_target_offset(e_target, n_index);
    b_current_target = is_target(e_target, n_index);
    if (isdefined(e_target) && isdefined(e_target.ignoreme) && e_target.ignoreme) {
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
// Checksum 0x352e87a2, Offset: 0x3920
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
    v_target = e_target.origin + v_offset;
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
// Checksum 0x54d2098b, Offset: 0x3bb8
// Size: 0x46
function set_ignore_line_of_sight(b_ignore, n_index) {
    s_turret = _get_turret_data(n_index);
    s_turret.b_ignore_line_of_sight = b_ignore;
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0x30876e0c, Offset: 0x3c08
// Size: 0x46
function set_occupy_no_target_time(time, n_index) {
    s_turret = _get_turret_data(n_index);
    s_turret.occupy_no_target_time = time;
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0x717983b9, Offset: 0x3c58
// Size: 0x2c
function toggle_lensflare(bool) {
    self clientfield::set("toggle_lensflare", bool);
}

// Namespace turret/turret_shared
// Params 0, eflags: 0x0
// Checksum 0xb96a0867, Offset: 0x3c90
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
// Params 1, eflags: 0x0
// Checksum 0x5f39758, Offset: 0x3df8
// Size: 0xaa
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
        assertmsg("<dev string:x1cd>");
        break;
    }
}

