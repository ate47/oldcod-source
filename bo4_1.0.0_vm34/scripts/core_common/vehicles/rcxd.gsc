#using scripts\core_common\system_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicles\smart_bomb;

#namespace rcxd;

// Namespace rcxd/rcxd
// Params 0, eflags: 0x2
// Checksum 0x2b9a28aa, Offset: 0xb8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"rcxd", &__init__, undefined, undefined);
}

// Namespace rcxd/rcxd
// Params 0, eflags: 0x0
// Checksum 0x61e7155, Offset: 0x100
// Size: 0x2c
function __init__() {
    vehicle::add_main_callback("rcxd", &function_7619e01);
}

// Namespace rcxd/rcxd
// Params 0, eflags: 0x0
// Checksum 0xd9aeae30, Offset: 0x138
// Size: 0x8c
function function_7619e01() {
    smart_bomb::function_353b9cf8();
    self.detonate_sides_disabled = 1;
    self useanimtree("generic");
    self initsounds();
    if (isdefined(level.vehicle_initializer_cb)) {
        [[ level.vehicle_initializer_cb ]](self);
    }
    defaultrole();
}

// Namespace rcxd/rcxd
// Params 0, eflags: 0x0
// Checksum 0x64cef4f7, Offset: 0x1d0
// Size: 0x10c
function defaultrole() {
    self vehicle_ai::init_state_machine_for_role("default");
    self vehicle_ai::get_state_callbacks("combat").update_func = &smart_bomb::state_combat_update;
    self vehicle_ai::get_state_callbacks("driving").update_func = &smart_bomb::state_scripted_update;
    self vehicle_ai::get_state_callbacks("death").update_func = &smart_bomb::state_death_update;
    self vehicle_ai::get_state_callbacks("emped").update_func = &smart_bomb::state_emped_update;
    self vehicle_ai::call_custom_add_state_callbacks();
    vehicle_ai::startinitialstate("combat");
}

// Namespace rcxd/rcxd
// Params 0, eflags: 0x0
// Checksum 0x2a8c75f7, Offset: 0x2e8
// Size: 0x19e
function initsounds() {
    self.sndalias = [];
    self.sndalias[#"inair"] = #"hash_65ec2e5d43b62423";
    self.sndalias[#"land"] = #"hash_26fddc98c4b5aa5a";
    self.sndalias[#"spawn"] = #"hash_1b30b26c406054e2";
    self.sndalias[#"direction"] = #"hash_69f9a2b48dccef90";
    self.sndalias[#"jump_up"] = #"hash_43b08a05140c0ea9";
    self.sndalias[#"vehclose250"] = #"hash_7a70a6fa72ea121";
    self.sndalias[#"vehclose1500"] = #"hash_548fbad0d3c63e20";
    self.sndalias[#"vehtargeting"] = #"hash_29426008ddf3da16";
    self.sndalias[#"vehalarm"] = #"hash_4966894e7ae3a222";
    self.sndalias[#"vehcollision"] = #"veh_wasp_wall_imp";
}

