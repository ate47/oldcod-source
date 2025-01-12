#using scripts\core_common\callbacks_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;

#namespace rappel;

// Namespace rappel/rappel
// Params 0, eflags: 0x6
// Checksum 0x735b7825, Offset: 0xf0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"rappel", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace rappel/rappel
// Params 0, eflags: 0x5 linked
// Checksum 0xe2c6685, Offset: 0x138
// Size: 0x20c
function private function_70a657d8() {
    level.ascendstarts = struct::get_array("ascend_begin", "script_noteworthy");
    level.descendstarts = struct::get_array("descend_begin", "script_noteworthy");
    level.ascendstructs = [];
    foreach (a in level.ascendstarts) {
        function_731b9325(a, 1);
    }
    foreach (a in level.descendstarts) {
        function_731b9325(a, 0);
    }
    callback::function_532a4f74(&function_1858cdf2);
    callback::function_c16ce2bc(&function_7e99ed03);
    callback::on_player_killed(&on_player_killed);
    callback::on_disconnect(&on_player_disconnect);
    /#
        level thread function_efab52ae();
    #/
}

// Namespace rappel/rappel
// Params 0, eflags: 0x1 linked
// Checksum 0x8983f1c1, Offset: 0x350
// Size: 0x5c
function function_1858cdf2() {
    assert(isdefined(self.ascender));
    assert(is_true(self.ascender.inuse));
}

// Namespace rappel/rappel
// Params 0, eflags: 0x1 linked
// Checksum 0x897257c5, Offset: 0x3b8
// Size: 0x1c
function function_7e99ed03() {
    self function_1fd398d8();
}

// Namespace rappel/rappel
// Params 1, eflags: 0x1 linked
// Checksum 0x4ed85cab, Offset: 0x3e0
// Size: 0x24
function on_player_killed(*params) {
    self function_1fd398d8();
}

// Namespace rappel/rappel
// Params 0, eflags: 0x1 linked
// Checksum 0x7ff2808b, Offset: 0x410
// Size: 0x1c
function on_player_disconnect() {
    self function_1fd398d8();
}

// Namespace rappel/rappel
// Params 0, eflags: 0x1 linked
// Checksum 0xafb6bde5, Offset: 0x438
// Size: 0xe6
function function_1fd398d8() {
    if (isdefined(self.ascender)) {
        self.ascender.inuse = 0;
        hint = #"hash_4079b1df1f035718";
        self.ascender.trigger sethintstring(hint);
        if (isdefined(self.ascender.ascendstructend) && isdefined(self.ascender.ascendstructend.trigger)) {
            self.ascender.ascendstructend.trigger sethintstring(hint);
            self.ascender.ascendstructend.inuse = 0;
        }
        self.ascender = undefined;
    }
}

// Namespace rappel/rappel
// Params 1, eflags: 0x1 linked
// Checksum 0x2ccd50ff, Offset: 0x528
// Size: 0x120
function function_c487f6c0(var_13bb8c94) {
    var_3d783ef7 = spawn("trigger_radius_use", var_13bb8c94.origin + (0, 0, 16), 0, 128, 128);
    var_3d783ef7.var_13bb8c94 = var_13bb8c94;
    var_3d783ef7 triggerignoreteam();
    var_3d783ef7 setvisibletoall();
    var_3d783ef7 setteamfortrigger(#"none");
    var_3d783ef7 setcursorhint("HINT_NOICON");
    hint = #"hash_4079b1df1f035718";
    var_3d783ef7 sethintstring(hint);
    var_3d783ef7 callback::on_trigger(&ascender_use);
    return var_3d783ef7;
}

// Namespace rappel/rappel
// Params 2, eflags: 0x1 linked
// Checksum 0xb4c54965, Offset: 0x650
// Size: 0xfa
function function_731b9325(struct, dir) {
    var_b53569ae = struct::get(struct.target, "targetname");
    var_1802b8ab = struct::get(var_b53569ae.target, "targetname");
    level.ascendstructs[struct.target] = struct;
    struct.ascendstructend = var_b53569ae;
    struct.ascendstructout = var_1802b8ab;
    struct.inuse = 0;
    struct.exitangle = struct.angles + (0, 180, 0);
    struct.startangle = struct.angles;
    struct.dir = dir;
    struct.trigger = function_c487f6c0(struct);
}

// Namespace rappel/rappel
// Params 2, eflags: 0x1 linked
// Checksum 0x60607f40, Offset: 0x758
// Size: 0x96
function function_8b08f357(player, var_13bb8c94) {
    if (is_true(var_13bb8c94.inuse)) {
        return false;
    }
    if (is_true(self.laststand)) {
        return false;
    }
    if (player getstance() == "prone") {
        return false;
    }
    if (!player function_c73c0ee6()) {
        return false;
    }
    return true;
}

// Namespace rappel/rappel
// Params 1, eflags: 0x1 linked
// Checksum 0x67811ff6, Offset: 0x7f8
// Size: 0x1ec
function ascender_use(trigger_info) {
    player = trigger_info.activator;
    level endon(#"game_ended");
    player endon(#"death");
    player endon(#"disconnect");
    player endon(#"ascender_cancel");
    var_13bb8c94 = self.var_13bb8c94;
    if (!function_8b08f357(player, var_13bb8c94)) {
        return;
    }
    var_5c1b57ee = var_13bb8c94.ascendstructend;
    var_81d2b10b = distance(var_5c1b57ee.origin, var_13bb8c94.origin);
    if (var_13bb8c94.origin[2] > var_5c1b57ee.origin[2]) {
        var_81d2b10b *= -1;
    }
    player.ascender = var_13bb8c94;
    hint = #"hash_607b12b5d5733b3e";
    var_13bb8c94.trigger sethintstring(hint);
    var_13bb8c94.inuse = 1;
    if (isdefined(var_5c1b57ee) && isdefined(var_5c1b57ee.trigger)) {
        var_5c1b57ee.trigger sethintstring(hint);
        var_5c1b57ee.inuse = 1;
    }
    player function_256406a6(var_13bb8c94.origin, var_13bb8c94.angles[1], var_81d2b10b);
}

/#

    // Namespace rappel/rappel
    // Params 0, eflags: 0x0
    // Checksum 0xc3341fef, Offset: 0x9f0
    // Size: 0x164
    function function_efab52ae() {
        while (getdvarint(#"hash_7cfb013f9bd630b6", 0)) {
            waitframe(1);
            foreach (rappel in level.ascendstarts) {
                var_86660d95 = rappel.origin;
                print3d(var_86660d95 + (0, 0, 16), rappel.targetname, (0, 1, 0));
                sphere(var_86660d95, 4, (0, 1, 0));
                circle(var_86660d95, 24, (0, 1, 0), 1, 1);
                line(var_86660d95, rappel.ascendstructend.origin, (0, 1, 0));
            }
        }
    }

#/
