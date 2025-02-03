#using scripts\core_common\callbacks_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;

#namespace rappel;

// Namespace rappel/rappel
// Params 0, eflags: 0x6
// Checksum 0xba6392eb, Offset: 0xf0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"rappel", &preinit, undefined, undefined, undefined);
}

// Namespace rappel/rappel
// Params 0, eflags: 0x4
// Checksum 0x95d119ef, Offset: 0x138
// Size: 0x20c
function private preinit() {
    level.ascendstarts = struct::get_array("ascend_begin", "script_noteworthy");
    level.descendstarts = struct::get_array("descend_begin", "script_noteworthy");
    level.ascendstructs = [];
    foreach (a in level.ascendstarts) {
        function_731b9325(a, 1);
    }
    foreach (a in level.descendstarts) {
        function_731b9325(a, 0);
    }
    callback::on_rappel(&function_1858cdf2);
    callback::function_c16ce2bc(&function_7e99ed03);
    callback::on_player_killed(&on_player_killed);
    callback::on_disconnect(&on_player_disconnect);
    /#
        level thread function_efab52ae();
    #/
}

// Namespace rappel/rappel
// Params 0, eflags: 0x0
// Checksum 0x172f0d32, Offset: 0x350
// Size: 0x5c
function function_1858cdf2() {
    assert(isdefined(self.ascender));
    assert(is_true(self.ascender.inuse));
}

// Namespace rappel/rappel
// Params 0, eflags: 0x0
// Checksum 0x1874efc7, Offset: 0x3b8
// Size: 0x1c
function function_7e99ed03() {
    self function_1fd398d8();
}

// Namespace rappel/rappel
// Params 1, eflags: 0x0
// Checksum 0x17f0a6d6, Offset: 0x3e0
// Size: 0x24
function on_player_killed(*params) {
    self function_1fd398d8();
}

// Namespace rappel/rappel
// Params 0, eflags: 0x0
// Checksum 0x413d83d6, Offset: 0x410
// Size: 0x1c
function on_player_disconnect() {
    self function_1fd398d8();
}

// Namespace rappel/rappel
// Params 0, eflags: 0x0
// Checksum 0xc8e4f3b4, Offset: 0x438
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
// Params 1, eflags: 0x0
// Checksum 0xeb7b1170, Offset: 0x528
// Size: 0x120
function function_c487f6c0(ascendstart) {
    var_3d783ef7 = spawn("trigger_radius_use", ascendstart.origin + (0, 0, 16), 0, 128, 128);
    var_3d783ef7.ascendstart = ascendstart;
    var_3d783ef7 triggerignoreteam();
    var_3d783ef7 setvisibletoall();
    var_3d783ef7 setteamfortrigger(#"none");
    var_3d783ef7 setcursorhint("HINT_NOICON");
    hint = #"hash_4079b1df1f035718";
    var_3d783ef7 sethintstring(hint);
    var_3d783ef7 callback::on_trigger(&function_4945d10b);
    return var_3d783ef7;
}

// Namespace rappel/rappel
// Params 2, eflags: 0x0
// Checksum 0x54804704, Offset: 0x650
// Size: 0xfa
function function_731b9325(struct, dir) {
    endstruct = struct::get(struct.target, "targetname");
    var_1802b8ab = struct::get(endstruct.target, "targetname");
    level.ascendstructs[struct.target] = struct;
    struct.ascendstructend = endstruct;
    struct.ascendstructout = var_1802b8ab;
    struct.inuse = 0;
    struct.exitangle = struct.angles + (0, 180, 0);
    struct.startangle = struct.angles;
    struct.dir = dir;
    struct.trigger = function_c487f6c0(struct);
}

// Namespace rappel/rappel
// Params 2, eflags: 0x0
// Checksum 0xee3e8f7f, Offset: 0x758
// Size: 0x96
function function_8b08f357(player, ascendstart) {
    if (is_true(ascendstart.inuse)) {
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
// Params 1, eflags: 0x0
// Checksum 0x4aa2b9d4, Offset: 0x7f8
// Size: 0x1ec
function function_4945d10b(trigger_info) {
    player = trigger_info.activator;
    level endon(#"game_ended");
    player endon(#"death");
    player endon(#"disconnect");
    player endon(#"hash_210eae4f25120927");
    ascendstart = self.ascendstart;
    if (!function_8b08f357(player, ascendstart)) {
        return;
    }
    ascendend = ascendstart.ascendstructend;
    var_81d2b10b = distance(ascendend.origin, ascendstart.origin);
    if (ascendstart.origin[2] > ascendend.origin[2]) {
        var_81d2b10b *= -1;
    }
    player.ascender = ascendstart;
    hint = #"hash_607b12b5d5733b3e";
    ascendstart.trigger sethintstring(hint);
    ascendstart.inuse = 1;
    if (isdefined(ascendend) && isdefined(ascendend.trigger)) {
        ascendend.trigger sethintstring(hint);
        ascendend.inuse = 1;
    }
    player function_256406a6(ascendstart.origin, ascendstart.angles[1], var_81d2b10b);
}

/#

    // Namespace rappel/rappel
    // Params 0, eflags: 0x0
    // Checksum 0xbf5d3c82, Offset: 0x9f0
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
