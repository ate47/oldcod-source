#using script_4daa124bc391e7ed;
#using scripts\core_common\renderoverridebundle;
#using scripts\killstreaks\killstreak_detect;

#namespace killstreak_bundles;

// Namespace killstreak_bundles/killstreak_bundles
// Params 2, eflags: 0x1 linked
// Checksum 0xc7050bdd, Offset: 0x78
// Size: 0xf4
function spawned(local_client_num, bundle) {
    self.var_22a05c26 = bundle;
    if (isdefined(bundle.var_7249d50f) && bundle.var_7249d50f > 0) {
        self enablevisioncircle(local_client_num, bundle.var_7249d50f);
    }
    if (bundle.var_101cf227 === 1) {
        self enableonradar();
    }
    if (bundle.var_101cf227 === 1) {
        self enableonradar();
    }
    if (bundle.var_bea37bdc === 1) {
        self namespace_9bcd7d72::function_bdda909b();
    }
    killstreak_detect::function_8ac48939(bundle);
}

// Namespace killstreak_bundles/killstreak_bundles
// Params 0, eflags: 0x1 linked
// Checksum 0x14ed81f8, Offset: 0x178
// Size: 0xa
function function_48e9536e() {
    return self.var_22a05c26;
}

