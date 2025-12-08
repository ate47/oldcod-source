#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;

#namespace namespace_e85e312c;

// Namespace namespace_e85e312c
// Method(s) 3 Total 3
class class_6e09f777
{

    var var_5ee36218;

    // Namespace namespace_6e09f777/turret_dead_system
    // Params 1
    // Checksum 0xb74b0f01, Offset: 0x208
    // Size: 0x3c
    function function_860ebd20( var_8f7a5c75 )
    {
        var_5ee36218 = var_8f7a5c75;
        var_5ee36218 flag::wait_till( "vehicle_spawn_setup_complete" );
    }

}

// Namespace namespace_e85e312c/turret_dead_system
// Params 0, eflags: 0x6
// Checksum 0x73e6648e, Offset: 0x100
// Size: 0x4c
function private autoexec __init__system__()
{
    system::register( #"hash_4bbb330ecd0b67a8", &preinit, &postinit, undefined, undefined );
}

// Namespace namespace_e85e312c/turret_dead_system
// Params 0, eflags: 0x4
// Checksum 0x98ef1088, Offset: 0x158
// Size: 0x34
function private preinit()
{
    vehicle::add_spawn_function_group( "turret_dead_system", "script_turret_type", &function_33dd3fda );
}

// Namespace namespace_e85e312c/turret_dead_system
// Params 0, eflags: 0x4
// Checksum 0x80f724d1, Offset: 0x198
// Size: 0x4
function private postinit()
{
    
}

// Namespace namespace_e85e312c/turret_dead_system
// Params 0
// Checksum 0xcc6caa62, Offset: 0x1a8
// Size: 0x34
function function_33dd3fda()
{
    var_e85e312c = new class_6e09f777();
    [[ var_e85e312c ]]->function_860ebd20( self );
}

