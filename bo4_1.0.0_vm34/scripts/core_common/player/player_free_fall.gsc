#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace player_free_fall;

// Namespace player_free_fall/player_free_fall
// Params 0, eflags: 0x2
// Checksum 0xcc28e621, Offset: 0x80
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"player_free_fall", &__init__, undefined, undefined);
}

// Namespace player_free_fall/player_free_fall
// Params 0, eflags: 0x0
// Checksum 0xf2371453, Offset: 0xc8
// Size: 0x8e
function __init__() {
    callback::add_callback(#"freefall", &function_6b439695);
    callback::add_callback(#"parachute", &function_a1324b02);
    level.parachute_weapon = getweapon(#"parachute");
}

// Namespace player_free_fall/player_free_fall
// Params 1, eflags: 0x4
// Checksum 0xf0754a15, Offset: 0x160
// Size: 0x19c
function private function_6b439695(eventstruct) {
    if (eventstruct.freefall) {
        if (!self hasweapon(level.parachute_weapon)) {
            self giveweapon(level.parachute_weapon);
        }
        self switchtoweapon(level.parachute_weapon);
        if (!self isattached(#"c_t8_hero_playermale_wingsuit1")) {
            self attach(#"c_t8_hero_playermale_wingsuit1");
        }
        if (!self hasweapon(level.parachute_weapon)) {
            self giveweapon(level.parachute_weapon);
        }
        return;
    }
    if (self isattached(#"c_t8_hero_playermale_wingsuit1")) {
        self detach(#"c_t8_hero_playermale_wingsuit1");
    }
    if (!self function_dbc2b8c1()) {
        if (self hasweapon(level.parachute_weapon)) {
            self takeweapon(level.parachute_weapon);
        }
    }
}

// Namespace player_free_fall/player_free_fall
// Params 1, eflags: 0x4
// Checksum 0x466ea09d, Offset: 0x308
// Size: 0x3c
function private function_a1324b02(eventstruct) {
    if (eventstruct.parachute) {
        return;
    }
    self takeweapon(level.parachute_weapon);
}

