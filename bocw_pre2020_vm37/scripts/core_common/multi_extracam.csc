#using scripts\core_common\struct;

#namespace multi_extracam;

// Namespace multi_extracam/multi_extracam
// Params 2, eflags: 0x1 linked
// Checksum 0xd36f6dbe, Offset: 0x88
// Size: 0xb6
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
// Params 3, eflags: 0x1 linked
// Checksum 0x2c0b4f39, Offset: 0x148
// Size: 0x5a
function extracam_init_index(localclientnum, target, index) {
    camerastruct = struct::get(target, "targetname");
    return extracam_init_item(localclientnum, camerastruct, index);
}

// Namespace multi_extracam/multi_extracam
// Params 3, eflags: 0x1 linked
// Checksum 0xe37d9ba7, Offset: 0x1b0
// Size: 0x16a
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

