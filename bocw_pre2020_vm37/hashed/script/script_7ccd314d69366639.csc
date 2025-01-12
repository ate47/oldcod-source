#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\util_shared;

#namespace objective_retrieval;

// Namespace objective_retrieval/level_init
// Params 1, eflags: 0x40
// Checksum 0xafb097be, Offset: 0xa0
// Size: 0xd4
function event_handler[level_init] main(*eventstruct) {
    clientfield::register("toplayer", "" + #"hash_24d873496283af6e", 1, 1, "int", &function_5ea9ba5d, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_24d873496283af6e", 1, 1, "int", &function_5ea9ba5d, 0, 0);
    util::waitforclient(0);
}

// Namespace objective_retrieval/objective_retrieval
// Params 7, eflags: 0x0
// Checksum 0xdb126525, Offset: 0x180
// Size: 0x15c
function function_5ea9ba5d(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump == 1) {
        if (self isplayer()) {
            self postfx::playpostfxbundle(#"pstfx_speedblur");
            self function_116b95e5(#"pstfx_speedblur", #"inner mask", 0.3);
            self function_116b95e5(#"pstfx_speedblur", #"outer mask", 0.8);
            self thread function_d233fb1f();
        }
        return;
    }
    if (self isplayer()) {
        self notify(#"hash_639f680ae2bb2ff");
        wait 0.05;
        self postfx::exitpostfxbundle(#"pstfx_speedblur");
    }
}

// Namespace objective_retrieval/objective_retrieval
// Params 0, eflags: 0x0
// Checksum 0xc6cb25d0, Offset: 0x2e8
// Size: 0x114
function function_d233fb1f() {
    self endon(#"death", #"disconnect", #"hash_639f680ae2bb2ff");
    var_9b8a1091 = 0.01;
    while (true) {
        self function_116b95e5(#"pstfx_speedblur", #"blur", var_9b8a1091);
        wait 0.08;
        var_9b8a1091 += 0.01;
        if (var_9b8a1091 > 0.1) {
            while (var_9b8a1091 > 0) {
                var_9b8a1091 -= 0.01;
                self function_116b95e5(#"pstfx_speedblur", #"blur", var_9b8a1091);
                wait 0.08;
            }
        }
    }
}

