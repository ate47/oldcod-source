#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace wz_ai_utils;

// Namespace wz_ai_utils/wz_ai_utils
// Params 0, eflags: 0x2
// Checksum 0x3bd059ce, Offset: 0xa0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"wz_ai_utils", &__init__, undefined, undefined);
}

// Namespace wz_ai_utils/wz_ai_utils
// Params 0, eflags: 0x0
// Checksum 0xf7faaad0, Offset: 0xe8
// Size: 0xaa
function __init__() {
    clientfield::register("scriptmover", "aizoneflag", 1, 1, "int", &function_bff4114a, 0, 0);
    level._effect[#"hash_2ff87d61167ea531"] = #"hash_d66a9f5776f1fba";
    level._effect[#"hash_4048cb4967032c4a"] = #"hash_1e43d43c6586fcb5";
}

// Namespace wz_ai_utils/wz_ai_utils
// Params 7, eflags: 0x0
// Checksum 0x3c555c5a, Offset: 0x1a0
// Size: 0x13e
function function_bff4114a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        /#
            self setcompassicon("<dev string:x30>");
            self function_636e7d72(0);
        #/
        playfx(localclientnum, level._effect[#"hash_4048cb4967032c4a"], self.origin);
        self.var_97535e9d = playfx(localclientnum, level._effect[#"hash_2ff87d61167ea531"], self.origin);
        return;
    }
    /#
        self function_636e7d72(1);
    #/
    stopfx(localclientnum, self.var_97535e9d);
    self.var_97535e9d = undefined;
}

