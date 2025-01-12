#using scripts\core_common\system_shared;

#namespace radiant_live_update;

/#

    // Namespace radiant_live_update/radiant_live_update
    // Params 0, eflags: 0x6
    // Checksum 0xd7007678, Offset: 0x68
    // Size: 0x3c
    function private autoexec __init__system__() {
        system::register(#"radiant_live_update", &function_70a657d8, undefined, undefined, undefined);
    }

    // Namespace radiant_live_update/radiant_live_update
    // Params 0, eflags: 0x4
    // Checksum 0xba1f7ab2, Offset: 0xb0
    // Size: 0x1c
    function private function_70a657d8() {
        thread scriptstruct_debug_render();
    }

    // Namespace radiant_live_update/radiant_live_update
    // Params 0, eflags: 0x0
    // Checksum 0x75d493b, Offset: 0xd8
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
    // Checksum 0xfa4319c7, Offset: 0x168
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
