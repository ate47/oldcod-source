#using scripts\core_common\spawner_shared;
#using scripts\core_common\system_shared;
#using scripts\zm\ai\zm_ai_brutus;
#using scripts\zm_common\zm_devgui;

#namespace namespace_165f18d5;

// Namespace namespace_165f18d5/namespace_165f18d5
// Params 0, eflags: 0x2
// Checksum 0x9de83ca5, Offset: 0xd0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"hash_2e2fcde8843638d9", &__init__, undefined, undefined);
}

// Namespace namespace_165f18d5/namespace_165f18d5
// Params 0, eflags: 0x4
// Checksum 0x82377b80, Offset: 0x118
// Size: 0x44
function private __init__() {
    spawner::add_archetype_spawn_function("brutus", &function_dda5e009);
    /#
        function_1cbb3aba();
    #/
}

// Namespace namespace_165f18d5/namespace_165f18d5
// Params 0, eflags: 0x4
// Checksum 0x93e4efae, Offset: 0x168
// Size: 0x3c
function private function_dda5e009() {
    if (self.var_ea94c12a !== "brutus_special") {
        return;
    }
    self attach("c_t8_zmb_mob_brutus_boss_baton", "tag_weapon_right");
}

/#

    // Namespace namespace_165f18d5/namespace_165f18d5
    // Params 0, eflags: 0x4
    // Checksum 0x4e98c61c, Offset: 0x1b0
    // Size: 0x5c
    function private function_1cbb3aba() {
        adddebugcommand("<dev string:x30>");
        adddebugcommand("<dev string:x7f>");
        zm_devgui::add_custom_devgui_callback(&function_d651328f);
    }

    // Namespace namespace_165f18d5/namespace_165f18d5
    // Params 1, eflags: 0x4
    // Checksum 0x6f4d1580, Offset: 0x218
    // Size: 0x1e2
    function private function_d651328f(cmd) {
        switch (cmd) {
        case #"hash_3b5a33d5b7ae4e80":
            spawners = getspawnerarray();
            foreach (spawner in spawners) {
                if (spawner.var_ea94c12a === "<dev string:xd0>" && isdefined(spawner.script_noteworthy)) {
                    zm_devgui::spawn_archetype(spawner.script_noteworthy);
                    break;
                }
            }
            break;
        case #"hash_2e229b658a79d09f":
            brutuses = getaiarchetypearray("<dev string:xdf>");
            foreach (brutus in brutuses) {
                if (brutus.var_ea94c12a === "<dev string:xd0>") {
                    brutus kill(undefined, undefined, undefined, undefined, 0, 1);
                }
            }
            break;
        default:
            break;
        }
    }

#/
