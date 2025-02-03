#using scripts\core_common\ai\archetype_cover_utility;
#using scripts\core_common\ai\archetype_damage_utility;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\animation_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicleriders_shared;

#namespace turret;

// Namespace turret/turret_shared
// Params 0, eflags: 0x6
// Checksum 0xce374324, Offset: 0x398
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"turret", &preinit, undefined, undefined, undefined);
}

// Namespace turret/turret_shared
// Params 0, eflags: 0x4
// Checksum 0xda896787, Offset: 0x3e0
// Size: 0x5c
function private preinit() {
    clientfield::register("vehicle", "toggle_lensflare", 1, 1, "int");
    level._turrets = spawnstruct();
    registerbehaviorscriptfunctions();
}

// Namespace turret/turret_shared
// Params 0, eflags: 0x4
// Checksum 0x577f98d9, Offset: 0x448
// Size: 0x1a4
function private registerbehaviorscriptfunctions() {
    assert(isscriptfunctionptr(&function_2c6be6cd));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4da9c87ccb6a9163", &function_2c6be6cd);
    assert(isscriptfunctionptr(&function_90e78f70));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_38b92465454460ba", &function_90e78f70);
    assert(isscriptfunctionptr(&function_38388863));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_400342bceb3fa64e", &function_38388863);
    assert(isscriptfunctionptr(&function_3628f3da));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2eef1e8d94fa0609", &function_3628f3da);
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x4
// Checksum 0x6a994364, Offset: 0x5f8
// Size: 0x2a
function private function_2c6be6cd(entity) {
    return entity flag::get(#"turret_pilot");
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x4
// Checksum 0x44fde8da, Offset: 0x630
// Size: 0x2a
function private function_90e78f70(entity) {
    return entity flag::get(#"hash_79f73bc0bf703a5d");
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x4
// Checksum 0x676d11de, Offset: 0x668
// Size: 0x18
function private function_38388863(entity) {
    return isdefined(entity.var_2df45b5d);
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x4
// Checksum 0x16a74833, Offset: 0x688
// Size: 0x16
function private function_3628f3da(entity) {
    entity.var_2df45b5d = undefined;
}

// Namespace turret/turret_shared
// Params 12, eflags: 0x4
// Checksum 0x255c2190, Offset: 0x6a8
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
// Params 1, eflags: 0x0
// Checksum 0x38f40dc6, Offset: 0x778
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
// Checksum 0xe13203d0, Offset: 0x7e0
// Size: 0x2a
function get_parent(n_index) {
    return _get_turret_data(n_index).e_parent;
}

// Namespace turret/turret_shared
// Params 0, eflags: 0x0
// Checksum 0x531c048f, Offset: 0x818
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
// Checksum 0x59e17163, Offset: 0x878
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
// Params 1, eflags: 0x0
// Checksum 0x2bdbb4c7, Offset: 0x928
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
// Checksum 0x4d78c459, Offset: 0xa88
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
// Checksum 0xfa477e3c, Offset: 0xb18
// Size: 0x3e
function set_team(str_team, n_index) {
    _get_turret_data(n_index).str_team = str_team;
    self.team = str_team;
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0xb30c2606, Offset: 0xb60
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
// Params 1, eflags: 0x0
// Checksum 0x17f954c0, Offset: 0xbd0
// Size: 0x2a
function is_turret_enabled(n_index) {
    return _get_turret_data(n_index).is_enabled;
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0xfaddd521, Offset: 0xc08
// Size: 0x3a
function does_need_user(n_index) {
    return is_true(_get_turret_data(n_index).b_needs_user);
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0x257c9726, Offset: 0xc50
// Size: 0x32
function does_have_user(n_index) {
    return isalive(get_user(n_index));
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0x1c34c0aa, Offset: 0xc90
// Size: 0x22
function get_user(n_index) {
    return self getseatoccupant(n_index);
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0x1a93111a, Offset: 0xcc0
// Size: 0x42
function _set_turret_needs_user(n_index, b_needs_user) {
    s_turret = _get_turret_data(n_index);
    s_turret.b_needs_user = b_needs_user;
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0xabe07192, Offset: 0xd10
// Size: 0x56
function is_current_user(ai_user, n_index) {
    ai_current_user = get_user(n_index);
    return isalive(ai_current_user) && ai_user == ai_current_user;
}

// Namespace turret/turret_shared
// Params 5, eflags: 0x0
// Checksum 0x7a45fc90, Offset: 0xd70
// Size: 0x7e
function set_burst_parameters(n_fire_min, n_fire_max, n_wait_min, n_wait_max, n_index) {
    s_turret = _get_turret_data(n_index);
    s_turret.n_burst_fire_min = n_fire_min;
    s_turret.n_burst_fire_max = n_fire_max;
    s_turret.n_burst_wait_min = n_wait_min;
    s_turret.n_burst_wait_max = n_wait_max;
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0x79ffec79, Offset: 0xdf8
// Size: 0x52
function set_torso_targetting(n_index, n_torso_targetting_offset = -12) {
    s_turret = _get_turret_data(n_index);
    s_turret.n_torso_targetting_offset = n_torso_targetting_offset;
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0xfbfa1091, Offset: 0xe58
// Size: 0x52
function set_target_leading(n_index, n_target_leading_factor = 0.1) {
    s_turret = _get_turret_data(n_index);
    s_turret.n_target_leading_factor = n_target_leading_factor;
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0x1c15fecf, Offset: 0xeb8
// Size: 0x3c
function set_on_target_angle(n_angle, n_index = 0) {
    self turretsetontargettolerance(n_index, n_angle);
}

// Namespace turret/turret_shared
// Params 5, eflags: 0x0
// Checksum 0x768a9ddd, Offset: 0xf00
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
// Params 2, eflags: 0x4
// Checksum 0x44174071, Offset: 0x10a8
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
// Params 1, eflags: 0x0
// Checksum 0xfb463846, Offset: 0x1318
// Size: 0x36
function get_target(n_index) {
    s_turret = _get_turret_data(n_index);
    return s_turret.target;
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0x34fd19ba, Offset: 0x1358
// Size: 0xae
function is_target(target, n_index) {
    current_target = get_target(n_index);
    if (isdefined(current_target) && (isentity(target) && isentity(current_target) || isvec(target) && isvec(current_target))) {
        return (current_target == target);
    }
    return false;
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0x8e78bb95, Offset: 0x1410
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
// Checksum 0x53fff475, Offset: 0x14a8
// Size: 0x4a
function function_49c3b892(e_target, n_index = 0) {
    s_turret = _get_turret_data(n_index);
    s_turret.favoriteenemy = e_target;
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0xbdce3924, Offset: 0x1500
// Size: 0x3e
function get_favorite_enemy(n_index = 0) {
    s_turret = _get_turret_data(n_index);
    return s_turret.favoriteenemy;
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0xc7f73546, Offset: 0x1548
// Size: 0x4a
function function_41c79ce4(b_enable, n_index = 0) {
    s_turret = _get_turret_data(n_index);
    s_turret.perfectaim = b_enable;
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0x7985ab88, Offset: 0x15a0
// Size: 0x42
function set_min_target_distance_squared(n_distance_squared, n_index) {
    s_turret = _get_turret_data(n_index);
    s_turret.n_min_target_distance_squared = n_distance_squared;
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0xa3a3ca03, Offset: 0x15f0
// Size: 0x98
function function_9c04d437(var_6a56e517, n_index = 0) {
    s_turret = _get_turret_data(n_index);
    s_turret flag::set("turret manual");
    if (is_true(var_6a56e517)) {
        self notify("turret manual" + _index(n_index));
    }
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0xf09ab273, Offset: 0x1690
// Size: 0x54
function function_21827343(n_index = 0) {
    s_turret = _get_turret_data(n_index);
    s_turret flag::clear("turret manual");
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0xac76f5ad, Offset: 0x16f0
// Size: 0x4a
function function_3e5395(n_seconds, n_index = 0) {
    s_turret = _get_turret_data(n_index);
    s_turret.var_b52bbdba = n_seconds;
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0x620f2e3b, Offset: 0x1748
// Size: 0x82
function function_30a9811a(n_scale, n_index = 0) {
    assert(isdefined(n_scale) && n_scale > 0, "<dev string:x38>");
    s_turret = _get_turret_data(n_index);
    s_turret.var_72f4d1b7 = n_scale;
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0x98a0c684, Offset: 0x17d8
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
// Params 3, eflags: 0x0
// Checksum 0x1ce7b991, Offset: 0x1980
// Size: 0x1b6
function fire_for_time(n_time, n_index = 0, var_7cd5e5c = "unused") {
    self endon(var_7cd5e5c, #"terminate_all_turrets_firing", #"death", "_stop_turret" + _index(n_index), "turret_disabled" + _index(n_index), "turret manual" + _index(n_index));
    var_17b7891d = "3fea036d77ed91a5" + _index(n_index);
    self notify(var_17b7891d);
    self endon(var_17b7891d);
    s_turret = _get_turret_data(n_index);
    w_weapon = get_weapon(n_index);
    n_fire_time = w_weapon.firetime;
    n_shots = 0;
    var_23ec945b = floor(abs(n_time / n_fire_time));
    while (n_shots < var_23ec945b) {
        if (n_time > 0) {
            n_shots++;
        }
        self fire(n_index);
        wait n_fire_time;
    }
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0xe74132ff, Offset: 0x1b40
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
// Params 2, eflags: 0x0
// Checksum 0x8bf62937, Offset: 0x1c10
// Size: 0x224
function get_in(ai_actor, n_index = 0) {
    if (isalive(ai_actor) && !is_true(ai_actor islinkedto(self))) {
        s_turret = _get_turret_data(n_index);
        self usevehicle(ai_actor, n_index);
        ai_actor flag::set(#"turret_pilot");
        if (is_true(s_turret.var_7394b9dc)) {
            ai_actor.allowpain = 0;
            ai_actor.blockingpain = 1;
        }
        /#
            if (!is_true(ai_actor islinkedto(self))) {
                ai_actor linkto(self);
                println("<dev string:xb6>" + n_index + "<dev string:xf8>" + self.model + "<dev string:x104>");
            }
        #/
        self enable(n_index, 1);
        ai_actor.s_turret = s_turret;
        ai_actor.var_72f4d1b7 = s_turret.var_72f4d1b7;
        ai_actor.var_41adb97 = undefined;
        aiutility::addaioverridedamagecallback(ai_actor, &function_d72fcb0a);
        self thread handle_rider_death(ai_actor, n_index);
        self thread function_2c718f9e(ai_actor, n_index);
        self thread function_738effc8(ai_actor, n_index);
    }
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x4
// Checksum 0xdbae6f44, Offset: 0x1e40
// Size: 0x298
function private function_2c718f9e(ai_actor, n_index) {
    self endon(#"death", "turret_disabled" + _index(n_index));
    ai_actor endon(#"death");
    s_turret = _get_turret_data(n_index);
    while (true) {
        ai_actor waittill(#"pain");
        if (is_true(s_turret.var_7394b9dc) || is_true(s_turret.var_aa100948)) {
            continue;
        }
        s_turret.e_last_target = s_turret.target;
        s_turret.var_aa100948 = 1;
        var_d8c89de3 = 1.5;
        stop(n_index, 1);
        pause(-1, n_index);
        self turretsettargetangles(n_index, (0, 0, 0));
        waitframe(2);
        if (isdefined(s_turret.var_bf6d793d) && isdefined(s_turret.var_bf6d793d.var_81610bb0)) {
            for (i = 0; i < 10; i++) {
                if (isdefined(s_turret.var_bf6d793d.var_81610bb0[i])) {
                    var_1e713ee7 = s_turret.var_bf6d793d.var_81610bb0[i].xanim;
                    if (isdefined(var_1e713ee7)) {
                        anim_time = ai_actor getanimtime(var_1e713ee7);
                        if (anim_time > 0) {
                            var_73a9738e = getanimlength(var_1e713ee7);
                            var_d8c89de3 = (1 - anim_time) * var_73a9738e;
                            break;
                        }
                    }
                }
            }
        }
        wait var_d8c89de3;
        s_turret.var_aa100948 = 0;
        unpause(n_index);
        set_target(s_turret.e_last_target);
    }
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x4
// Checksum 0x745ec03f, Offset: 0x20e0
// Size: 0x94
function private function_738effc8(ai_actor, n_index) {
    self endon(#"death");
    ai_actor endon(#"death");
    ai_actor waittill(#"goal_changed");
    /#
        if (getdvarint(#"hash_47a40f04e7c48117", 0)) {
            return;
        }
    #/
    self _drop_turret(n_index);
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0x2852e5fb, Offset: 0x2180
// Size: 0x220
function get_out(ai_actor, n_index = 0) {
    if (ai_actor islinkedto(self)) {
        self usevehicle(ai_actor, n_index);
        if (isalive(ai_actor)) {
            ai_actor flag::clear(#"turret_pilot");
            ai_actor.s_turret = undefined;
            ai_actor.var_72f4d1b7 = undefined;
            ai_actor.blockingpain = 0;
            ai_actor.allowpain = 1;
            ai_actor.ignoreme = 0;
            aiutility::releaseclaimnode(ai_actor);
            aiutility::choosebestcovernodeasap(ai_actor);
            if (isdefined(ai_actor.aioverridedamage)) {
                aiutility::removeaioverridedamagecallback(ai_actor, &function_d72fcb0a);
            }
            var_3b228fdf = isdefined(ai_actor.node) && ai_actor.node.type == "Turret";
            var_3b228fdf |= isdefined(ai_actor.covernode) && ai_actor.covernode.type == "Turret";
            if (var_3b228fdf) {
                ai_actor.var_41adb97 = gettime() + 4000;
                ai_actor setgoal(ai_actor.origin, 0, ai_actor.goalradius);
            }
        }
        self disable(n_index);
        self notify(#"exit_vehicle");
        ai_actor notify(#"exit_vehicle");
    }
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0x16c08545, Offset: 0x23a8
// Size: 0xf4
function handle_rider_death(ai_rider, n_index = 0) {
    self endon(#"death", "turret_disabled" + _index(n_index));
    ai_rider waittill(#"death");
    if (ai_rider flag::get(#"turret_pilot")) {
        ai_rider flag::clear(#"turret_pilot");
        ai_rider flag::set(#"hash_79f73bc0bf703a5d");
    }
    self get_out(ai_rider, n_index);
    self disable(n_index);
}

// Namespace turret/turret_shared
// Params 4, eflags: 0x0
// Checksum 0xba442bb5, Offset: 0x24a8
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
// Checksum 0x13463e37, Offset: 0x2608
// Size: 0x30c
function function_aecc6bed(var_502298b8, n_shots, n_index = 0, var_c3e16ce = undefined, var_702f0a7e = undefined) {
    assert(isarray(var_502298b8), "<dev string:x14b>");
    assert(n_shots > 0, "<dev string:x180>");
    var_17b7891d = "1146ee46da977605" + _index(n_index);
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
        for (shots = 0; shots < n_shots; shots++) {
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
// Checksum 0xa1241c6, Offset: 0x2920
// Size: 0x204
function function_d1ba6eb6(v_start, v_end, n_index = 0) {
    assert(isdefined(v_start) && isdefined(v_end), "<dev string:x1b8>");
    var_17b7891d = "38e250c05bd13c11" + _index(n_index);
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
// Params 4, eflags: 0x4
// Checksum 0x6db6d66c, Offset: 0x2b30
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
    var_17b7891d = "254e682350098752" + _index(n_index);
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
// Params 1, eflags: 0x4
// Checksum 0x90d93b62, Offset: 0x2ec0
// Size: 0x32
function private function_a8d258ca(n_index) {
    if (!isdefined(n_index) || n_index == 0) {
        return "turret_on_target";
    }
    return "gunner_turret_on_target";
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0x3da7b84c, Offset: 0x2f00
// Size: 0x6a
function function_259e1449(n_index) {
    wait isdefined(self.waittill_turret_on_target_delay) ? self.waittill_turret_on_target_delay : float(function_60d95f53()) / 1000;
    self waittill(function_a8d258ca(n_index));
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0x158545d0, Offset: 0x2f78
// Size: 0x52
function function_38841344(e_target, n_index) {
    do {
        function_259e1449(n_index);
    } while (isdefined(e_target) && !can_hit_target(e_target, n_index));
}

// Namespace turret/turret_shared
// Params 3, eflags: 0x0
// Checksum 0x5766388, Offset: 0x2fd8
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
// Checksum 0xb1304c38, Offset: 0x30b8
// Size: 0x2a
function enable_auto_use(b_enable = 1) {
    self.script_auto_use = b_enable;
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0x24c3f5a5, Offset: 0x30f0
// Size: 0x42
function disable_ai_getoff(n_index, b_disable = 1) {
    _get_turret_data(n_index).disable_ai_getoff = b_disable;
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0x79c76998, Offset: 0x3140
// Size: 0xe8
function disable(n_index) {
    if (is_turret_enabled(n_index)) {
        s_turret = _get_turret_data(n_index);
        s_turret.is_enabled = 0;
        s_turret.var_aa100948 = 0;
        function_14223170(n_index);
        clear_target(n_index);
        unpause(n_index);
        self turretsettargetangles(n_index, (0, 0, 0));
        self notify("turret_disabled" + _index(n_index));
    }
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0x3665034c, Offset: 0x3230
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
// Params 1, eflags: 0x0
// Checksum 0xac9828e4, Offset: 0x32f0
// Size: 0x58
function unpause(n_index) {
    s_turret = _get_turret_data(n_index);
    s_turret.pause = undefined;
    self notify("_turret_unpaused" + _index(n_index));
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0x662b36bb, Offset: 0x3350
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
// Params 2, eflags: 0x0
// Checksum 0x8905b065, Offset: 0x34a0
// Size: 0x50e
function _turret_think(n_index, v_offset) {
    turret_think_time = max(1.5, get_weapon(n_index).firetime);
    no_target_start_time = 0;
    self endon(#"death", "turret_disabled" + _index(n_index));
    var_17b7891d = "7e466bf1647f7499" + _index(n_index);
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
        if (is_true(s_turret.var_73446dab)) {
            self thread function_1358b930(n_index);
        }
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
// Params 1, eflags: 0x0
// Checksum 0x4bfa3cb5, Offset: 0x39b8
// Size: 0x54
function _turret_health_monitor(n_index) {
    self endon(#"death");
    waitframe(1);
    _turret_health_monitor_loop(n_index);
    self disable(n_index);
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0x60427c1f, Offset: 0x3a18
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
// Params 1, eflags: 0x0
// Checksum 0xbf94092c, Offset: 0x3aa8
// Size: 0x3cc
function function_1358b930(n_index) {
    self endon(#"death", "turret_disabled" + _index(n_index), "_turret_think" + _index(n_index), #"exit_vehicle");
    var_17b7891d = "41b81c1564e10447" + _index(n_index);
    self notify(var_17b7891d);
    self endon(var_17b7891d);
    ai_user = self get_user(n_index);
    if (!isdefined(ai_user)) {
        return;
    }
    /#
        if (getdvarint(#"hash_47a40f04e7c48117", 0)) {
            return;
        }
    #/
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
                if (abs(ai_user.origin[2] - player.origin[2]) <= 60 && distance2dsquared(ai_user.origin, player.origin) <= sqr(300)) {
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
// Checksum 0xb2ec751, Offset: 0x3e80
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
// Checksum 0x9b5e1998, Offset: 0x3f98
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
// Params 1, eflags: 0x0
// Checksum 0x15f6b3b8, Offset: 0x4078
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
// Params 2, eflags: 0x0
// Checksum 0x9ff3e2b0, Offset: 0x4138
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
// Checksum 0xc2b6b6c6, Offset: 0x4270
// Size: 0x2c
function does_have_target(n_index) {
    return isdefined(_get_turret_data(n_index).e_next_target);
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0x2731575b, Offset: 0x42a8
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
// Params 1, eflags: 0x0
// Checksum 0x4072548b, Offset: 0x4328
// Size: 0x1f8
function function_2a4a311(n_index) {
    var_17b7891d = "62a040c689f8351a" + _index(n_index);
    self notify(var_17b7891d);
    self endon(var_17b7891d);
    self endon(#"death");
    s_turret = _get_turret_data(n_index);
    if (!isdefined(s_turret.node)) {
        return;
    }
    var_f449d788 = sqr(s_turret.var_43ce86ed);
    while (true) {
        s_notify = self waittill(#"hash_4ecf2bd2fb1d75d9");
        ai_actor = s_notify.entity;
        if (isalive(ai_actor) && !ai_actor flag::get(#"turret_pilot")) {
            if (ai_actor.isarriving) {
                while (isalive(ai_actor) && ai_actor.isarriving) {
                    waitframe(1);
                }
                get_in(ai_actor, n_index);
                continue;
            }
            if (distance2dsquared(ai_actor.origin, s_turret.node.origin) <= var_f449d788) {
                if (isdefined(ai_actor.var_41adb97) && gettime() < ai_actor.var_41adb97) {
                    continue;
                }
                get_in(ai_actor, n_index);
            }
        }
    }
}

/#

    // Namespace turret/turret_shared
    // Params 1, eflags: 0x0
    // Checksum 0xc8e15143, Offset: 0x4528
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
// Params 1, eflags: 0x0
// Checksum 0x7977f77e, Offset: 0x4c10
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
// Checksum 0x2979c41e, Offset: 0x4cc0
// Size: 0x34
function has_turret(n_index) {
    if (isdefined(self.a_turrets) && isdefined(self.a_turrets[n_index])) {
        return true;
    }
    return false;
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0x537b5879, Offset: 0x4d00
// Size: 0x8e
function _update_turret_arcs(n_index) {
    s_turret = _get_turret_data(n_index);
    s_turret.rightarc = s_turret.w_weapon.rightarc;
    s_turret.leftarc = s_turret.w_weapon.leftarc;
    s_turret.toparc = s_turret.w_weapon.toparc;
    s_turret.bottomarc = s_turret.w_weapon.bottomarc;
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0xfa886584, Offset: 0x4d98
// Size: 0x2d0
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
    s_turret.var_73446dab = 1;
    s_turret.var_cd8600bd = 0;
    s_turret.var_30e97b22 = 0;
    s_turret.var_d55528ca = 0;
    s_turret.var_7394b9dc = 0;
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
    s_turret.var_43ce86ed = 36;
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
// Params 1, eflags: 0x0
// Checksum 0xd6cc81d8, Offset: 0x5070
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
// Params 1, eflags: 0x0
// Checksum 0xfa168828, Offset: 0x5298
// Size: 0x5a
function function_14223170(n_index = 0) {
    s_turret = _get_turret_data(n_index);
    s_turret.n_burst_time = 0;
    s_turret.n_burst_fire_time = 0;
    s_turret.n_burst_wait = 0;
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0x686d9a9, Offset: 0x5300
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
// Params 1, eflags: 0x0
// Checksum 0xfe095f03, Offset: 0x54d0
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
// Params 1, eflags: 0x0
// Checksum 0x31f79ca, Offset: 0x55c0
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
// Params 1, eflags: 0x0
// Checksum 0xe47467b4, Offset: 0x56b0
// Size: 0x2a
function _index(n_index) {
    return isdefined(n_index) ? "" + n_index : "";
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0x66db5e38, Offset: 0x56e8
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
// Params 2, eflags: 0x0
// Checksum 0xdf66644, Offset: 0x58c0
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
// Params 3, eflags: 0x0
// Checksum 0x3b54e49, Offset: 0x5a78
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
// Checksum 0xace3edc8, Offset: 0x5d10
// Size: 0x42
function function_3a7e640f(b_ignore, n_index) {
    s_turret = _get_turret_data(n_index);
    s_turret.var_7394b9dc = b_ignore;
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0xb38b6938, Offset: 0x5d60
// Size: 0x42
function set_ignore_line_of_sight(b_ignore, n_index) {
    s_turret = _get_turret_data(n_index);
    s_turret.b_ignore_line_of_sight = b_ignore;
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0xb96f5862, Offset: 0x5db0
// Size: 0x42
function function_8bbe7822(b_ignore, n_index) {
    s_turret = _get_turret_data(n_index);
    s_turret.var_2890139c = b_ignore;
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0x71ac106, Offset: 0x5e00
// Size: 0x42
function function_bb42e3e2(var_7994b8bf, n_index) {
    s_turret = _get_turret_data(n_index);
    s_turret.var_30e97b22 = var_7994b8bf;
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0x4b63a151, Offset: 0x5e50
// Size: 0x42
function function_f5e3e1de(b_enabled, n_index) {
    s_turret = _get_turret_data(n_index);
    s_turret.var_cd8600bd = b_enabled;
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0x1bb69952, Offset: 0x5ea0
// Size: 0x42
function function_69546b4e(b_allow, n_index) {
    s_turret = _get_turret_data(n_index);
    s_turret.var_73446dab = b_allow;
}

// Namespace turret/turret_shared
// Params 2, eflags: 0x0
// Checksum 0x5643fd9, Offset: 0x5ef0
// Size: 0x42
function set_occupy_no_target_time(time, n_index) {
    s_turret = _get_turret_data(n_index);
    s_turret.occupy_no_target_time = time;
}

// Namespace turret/turret_shared
// Params 1, eflags: 0x0
// Checksum 0x581fbb02, Offset: 0x5f40
// Size: 0x2c
function toggle_lensflare(bool) {
    self clientfield::set("toggle_lensflare", bool);
}

// Namespace turret/turret_shared
// Params 0, eflags: 0x0
// Checksum 0x4ae81e71, Offset: 0x5f78
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
// Checksum 0x9c9f540a, Offset: 0x60e0
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

