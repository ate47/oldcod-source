#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace namespace_84ec8f9b;

// Namespace namespace_84ec8f9b/namespace_84ec8f9b
// Params 0, eflags: 0x6
// Checksum 0xaae8cecc, Offset: 0x1a0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_33e10510941e7e77", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace namespace_84ec8f9b/namespace_84ec8f9b
// Params 0, eflags: 0x4
// Checksum 0x84f34281, Offset: 0x1e8
// Size: 0x94
function private function_70a657d8() {
    clientfield::register("scriptmover", "radiation_zone_intensity", 1, 3, "int", &function_ccb15cbe, 0, 0);
    clientfield::register("toplayer", "radiation_zone_intensity", 1, 3, "int", &function_69221469, 0, 1);
}

// Namespace namespace_84ec8f9b/namespace_84ec8f9b
// Params 7, eflags: 0x4
// Checksum 0x48ac7ec, Offset: 0x288
// Size: 0x10c
function private function_ccb15cbe(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self notify(#"hash_49ffd4b337ae771d");
    if (bwastimejump > 0) {
        compassicon = function_b9805f7c(bwastimejump);
        self setcompassicon(compassicon);
        self function_811196d1(0);
        self function_95bc465d(1);
        self function_60212003(0);
        self thread function_bd722387(fieldname);
        return;
    }
    self function_811196d1(1);
}

// Namespace namespace_84ec8f9b/namespace_84ec8f9b
// Params 7, eflags: 0x4
// Checksum 0x7d812ad4, Offset: 0x3a0
// Size: 0xec
function private function_69221469(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self notify(#"hash_49ffd4b337ae771d");
    if (bwastimejump > 0) {
        if (!function_148ccc79(fieldname, #"hash_3fc5123369b4c59f")) {
            function_a837926b(fieldname, #"hash_3fc5123369b4c59f");
            self thread function_9933c2e1(fieldname, #"hash_3fc5123369b4c59f");
        }
        return;
    }
    codestoppostfxbundlelocal(fieldname, #"hash_3fc5123369b4c59f");
}

// Namespace namespace_84ec8f9b/namespace_84ec8f9b
// Params 2, eflags: 0x4
// Checksum 0xa18884a1, Offset: 0x498
// Size: 0x54
function private function_9933c2e1(localclientnum, postfx) {
    self endon(#"hash_49ffd4b337ae771d");
    self waittill(#"death");
    codestoppostfxbundlelocal(localclientnum, postfx);
}

// Namespace namespace_84ec8f9b/namespace_84ec8f9b
// Params 1, eflags: 0x4
// Checksum 0x1dd191c6, Offset: 0x4f8
// Size: 0xa2
function private function_b9805f7c(intensity) {
    switch (intensity) {
    case 7:
        return "ui_icon_minimap_collapse_ring";
    case 1:
        return "ui_icon_minimap_radiation_intensity_1";
    case 2:
        return "ui_icon_minimap_radiation_intensity_2";
    case 3:
        return "ui_icon_minimap_radiation_intensity_3";
    case 4:
        return "ui_icon_minimap_radiation_intensity_4";
    }
    return "ui_icon_minimap_radiation_intensity_5";
}

// Namespace namespace_84ec8f9b/namespace_84ec8f9b
// Params 1, eflags: 0x4
// Checksum 0x94db6641, Offset: 0x5a8
// Size: 0x8e
function private function_bd722387(*localclientnum) {
    self endon(#"death", #"hash_49ffd4b337ae771d");
    while (true) {
        radius = 15000 * self.scale;
        compassscale = radius * 2;
        self function_5e00861(compassscale, 1);
        waitframe(1);
    }
}

