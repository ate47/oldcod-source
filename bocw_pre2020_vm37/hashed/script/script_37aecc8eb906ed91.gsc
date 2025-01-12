#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace nightingale;

// Namespace nightingale/nightingale
// Params 0, eflags: 0x6
// Checksum 0xb64c5a37, Offset: 0x98
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"nightingale", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace nightingale/nightingale
// Params 0, eflags: 0x5 linked
// Checksum 0x3034a2d6, Offset: 0xe0
// Size: 0x24
function private function_70a657d8() {
    if (sessionmodeiszombiesgame()) {
        level.var_17d9f80 = [];
    }
}

// Namespace nightingale/grenade_fire
// Params 1, eflags: 0x44
// Checksum 0x631392bc, Offset: 0x110
// Size: 0xbc
function private event_handler[grenade_fire] function_4776caf4(eventstruct) {
    if (eventstruct.weapon.name == "nightingale") {
        grenade = eventstruct.projectile;
        grenade waittill(#"grenade_bounce", #"death");
        if (!isdefined(grenade)) {
            return;
        }
        grenade thread function_db24f032();
        if (sessionmodeiszombiesgame()) {
            array::add(level.var_17d9f80, grenade);
        }
    }
}

// Namespace nightingale/nightingale
// Params 0, eflags: 0x1 linked
// Checksum 0x8f53f009, Offset: 0x1d8
// Size: 0xd4
function function_db24f032() {
    decoy = util::spawn_model(self.model, self.origin, self.angles);
    decoy linkto(self);
    self ghost();
    self thread scene::play(#"scene_grenade_decoy_footsteps", decoy);
    self waittill(#"death");
    if (isdefined(self)) {
        self scene::stop();
    }
    if (isdefined(decoy)) {
        decoy deletedelay();
    }
}

// Namespace nightingale/nightingale
// Params 1, eflags: 0x1 linked
// Checksum 0xf1d40bb0, Offset: 0x2b8
// Size: 0x7a
function function_29fbe24f(zombie) {
    arrayremovevalue(level.var_17d9f80, undefined);
    var_ed793fcb = undefined;
    if (level.var_17d9f80.size > 0) {
        var_ed793fcb = arraygetclosest(zombie.origin, level.var_17d9f80, 420);
    }
    return var_ed793fcb;
}

