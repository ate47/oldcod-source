#using scripts/core_common/array_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace multi_extracam;

// Namespace multi_extracam/multi_extracam
// Params 2, eflags: 0x0
// Checksum 0x743137a6, Offset: 0x150
// Size: 0xca
function extracam_reset_index(localclientnum, index) {
    if (!isdefined(level.camera_ents) || !isdefined(level.camera_ents[localclientnum])) {
        return;
    }
    if (isdefined(level.camera_ents[localclientnum][index])) {
        level.camera_ents[localclientnum][index] clearextracam();
        level.camera_ents[localclientnum][index] delete();
        level.camera_ents[localclientnum][index] = undefined;
    }
}

// Namespace multi_extracam/multi_extracam
// Params 3, eflags: 0x0
// Checksum 0x8f1c9f9e, Offset: 0x228
// Size: 0x62
function extracam_init_index(localclientnum, target, index) {
    camerastruct = struct::get(target, "targetname");
    return extracam_init_item(localclientnum, camerastruct, index);
}

// Namespace multi_extracam/multi_extracam
// Params 3, eflags: 0x0
// Checksum 0x69751f2a, Offset: 0x298
// Size: 0x1ae
function extracam_init_item(localclientnum, copy_ent, index) {
    if (!isdefined(level.camera_ents)) {
        level.camera_ents = [];
    }
    if (!isdefined(level.camera_ents[localclientnum])) {
        level.camera_ents[localclientnum] = [];
    }
    if (isdefined(level.camera_ents[localclientnum][index])) {
        level.camera_ents[localclientnum][index] clearextracam();
        level.camera_ents[localclientnum][index] delete();
        level.camera_ents[localclientnum][index] = undefined;
    }
    if (isdefined(copy_ent)) {
        level.camera_ents[localclientnum][index] = spawn(localclientnum, copy_ent.origin, "script_origin");
        level.camera_ents[localclientnum][index].angles = copy_ent.angles;
        level.camera_ents[localclientnum][index] setextracam(index);
        return level.camera_ents[localclientnum][index];
    }
    return undefined;
}

