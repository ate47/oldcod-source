#using scripts\core_common\callbacks_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\system_shared;

#namespace namespace_5862fe7d;

// Namespace namespace_5862fe7d/namespace_5862fe7d
// Params 0, eflags: 0x6
// Checksum 0x83cfcd5c, Offset: 0xf0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_2fb866b9ca52ea3c", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace namespace_5862fe7d/namespace_5862fe7d
// Params 0, eflags: 0x4
// Checksum 0xd0d84232, Offset: 0x138
// Size: 0x64
function private function_70a657d8() {
    callback::add_callback(#"hash_6adbe5700aba9035", &function_376874e9);
    callback::add_callback(#"hash_1002f619f2d58b36", &function_ba5141a9);
}

// Namespace namespace_5862fe7d/namespace_5862fe7d
// Params 1, eflags: 0x4
// Checksum 0x51344a4c, Offset: 0x1a8
// Size: 0x94
function private function_376874e9(var_9bbce2cd) {
    bomb = spawn_bomb(var_9bbce2cd.var_b16c122);
    bomb.var_9bbce2cd = var_9bbce2cd;
    var_9bbce2cd.dirtybomb = bomb;
    setbombtimer("A", 0);
    setmatchflag("bomb_timer_a", 0);
    setclientnamemode("manual_change");
}

// Namespace namespace_5862fe7d/namespace_5862fe7d
// Params 1, eflags: 0x4
// Checksum 0xc316427e, Offset: 0x248
// Size: 0x74
function private function_ba5141a9(var_9bbce2cd) {
    bomb = var_9bbce2cd.dirtybomb;
    if (isdefined(bomb) && !is_true(bomb.armed)) {
        var_9bbce2cd.dirtybomb = undefined;
        bomb gameobjects::destroy_object(1);
    }
}

// Namespace namespace_5862fe7d/namespace_5862fe7d
// Params 1, eflags: 0x4
// Checksum 0xad48f2c2, Offset: 0x2c8
// Size: 0x94
function private function_854de785(activator) {
    level endon(#"game_ended");
    level thread function_a6b59237(self, activator.team, 90);
    callback::callback(#"hash_179603173879ec50", {#bomb:self, #activator:activator});
}

// Namespace namespace_5862fe7d/namespace_5862fe7d
// Params 3, eflags: 0x4
// Checksum 0xa48e919f, Offset: 0x368
// Size: 0xec
function private function_a6b59237(bomb, team, *var_5cd62cb9) {
    level endon(#"game_ended");
    team.armed = 1;
    team gameobjects::disable_object(0, 1);
    level function_674b83d5(90);
    objid = level function_766266a3(team.origin, var_5cd62cb9);
    wait 90;
    setgameendtime(0);
    function_2bdc0fe9(objid);
    level thread function_e2cbe93c(team);
}

// Namespace namespace_5862fe7d/namespace_5862fe7d
// Params 2, eflags: 0x4
// Checksum 0x9df7c5a8, Offset: 0x460
// Size: 0x90
function private function_766266a3(origin, team) {
    objid = gameobjects::get_next_obj_id();
    objective_add(objid, "active", origin, #"hash_410120703c9f0e46");
    objective_setteam(objid, team);
    objective_setgamemodeflags(objid, 1);
    return objid;
}

// Namespace namespace_5862fe7d/namespace_5862fe7d
// Params 1, eflags: 0x4
// Checksum 0x81b95b2f, Offset: 0x4f8
// Size: 0x3c
function private function_2bdc0fe9(objid) {
    objective_delete(objid);
    gameobjects::release_obj_id(objid);
}

// Namespace namespace_5862fe7d/namespace_5862fe7d
// Params 1, eflags: 0x4
// Checksum 0xf8ee590c, Offset: 0x540
// Size: 0xc4
function private function_674b83d5(var_5cd62cb9) {
    level.timelimitoverride = 1;
    setgameendtime(gettime() + int(var_5cd62cb9 * 1000));
    setmatchflag("bomb_timer_a", 1);
    setbombtimer("A", gettime() + int(var_5cd62cb9 * 1000));
    setmatchflag("bomb_timer_a", 1);
}

// Namespace namespace_5862fe7d/namespace_5862fe7d
// Params 1, eflags: 0x4
// Checksum 0xd69f74f3, Offset: 0x610
// Size: 0x1f4
function private function_e2cbe93c(bomb) {
    x = bomb.origin[0];
    y = bomb.origin[1];
    foreach (player in getplayers()) {
        var_98b02a87 = player getplayerviewheight();
        eye = player.origin + (0, 0, var_98b02a87);
        var_3c620b55 = (x, y, eye[2]);
        offset = vectornormalize(var_3c620b55 - eye) * 200;
        ent = playsoundatposition(#"hash_347fbe348869aaa7", player.origin + offset);
        ent hide();
        ent showtoplayer(player);
    }
    callback::callback(#"hash_de3a4366fb5979e", bomb);
    waitframe(1);
    if (isdefined(bomb)) {
        bomb gameobjects::destroy_object(1);
    }
}

// Namespace namespace_5862fe7d/namespace_5862fe7d
// Params 1, eflags: 0x4
// Checksum 0x4bd5c65a, Offset: 0x810
// Size: 0x1de
function private spawn_bomb(origin) {
    trace = ground_trace(origin);
    var_5c49bd45 = trace[#"position"];
    trigger = spawn("trigger_radius_use", var_5c49bd45 + (0, 0, 32), 0, 94, 64, 1);
    trigger triggerignoreteam();
    trigger setteamfortrigger(#"none");
    trigger setcursorhint("HINT_INTERACTIVE_PROMPT");
    var_ac21a084 = spawn("script_model", var_5c49bd45);
    var_ac21a084 setmodel(#"wpn_t8_eqp_briefcase_bomb_view");
    bomb = gameobjects::create_use_object(#"none", trigger, array(var_ac21a084), (0, 0, 0), #"hash_4437efa9407ac3b2", 1);
    bomb gameobjects::allow_use(#"hash_5ccfd7bbbf07c770");
    bomb gameobjects::set_use_time(15);
    bomb.onuse_thread = 1;
    bomb.onuse = &function_854de785;
    return bomb;
}

// Namespace namespace_5862fe7d/namespace_5862fe7d
// Params 1, eflags: 0x4
// Checksum 0xe17a9c09, Offset: 0x9f8
// Size: 0x52
function private ground_trace(origin) {
    return groundtrace(origin + (0, 0, 20000), origin + (0, 0, -10000), 0, undefined);
}

