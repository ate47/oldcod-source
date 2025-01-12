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
// Checksum 0x726ffb6b, Offset: 0x3a8
// Size: 0x4a
function set_pacifist(val) {
    assert(issentient(self), "<dev string:x38>");
    self.pacifist = val;
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x7ae8a440, Offset: 0x400
// Size: 0x3e
function disable_pain() {
    assert(isai(self), "<dev string:x58>");
    self.allowpain = 0;
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x1 linked
// Checksum 0xed13d18f, Offset: 0x448
// Size: 0x42
function enable_pain() {
    assert(isai(self), "<dev string:x7d>");
    self.allowpain = 1;
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x3388b31d, Offset: 0x498
// Size: 0x3a
function gun_remove() {
    self shared::placeweaponon(self.weapon, "none");
    self.gun_removed = 1;
}

// Namespace ai/ai_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x5590406f, Offset: 0x4e0
// Size: 0x2c
function gun_switchto(weapon, whichhand) {
    self shared::placeweaponon(weapon, whichhand);
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x1 linked
// Checksum 0xd1091690, Offset: 0x518
// Size: 0x36
function gun_recall() {
    self shared::placeweaponon(self.primaryweapon, "right");
    self.gun_removed = undefined;
}

// Namespace ai/ai_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x497e8cc7, Offset: 0x558
// Size: 0x4c
function set_behavior_attribute(attribute, value) {
    if (has_behavior_attribute(attribute)) {
        setaiattribute(self, attribute, value);
    }
}

// Namespace ai/ai_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xd32f00f9, Offset: 0x5b0
// Size: 0x22
function get_behavior_attribute(attribute) {
    return getaiattribute(self, attribute);
}

// Namespace ai/ai_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xb93aecdb, Offset: 0x5e0
// Size: 0x22
function has_behavior_attribute(attribute) {
    return hasaiattribute(self, attribute);
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x2316fc3b, Offset: 0x610
// Size: 0x48
function is_dead_sentient() {
    if (issentient(self) && !isalive(self)) {
        return 1;
    }
    return 0;
}

// Namespace ai/ai_shared
// Params 3, eflags: 0x1 linked
// Checksum 0x44329d68, Offset: 0x660
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
// Checksum 0x9ca3c15a, Offset: 0x838
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
// Params 1, eflags: 0x5 linked
// Checksum 0xb4017a60, Offset: 0x998
// Size: 0x40
function private waittill_dead_thread(ent) {
    self waittill(#"death");
    ent.count--;
    ent notify(#"waittill_dead guy died");
}

// Namespace ai/ai_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xed02be92, Offset: 0x9e0
// Size: 0x50
function waittill_dead_or_dying_thread(ent) {
    self waittill(#"death", #"pain_death");
    ent.count--;
    ent notify(#"waittill_dead_guy_dead_or_dying");
}

// Namespace ai/ai_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xc44de0ea, Offset: 0xa38
// Size: 0x26
function waittill_dead_timeout(timeoutlength) {
    wait timeoutlength;
    self notify(#"thread_timed_out");
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x5 linked
// Checksum 0xe0b6cd9b, Offset: 0xa68
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
// Checksum 0xe67dc8c1, Offset: 0xb00
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
// Params 0, eflags: 0x1 linked
// Checksum 0x8fd63525, Offset: 0xf10
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
// Checksum 0x172efdbe, Offset: 0xf98
// Size: 0x2c
function wait_until_done_speaking() {
    self endon(#"death");
    while (self.isspeaking) {
        waitframe(1);
    }
}

// Namespace ai/ai_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xd0f56842, Offset: 0xfd0
// Size: 0x3c2
function function_620eeb6b(goalent) {
    if (is_true(self.var_8f561628)) {
        self.var_2925fedc = undefined;
    }
    if (isdefined(goalent) && !isvec(goalent) && isdefined(goalent.script_likelyenemy)) {
        var_4c719501 = struct::get_array(goalent.script_likelyenemy, "script_likelyenemy");
        targetent = undefined;
        var_b266f03e = "";
        if (self.team == #"allies") {
            var_b266f03e = "ai_likelyenemydir_allies";
        } else if (self.team == #"axis") {
            var_b266f03e = "ai_likelyenemydir_axis";
        }
        foreach (struct in var_4c719501) {
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
        foreach (struct in var_4c719501) {
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
            var_666dc042 = getnodearray(goalent.script_likelyenemy, "script_likelyenemy");
            var_d1535971 = arraycombine(arraycombine(linkedents, var_666dc042), var_4c719501);
            var_2188535d = array::exclude(var_d1535971, goalent);
            if (var_2188535d.size == 1) {
                targetent = var_2188535d[0];
            }
        }
        if (!isdefined(targetent)) {
            assertmsg("<dev string:x304>");
        }
        self.var_2925fedc = targetent.origin;
        self.var_8f561628 = 1;
    }
}

// Namespace ai/ai_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x1807db9f, Offset: 0x13a0
// Size: 0x56
function function_54115a91(goal) {
    self function_620eeb6b(goal);
    if (isdefined(goal) && ispathnode(goal)) {
        self.var_11b1735a = 1;
    }
}

// Namespace ai/ai_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x9ee05412, Offset: 0x1400
// Size: 0x3c
function set_goal_node(node) {
    self setgoal(node);
    self function_54115a91(node);
}

// Namespace ai/ai_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x6071cefe, Offset: 0x1448
// Size: 0x3c
function set_goal_ent(ent) {
    self setgoal(ent);
    self function_54115a91(ent);
}

// Namespace ai/ai_shared
// Params 3, eflags: 0x0
// Checksum 0xb2d6b67, Offset: 0x1490
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
// Params 5, eflags: 0x1 linked
// Checksum 0xcb49eb2e, Offset: 0x15c8
// Size: 0xc4
function force_goal(goto, b_shoot = 1, str_end_on, b_keep_colors = 0, b_should_sprint = 0) {
    self endon(#"death");
    s_tracker = spawnstruct();
    self thread _force_goal(s_tracker, goto, b_shoot, str_end_on, b_keep_colors, b_should_sprint);
    s_tracker waittill(#"done");
}

// Namespace ai/ai_shared
// Params 6, eflags: 0x1 linked
// Checksum 0x3a4bafcc, Offset: 0x1698
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
// Checksum 0xe15cdc4f, Offset: 0x1b88
// Size: 0x16
function stoppainwaitinterval() {
    self notify(#"painwaitintervalremove");
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x5 linked
// Checksum 0x81737e59, Offset: 0x1ba8
// Size: 0x46
function private _allowpainrestore() {
    self endon(#"death");
    self waittill(#"painwaitintervalremove", #"painwaitinterval");
    self.allowpain = 1;
}

// Namespace ai/ai_shared
// Params 1, eflags: 0x0
// Checksum 0xb6f73966, Offset: 0x1bf8
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
// Checksum 0x3031cf0, Offset: 0x1cf8
// Size: 0x254
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
        assert(isinarray(array("<dev string:x393>", "<dev string:x39d>", "<dev string:x3a5>", "<dev string:x3ad>", "<dev string:x3bc>", "<dev string:x3c9>", "<dev string:x3d8>", "<dev string:x3eb>", "<dev string:x3fd>", "<dev string:x410>", "<dev string:x422>", "<dev string:x430>", "<dev string:x43d>", "<dev string:x450>", "<dev string:x462>", "<dev string:x475>", "<dev string:x487>", "<dev string:x495>", "<dev string:x4a2>", "<dev string:x4a9>"), hit_loc), "<dev string:x4b7>");
    } else {
        hit_loc = array::random(array("helmet", "head", "neck", "torso_upper", "torso_mid", "torso_lower", "right_arm_upper", "left_arm_upper", "right_arm_lower", "left_arm_lower", "right_hand", "left_hand", "right_leg_upper", "left_leg_upper", "right_leg_lower", "left_leg_lower", "right_foot", "left_foot", "gun", "riotshield"));
    }
    self dodamage(self.health + 100, self.origin, undefined, undefined, hit_loc);
    self kill();
}

// Namespace ai/ai_shared
// Params 1, eflags: 0x0
// Checksum 0x82588e3, Offset: 0x1f58
// Size: 0x4a
function shouldregisterclientfieldforarchetype(archetype) {
    if (is_true(level.clientfieldaicheck) && !isarchetypeloaded(archetype)) {
        return false;
    }
    return true;
}

// Namespace ai/ai_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x75faf11f, Offset: 0x1fb0
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
// Checksum 0xec9c6633, Offset: 0x2088
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
// Checksum 0x8ca75c63, Offset: 0x21a0
// Size: 0x4c
function remove_protect_ent() {
    self.protectent = undefined;
    if (isactor(self)) {
        self setblackboardattribute("_defend", "defend_disabled");
    }
}

// Namespace ai/ai_shared
// Params 3, eflags: 0x1 linked
// Checksum 0x39635c87, Offset: 0x21f8
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
// Params 3, eflags: 0x1 linked
// Checksum 0xfe897a4a, Offset: 0x2288
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
// Params 3, eflags: 0x1 linked
// Checksum 0xb4b0b784, Offset: 0x2378
// Size: 0x274
function function_1628d95b(cansee = 0, var_9a21f98d = 1, var_2dd9c403 = self.origin) {
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
        distsq = distancesquared(var_2dd9c403, target.origin);
        if (!isdefined(nearesttarget) || distsq < var_46e1d165) {
            nearesttarget = target;
            var_46e1d165 = distsq;
        }
    }
    return nearesttarget;
}

// Namespace ai/ai_shared
// Params 1, eflags: 0x0
// Checksum 0xc9622044, Offset: 0x25f8
// Size: 0x32
function function_31a31a25(var_9a21f98d = 1) {
    return function_1628d95b(1, var_9a21f98d);
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x7af78884, Offset: 0x2638
// Size: 0x48
function function_41b04632() {
    return isdefined(self.targetname) && self.targetname == "destructible" && !isdefined(getent(self.target, "targetname"));
}

// Namespace ai/ai_shared
// Params 1, eflags: 0x0
// Checksum 0x570eee01, Offset: 0x2688
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
// Params 1, eflags: 0x1 linked
// Checksum 0x84d12a30, Offset: 0x27a0
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
// Params 0, eflags: 0x1 linked
// Checksum 0x7da71303, Offset: 0x2888
// Size: 0x1e
function is_stunned() {
    return isdefined(self.var_3d461e6f) && gettime() < self.var_3d461e6f;
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x8cfd505e, Offset: 0x28b0
// Size: 0xe
function clear_stun() {
    self.var_3d461e6f = undefined;
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x8c5ce5ec, Offset: 0x28c8
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
// Checksum 0x7b7016d3, Offset: 0x2a08
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
// Checksum 0x7986d7ab, Offset: 0x2ab0
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
// Checksum 0x352a9075, Offset: 0x2b38
// Size: 0x30
function function_f6060793() {
    if (isfunctionptr(self.var_b84eb531)) {
        self thread [[ self.var_b84eb531 ]]();
    }
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x0
// Checksum 0xba2ff0e6, Offset: 0x2b70
// Size: 0x42
function enable_careful() {
    assert(isai(self), "<dev string:x527>");
    self.script_careful = 1;
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x0
// Checksum 0x46a76e45, Offset: 0x2bc0
// Size: 0x3e
function disable_careful() {
    assert(isai(self), "<dev string:x564>");
    self.script_careful = 0;
}

// Namespace ai/ai_shared
// Params 6, eflags: 0x0
// Checksum 0xbe79aa06, Offset: 0x2c08
// Size: 0x248
function look_at(look_at, priority = 2, var_9e364106 = 1, duration = 0, var_152044ef, var_71e42546) {
    assert(isai(self), "<dev string:x5a3>");
    assert(priority >= 0 && priority < 4, "<dev string:x5e2>");
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
    if (isdefined(look_at)) {
        self.var_8a068c50[priority].set = 1;
    }
    if (duration > 0 && duration < 1) {
        self.var_8a068c50[priority].glance = 1;
    }
    self notify("look_at_" + string(priority) + "_updated");
    if (duration > 0) {
        self thread function_4760d8c0(priority, duration);
    }
    function_fcd4fcb7();
    return true;
}

// Namespace ai/ai_shared
// Params 2, eflags: 0x5 linked
// Checksum 0x6ab25669, Offset: 0x2e58
// Size: 0x8c
function private function_4760d8c0(priority, duration) {
    self notify("149af38ca577ea7f");
    self endon("149af38ca577ea7f");
    self endon("look_at_" + string(priority) + "_updated", #"death");
    wait duration;
    function_e1c5902(priority);
    function_fcd4fcb7();
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x5 linked
// Checksum 0xa41b5729, Offset: 0x2ef0
// Size: 0x50
function private function_191b31f3() {
    prioritystack = [];
    for (stackindex = 0; stackindex < 4; stackindex++) {
        prioritystack[stackindex] = spawnstruct();
    }
    return prioritystack;
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x5 linked
// Checksum 0x6b31093, Offset: 0x2f48
// Size: 0x182
function private function_91692eaa() {
    var_f613552 = undefined;
    var_9fe69433 = 0;
    var_f5eb28fc = undefined;
    var_1aa9eee = undefined;
    for (stackindex = 0; stackindex < 4; stackindex++) {
        if (is_true(self.var_8a068c50[stackindex].set)) {
            var_f613552 = self.var_8a068c50[stackindex].object;
            var_9fe69433 = is_true(self.var_8a068c50[stackindex].glance);
            var_f5eb28fc = is_true(self.var_8a068c50[stackindex].var_8fbcda45);
            var_1aa9eee = is_true(self.var_8a068c50[stackindex].var_eba0d1fe);
            break;
        }
    }
    if (!isdefined(self.lookat)) {
        self.lookat = {};
    }
    self.lookat.object = var_f613552;
    self.lookat.glance = var_9fe69433;
    self.lookat.var_8fbcda45 = var_f5eb28fc;
    self.lookat.var_eba0d1fe = var_1aa9eee;
}

// Namespace ai/ai_shared
// Params 1, eflags: 0x5 linked
// Checksum 0x6862b07, Offset: 0x30d8
// Size: 0x82
function private function_e1c5902(priority) {
    self.var_8a068c50[priority].object = undefined;
    self.var_8a068c50[priority].set = undefined;
    self.var_8a068c50[priority].glance = undefined;
    self.var_8a068c50[priority].var_8fbcda45 = undefined;
    self.var_8a068c50[priority].var_eba0d1fe = undefined;
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x0
// Checksum 0x27de6639, Offset: 0x3168
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
// Checksum 0x5997efd5, Offset: 0x31e8
// Size: 0x8c
function function_6b85d60d(priority) {
    if (!isdefined(self.var_8a068c50)) {
        self.var_8a068c50 = function_191b31f3();
    }
    assert(priority >= 0 && priority < 4, "<dev string:x60b>");
    function_e1c5902(priority);
    function_fcd4fcb7();
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x5 linked
// Checksum 0x75fc5125, Offset: 0x3280
// Size: 0x2d4
function private function_fcd4fcb7() {
    function_91692eaa();
    object = self.lookat.object;
    var_8fbcda45 = self.lookat.var_8fbcda45;
    var_eba0d1fe = self.lookat.var_eba0d1fe;
    if (self isinscriptedstate() && !is_true(self._scene_object._s.var_db255011)) {
        object = undefined;
    }
    if (self flag::get("scripted_lookat_disable")) {
        object = undefined;
    }
    if (isdefined(object)) {
        var_9d112229 = &lookatentity;
        var_77a9fe9e = &lookatpos;
        if (is_true(var_8fbcda45) && !is_true(var_eba0d1fe)) {
            var_9d112229 = &aimatentityik;
            var_77a9fe9e = &aimatposik;
        } else if (is_true(var_8fbcda45) && is_true(var_eba0d1fe)) {
            var_9d112229 = &aimatentityik;
            var_77a9fe9e = &function_2031372a;
        } else if (!is_true(var_8fbcda45) && is_true(var_eba0d1fe)) {
            var_77a9fe9e = &lookatangles;
        }
        if (isentity(object)) {
            self [[ var_9d112229 ]](object);
        } else if (!isvec(object)) {
            self [[ var_77a9fe9e ]](object.origin);
        } else {
            self [[ var_77a9fe9e ]](object);
        }
    } else {
        self lookatentity(undefined);
        self lookatpos(undefined);
    }
    /#
        self thread function_1571b7b6(object, is_true(self.lookat.glance));
    #/
}

/#

    // Namespace ai/ai_shared
    // Params 2, eflags: 0x4
    // Checksum 0x25d094db, Offset: 0x3560
    // Size: 0x1be
    function private function_1571b7b6(object, var_dfb8e94b) {
        self endon(#"death", #"entitydeleted");
        self notify("<dev string:x636>");
        self endon("<dev string:x636>");
        while (isdefined(object) && function_45ef77da()) {
            from = self geteye();
            to = object;
            if (!isvec(to) && issentient(to)) {
                to = to geteye();
            }
            var_ee0ec31 = anglestoforward(self gettagangles("<dev string:x64a>"));
            line(from, from + var_ee0ec31 * 500, (0.75, 0.75, 0.75), 1, 0, 1);
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
    // Checksum 0xc419595c, Offset: 0x3728
    // Size: 0x54
    function function_45ef77da() {
        dvar = getdvarstring(#"hash_4493b356ca38ab5e", "<dev string:x655>");
        return int(dvar);
    }

#/

// Namespace ai/ai_shared
// Params 2, eflags: 0x0
// Checksum 0xcea5de77, Offset: 0x3788
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
// Checksum 0xc896b36d, Offset: 0x3888
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
// Checksum 0xfac41ebe, Offset: 0x3988
// Size: 0x60
function poi_enable(var_dc8b0c0d, firstpoint, var_8fbcda45) {
    if (isfunctionptr(level.poi.var_705e0648)) {
        self thread [[ level.poi.var_705e0648 ]](var_dc8b0c0d, firstpoint, var_8fbcda45);
    }
}

// Namespace ai/ai_shared
// Params 6, eflags: 0x0
// Checksum 0x25747541, Offset: 0x39f0
// Size: 0x80
function function_3a5e9945(var_dc8b0c0d, yawmin, yawmax, pitchmin, pitchmax, var_8fbcda45) {
    if (isfunctionptr(level.poi.var_38974483)) {
        self thread [[ level.poi.var_38974483 ]](var_dc8b0c0d, yawmin, yawmax, pitchmin, pitchmax, var_8fbcda45);
    }
}

