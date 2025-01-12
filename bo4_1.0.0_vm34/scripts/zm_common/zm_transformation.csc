#using scripts\core_common\ai_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace zm_transform;

// Namespace zm_transform/zm_transformation
// Params 0, eflags: 0x2
// Checksum 0x6f9f495b, Offset: 0xc8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_transform", &__init__, undefined, undefined);
}

// Namespace zm_transform/zm_transformation
// Params 0, eflags: 0x0
// Checksum 0x7e768117, Offset: 0x110
// Size: 0x94
function __init__() {
    clientfield::register("actor", "transformation_spawn", 1, 1, "int", &function_85664731, 0, 0);
    clientfield::register("actor", "transformation_stream_split", 1, 1, "int", &function_8d548811, 0, 0);
}

// Namespace zm_transform/zm_transformation
// Params 7, eflags: 0x0
// Checksum 0xfa53881e, Offset: 0x1b0
// Size: 0x74
function function_85664731(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self playrenderoverridebundle(isdefined(self.var_d7aceec1) ? self.var_d7aceec1 : #"hash_435832b390f73dff");
}

// Namespace zm_transform/zm_transformation
// Params 7, eflags: 0x0
// Checksum 0xbd13e6dd, Offset: 0x230
// Size: 0x156
function function_8d548811(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        settingsbundle = self ai::function_a0dbf10a();
        if (isdefined(settingsbundle) && isdefined(settingsbundle.var_7e53f5f9)) {
            foreach (var_e27d1aca in settingsbundle.var_7e53f5f9) {
                if (self.model === var_e27d1aca.var_6120fa15) {
                    util::lock_model(var_e27d1aca.var_174f1680);
                    self thread function_e349df2e(var_e27d1aca.var_174f1680);
                    break;
                }
            }
        }
        return;
    }
    self notify(#"unlock_model");
}

// Namespace zm_transform/zm_transformation
// Params 1, eflags: 0x0
// Checksum 0x313b778b, Offset: 0x390
// Size: 0x4c
function function_e349df2e(model) {
    self waittilltimeout(60, #"death", #"unlock_model");
    util::unlock_model(model);
}

