#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace cinematicmotion;

// Namespace cinematicmotion/namespace_345fff71
// Params 0, eflags: 0x6
// Checksum 0x1c3d5cf7, Offset: 0xa0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"cinematicmotion", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace cinematicmotion/namespace_345fff71
// Params 0, eflags: 0x1 linked
// Checksum 0x34b07f8, Offset: 0xe8
// Size: 0x54
function function_70a657d8() {
    n_bits = getminbitcountfornum(11);
    clientfield::register("toplayer", "cinematicMotion", 1, n_bits, "int");
}

// Namespace cinematicmotion/namespace_345fff71
// Params 1, eflags: 0x1 linked
// Checksum 0x53f35f49, Offset: 0x148
// Size: 0x2ea
function function_92dd9a20(param) {
    if (!isplayer(self)) {
        return;
    }
    switch (param) {
    case #"hash_5a4e4aa2a78f38a5":
        self clientfield::set_to_player("cinematicMotion", 0);
        break;
    case #"hash_5a4e49a2a78f36f2":
        self clientfield::set_to_player("cinematicMotion", 1);
        break;
    case #"hash_5a4e48a2a78f353f":
        self clientfield::set_to_player("cinematicMotion", 2);
        break;
    case #"hash_5a4e47a2a78f338c":
        self clientfield::set_to_player("cinematicMotion", 3);
        break;
    case #"hash_5a4e46a2a78f31d9":
        self clientfield::set_to_player("cinematicMotion", 4);
        break;
    case #"hash_5a4e45a2a78f3026":
        self clientfield::set_to_player("cinematicMotion", 5);
        break;
    case #"hash_1f2696a2ce6d028b":
        self clientfield::set_to_player("cinematicMotion", 6);
        break;
    case #"hash_1f2695a2ce6d00d8":
        self clientfield::set_to_player("cinematicMotion", 7);
        break;
    case #"hash_1f2698a2ce6d05f1":
        self clientfield::set_to_player("cinematicMotion", 8);
        break;
    case #"hash_1f2697a2ce6d043e":
        self clientfield::set_to_player("cinematicMotion", 9);
        break;
    case #"hash_1f269aa2ce6d0957":
        self clientfield::set_to_player("cinematicMotion", 10);
        break;
    case #"hash_1f2699a2ce6d07a4":
        self clientfield::set_to_player("cinematicMotion", 11);
        break;
    default:
        break;
    }
}

// Namespace cinematicmotion/namespace_345fff71
// Params 1, eflags: 0x1 linked
// Checksum 0x76e8d3b4, Offset: 0x440
// Size: 0x64
function function_bbf6e778(param) {
    if (!isplayer(self)) {
        return;
    }
    if (param != "") {
        self setcinematicmotionoverride(param);
        return;
    }
    self setcinematicmotionoverride();
}

