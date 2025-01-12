#using scripts\core_common\system_shared;

#namespace radiant_live_update;

/#

    // Namespace radiant_live_update/radiant_live_update
    // Params 0, eflags: 0x2
    // Checksum 0xc855eb72, Offset: 0x70
    // Size: 0x3c
    function autoexec __init__system__() {
        system::register(#"radiant_live_update", &__init__, undefined, undefined);
    }

    // Namespace radiant_live_update/radiant_live_update
    // Params 0, eflags: 0x0
    // Checksum 0xbc19804d, Offset: 0xb8
    // Size: 0x1c
    function __init__() {
        thread scriptstruct_debug_render();
    }

    // Namespace radiant_live_update/radiant_live_update
    // Params 0, eflags: 0x0
    // Checksum 0xa462f631, Offset: 0xe0
    // Size: 0x7c
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
    // Checksum 0x8ab63f0b, Offset: 0x168
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
