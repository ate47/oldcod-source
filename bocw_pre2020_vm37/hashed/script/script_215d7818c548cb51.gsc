#using script_113dd7f0ea2a1d4f;
#using script_3751b21462a54a7d;
#using script_4364094db7b986ff;
#using script_7963da8c5cf62922;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\item_inventory;
#using scripts\core_common\system_shared;

#namespace namespace_77bd50da;

// Namespace namespace_77bd50da/namespace_77bd50da
// Params 0, eflags: 0x6
// Checksum 0x3248472b, Offset: 0xa0
// Size: 0x4c
function private autoexec __init__system__() {
    system::register(#"hash_7b30b3878fc15536", &function_70a657d8, &postinit, undefined, undefined);
}

// Namespace namespace_77bd50da/namespace_77bd50da
// Params 0, eflags: 0x1 linked
// Checksum 0x8c085574, Offset: 0xf8
// Size: 0x7c
function function_70a657d8() {
    level.var_90456892 = sr_message_box::register();
    if (!isdefined(level.var_31028c5d)) {
        level.var_31028c5d = prototype_hud::register();
    }
    level.var_a8831379 = namespace_84845aec::register();
    callback::on_spawned(&on_player_spawned);
}

// Namespace namespace_77bd50da/namespace_77bd50da
// Params 0, eflags: 0x1 linked
// Checksum 0x80f724d1, Offset: 0x180
// Size: 0x4
function postinit() {
    
}

// Namespace namespace_77bd50da/namespace_77bd50da
// Params 0, eflags: 0x1 linked
// Checksum 0xc744fcd1, Offset: 0x190
// Size: 0x1c
function on_player_spawned() {
    self function_2778528();
}

// Namespace namespace_77bd50da/namespace_77bd50da
// Params 0, eflags: 0x5 linked
// Checksum 0x778b1f6a, Offset: 0x1b8
// Size: 0xf2
function private function_2778528() {
    if (!isplayer(self)) {
        return;
    }
    if (!level.var_31028c5d prototype_hud::is_open(self)) {
        level.var_31028c5d prototype_hud::open(self, 1);
    }
    if (isdefined(level.var_8a13c98f)) {
        i = 1;
        foreach (s_objective in level.var_8a13c98f) {
            i++;
        }
    }
}

// Namespace namespace_77bd50da/namespace_77bd50da
// Params 2, eflags: 0x1 linked
// Checksum 0x8cab9ddf, Offset: 0x2b8
// Size: 0x124
function function_cc8342e0(string = #"hash_6c919cffb550417a", opentime = 10) {
    level endon(#"game_ended");
    self endon(#"death");
    if (!isplayer(self)) {
        return;
    }
    if (!level.var_90456892 sr_message_box::is_open(self)) {
        level.var_90456892 sr_message_box::open(self);
        level.var_90456892 sr_message_box::function_7a690474(self, string);
    } else {
        return;
    }
    wait opentime;
    if (level.var_90456892 sr_message_box::is_open(self)) {
        level.var_90456892 sr_message_box::close(self);
    }
}

