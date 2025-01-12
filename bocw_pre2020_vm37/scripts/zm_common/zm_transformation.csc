#using script_31816d064a53f516;
#using scripts\core_common\ai_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace zm_transform;

// Namespace zm_transform/zm_transformation
// Params 0, eflags: 0x4
// Checksum 0x438aaeb7, Offset: 0xd0
// Size: 0x94
function private function_70a657d8() {
    clientfield::register("actor", "transformation_spawn", 1, 1, "int", &function_201c2cb7, 0, 0);
    clientfield::register("actor", "transformation_stream_split", 1, 1, "int", &function_341e5a97, 0, 0);
}

// Namespace zm_transform/zm_transformation
// Params 7, eflags: 0x1 linked
// Checksum 0x6d6d917a, Offset: 0x170
// Size: 0x74
function function_201c2cb7(*localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self playrenderoverridebundle(isdefined(self.var_fab3cf78) ? self.var_fab3cf78 : #"hash_435832b390f73dff");
}

// Namespace zm_transform/zm_transformation
// Params 7, eflags: 0x1 linked
// Checksum 0x20bcc240, Offset: 0x1f0
// Size: 0x15e
function function_341e5a97(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        settingsbundle = self ai::function_9139c839();
        if (isdefined(settingsbundle) && isdefined(settingsbundle.var_d354164e)) {
            foreach (var_127d3a7a in settingsbundle.var_d354164e) {
                if (self.model === var_127d3a7a.var_a3c9023c) {
                    util::lock_model(var_127d3a7a.var_cdf1f53d);
                    self thread function_8a817bd6(var_127d3a7a.var_cdf1f53d);
                    break;
                }
            }
        }
        return;
    }
    self notify(#"unlock_model");
}

// Namespace zm_transform/zm_transformation
// Params 1, eflags: 0x1 linked
// Checksum 0xa94b59b9, Offset: 0x358
// Size: 0x4c
function function_8a817bd6(model) {
    self waittilltimeout(60, #"death", #"unlock_model");
    util::unlock_model(model);
}

