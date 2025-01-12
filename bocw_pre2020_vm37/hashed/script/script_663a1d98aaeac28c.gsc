#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\weapons\weaponobjects;

#namespace hatchet;

// Namespace hatchet/hatchet
// Params 0, eflags: 0x6
// Checksum 0x895bf09, Offset: 0x98
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hatchet", &init_shared, undefined, undefined, undefined);
}

// Namespace hatchet/hatchet
// Params 0, eflags: 0x1 linked
// Checksum 0x20e7f055, Offset: 0xe0
// Size: 0x3c
function init_shared() {
    weaponobjects::function_e6400478(#"hatchet", &function_1679806a, 1);
}

// Namespace hatchet/hatchet
// Params 1, eflags: 0x1 linked
// Checksum 0x3ae4165e, Offset: 0x128
// Size: 0x9a
function function_1679806a(s_watcher) {
    s_watcher.onspawn = &function_16a186f;
    s_watcher.ondamage = &util::void;
    s_watcher.onspawnretrievetriggers = &weaponobjects::function_23b0aea9;
    s_watcher.ontimeout = &function_27ae0902;
    s_watcher.pickup = &weaponobjects::function_d9219ce2;
    s_watcher.onfizzleout = &function_27ae0902;
}

// Namespace hatchet/hatchet
// Params 0, eflags: 0x1 linked
// Checksum 0x85cad3e3, Offset: 0x1d0
// Size: 0x9c
function function_27ae0902() {
    e_fx = spawn("script_model", self.origin);
    e_fx setmodel(#"tag_origin");
    e_fx.angles = self.angles;
    playfxontag(#"hash_522eb6eca07bfe70", e_fx, "tag_origin");
    self delete();
}

// Namespace hatchet/hatchet
// Params 2, eflags: 0x1 linked
// Checksum 0xc05e844f, Offset: 0x278
// Size: 0x38
function function_16a186f(*s_watcher, player) {
    if (isdefined(level.playthrowhatchet)) {
        player [[ level.playthrowhatchet ]]();
    }
}

