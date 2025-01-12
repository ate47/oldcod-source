#using scripts/core_common/ai_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/system_shared;

#namespace namespace_46de4034;

// Namespace namespace_46de4034/archetype_direwolf
// Params 0, eflags: 0x2
// Checksum 0xb86623a8, Offset: 0x160
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("direwolf", &__init__, undefined, undefined);
}

// Namespace namespace_46de4034/archetype_direwolf
// Params 0, eflags: 0x2
// Checksum 0xbc0bda3a, Offset: 0x1a0
// Size: 0x22
function autoexec precache() {
    level._effect["fx_bio_direwolf_eyes"] = "animals/fx_bio_direwolf_eyes";
}

// Namespace namespace_46de4034/archetype_direwolf
// Params 0, eflags: 0x0
// Checksum 0x6215df56, Offset: 0x1d0
// Size: 0x64
function __init__() {
    if (ai::shouldregisterclientfieldforarchetype("direwolf")) {
        clientfield::register("actor", "direwolf_eye_glow_fx", 1, 1, "int", &function_beea0195, 0, 1);
    }
}

// Namespace namespace_46de4034/archetype_direwolf
// Params 7, eflags: 0x4
// Checksum 0xad75f7e2, Offset: 0x240
// Size: 0x110
function private function_beea0195(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    entity = self;
    if (isdefined(entity.archetype) && entity.archetype != "direwolf") {
        return;
    }
    if (isdefined(entity.var_3efcb1a5)) {
        stopfx(localclientnum, entity.var_3efcb1a5);
        entity.var_3efcb1a5 = undefined;
    }
    if (newvalue) {
        entity.var_3efcb1a5 = playfxontag(localclientnum, level._effect["fx_bio_direwolf_eyes"], entity, "tag_eye");
    }
}

