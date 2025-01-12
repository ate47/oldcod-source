#using scripts\abilities\gadgets\gadget_cymbal_monkey;
#using scripts\core_common\ai\systems\animation_state_machine_notetracks;
#using scripts\core_common\ai\systems\behavior_state_machine;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\zombie;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\values_shared;
#using scripts\wz_common\wz_ai_utils;

#namespace wz_ai_zombie;

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 0, eflags: 0x2
// Checksum 0x4b9e132e, Offset: 0x3c8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"wz_ai_zombie", &__init__, undefined, undefined);
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 0, eflags: 0x4
// Checksum 0xd06d3cc3, Offset: 0x410
// Size: 0x32e
function private __init__() {
    clientfield::register("actor", "zombie_riser_fx", 1, 1, "int");
    clientfield::register("actor", "zombie_has_eyes", 1, 1, "int");
    level.var_47a0b064 = [];
    level.var_47a0b064[#"walk"] = [];
    level.var_47a0b064[#"run"] = [];
    level.var_47a0b064[#"sprint"] = [];
    level.var_47a0b064[#"super_sprint"] = [];
    level.var_47a0b064[#"walk"][#"down"] = 14;
    level.var_47a0b064[#"walk"][#"up"] = 16;
    level.var_47a0b064[#"run"][#"down"] = 13;
    level.var_47a0b064[#"run"][#"up"] = 12;
    level.var_47a0b064[#"sprint"][#"down"] = 9;
    level.var_47a0b064[#"sprint"][#"up"] = 8;
    level.var_47a0b064[#"super_sprint"][#"down"] = 1;
    level.var_47a0b064[#"super_sprint"][#"up"] = 1;
    spawner::add_archetype_spawn_function("zombie", &function_6f0def21);
    initzombiebehaviors();
    val::register("allowoffnavmesh", 1);
    val::default_value("allowoffnavmesh", 0);
    level.attackablecallback = &attackable_callback;
    level.var_e3cc172b = &function_e3cc172b;
    level.var_96884b5e = &function_96884b5e;
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 0, eflags: 0x0
// Checksum 0x9a0dbebf, Offset: 0x748
// Size: 0x42
function function_e3cc172b() {
    if (isdefined(self.ai_zone) && isdefined(self.ai_zone.is_active) && self.ai_zone.is_active) {
        return true;
    }
    return false;
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 1, eflags: 0x0
// Checksum 0x4d1a0d99, Offset: 0x798
// Size: 0x62
function function_96884b5e(playerradius) {
    position = getclosestpointonnavmesh(self.origin - (0, 0, 60), 200, playerradius);
    if (isdefined(position)) {
        self.last_valid_position = position;
    }
    return self.last_valid_position;
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 1, eflags: 0x0
// Checksum 0xc9c73da5, Offset: 0x808
// Size: 0x9c
function function_8128e320(vehicle) {
    if (isdefined(vehicle)) {
        vehicle dodamage(50, vehicle.origin);
        org = vehicle.origin;
        earthquake(0.3, 1, org, 2000);
        playrumbleonposition("grenade_rumble", org);
    }
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 1, eflags: 0x0
// Checksum 0xc40beb3d, Offset: 0x8b0
// Size: 0x24
function attackable_callback(entity) {
    function_8128e320(self);
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 0, eflags: 0x0
// Checksum 0x270ff81a, Offset: 0x8e0
// Size: 0x6dc
function initzombiebehaviors() {
    assert(isscriptfunctionptr(&function_26c86578));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"wzzombieupdatethrottle", &function_26c86578, 1);
    assert(isscriptfunctionptr(&zombieshouldmelee));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"wzzombieshouldmelee", &zombieshouldmelee);
    assert(isscriptfunctionptr(&function_6f707486));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_350ddff40ea2207b", &function_6f707486);
    assert(isscriptfunctionptr(&function_d93501a5));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_77070e8fef81d6da", &function_d93501a5);
    assert(isscriptfunctionptr(&function_6f707486));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_350ddff40ea2207b", &function_6f707486);
    assert(isscriptfunctionptr(&function_679842af));
    behaviorstatemachine::registerbsmscriptapiinternal(#"wzzombieshouldreact", &function_679842af);
    assert(isscriptfunctionptr(&zombieshouldmove));
    behaviorstatemachine::registerbsmscriptapiinternal(#"wzzombieshouldmove", &zombieshouldmove);
    assert(isscriptfunctionptr(&function_c27f159b));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_2b17bbf6d0ceff72", &function_c27f159b);
    assert(isscriptfunctionptr(&function_7040b4b8));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_336e28ae1ed4640b", &function_7040b4b8);
    assert(isscriptfunctionptr(&function_6f540f61));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_53e4632b82a3a930", &function_6f540f61);
    assert(isscriptfunctionptr(&function_d22c6a6a));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_791763042d13fef1", &function_d22c6a6a);
    assert(isscriptfunctionptr(&function_5a110a35));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_24de191ac3416c18", &function_5a110a35);
    assert(isscriptfunctionptr(&function_40c63b44));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_33c14e313f684eab", &function_40c63b44);
    assert(isscriptfunctionptr(&zombiemoveactionstart));
    behaviorstatemachine::registerbsmscriptapiinternal(#"wzzombiemoveactionstart", &zombiemoveactionstart);
    assert(isscriptfunctionptr(&zombiemoveactionupdate));
    behaviorstatemachine::registerbsmscriptapiinternal(#"wzzombiemoveactionupdate", &zombiemoveactionupdate);
    assert(isscriptfunctionptr(&function_44050ea7));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_796d69f77ff45304", &function_44050ea7);
    animationstatenetwork::registernotetrackhandlerfunction("zombieRiserFx", &function_4514e21a);
    animationstatenetwork::registernotetrackhandlerfunction("showZombie", &showzombie);
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 0, eflags: 0x4
// Checksum 0x28337607, Offset: 0xfc8
// Size: 0x142
function private function_6f0def21() {
    self callback::function_1dea870d(#"on_ai_damage", &function_2718f38d);
    self callback::function_1dea870d(#"on_ai_killed", &zombie_death_event);
    self.clamptonavmesh = 0;
    self.ignorepathenemyfightdist = 1;
    self.var_40c3ca7d = 0;
    self.var_f33b7054 = 180;
    self.var_6b113703 = 128;
    self wz_ai_utils::function_26a629a8("walk");
    self.spawn_anim = "ai_zombie_base_traverse_ground_climbout_fast";
    self thread function_777fe596();
    self thread zombie_gib_on_damage();
    self thread function_98ce5aca();
    self.maxhealth = level.startinghealth;
    self.health = self.maxhealth;
    self.cant_move_cb = &function_f55a524e;
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 1, eflags: 0x4
// Checksum 0x7d445c97, Offset: 0x1118
// Size: 0x72
function private function_2718f38d(params) {
    if (!isdefined(self.enemy_override) && isdefined(self.favoriteenemy) && isdefined(params.eattacker) && isplayer(params.eattacker)) {
        self.favoriteenemy = params.eattacker;
    }
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 0, eflags: 0x4
// Checksum 0x6c9ea8f1, Offset: 0x1198
// Size: 0x64
function private function_f55a524e() {
    self notify("674df4b2d93d18f7");
    self endon("69374bc3bb25b7a4", #"death");
    self collidewithactors(0);
    wait 2;
    self collidewithactors(1);
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 1, eflags: 0x4
// Checksum 0xe06dad69, Offset: 0x1208
// Size: 0x2e
function private function_26c86578(entity) {
    level.var_df2085fe = entity getentitynumber();
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 1, eflags: 0x4
// Checksum 0xdb56d264, Offset: 0x1240
// Size: 0x392
function private zombieshouldmelee(entity) {
    if (isdefined(entity.enemy_override)) {
        return false;
    }
    if (!isdefined(entity.enemy)) {
        return false;
    }
    if (isdefined(entity.ignoremelee) && entity.ignoremelee) {
        return false;
    }
    if (isdefined(entity.var_74ce5898) && entity.var_74ce5898 || isdefined(entity.var_25c0e873) && entity.var_25c0e873) {
        return false;
    }
    if (abs(entity.origin[2] - entity.enemy.origin[2]) > (isdefined(entity.var_6b113703) ? entity.var_6b113703 : 64)) {
        return false;
    }
    meleedistsq = zombiebehavior::function_e3f0cca3(entity);
    if (distancesquared(entity.origin, entity.enemy.origin) > meleedistsq) {
        return false;
    }
    yawtoenemy = angleclamp180(entity.angles[1] - vectortoangles(entity.enemy.origin - entity.origin)[1]);
    if (abs(yawtoenemy) > (isdefined(entity.var_f33b7054) ? entity.var_f33b7054 : 60)) {
        return false;
    }
    if (!entity cansee(entity.enemy)) {
        return false;
    }
    if (distancesquared(entity.origin, entity.enemy.origin) < 40 * 40) {
        return true;
    }
    if (isdefined(entity.enemy.usingvehicle) && entity.enemy.usingvehicle) {
        entity.attackable = entity.enemy getvehicleoccupied();
        entity.attackable.is_active = 1;
        entity.is_at_attackable = 1;
        return true;
    }
    if (isdefined(self.isonnavmesh) && self.isonnavmesh && !tracepassedonnavmesh(entity.origin, isdefined(entity.enemy.last_valid_position) ? entity.enemy.last_valid_position : entity.enemy.origin, entity.enemy getpathfindingradius())) {
        return false;
    }
    return true;
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 1, eflags: 0x4
// Checksum 0x35f76b0c, Offset: 0x15e0
// Size: 0x28
function private function_6f707486(entity) {
    return isdefined(entity.var_74ce5898) && entity.var_74ce5898;
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 1, eflags: 0x4
// Checksum 0xcfe3c041, Offset: 0x1610
// Size: 0x28
function private function_d93501a5(entity) {
    return isdefined(entity.var_25c0e873) && entity.var_25c0e873;
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 1, eflags: 0x4
// Checksum 0x9d4b59af, Offset: 0x1640
// Size: 0x28
function private function_679842af(entity) {
    return isdefined(entity.shouldreact) && entity.shouldreact;
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 1, eflags: 0x4
// Checksum 0x1fc0542e, Offset: 0x1670
// Size: 0x2c
function private zombieshouldmove(entity) {
    return entity.allowoffnavmesh || entity haspath();
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 1, eflags: 0x4
// Checksum 0x6c912beb, Offset: 0x16a8
// Size: 0x28
function private function_c27f159b(entity) {
    return isdefined(entity.var_6edb26c0) && entity.var_6edb26c0;
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 1, eflags: 0x4
// Checksum 0xfdf97e17, Offset: 0x16d8
// Size: 0x1dc
function private function_f46fef7f(entity) {
    origin = undefined;
    if (isdefined(self.enemy_override)) {
        origin = self.enemy_override.origin;
    } else if (isdefined(self.favoriteenemy)) {
        origin = self.favoriteenemy.origin;
    }
    if (!isdefined(origin)) {
        return;
    }
    to_origin = origin - entity.origin;
    yaw = vectortoangles(to_origin)[1] - entity.angles[1];
    yaw = absangleclamp360(yaw);
    entity.shouldreact = 1;
    if (yaw <= 45 || yaw > 315) {
        entity setblackboardattribute("_zombie_react_direction", "front");
        return;
    }
    if (yaw > 45 && yaw <= 135) {
        entity setblackboardattribute("_zombie_react_direction", "left");
        return;
    }
    if (yaw > 135 && yaw <= 225) {
        entity setblackboardattribute("_zombie_react_direction", "back");
        return;
    }
    entity setblackboardattribute("_zombie_react_direction", "right");
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 1, eflags: 0x4
// Checksum 0x65b79b6d, Offset: 0x18c0
// Size: 0x48
function private function_5a110a35(entity) {
    entity.var_74ce5898 = undefined;
    entity.is_digging = 1;
    entity pathmode("dont move", 1);
    return true;
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 1, eflags: 0x4
// Checksum 0x4e3f2e4a, Offset: 0x1910
// Size: 0x74
function private function_40c63b44(entity) {
    entity ghost();
    entity notsolid();
    entity clientfield::set("zombie_riser_fx", 0);
    entity notify(#"is_underground");
    return true;
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 1, eflags: 0x4
// Checksum 0x2846204, Offset: 0x1990
// Size: 0x4e
function private function_7040b4b8(entity) {
    entity solid();
    entity clientfield::set("zombie_riser_fx", 1);
    entity.var_25c0e873 = undefined;
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 1, eflags: 0x4
// Checksum 0x67196d66, Offset: 0x19e8
// Size: 0x68
function private function_6f540f61(entity) {
    entity clientfield::set("zombie_riser_fx", 0);
    entity.is_digging = 0;
    entity pathmode("move allowed");
    entity notify(#"not_underground");
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 1, eflags: 0x4
// Checksum 0x2e09320a, Offset: 0x1a58
// Size: 0x1a
function private function_d22c6a6a(entity) {
    entity.shouldreact = undefined;
    return true;
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 1, eflags: 0x4
// Checksum 0xa874e9d8, Offset: 0x1a80
// Size: 0x36
function private zombiemoveactionstart(entity) {
    entity.movetime = gettime();
    entity.moveorigin = entity.origin;
    return true;
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 1, eflags: 0x4
// Checksum 0x37cc2fd7, Offset: 0x1ac0
// Size: 0xd2
function private zombiemoveactionupdate(entity) {
    if (!(isdefined(entity.missinglegs) && entity.missinglegs) && gettime() - entity.movetime > 1000) {
        distsq = distance2dsquared(entity.origin, entity.moveorigin);
        if (distsq < 144) {
            if (isdefined(entity.cant_move_cb)) {
                entity thread [[ entity.cant_move_cb ]]();
            }
        }
        entity.movetime = gettime();
        entity.moveorigin = entity.origin;
    }
    return true;
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 1, eflags: 0x4
// Checksum 0xc67d163c, Offset: 0x1ba0
// Size: 0x1a
function private function_44050ea7(entity) {
    entity.var_6edb26c0 = undefined;
    return true;
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 1, eflags: 0x4
// Checksum 0x399794b4, Offset: 0x1bc8
// Size: 0x2c
function private function_4514e21a(entity) {
    entity clientfield::set("zombie_riser_fx", 1);
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 1, eflags: 0x4
// Checksum 0x294fc3fb, Offset: 0x1c00
// Size: 0x24
function private showzombie(entity) {
    entity show();
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 0, eflags: 0x4
// Checksum 0x965224c, Offset: 0x1c30
// Size: 0x5a
function private function_6d8c6b17() {
    switch (self.aistate) {
    case 3:
        self.goalradius = 64;
        break;
    default:
        self.goalradius = 32;
        break;
    }
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 2, eflags: 0x4
// Checksum 0x4043257c, Offset: 0x1c98
// Size: 0x74
function private function_f787e1da(id, value) {
    if (isdefined(value) && value) {
        self val::set(id, "allowoffnavmesh", 1);
        return;
    }
    self val::reset(id, "allowoffnavmesh");
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 0, eflags: 0x4
// Checksum 0x9f10ce15, Offset: 0x1d18
// Size: 0x346
function private function_98ce5aca() {
    level endon(#"game_ended");
    self endon(#"death");
    if (isdefined(self.spawn_anim)) {
        self wz_ai_utils::function_4feb4f21(self.origin, self.angles, self.spawn_anim, 1);
    }
    waitframe(1);
    self.aistate = 1;
    self setgoal(self.origin);
    while (true) {
        self.isonnavmesh = ispointonnavmesh(self.origin, self);
        self function_b473e020();
        if (!self.isonnavmesh && self.allowoffnavmesh) {
            if (!isdefined(self.var_b5101cb8)) {
                self.var_b5101cb8 = gettime();
                self.var_873d1620 = randomintrange(6000, 10000);
            }
        } else {
            self.var_b5101cb8 = undefined;
            self function_6d8c6b17();
        }
        if (self.aistate !== 5 && isdefined(self.var_b5101cb8) && gettime() - self.var_b5101cb8 > self.var_873d1620) {
            self.var_b4458b4b = 5;
        }
        if (isdefined(self.var_b4458b4b) && self.aistate != self.var_b4458b4b) {
            self function_db8d8039(self.aistate);
            self.aistate = self.var_b4458b4b;
            self function_23def054(self.aistate);
            self notify(#"state_changed");
            self.var_b4458b4b = undefined;
        }
        switch (self.aistate) {
        case 1:
            self function_2a29ba4f();
            break;
        case 3:
            self function_b2960fe6();
            break;
        case 5:
            self function_80f792a0();
            break;
        case 0:
        default:
            break;
        }
        if ((self getentitynumber() & 1) == (getlevelframenumber() & 1)) {
            self.clamptonavmesh = !self.isonnavmesh && self istouching(self.ai_zone);
        }
        update_goal();
        waitframe(1);
    }
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 0, eflags: 0x4
// Checksum 0x6cfd69a3, Offset: 0x2068
// Size: 0xfe
function private update_goal() {
    if (isdefined(self.var_ea580094) && level.var_df2085fe === self getentitynumber()) {
        if (!self.allowoffnavmesh && self.isonnavmesh) {
            adjustedgoal = getclosestpointonnavmesh(self.var_ea580094, 100, self getpathfindingradius());
            if (isdefined(adjustedgoal)) {
                pathdata = generatenavmeshpath(self.origin, adjustedgoal, self);
                if (isdefined(pathdata) && pathdata.status === "succeeded") {
                    self setgoal(adjustedgoal);
                }
            }
        }
        self.var_ea580094 = undefined;
    }
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 0, eflags: 0x4
// Checksum 0x8203364c, Offset: 0x2170
// Size: 0xe2
function private function_b473e020() {
    self.enemy_override = function_7e8cbd1();
    if (isdefined(self.enemy_override)) {
        self.favoriteenemy = undefined;
    } else if (isdefined(self.favoriteenemy)) {
        if (self wz_ai_utils::function_8ac865a8(self.favoriteenemy)) {
            self.var_40c3ca7d = gettime();
        }
        if (gettime() - self.var_40c3ca7d > 8000 || !wz_ai_utils::is_player_valid(self.favoriteenemy)) {
            self.favoriteenemy = undefined;
        }
    }
    if (!isdefined(self.enemy_override) && !isdefined(self.favoriteenemy)) {
        self.favoriteenemy = wz_ai_utils::ai_wz_can_see();
    }
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 0, eflags: 0x4
// Checksum 0xf7fbe44b, Offset: 0x2260
// Size: 0x5c
function private function_7e8cbd1() {
    enemy_override = gadget_cymbal_monkey::function_5a3f7c0d(self);
    if (!isdefined(enemy_override)) {
        return undefined;
    }
    if (self.isonnavmesh && !isdefined(enemy_override.var_b7cd1dda)) {
        return undefined;
    }
    return enemy_override;
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 1, eflags: 0x4
// Checksum 0xc64ea6f3, Offset: 0x22c8
// Size: 0x162
function private function_db8d8039(state) {
    switch (state) {
    case 1:
        self.var_fb776b4 = undefined;
        self clearpath();
        if (self.var_b4458b4b === 3) {
            function_f46fef7f(self);
        }
        break;
    case 3:
        self function_f787e1da(#"hash_6e6d6ff06622efa4", 0);
        self pathmode("move allowed");
        break;
    case 5:
        self function_f787e1da(#"hash_5780e28b762b831a", 0);
        val::reset(#"hash_5780e28b762b831a", "ignoreall");
        self pathmode("move allowed");
        break;
    default:
        break;
    }
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 1, eflags: 0x4
// Checksum 0xcbfd7f20, Offset: 0x2438
// Size: 0x144
function private function_23def054(state) {
    switch (state) {
    case 1:
        self wz_ai_utils::function_26a629a8("walk");
        self.favoriteenemy = undefined;
        break;
    case 3:
        self wz_ai_utils::function_26a629a8("sprint");
        break;
    case 5:
        self function_f787e1da(#"hash_5780e28b762b831a", !self.isonnavmesh);
        val::set(#"hash_5780e28b762b831a", "ignoreall", 1);
        if (!self.isonnavmesh) {
            self pathmode("dont move", 1);
        }
        break;
    default:
        break;
    }
    self function_6d8c6b17();
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 0, eflags: 0x4
// Checksum 0xfd448d6, Offset: 0x2588
// Size: 0x32e
function private function_b2960fe6() {
    self pathmode("move allowed");
    self function_9f59031e();
    if (isdefined(self.enemy_override)) {
        var_174795fb = ispointonnavmesh(self.enemy_override.origin, self);
        if (var_174795fb && self.isonnavmesh) {
            self function_f787e1da(#"hash_6e6d6ff06622efa4", 0);
            self.var_ea580094 = self.enemy_override.origin;
            return;
        }
        if (self.isonnavmesh && isdefined(self.enemy_override.var_b7cd1dda) && !self isingoal(self.enemy_override.var_b7cd1dda)) {
            self.var_ea580094 = self.enemy_override.var_b7cd1dda;
            return;
        }
        if (!self.isonnavmesh || self isatgoal()) {
            self function_f787e1da(#"hash_6e6d6ff06622efa4", 1);
            self pathmode("dont move", 1);
            self function_3c8dce03(self.enemy_override.origin);
        }
        return;
    }
    if (isdefined(self.favoriteenemy)) {
        if (isdefined(self.favoriteenemy.last_valid_position) && self.favoriteenemy.ai_zone === self.ai_zone) {
            self.var_ea580094 = self.favoriteenemy.last_valid_position;
            if (self.isonnavmesh) {
                self function_f787e1da(#"hash_6e6d6ff06622efa4", 0);
            }
            return;
        } else if (isdefined(self.favoriteenemy.last_valid_position) && !ispointonnavmesh(self.favoriteenemy.origin, self)) {
            if (!self.isonnavmesh && !self function_482b72a() || self isatgoal()) {
                self pathmode("dont move", 1);
                self function_f787e1da(#"hash_6e6d6ff06622efa4", 1);
            }
        }
        return;
    }
    self.var_b4458b4b = 1;
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 0, eflags: 0x4
// Checksum 0x8ebadda5, Offset: 0x28c0
// Size: 0xba
function private function_2a29ba4f() {
    if (!isdefined(self.var_fb776b4) && isdefined(self.ai_zone.spawn_points) && self.ai_zone.spawn_points.size > 0) {
        self thread function_91d77373();
    }
    if (!self.isonnavmesh && !self function_482b72a()) {
        self.var_b4458b4b = 5;
        return;
    }
    if (isdefined(self.enemy_override) || isdefined(self.favoriteenemy)) {
        self.var_b4458b4b = 3;
    }
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 0, eflags: 0x4
// Checksum 0x136de2b0, Offset: 0x2988
// Size: 0x188
function private function_91d77373() {
    level endon(#"game_ended");
    self endon(#"death", #"state_changed");
    while (true) {
        self.var_fb776b4 = self.ai_zone.spawn_points[self.ai_zone.var_7a44fd53].origin;
        self.ai_zone.var_7a44fd53++;
        if (self.ai_zone.var_7a44fd53 >= self.ai_zone.spawn_points.size) {
            self.ai_zone.var_7a44fd53 = 0;
        }
        if (isdefined(self.var_fb776b4)) {
            self.var_ea580094 = self.var_fb776b4;
        } else {
            self.var_ea580094 = self.origin;
        }
        wait_time = randomfloatrange(3, 5);
        waitresult = self waittilltimeout(wait_time, #"goal");
        if (waitresult._notify !== "timeout") {
            idle_time = randomfloatrange(3, 5);
            wait idle_time;
        }
    }
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 0, eflags: 0x4
// Checksum 0x6032daa2, Offset: 0x2b18
// Size: 0x12
function private function_489cfab4() {
    self.var_b4458b4b = 1;
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 0, eflags: 0x4
// Checksum 0xbf6c73ed, Offset: 0x2b38
// Size: 0xf6
function private function_80f792a0() {
    self endon(#"death");
    self.var_74ce5898 = 1;
    self waittill(#"is_underground");
    spawn_point = self.ai_zone.spawn_points[randomint(self.ai_zone.spawn_points.size)];
    if (!isdefined(spawn_point)) {
        self kill();
    }
    wait 2;
    self forceteleport(spawn_point.origin, spawn_point.angles);
    wait 2;
    self.var_25c0e873 = 1;
    self waittill(#"not_underground");
    self.var_b4458b4b = 1;
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 0, eflags: 0x0
// Checksum 0x8ad67ce, Offset: 0x2c38
// Size: 0x84
function delayed_zombie_eye_glow() {
    self endon(#"death");
    if (isdefined(self.in_the_ground) && self.in_the_ground || isdefined(self.in_the_ceiling) && self.in_the_ceiling) {
        while (!isdefined(self.create_eyes)) {
            wait 0.1;
        }
    } else {
        wait 0.5;
    }
    self zombie_eye_glow();
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 0, eflags: 0x0
// Checksum 0xfc9ab97b, Offset: 0x2cc8
// Size: 0x64
function zombie_eye_glow() {
    if (!isdefined(self) || !isactor(self)) {
        return;
    }
    if (!(isdefined(self.no_eye_glow) && self.no_eye_glow)) {
        self clientfield::set("zombie_has_eyes", 1);
    }
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 0, eflags: 0x0
// Checksum 0x50491a07, Offset: 0x2d38
// Size: 0x64
function zombie_eye_glow_stop() {
    if (!isdefined(self) || !isactor(self)) {
        return;
    }
    if (!(isdefined(self.no_eye_glow) && self.no_eye_glow)) {
        self clientfield::set("zombie_has_eyes", 0);
    }
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 1, eflags: 0x0
// Checksum 0x2a5309a6, Offset: 0x2da8
// Size: 0x24
function zombie_death_event(params) {
    self zombie_eye_glow_stop();
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 0, eflags: 0x0
// Checksum 0x20e7137f, Offset: 0x2dd8
// Size: 0xc0
function zombie_gib_on_damage() {
    self endon(#"death");
    while (true) {
        waitresult = self waittill(#"damage");
        self thread zombie_gib(waitresult.amount, waitresult.attacker, waitresult.direction, waitresult.position, waitresult.mod, waitresult.tag_name, waitresult.model_name, waitresult.part_name, waitresult.weapon);
    }
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 9, eflags: 0x0
// Checksum 0x13fb35c9, Offset: 0x2ea0
// Size: 0x468
function zombie_gib(amount, attacker, direction_vec, point, type, tagname, modelname, partname, weapon) {
    if (!isdefined(self)) {
        return;
    }
    if (!self zombie_should_gib(amount, attacker, type)) {
        return;
    }
    if (self head_should_gib(attacker, type, point) && type != "MOD_BURNED") {
        self zombie_head_gib(attacker, type);
        return;
    }
    if (!(isdefined(self.gibbed) && self.gibbed) && isdefined(self.damagelocation)) {
        if (self.damagelocation == "head" || self.damagelocation == "helmet" || self.damagelocation == "neck") {
            return;
        }
        switch (self.damagelocation) {
        case #"torso_upper":
        case #"torso_lower":
            if (!gibserverutils::isgibbed(self, 32)) {
                gibserverutils::gibrightarm(self);
            }
            break;
        case #"right_arm_lower":
        case #"right_arm_upper":
        case #"right_hand":
            if (!gibserverutils::isgibbed(self, 32)) {
                gibserverutils::gibrightarm(self);
            }
            break;
        case #"left_arm_lower":
        case #"left_arm_upper":
        case #"left_hand":
            if (!gibserverutils::isgibbed(self, 16)) {
                gibserverutils::gibleftarm(self);
            }
            break;
        case #"right_leg_upper":
        case #"left_leg_lower":
        case #"right_leg_lower":
        case #"left_foot":
        case #"right_foot":
        case #"left_leg_upper":
            break;
        default:
            if (self.damagelocation == "none") {
                if (type == "MOD_GRENADE" || type == "MOD_GRENADE_SPLASH" || type == "MOD_PROJECTILE" || type == "MOD_PROJECTILE_SPLASH") {
                    self derive_damage_refs(point);
                    break;
                }
            }
            break;
        }
        if (isdefined(self.missinglegs) && self.missinglegs && self.health > 0) {
            level notify(#"crawler_created", {#zombie:self, #player:attacker, #weapon:weapon});
            self allowedstances("crouch");
            self setphysparams(15, 0, 24);
            self allowpitchangle(1);
            self setpitchorient();
            health = self.health;
            health *= 0.1;
        }
    }
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 1, eflags: 0x0
// Checksum 0x35cf2736, Offset: 0x3310
// Size: 0x33c
function derive_damage_refs(point) {
    if (!isdefined(level.gib_tags)) {
        init_gib_tags();
    }
    closesttag = undefined;
    for (i = 0; i < level.gib_tags.size; i++) {
        if (!isdefined(closesttag)) {
            closesttag = level.gib_tags[i];
            continue;
        }
        if (distancesquared(point, self gettagorigin(level.gib_tags[i])) < distancesquared(point, self gettagorigin(closesttag))) {
            closesttag = level.gib_tags[i];
        }
    }
    if (closesttag == "J_SpineLower" || closesttag == "J_SpineUpper" || closesttag == "J_Spine4") {
        gibserverutils::gibrightarm(self);
        return;
    }
    if (closesttag == "J_Shoulder_LE" || closesttag == "J_Elbow_LE" || closesttag == "J_Wrist_LE") {
        if (!gibserverutils::isgibbed(self, 16)) {
            gibserverutils::gibleftarm(self);
        }
        return;
    }
    if (closesttag == "J_Shoulder_RI" || closesttag == "J_Elbow_RI" || closesttag == "J_Wrist_RI") {
        if (!gibserverutils::isgibbed(self, 32)) {
            gibserverutils::gibrightarm(self);
        }
        return;
    }
    if (closesttag == "J_Hip_LE" || closesttag == "J_Knee_LE" || closesttag == "J_Ankle_LE") {
        gibserverutils::gibleftleg(self);
        if (randomint(100) > 75) {
            gibserverutils::gibrightleg(self);
        }
        self function_9c628842(1);
        return;
    }
    if (closesttag == "J_Hip_RI" || closesttag == "J_Knee_RI" || closesttag == "J_Ankle_RI") {
        gibserverutils::gibrightleg(self);
        if (randomint(100) > 75) {
            gibserverutils::gibleftleg(self);
        }
        self function_9c628842(1);
    }
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 0, eflags: 0x0
// Checksum 0x35c74b28, Offset: 0x3658
// Size: 0x14e
function init_gib_tags() {
    tags = [];
    tags[tags.size] = "J_SpineLower";
    tags[tags.size] = "J_SpineUpper";
    tags[tags.size] = "J_Spine4";
    tags[tags.size] = "J_Shoulder_LE";
    tags[tags.size] = "J_Elbow_LE";
    tags[tags.size] = "J_Wrist_LE";
    tags[tags.size] = "J_Shoulder_RI";
    tags[tags.size] = "J_Elbow_RI";
    tags[tags.size] = "J_Wrist_RI";
    tags[tags.size] = "J_Hip_LE";
    tags[tags.size] = "J_Knee_LE";
    tags[tags.size] = "J_Ankle_LE";
    tags[tags.size] = "J_Hip_RI";
    tags[tags.size] = "J_Knee_RI";
    tags[tags.size] = "J_Ankle_RI";
    level.gib_tags = tags;
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 1, eflags: 0x0
// Checksum 0xab4a0463, Offset: 0x37b0
// Size: 0x3a
function function_9c628842(missinglegs = 0) {
    if (missinglegs) {
        self.knockdown = 0;
    }
    self.missinglegs = missinglegs;
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 3, eflags: 0x0
// Checksum 0xf12385f4, Offset: 0x37f8
// Size: 0x270
function zombie_should_gib(amount, attacker, type) {
    if (!isdefined(type)) {
        return false;
    }
    if (isdefined(self.is_on_fire) && self.is_on_fire) {
        return false;
    }
    if (isdefined(self.no_gib) && self.no_gib == 1) {
        return false;
    }
    prev_health = amount + self.health;
    if (prev_health <= 0) {
        prev_health = 1;
    }
    damage_percent = amount / prev_health * 100;
    weapon = undefined;
    if (isdefined(attacker)) {
        if (isplayer(attacker) || isdefined(attacker.can_gib_zombies) && attacker.can_gib_zombies) {
            if (isplayer(attacker)) {
                weapon = attacker getcurrentweapon();
            } else {
                weapon = attacker.weapon;
            }
        }
    }
    switch (type) {
    case #"mod_telefrag":
    case #"mod_unknown":
    case #"mod_burned":
    case #"mod_trigger_hurt":
    case #"mod_suicide":
    case #"mod_falling":
        return false;
    case #"mod_melee":
        return false;
    }
    if (type == "MOD_PISTOL_BULLET" || type == "MOD_RIFLE_BULLET") {
        if (!isdefined(attacker) || !isplayer(attacker)) {
            return false;
        }
        if (weapon == level.weaponnone || isdefined(level.start_weapon) && weapon == level.start_weapon || weapon.isgasweapon) {
            return false;
        }
    }
    return true;
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 3, eflags: 0x0
// Checksum 0x39f222b2, Offset: 0x3a70
// Size: 0x30e
function head_should_gib(attacker, type, point) {
    if (isdefined(self.head_gibbed) && self.head_gibbed) {
        return false;
    }
    if (!isdefined(attacker) || !isplayer(attacker)) {
        if (!(isdefined(attacker.can_gib_zombies) && attacker.can_gib_zombies)) {
            return false;
        }
    }
    if (isplayer(attacker)) {
        weapon = attacker getcurrentweapon();
    } else {
        weapon = attacker.weapon;
    }
    if (type != "MOD_RIFLE_BULLET" && type != "MOD_PISTOL_BULLET") {
        if (type == "MOD_GRENADE" || type == "MOD_GRENADE_SPLASH") {
            if (distance(point, self gettagorigin("j_head")) > 55) {
                return false;
            } else {
                return true;
            }
        } else if (type == "MOD_PROJECTILE") {
            if (distance(point, self gettagorigin("j_head")) > 10) {
                return false;
            } else {
                return true;
            }
        } else if (weapon.weapclass != "spread") {
            return false;
        }
    }
    if (!(self.damagelocation == "head" || self.damagelocation == "helmet" || self.damagelocation == "neck")) {
        return false;
    }
    if (type == "MOD_PISTOL_BULLET" && weapon.weapclass != "smg" || weapon == level.weaponnone || isdefined(level.start_weapon) && weapon == level.start_weapon || weapon.isgasweapon) {
        return false;
    }
    if (sessionmodeiscampaigngame() && type == "MOD_PISTOL_BULLET" && weapon.weapclass != "smg") {
        return false;
    }
    low_health_percent = self.health / self.maxhealth * 100;
    if (low_health_percent > 10) {
        return false;
    }
    return true;
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 2, eflags: 0x0
// Checksum 0x146ca578, Offset: 0x3d88
// Size: 0xd4
function zombie_head_gib(attacker, means_of_death) {
    self endon(#"death");
    if (isdefined(self.head_gibbed) && self.head_gibbed) {
        return;
    }
    self.head_gibbed = 1;
    self zombie_eye_glow_stop();
    if (!(isdefined(self.disable_head_gib) && self.disable_head_gib)) {
        gibserverutils::gibhead(self);
    }
    self thread damage_over_time(ceil(self.health * 0.2), 1, attacker, means_of_death);
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 4, eflags: 0x0
// Checksum 0x49f064c8, Offset: 0x3e68
// Size: 0x148
function damage_over_time(dmg, delay, attacker, means_of_death) {
    self endon(#"death");
    self endon(#"exploding");
    if (!isalive(self)) {
        return;
    }
    if (!isplayer(attacker)) {
        attacker = self;
    }
    if (!isdefined(means_of_death)) {
        means_of_death = "MOD_UNKNOWN";
    }
    while (true) {
        if (isdefined(delay)) {
            wait delay;
        }
        if (isdefined(self)) {
            if (isdefined(attacker)) {
                self dodamage(dmg, self gettagorigin("j_neck"), attacker, self, self.damagelocation, means_of_death, 4096, self.damageweapon);
                continue;
            }
            self dodamage(dmg, self gettagorigin("j_neck"));
        }
    }
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 2, eflags: 0x0
// Checksum 0x6c1801a1, Offset: 0x3fb8
// Size: 0xdc
function function_d41270e(str_zone, v_loc) {
    e_pickup = spawn("script_model", v_loc);
    e_pickup setmodel(#"p7_zm_power_up_max_ammo");
    e_pickup playsound(#"zmb_spawn_powerup");
    e_pickup playloopsound(#"zmb_spawn_powerup_loop");
    e_pickup thread powerup_wobble();
    e_pickup thread powerup_timeout();
    e_pickup thread function_c3290a74(str_zone);
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 1, eflags: 0x0
// Checksum 0xe39149db, Offset: 0x40a0
// Size: 0x1ae
function function_c3290a74(str_zone) {
    self endon(#"powerup_grabbed", #"powerup_timedout", #"death");
    while (true) {
        e_player = wz_ai_utils::get_closest_player(str_zone, self.origin);
        if (isdefined(e_player)) {
            n_dist = distance(self.origin, e_player.origin);
            if (n_dist < 80) {
                a_weapons = e_player getweaponslistprimaries();
                foreach (weapon in a_weapons) {
                    e_player setweaponammoclip(weapon, weapon.clipsize);
                    e_player givestartammo(weapon);
                }
                e_player playsound(#"zmb_powerup_grabbed");
                self delete();
            }
        }
        waitframe(1);
    }
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 0, eflags: 0x0
// Checksum 0x2c6994b8, Offset: 0x4258
// Size: 0x198
function powerup_wobble() {
    self endon(#"powerup_grabbed", #"powerup_timedout", #"death");
    playfxontag(#"zombie/fx_powerup_on_green_zmb", self, "tag_origin");
    while (true) {
        waittime = randomfloatrange(2.5, 5);
        yaw = randomint(360);
        if (yaw > 300) {
            yaw = 300;
        } else if (yaw < 60) {
            yaw = 60;
        }
        yaw = self.angles[1] + yaw;
        new_angles = (-60 + randomint(120), yaw, -45 + randomint(90));
        self rotateto(new_angles, waittime, waittime * 0.5, waittime * 0.5);
        wait randomfloat(waittime - 0.1);
    }
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 0, eflags: 0x0
// Checksum 0xf2c49c10, Offset: 0x43f8
// Size: 0x8c
function powerup_timeout() {
    self endon(#"powerup_grabbed", #"death", #"powerup_reset");
    self show();
    wait 15;
    self hide_and_show();
    self notify(#"powerup_timedout");
    self delete();
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 0, eflags: 0x0
// Checksum 0xefef3cd, Offset: 0x4490
// Size: 0xae
function hide_and_show() {
    self endon(#"death");
    for (i = 0; i < 40; i++) {
        if (i % 2) {
            self ghost();
        } else {
            self show();
        }
        if (i < 15) {
            wait 0.5;
            continue;
        }
        if (i < 25) {
            wait 0.25;
            continue;
        }
        wait 0.1;
    }
}

// Namespace wz_ai_zombie/bhtn_action_start
// Params 1, eflags: 0x40
// Checksum 0x8c5fdb4f, Offset: 0x4548
// Size: 0x222
function event_handler[bhtn_action_start] function_4ab896ed(eventstruct) {
    notify_string = eventstruct.action;
    switch (notify_string) {
    case #"death":
        level thread zmbaivox_playvox(self, notify_string, 1, 4);
        break;
    case #"pain":
        level thread zmbaivox_playvox(self, notify_string, 1, 3);
        break;
    case #"behind":
        level thread zmbaivox_playvox(self, notify_string, 1, 3);
        break;
    case #"attack_melee_notetrack":
        level thread zmbaivox_playvox(self, "attack_melee", 1, 2, 1);
        break;
    case #"chase_state_start":
        level thread zmbaivox_playvox(self, "sprint", 1, 2);
        break;
    case #"sprint":
    case #"ambient":
    case #"crawler":
    case #"teardown":
    case #"taunt":
        level thread zmbaivox_playvox(self, notify_string, 0, 1);
        break;
    case #"attack_melee":
        break;
    default:
        level thread zmbaivox_playvox(self, notify_string, 0, 2);
        break;
    }
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 5, eflags: 0x0
// Checksum 0xd26f2c41, Offset: 0x4778
// Size: 0x356
function zmbaivox_playvox(zombie, type, override, priority, delayambientvox = 0) {
    zombie endon(#"death");
    if (!isdefined(zombie)) {
        return;
    }
    if (!isdefined(zombie.voiceprefix)) {
        return;
    }
    if (!isdefined(priority)) {
        priority = 1;
    }
    if (!isdefined(zombie.talking)) {
        zombie.talking = 0;
    }
    if (!isdefined(zombie.currentvoxpriority)) {
        zombie.currentvoxpriority = 1;
    }
    if (!isdefined(self.delayambientvox)) {
        self.delayambientvox = 0;
    }
    if ((type == "ambient" || type == "sprint" || type == "crawler") && isdefined(self.delayambientvox) && self.delayambientvox) {
        return;
    }
    if (delayambientvox) {
        self.delayambientvox = 1;
        self thread zmbaivox_ambientdelay();
    }
    alias = "zmb_vocals_" + zombie.voiceprefix + "_" + type;
    if (sndisnetworksafe()) {
        if (isdefined(override) && override) {
            if (isdefined(zombie.currentvox) && priority >= zombie.currentvoxpriority) {
                zombie stopsound(zombie.currentvox);
            }
            if (type == "death" || type == "death_whimsy" || type == "death_nohead") {
                zombie playsound(alias);
                return;
            }
        }
        if (zombie.talking === 1 && (priority < zombie.currentvoxpriority || priority === 1)) {
            return;
        }
        zombie.talking = 1;
        zombie.currentvox = alias;
        zombie.currentvoxpriority = priority;
        zombie playsoundontag(alias, "j_head");
        playbacktime = soundgetplaybacktime(alias);
        if (!isdefined(playbacktime)) {
            playbacktime = 1;
        }
        if (playbacktime >= 0) {
            playbacktime *= 0.001;
        } else {
            playbacktime = 1;
        }
        wait playbacktime;
        zombie.talking = 0;
        zombie.currentvox = undefined;
        zombie.currentvoxpriority = 1;
    }
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 0, eflags: 0x0
// Checksum 0xb7249fb4, Offset: 0x4ad8
// Size: 0x5a
function zmbaivox_ambientdelay() {
    self notify(#"sndambientdelay");
    self endon(#"sndambientdelay");
    self endon(#"death");
    self endon(#"disconnect");
    wait 2;
    self.delayambientvox = 0;
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 0, eflags: 0x0
// Checksum 0x4666dbe, Offset: 0x4b40
// Size: 0x24
function networksafereset() {
    while (true) {
        level._numzmbaivox = 0;
        waitframe(1);
    }
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 0, eflags: 0x0
// Checksum 0x317a5d7b, Offset: 0x4b70
// Size: 0x54
function sndisnetworksafe() {
    if (!isdefined(level._numzmbaivox)) {
        level thread networksafereset();
    }
    if (level._numzmbaivox >= 2) {
        return false;
    }
    level._numzmbaivox++;
    return true;
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 0, eflags: 0x0
// Checksum 0xcfdb36cf, Offset: 0x4bd0
// Size: 0x34
function function_777fe596() {
    self thread play_ambient_zombie_vocals();
    self thread zmbaivox_playdeath();
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 0, eflags: 0x0
// Checksum 0xb89a96a, Offset: 0x4c10
// Size: 0x158
function play_ambient_zombie_vocals() {
    self endon(#"death");
    self thread function_b3cd786a();
    while (true) {
        type = "ambient";
        float = 3;
        if (isdefined(self.aistate)) {
            switch (self.aistate) {
            case 0:
            case 1:
            case 2:
            case 4:
                type = "ambient";
                float = 3;
                break;
            case 3:
                type = "sprint";
                float = 3;
                break;
            }
        }
        bhtnactionstartevent(self, type);
        self notify(#"bhtn_action_notify", {#action:type});
        wait randomfloatrange(1, float);
    }
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 0, eflags: 0x0
// Checksum 0x7e1890bc, Offset: 0x4d70
// Size: 0x54
function zmbaivox_playdeath() {
    self endon(#"disconnect");
    self waittill(#"death");
    if (isdefined(self)) {
        level thread zmbaivox_playvox(self, "death", 1);
    }
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 0, eflags: 0x0
// Checksum 0x2e841af6, Offset: 0x4dd0
// Size: 0x78
function function_b3cd786a() {
    self endon(#"death");
    self endon(#"disconnect");
    while (true) {
        self waittill(#"reset_pathing");
        if (self.aistate == 3) {
            bhtnactionstartevent(self, "chase_state_start");
        }
    }
}

