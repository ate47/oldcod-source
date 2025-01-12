#using script_7fc996fe8678852;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_utility;

#namespace namespace_25297a8a;

// Namespace namespace_25297a8a/namespace_25297a8a
// Params 0, eflags: 0x6
// Checksum 0x96213dda, Offset: 0xb8
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"hash_4a495e6d62e549d9", &function_70a657d8, undefined, undefined, #"hash_f81b9dea74f0ee");
}

// Namespace namespace_25297a8a/namespace_25297a8a
// Params 0, eflags: 0x1 linked
// Checksum 0x476c7464, Offset: 0x108
// Size: 0x4c
function function_70a657d8() {
    if (!zm_utility::is_survival()) {
        return;
    }
    namespace_8b6a9d79::function_b3464a7c(#"hash_4a495e6d62e549d9", &function_d0a64706);
}

// Namespace namespace_25297a8a/namespace_25297a8a
// Params 1, eflags: 0x1 linked
// Checksum 0x86b7f27f, Offset: 0x160
// Size: 0x16c
function function_8adcc97a(destination) {
    var_ba9835cd = [];
    foreach (s_location in destination.locations) {
        if (namespace_8b6a9d79::function_fe9fb6fd(s_location)) {
            continue;
        }
        if (isdefined(s_location.instances[#"hash_4a495e6d62e549d9"])) {
            if (!isdefined(var_ba9835cd)) {
                var_ba9835cd = [];
            } else if (!isarray(var_ba9835cd)) {
                var_ba9835cd = array(var_ba9835cd);
            }
            var_ba9835cd[var_ba9835cd.size] = s_location.instances[#"hash_4a495e6d62e549d9"];
        }
    }
    s_instance = array::random(var_ba9835cd);
    if (isdefined(s_instance)) {
        namespace_8b6a9d79::function_20d7e9c7(s_instance);
    }
}

// Namespace namespace_25297a8a/namespace_25297a8a
// Params 1, eflags: 0x5 linked
// Checksum 0xea3eb4d0, Offset: 0x2d8
// Size: 0x162
function private function_d0a64706(s_instance) {
    var_7477dd11 = function_ba5f4279(s_instance);
    if (!isdefined(var_7477dd11)) {
        return;
    }
    struct = s_instance.var_fe2612fe[#"hash_1132c67c57349064"][0];
    scriptmodel = namespace_8b6a9d79::spawn_script_model(struct, struct.model);
    objid = gameobjects::get_next_obj_id();
    struct.var_e55c8b4e = objid;
    scriptmodel.var_e55c8b4e = objid;
    objective_add(objid, "active", scriptmodel, #"hash_5dbaa51e44605f76");
    trigger = namespace_8b6a9d79::function_214737c7(struct, &function_80998a51, #"hash_5eaeee593757c0b6", undefined, 128, 128, 0);
    trigger.var_7477dd11 = var_7477dd11;
    trigger.scriptmodel = scriptmodel;
    scriptmodel.trigger = trigger;
}

// Namespace namespace_25297a8a/namespace_25297a8a
// Params 1, eflags: 0x1 linked
// Checksum 0x19e82988, Offset: 0x448
// Size: 0x94
function function_80998a51(*eventstruct) {
    if (isdefined(self.var_7477dd11)) {
        playsoundatposition(self.var_7477dd11, self.scriptmodel.origin);
        objective_setinvisibletoall(self.scriptmodel.var_e55c8b4e);
        waittillframeend();
        util::wait_network_frame();
        self delete();
    }
}

// Namespace namespace_25297a8a/namespace_25297a8a
// Params 1, eflags: 0x1 linked
// Checksum 0xd9fd5682, Offset: 0x4e8
// Size: 0x222
function function_ba5f4279(s_instance) {
    foreach (group in level.var_7d45d0d4.var_5eba96b3) {
        foreach (instance in group) {
            if (instance.location.target === s_instance.location.target) {
                switch (instance.content_script_name) {
                case #"hash_3386f30228d9a983":
                default:
                    return #"hash_7eb2ae719a60bb0e";
                case #"destroy":
                    return #"hash_5be160f240ed208c";
                case #"kill_hvt":
                    return #"hash_5b28d61161f1596a";
                case #"payload_escort":
                    return #"hash_1d5819703b006c0a";
                case #"retrieval":
                    return #"hash_85fb02447e7053d";
                case #"secure":
                    return #"hash_5cb665542a8aaa76";
                case #"hash_3eb0da94cd242359":
                    return #"hash_1c7b4b312eedaec4";
                }
            }
        }
    }
}

