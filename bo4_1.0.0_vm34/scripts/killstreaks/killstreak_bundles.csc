#using script_4daa124bc391e7ed;
#using scripts\core_common\renderoverridebundle;
#using scripts\killstreaks\killstreak_detect;

#namespace killstreak_bundles;

// Namespace killstreak_bundles/killstreak_bundles
// Params 2, eflags: 0x0
// Checksum 0xcd9f7d27, Offset: 0x80
// Size: 0x12c
function spawned(local_client_num, bundle) {
    self.var_63a22f1e = bundle;
    if (isdefined(bundle.var_52891e09) && bundle.var_52891e09 > 0) {
        self enablevisioncircle(local_client_num, bundle.var_52891e09);
    }
    if (bundle.var_b38b3ea4 === 1) {
        self enableonradar();
    }
    if (bundle.var_b38b3ea4 === 1) {
        self enableonradar();
    }
    if (bundle.var_8e9758bf === 1) {
        self namespace_104bbcd1::function_1773d7da();
    }
    killstreak_detect::function_296548cf(bundle);
    renderoverridebundle::function_15e70783(local_client_num, #"friendly", #"hash_ebb37dab2ee0ae3");
}

// Namespace killstreak_bundles/killstreak_bundles
// Params 0, eflags: 0x0
// Checksum 0x396e7b5e, Offset: 0x1b8
// Size: 0xa
function function_bf8322cd() {
    return self.var_63a22f1e;
}

