#using script_6d7d84509b62f422;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\hud_util_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;

#namespace zm_hud;

// Namespace zm_hud/zm_hud
// Params 0, eflags: 0x6
// Checksum 0xfb97899f, Offset: 0xe0
// Size: 0x54
function private autoexec __init__system__() {
    system::register(#"zm_hud", &function_70a657d8, &postinit, undefined, #"zm_crafting");
}

// Namespace zm_hud/zm_hud
// Params 0, eflags: 0x5 linked
// Checksum 0x58cd536d, Offset: 0x140
// Size: 0x5c
function private function_70a657d8() {
    level.zm_location = zm_location::register();
    callback::on_connect(&on_player_connect);
    callback::on_spawned(&on_player_spawned);
}

// Namespace zm_hud/zm_hud
// Params 0, eflags: 0x5 linked
// Checksum 0x80f724d1, Offset: 0x1a8
// Size: 0x4
function private postinit() {
    
}

// Namespace zm_hud/zm_hud
// Params 0, eflags: 0x1 linked
// Checksum 0x80f724d1, Offset: 0x1b8
// Size: 0x4
function on_player_connect() {
    
}

// Namespace zm_hud/zm_hud
// Params 0, eflags: 0x1 linked
// Checksum 0xad0fd283, Offset: 0x1c8
// Size: 0x9c
function on_player_spawned() {
    self endon(#"disconnect");
    if (level.zm_location zm_location::is_open(self)) {
        level.zm_location zm_location::close(self);
    }
    self.var_b3122c84 = #"";
    util::wait_network_frame();
    if (isdefined(self)) {
        self function_84c3e8e6();
    }
}

// Namespace zm_hud/zm_hud
// Params 0, eflags: 0x1 linked
// Checksum 0xeeebc695, Offset: 0x270
// Size: 0x44
function function_84c3e8e6() {
    if (!level.zm_location zm_location::is_open(self)) {
        level.zm_location zm_location::open(self, 0);
    }
}

// Namespace zm_hud/zm_hud
// Params 1, eflags: 0x1 linked
// Checksum 0x1e0af55b, Offset: 0x2c0
// Size: 0x8c
function function_29780fb5(location) {
    self.var_5417136 = location;
    if (level.zm_location zm_location::is_open(self)) {
        level.zm_location zm_location::set_location_name(self, location);
        if (self.var_b3122c84 != location) {
            self.var_b3122c84 = location;
            self thread zm_audio::function_a3c4af48(location);
        }
    }
}

