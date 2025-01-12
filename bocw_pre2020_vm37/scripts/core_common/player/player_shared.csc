#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;

#namespace player;

// Namespace player/player_shared
// Params 0, eflags: 0x6
// Checksum 0xa9205796, Offset: 0xf8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"player", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace player/player_shared
// Params 0, eflags: 0x5 linked
// Checksum 0xb7ad4046, Offset: 0x140
// Size: 0x10c
function private function_70a657d8() {
    clientfield::register("world", "gameplay_started", 1, 1, "int", &gameplay_started_callback, 0, 1);
    clientfield::register("toplayer", "gameplay_allows_deploy", 1, 1, "int", undefined, 0, 0);
    clientfield::register("toplayer", "player_dof_settings", 1, 2, "int", &function_f9e445ee, 0, 0);
    callback::on_localplayer_spawned(&local_player_spawn);
    callback::on_spawned(&on_player_spawned);
}

// Namespace player/slide_begin
// Params 1, eflags: 0x40
// Checksum 0x3401a439, Offset: 0x258
// Size: 0x8c
function event_handler[slide_begin] function_8183e35a(*eventstruct) {
    if (!self function_21c0fa55()) {
        return;
    }
    if (self postfx::function_556665f2(#"hash_715247c8f8a6a967")) {
        self postfx::exitpostfxbundle(#"hash_715247c8f8a6a967");
    }
    self thread postfx::playpostfxbundle(#"hash_715247c8f8a6a967");
}

// Namespace player/player_shared
// Params 7, eflags: 0x1 linked
// Checksum 0xe17ef6be, Offset: 0x2f0
// Size: 0x84
function gameplay_started_callback(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    setdvar(#"cg_isgameplayactive", bwastimejump);
    if (bwastimejump) {
        level callback::callback(#"on_gameplay_started", fieldname);
    }
}

// Namespace player/player_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x235cea99, Offset: 0x380
// Size: 0x54
function local_player_spawn(localclientnum) {
    if (!self function_21c0fa55()) {
        return;
    }
    setdepthoffield(localclientnum, 0, 0, 0, 0, 6, 1.8);
}

// Namespace player/player_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x129f65b4, Offset: 0x3e0
// Size: 0xb8
function on_player_spawned(localclientnum) {
    self thread function_8f03c3d0(localclientnum);
    foreach (player in getplayers(localclientnum)) {
        player function_f22aa227(localclientnum);
    }
}

// Namespace player/player_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x4e3b26c, Offset: 0x4a0
// Size: 0xd4
function function_8f03c3d0(localclientnum) {
    if (sessionmodeiscampaigngame()) {
        return;
    }
    self endon(#"death");
    self endon(#"disconnect");
    wait 1;
    localplayer = function_27673a7(localclientnum);
    if (self != localplayer) {
        if (self.team === localplayer.team) {
            self function_9974c822("cmn_teammate_duck");
            self callback::add_entity_callback(#"death", &function_65dbe586);
        }
    }
}

// Namespace player/player_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x17e26003, Offset: 0x580
// Size: 0x5c
function function_65dbe586(*params) {
    self function_5dcc74d1("cmn_teammate_duck");
    self callback::function_52ac9652(#"death", &function_65dbe586);
}

// Namespace player/player_shared
// Params 7, eflags: 0x1 linked
// Checksum 0x25e72ead, Offset: 0x5e8
// Size: 0x122
function function_f9e445ee(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    switch (bwastimejump) {
    case 0:
        setdepthoffield(fieldname, 0, 0, 512, 512, 4, 0);
        break;
    case 1:
        setdepthoffield(fieldname, 0, 0, 512, 4000, 4, 0);
        break;
    case 2:
        setdepthoffield(fieldname, 0, 128, 512, 4000, 6, 1.8);
        break;
    default:
        break;
    }
}

// Namespace player/player_shared
// Params 1, eflags: 0x5 linked
// Checksum 0x12d9f5fa, Offset: 0x718
// Size: 0xe4
function private function_f22aa227(localclientnum) {
    if (!isalive(self)) {
        return;
    }
    var_2d9ea0a1 = function_27673a7(localclientnum);
    if (self.team !== var_2d9ea0a1.team) {
        if (!self function_d2503806(#"rob_sonar_set_enemy")) {
            self playrenderoverridebundle(#"rob_sonar_set_enemy");
        }
        return;
    }
    if (self function_d2503806(#"rob_sonar_set_enemy")) {
        self stoprenderoverridebundle(#"rob_sonar_set_enemy");
    }
}

