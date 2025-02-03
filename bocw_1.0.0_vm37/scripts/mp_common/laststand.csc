#using script_330e1a53a92b38cc;
#using script_3b8f43c68572f06;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace laststand;

// Namespace laststand/laststand
// Params 0, eflags: 0x6
// Checksum 0x9b4871d0, Offset: 0x258
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"laststand", &preinit, undefined, undefined, undefined);
}

// Namespace laststand/laststand
// Params 0, eflags: 0x4
// Checksum 0x29b3ce4e, Offset: 0x2a0
// Size: 0x334
function private preinit() {
    function_349ff038();
    clientfield::register_clientuimodel("hudItems.laststand.progress", #"last_stand", #"progress", 1, 5, "float", &laststand_postfx, 0, 0);
    clientfield::register_clientuimodel("hudItems.laststand.beingRevived", #"last_stand", #"beingrevived", 1, 1, "int", &being_revived, 0, 1);
    clientfield::register_clientuimodel("hudItems.laststand.revivingClientNum", #"last_stand", #"revivingclientnum", 1, 7, "int", &function_6159e216, 0, 0);
    clientfield::register_clientuimodel("hudItems.laststand.reviveProgress", #"last_stand", #"reviveprogress", 1, 5, "float", undefined, 0, 0);
    clientfield::register_clientuimodel("EnemyTeamLastLivesData.numPlayersDowned", #"hash_157814322eeb6f4f", #"numplayersdowned", 1, 3, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("PlayerTeamLastLivesData.numPlayersDowned", #"hash_1c0caa4923ddc616", #"numplayersdowned", 1, 3, "int", undefined, 0, 0);
    clientfield::register("allplayers", "laststand_bleed", 1, 1, "int", &laststand_bleed, 0, 0);
    clientfield::register_clientuimodel("hud_items.selfReviveAvailable", #"hud_items", #"hash_421cc80875ab27e5", 1, 1, "int", undefined, 0, 0);
    clientfield::register("toplayer", "isSelfReviving", 1, 1, "int", &function_a228d7a3, 0, 1);
    level thread wait_and_set_revive_shader_constant();
    level.var_4103bf85 = [];
    level.var_7f1612a0 = [];
}

// Namespace laststand/laststand
// Params 0, eflags: 0x0
// Checksum 0x8370577b, Offset: 0x5e0
// Size: 0x5c
function function_349ff038() {
    var_f6784858 = 6;
    if (sessionmodeiswarzonegame()) {
        var_f6784858 = 4;
    }
    for (i = 0; i < var_f6784858; i++) {
        mp_revive_prompt::register();
    }
}

// Namespace laststand/laststand
// Params 7, eflags: 0x4
// Checksum 0x7c88301e, Offset: 0x648
// Size: 0xf4
function private function_a228d7a3(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        if (isdefined(level.var_7f1612a0[fieldname])) {
            function_d48752e(fieldname, level.var_7f1612a0[fieldname]);
        }
        level.var_7f1612a0[fieldname] = function_604c9983(fieldname, #"hash_390aa7d4252c46b5");
        return;
    }
    if (isdefined(level.var_7f1612a0[fieldname])) {
        function_d48752e(fieldname, level.var_7f1612a0[fieldname]);
        level.var_7f1612a0[fieldname] = undefined;
    }
}

// Namespace laststand/laststand
// Params 7, eflags: 0x0
// Checksum 0x3cec6514, Offset: 0x748
// Size: 0x1cc
function laststand_postfx(localclientnum, oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    player = function_5c10bd79(binitialsnap);
    if (bwastimejump) {
        if (!self postfx::function_556665f2("pstfx_drowning")) {
            self postfx::playpostfxbundle("pstfx_drowning");
            value = 0.99;
            self postfx::function_c8b5f318("pstfx_drowning", #"outer radius", value);
            self postfx::function_c8b5f318("pstfx_drowning", #"inner radius", value - 0.3);
            self postfx::function_c8b5f318("pstfx_drowning", #"opacity", 1);
        }
        if (bwastimejump > 0.5) {
            if (fieldname == 0) {
                fieldname = bwastimejump;
                bwastimejump = fieldname - 0.05;
            }
            player thread function_8960f852(fieldname, bwastimejump);
        }
        return;
    }
    if (self postfx::function_556665f2("pstfx_drowning")) {
        postfx::stoppostfxbundle("pstfx_drowning");
    }
}

// Namespace laststand/laststand
// Params 7, eflags: 0x0
// Checksum 0x9d38b4ea, Offset: 0x920
// Size: 0x6c
function being_revived(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    var_4f6e7690 = bwastimejump != 0;
    function_766ed49(fieldname, var_4f6e7690);
}

// Namespace laststand/laststand
// Params 7, eflags: 0x0
// Checksum 0xb1e60a5a, Offset: 0x998
// Size: 0x9c
function function_6159e216(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    var_4f6e7690 = bwastimejump != int(pow(2, 7) - 2);
    function_766ed49(fieldname, var_4f6e7690);
}

// Namespace laststand/laststand
// Params 2, eflags: 0x0
// Checksum 0xf30bdcd4, Offset: 0xa40
// Size: 0xcc
function function_766ed49(localclientnum, var_20e2bb05) {
    if (var_20e2bb05) {
        if (isdefined(level.var_4103bf85[localclientnum])) {
            function_d48752e(localclientnum, level.var_4103bf85[localclientnum]);
        }
        level.var_4103bf85[localclientnum] = function_604c9983(localclientnum, #"hash_390aa7d4252c46b5");
        return;
    }
    if (isdefined(level.var_4103bf85[localclientnum])) {
        function_d48752e(localclientnum, level.var_4103bf85[localclientnum]);
        level.var_4103bf85[localclientnum] = undefined;
    }
}

// Namespace laststand/laststand
// Params 7, eflags: 0x0
// Checksum 0x6266dd76, Offset: 0xb18
// Size: 0xfe
function laststand_bleed(localclientnum, oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self endon(#"death", #"hash_7698972484f247e8");
    if (bwastimejump != fieldname && bwastimejump) {
        self util::waittill_dobj(binitialsnap);
        self.var_63796ff0 = function_239993de(binitialsnap, "player/fx8_plyr_blood_drip_last_stand", self, "j_spine4");
        return;
    }
    if (isdefined(self.var_63796ff0)) {
        stopfx(binitialsnap, self.var_63796ff0);
    }
    self notify(#"hash_7698972484f247e8");
}

// Namespace laststand/laststand
// Params 2, eflags: 0x0
// Checksum 0xf3168b51, Offset: 0xc20
// Size: 0xe0
function function_8960f852(oldval, newval) {
    self endon(#"death");
    duration = 1;
    while (duration > 0) {
        value = oldval - (oldval - newval) * (1 - duration);
        duration -= 0.1;
        self postfx::function_c8b5f318("pstfx_drowning", #"outer radius", value);
        self postfx::function_c8b5f318("pstfx_drowning", #"inner radius", value - 0.8);
        wait 0.1;
    }
}

// Namespace laststand/laststand
// Params 0, eflags: 0x0
// Checksum 0xec844d0b, Offset: 0xd08
// Size: 0xc8
function wait_and_set_revive_shader_constant() {
    while (true) {
        waitresult = level waittill(#"notetrack");
        localclientnum = waitresult.localclientnum;
        if (waitresult.notetrack == "revive_shader_constant") {
            player = function_5c10bd79(localclientnum);
            player mapshaderconstant(localclientnum, 0, "scriptVector2", 0, 1, 0, getservertime(localclientnum) / 1000);
        }
    }
}

