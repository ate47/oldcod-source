#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai\systems\shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;

#namespace ai;

// Namespace ai/ai_shared
// Params 1, eflags: 0x0
// Checksum 0xf8159e7d, Offset: 0x3b0
// Size: 0x4a
function set_pacifist(val) {
    assert(issentient(self), "<dev string:x38>");
    self.pacifist = val;
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x0
// Checksum 0x373b8722, Offset: 0x408
// Size: 0x3e
function disable_pain() {
    assert(isai(self), "<dev string:x58>");
    self.allowpain = 0;
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x0
// Checksum 0x7854e2b5, Offset: 0x450
// Size: 0x42
function enable_pain() {
    assert(isai(self), "<dev string:x7d>");
    self.allowpain = 1;
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x0
// Checksum 0x80d84c8b, Offset: 0x4a0
// Size: 0x3a
function gun_remove() {
    self shared::placeweaponon(self.weapon, "none");
    self.gun_removed = 1;
}

// Namespace ai/ai_shared
// Params 2, eflags: 0x0
// Checksum 0xa667f06b, Offset: 0x4e8
// Size: 0x2c
function gun_switchto(weapon, whichhand) {
    self shared::placeweaponon(weapon, whichhand);
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x0
// Checksum 0xe7551c7f, Offset: 0x520
// Size: 0x36
function gun_recall() {
    self shared::placeweaponon(self.primaryweapon, "right");
    self.gun_removed = undefined;
}

// Namespace ai/ai_shared
// Params 2, eflags: 0x0
// Checksum 0xe9ab4162, Offset: 0x560
// Size: 0x4c
function set_behavior_attribute(attribute, value) {
    if (has_behavior_attribute(attribute)) {
        setaiattribute(self, attribute, value);
    }
}

// Namespace ai/ai_shared
// Params 1, eflags: 0x0
// Checksum 0x7bdb47a9, Offset: 0x5b8
// Size: 0x22
function get_behavior_attribute(attribute) {
    return getaiattribute(self, attribute);
}

// Namespace ai/ai_shared
// Params 1, eflags: 0x0
// Checksum 0x1c474962, Offset: 0x5e8
// Size: 0x22
function has_behavior_attribute(attribute) {
    return hasaiattribute(self, attribute);
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x0
// Checksum 0x5016c378, Offset: 0x618
// Size: 0x48
function is_dead_sentient() {
    if (issentient(self) && !isalive(self)) {
        return 1;
    }
    return 0;
}

// Namespace ai/ai_shared
// Params 3, eflags: 0x0
// Checksum 0xc6c3ee67, Offset: 0x668
// Size: 0x1d0
function waittill_dead(guys, num, timeoutlength) {
    allalive = 1;
    for (i = 0; i < guys.size; i++) {
        if (isalive(guys[i])) {
            continue;
        }
        allalive = 0;
        break;
    }
    assert(allalive, "<dev string:xa1>");
    if (!allalive) {
        newarray = [];
        for (i = 0; i < guys.size; i++) {
            if (isalive(guys[i])) {
                newarray[newarray.size] = guys[i];
            }
        }
        guys = newarray;
    }
    ent = spawnstruct();
    if (isdefined(timeoutlength)) {
        ent endon(#"thread_timed_out");
        ent thread waittill_dead_timeout(timeoutlength);
    }
    ent.count = guys.size;
    if (isdefined(num) && num < ent.count) {
        ent.count = num;
    }
    array::thread_all(guys, &waittill_dead_thread, ent);
    while (ent.count > 0) {
        ent waittill(#"waittill_dead guy died");
    }
}

// Namespace ai/ai_shared
// Params 3, eflags: 0x0
// Checksum 0xcb0fabc3, Offset: 0x840
// Size: 0x158
function waittill_dead_or_dying(guys, num, timeoutlength) {
    newarray = [];
    for (i = 0; i < guys.size; i++) {
        if (isalive(guys[i])) {
            newarray[newarray.size] = guys[i];
        }
    }
    guys = newarray;
    ent = spawnstruct();
    if (isdefined(timeoutlength)) {
        ent endon(#"thread_timed_out");
        ent thread waittill_dead_timeout(timeoutlength);
    }
    ent.count = guys.size;
    if (isdefined(num) && num < ent.count) {
        ent.count = num;
    }
    array::thread_all(guys, &waittill_dead_or_dying_thread, ent);
    while (ent.count > 0) {
        ent waittill(#"waittill_dead_guy_dead_or_dying");
    }
}

// Namespace ai/ai_shared
// Params 1, eflags: 0x4
// Checksum 0x6c53d852, Offset: 0x9a0
// Size: 0x40
function private waittill_dead_thread(ent) {
    self waittill(#"death");
    ent.count--;
    ent notify(#"waittill_dead guy died");
}

// Namespace ai/ai_shared
// Params 1, eflags: 0x0
// Checksum 0x6d02354, Offset: 0x9e8
// Size: 0x50
function waittill_dead_or_dying_thread(ent) {
    self waittill(#"death", #"pain_death");
    ent.count--;
    ent notify(#"waittill_dead_guy_dead_or_dying");
}

// Namespace ai/ai_shared
// Params 1, eflags: 0x0
// Checksum 0xab2708d2, Offset: 0xa40
// Size: 0x26
function waittill_dead_timeout(timeoutlength) {
    wait timeoutlength;
    self notify(#"thread_timed_out");
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x4
// Checksum 0x95ce46c, Offset: 0xa70
// Size: 0x8e
function private wait_for_shoot() {
    self endon(#"stop_shoot_at_target", #"death");
    if (isvehicle(self) || isbot(self)) {
        self waittill(#"weapon_fired");
    } else {
        self waittill(#"shoot");
    }
    self.start_duration_comp = 1;
}

// Namespace ai/ai_shared
// Params 6, eflags: 0x0
// Checksum 0x20129ac5, Offset: 0xb08
// Size: 0x404
function shoot_at_target(mode, target, tag, duration, sethealth, ignorefirstshotwait) {
    self endon(#"death", #"stop_shoot_at_target");
    assert(isdefined(target), "<dev string:xff>");
    assert(isdefined(mode), "<dev string:x131>");
    mode_flag = mode === "normal" || mode === "shoot_until_target_dead" || mode === "kill_within_time";
    assert(mode_flag, "<dev string:x16d>");
    if (isdefined(duration)) {
        assert(duration >= 0, "<dev string:x1c9>");
    } else {
        duration = 0;
    }
    if (isdefined(sethealth) && isdefined(target)) {
        target.health = sethealth;
    }
    if (!isdefined(target) || mode === "shoot_until_target_dead" && target.health <= 0) {
        return;
    }
    if (isdefined(self.var_728f218b)) {
        if (!self [[ self.var_728f218b ]]()) {
            return;
        }
    }
    if (isdefined(tag) && tag != "") {
        self setentitytarget(target, 1, tag);
    } else {
        self setentitytarget(target, 1);
    }
    self.start_duration_comp = 0;
    switch (mode) {
    case #"normal":
        break;
    case #"shoot_until_target_dead":
        duration = -1;
        break;
    case #"kill_within_time":
        target damagemode("next_shot_kills");
        break;
    }
    if (isvehicle(self)) {
        self util::clearallcooldowns();
    }
    if (ignorefirstshotwait === 1) {
        self.start_duration_comp = 1;
    } else {
        self thread wait_for_shoot();
    }
    if (isdefined(duration) && isdefined(target) && target.health > 0) {
        if (duration >= 0) {
            elapsed = 0;
            while (isdefined(target) && target.health > 0 && elapsed <= duration) {
                elapsed += 0.05;
                if (!is_true(self.start_duration_comp)) {
                    elapsed = 0;
                }
                waitframe(1);
            }
            if (isdefined(target) && mode == "kill_within_time") {
                self.perfectaim = 1;
                self.aim_set_by_shoot_at_target = 1;
                target waittill(#"death");
            }
        } else if (duration == -1) {
            target waittill(#"death");
        }
    }
    stop_shoot_at_target();
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x0
// Checksum 0x6a20c000, Offset: 0xf18
// Size: 0x7e
function stop_shoot_at_target() {
    self clearentitytarget();
    if (isdefined(self.var_e892f39b)) {
        self [[ self.var_e892f39b ]]();
    }
    if (is_true(self.aim_set_by_shoot_at_target)) {
        self.perfectaim = 0;
        self.aim_set_by_shoot_at_target = 0;
    }
    self notify(#"stop_shoot_at_target");
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x0
// Checksum 0x1fb4284b, Offset: 0xfa0
// Size: 0x2c
function wait_until_done_speaking() {
    self endon(#"death");
    while (self.isspeaking) {
        waitframe(1);
    }
}

// Namespace ai/ai_shared
// Params 1, eflags: 0x0
// Checksum 0xd9a04d63, Offset: 0xfd8
// Size: 0x48a
function function_620eeb6b(goalent) {
    if (is_true(self.var_8f561628)) {
        self.var_2925fedc = undefined;
    }
    if (isdefined(goalent) && !isvec(goalent) && isdefined(goalent.script_likelyenemy)) {
        linkedstructs = struct::get_array(goalent.script_likelyenemy, "script_likelyenemy");
        targetent = undefined;
        var_b266f03e = "";
        if (self.team == #"allies") {
            var_b266f03e = "ai_likelyenemydir_allies";
        } else if (self.team == #"axis") {
            var_b266f03e = "ai_likelyenemydir_axis";
        }
        foreach (struct in linkedstructs) {
            if (struct.variantname === var_b266f03e) {
                if (isdefined(targetent)) {
                    assertmsg("<dev string:x1fb>" + var_b266f03e + "<dev string:x242>");
                }
                if (goalent == struct) {
                    assertmsg("<dev string:x252>");
                }
                targetent = struct;
            }
        }
        foreach (struct in linkedstructs) {
            if (struct.variantname === "ai_likelyenemydir") {
                if (isdefined(targetent)) {
                    assertmsg("<dev string:x2a2>");
                }
                if (goalent == struct) {
                    assertmsg("<dev string:x252>");
                }
                targetent = struct;
            }
        }
        if (!isdefined(targetent)) {
            linkedents = getentarray(goalent.script_likelyenemy, "script_likelyenemy");
            linkednodes = getnodearray(goalent.script_likelyenemy, "script_likelyenemy");
            var_d1535971 = arraycombine(arraycombine(linkedents, linkednodes), linkedstructs);
            var_2188535d = array::exclude(var_d1535971, goalent);
            if (var_2188535d.size == 1) {
                targetent = var_2188535d[0];
            } else {
                var_215ed720 = "";
                foreach (target in var_2188535d) {
                    var_215ed720 += " " + target.origin;
                }
                assertmsg("<dev string:x304>" + var_215ed720);
            }
        }
        if (!isdefined(targetent)) {
            assertmsg("<dev string:x3a9>");
        }
        self.var_2925fedc = targetent.origin;
        self.var_8f561628 = 1;
    }
}

// Namespace ai/ai_shared
// Params 1, eflags: 0x0
// Checksum 0x6724e035, Offset: 0x1470
// Size: 0x56
function function_54115a91(goal) {
    self function_620eeb6b(goal);
    if (isdefined(goal) && ispathnode(goal)) {
        self.var_11b1735a = 1;
    }
}

// Namespace ai/ai_shared
// Params 1, eflags: 0x0
// Checksum 0xc4d5c16f, Offset: 0x14d0
// Size: 0x3c
function set_goal_node(node) {
    self setgoal(node);
    self function_54115a91(node);
}

// Namespace ai/ai_shared
// Params 1, eflags: 0x0
// Checksum 0xcafaf00f, Offset: 0x1518
// Size: 0x3c
function set_goal_ent(ent) {
    self setgoal(ent);
    self function_54115a91(ent);
}

// Namespace ai/ai_shared
// Params 3, eflags: 0x0
// Checksum 0xf53d577f, Offset: 0x1560
// Size: 0x130
function set_goal(value, key = "targetname", b_force = 0) {
    goal = getnode(value, key);
    if (isdefined(goal)) {
        self setgoal(goal, b_force);
    } else {
        goal = getent(value, key);
        if (isdefined(goal)) {
            self setgoal(goal, b_force);
        } else {
            goal = struct::get(value, key);
            if (isdefined(goal)) {
                self setgoal(goal.origin, b_force);
            }
        }
    }
    self function_54115a91(goal);
    return goal;
}

// Namespace ai/ai_shared
// Params 5, eflags: 0x0
// Checksum 0x4e02e739, Offset: 0x1698
// Size: 0xc4
function force_goal(goto, b_shoot = 1, str_end_on, b_keep_colors = 0, b_should_sprint = 0) {
    self endon(#"death");
    s_tracker = spawnstruct();
    self thread _force_goal(s_tracker, goto, b_shoot, str_end_on, b_keep_colors, b_should_sprint);
    s_tracker waittill(#"done");
}

// Namespace ai/ai_shared
// Params 6, eflags: 0x0
// Checksum 0x53a715d6, Offset: 0x1768
// Size: 0x4e8
function _force_goal(s_tracker, goto, b_shoot = 1, str_end_on, b_keep_colors = 0, b_should_sprint = 0) {
    self endon(#"death");
    self notify(#"new_force_goal");
    flag::wait_till_clear("force_goal");
    flag::set(#"force_goal");
    color_enabled = 0;
    if (!b_keep_colors) {
        if (isdefined(colors::get_force_color())) {
            color_enabled = 1;
            self colors::disable();
        }
    }
    allowpain = self.allowpain;
    ignoresuppression = self.ignoresuppression;
    grenadeawareness = self.grenadeawareness;
    if (!b_shoot) {
        self val::set(#"ai_forcegoal", "ignoreall", 1);
    } else if (self has_behavior_attribute("move_mode")) {
        var_a5151bf = self get_behavior_attribute("move_mode");
        self set_behavior_attribute("move_mode", "rambo");
    }
    if (b_should_sprint && self has_behavior_attribute("sprint")) {
        self set_behavior_attribute("sprint", 1);
    }
    self.ignoresuppression = 1;
    self.grenadeawareness = 0;
    self val::set(#"ai_forcegoal", "ignoreme", 1);
    self disable_pain();
    if (!isplayer(self)) {
        self val::set(#"ai_forcegoal", "push_player", 1);
    }
    if (isdefined(goto)) {
        self setgoal(goto, 1);
    }
    self function_54115a91(goto);
    self waittill(#"goal", #"new_force_goal", str_end_on);
    if (color_enabled) {
        colors::enable();
    }
    if (!isplayer(self)) {
        self val::reset(#"ai_forcegoal", "push_player");
    }
    self clearforcedgoal();
    self val::reset(#"ai_forcegoal", "ignoreme");
    self val::reset(#"ai_forcegoal", "ignoreall");
    if (is_true(allowpain)) {
        self enable_pain();
    }
    if (self has_behavior_attribute("sprint")) {
        self set_behavior_attribute("sprint", 0);
    }
    if (isdefined(var_a5151bf)) {
        self set_behavior_attribute("move_mode", var_a5151bf);
    }
    self.ignoresuppression = ignoresuppression;
    self.grenadeawareness = grenadeawareness;
    flag::clear(#"force_goal");
    s_tracker notify(#"done");
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x0
// Checksum 0x364f7d7, Offset: 0x1c58
// Size: 0x16
function stoppainwaitinterval() {
    self notify(#"painwaitintervalremove");
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x4
// Checksum 0x9a9336b2, Offset: 0x1c78
// Size: 0x46
function private _allowpainrestore() {
    self endon(#"death");
    self waittill(#"painwaitintervalremove", #"painwaitinterval");
    self.allowpain = 1;
}

// Namespace ai/ai_shared
// Params 1, eflags: 0x0
// Checksum 0xb48e13b8, Offset: 0x1cc8
// Size: 0xf6
function painwaitinterval(msec) {
    self endon(#"death");
    self notify(#"painwaitinterval");
    self endon(#"painwaitinterval", #"painwaitintervalremove");
    self thread _allowpainrestore();
    if (!isdefined(msec) || msec < 20) {
        msec = 20;
    }
    while (isalive(self)) {
        self waittill(#"pain");
        self.allowpain = 0;
        wait float(msec) / 1000;
        self.allowpain = 1;
    }
}

// Namespace ai/ai_shared
// Params 2, eflags: 0x0
// Checksum 0xd5aeccfa, Offset: 0x1dc8
// Size: 0x29c
function bloody_death(n_delay, hit_loc) {
    if (!isdefined(self)) {
        return;
    }
    self endon(#"death");
    if (isdefined(n_delay)) {
        wait n_delay;
    }
    if (!isalive(self)) {
        return;
    }
    if (isdefined(hit_loc)) {
        assert(isinarray(array("<dev string:x438>", "<dev string:x442>", "<dev string:x44a>", "<dev string:x452>", "<dev string:x461>", "<dev string:x46e>", "<dev string:x47d>", "<dev string:x490>", "<dev string:x4a2>", "<dev string:x4b5>", "<dev string:x4c7>", "<dev string:x4d5>", "<dev string:x4e2>", "<dev string:x4f5>", "<dev string:x507>", "<dev string:x51a>", "<dev string:x52c>", "<dev string:x53a>", "<dev string:x547>", "<dev string:x54e>"), hit_loc), "<dev string:x55c>");
    } else {
        hit_loc = array::random(array("helmet", "head", "neck", "torso_upper", "torso_mid", "torso_lower", "right_arm_upper", "left_arm_upper", "right_arm_lower", "left_arm_lower", "right_hand", "left_hand", "right_leg_upper", "left_leg_upper", "right_leg_lower", "left_leg_lower", "right_foot", "left_foot", "gun", "riotshield"));
    }
    if (is_true(self.var_4b5540a0)) {
        self delete();
        return;
    }
    util::stop_magic_bullet_shield(self);
    self dodamage(self.health + 100, self.origin, undefined, undefined, hit_loc);
    self kill();
}

// Namespace ai/ai_shared
// Params 1, eflags: 0x0
// Checksum 0x2934ed3d, Offset: 0x2070
// Size: 0x4a
function shouldregisterclientfieldforarchetype(archetype) {
    if (is_true(level.clientfieldaicheck) && !isarchetypeloaded(archetype)) {
        return false;
    }
    return true;
}

// Namespace ai/ai_shared
// Params 1, eflags: 0x0
// Checksum 0xf1c5b888, Offset: 0x20c8
// Size: 0xcc
function set_protect_ent(entity) {
    if (!isdefined(entity.protect_tactical_influencer) && sessionmodeiscampaigngame()) {
        teammask = util::getteammask(self.team);
        entity.protect_tactical_influencer = createtacticalinfluencer("protect_entity_influencer_def", entity, teammask);
    }
    self.protectent = entity;
    if (isactor(self)) {
        self setblackboardattribute("_defend", "defend_enabled");
    }
}

// Namespace ai/ai_shared
// Params 2, eflags: 0x0
// Checksum 0x54af86d6, Offset: 0x21a0
// Size: 0x10c
function set_group_protect_ent(e_ent_to_protect, defend_volume_name_or_ent) {
    a_defenders = self;
    if (!isdefined(a_defenders)) {
        a_defenders = [];
    } else if (!isarray(a_defenders)) {
        a_defenders = array(a_defenders);
    }
    if (isstring(defend_volume_name_or_ent)) {
        vol_defend = getent(defend_volume_name_or_ent, "targetname");
    } else if (isentity(defend_volume_name_or_ent)) {
        vol_defend = defend_volume_name_or_ent;
    }
    array::run_all(a_defenders, &setgoal, vol_defend, 1);
    array::thread_all(a_defenders, &set_protect_ent, e_ent_to_protect);
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x0
// Checksum 0xfeb503b3, Offset: 0x22b8
// Size: 0x4c
function remove_protect_ent() {
    self.protectent = undefined;
    if (isactor(self)) {
        self setblackboardattribute("_defend", "defend_disabled");
    }
}

// Namespace ai/ai_shared
// Params 3, eflags: 0x0
// Checksum 0x653fdb1, Offset: 0x2310
// Size: 0x86
function t_cylinder(origin, radius, halfheight) {
    struct = spawnstruct();
    struct.type = 1;
    struct.origin = origin;
    struct.radius = float(radius);
    struct.halfheight = float(halfheight);
    return struct;
}

// Namespace ai/ai_shared
// Params 3, eflags: 0x0
// Checksum 0xc1423166, Offset: 0x23a0
// Size: 0xe2
function function_470c0597(center, halfsize, angles) {
    assert(isvec(center));
    assert(isvec(halfsize));
    assert(isvec(angles));
    struct = spawnstruct();
    struct.type = 2;
    struct.center = center;
    struct.halfsize = halfsize;
    struct.angles = angles;
    return struct;
}

// Namespace ai/ai_shared
// Params 3, eflags: 0x0
// Checksum 0x6dd841b3, Offset: 0x2490
// Size: 0x274
function function_1628d95b(cansee = 0, var_9a21f98d = 1, overrideorigin = self.origin) {
    var_56203bf4 = function_4d8c71ce(util::get_enemy_team(self.team), #"team3");
    nearesttarget = undefined;
    var_46e1d165 = undefined;
    foreach (target in var_56203bf4) {
        if (!isalive(target) || is_true(target.var_becd4d91) || target function_41b04632()) {
            continue;
        }
        if (cansee && var_9a21f98d) {
            if (!self cansee(target)) {
                continue;
            }
        } else if (cansee && !var_9a21f98d) {
            targetpoint = isdefined(target.var_88f8feeb) ? target.var_88f8feeb : target getcentroid();
            if (!sighttracepassed(self geteye(), targetpoint, 0, target)) {
                continue;
            }
        }
        distsq = distancesquared(overrideorigin, target.origin);
        if (!isdefined(nearesttarget) || distsq < var_46e1d165) {
            nearesttarget = target;
            var_46e1d165 = distsq;
        }
    }
    return nearesttarget;
}

// Namespace ai/ai_shared
// Params 1, eflags: 0x0
// Checksum 0x3632be62, Offset: 0x2710
// Size: 0x32
function function_31a31a25(var_9a21f98d = 1) {
    return function_1628d95b(1, var_9a21f98d);
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x0
// Checksum 0x65e6cde7, Offset: 0x2750
// Size: 0x48
function function_41b04632() {
    return isdefined(self.targetname) && self.targetname == "destructible" && !isdefined(getent(self.target, "targetname"));
}

// Namespace ai/ai_shared
// Params 1, eflags: 0x0
// Checksum 0x7c2b2dbd, Offset: 0x27a0
// Size: 0x110
function function_63734291(enemy) {
    if (!isdefined(enemy)) {
        return false;
    }
    var_aba9ee4c = 1;
    if (isdefined(self.var_ffa507cd)) {
        var_e1ea86de = self.var_ffa507cd;
        if (var_e1ea86de < randomfloat(1)) {
            var_aba9ee4c = 0;
        }
    }
    if (var_aba9ee4c && isvehicle(enemy) && !is_true(enemy.var_c95dcb15)) {
        dist_squared = distancesquared(self.origin, enemy.origin);
        if (dist_squared >= 562500) {
            enemy notify(#"hash_4853a85e5ddc4a47");
            return true;
        }
    }
    return false;
}

// Namespace ai/ai_shared
// Params 1, eflags: 0x0
// Checksum 0x6619baed, Offset: 0x28b8
// Size: 0xde
function stun(duration = self.var_95d94ac4) {
    if (!isdefined(duration) || !is_true(self.var_28aab32a) || is_true(self.var_c2986b66) || is_true(self.var_b736fc8b)) {
        return;
    }
    end_time = gettime() + int(duration * 1000);
    if (isdefined(self.var_3d461e6f) && self.var_3d461e6f > end_time) {
        return;
    }
    self.var_3d461e6f = end_time;
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x0
// Checksum 0xd9fb3f07, Offset: 0x29a0
// Size: 0x1e
function is_stunned() {
    return isdefined(self.var_3d461e6f) && gettime() < self.var_3d461e6f;
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x0
// Checksum 0x6466847, Offset: 0x29c8
// Size: 0xe
function clear_stun() {
    self.var_3d461e6f = undefined;
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x0
// Checksum 0xda014dc, Offset: 0x29e0
// Size: 0x134
function function_9139c839() {
    if (!isdefined(self.var_76167463)) {
        if (isdefined(self.aisettingsbundle)) {
            settingsbundle = self.aisettingsbundle;
        } else if (isspawner(self) && isdefined(self.aitype)) {
            settingsbundle = function_edf479a3(self.aitype);
        } else if (isvehicle(self) && isdefined(self.scriptbundlesettings)) {
            settingsbundle = getscriptbundle(self.scriptbundlesettings).aisettingsbundle;
        }
        if (!isdefined(settingsbundle)) {
            return undefined;
        }
        self.var_76167463 = settingsbundle;
        if (!isdefined(level.var_e3a467cf)) {
            level.var_e3a467cf = [];
        }
        if (!isdefined(level.var_e3a467cf[self.var_76167463])) {
            level.var_e3a467cf[self.var_76167463] = getscriptbundle(self.var_76167463);
        }
    }
    return level.var_e3a467cf[self.var_76167463];
}

// Namespace ai/ai_shared
// Params 2, eflags: 0x0
// Checksum 0x7aca1a4d, Offset: 0x2b20
// Size: 0x9a
function function_71919555(var_45302432, fieldname) {
    if (!isdefined(level.var_e3a467cf)) {
        level.var_e3a467cf = [];
    }
    if (!isdefined(level.var_e3a467cf[var_45302432])) {
        level.var_e3a467cf[var_45302432] = getscriptbundle(var_45302432);
    }
    if (isdefined(level.var_e3a467cf[var_45302432])) {
        return level.var_e3a467cf[var_45302432].(fieldname);
    }
    return undefined;
}

// Namespace ai/ai_shared
// Params 1, eflags: 0x0
// Checksum 0x8f410616, Offset: 0x2bc8
// Size: 0x80
function function_fc7bd6c7(var_80292228) {
    if (is_true(var_80292228)) {
        if (isfunctionptr(self.var_9a22ab2b)) {
            self thread [[ self.var_9a22ab2b ]]();
        }
        return;
    }
    if (isfunctionptr(self.var_54aff8ae)) {
        self thread [[ self.var_54aff8ae ]]();
    }
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x0
// Checksum 0xf2614907, Offset: 0x2c50
// Size: 0x30
function function_f6060793() {
    if (isfunctionptr(self.var_b84eb531)) {
        self thread [[ self.var_b84eb531 ]]();
    }
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x0
// Checksum 0x553aac35, Offset: 0x2c88
// Size: 0x42
function enable_careful() {
    assert(isai(self), "<dev string:x5cc>");
    self.script_careful = 1;
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x0
// Checksum 0x5ebe3829, Offset: 0x2cd8
// Size: 0x4e
function disable_careful() {
    assert(isai(self), "<dev string:x609>");
    self.script_careful = 0;
    self notify(#"hash_365fd8fda5a5a322");
}

// Namespace ai/ai_shared
// Params 11, eflags: 0x0
// Checksum 0x1ec749d, Offset: 0x2d30
// Size: 0x340
function look_at(look_at, priority = 2, var_9e364106 = 1, duration = 0, var_152044ef, var_71e42546, var_a806de0b = 1, no_head = 0, var_3777d080 = 0, blend_time = 0.5, weight = 1) {
    assert(isai(self), "<dev string:x648>");
    assert(priority >= 0 && priority < 4, "<dev string:x687>");
    if (!isdefined(self.var_8a068c50)) {
        self.var_8a068c50 = function_191b31f3();
    }
    if (is_true(self.var_8a068c50[priority].set) && !var_9e364106) {
        return false;
    }
    function_e1c5902(var_9e364106);
    self.var_8a068c50[priority].object = look_at;
    self.var_8a068c50[priority].var_8fbcda45 = var_152044ef;
    self.var_8a068c50[priority].var_eba0d1fe = var_71e42546;
    self.var_8a068c50[priority].var_a806de0b = var_a806de0b;
    self.var_8a068c50[priority].no_head = no_head;
    self.var_8a068c50[priority].var_3777d080 = var_3777d080;
    self.var_8a068c50[priority].blend_time = blend_time;
    self.var_8a068c50[priority].weight = weight;
    if (isdefined(look_at)) {
        self.var_8a068c50[priority].set = 1;
    }
    if (duration > 0 && duration < 1) {
        self.var_8a068c50[priority].var_51bcf38d = 1;
    }
    self notify("look_at_" + string(priority) + "_updated");
    if (duration > 0) {
        self thread function_4760d8c0(priority, duration);
    }
    function_fcd4fcb7();
    return true;
}

// Namespace ai/ai_shared
// Params 2, eflags: 0x4
// Checksum 0xd3a11eb7, Offset: 0x3078
// Size: 0x8c
function private function_4760d8c0(priority, duration) {
    self notify("794afd593fb93377");
    self endon("794afd593fb93377");
    self endon("look_at_" + string(priority) + "_updated", #"death");
    wait duration;
    function_e1c5902(priority);
    function_fcd4fcb7();
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x4
// Checksum 0xb7275deb, Offset: 0x3110
// Size: 0x50
function private function_191b31f3() {
    prioritystack = [];
    for (stackindex = 0; stackindex < 4; stackindex++) {
        prioritystack[stackindex] = spawnstruct();
    }
    return prioritystack;
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x4
// Checksum 0x9a4009fa, Offset: 0x3168
// Size: 0x2ce
function private function_91692eaa() {
    var_f613552 = undefined;
    var_9fe69433 = 0;
    var_f5eb28fc = undefined;
    var_1aa9eee = undefined;
    var_a806de0b = undefined;
    no_head = undefined;
    var_3777d080 = undefined;
    blend_time = undefined;
    weight = undefined;
    for (stackindex = 0; stackindex < 4; stackindex++) {
        if (is_true(self.var_8a068c50[stackindex].set)) {
            var_f613552 = self.var_8a068c50[stackindex].object;
            var_9fe69433 = is_true(self.var_8a068c50[stackindex].var_51bcf38d);
            var_f5eb28fc = is_true(self.var_8a068c50[stackindex].var_8fbcda45);
            var_1aa9eee = is_true(self.var_8a068c50[stackindex].var_eba0d1fe);
            var_a806de0b = is_true(self.var_8a068c50[stackindex].var_a806de0b);
            no_head = is_true(self.var_8a068c50[stackindex].no_head);
            var_3777d080 = is_true(self.var_8a068c50[stackindex].var_3777d080);
            blend_time = self.var_8a068c50[stackindex].blend_time;
            weight = self.var_8a068c50[stackindex].weight;
            break;
        }
    }
    if (!isdefined(self.lookat)) {
        self.lookat = {};
    }
    self.lookat.object = var_f613552;
    self.lookat.var_51bcf38d = var_9fe69433;
    self.lookat.var_8fbcda45 = var_f5eb28fc;
    self.lookat.var_eba0d1fe = var_1aa9eee;
    self.lookat.var_a806de0b = var_a806de0b;
    self.lookat.no_head = no_head;
    self.lookat.var_3777d080 = var_3777d080;
    self.lookat.blend_time = blend_time;
    self.lookat.weight = weight;
}

// Namespace ai/ai_shared
// Params 1, eflags: 0x4
// Checksum 0xb821f9a2, Offset: 0x3440
// Size: 0xfa
function private function_e1c5902(priority) {
    self.var_8a068c50[priority].object = undefined;
    self.var_8a068c50[priority].set = undefined;
    self.var_8a068c50[priority].var_51bcf38d = undefined;
    self.var_8a068c50[priority].var_8fbcda45 = undefined;
    self.var_8a068c50[priority].var_eba0d1fe = undefined;
    self.var_8a068c50[priority].var_a806de0b = undefined;
    self.var_8a068c50[priority].no_head = undefined;
    self.var_8a068c50[priority].var_3777d080 = undefined;
    self.var_8a068c50[priority].blend_time = undefined;
    self.var_8a068c50[priority].weight = undefined;
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x0
// Checksum 0x1290d9ea, Offset: 0x3548
// Size: 0x74
function function_603b970a() {
    if (!isdefined(self.var_8a068c50)) {
        self.var_8a068c50 = function_191b31f3();
    }
    for (stackindex = 0; stackindex < 4; stackindex++) {
        function_e1c5902(stackindex);
    }
    function_fcd4fcb7();
}

// Namespace ai/ai_shared
// Params 1, eflags: 0x0
// Checksum 0xe90539b6, Offset: 0x35c8
// Size: 0x8c
function function_6b85d60d(priority) {
    if (!isdefined(self.var_8a068c50)) {
        self.var_8a068c50 = function_191b31f3();
    }
    assert(priority >= 0 && priority < 4, "<dev string:x6b0>");
    function_e1c5902(priority);
    function_fcd4fcb7();
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x0
// Checksum 0x5aeb4cbd, Offset: 0x3660
// Size: 0x76
function function_5e5653d3() {
    if (self isinscriptedstate() && !is_true(self._scene_object._s.var_db255011)) {
        return false;
    }
    if (self flag::get("scripted_lookat_disable")) {
        return false;
    }
    return true;
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x4
// Checksum 0xb7b550e8, Offset: 0x36e0
// Size: 0x35c
function private function_fcd4fcb7() {
    function_91692eaa();
    object = self.lookat.object;
    var_8fbcda45 = self.lookat.var_8fbcda45;
    var_eba0d1fe = self.lookat.var_eba0d1fe;
    var_a806de0b = self.lookat.var_a806de0b;
    no_head = self.lookat.no_head;
    var_3777d080 = self.lookat.var_3777d080;
    blend_time = self.lookat.blend_time;
    weight = self.lookat.weight;
    if (!function_5e5653d3()) {
        object = undefined;
    }
    if (isdefined(object)) {
        var_9d112229 = &lookatentity;
        var_77a9fe9e = &lookatpos;
        if (is_true(var_8fbcda45)) {
            var_9d112229 = &aimatentityik;
            if (is_true(var_eba0d1fe)) {
                var_77a9fe9e = &function_2031372a;
            } else {
                var_77a9fe9e = &aimatposik;
            }
            if (isentity(object)) {
                self [[ var_9d112229 ]](object, blend_time, weight);
            } else if (!isvec(object)) {
                self [[ var_77a9fe9e ]](object.origin, blend_time, weight);
            } else {
                self [[ var_77a9fe9e ]](object, blend_time, weight);
            }
        } else {
            if (is_true(var_eba0d1fe)) {
                var_77a9fe9e = &lookatangles;
            }
            if (isentity(object)) {
                self [[ var_9d112229 ]](object, var_a806de0b, no_head, var_3777d080, blend_time, weight);
            } else if (!isvec(object)) {
                self [[ var_77a9fe9e ]](object.origin, var_a806de0b, no_head, var_3777d080, blend_time, weight);
            } else {
                self [[ var_77a9fe9e ]](object, var_a806de0b, no_head, var_3777d080, blend_time, weight);
            }
        }
    } else {
        self lookatentity(undefined);
        self lookatpos(undefined);
    }
    /#
        self thread function_1571b7b6(object, is_true(self.lookat.var_51bcf38d));
    #/
}

/#

    // Namespace ai/ai_shared
    // Params 2, eflags: 0x4
    // Checksum 0x682d3a32, Offset: 0x3a48
    // Size: 0x1be
    function private function_1571b7b6(object, var_dfb8e94b) {
        self endon(#"death", #"entitydeleted");
        self notify("<dev string:x6db>");
        self endon("<dev string:x6db>");
        while (isdefined(object) && function_45ef77da()) {
            from = self geteye();
            to = object;
            if (!isvec(to) && issentient(to)) {
                to = to geteye();
            }
            looking = anglestoforward(self gettagangles("<dev string:x6ef>"));
            line(from, from + looking * 500, (0.75, 0.75, 0.75), 1, 0, 1);
            color = (1, 1, 0);
            if (is_true(var_dfb8e94b)) {
                color = (1, 1, 1);
            }
            line(from, to, color, 1, 0, 1);
            waitframe(1);
        }
    }

    // Namespace ai/ai_shared
    // Params 0, eflags: 0x0
    // Checksum 0x3a0629bc, Offset: 0x3c10
    // Size: 0x54
    function function_45ef77da() {
        dvar = getdvarstring(#"hash_4493b356ca38ab5e", "<dev string:x6fa>");
        return int(dvar);
    }

#/

// Namespace ai/ai_shared
// Params 2, eflags: 0x0
// Checksum 0xd55c1eac, Offset: 0x3c70
// Size: 0xf4
function function_fd90d41c(target, tag) {
    if (!isdefined(target)) {
        self lookatentity();
        if (isdefined(self.var_875e35a2)) {
            self.var_875e35a2 delete();
        }
        return;
    }
    if (!isdefined(self.var_875e35a2)) {
        self.var_875e35a2 = util::spawn_model("tag_origin");
    }
    assert(isdefined(self.var_875e35a2));
    self.var_875e35a2 linkto(target, tag, (0, 0, 0), (0, 0, 0));
    self lookatentity(self.var_875e35a2);
}

// Namespace ai/ai_shared
// Params 2, eflags: 0x0
// Checksum 0xe0b5799a, Offset: 0x3d70
// Size: 0xf4
function function_71915b43(target, tag) {
    if (!isdefined(target)) {
        self aimatentityik();
        if (isdefined(self.var_875e35a2)) {
            self.var_875e35a2 delete();
        }
        return;
    }
    if (!isdefined(self.var_875e35a2)) {
        self.var_875e35a2 = util::spawn_model("tag_origin");
    }
    assert(isdefined(self.var_875e35a2));
    self.var_875e35a2 linkto(target, tag, (0, 0, 0), (0, 0, 0));
    self aimatentityik(self.var_875e35a2);
}

// Namespace ai/ai_shared
// Params 3, eflags: 0x0
// Checksum 0xb9ba0695, Offset: 0x3e70
// Size: 0x60
function poi_enable(shouldenable, firstpoint, var_8fbcda45) {
    if (isfunctionptr(level.poi.fnenable)) {
        self thread [[ level.poi.fnenable ]](shouldenable, firstpoint, var_8fbcda45);
    }
}

// Namespace ai/ai_shared
// Params 6, eflags: 0x0
// Checksum 0x6dcbaed2, Offset: 0x3ed8
// Size: 0x80
function function_3a5e9945(shouldenable, yawmin, yawmax, pitchmin, pitchmax, var_8fbcda45) {
    if (isfunctionptr(level.poi.var_38974483)) {
        self thread [[ level.poi.var_38974483 ]](shouldenable, yawmin, yawmax, pitchmin, pitchmax, var_8fbcda45);
    }
}

