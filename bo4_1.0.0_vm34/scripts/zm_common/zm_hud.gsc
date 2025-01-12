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
// Params 0, eflags: 0x2
// Checksum 0x43a49dd2, Offset: 0xf8
// Size: 0x54
function autoexec __init__system__() {
    system::register(#"zm_hud", &__init__, &__main__, #"zm_crafting");
}

// Namespace zm_hud/zm_hud
// Params 0, eflags: 0x0
// Checksum 0x2193ee74, Offset: 0x158
// Size: 0x64
function __init__() {
    level.zm_location = zm_location::register("zm_location");
    callback::on_connect(&on_player_connect);
    callback::on_spawned(&on_player_spawned);
}

// Namespace zm_hud/zm_hud
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x1c8
// Size: 0x4
function __main__() {
    
}

// Namespace zm_hud/zm_hud
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x1d8
// Size: 0x4
function on_player_connect() {
    
}

// Namespace zm_hud/zm_hud
// Params 0, eflags: 0x0
// Checksum 0x1bfc5102, Offset: 0x1e8
// Size: 0x74
function on_player_spawned() {
    if (level.zm_location zm_location::is_open(self)) {
        level.zm_location zm_location::close(self);
    }
    self.var_145b255d = #"";
    waitframe(1);
    self function_e003483a();
}

// Namespace zm_hud/zm_hud
// Params 0, eflags: 0x0
// Checksum 0x3a84c7f5, Offset: 0x268
// Size: 0x44
function function_e003483a() {
    if (!level.zm_location zm_location::is_open(self)) {
        level.zm_location zm_location::open(self, 0);
    }
}

// Namespace zm_hud/zm_hud
// Params 1, eflags: 0x0
// Checksum 0xdb21a257, Offset: 0x2b8
// Size: 0x84
function function_3a4fb187(location) {
    if (level.zm_location zm_location::is_open(self)) {
        level.zm_location zm_location::set_location_name(self, location);
        if (self.var_145b255d != location) {
            self.var_145b255d = location;
            self thread zm_audio::function_4725da2e(location);
        }
    }
}

