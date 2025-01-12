#using scripts/core_common/ai/archetype_utility;
#using scripts/core_common/ai/systems/ai_interface;
#using scripts/core_common/ai/systems/blackboard;
#using scripts/core_common/ai/systems/init;
#using scripts/core_common/ai/systems/shared;
#using scripts/core_common/ai/systems/weaponlist;
#using scripts/core_common/array_shared;
#using scripts/core_common/colors_shared;
#using scripts/core_common/flag_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/scene_objects_shared;
#using scripts/core_common/scene_shared;
#using scripts/core_common/struct;
#using scripts/core_common/util_shared;
#using scripts/core_common/values_shared;
#using scripts/core_common/vehicle_ai_shared;

#namespace ai;

// Namespace ai/ai_shared
// Params 1, eflags: 0x0
// Checksum 0x9ad0735b, Offset: 0x570
// Size: 0x4c
function set_pacifist(val) {
    assert(issentient(self), "<dev string:x28>");
    self.pacifist = val;
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x0
// Checksum 0xf8574e73, Offset: 0x5c8
// Size: 0x40
function disable_pain() {
    assert(isalive(self), "<dev string:x45>");
    self.allowpain = 0;
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x0
// Checksum 0x14dd8daa, Offset: 0x610
// Size: 0x44
function enable_pain() {
    assert(isalive(self), "<dev string:x67>");
    self.allowpain = 1;
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x0
// Checksum 0xa224591c, Offset: 0x660
// Size: 0x3c
function gun_remove() {
    self shared::placeweaponon(self.weapon, "none");
    self.gun_removed = 1;
}

// Namespace ai/ai_shared
// Params 2, eflags: 0x0
// Checksum 0xdddbc5e5, Offset: 0x6a8
// Size: 0x34
function gun_switchto(weapon, whichhand) {
    self shared::placeweaponon(weapon, whichhand);
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x0
// Checksum 0x537fd6ed, Offset: 0x6e8
// Size: 0x36
function gun_recall() {
    self shared::placeweaponon(self.primaryweapon, "right");
    self.gun_removed = undefined;
}

// Namespace ai/ai_shared
// Params 2, eflags: 0x0
// Checksum 0xbd34fdc6, Offset: 0x728
// Size: 0xac
function set_behavior_attribute(attribute, value) {
    if (isdefined(level.b_gmodifier_only_robots) && (isdefined(level.b_gmodifier_only_humans) && level.b_gmodifier_only_humans || level.b_gmodifier_only_robots)) {
        if (has_behavior_attribute(attribute)) {
            setaiattribute(self, attribute, value);
        }
        return;
    }
    setaiattribute(self, attribute, value);
}

// Namespace ai/ai_shared
// Params 1, eflags: 0x0
// Checksum 0xbfe56ea6, Offset: 0x7e0
// Size: 0x22
function get_behavior_attribute(attribute) {
    return getaiattribute(self, attribute);
}

// Namespace ai/ai_shared
// Params 1, eflags: 0x0
// Checksum 0xc8225139, Offset: 0x810
// Size: 0x22
function has_behavior_attribute(attribute) {
    return hasaiattribute(self, attribute);
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x0
// Checksum 0xb29d723e, Offset: 0x840
// Size: 0x46
function is_dead_sentient() {
    if (issentient(self) && !isalive(self)) {
        return 1;
    }
    return 0;
}

// Namespace ai/ai_shared
// Params 3, eflags: 0x0
// Checksum 0x62a9461f, Offset: 0x890
// Size: 0x218
function waittill_dead(guys, num, timeoutlength) {
    allalive = 1;
    for (i = 0; i < guys.size; i++) {
        if (isalive(guys[i])) {
            continue;
        }
        allalive = 0;
        break;
    }
    assert(allalive, "<dev string:x88>");
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
        ent waittill("waittill_dead guy died");
    }
}

// Namespace ai/ai_shared
// Params 3, eflags: 0x0
// Checksum 0xbfc77dbd, Offset: 0xab0
// Size: 0x1a0
function waittill_dead_or_dying(guys, num, timeoutlength) {
    newarray = [];
    for (i = 0; i < guys.size; i++) {
        if (isalive(guys[i]) && !guys[i].ignoreforfixednodesafecheck) {
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
        ent waittill("waittill_dead_guy_dead_or_dying");
    }
}

// Namespace ai/ai_shared
// Params 1, eflags: 0x4
// Checksum 0xac4b66c1, Offset: 0xc58
// Size: 0x38
function private waittill_dead_thread(ent) {
    self waittill("death");
    ent.count--;
    ent notify(#"waittill_dead guy died");
}

// Namespace ai/ai_shared
// Params 1, eflags: 0x0
// Checksum 0xa2ad55d3, Offset: 0xc98
// Size: 0x54
function waittill_dead_or_dying_thread(ent) {
    self util::waittill_either("death", "pain_death");
    ent.count--;
    ent notify(#"waittill_dead_guy_dead_or_dying");
}

// Namespace ai/ai_shared
// Params 1, eflags: 0x0
// Checksum 0xde1d1948, Offset: 0xcf8
// Size: 0x1e
function waittill_dead_timeout(timeoutlength) {
    wait timeoutlength;
    self notify(#"thread_timed_out");
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x4
// Checksum 0xa1fa4f08, Offset: 0xd20
// Size: 0x58
function private wait_for_shoot() {
    self endon(#"stop_shoot_at_target");
    if (isvehicle(self)) {
        self waittill("weapon_fired");
    } else {
        self waittill("shoot");
    }
    self.start_duration_comp = 1;
}

// Namespace ai/ai_shared
// Params 6, eflags: 0x0
// Checksum 0xb13e14a2, Offset: 0xd80
// Size: 0x404
function shoot_at_target(mode, target, tag, duration, sethealth, ignorefirstshotwait) {
    self endon(#"death");
    self endon(#"stop_shoot_at_target");
    assert(isdefined(target), "<dev string:xe3>");
    assert(isdefined(mode), "<dev string:x112>");
    mode_flag = mode === "normal" || mode === "shoot_until_target_dead" || mode === "kill_within_time";
    assert(mode_flag, "<dev string:x14b>");
    if (isdefined(duration)) {
        assert(duration >= 0, "<dev string:x1a4>");
    } else {
        duration = 0;
    }
    if (isdefined(sethealth) && isdefined(target)) {
        target.health = sethealth;
    }
    if (mode === "shoot_until_target_dead" && (!isdefined(target) || target.health <= 0)) {
        return;
    }
    if (isdefined(tag) && tag != "") {
        self setentitytarget(target, 1, tag);
    } else {
        self setentitytarget(target, 1);
    }
    self.var_752147e1 = 1;
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
        self vehicle_ai::clearallcooldowns();
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
                target waittill("death");
            }
        } else if (duration == -1) {
            target waittill("death");
        }
    }
    stop_shoot_at_target();
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x0
// Checksum 0xcedd2750, Offset: 0x1190
// Size: 0x6e
function stop_shoot_at_target() {
    self clearentitytarget();
    if (isdefined(self.aim_set_by_shoot_at_target) && self.aim_set_by_shoot_at_target) {
        self.perfectaim = 0;
        self.aim_set_by_shoot_at_target = 0;
    }
    self.var_752147e1 = 0;
    self notify(#"stop_shoot_at_target");
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x0
// Checksum 0xc764e2dd, Offset: 0x1208
// Size: 0x28
function wait_until_done_speaking() {
    self endon(#"death");
    while (self.isspeaking) {
        waitframe(1);
    }
}

// Namespace ai/ai_shared
// Params 3, eflags: 0x0
// Checksum 0x7ebe1807, Offset: 0x1238
// Size: 0x138
function set_goal(value, key, b_force) {
    if (!isdefined(key)) {
        key = "targetname";
    }
    if (!isdefined(b_force)) {
        b_force = 0;
    }
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
// Params 6, eflags: 0x0
// Checksum 0x33fc743d, Offset: 0x1378
// Size: 0xdc
function force_goal(goto, n_radius, b_shoot, str_end_on, b_keep_colors, b_should_sprint) {
    if (!isdefined(b_shoot)) {
        b_shoot = 1;
    }
    if (!isdefined(b_keep_colors)) {
        b_keep_colors = 0;
    }
    if (!isdefined(b_should_sprint)) {
        b_should_sprint = 0;
    }
    self endon(#"death");
    s_tracker = spawnstruct();
    self thread _force_goal(s_tracker, goto, n_radius, b_shoot, str_end_on, b_keep_colors, b_should_sprint);
    s_tracker waittill("done");
}

// Namespace ai/ai_shared
// Params 7, eflags: 0x0
// Checksum 0xbe7300cc, Offset: 0x1460
// Size: 0x52c
function _force_goal(s_tracker, goto, n_radius, b_shoot, str_end_on, b_keep_colors, b_should_sprint) {
    if (!isdefined(b_shoot)) {
        b_shoot = 1;
    }
    if (!isdefined(b_keep_colors)) {
        b_keep_colors = 0;
    }
    if (!isdefined(b_should_sprint)) {
        b_should_sprint = 0;
    }
    self endon(#"death");
    self notify(#"new_force_goal");
    flagsys::wait_till_clear("force_goal");
    flagsys::set("force_goal");
    goalradius = self.goalradius;
    if (isdefined(n_radius)) {
        assert(isfloat(n_radius) || isint(n_radius), "<dev string:x1d3>");
        self.goalradius = n_radius;
    }
    color_enabled = 0;
    if (!b_keep_colors) {
        if (isdefined(colors::get_force_color())) {
            color_enabled = 1;
            self colors::disable();
        }
    }
    allowpain = self.allowpain;
    ignoreall = self.ignoreall;
    ignoreme = self.ignoreme;
    ignoresuppression = self.ignoresuppression;
    grenadeawareness = self.grenadeawareness;
    if (!b_shoot) {
        self val::set("ai_forcegoal", "ignoreall", 1);
    }
    if (b_should_sprint && self has_behavior_attribute("sprint")) {
        self set_behavior_attribute("sprint", 1);
    }
    self.ignoresuppression = 1;
    self.grenadeawareness = 0;
    self val::set("ai_forcegoal", "ignoreme", 1);
    self disable_pain();
    if (!isplayer(self)) {
        self pushplayer(1);
    }
    if (isdefined(goto)) {
        if (isdefined(n_radius)) {
            assert(isfloat(n_radius) || isint(n_radius), "<dev string:x1d3>");
            self setgoal(goto);
        } else {
            self setgoal(goto, 1);
        }
    }
    self waittill("goal", "new_force_goal", str_end_on);
    if (color_enabled) {
        colors::enable();
    }
    if (!isplayer(self)) {
        self pushplayer(0);
    }
    self clearforcedgoal();
    self.goalradius = goalradius;
    self val::set("ai_forcegoal", "ignoreme", ignoreme);
    self val::set("ai_forcegoal", "ignoreall", ignoreall);
    if (isdefined(allowpain) && allowpain) {
        self enable_pain();
    }
    if (self has_behavior_attribute("sprint")) {
        self set_behavior_attribute("sprint", 0);
    }
    self.ignoresuppression = ignoresuppression;
    self.grenadeawareness = grenadeawareness;
    flagsys::clear("force_goal");
    s_tracker notify(#"done");
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x0
// Checksum 0x30ad742a, Offset: 0x1998
// Size: 0x12
function stoppainwaitinterval() {
    self notify(#"painwaitintervalremove");
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x4
// Checksum 0xaec25c92, Offset: 0x19b8
// Size: 0x34
function private _allowpainrestore() {
    self endon(#"death");
    self waittill("painWaitIntervalRemove", "painWaitInterval");
    self.allowpain = 1;
}

// Namespace ai/ai_shared
// Params 1, eflags: 0x0
// Checksum 0x5efee564, Offset: 0x19f8
// Size: 0xcc
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
        self waittill("pain");
        self.allowpain = 0;
        wait msec / 1000;
        self.allowpain = 1;
    }
}

// Namespace ai/ai_shared
// Params 1, eflags: 0x0
// Checksum 0xc0e99ac, Offset: 0x1ad0
// Size: 0x568
function patrol(start_path_node) {
    self endon(#"death");
    self endon(#"stop_patrolling");
    assert(isdefined(start_path_node), self.targetname + "<dev string:x213>");
    if (start_path_node.type == "BAD NODE") {
        /#
            errormsg = "<dev string:x26d>" + start_path_node.targetname + "<dev string:x282>" + int(start_path_node.origin[0]) + "<dev string:x286>" + int(start_path_node.origin[1]) + "<dev string:x286>" + int(start_path_node.origin[2]) + "<dev string:x288>";
            iprintln(errormsg);
            logprint(errormsg);
        #/
        return;
    }
    assert(start_path_node.type == "<dev string:x298>" || isdefined(start_path_node.scriptbundlename), "<dev string:x29d>" + start_path_node.targetname + "<dev string:x2b2>");
    self notify(#"go_to_spawner_target");
    self.target = undefined;
    self.old_goal_radius = self.goalradius;
    self thread end_patrol_on_enemy_targetting();
    self.currentgoal = start_path_node;
    self.patroller = 1;
    while (true) {
        if (isdefined(self.currentgoal.type) && self.currentgoal.type == "Path") {
            if (self has_behavior_attribute("patrol")) {
                self set_behavior_attribute("patrol", 1);
            }
            self setgoal(self.currentgoal, 1);
            self waittill("goal");
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
            if (!isdefined(self.currentgoal.script_wait_min)) {
                self.currentgoal.script_wait_min = 0;
            }
            if (!isdefined(self.currentgoal.script_wait_max)) {
                self.currentgoal.script_wait_max = 0;
            }
            assert(self.currentgoal.script_wait_min <= self.currentgoal.script_wait_max, "<dev string:x2f0>" + self.currentgoal.targetname);
            if (!isdefined(self.currentgoal.scriptbundlename)) {
                wait_variability = self.currentgoal.script_wait_max - self.currentgoal.script_wait_min;
                wait_time = self.currentgoal.script_wait_min + randomfloat(wait_variability);
                self notify(#"patrol_goal", {#node:self.currentgoal});
                wait wait_time;
            } else {
                self scene::play(self.currentgoal.scriptbundlename, self);
            }
        } else if (isdefined(self.currentgoal.scriptbundlename)) {
            self.currentgoal scene::play(self);
        }
        self patrol_next_node();
    }
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x0
// Checksum 0xb1430966, Offset: 0x2040
// Size: 0x11c
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
// Checksum 0x872b2300, Offset: 0x2168
// Size: 0x68
function end_patrol_on_enemy_targetting() {
    self endon(#"death");
    self endon(#"stop_patrolling");
    while (true) {
        if (isdefined(self.enemy) || self.should_stop_patrolling === 1) {
            self end_and_clean_patrol_behaviors();
        }
        wait 0.1;
    }
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x0
// Checksum 0xa99fcd15, Offset: 0x21d8
// Size: 0xd2
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
}

// Namespace ai/ai_shared
// Params 2, eflags: 0x0
// Checksum 0x1d8c1812, Offset: 0x22b8
// Size: 0x2d4
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
        assert(isinarray(array("<dev string:x31e>", "<dev string:x325>", "<dev string:x32a>", "<dev string:x32f>", "<dev string:x33b>", "<dev string:x345>", "<dev string:x351>", "<dev string:x361>", "<dev string:x370>", "<dev string:x380>", "<dev string:x38f>", "<dev string:x39a>", "<dev string:x3a4>", "<dev string:x3b4>", "<dev string:x3c3>", "<dev string:x3d3>", "<dev string:x3e2>", "<dev string:x3ed>", "<dev string:x3f7>", "<dev string:x3fb>"), hit_loc), "<dev string:x406>");
    } else {
        hit_loc = array::random(array("helmet", "head", "neck", "torso_upper", "torso_mid", "torso_lower", "right_arm_upper", "left_arm_upper", "right_arm_lower", "left_arm_lower", "right_hand", "left_hand", "right_leg_upper", "left_leg_upper", "right_leg_lower", "left_leg_lower", "right_foot", "left_foot", "gun", "riotshield"));
    }
    self dodamage(self.health + 100, self.origin, undefined, undefined, hit_loc);
}

// Namespace ai/ai_shared
// Params 1, eflags: 0x0
// Checksum 0x61a51532, Offset: 0x2598
// Size: 0x50
function shouldregisterclientfieldforarchetype(archetype) {
    if (isdefined(level.clientfieldaicheck) && level.clientfieldaicheck && !isarchetypeloaded(archetype)) {
        return false;
    }
    return true;
}

// Namespace ai/ai_shared
// Params 1, eflags: 0x0
// Checksum 0xf707269d, Offset: 0x25f0
// Size: 0xdc
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
// Checksum 0xa720c0f9, Offset: 0x26d8
// Size: 0x12c
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
// Checksum 0xd8ad895b, Offset: 0x2810
// Size: 0x4c
function remove_protect_ent() {
    self.protectent = undefined;
    if (isactor(self)) {
        self setblackboardattribute("_defend", "defend_disabled");
    }
}

// Namespace ai/ai_shared
// Params 3, eflags: 0x0
// Checksum 0xb058a050, Offset: 0x2868
// Size: 0xa4
function t_cylinder(origin, radius, halfheight) {
    struct = spawnstruct();
    struct.type = 1;
    struct.origin = origin;
    struct.radius = float(radius);
    struct.halfheight = float(halfheight);
    return struct;
}

