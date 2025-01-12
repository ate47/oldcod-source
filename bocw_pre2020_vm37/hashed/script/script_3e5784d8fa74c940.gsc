#using script_24c32478acf44108;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\weapons\weaponobjects;
#using scripts\zm_common\zm_weapons;

#namespace namespace_a5ef5769;

// Namespace namespace_a5ef5769/namespace_a5ef5769
// Params 0, eflags: 0x6
// Checksum 0xea3def3c, Offset: 0x140
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_52556758a0c8acfe", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace namespace_a5ef5769/namespace_a5ef5769
// Params 0, eflags: 0x5 linked
// Checksum 0xa18c9339, Offset: 0x188
// Size: 0x1bc
function private function_70a657d8() {
    level.var_db785e13 = getweapon(#"ww_ray_rifle_t9");
    level.var_a467bdbc = getweapon(#"hash_ac86d29509a8939");
    weaponobjects::function_e6400478(#"ww_ray_rifle_t9", &function_a849d64f, 1);
    zombie_utility::add_zombie_gib_weapon_callback(#"hash_ac86d29509a8939", &function_81027f3e, &function_81027f3e);
    clientfield::register("scriptmover", "" + #"hash_47e7d5219a26a786", 1, 2, "int");
    clientfield::register("actor", "" + #"hash_3a47820a21ce3170", 1, 1, "int");
    namespace_9ff9f642::register_slowdown(#"hash_5c37161904f4bcc9", 0.8, 1);
    callback::on_weapon_change(&function_54e9969b);
    callback::on_ai_killed(&function_65ba5ec2);
}

// Namespace namespace_a5ef5769/namespace_a5ef5769
// Params 1, eflags: 0x1 linked
// Checksum 0x73370c17, Offset: 0x350
// Size: 0x7a
function function_2715ee2d(weapon) {
    if (isdefined(weapon)) {
        var_1236db9d = zm_weapons::function_386dacbc(weapon).name;
        if (var_1236db9d === #"ww_ray_rifle_t9" || var_1236db9d === #"hash_ac86d29509a8939") {
            return true;
        }
    }
    return false;
}

// Namespace namespace_a5ef5769/namespace_a5ef5769
// Params 1, eflags: 0x1 linked
// Checksum 0xb6eaca1c, Offset: 0x3d8
// Size: 0xd4
function function_54e9969b(params) {
    if (function_2715ee2d(params.weapon) && !function_2715ee2d(params.last_weapon)) {
        self setactionslot(1, "altmode");
        return;
    }
    if (!function_2715ee2d(params.weapon) && function_2715ee2d(params.last_weapon)) {
        self setactionslot(1, "");
    }
}

// Namespace namespace_a5ef5769/namespace_a5ef5769
// Params 1, eflags: 0x1 linked
// Checksum 0x626fffa9, Offset: 0x4b8
// Size: 0xe
function function_81027f3e(*damage_percent) {
    return false;
}

// Namespace namespace_a5ef5769/namespace_a5ef5769
// Params 1, eflags: 0x1 linked
// Checksum 0x386e8a24, Offset: 0x4d0
// Size: 0x22
function function_a849d64f(watcher) {
    watcher.onspawn = &function_a29349e5;
}

// Namespace namespace_a5ef5769/namespace_a5ef5769
// Params 2, eflags: 0x1 linked
// Checksum 0x6dd36eae, Offset: 0x500
// Size: 0x2c
function function_a29349e5(*watcher, player) {
    self thread function_8376de9c(player);
}

// Namespace namespace_a5ef5769/namespace_a5ef5769
// Params 1, eflags: 0x1 linked
// Checksum 0x76ea50f2, Offset: 0x538
// Size: 0xa4
function function_8376de9c(owner) {
    self endon(#"hash_6051203740d9c46a");
    self thread function_117f53ee();
    waitresult = self waittill(#"projectile_impact_explode", #"explode");
    if (waitresult._notify == "projectile_impact_explode") {
        function_b80325b1(owner, waitresult.position);
    }
}

// Namespace namespace_a5ef5769/namespace_a5ef5769
// Params 0, eflags: 0x1 linked
// Checksum 0x2e903a52, Offset: 0x5e8
// Size: 0x2e
function function_117f53ee() {
    self waittill(#"death");
    waittillframeend();
    self notify(#"hash_6051203740d9c46a");
}

// Namespace namespace_a5ef5769/namespace_a5ef5769
// Params 2, eflags: 0x1 linked
// Checksum 0xb5ecce42, Offset: 0x620
// Size: 0x1dc
function function_b80325b1(owner, position) {
    dir_up = (0, 0, 1);
    var_7ef7dc23 = spawn("script_model", position);
    var_7ef7dc23 setmodel("tag_origin");
    var_7ef7dc23.var_745ae857 = 0;
    var_7ef7dc23.var_669f67cf = 0;
    var_7ef7dc23.exploded = 0;
    var_7ef7dc23.var_bc60b6e0 = 1;
    var_7ef7dc23 function_b198b062(1);
    var_b7c37f0f = 131072 | 524288 | 1048576 | 2097152 | 4194304 | 8388608 | 16777216;
    var_7ef7dc23.var_fcefdef4 = spawn("trigger_damage", position, var_b7c37f0f, 100, 100);
    if (isdefined(owner)) {
        var_7ef7dc23 setteam(owner.team);
        if (isplayer(owner)) {
            var_7ef7dc23 setowner(owner);
        }
    }
    /#
        var_7ef7dc23 function_6a0ad00("<dev string:x38>");
    #/
    var_7ef7dc23 thread function_d60a354c();
    var_7ef7dc23 thread function_646f5566();
    var_7ef7dc23 thread function_70240b1b();
}

// Namespace namespace_a5ef5769/namespace_a5ef5769
// Params 0, eflags: 0x1 linked
// Checksum 0xf53a41c8, Offset: 0x808
// Size: 0xda
function function_646f5566() {
    level endon(#"end_game");
    self endon(#"death");
    while (true) {
        s_notify = self.var_fcefdef4 waittill(#"damage");
        if (function_2715ee2d(s_notify.weapon)) {
            if (self.var_669f67cf == 0) {
                self notify(#"ray_hit");
            }
            self.var_669f67cf++;
            if (self.var_669f67cf >= 10) {
                self function_a0ef7452();
                break;
            }
        }
        waitframe(1);
    }
}

// Namespace namespace_a5ef5769/namespace_a5ef5769
// Params 0, eflags: 0x1 linked
// Checksum 0xf63e726c, Offset: 0x8f0
// Size: 0x1fc
function function_a0ef7452() {
    /#
        self function_6a0ad00("<dev string:x4a>");
    #/
    if (!is_true(self.exploded)) {
        self.exploded = 1;
        targets = getentitiesinradius(self.origin, 500, 15);
        foreach (ai in targets) {
            if (!isdefined(ai) || ai.archetype !== #"zombie" && ai.archetype !== #"zombie_dog" && ai.archetype !== #"nova_crawler" || ai getteam() !== level.zombie_team) {
                continue;
            }
            if (isalive(ai)) {
                ai dodamage(500, self.origin, self.owner, undefined, undefined, "MOD_EXPLOSIVE");
            }
        }
    }
    self function_b198b062(3);
    self thread function_e7714941();
}

// Namespace namespace_a5ef5769/namespace_a5ef5769
// Params 0, eflags: 0x1 linked
// Checksum 0x1e1a1060, Offset: 0xaf8
// Size: 0x134
function function_d60a354c() {
    level endon(#"end_game");
    self endon(#"death");
    waitresult = self waittilltimeout(3, #"ray_hit");
    if (waitresult._notify !== "ray_hit") {
        /#
            self function_6a0ad00("<dev string:x5d>");
        #/
        self function_b198b062(0);
        self thread function_e7714941();
        return;
    }
    /#
        self function_6a0ad00("<dev string:x7c>");
    #/
    self function_b198b062(2);
    self thread function_f2ccb676();
    wait 3;
    if (isdefined(self)) {
        self function_a0ef7452();
    }
}

// Namespace namespace_a5ef5769/namespace_a5ef5769
// Params 0, eflags: 0x1 linked
// Checksum 0xc6b58395, Offset: 0xc38
// Size: 0x94
function function_e7714941() {
    level endon(#"end_game");
    wait 1;
    /#
        if (isdefined(self)) {
            self function_6a0ad00("<dev string:x98>");
        }
    #/
    if (isdefined(self.var_fcefdef4)) {
        self.var_fcefdef4 delete();
    }
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace namespace_a5ef5769/namespace_a5ef5769
// Params 0, eflags: 0x1 linked
// Checksum 0x3b5b718e, Offset: 0xcd8
// Size: 0xb6
function function_f2ccb676() {
    level endon(#"end_game");
    self endon(#"death");
    for (var_1c8e3f7d = 0; isdefined(self) && var_1c8e3f7d < 3; var_1c8e3f7d += float(function_60d95f53()) / 1000) {
        self.var_bc60b6e0 = 1 + 4 * var_1c8e3f7d / 3;
        waitframe(1);
    }
}

// Namespace namespace_a5ef5769/namespace_a5ef5769
// Params 0, eflags: 0x1 linked
// Checksum 0x5ba5acf5, Offset: 0xd98
// Size: 0x1ea
function function_70240b1b() {
    level endon(#"end_game");
    self endon(#"death");
    while (isdefined(self)) {
        targets = getentitiesinradius(self.origin, self.var_bc60b6e0 * 100, 15);
        foreach (ai in targets) {
            if (!isdefined(ai) || ai.archetype !== #"zombie" && ai.archetype !== #"zombie_dog" && ai.archetype !== #"nova_crawler" || ai getteam() !== level.zombie_team) {
                continue;
            }
            if (isalive(ai)) {
                ai dodamage(2, self.origin, self.owner, undefined, undefined, "MOD_UNKNOWN");
                ai thread namespace_9ff9f642::slowdown(#"hash_5c37161904f4bcc9");
            }
        }
        wait 1;
    }
}

// Namespace namespace_a5ef5769/namespace_a5ef5769
// Params 1, eflags: 0x1 linked
// Checksum 0x6bd5cb07, Offset: 0xf90
// Size: 0x34
function function_b198b062(stage) {
    self clientfield::set("" + #"hash_47e7d5219a26a786", stage);
}

// Namespace namespace_a5ef5769/namespace_a5ef5769
// Params 1, eflags: 0x1 linked
// Checksum 0x970fd5ce, Offset: 0xfd0
// Size: 0x7c
function function_65ba5ec2(params) {
    if (isdefined(params.weapon) && zm_weapons::function_386dacbc(params.weapon).name === #"ww_ray_rifle_t9") {
        self clientfield::set("" + #"hash_3a47820a21ce3170", 1);
    }
}

/#

    // Namespace namespace_a5ef5769/namespace_a5ef5769
    // Params 2, eflags: 0x0
    // Checksum 0xee2af3c1, Offset: 0x1058
    // Size: 0x8c
    function function_6a0ad00(msg, color = (1, 0, 0)) {
        if (!getdvarint(#"hash_3854586b6f561405", 0)) {
            return;
        }
        print3d(self.origin + (0, 0, 60), msg, color, 1, 1, 10);
    }

#/
