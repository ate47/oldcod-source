#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;

#namespace pap_quest;

// Namespace pap_quest/zm_escape_pap_quest
// Params 0, eflags: 0x0
// Checksum 0x6183e612, Offset: 0x110
// Size: 0x64
function init() {
    level._effect[#"lightning_near"] = "maps/zm_escape/fx8_pap_lightning_near";
    level._effect[#"lightning_bridge"] = "maps/zm_escape/fx8_pap_lightning_bridge";
    init_clientfield();
}

// Namespace pap_quest/zm_escape_pap_quest
// Params 0, eflags: 0x0
// Checksum 0x2f2043db, Offset: 0x180
// Size: 0x10c
function init_clientfield() {
    clientfield::register("world", "" + #"lightning_near", 1, 1, "counter", &lightning_near_fx, 0, 0);
    clientfield::register("world", "" + #"lightning_far", 1, 1, "counter", &function_b72ac688, 0, 0);
    clientfield::register("scriptmover", "" + #"lightning_near", 1, 1, "counter", &lightning_near_fx, 0, 0);
}

// Namespace pap_quest/zm_escape_pap_quest
// Params 7, eflags: 0x0
// Checksum 0x5605b855, Offset: 0x298
// Size: 0xcc
function lightning_near_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (self == level) {
        s_lightning_near = struct::get("lightning_near");
        v_origin = s_lightning_near.origin;
    } else {
        v_origin = self.origin;
    }
    playfx(localclientnum, level._effect[#"lightning_near"], v_origin);
}

// Namespace pap_quest/zm_escape_pap_quest
// Params 7, eflags: 0x0
// Checksum 0x388498f2, Offset: 0x370
// Size: 0xec
function function_b72ac688(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    s_lightning_bridge = struct::get("lightning_bridge");
    playfx(localclientnum, level._effect[#"lightning_bridge"], s_lightning_bridge.origin, vectornormalize(anglestoforward(s_lightning_bridge.angles)), vectornormalize(anglestoup(s_lightning_bridge.angles)));
}

