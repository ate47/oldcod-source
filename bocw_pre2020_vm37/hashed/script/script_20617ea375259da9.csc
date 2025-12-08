#using script_644007a8c3885fc;
#using scripts\core_common\item_world_fixup;

#namespace namespace_654e3553;

// Namespace namespace_654e3553/namespace_654e3553
// Params 0, eflags: 0x2
// Checksum 0xc8f144d6, Offset: 0x70
// Size: 0x7a
function autoexec __init__()
{
    gametype = getdvarstring( #"g_gametype" );
    
    switch ( gametype )
    {
        case #"fireteam_dirty_bomb":
            function_cbbf16a4();
            break;
        default:
            break;
    }
}

// Namespace namespace_654e3553/namespace_654e3553
// Params 0
// Checksum 0xf04aa45, Offset: 0xf8
// Size: 0x10c
function function_cbbf16a4()
{
    var_a12b4736 = &item_world_fixup::function_96ff7b88;
    var_d2223309 = &item_world_fixup::function_261ab7f5;
    var_b5014996 = &item_world_fixup::function_19089c75;
    var_87d0eef8 = &item_world_fixup::remove_item;
    var_74257310 = &item_world_fixup::add_item_replacement;
    var_f8a4c541 = &item_world_fixup::function_6991057;
    var_edfbccd0 = &item_world_fixup::function_e70fa91c;
    namespace_1c7b37c6::item_replacer( var_b5014996, var_f8a4c541, #"hash_236440cd20c8be44", #"t9_empty_global" );
    namespace_1c7b37c6::item_replacer( var_b5014996, var_f8a4c541, #"hash_694cfad6e9e3f2e1", #"t9_empty_global" );
}

