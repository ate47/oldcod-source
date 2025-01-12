#using scripts\core_common\system_shared;

#namespace namespace_e579bb10;

// Namespace namespace_e579bb10/namespace_e579bb10
// Params 0, eflags: 0x6
// Checksum 0x2bfc0863, Offset: 0x90
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_2ceee52ce883fbc2", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace namespace_e579bb10/namespace_e579bb10
// Params 0, eflags: 0x5 linked
// Checksum 0x80f724d1, Offset: 0xd8
// Size: 0x4
function private function_70a657d8() {
    
}

// Namespace namespace_e579bb10/namespace_e579bb10
// Params 0, eflags: 0x1 linked
// Checksum 0x9df730bd, Offset: 0xe8
// Size: 0x94
function function_9b8847dd() {
    if (level.var_db91e97c === 1) {
        level.hawk_settings.bundle = getscriptbundle("hawk_settings_hpc");
    } else {
        level.hawk_settings.bundle = getscriptbundle("hawk_settings");
    }
    assert(isdefined(level.hawk_settings.bundle));
}

