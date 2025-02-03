#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\weapons\weaponobjects;

#namespace hatchet;

// Namespace hatchet/hatchet
// Params 0, eflags: 0x6
// Checksum 0xc1ad55c7, Offset: 0x98
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hatchet", &init_shared, undefined, undefined, undefined);
}

// Namespace hatchet/hatchet
// Params 0, eflags: 0x0
// Checksum 0x11685bb7, Offset: 0xe0
// Size: 0x3c
function init_shared() {
    weaponobjects::function_e6400478(#"hatchet", &function_1679806a, 1);
}

// Namespace hatchet/hatchet
// Params 1, eflags: 0x0
// Checksum 0x52ebc69f, Offset: 0x128
// Size: 0xda
function function_1679806a(s_watcher) {
    s_watcher.onspawn = &function_16a186f;
    s_watcher.ondamage = &util::void;
    if (sessionmodeiszombiesgame()) {
        s_watcher.onspawnretrievetriggers = &function_4ba658e5;
        s_watcher.pickup = &function_4ba658e5;
    } else {
        s_watcher.onspawnretrievetriggers = &weaponobjects::function_23b0aea9;
        s_watcher.pickup = &weaponobjects::function_d9219ce2;
    }
    s_watcher.ontimeout = &function_27ae0902;
    s_watcher.onfizzleout = &function_27ae0902;
}

// Namespace hatchet/hatchet
// Params 0, eflags: 0x0
// Checksum 0x6e992e4f, Offset: 0x210
// Size: 0x9c
function function_27ae0902() {
    e_fx = spawn("script_model", self.origin);
    e_fx setmodel(#"tag_origin");
    e_fx.angles = self.angles;
    playfxontag(#"hash_522eb6eca07bfe70", e_fx, "tag_origin");
    self delete();
}

// Namespace hatchet/hatchet
// Params 2, eflags: 0x0
// Checksum 0x9e8a4968, Offset: 0x2b8
// Size: 0x38
function function_16a186f(*s_watcher, player) {
    if (isdefined(level.playthrowhatchet)) {
        player [[ level.playthrowhatchet ]]();
    }
}

// Namespace hatchet/hatchet
// Params 2, eflags: 0x0
// Checksum 0x2ad31648, Offset: 0x2f8
// Size: 0x14
function function_4ba658e5(*s_watcher, *player) {
    
}

