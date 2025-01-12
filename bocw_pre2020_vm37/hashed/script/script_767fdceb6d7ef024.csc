#using script_1f38e4dd404966a1;
#using script_312c65d6c946308;
#using scripts\core_common\aat_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\item_inventory;
#using scripts\core_common\util_shared;

#namespace ammomod_electriccherry;

// Namespace ammomod_electriccherry/ammomod_electriccherry
// Params 0, eflags: 0x1 linked
// Checksum 0x469b7559, Offset: 0x138
// Size: 0x9c
function function_4b66248d() {
    if (!is_true(level.aat_in_use)) {
        return;
    }
    aat::register("ammomod_electriccherry", #"hash_6c2c475aa887c056", "t7_icon_zm_aat_dead_wire");
    clientfield::register("allplayers", "ammomod_electric_cherry_explode", 1, 1, "counter", &electric_cherry_explode, 0, 0);
}

// Namespace ammomod_electriccherry/ammomod_electriccherry
// Params 7, eflags: 0x1 linked
// Checksum 0x31ce458d, Offset: 0x1e0
// Size: 0xa4
function electric_cherry_explode(localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    level endon(#"game_ended");
    electric_cherry_reload_fx = util::playfxontag(bwastimejump, "zombie/fx7_perk_electric_cherry_down", self, "tag_origin");
    wait 1;
    stopfx(bwastimejump, electric_cherry_reload_fx);
}

