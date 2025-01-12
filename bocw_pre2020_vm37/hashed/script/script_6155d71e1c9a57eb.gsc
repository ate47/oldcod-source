#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_9b972177;

// Namespace namespace_9b972177/namespace_9b972177
// Params 0, eflags: 0x6
// Checksum 0x928e3ec, Offset: 0x1f8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_946f5279d6cd83c", undefined, &function_2a159d3e, undefined, undefined);
}

// Namespace namespace_9b972177/namespace_9b972177
// Params 0, eflags: 0x4
// Checksum 0x6186b678, Offset: 0x240
// Size: 0xa4
function private function_2a159d3e() {
    if (!is_true(level.is_survival)) {
        return;
    }
    callback::on_spawned(&on_player_spawned);
    callback::add_callback(#"hash_17028f0b9883e5be", &function_83b6d24a);
    callback::add_callback(#"objective_ended", &function_2b1da4a6);
}

// Namespace namespace_9b972177/namespace_9b972177
// Params 0, eflags: 0x0
// Checksum 0x8724d581, Offset: 0x2f0
// Size: 0x1c
function on_player_spawned() {
    self thread underscore();
}

// Namespace namespace_9b972177/namespace_9b972177
// Params 1, eflags: 0x0
// Checksum 0xd72a4b93, Offset: 0x318
// Size: 0x7c
function function_83b6d24a(params) {
    if (!isdefined(params)) {
        return;
    }
    if (!isdefined(params.instance)) {
        return;
    }
    str_objective_name = undefined;
    s_instance = params.instance;
    if (isdefined(s_instance.content_script_name)) {
        str_objective_name = s_instance.content_script_name;
    }
    function_df47d1da(str_objective_name);
}

// Namespace namespace_9b972177/namespace_9b972177
// Params 1, eflags: 0x0
// Checksum 0x6590c662, Offset: 0x3a0
// Size: 0x64
function function_2b1da4a6(params) {
    str_objective_name = undefined;
    s_instance = params.instance;
    if (isdefined(s_instance.content_script_name)) {
        str_objective_name = s_instance.content_script_name;
    }
    function_a9cc2e9f(params.completed, str_objective_name);
}

// Namespace namespace_9b972177/namespace_9b972177
// Params 1, eflags: 0x0
// Checksum 0xc1f10795, Offset: 0x410
// Size: 0x15c
function function_df47d1da(str_objective_name) {
    level notify(#"hash_1034af1a853c873d");
    switch (str_objective_name) {
    case #"destroy":
        level thread obj_destroy();
        return;
    case #"kill_hvt":
        var_9c1ed9ea = "obj_huntvip_start";
        break;
    case #"hash_3386f30228d9a983":
        var_9c1ed9ea = "obj_defend_start";
        break;
    case #"hash_3f7125c5b483847f":
        var_9c1ed9ea = "obj_defend_start";
        break;
    case #"hash_401d37614277df42":
        if (math::cointoss()) {
            var_9c1ed9ea = "obj_finalbattle_start";
        } else {
            var_9c1ed9ea = "obj_finalbattle_start_2";
        }
        break;
    default:
        var_9c1ed9ea = "obj_stage_2";
        break;
    }
    function_5d985962(0);
    function_5a47adab(var_9c1ed9ea);
}

// Namespace namespace_9b972177/namespace_9b972177
// Params 2, eflags: 0x0
// Checksum 0xd68d368b, Offset: 0x578
// Size: 0x1dc
function function_a9cc2e9f(b_completed = 1, str_objective_name) {
    level notify(#"hash_27abcd3efcaaf572");
    var_6700857c = 1;
    switch (str_objective_name) {
    case #"destroy":
        var_cb24fe86 = "obj_win";
        var_f96b77d1 = "obj_lose";
        break;
    case #"kill_hvt":
        var_cb24fe86 = "obj_huntvip_end_win";
        var_f96b77d1 = "obj_huntvip_end_lose";
        break;
    case #"hash_3386f30228d9a983":
        var_cb24fe86 = "obj_defend_end_win";
        var_f96b77d1 = "obj_defend_end_lose";
        break;
    case #"hash_3f7125c5b483847f":
        var_cb24fe86 = "obj_win";
        var_f96b77d1 = "obj_lose";
        break;
    case #"hash_401d37614277df42":
        var_cb24fe86 = "obj_finalbattle_end_win";
        var_f96b77d1 = "obj_finalbattle_end_win";
        var_6700857c = 0;
        break;
    default:
        var_cb24fe86 = "obj_win";
        var_f96b77d1 = "obj_lose";
        break;
    }
    if (b_completed) {
        function_5a47adab(var_cb24fe86);
    } else {
        function_5a47adab(var_f96b77d1);
    }
    if (is_true(var_6700857c)) {
        function_5d985962(1);
    }
}

// Namespace namespace_9b972177/namespace_9b972177
// Params 1, eflags: 0x0
// Checksum 0x35631e52, Offset: 0x760
// Size: 0xb6
function function_5d985962(var_b375589a) {
    level.var_b375589a = var_b375589a;
    if (!var_b375589a) {
        foreach (player in level.players) {
            player.var_edc6d524 = "";
            player.var_187e3f7e = "";
        }
    }
}

// Namespace namespace_9b972177/namespace_9b972177
// Params 0, eflags: 0x0
// Checksum 0x3f3ed797, Offset: 0x820
// Size: 0x136
function underscore() {
    self endon(#"death");
    self endon(#"disconnect");
    if (!isdefined(level.var_b375589a)) {
        level.var_b375589a = 0;
    }
    if (!isdefined(self.var_edc6d524)) {
        self.var_edc6d524 = "";
    }
    if (!isdefined(self.var_187e3f7e)) {
        self.var_187e3f7e = "";
    }
    self thread function_28f119be();
    while (true) {
        waitresult = self waittill(#"hash_766bf24383b8f582");
        if (is_true(level.var_b375589a)) {
            if (isdefined(waitresult.var_9c1ed9ea)) {
                self.var_187e3f7e = waitresult.var_9c1ed9ea;
            }
            if (self.var_edc6d524 !== self.var_187e3f7e) {
                set_to_player(self.var_187e3f7e);
                self.var_edc6d524 = self.var_187e3f7e;
            }
        }
    }
}

// Namespace namespace_9b972177/namespace_9b972177
// Params 0, eflags: 0x0
// Checksum 0xd4e52b5c, Offset: 0x960
// Size: 0x1b0
function function_28f119be() {
    self endon(#"death");
    self endon(#"disconnect");
    while (true) {
        if (!is_true(level.var_b375589a)) {
            wait 0.1;
            continue;
        }
        n_counter = 0;
        a_enemies = getaiarray();
        foreach (enemy in a_enemies) {
            if (isdefined(enemy.favoriteenemy)) {
                if (enemy.favoriteenemy == self) {
                    n_counter++;
                }
            }
            if (n_counter >= 5) {
                break;
            }
        }
        if (n_counter >= 5) {
            self notify(#"hash_766bf24383b8f582", {#var_9c1ed9ea:"sr_underscore_active"});
        } else if (n_counter == 0) {
            self notify(#"hash_766bf24383b8f582", {#var_9c1ed9ea:"sr_underscore"});
        }
        wait 5;
    }
}

// Namespace namespace_9b972177/namespace_9b972177
// Params 1, eflags: 0x0
// Checksum 0xe878bf20, Offset: 0xb18
// Size: 0x98
function function_5a47adab(var_9c1ed9ea) {
    foreach (player in level.players) {
        player set_to_player(var_9c1ed9ea);
    }
}

// Namespace namespace_9b972177/namespace_9b972177
// Params 1, eflags: 0x0
// Checksum 0x9c51f675, Offset: 0xbb8
// Size: 0x24
function set_to_player(var_9c1ed9ea) {
    music::setmusicstate(var_9c1ed9ea, self);
}

// Namespace namespace_9b972177/namespace_9b972177
// Params 0, eflags: 0x0
// Checksum 0xe7f6e004, Offset: 0xbe8
// Size: 0x1c
function function_57292af3() {
    function_5a47adab("sr_intro_cutscene");
}

// Namespace namespace_9b972177/namespace_9b972177
// Params 1, eflags: 0x0
// Checksum 0x6290264e, Offset: 0xc10
// Size: 0x3c
function insertion(*var_df887556) {
    level endon(#"hash_1034af1a853c873d");
    wait 5;
    function_5d985962(1);
}

// Namespace namespace_9b972177/namespace_9b972177
// Params 0, eflags: 0x0
// Checksum 0xa616bc98, Offset: 0xc58
// Size: 0x7c
function obj_destroy() {
    level endon(#"hash_27abcd3efcaaf572");
    function_5d985962(0);
    function_5a47adab("obj_start");
    level flag::wait_till(#"assault_start");
    function_5a47adab("obj_stage_2");
}

