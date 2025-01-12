#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai\systems\shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;

#namespace ai;

// Namespace ai/ai_shared
// Params 1, eflags: 0x0
// Checksum 0xd522fa36, Offset: 0x2a0
// Size: 0x4a
function set_pacifist(val) {
    assert(issentient(self), "<dev string:x30>");
    self.pacifist = val;
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x0
// Checksum 0xae967a86, Offset: 0x2f8
// Size: 0x3e
function disable_pain() {
    assert(isalive(self), "<dev string:x4d>");
    self.allowpain = 0;
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x0
// Checksum 0x65e10300, Offset: 0x340
// Size: 0x42
function enable_pain() {
    assert(isalive(self), "<dev string:x6f>");
    self.allowpain = 1;
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x0
// Checksum 0x6dc489a3, Offset: 0x390
// Size: 0x3a
function gun_remove() {
    self shared::placeweaponon(self.weapon, "none");
    self.gun_removed = 1;
}

// Namespace ai/ai_shared
// Params 2, eflags: 0x0
// Checksum 0x23b51d8d, Offset: 0x3d8
// Size: 0x2c
function gun_switchto(weapon, whichhand) {
    self shared::placeweaponon(weapon, whichhand);
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x0
// Checksum 0xb8b4ac1a, Offset: 0x410
// Size: 0x36
function gun_recall() {
    self shared::placeweaponon(self.primaryweapon, "right");
    self.gun_removed = undefined;
}

// Namespace ai/ai_shared
// Params 2, eflags: 0x0
// Checksum 0x5a42d548, Offset: 0x450
// Size: 0xac
function set_behavior_attribute(attribute, value) {
    if (isdefined(level.b_gmodifier_only_humans) && level.b_gmodifier_only_humans || isdefined(level.b_gmodifier_only_robots) && level.b_gmodifier_only_robots) {
        if (has_behavior_attribute(attribute)) {
            setaiattribute(self, attribute, value);
        }
        return;
    }
    setaiattribute(self, attribute, value);
}

// Namespace ai/ai_shared
// Params 1, eflags: 0x0
// Checksum 0x5033af90, Offset: 0x508
// Size: 0x22
function get_behavior_attribute(attribute) {
    return getaiattribute(self, attribute);
}

// Namespace ai/ai_shared
// Params 1, eflags: 0x0
// Checksum 0x621b0cb4, Offset: 0x538
// Size: 0x22
function has_behavior_attribute(attribute) {
    return hasaiattribute(self, attribute);
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x0
// Checksum 0x208e5ad8, Offset: 0x568
// Size: 0x48
function is_dead_sentient() {
    if (issentient(self) && !isalive(self)) {
        return 1;
    }
    return 0;
}

// Namespace ai/ai_shared
// Params 3, eflags: 0x0
// Checksum 0xe4d4e5ff, Offset: 0x5b8
// Size: 0x1f8
function waittill_dead(guys, num, timeoutlength) {
    allalive = 1;
    for (i = 0; i < guys.size; i++) {
        if (isalive(guys[i])) {
            continue;
        }
        allalive = 0;
        break;
    }
    assert(allalive, "<dev string:x90>");
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
// Checksum 0x79c6ebab, Offset: 0x7b8
// Size: 0x178
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
// Checksum 0x642c8b25, Offset: 0x938
// Size: 0x48
function private waittill_dead_thread(ent) {
    self waittill(#"death");
    ent.count--;
    ent notify(#"waittill_dead guy died");
}

// Namespace ai/ai_shared
// Params 1, eflags: 0x0
// Checksum 0xbd5bfdb8, Offset: 0x988
// Size: 0x58
function waittill_dead_or_dying_thread(ent) {
    self util::waittill_either("death", "pain_death");
    ent.count--;
    ent notify(#"waittill_dead_guy_dead_or_dying");
}

// Namespace ai/ai_shared
// Params 1, eflags: 0x0
// Checksum 0x103d9ad5, Offset: 0x9e8
// Size: 0x26
function waittill_dead_timeout(timeoutlength) {
    wait timeoutlength;
    self notify(#"thread_timed_out");
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x4
// Checksum 0x2dc725b3, Offset: 0xa18
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
// Checksum 0xd90f9947, Offset: 0xab0
// Size: 0x3e4
function shoot_at_target(mode, target, tag, duration, sethealth, ignorefirstshotwait) {
    self endon(#"death");
    self endon(#"stop_shoot_at_target");
    assert(isdefined(target), "<dev string:xeb>");
    assert(isdefined(mode), "<dev string:x11a>");
    mode_flag = mode === "normal" || mode === "shoot_until_target_dead" || mode === "kill_within_time";
    assert(mode_flag, "<dev string:x153>");
    if (isdefined(duration)) {
        assert(duration >= 0, "<dev string:x1ac>");
    } else {
        duration = 0;
    }
    if (isdefined(sethealth) && isdefined(target)) {
        target.health = sethealth;
    }
    if (!isdefined(target) || mode === "shoot_until_target_dead" && target.health <= 0) {
        return;
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
                if (!(isdefined(self.start_duration_comp) && self.start_duration_comp)) {
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
// Checksum 0x251a28d2, Offset: 0xea0
// Size: 0x5e
function stop_shoot_at_target() {
    self clearentitytarget();
    if (isdefined(self.aim_set_by_shoot_at_target) && self.aim_set_by_shoot_at_target) {
        self.perfectaim = 0;
        self.aim_set_by_shoot_at_target = 0;
    }
    self notify(#"stop_shoot_at_target");
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x0
// Checksum 0x1d7d0648, Offset: 0xf08
// Size: 0x2c
function wait_until_done_speaking() {
    self endon(#"death");
    while (self.isspeaking) {
        waitframe(1);
    }
}

// Namespace ai/ai_shared
// Params 3, eflags: 0x0
// Checksum 0x4a5ccd19, Offset: 0xf40
// Size: 0x120
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
    return goal;
}

// Namespace ai/ai_shared
// Params 5, eflags: 0x0
// Checksum 0x76a95513, Offset: 0x1068
// Size: 0xcc
function force_goal(goto, b_shoot = 1, str_end_on, b_keep_colors = 0, b_should_sprint = 0) {
    self endon(#"death");
    s_tracker = spawnstruct();
    self thread _force_goal(s_tracker, goto, b_shoot, str_end_on, b_keep_colors, b_should_sprint);
    s_tracker waittill(#"done");
}

// Namespace ai/ai_shared
// Params 6, eflags: 0x0
// Checksum 0x6b6d4785, Offset: 0x1140
// Size: 0x4a0
function _force_goal(s_tracker, goto, b_shoot = 1, str_end_on, b_keep_colors = 0, b_should_sprint = 0) {
    self endon(#"death");
    self notify(#"new_force_goal");
    flagsys::wait_till_clear("force_goal");
    flagsys::set(#"force_goal");
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
        var_35b9d6db = self get_behavior_attribute("move_mode");
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
        self pushplayer(1);
    }
    if (isdefined(goto)) {
        self setgoal(goto, 1);
    }
    self waittill(#"goal", #"new_force_goal", str_end_on);
    if (color_enabled) {
        colors::enable();
    }
    if (!isplayer(self)) {
        self pushplayer(0);
    }
    self clearforcedgoal();
    self val::reset(#"ai_forcegoal", "ignoreme");
    self val::reset(#"ai_forcegoal", "ignoreall");
    if (isdefined(allowpain) && allowpain) {
        self enable_pain();
    }
    if (self has_behavior_attribute("sprint")) {
        self set_behavior_attribute("sprint", 0);
    }
    if (isdefined(var_35b9d6db)) {
        self set_behavior_attribute("move_mode", var_35b9d6db);
    }
    self.ignoresuppression = ignoresuppression;
    self.grenadeawareness = grenadeawareness;
    flagsys::clear(#"force_goal");
    s_tracker notify(#"done");
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x0
// Checksum 0x6e46a6d0, Offset: 0x15e8
// Size: 0x16
function stoppainwaitinterval() {
    self notify(#"painwaitintervalremove");
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x4
// Checksum 0xdf0a927f, Offset: 0x1608
// Size: 0x46
function private _allowpainrestore() {
    self endon(#"death");
    self waittill(#"painwaitintervalremove", #"painwaitinterval");
    self.allowpain = 1;
}

// Namespace ai/ai_shared
// Params 1, eflags: 0x0
// Checksum 0xa808170a, Offset: 0x1658
// Size: 0xf6
function painwaitinterval(msec) {
    self endon(#"death");
    self notify(#"painwaitinterval");
    self endon(#"painwaitinterval");
    self endon(#"painwaitintervalremove");
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
// Params 1, eflags: 0x0
// Checksum 0x8160f7e2, Offset: 0x1758
// Size: 0x598
function patrol(start_path_node) {
    self endon(#"death");
    self endon(#"stop_patrolling");
    assert(isdefined(start_path_node), self.targetname + "<dev string:x1db>");
    if (start_path_node.type === #"bad node") {
        /#
            errormsg = "<dev string:x235>" + start_path_node.targetname + "<dev string:x24a>" + int(start_path_node.origin[0]) + "<dev string:x24e>" + int(start_path_node.origin[1]) + "<dev string:x24e>" + int(start_path_node.origin[2]) + "<dev string:x250>";
            iprintln(errormsg);
        #/
        return;
    }
    assert(start_path_node.type === #"path" || isdefined(start_path_node.scriptbundlename), "<dev string:x260>" + start_path_node.targetname + "<dev string:x275>");
    self notify(#"go_to_spawner_target");
    self.target = undefined;
    self.old_goal_radius = self.goalradius;
    self.goalradius = 16;
    self thread end_patrol_on_enemy_targetting();
    self.currentgoal = start_path_node;
    self.patroller = 1;
    while (true) {
        if (isdefined(self.currentgoal.type) && self.currentgoal.type == "Path") {
            if (self has_behavior_attribute("patrol")) {
                self set_behavior_attribute("patrol", 1);
            }
            self setgoal(self.currentgoal, 1);
            self waittill(#"goal");
            if (isdefined(self.currentgoal.script_notify)) {
                self notify(self.currentgoal.script_notify);
                level notify(self.currentgoal.script_notify);
            }
            if (isdefined(self.currentgoal.script_flag_set)) {
                flag = self.currentgoal.script_flag_set;
                if (!isdefined(level.flag[flag])) {
                    level flag::init(flag);
                }
                level flag::set(flag);
            }
            if (isdefined(self.currentgoal.script_flag_wait)) {
                flag = self.currentgoal.script_flag_wait;
                assert(isdefined(level.flag[flag]), "<dev string:x2b3>" + flag);
                level flag::wait_till(flag);
            }
            if (!isdefined(self.currentgoal.script_wait_min)) {
                self.currentgoal.script_wait_min = 0;
            }
            if (!isdefined(self.currentgoal.script_wait_max)) {
                self.currentgoal.script_wait_max = 0;
            }
            assert(self.currentgoal.script_wait_min <= self.currentgoal.script_wait_max, "<dev string:x2e8>" + self.currentgoal.targetname);
            if (!isdefined(self.currentgoal.scriptbundlename)) {
                wait_variability = self.currentgoal.script_wait_max - self.currentgoal.script_wait_min;
                wait_time = self.currentgoal.script_wait_min + randomfloat(wait_variability);
                self notify(#"patrol_goal", {#node:self.currentgoal});
                wait wait_time;
            } else {
                self scene::play(self.currentgoal.scriptbundlename, self);
            }
        } else if (isdefined(self.currentgoal.scriptbundlename)) {
            self.currentgoal scene::play(self.currentgoal.scriptbundlename, self);
        }
        self patrol_next_node();
    }
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x0
// Checksum 0xa24cab5, Offset: 0x1cf8
// Size: 0x10a
function patrol_next_node() {
    target_nodes = [];
    target_scenes = [];
    if (isdefined(self.currentgoal.target)) {
        target_nodes = getnodearray(self.currentgoal.target, "targetname");
        target_scenes = struct::get_array(self.currentgoal.target, "targetname");
    }
    if (target_nodes.size == 0 && target_scenes.size == 0) {
        self end_and_clean_patrol_behaviors();
        return;
    }
    if (target_nodes.size != 0) {
        self.currentgoal = array::random(target_nodes);
        return;
    }
    self.currentgoal = array::random(target_scenes);
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x0
// Checksum 0x5dcf63c8, Offset: 0x1e10
// Size: 0x68
function end_patrol_on_enemy_targetting() {
    self endon(#"death");
    self endon(#"alerted");
    while (true) {
        if (isdefined(self.should_stop_patrolling) && self.should_stop_patrolling) {
            self end_and_clean_patrol_behaviors();
        }
        wait 0.1;
    }
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x0
// Checksum 0x6a028f72, Offset: 0x1e80
// Size: 0xd6
function end_and_clean_patrol_behaviors() {
    if (isdefined(self.currentgoal) && isdefined(self.currentgoal.scriptbundlename)) {
        self stopanimscripted();
    }
    if (self has_behavior_attribute("patrol")) {
        self set_behavior_attribute("patrol", 0);
    }
    if (isdefined(self.old_goal_radius)) {
        self.goalradius = self.old_goal_radius;
    }
    self clearforcedgoal();
    self notify(#"stop_patrolling");
    self.patroller = undefined;
    self notify(#"alerted");
}

// Namespace ai/ai_shared
// Params 2, eflags: 0x0
// Checksum 0x1f6d04af, Offset: 0x1f60
// Size: 0x2bc
function bloody_death(n_delay, hit_loc) {
    self endon(#"death");
    if (!isdefined(self)) {
        return;
    }
    assert(isactor(self));
    assert(isalive(self));
    if (isdefined(self.__bloody_death) && self.__bloody_death) {
        return;
    }
    self.__bloody_death = 1;
    if (isdefined(n_delay)) {
        wait n_delay;
    }
    if (!isdefined(self) || !isalive(self)) {
        return;
    }
    if (isdefined(hit_loc)) {
        assert(isinarray(array("<dev string:x316>", "<dev string:x31d>", "<dev string:x322>", "<dev string:x327>", "<dev string:x333>", "<dev string:x33d>", "<dev string:x349>", "<dev string:x359>", "<dev string:x368>", "<dev string:x378>", "<dev string:x387>", "<dev string:x392>", "<dev string:x39c>", "<dev string:x3ac>", "<dev string:x3bb>", "<dev string:x3cb>", "<dev string:x3da>", "<dev string:x3e5>", "<dev string:x3ef>", "<dev string:x3f3>"), hit_loc), "<dev string:x3fe>");
    } else {
        hit_loc = array::random(array("helmet", "head", "neck", "torso_upper", "torso_mid", "torso_lower", "right_arm_upper", "left_arm_upper", "right_arm_lower", "left_arm_lower", "right_hand", "left_hand", "right_leg_upper", "left_leg_upper", "right_leg_lower", "left_leg_lower", "right_foot", "left_foot", "gun", "riotshield"));
    }
    self dodamage(self.health + 100, self.origin, undefined, undefined, hit_loc);
}

// Namespace ai/ai_shared
// Params 1, eflags: 0x0
// Checksum 0x8997bc02, Offset: 0x2228
// Size: 0x52
function shouldregisterclientfieldforarchetype(archetype) {
    if (isdefined(level.clientfieldaicheck) && level.clientfieldaicheck && !isarchetypeloaded(archetype)) {
        return false;
    }
    return true;
}

// Namespace ai/ai_shared
// Params 1, eflags: 0x0
// Checksum 0xd6cf5a33, Offset: 0x2288
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
// Checksum 0x8d724c23, Offset: 0x2360
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
// Checksum 0x14125905, Offset: 0x2478
// Size: 0x4c
function remove_protect_ent() {
    self.protectent = undefined;
    if (isactor(self)) {
        self setblackboardattribute("_defend", "defend_disabled");
    }
}

// Namespace ai/ai_shared
// Params 3, eflags: 0x0
// Checksum 0x8053abe7, Offset: 0x24d0
// Size: 0x9a
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
// Checksum 0xfc6d3876, Offset: 0x2578
// Size: 0xf2
function function_63b748bd(center, halfsize, angles) {
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
// Params 1, eflags: 0x0
// Checksum 0x61141c67, Offset: 0x2678
// Size: 0x19c
function function_12fcc666(active) {
    self endon(#"death");
    if (active === 1) {
        self clearenemy();
        self.var_99bdb208 = 1;
        if (self has_behavior_attribute("patrol")) {
            self set_behavior_attribute("patrol", 1);
        }
        fov = 0.7;
        var_a1fd8640 = 1000000;
        self function_b8a78ca6(fov, var_a1fd8640);
        while (isdefined(self) && self.var_99bdb208 === 1 && !isdefined(self.enemy)) {
            wait 0.25;
        }
    }
    self.var_99bdb208 = 0;
    if (self has_behavior_attribute("patrol")) {
        self set_behavior_attribute("patrol", 0);
    }
    fov = 0;
    var_a1fd8640 = 64000000;
    if (isdefined(self.sightdistance)) {
        var_a1fd8640 = self.sightdistance * self.sightdistance;
    }
    self function_b8a78ca6(0, 64000000);
}

// Namespace ai/ai_shared
// Params 2, eflags: 0x0
// Checksum 0x1096e50f, Offset: 0x2820
// Size: 0x2e
function function_b8a78ca6(fovcosine, maxsightdistsqrd) {
    self.fovcosine = fovcosine;
    self.maxsightdistsqrd = maxsightdistsqrd;
}

// Namespace ai/ai_shared
// Params 3, eflags: 0x0
// Checksum 0xff4afefc, Offset: 0x2858
// Size: 0x270
function function_9716c6cf(cansee = 0, var_72614eab = 1, overrideorigin = self.origin) {
    var_7e4a7173 = function_5e6ac79d(util::get_enemy_team(self.team), #"team3");
    nearesttarget = undefined;
    var_9eadb312 = undefined;
    foreach (target in var_7e4a7173) {
        if (!isalive(target) || isdefined(target.var_65f743a8) && target.var_65f743a8 || target function_3416a7e4()) {
            continue;
        }
        if (cansee && var_72614eab) {
            if (!self cansee(target)) {
                continue;
            }
        } else if (cansee && !var_72614eab) {
            targetpoint = isdefined(target.var_b49c3390) ? target.var_b49c3390 : target getcentroid();
            if (!sighttracepassed(self geteye(), targetpoint, 0, target)) {
                continue;
            }
        }
        distsq = distancesquared(overrideorigin, target.origin);
        if (!isdefined(nearesttarget) || distsq < var_9eadb312) {
            nearesttarget = target;
            var_9eadb312 = distsq;
        }
    }
    return nearesttarget;
}

// Namespace ai/ai_shared
// Params 1, eflags: 0x0
// Checksum 0xa2299b2d, Offset: 0x2ad0
// Size: 0x32
function function_baa92a04(var_72614eab = 1) {
    return function_9716c6cf(1, var_72614eab);
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x0
// Checksum 0xce0dfb6a, Offset: 0x2b10
// Size: 0x48
function function_3416a7e4() {
    return isdefined(self.targetname) && self.targetname == "destructible" && !isdefined(getent(self.target, "targetname"));
}

// Namespace ai/ai_shared
// Params 1, eflags: 0x0
// Checksum 0x618cc4ab, Offset: 0x2b60
// Size: 0x110
function function_8bd47b7e(enemy) {
    if (!isdefined(enemy)) {
        return false;
    }
    var_d1ebeabe = 1;
    if (isdefined(self.var_7063b967)) {
        var_96046250 = self.var_7063b967;
        if (var_96046250 < randomfloat(1)) {
            var_d1ebeabe = 0;
        }
    }
    if (var_d1ebeabe && isvehicle(enemy) && !(isdefined(enemy.var_b1db4c43) && enemy.var_b1db4c43)) {
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
// Checksum 0x40f4407e, Offset: 0x2c78
// Size: 0xb6
function stun(duration = self.var_6499b5b2) {
    if (!isdefined(duration) || !(isdefined(self.var_206e9b33) && self.var_206e9b33) || isdefined(self.var_67b0a19a) && self.var_67b0a19a) {
        return;
    }
    end_time = gettime() + int(duration * 1000);
    if (isdefined(self.var_8d67aa1a) && self.var_8d67aa1a > end_time) {
        return;
    }
    self.var_8d67aa1a = end_time;
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x0
// Checksum 0xdaa4b77a, Offset: 0x2d38
// Size: 0x1e
function is_stunned() {
    return isdefined(self.var_8d67aa1a) && gettime() < self.var_8d67aa1a;
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x0
// Checksum 0xea7c060f, Offset: 0x2d60
// Size: 0xe
function clear_stun() {
    self.var_8d67aa1a = undefined;
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x0
// Checksum 0x5bb5a797, Offset: 0x2d78
// Size: 0x144
function function_a0dbf10a() {
    if (!isdefined(self.var_105bdc9c)) {
        if (isdefined(self.aisettingsbundle)) {
            settingsbundle = self.aisettingsbundle;
        } else if (isspawner(self) && isdefined(self.aitype)) {
            settingsbundle = function_a6972700(self.aitype);
        } else if (isvehicle(self) && isdefined(self.scriptbundlesettings)) {
            settingsbundle = getscriptbundle(self.scriptbundlesettings).aisettingsbundle;
        }
        if (!isdefined(settingsbundle)) {
            return undefined;
        }
        self.var_105bdc9c = settingsbundle;
        if (!isdefined(level.var_48d9e777)) {
            level.var_48d9e777 = [];
        }
        if (!isdefined(level.var_48d9e777[self.var_105bdc9c])) {
            level.var_48d9e777[self.var_105bdc9c] = getscriptbundle(self.var_105bdc9c);
        }
    }
    return level.var_48d9e777[self.var_105bdc9c];
}

// Namespace ai/ai_shared
// Params 2, eflags: 0x0
// Checksum 0x9dd98f94, Offset: 0x2ec8
// Size: 0x9e
function function_f338efae(var_79ee70c4, fieldname) {
    if (!isdefined(level.var_48d9e777)) {
        level.var_48d9e777 = [];
    }
    if (!isdefined(level.var_48d9e777[var_79ee70c4])) {
        level.var_48d9e777[var_79ee70c4] = getscriptbundle(var_79ee70c4);
    }
    if (isdefined(level.var_48d9e777[var_79ee70c4])) {
        return level.var_48d9e777[var_79ee70c4].(fieldname);
    }
    return undefined;
}

