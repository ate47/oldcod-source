#using script_330e1a53a92b38cc;
#using script_3b8f43c68572f06;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace laststand;

// Namespace laststand/laststand
// Params 0, eflags: 0x6
// Checksum 0x44db5543, Offset: 0x220
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"laststand", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace laststand/laststand
// Params 0, eflags: 0x5 linked
// Checksum 0x7567b938, Offset: 0x268
// Size: 0x264
function private function_70a657d8() {
    function_349ff038();
    clientfield::register_clientuimodel("hudItems.laststand.progress", #"last_stand", #"progress", 1, 5, "float", &laststand_postfx, 0, 0);
    clientfield::register_clientuimodel("hudItems.laststand.beingRevived", #"last_stand", #"beingrevived", 1, 1, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.laststand.revivingClientNum", #"last_stand", #"revivingclientnum", 1, 7, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.laststand.reviveProgress", #"last_stand", #"reviveprogress", 1, 5, "float", undefined, 0, 0);
    clientfield::register_clientuimodel("EnemyTeamLastLivesData.numPlayersDowned", #"hash_157814322eeb6f4f", #"numplayersdowned", 1, 3, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("PlayerTeamLastLivesData.numPlayersDowned", #"hash_1c0caa4923ddc616", #"numplayersdowned", 1, 3, "int", undefined, 0, 0);
    clientfield::register("allplayers", "laststand_bleed", 1, 1, "int", &laststand_bleed, 0, 0);
    level thread wait_and_set_revive_shader_constant();
}

// Namespace laststand/laststand
// Params 0, eflags: 0x1 linked
// Checksum 0xefa55275, Offset: 0x4d8
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
// Params 7, eflags: 0x1 linked
// Checksum 0xbd16a10d, Offset: 0x540
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
// Params 7, eflags: 0x1 linked
// Checksum 0xbeae1b3a, Offset: 0x718
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
// Params 2, eflags: 0x1 linked
// Checksum 0xda228d39, Offset: 0x820
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
// Params 0, eflags: 0x1 linked
// Checksum 0xef17b72f, Offset: 0x908
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

