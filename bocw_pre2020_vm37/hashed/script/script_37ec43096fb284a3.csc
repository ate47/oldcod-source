#using scripts\core_common\audio_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_d0ab5955;

// Namespace namespace_d0ab5955/namespace_d0ab5955
// Params 0, eflags: 0x6
// Checksum 0x9bd0c749, Offset: 0x190
// Size: 0x4c
function private autoexec __init__system__() {
    system::register(#"hash_d07e35f920d16a8", &function_70a657d8, &postinit, undefined, undefined);
}

// Namespace namespace_d0ab5955/namespace_d0ab5955
// Params 0, eflags: 0x0
// Checksum 0xda4f7319, Offset: 0x1e8
// Size: 0x278
function function_70a657d8() {
    clientfield::register("scriptmover", "fogofwarflag", 1, 1, "int", &function_a380fe5, 0, 0);
    clientfield::register("toplayer", "fogofwareffects", 1, 2, "int", undefined, 0, 1);
    clientfield::register("toplayer", "fogofwartimer", 1, 1, "int", &function_947e99a9, 0, 1);
    clientfield::register("allplayers", "outsidetile", 1, 1, "int", undefined, 0, 0);
    clientfield::register("world", "tile_id", 1, 6, "int", &function_ec0b7087, 1, 0);
    if (!is_true(getgametypesetting(#"hash_59854c1f30538261"))) {
        return;
    }
    level.var_7bd7bdc8 = [1:#"hash_6a04f899ab555f22", 2:#"hash_2964f82e2c05c8b8", 3:#"hash_54da2f2da5752d99"];
    level.var_6e62d281 = #"hash_289962ed0e76921d";
    var_ac22a760 = struct::get_array(#"hash_3460aae6bb799a99", "content_key");
    for (index = 1; index <= var_ac22a760.size; index++) {
        var_ac22a760[index - 1].id = index;
    }
    callback::on_localclient_connect(&on_localclient_connect);
    level.var_e9d75843 = [];
}

// Namespace namespace_d0ab5955/namespace_d0ab5955
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x468
// Size: 0x4
function postinit() {
    
}

// Namespace namespace_d0ab5955/namespace_d0ab5955
// Params 7, eflags: 0x0
// Checksum 0xef43a10, Offset: 0x478
// Size: 0xc4
function function_a380fe5(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        self playrenderoverridebundle(#"hash_4a9cb80afea6f8cb");
        self function_78233d29(#"hash_4a9cb80afea6f8cb", "", "Scale", 1);
        return;
    }
    self stoprenderoverridebundle(#"hash_4a9cb80afea6f8cb");
}

// Namespace namespace_d0ab5955/namespace_d0ab5955
// Params 7, eflags: 0x0
// Checksum 0x49937d52, Offset: 0x548
// Size: 0x160
function function_ec0b7087(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    var_ac22a760 = struct::get_array(#"hash_3460aae6bb799a99", "content_key");
    foreach (var_ea0ed69c in var_ac22a760) {
        var_f6b2bc6f = getent(fieldname, var_ea0ed69c.targetname, "target");
        if (isdefined(var_f6b2bc6f)) {
            if (var_ea0ed69c.id == bwastimejump) {
                var_f6b2bc6f function_704c070e(fieldname);
                continue;
            }
            var_f6b2bc6f function_53a26ea0(fieldname);
        }
    }
}

// Namespace namespace_d0ab5955/namespace_d0ab5955
// Params 1, eflags: 0x0
// Checksum 0x2f1c6ac1, Offset: 0x6b0
// Size: 0x8c
function on_localclient_connect(localclientnum) {
    function_486e663e(localclientnum, 1);
    level thread function_347f52dd(localclientnum);
    setuimodelvalue(createuimodel(function_1df4c3b0(localclientnum, #"hash_6f4b11a0bee9b73d"), "outOfBoundsEndTime"), 0);
}

// Namespace namespace_d0ab5955/namespace_d0ab5955
// Params 1, eflags: 0x4
// Checksum 0x29e0bdab, Offset: 0x748
// Size: 0x114
function private function_347f52dd(localclientnum) {
    self notify("3364e807c7f7a0e7");
    self endon("3364e807c7f7a0e7");
    var_ef2f4cec = spawnstruct();
    level.var_e9d75843[localclientnum] = var_ef2f4cec;
    while (true) {
        currentplayer = function_5c10bd79(localclientnum);
        if (!isdefined(currentplayer)) {
            waitframe(1);
            continue;
        }
        intensity = currentplayer clientfield::get_to_player("fogofwareffects");
        if (var_ef2f4cec.var_6f2e5a2b !== intensity) {
            var_ef2f4cec notify(#"hash_387bb78db1d4d1be");
            var_ef2f4cec function_d45dd62(localclientnum, intensity, currentplayer);
            var_ef2f4cec.var_6f2e5a2b = intensity;
        }
        waitframe(1);
    }
}

// Namespace namespace_d0ab5955/namespace_d0ab5955
// Params 7, eflags: 0x4
// Checksum 0x1a22c004, Offset: 0x868
// Size: 0xe4
function private function_947e99a9(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    oobmodel = getuimodel(function_1df4c3b0(fieldname, #"hash_6f4b11a0bee9b73d"), "outOfBoundsEndTime");
    if (bwastimejump > 0) {
        setuimodelvalue(oobmodel, getservertime(0, 1) + level.oob_timelimit_ms);
        return;
    }
    setuimodelvalue(oobmodel, 0);
}

// Namespace namespace_d0ab5955/namespace_d0ab5955
// Params 3, eflags: 0x4
// Checksum 0xa012c964, Offset: 0x958
// Size: 0x1ea
function private function_d45dd62(localclientnum, intensity = 0, currentplayer) {
    if (isdefined(self.var_7bd7bdc8)) {
        function_24cd4cfb(localclientnum, self.var_7bd7bdc8);
        self.var_7bd7bdc8 = undefined;
        stopfx(localclientnum, self.var_6e62d281);
        self.var_6e62d281 = undefined;
    }
    if (isdefined(currentplayer.var_103fdf58)) {
        playsound(localclientnum, #"hash_1757939248ce3124", (0, 0, 0));
        currentplayer stoploopsound(currentplayer.var_103fdf58);
        currentplayer.var_103fdf58 = undefined;
    }
    postfx = level.var_7bd7bdc8[intensity];
    if (isdefined(postfx)) {
        if (function_148ccc79(localclientnum, postfx)) {
            codestoppostfxbundlelocal(localclientnum, postfx);
        }
        function_a837926b(localclientnum, postfx);
        self.var_6e62d281 = playviewmodelfx(localclientnum, level.var_6e62d281, "tag_torso");
        self.var_7bd7bdc8 = postfx;
        if (!isdefined(currentplayer.var_103fdf58)) {
            playsound(localclientnum, #"hash_639f49c1fc950a5d", (0, 0, 0));
            currentplayer.var_103fdf58 = currentplayer playloopsound("evt_sr_fogofwar_1p_lp");
        }
    }
}

