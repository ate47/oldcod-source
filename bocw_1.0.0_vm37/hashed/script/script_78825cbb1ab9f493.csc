#using script_71f2f8a6fc184b69;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\map;
#using scripts\core_common\player\player_insertion;
#using scripts\core_common\util_shared;
#using scripts\mp_common\laststand;
#using scripts\wz_common\hud;
#using scripts\wz_common\vehicle;
#using scripts\wz_common\wz_ignore_systems;

#namespace namespace_17baa64d;

// Namespace namespace_17baa64d/namespace_17baa64d
// Params 0, eflags: 0x0
// Checksum 0x55814f65, Offset: 0x158
// Size: 0x194
function init() {
    insertion_passenger_count::register();
    hud::function_9b9cecdf();
    callback::on_localplayer_spawned(&on_player_spawned);
    callback::on_killcam_begin(&on_killcam_begin);
    callback::on_killcam_end(&on_killcam_end);
    callback::on_gameplay_started(&start_warzone);
    function_41f9de03();
    function_f6b076db();
    level.var_f2814a96 = isdefined(getgametypesetting(#"hash_6be1c95551e78384")) ? getgametypesetting(#"hash_6be1c95551e78384") : 0;
    if (is_true(getgametypesetting(#"hash_3a73deb0ca8c9aea"))) {
        setdvar(#"cg_drawcrosshair", 0);
    }
    setdvar(#"hash_2d5b0d6d4ce995d7", 0);
}

// Namespace namespace_17baa64d/namespace_17baa64d
// Params 1, eflags: 0x0
// Checksum 0x3b05ba91, Offset: 0x2f8
// Size: 0xcc
function start_warzone(localclientnum) {
    if (!is_true(getgametypesetting(#"hash_7532afe3ef8b4332"))) {
        setdvar(#"hash_2d5b0d6d4ce995d7", 1);
    }
    function_d547b972();
    function_65469e2e();
    if (is_true(getgametypesetting(#"hash_6cc7b012775d9662"))) {
        level thread function_3dadedf8(localclientnum);
    }
}

// Namespace namespace_17baa64d/namespace_17baa64d
// Params 0, eflags: 0x0
// Checksum 0x7424e45b, Offset: 0x3d0
// Size: 0x334
function function_41f9de03() {
    localclientnum = 0;
    mapbundle = map::get_script_bundle();
    var_4e59607a = [];
    if (isdefined(mapbundle) && isdefined(mapbundle.destinationlabellist)) {
        foreach (destinationlabel in mapbundle.destinationlabellist) {
            if (isdefined(destinationlabel.targetname)) {
                var_4e59607a[destinationlabel.targetname] = destinationlabel.displayname;
            }
        }
    }
    if (!isdefined(level.struct)) {
        level.struct = [];
    }
    foreach (struct in level.struct) {
        if (isdefined(struct.targetname) && isdefined(var_4e59607a[struct.targetname])) {
            function_4b8a09b(localclientnum, var_4e59607a[hash(struct.targetname)], struct.origin);
            var_4e59607a[struct.targetname] = undefined;
        }
        if (struct.classname === "script_struct") {
            struct.classname = undefined;
        }
    }
    /#
        foreach (destname in var_4e59607a) {
            level.var_909020d0 = (isdefined(level.var_909020d0) ? level.var_909020d0 : 0) + 1;
            level.var_a1222bd2 = (isdefined(level.var_a1222bd2) ? level.var_a1222bd2 : "<dev string:x38>") + destinationlabel.targetname + "<dev string:x3c>";
        }
        if (isdefined(level.var_909020d0)) {
            println(level.var_909020d0 + "<dev string:x42>" + level.var_a1222bd2);
        }
    #/
}

// Namespace namespace_17baa64d/namespace_17baa64d
// Params 1, eflags: 0x0
// Checksum 0x77a13c41, Offset: 0x710
// Size: 0x74
function on_player_spawned(localclientnum) {
    if (!self function_da43934d()) {
        return;
    }
    function_2dba6c5(localclientnum, function_8978c19(localclientnum));
    thread function_a1aaf8c0();
    self thread function_f8c70ad7(localclientnum);
}

// Namespace namespace_17baa64d/namespace_17baa64d
// Params 0, eflags: 0x0
// Checksum 0x9c2d8ad9, Offset: 0x790
// Size: 0x24
function function_c6878ba5() {
    setdvar(#"hash_1b9479093c392885", 0);
}

// Namespace namespace_17baa64d/namespace_17baa64d
// Params 0, eflags: 0x0
// Checksum 0xbe329cb5, Offset: 0x7c0
// Size: 0x54
function function_f6b076db() {
    setdvar(#"hash_1b9479093c392885", 300);
    setdvar(#"hash_51508fd2e827ae4", 1500);
}

// Namespace namespace_17baa64d/namespace_17baa64d
// Params 1, eflags: 0x0
// Checksum 0x70840dff, Offset: 0x820
// Size: 0x1c
function on_killcam_begin(*params) {
    function_c6878ba5();
}

// Namespace namespace_17baa64d/namespace_17baa64d
// Params 1, eflags: 0x0
// Checksum 0xedaaed13, Offset: 0x848
// Size: 0x1c
function on_killcam_end(*params) {
    function_f6b076db();
}

// Namespace namespace_17baa64d/namespace_17baa64d
// Params 1, eflags: 0x0
// Checksum 0x3ce0b70e, Offset: 0x870
// Size: 0x2a8
function function_f8c70ad7(*localclientnum) {
    self endoncallback(&function_e8d2d8c5, #"death");
    self endon(#"disconnect");
    assert(!isdefined(self.var_408847b6));
    if (isdefined(self.var_408847b6)) {
        self function_e8d2d8c5();
    }
    self.var_408847b6 = spawn(0, (0, 0, 0), "script_origin");
    if (!isdefined(self.var_408847b6)) {
        return;
    }
    var_408847b6 = self.var_408847b6;
    var_408847b6.var_41266084 = var_408847b6 playloopsound("amb_height_looper_mountain_fnt");
    var_408847b6.var_2f3960f5 = var_408847b6 playloopsound("amb_height_looper_mountain_bck");
    setsoundvolumerate(var_408847b6.var_41266084, 1);
    setsoundvolumerate(var_408847b6.var_2f3960f5, 1);
    var_d15c9ee7 = 0;
    while (true) {
        var_ebe45f6a = self.origin[2];
        if (abs(var_ebe45f6a - var_d15c9ee7) > 50) {
            var_d15c9ee7 = var_ebe45f6a;
            if (var_ebe45f6a <= 3000) {
                setsoundvolume(var_408847b6.var_41266084, 0);
                setsoundvolume(var_408847b6.var_2f3960f5, 0);
            } else if (var_ebe45f6a <= 7500) {
                var_f9d98743 = (var_ebe45f6a - 3000) / 4500;
                setsoundvolume(var_408847b6.var_41266084, var_f9d98743);
                setsoundvolume(var_408847b6.var_2f3960f5, var_f9d98743);
            } else {
                setsoundvolume(var_408847b6.var_41266084, 1);
                setsoundvolume(var_408847b6.var_2f3960f5, 1);
            }
        }
        wait 0.25;
    }
}

// Namespace namespace_17baa64d/namespace_17baa64d
// Params 1, eflags: 0x0
// Checksum 0x40ddb4f7, Offset: 0xb20
// Size: 0x46
function function_e8d2d8c5(*notifyhash) {
    if (isdefined(self) && isdefined(self.var_408847b6)) {
        self.var_408847b6 delete();
        self.var_408847b6 = undefined;
    }
}

// Namespace namespace_17baa64d/namespace_17baa64d
// Params 2, eflags: 0x0
// Checksum 0x2c83db1a, Offset: 0xb70
// Size: 0x164
function function_2dba6c5(localclientnum, var_be9954a5) {
    if (!isdefined(level.controllercolor)) {
        level.controllercolor = [];
    }
    switch (var_be9954a5) {
    case 0:
    case 1:
        level.controllercolor[localclientnum] = (1, 0.5, 0);
        break;
    case 2:
        level.controllercolor[localclientnum] = (0, 0, 1);
        break;
    case 3:
        level.controllercolor[localclientnum] = (0, 1, 0);
        break;
    case 4:
        level.controllercolor[localclientnum] = (1, 0, 1);
        break;
    default:
        break;
    }
    if (isdefined(level.controllercolor[localclientnum])) {
        setcontrollerlightbarcolor(localclientnum, level.controllercolor[localclientnum]);
        return;
    }
    setcontrollerlightbarcolor(localclientnum);
}

// Namespace namespace_17baa64d/namespace_17baa64d
// Params 0, eflags: 0x0
// Checksum 0xb388399c, Offset: 0xce0
// Size: 0x78
function function_a1aaf8c0() {
    self notify("7e59a2bbe2559c76");
    self endon("7e59a2bbe2559c76");
    while (isdefined(self)) {
        waitresult = level waittill(#"hash_5af34d08eac79f88");
        function_2dba6c5(waitresult.localclientnum, waitresult.teammateindex);
    }
}

// Namespace namespace_17baa64d/namespace_17baa64d
// Params 1, eflags: 0x4
// Checksum 0x9334247a, Offset: 0xd60
// Size: 0x310
function private function_3dadedf8(localclientnum) {
    while (true) {
        origin = getlocalclientpos(localclientnum);
        players = getplayers(localclientnum);
        players = arraysortclosest(players, origin, undefined, 0, 6000);
        bleeding = 0;
        foreach (player in players) {
            if (!player hasdobj(localclientnum)) {
                continue;
            }
            if (!is_true(player.var_374045a0)) {
                if (player ishidden() || player isinfreefall() || player function_9a0edd92()) {
                    continue;
                }
            }
            player.var_374045a0 = 1;
            if (player getlocalclientnumber() === localclientnum) {
                setuimodelvalue(createuimodel(function_1df4c3b0(localclientnum, #"hud_items"), "bleedingOverTime"), 1);
            }
            if (bleeding >= 10 || !isalive(player)) {
                if (isarray(player.var_88b0c4c3)) {
                    foreach (handle in player.var_88b0c4c3) {
                        stopfx(localclientnum, handle);
                    }
                    player.var_88b0c4c3 = undefined;
                }
                continue;
            }
            bleeding++;
            if (!isdefined(player.var_88b0c4c3)) {
                player.var_88b0c4c3 = playtagfxset(localclientnum, "status_effect_bloody_tracker", player);
            }
        }
        players = undefined;
        wait 0.2;
    }
}

