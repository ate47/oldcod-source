#using script_1287f54612f9bfce;
#using script_355c6e84a79530cb;
#using script_3751b21462a54a7d;
#using script_7fc996fe8678852;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\item_inventory;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_utility;

#namespace namespace_c71c7ca5;

// Namespace namespace_c71c7ca5/namespace_c71c7ca5
// Params 0, eflags: 0x6
// Checksum 0x7b39fb55, Offset: 0x180
// Size: 0x54
function private autoexec __init__system__() {
    system::register(#"hash_59fd15f8f403c8b", &function_70a657d8, &postinit, undefined, #"hash_f81b9dea74f0ee");
}

// Namespace namespace_c71c7ca5/namespace_c71c7ca5
// Params 0, eflags: 0x1 linked
// Checksum 0x824d186a, Offset: 0x1e0
// Size: 0x4c
function function_70a657d8() {
    level.var_291ed71 = array(#"hash_25c21c498472d468", #"hash_4b717fb97cdcb15a", #"hash_cb1cfbaf811242");
}

// Namespace namespace_c71c7ca5/namespace_c71c7ca5
// Params 0, eflags: 0x1 linked
// Checksum 0x89e85915, Offset: 0x238
// Size: 0x84
function postinit() {
    var_f5ae494f = struct::get_array(#"content_destination", "variantname");
    if (zm_utility::is_classic() && isdefined(var_f5ae494f) && var_f5ae494f.size > 0) {
        level thread function_f72d912(var_f5ae494f[0]);
    }
}

// Namespace namespace_c71c7ca5/namespace_c71c7ca5
// Params 3, eflags: 0x1 linked
// Checksum 0xfc0b9811, Offset: 0x2c8
// Size: 0xc8
function function_1142ba4a(var_beee4994, *hint_string, *model) {
    if (!isdefined(model)) {
        return;
    }
    foreach (var_7d0e37f8 in model) {
        function_5be7e51b(var_7d0e37f8, "p9_sur_machine_computer", #"hash_545a7fa1ec400c83", &function_18aca533);
    }
}

// Namespace namespace_c71c7ca5/namespace_c71c7ca5
// Params 4, eflags: 0x1 linked
// Checksum 0xe0d220f0, Offset: 0x398
// Size: 0x2bc
function function_5be7e51b(struct, modelname, hint_string, callbackfunction) {
    assert(isstruct(struct), "<dev string:x38>");
    assert(isfunctionptr(callbackfunction), "<dev string:x56>");
    assert(isdefined(modelname), "<dev string:x7b>");
    assert(isdefined(hint_string), "<dev string:x9d>");
    scriptmodel = namespace_8b6a9d79::spawn_script_model(struct, modelname);
    if (zm_utility::is_survival()) {
        objid = gameobjects::get_next_obj_id();
        struct.objectiveid = objid;
        scriptmodel.objectiveid = objid;
        objective_add(objid, "active", scriptmodel, #"hash_3632525bd692cfc8");
        if (!isdefined(level.var_6bf8ee58)) {
            level.var_6bf8ee58 = [];
        } else if (!isarray(level.var_6bf8ee58)) {
            level.var_6bf8ee58 = array(level.var_6bf8ee58);
        }
        level.var_6bf8ee58[level.var_6bf8ee58.size] = objid;
    }
    trigger = namespace_8b6a9d79::function_214737c7(struct, callbackfunction, hint_string, undefined, 128, 128, 0, (0, 0, 50));
    trigger.scriptmodel = scriptmodel;
    scriptmodel.trigger = trigger;
    scriptmodel clientfield::set("safehouse_machine_spawn_rob", 1);
    scriptmodel playloopsound(#"hash_5f690620ca8d62bc");
    playsoundatposition(#"hash_5c2fc4437449ddb4", struct.origin);
    playfx("sr/fx9_safehouse_mchn_wonderfizz_spawn", struct.origin);
}

// Namespace namespace_c71c7ca5/namespace_c71c7ca5
// Params 1, eflags: 0x1 linked
// Checksum 0x40fe80fc, Offset: 0x660
// Size: 0x11c
function function_18aca533(*eventstruct) {
    if (isdefined(level.var_291ed71) && level.var_291ed71.size > 0) {
        playsoundatposition(#"hash_2306bc49a7e85ea2", self.scriptmodel.origin);
        playsoundatposition(level.var_291ed71[0], self.scriptmodel.origin);
        arrayremoveindex(level.var_291ed71, 0);
        if (isdefined(self.scriptmodel.objectiveid)) {
            objective_delete(self.scriptmodel.objectiveid);
        }
        waittillframeend();
        util::wait_network_frame();
        self delete();
    }
}

// Namespace namespace_c71c7ca5/namespace_c71c7ca5
// Params 1, eflags: 0x1 linked
// Checksum 0xf14b820e, Offset: 0x788
// Size: 0x44
function function_f72d912(destination) {
    level flag::wait_till("start_zombie_round_logic");
    waittillframeend();
    function_399aa551(destination);
}

// Namespace namespace_c71c7ca5/namespace_c71c7ca5
// Params 1, eflags: 0x1 linked
// Checksum 0xcf327b3a, Offset: 0x7d8
// Size: 0x16c
function function_399aa551(destination) {
    foreach (location in destination.locations) {
        var_ac97a756 = location.instances[#"hash_5aa51584db09513"];
        if (isdefined(var_ac97a756)) {
            children = namespace_8b6a9d79::function_f703a5a(var_ac97a756);
            foreach (child in children) {
                function_5be7e51b(child, "p9_sur_machine_computer", #"hash_545a7fa1ec400c83", &function_18aca533);
            }
        }
    }
}

