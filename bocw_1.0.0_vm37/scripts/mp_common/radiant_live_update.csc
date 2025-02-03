#using scripts\core_common\system_shared;

#namespace radiant_live_update;

/#

    // Namespace radiant_live_update/radiant_live_update
    // Params 0, eflags: 0x6
    // Checksum 0x9ed6ca41, Offset: 0x68
    // Size: 0x3c
    function private autoexec __init__system__() {
        system::register(#"radiant_live_update", &preinit, undefined, undefined, undefined);
    }

    // Namespace radiant_live_update/radiant_live_update
    // Params 0, eflags: 0x4
    // Checksum 0x1101434f, Offset: 0xb0
    // Size: 0x1c
    function private preinit() {
        thread scriptstruct_debug_render();
    }

    // Namespace radiant_live_update/radiant_live_update
    // Params 0, eflags: 0x0
    // Checksum 0xc3b7fd1a, Offset: 0xd8
    // Size: 0x84
    function scriptstruct_debug_render() {
        while (true) {
            waitresult = level waittill(#"liveupdate");
            if (isdefined(waitresult.selected_struct)) {
                level thread render_struct(waitresult.selected_struct);
                continue;
            }
            level notify(#"stop_struct_render");
        }
    }

    // Namespace radiant_live_update/radiant_live_update
    // Params 1, eflags: 0x0
    // Checksum 0xbb0ddd6, Offset: 0x168
    // Size: 0x8e
    function render_struct(selected_struct) {
        self endon(#"stop_struct_render");
        if (!isdefined(selected_struct.origin)) {
            return;
        }
        while (isdefined(selected_struct)) {
            box(selected_struct.origin, (-16, -16, -16), (16, 16, 16), 0, (1, 0.4, 0.4));
            waitframe(1);
        }
    }

#/
