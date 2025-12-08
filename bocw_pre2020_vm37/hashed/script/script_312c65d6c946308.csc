#using scripts\core_common\struct;

#namespace namespace_e86ffa8;

// Namespace namespace_e86ffa8/namespace_e86ffa8
// Params 1
// Checksum 0x1ad24eba, Offset: 0x68
// Size: 0x2fa
function function_e75318e9( var_c1c9cf07 )
{
    switch ( var_c1c9cf07 )
    {
        case #"hash_47d7a8105237c88":
        case #"talent_deadshot":
        case #"talent_elemental_pop":
        case #"talent_doubletap":
        case #"talent_staminup":
        case #"talent_speedcola":
        case #"talent_quickrevive":
            return 0;
        case #"hash_504b41f717f8931a":
        case #"hash_1f95b48e4a49df4a":
        case #"hash_afdc97f440fbcec":
        case #"talent_doubletap":
        case #"hash_17ccbaee64daa05b":
        case #"talent_elemental_pop_1":
        case #"hash_520b5db0216b778a":
            return 1;
        case #"hash_afdcc7f440fc205":
        case #"hash_504b40f717f89167":
        case #"hash_520b5cb0216b75d7":
        case #"hash_17ccbbee64daa20e":
        case #"talent_elemental_pop_2":
        case #"hash_1f95b38e4a49dd97":
        case #"talent_doubletap":
            return 2;
        case #"hash_afdcb7f440fc052":
        case #"hash_17ccbcee64daa3c1":
        case #"hash_504b3ff717f88fb4":
        case #"talent_doubletap":
        case #"hash_1f95b28e4a49dbe4":
        case #"talent_elemental_pop_3":
        case #"hash_520b5bb0216b7424":
            return 3;
        case #"hash_afdc67f440fb7d3":
        case #"talent_doubletap":
        case #"hash_520b5ab0216b7271":
        case #"hash_1f95b18e4a49da31":
        case #"hash_504b3ef717f88e01":
        case #"hash_17ccbdee64daa574":
        case #"talent_elemental_pop_4":
            return 4;
        case #"hash_afdc57f440fb620":
        case #"talent_doubletap":
        case #"hash_520b59b0216b70be":
        case #"hash_504b3df717f88c4e":
        case #"hash_1f95b08e4a49d87e":
        case #"hash_17ccbeee64daa727":
        case #"talent_elemental_pop_5":
            return 5;
    }
}

// Namespace namespace_e86ffa8/namespace_e86ffa8
// Params 1
// Checksum 0x47b853ea, Offset: 0x370
// Size: 0x2c2
function function_cde018a9( var_c1c9cf07 )
{
    switch ( var_c1c9cf07 )
    {
        case #"hash_47d7a8105237c88":
        case #"hash_afdc57f440fb620":
        case #"hash_afdc67f440fb7d3":
        case #"hash_afdc97f440fbcec":
        case #"hash_afdcb7f440fc052":
        case #"hash_afdcc7f440fc205":
            return #"hash_47d7a8105237c88";
        case #"hash_504b3ef717f88e01":
        case #"hash_504b3ff717f88fb4":
        case #"hash_504b40f717f89167":
        case #"hash_504b41f717f8931a":
        case #"talent_quickrevive":
        case #"hash_504b3df717f88c4e":
            return #"talent_quickrevive";
        case #"hash_520b59b0216b70be":
        case #"hash_520b5ab0216b7271":
        case #"hash_520b5bb0216b7424":
        case #"hash_520b5cb0216b75d7":
        case #"hash_520b5db0216b778a":
        case #"talent_speedcola":
            return #"talent_speedcola";
        case #"hash_1f95b08e4a49d87e":
        case #"hash_1f95b18e4a49da31":
        case #"hash_1f95b28e4a49dbe4":
        case #"hash_1f95b38e4a49dd97":
        case #"hash_1f95b48e4a49df4a":
        case #"talent_deadshot":
            return #"talent_deadshot";
        case #"hash_17ccbaee64daa05b":
        case #"hash_17ccbbee64daa20e":
        case #"hash_17ccbcee64daa3c1":
        case #"hash_17ccbdee64daa574":
        case #"hash_17ccbeee64daa727":
        case #"talent_staminup":
            return #"talent_staminup";
        case #"talent_elemental_pop_2":
        case #"talent_elemental_pop_3":
        case #"talent_elemental_pop_1":
        case #"talent_elemental_pop_4":
        case #"talent_elemental_pop_5":
        case #"talent_elemental_pop":
            return #"talent_elemental_pop";
    }
}

// Namespace namespace_e86ffa8/namespace_e86ffa8
// Params 2
// Checksum 0xc8bbbac4, Offset: 0x640
// Size: 0x1bc, Type: bool
function function_efb6dedf( localclientnum, n_level = 0 )
{
    if ( self hastalent( localclientnum, #"hash_520b59b0216b70be" ) )
    {
        return true;
    }
    else if ( self hastalent( localclientnum, #"hash_520b5ab0216b7271" ) && n_level <= 4 )
    {
        return true;
    }
    else if ( self hastalent( localclientnum, #"hash_520b5bb0216b7424" ) && n_level <= 3 )
    {
        return true;
    }
    else if ( self hastalent( localclientnum, #"hash_520b5cb0216b75d7" ) && n_level <= 2 )
    {
        return true;
    }
    else if ( self hastalent( localclientnum, #"hash_520b5db0216b778a" ) && n_level == 1 )
    {
        return true;
    }
    else if ( self hastalent( localclientnum, #"talent_speedcola" ) && n_level == 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_e86ffa8/namespace_e86ffa8
// Params 2
// Checksum 0x107ce2e2, Offset: 0x808
// Size: 0x1bc, Type: bool
function function_3623f9d1( localclientnum, n_level = 0 )
{
    if ( self hastalent( localclientnum, #"hash_17ccbeee64daa727" ) )
    {
        return true;
    }
    else if ( self hastalent( localclientnum, #"hash_17ccbdee64daa574" ) && n_level <= 4 )
    {
        return true;
    }
    else if ( self hastalent( localclientnum, #"hash_17ccbcee64daa3c1" ) && n_level <= 3 )
    {
        return true;
    }
    else if ( self hastalent( localclientnum, #"hash_17ccbbee64daa20e" ) && n_level <= 2 )
    {
        return true;
    }
    else if ( self hastalent( localclientnum, #"hash_17ccbaee64daa05b" ) && n_level == 1 )
    {
        return true;
    }
    else if ( self hastalent( localclientnum, #"talent_staminup" ) && n_level == 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_e86ffa8/namespace_e86ffa8
// Params 2
// Checksum 0xb156ae7f, Offset: 0x9d0
// Size: 0x1bc, Type: bool
function function_cd6787b( localclientnum, n_level = 0 )
{
    if ( self hastalent( localclientnum, #"talent_elemental_pop_5" ) )
    {
        return true;
    }
    else if ( self hastalent( localclientnum, #"talent_elemental_pop_4" ) && n_level <= 4 )
    {
        return true;
    }
    else if ( self hastalent( localclientnum, #"talent_elemental_pop_3" ) && n_level <= 3 )
    {
        return true;
    }
    else if ( self hastalent( localclientnum, #"talent_elemental_pop_2" ) && n_level <= 2 )
    {
        return true;
    }
    else if ( self hastalent( localclientnum, #"talent_elemental_pop_1" ) && n_level == 1 )
    {
        return true;
    }
    else if ( self hastalent( localclientnum, #"talent_elemental_pop" ) && n_level == 0 )
    {
        return true;
    }
    
    return false;
}

