#using script_18b9d0e77614c97;
#using script_1d96ce237e3b4068;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\util_shared;

#namespace planemortar;

// Namespace planemortar/planemortar_shared
// Params 0, eflags: 0x0
// Checksum 0xd6cf0072, Offset: 0xf0
// Size: 0xf4
function init_shared() {
    if (!isdefined(level.var_6ea2bb2e)) {
        level.var_6ea2bb2e = {};
        clientfield::register("scriptmover", "planemortar_contrail", 1, 1, "int", &planemortar_contrail, 0, 0);
        clientfield::register_clientuimodel("hudItems.planeMortarShotsRemaining", #"hud_items", #"hash_569b707ceee60e2b", 1, 2, "int", undefined, 0, 0);
        streamer::function_d46dcfc2(#"hash_4ec0ec605a5b1cb0", 1, &function_719342ff, &function_611ebaf8);
    }
}

// Namespace planemortar/planemortar_shared
// Params 7, eflags: 0x0
// Checksum 0x1359965d, Offset: 0x1f0
// Size: 0xf2
function planemortar_contrail(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self endon(#"death");
    params = getscriptbundle("killstreak_planemortar");
    util::waittill_dobj(fieldname);
    if (bwastimejump) {
        self.fx = util::playfxontag(fieldname, params.var_dcbb40c5, self, params.var_d678978c);
        self.fx = util::playfxontag(fieldname, params.var_2375a152, self, params.var_e5082065);
    }
}

// Namespace planemortar/entity_spawned
// Params 1, eflags: 0x40
// Checksum 0xbc857580, Offset: 0x2f0
// Size: 0x54
function event_handler[entity_spawned] codecallback_entityspawned(*eventstruct) {
    if (self.weapon.name !== #"planemortar") {
        return;
    }
    streamer::force_stream(#"hash_4ec0ec605a5b1cb0");
}

// Namespace planemortar/planemortar_shared
// Params 0, eflags: 0x4
// Checksum 0xe405b63f, Offset: 0x350
// Size: 0x24
function private function_719342ff() {
    function_3385d776(#"hash_332122cbf3beacdf");
}

// Namespace planemortar/planemortar_shared
// Params 0, eflags: 0x4
// Checksum 0x67447161, Offset: 0x380
// Size: 0x24
function private function_611ebaf8() {
    function_c22a1ca2(#"hash_332122cbf3beacdf");
}

