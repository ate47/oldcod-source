#using scripts\core_common\callbacks_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;

#namespace multi_extracam;

// Namespace multi_extracam/multi_extracam
// Params 0, eflags: 0x6
// Checksum 0xdae20a50, Offset: 0xb8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"multi_extracam", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace multi_extracam/multi_extracam
// Params 0, eflags: 0x5 linked
// Checksum 0x74d95f57, Offset: 0x100
// Size: 0x24
function private function_70a657d8() {
    callback::on_localclient_connect(&multi_extracam_init);
}

// Namespace multi_extracam/multi_extracam
// Params 1, eflags: 0x1 linked
// Checksum 0xb255ef34, Offset: 0x130
// Size: 0x15c
function multi_extracam_init(localclientnum) {
    triggers = getentarray(localclientnum, "multicam_enable", "targetname");
    for (i = 1; i <= 4; i++) {
        camerastruct = struct::get("extracam" + i, "targetname");
        if (isdefined(camerastruct)) {
            camera_ent = spawn(localclientnum, camerastruct.origin, "script_origin");
            camera_ent.angles = camerastruct.angles;
            width = isdefined(camerastruct.extracam_width) ? camerastruct.extracam_width : -1;
            height = isdefined(camerastruct.extracam_height) ? camerastruct.extracam_height : -1;
            camera_ent setextracam(i - 1, width, height);
        }
    }
}

