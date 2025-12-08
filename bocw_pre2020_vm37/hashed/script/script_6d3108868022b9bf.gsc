#using script_13114d8a31c6152a;
#using script_1b9f100b85b7e21d;
#using script_35ae72be7b4fec10;
#using script_4052585f7ae90f3a;
#using script_5c15c1ec5f38f19c;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\statemachine_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\collectibles;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\load;
#using scripts\cp_common\skipto;
#using scripts\cp_common\ui\interactive_map;
#using scripts\cp_common\util;

#namespace namespace_fa335fda;

// Namespace namespace_fa335fda/namespace_f784b4da
// Params 2
// Checksum 0x944b5d83, Offset: 0x8a0
// Size: 0x4d4
function function_12624bb8( var_9e3df858, var_7b80750a )
{
    player = self;
    
    /#
        function_5ac4dc99( "<dev string:x38>", 0 );
        function_cd140ee9( "<dev string:x38>", &function_31c143a8 );
        util::init_dvar( "<dev string:x4c>", 0, &function_97c5cb9a );
    #/
    
    var_98901c49 = statemachine::create( "eboard_state_machine", player, "eboard_state_change" );
    function_fa4f5603( var_98901c49, var_9e3df858 );
    var_98901c49 statemachine::add_state( "board_default_state", &function_6d01a6c8, undefined, &function_964c7ad2, &function_361f6bd8 );
    var_98901c49 statemachine::add_state( "board_overview", &function_bdf71927, &function_f77a1784, &function_559b452b, &function_361f6bd8 );
    var_98901c49 statemachine::add_state( "board_mission_detail", &function_5b9bb291, &function_c7ffe282, &function_96e31558, &function_361f6bd8 );
    var_98901c49 statemachine::add_state( "board_evidence_review", &function_e2e9758c, &function_109f3f2, &function_3db40935, &function_361f6bd8 );
    var_98901c49 statemachine::add_state( "board_review_suspects", &function_de709256, &function_35a396ee, &function_3740b568, &function_361f6bd8 );
    var_98901c49 statemachine::add_state( "board_evidence_callback", &function_c4deb1a2, &function_b00f82b, &function_340179ff, &function_361f6bd8 );
    var_98901c49 statemachine::add_interrupt_connection( "board_default_state", "board_overview", "eboard_enter_overview" );
    var_98901c49 statemachine::add_interrupt_connection( "board_overview", "board_default_state", "evidence_board_closed" );
    var_98901c49 statemachine::add_interrupt_connection( "board_overview", "board_mission_detail", "evidence_board_mission_selected" );
    var_98901c49 statemachine::add_interrupt_connection( "board_mission_detail", "board_overview", "evidence_board_mission_unselected" );
    var_98901c49 statemachine::add_interrupt_connection( "board_mission_detail", "board_evidence_review", "evidence_board_review_selected" );
    var_98901c49 statemachine::add_interrupt_connection( "board_evidence_review", "board_mission_detail", "evidence_board_review_unselected" );
    var_98901c49 statemachine::add_interrupt_connection( "board_mission_detail", "board_review_suspects", "evidence_board_review_suspects_selected" );
    var_98901c49 statemachine::add_interrupt_connection( "board_review_suspects", "board_mission_detail", "evidence_board_review_suspects_unselected" );
    var_98901c49 statemachine::add_interrupt_connection( "board_evidence_review", "board_evidence_callback", "evidence_board_evidence_callback_execute" );
    var_98901c49 statemachine::add_interrupt_connection( "board_evidence_callback", "board_evidence_review", "evidence_board_evidence_callback_finished" );
    player thread function_e0cfa93c( var_7b80750a );
}

/#

    // Namespace namespace_fa335fda/namespace_f784b4da
    // Params 1, eflags: 0x4
    // Checksum 0x834946f1, Offset: 0xd80
    // Size: 0x54, Type: dev
    function private function_31c143a8( params )
    {
        assert( params.name == "<dev string:x38>" );
        level.var_47df5f11 = params.value > 0;
    }

    // Namespace namespace_fa335fda/namespace_f784b4da
    // Params 1, eflags: 0x4
    // Checksum 0x7ab4a605, Offset: 0xde0
    // Size: 0x204, Type: dev
    function private function_97c5cb9a( params )
    {
        assert( params.name == "<dev string:x4c>" );
        
        if ( params.value )
        {
            mission_list = [ "<dev string:x6a>", "<dev string:x79>", "<dev string:x8a>", "<dev string:x9d>", "<dev string:xaf>", "<dev string:xc2>", "<dev string:xd0>", "<dev string:xe3>", "<dev string:xf8>", "<dev string:x108>", "<dev string:x117>", "<dev string:x132>" ];
            
            foreach ( mission_name in mission_list )
            {
                if ( is_true( savegame::function_2ee66e93( mission_name + "<dev string:x14b>" ) ) )
                {
                    savegame::set_player_data( mission_name + "<dev string:x14b>", 0 );
                }
            }
            
            setdvar( #"hash_432a49c2505fa5fe", 0 );
        }
    }

#/

// Namespace namespace_fa335fda/namespace_f784b4da
// Params 2, eflags: 0x4
// Checksum 0x2cf752ef, Offset: 0xff0
// Size: 0x96a
function private function_fa4f5603( statemachine, var_9e3df858 )
{
    blackboard = {};
    var_e55cb845 = struct::get( "darkening_plane_origin", "targetname" );
    var_1bfff22b = spawn( "script_model", var_e55cb845.origin );
    var_1bfff22b.angles = var_e55cb845.angles;
    var_1bfff22b setmodel( "p9_sr_evidence_board_darkening_multiply_01" );
    var_1bfff22b hide();
    blackboard.var_1bfff22b = var_1bfff22b;
    var_c8099c2 = [ #"post_takedown":[ "cp_nic_revolucion", 1, "cp_takedown", 1, "cp_nam_armada", 0 ], #"post_armada":[ "cp_nic_revolucion", 1, "cp_takedown", 1, "cp_nam_armada", 1, "cp_ger_stakeout", 0 ], #"post_yamantau":[ "cp_nic_revolucion", 1, "cp_takedown", 1, "cp_nam_armada", 1, "cp_ger_stakeout", 1, "cp_rus_amerika", 1, "cp_rus_yamantau", 1, "cp_rus_kgb", 0 ], #"post_kgb":[ "cp_nic_revolucion", 0, "cp_takedown", 1, "cp_nam_armada", 1, "cp_ger_stakeout", 1, "cp_rus_amerika", 1, "cp_rus_yamantau", 1, "cp_rus_kgb", 1 ], #"post_cuba":[ "cp_nic_revolucion", 0, "cp_takedown", 1, "cp_nam_armada", 1, "cp_ger_stakeout", 1, "cp_rus_amerika", 1, "cp_rus_yamantau", 1, "cp_rus_kgb", 1 ], #"post_prisoner":[ "cp_nic_revolucion", 0, "cp_takedown", 1, "cp_nam_armada", 1, "cp_ger_stakeout", 1, "cp_rus_amerika", 1, "cp_rus_yamantau", 1, "cp_rus_kgb", 1 ] ];
    var_625dd793 = var_c8099c2[ var_9e3df858 ];
    assert( isdefined( var_625dd793 ), "<dev string:x15f>" + var_9e3df858 );
    assert( var_625dd793.size % 2 == 0 );
    blackboard.var_3cb3ede5 = function_89f058b1( var_625dd793 );
    
    if ( function_eaf23d80( blackboard.var_3cb3ede5, "cp_sidemission_takedown" ) )
    {
        var_625dd793[ var_625dd793.size ] = "cp_sidemission_takedown";
        var_625dd793[ var_625dd793.size ] = 1;
    }
    
    if ( function_eaf23d80( blackboard.var_3cb3ede5, "cp_sidemission_tundra" ) )
    {
        var_625dd793[ var_625dd793.size ] = "cp_sidemission_tundra";
        var_625dd793[ var_625dd793.size ] = 1;
    }
    
    blackboard.mdl_bulb_left = getent( "mdl_bulb_left", "script_noteworthy" );
    blackboard.mdl_bulb_right = getent( "mdl_bulb_right", "script_noteworthy" );
    blackboard.var_3c3d8c0b = [];
    var_d771858a = function_f98394d8( var_625dd793, blackboard.var_3cb3ede5 );
    
    foreach ( e in var_d771858a )
    {
        if ( e.classname == "trigger_multiple" )
        {
            if ( !isdefined( blackboard.var_3c3d8c0b ) )
            {
                blackboard.var_3c3d8c0b = [];
            }
            else if ( !isarray( blackboard.var_3c3d8c0b ) )
            {
                blackboard.var_3c3d8c0b = array( blackboard.var_3c3d8c0b );
            }
            
            blackboard.var_3c3d8c0b[ blackboard.var_3c3d8c0b.size ] = e;
            continue;
        }
        
        e show();
    }
    
    var_a5519791 = struct::get( "evidence_board_player_pos", "targetname" );
    blackboard.var_f9e7327d = util::spawn_model( "tag_origin", var_a5519791.origin + ( 0, 0, -60 ), var_a5519791.angles );
    blackboard.var_33e067df = 0.75;
    blackboard.var_8e1686c8 = 0.25;
    blackboard.var_f3592501 = 0.5;
    blackboard.var_b2257d78 = 0.5;
    var_ab72a295 = struct::get( "hint_evidence_board", "targetname" );
    var_63754fbc = util::spawn_model( "tag_origin", var_ab72a295.origin );
    blackboard.var_63754fbc = var_63754fbc;
    blackboard.var_7117f05e = [ #"menu/recruit", #"menu/regular", #"hash_5eb0fe85b0c234b0", #"menu/veteran", #"menu/heroic" ];
    statemachine.blackboard = blackboard;
}

// Namespace namespace_fa335fda/namespace_f784b4da
// Params 1, eflags: 0x4
// Checksum 0x4525f86f, Offset: 0x1968
// Size: 0x488
function private function_89f058b1( var_625dd793 )
{
    var_fe5aa0de = getscriptbundle( #"evidenceboardlist" );
    var_67e21ca2 = var_fe5aa0de.var_48be729c;
    var_3cb3ede5 = [];
    
    foreach ( var_839fe80a in var_67e21ca2 )
    {
        if ( isdefined( var_839fe80a.var_8ca1d4a ) )
        {
            if ( isdefined( var_839fe80a.collectiblelist ) )
            {
                collectibles = var_839fe80a.collectiblelist;
                var_839fe80a.var_9c01f410 = [];
                var_839fe80a.var_dade7c7f = [];
                var_839fe80a.var_1ccfca62 = 0;
                
                foreach ( v in collectibles )
                {
                    collectible = getscriptbundle( v.collectible );
                    
                    if ( collectible.var_4292acd3 === 1 )
                    {
                        var_839fe80a.var_1ccfca62++;
                        isunlocked = 1;
                        UnlockType = isdefined( collectible.UnlockType ) ? collectible.UnlockType : 0;
                        
                        if ( UnlockType == 1 || UnlockType == 2 )
                        {
                            assert( isdefined( collectible.UnlockMap ) );
                            isunlocked = function_a1a067ff( UnlockType, collectible.UnlockMap, var_625dd793 );
                        }
                        else if ( UnlockType == 3 )
                        {
                            assert( isdefined( collectible.UnlockMap ) );
                            assert( isdefined( collectible.var_f3575c58 ) );
                            isunlocked = is_true( collectibles::function_ab921f3d( collectible.var_f3575c58, collectible.UnlockMap ) );
                        }
                        
                        if ( isunlocked )
                        {
                            if ( !isdefined( var_839fe80a.var_dade7c7f ) )
                            {
                                var_839fe80a.var_dade7c7f = [];
                            }
                            else if ( !isarray( var_839fe80a.var_dade7c7f ) )
                            {
                                var_839fe80a.var_dade7c7f = array( var_839fe80a.var_dade7c7f );
                            }
                            
                            var_839fe80a.var_dade7c7f[ var_839fe80a.var_dade7c7f.size ] = collectible;
                            
                            if ( !isdefined( var_839fe80a.var_9c01f410 ) )
                            {
                                var_839fe80a.var_9c01f410 = [];
                            }
                            else if ( !isarray( var_839fe80a.var_9c01f410 ) )
                            {
                                var_839fe80a.var_9c01f410 = array( var_839fe80a.var_9c01f410 );
                            }
                            
                            var_839fe80a.var_9c01f410[ var_839fe80a.var_9c01f410.size ] = collectible;
                        }
                        
                        continue;
                    }
                    
                    if ( !isdefined( var_839fe80a.var_9c01f410 ) )
                    {
                        var_839fe80a.var_9c01f410 = [];
                    }
                    else if ( !isarray( var_839fe80a.var_9c01f410 ) )
                    {
                        var_839fe80a.var_9c01f410 = array( var_839fe80a.var_9c01f410 );
                    }
                    
                    var_839fe80a.var_9c01f410[ var_839fe80a.var_9c01f410.size ] = collectible;
                }
            }
            
            var_3cb3ede5[ var_839fe80a.var_8ca1d4a ] = var_839fe80a;
        }
    }
    
    return var_3cb3ede5;
}

// Namespace namespace_fa335fda/namespace_f784b4da
// Params 3, eflags: 0x4
// Checksum 0xefd79678, Offset: 0x1df8
// Size: 0xb4, Type: bool
function private function_a1a067ff( UnlockType, UnlockMap, var_625dd793 )
{
    i = 0;
    
    while ( i < var_625dd793.size )
    {
        var_663c51cb = var_625dd793[ i ];
        
        if ( var_663c51cb == UnlockMap )
        {
            missionstate = var_625dd793[ i + 1 ];
            
            if ( UnlockType == 1 )
            {
                return ( missionstate == 0 );
            }
            else if ( UnlockType == 2 )
            {
                return ( missionstate == 1 );
            }
        }
        
        i += 2;
    }
    
    return false;
}

// Namespace namespace_fa335fda/namespace_f784b4da
// Params 2, eflags: 0x4
// Checksum 0xad1c260a, Offset: 0x1eb8
// Size: 0x48, Type: bool
function private function_eaf23d80( var_3cb3ede5, var_edd030e1 )
{
    assert( isdefined( var_3cb3ede5[ var_edd030e1 ] ) );
    return var_3cb3ede5[ var_edd030e1 ].var_dade7c7f.size > 0;
}

// Namespace namespace_fa335fda/namespace_f784b4da
// Params 2, eflags: 0x4
// Checksum 0x3ceaa79e, Offset: 0x1f08
// Size: 0xf4
function private function_f98394d8( var_625dd793, var_3cb3ede5 )
{
    var_d771858a = [];
    i = 0;
    
    while ( i < var_625dd793.size )
    {
        var_663c51cb = var_625dd793[ i ];
        assert( isstring( var_663c51cb ) );
        missionstate = var_625dd793[ i + 1 ];
        assert( isint( missionstate ) );
        var_d771858a = function_e768ae1e( var_d771858a, var_663c51cb, missionstate, var_3cb3ede5 );
        i += 2;
    }
    
    return var_d771858a;
}

// Namespace namespace_fa335fda/namespace_f784b4da
// Params 4, eflags: 0x4
// Checksum 0xa778de51, Offset: 0x2008
// Size: 0x42a
function private function_e768ae1e( var_d771858a, var_663c51cb, missionstate, var_3cb3ede5 )
{
    var_6711328d = getentarray( "mdl_" + var_663c51cb + "_first_items", "script_noteworthy" );
    
    foreach ( e in var_6711328d )
    {
        if ( !isdefined( var_d771858a ) )
        {
            var_d771858a = [];
        }
        else if ( !isarray( var_d771858a ) )
        {
            var_d771858a = array( var_d771858a );
        }
        
        var_d771858a[ var_d771858a.size ] = e;
    }
    
    if ( var_663c51cb == "cp_nic_revolucion" )
    {
        if ( level.var_f5552371 == "post_kgb" )
        {
            t = getent( var_663c51cb, "script_noteworthy" );
            
            if ( !isdefined( var_d771858a ) )
            {
                var_d771858a = [];
            }
            else if ( !isarray( var_d771858a ) )
            {
                var_d771858a = array( var_d771858a );
            }
            
            var_d771858a[ var_d771858a.size ] = t;
        }
    }
    else
    {
        t = getent( var_663c51cb, "script_noteworthy" );
        
        if ( !isdefined( var_d771858a ) )
        {
            var_d771858a = [];
        }
        else if ( !isarray( var_d771858a ) )
        {
            var_d771858a = array( var_d771858a );
        }
        
        var_d771858a[ var_d771858a.size ] = t;
    }
    
    var_c48b2462 = function_ea758569( var_663c51cb, missionstate );
    
    foreach ( name in var_c48b2462 )
    {
        e = getent( name, "script_noteworthy" );
        
        if ( !isdefined( var_d771858a ) )
        {
            var_d771858a = [];
        }
        else if ( !isarray( var_d771858a ) )
        {
            var_d771858a = array( var_d771858a );
        }
        
        var_d771858a[ var_d771858a.size ] = e;
    }
    
    var_181973be = var_3cb3ede5[ var_663c51cb ].var_9c01f410;
    
    if ( isdefined( var_181973be ) )
    {
        foreach ( evidencedata in var_181973be )
        {
            if ( isdefined( evidencedata.tagname ) )
            {
                e = getent( evidencedata.tagname, "script_noteworthy" );
                
                if ( !isdefined( var_d771858a ) )
                {
                    var_d771858a = [];
                }
                else if ( !isarray( var_d771858a ) )
                {
                    var_d771858a = array( var_d771858a );
                }
                
                var_d771858a[ var_d771858a.size ] = e;
            }
        }
    }
    
    return var_d771858a;
}

// Namespace namespace_fa335fda/namespace_f784b4da
// Params 2, eflags: 0x4
// Checksum 0x8a86c048, Offset: 0x2440
// Size: 0x318
function private function_ea758569( var_663c51cb, missionstate )
{
    var_583fa16f = [ #"cp_nic_revolucion":[ [ "mdl_" + "cp_nic_revolucion" + "_string_red", "mdl_" + "cp_nic_revolucion" + "_label_next", "mdl_" + "cp_nic_revolucion" + "_label_next_bottom", "mdl_" + "cp_nic_revolucion" + "_bg_next" ], [ "mdl_" + "cp_nic_revolucion" + "_2", "mdl_" + "cp_nic_revolucion" + "_4", "mdl_" + "cp_nic_revolucion" + "_string_white", "mdl_" + "cp_nic_revolucion" + "_label", "mdl_" + "cp_nic_revolucion" + "_bg" ] ], #"cp_nam_prisoner":[ [ "mdl_" + "cp_nam_prisoner" + "_string_red", "mdl_" + "cp_nam_prisoner" + "_label_next", "mdl_" + "cp_nam_prisoner" + "_label_next_bottom", "mdl_" + "cp_nam_prisoner" + "_bg_next" ], [ "mdl_" + "cp_nam_prisoner" + "_1", "mdl_" + "cp_nam_prisoner" + "_2", "mdl_" + "cp_nam_prisoner" + "_3", "mdl_" + "cp_nam_prisoner" + "_string_white", "mdl_" + "cp_nam_prisoner" + "_label", "mdl_" + "cp_nam_prisoner" + "_bg" ] ] ];
    
    if ( missionstate > 1 )
    {
        missionstate = 1;
    }
    
    if ( isdefined( var_583fa16f[ var_663c51cb ] ) )
    {
        assert( isdefined( var_583fa16f[ var_663c51cb ][ missionstate ] ) );
        return var_583fa16f[ var_663c51cb ][ missionstate ];
    }
    
    return [];
}

// Namespace namespace_fa335fda/namespace_f784b4da
// Params 1, eflags: 0x4
// Checksum 0x18097b3f, Offset: 0x2760
// Size: 0xb4
function private function_e0cfa93c( var_7b80750a )
{
    player = self;
    assert( isplayer( player ) );
    
    if ( isdefined( var_7b80750a ) )
    {
        level waittill( var_7b80750a );
    }
    
    statemachine = player function_1bb19090();
    statemachine statemachine::set_state( "board_default_state" );
    player thread function_e8e65a88( statemachine, "board_default_state" );
}

// Namespace namespace_fa335fda/namespace_f784b4da
// Params 2, eflags: 0x4
// Checksum 0xde6586b2, Offset: 0x2820
// Size: 0x278
function private function_e8e65a88( statemachine, initialstate )
{
    player = self;
    assert( isplayer( player ) );
    blackboard = statemachine.blackboard;
    blackboard.var_481d0fb1 = [ initialstate ];
    
    while ( true )
    {
        player waittill( #"eboard_state_change" );
        assert( isdefined( statemachine.current_state ) && isdefined( statemachine.next_state ) );
        blackboard.var_68768c5 = statemachine.current_state.name;
        
        if ( !isinarray( blackboard.var_481d0fb1, statemachine.next_state.name ) )
        {
            array::add( blackboard.var_481d0fb1, statemachine.next_state.name );
        }
        else
        {
            assert( blackboard.var_481d0fb1[ blackboard.var_481d0fb1.size - 1 ] == statemachine.current_state.name && blackboard.var_481d0fb1[ blackboard.var_481d0fb1.size - 2 ] == statemachine.next_state.name );
            blackboard.var_481d0fb1[ blackboard.var_481d0fb1.size - 1 ] = undefined;
        }
        
        /#
            if ( is_true( level.var_47df5f11 ) )
            {
                println( "<dev string:x198>" );
                
                for ( i = 0; i < blackboard.var_481d0fb1.size ; i++ )
                {
                    println( "<dev string:x1b6>" + i + "<dev string:x1bb>" + blackboard.var_481d0fb1[ i ] );
                }
            }
        #/
    }
}

// Namespace namespace_fa335fda/namespace_f784b4da
// Params 0, eflags: 0x4
// Checksum 0x8ffb2e53, Offset: 0x2aa0
// Size: 0x152
function private function_305352b5()
{
    player = self;
    assert( isplayer( player ) );
    statemachine = player function_1bb19090();
    var_fe7185f8 = statemachine.blackboard.var_68768c5;
    
    /#
        if ( isinarray( statemachine.blackboard.var_481d0fb1, var_fe7185f8 ) )
        {
            blackboard = statemachine.blackboard;
            assert( blackboard.var_481d0fb1[ blackboard.var_481d0fb1.size - 1 ] == statemachine.current_state.name && blackboard.var_481d0fb1[ blackboard.var_481d0fb1.size - 2 ] == var_fe7185f8 );
        }
    #/
    
    return isinarray( statemachine.blackboard.var_481d0fb1, var_fe7185f8 );
}

// Namespace namespace_fa335fda/namespace_f784b4da
// Params 0, eflags: 0x4
// Checksum 0x2875e47f, Offset: 0x2c00
// Size: 0x152
function private function_a997529d()
{
    player = self;
    assert( isplayer( player ) );
    statemachine = player function_1bb19090();
    
    /#
        if ( isinarray( statemachine.blackboard.var_481d0fb1, statemachine.next_state.name ) )
        {
            blackboard = statemachine.blackboard;
            assert( blackboard.var_481d0fb1[ blackboard.var_481d0fb1.size - 1 ] == statemachine.current_state.name && blackboard.var_481d0fb1[ blackboard.var_481d0fb1.size - 2 ] == statemachine.next_state.name );
        }
    #/
    
    return isinarray( statemachine.blackboard.var_481d0fb1, statemachine.next_state.name );
}

// Namespace namespace_fa335fda/namespace_f784b4da
// Params 0, eflags: 0x4
// Checksum 0x93dc9ba6, Offset: 0x2d60
// Size: 0xa4
function private function_1bb19090()
{
    player = self;
    assert( isplayer( player ) );
    assert( isdefined( player.state_machines ) );
    assert( isdefined( player.state_machines[ #"eboard_state_machine" ] ) );
    return player.state_machines[ #"eboard_state_machine" ];
}

// Namespace namespace_fa335fda/namespace_f784b4da
// Params 1, eflags: 0x4
// Checksum 0xd5a165ef, Offset: 0x2e10
// Size: 0x2e, Type: bool
function private function_361f6bd8( *params )
{
    assertmsg( "<dev string:x1c1>" );
    return false;
}

// Namespace namespace_fa335fda/namespace_f784b4da
// Params 1, eflags: 0x4
// Checksum 0x1b17e2ef, Offset: 0x2e48
// Size: 0x124
function private function_6d01a6c8( *params )
{
    player = self;
    assert( isplayer( player ) );
    
    /#
        player function_fc845aca();
    #/
    
    statemachine = player function_1bb19090();
    statemachine.blackboard.var_63754fbc util::create_cursor_hint( "tag_origin", ( 0, 0, 0 ), #"hash_400e97432023f9f3", 160, undefined, &function_b0a92909 );
    player thread clientfield::set_to_player( "set_hub_fov", 2 );
    player thread clientfield::set_to_player( "pstfx_t9_cp_hub_eboard_vignette", 0 );
    player thread clientfield::set_to_player( "pstfx_t9_cp_hub_eboard_overview", 0 );
}

// Namespace namespace_fa335fda/namespace_f784b4da
// Params 1, eflags: 0x4
// Checksum 0xc6428e5e, Offset: 0x2f78
// Size: 0x8c
function private function_964c7ad2( *params )
{
    player = self;
    assert( isplayer( player ) );
    assert( !level flag::get( "<dev string:x201>" ) );
    
    /#
        player function_d530ce5a();
    #/
}

// Namespace namespace_fa335fda/namespace_f784b4da
// Params 1, eflags: 0x4
// Checksum 0x2f2a5eb2, Offset: 0x3010
// Size: 0xa4
function private function_b0a92909( params )
{
    assert( isdefined( params.player ) );
    
    /#
        statemachine = params.player function_1bb19090();
        assert( statemachine.current_state.name == "<dev string:x225>" );
    #/
    
    params.player notify( #"eboard_enter_overview" );
}

// Namespace namespace_fa335fda/namespace_f784b4da
// Params 1, eflags: 0x4
// Checksum 0x25c71fef, Offset: 0x30c0
// Size: 0x66c
function private function_bdf71927( *params )
{
    player = self;
    assert( isplayer( player ) );
    
    /#
        player function_fc845aca();
    #/
    
    statemachine = player function_1bb19090();
    blackboard = statemachine.blackboard;
    player clientfield::set_to_player( "pstfx_t9_cp_hub_eboard_vignette", 1 );
    player clientfield::set_to_player( "pstfx_t9_cp_hub_eboard_overview", 1 );
    
    if ( player function_305352b5() )
    {
        player function_3ab14abb();
        level thread namespace_4ed3ce47::function_d2bce2b8();
        player thread namespace_4ed3ce47::duck_evidence_board_enter();
        level thread namespace_4ed3ce47::function_7edafa59( "evidence_board_main" );
        level thread snd::function_4286bd2c( level.var_2b68b1ef, 3 );
        level flag::set( "flag_player_used_evidence_board" );
        level flag::set( "flag_player_using_evidence_board" );
        
        foreach ( var_3d43d7b8 in level.a_ai_allies )
        {
            if ( isdefined( var_3d43d7b8[ 0 ] ) )
            {
                var_3d43d7b8[ 0 ] notify( #"kill_dialog" );
            }
        }
        
        player hide();
        player setstance( "stand" );
        player val::set( #"evidence_board", "allow_prone", 0 );
        player val::set( #"evidence_board", "allow_crouch", 0 );
        player function_d50da7b8( blackboard );
        player interactive_map::open( #"hash_79bcfa1ce8d9fd7f", undefined, undefined, 0, undefined, undefined, undefined, undefined, undefined, 1 );
        player interactive_map::function_59b2a130( blackboard.var_3c3d8c0b );
        player interactive_map::function_879505e1( 1, #"hash_181a347630cebe70" );
        player interactive_map::function_835fb58e( 1 );
        player interactive_map::function_23036faa( #"cursor", "year", 0 );
        player interactive_map::function_23036faa( #"cursor", "player", #"" );
        player interactive_map::function_23036faa( #"cursor", "progress", 0 );
        player interactive_map::function_23036faa( #"cursor", "collectibleCount", 0 );
        
        if ( !player gamepadusedlast() )
        {
            setdvar( #"ui_busyblockingamemenu", 1 );
        }
        
        var_96b6affa = { #var_4ac77177:0, #var_de6f0004:0, #prompt_text:#"hash_6c7bb285599937ba", #complete_callback:&function_fb5a7ab1, #var_be77841a:0, #var_531201f1:&function_4b717253 };
        
        foreach ( trigger in blackboard.var_3c3d8c0b )
        {
            trigger.var_f90e2591 = &function_e976f5d3;
            trigger.var_938b0e9b = &function_cab79d7e;
            trigger.var_d9b5c896 = blackboard.var_3cb3ede5[ trigger.script_noteworthy ].levelname;
            trigger.var_94ca2a30 = blackboard.var_3cb3ede5[ trigger.script_noteworthy ].var_2dd3e7b0;
            trigger interactive_map::function_b5c2702b( #"confirm", var_96b6affa );
        }
    }
    
    namespace_c8e236da::removelist();
    namespace_c8e236da::addprompt( #"hash_6fd9204f76593a1b" );
    namespace_c8e236da::addprompt( #"hash_75a71993b5ef3343" );
}

// Namespace namespace_fa335fda/namespace_f784b4da
// Params 0, eflags: 0x4
// Checksum 0x4db39fc1, Offset: 0x3738
// Size: 0x54
function private function_3ab14abb()
{
    player = self;
    player clientfield::set_to_player( "set_hub_dof", 1 );
    player clientfield::set_to_player( "set_hub_fov", 4 );
}

// Namespace namespace_fa335fda/namespace_f784b4da
// Params 1, eflags: 0x4
// Checksum 0x73089187, Offset: 0x3798
// Size: 0x122
function private function_d50da7b8( blackboard )
{
    player = self;
    assert( isplayer( player ) );
    player playerlinktoblend( blackboard.var_f9e7327d, "tag_origin", blackboard.var_33e067df, blackboard.var_8e1686c8, blackboard.var_f3592501, blackboard.var_33e067df, blackboard.var_8e1686c8, blackboard.var_f3592501 );
    wait blackboard.var_33e067df;
    waitframe( 1 );
    playerpos = player getplayercamerapos();
    playerangles = player getplayerangles();
    player camerasetposition( playerpos, playerangles );
    player cameraactivate( 1 );
    waitframe( 1 );
}

// Namespace namespace_fa335fda/namespace_f784b4da
// Params 1, eflags: 0x4
// Checksum 0x7dbbc437, Offset: 0x38c8
// Size: 0x90
function private function_f77a1784( *params )
{
    player = self;
    assert( isplayer( player ) );
    player endon( #"eboard_state_change" );
    
    while ( !player scripted_widgets::function_57fbd346() )
    {
        waitframe( 1 );
    }
    
    player notify( #"evidence_board_closed" );
}

// Namespace namespace_fa335fda/namespace_f784b4da
// Params 1, eflags: 0x4
// Checksum 0x5e550f16, Offset: 0x3960
// Size: 0x48
function private function_fb5a7ab1( *var_5a02549b )
{
    player = getplayers()[ 0 ];
    player notify( #"evidence_board_mission_selected" );
}

// Namespace namespace_fa335fda/namespace_f784b4da
// Params 1, eflags: 0x4
// Checksum 0xe514fbf2, Offset: 0x39b0
// Size: 0x2c, Type: bool
function private function_4b717253( *var_5a02549b )
{
    return !scripted_widgets::should_hide( #"interactive_map" );
}

// Namespace namespace_fa335fda/namespace_f784b4da
// Params 0, eflags: 0x4
// Checksum 0xf617511a, Offset: 0x39e8
// Size: 0x2ec
function private function_e976f5d3()
{
    missionname = self.script_noteworthy;
    assert( missionname != "<dev string:xe3>" || level.var_f5552371 == "<dev string:x23c>" );
    player = getplayers()[ 0 ];
    statemachine = player function_1bb19090();
    blackboard = statemachine.blackboard;
    blackboard.var_c5bde695 = missionname;
    evidence = blackboard.var_3cb3ede5[ missionname ];
    assert( isdefined( evidence ) );
    interactive_map::function_23036faa( #"cursor", "isSideMission", evidence.isSideMission );
    interactive_map::function_23036faa( #"cursor", "year", evidence.var_2200aced );
    interactive_map::function_23036faa( #"cursor", "player", evidence.LevelPresence );
    interactive_map::function_23036faa( #"cursor", "progress", 0.4 );
    
    if ( isdefined( evidence.var_dade7c7f ) && isdefined( evidence.var_8ca1d4a ) )
    {
        var_61b3cfd0 = collectibles::function_9f976c54( evidence.var_8ca1d4a );
        assert( var_61b3cfd0 < 8 );
        var_68c47b96 = collectibles::function_7be39f53( evidence.var_8ca1d4a );
        assert( var_68c47b96 < 8 );
        var_2ed2359a = var_61b3cfd0;
        var_2ed2359a |= var_68c47b96 << 3;
        interactive_map::function_23036faa( #"cursor", "collectibleCount", var_2ed2359a );
    }
    else
    {
        interactive_map::function_23036faa( #"cursor", "collectibleCount", 0 );
    }
    
    level thread namespace_4ed3ce47::function_7edafa59( "evidence_board_mission" );
}

// Namespace namespace_fa335fda/namespace_f784b4da
// Params 0, eflags: 0x4
// Checksum 0x64134cf8, Offset: 0x3ce0
// Size: 0x144
function private function_cab79d7e()
{
    player = getplayers()[ 0 ];
    statemachine = player function_1bb19090();
    statemachine.blackboard.var_c5bde695 = undefined;
    interactive_map::function_23036faa( #"cursor", "year", 0 );
    interactive_map::function_23036faa( #"cursor", "player", #"" );
    interactive_map::function_23036faa( #"cursor", "progress", 0 );
    interactive_map::function_23036faa( #"cursor", "collectibleCount", 0 );
    level notify( #"hash_7c11efb940bfa7e2" );
    level thread namespace_4ed3ce47::function_7edafa59( "evidence_board_main" );
}

// Namespace namespace_fa335fda/namespace_f784b4da
// Params 1, eflags: 0x4
// Checksum 0x5bc90587, Offset: 0x3e30
// Size: 0xc4
function private function_559b452b( *params )
{
    player = self;
    assert( isplayer( player ) );
    
    /#
        player function_d530ce5a();
    #/
    
    namespace_c8e236da::removelist();
    
    if ( player function_a997529d() )
    {
        statemachine = player function_1bb19090();
        player thread function_22ec525a( statemachine.blackboard );
    }
}

// Namespace namespace_fa335fda/namespace_f784b4da
// Params 1, eflags: 0x4
// Checksum 0xaf839a19, Offset: 0x3f00
// Size: 0x174
function private function_22ec525a( blackboard )
{
    player = self;
    assert( isplayer( player ) );
    blackboard.var_c5bde695 = undefined;
    namespace_c8e236da::removelist();
    interactive_map::close();
    setdvar( #"ui_busyblockingamemenu", 0 );
    level thread namespace_4ed3ce47::function_7edafa59( "ambient" );
    level thread namespace_4ed3ce47::function_dd520714();
    player thread namespace_4ed3ce47::duck_evidence_board_exit();
    wait blackboard.var_33e067df;
    player show();
    player cameraactivate( 0 );
    waitframe( 1 );
    player unlink();
    player val::reset_all( #"evidence_board" );
    level flag::clear( "flag_player_using_evidence_board" );
}

// Namespace namespace_fa335fda/namespace_f784b4da
// Params 1, eflags: 0x4
// Checksum 0x4390fc2b, Offset: 0x4080
// Size: 0x90c
function private function_5b9bb291( *params )
{
    player = self;
    assert( isplayer( player ) );
    
    /#
        player function_fc845aca();
    #/
    
    statemachine = player function_1bb19090();
    blackboard = statemachine.blackboard;
    assert( isdefined( blackboard.var_c5bde695 ) );
    evidence = blackboard.var_3cb3ede5[ blackboard.var_c5bde695 ];
    assert( !scripted_widgets::exists( #"hash_3ccc1702bc979da8" ) );
    scripted_widgets::create( #"hash_3ccc1702bc979da8", #"hash_4130605c2e66825d" );
    scripted_widgets::function_d3c3e5c3( #"hash_3ccc1702bc979da8", #"interactive_map" );
    var_9f97b0c5 = isdefined( evidence.AlignRight ) && evidence.AlignRight == 1;
    scripted_widgets::function_9ade1d9b( #"hash_3ccc1702bc979da8", "AlignRight", var_9f97b0c5 );
    scripted_widgets::function_9ade1d9b( #"hash_3ccc1702bc979da8", "MapName", blackboard.var_c5bde695 );
    scripted_widgets::function_9ade1d9b( #"hash_3ccc1702bc979da8", "Year", evidence.var_2200aced );
    scripted_widgets::function_9ade1d9b( #"hash_3ccc1702bc979da8", "LevelName", evidence.levelname );
    scripted_widgets::function_9ade1d9b( #"hash_3ccc1702bc979da8", "LongDescription", evidence.var_47b1727b );
    scripted_widgets::function_9ade1d9b( #"hash_3ccc1702bc979da8", "LevelPresence", evidence.LevelPresence );
    missiondata = savegame::function_6440b06b( #"persistent", blackboard.var_c5bde695 );
    
    if ( is_true( missiondata.complete ) && isdefined( missiondata.highestdifficulty ) )
    {
        var_4a19e561 = blackboard.var_7117f05e[ missiondata.highestdifficulty ];
        scripted_widgets::function_9ade1d9b( #"hash_3ccc1702bc979da8", "LevelDifficulty", var_4a19e561 );
    }
    
    if ( isdefined( evidence.var_4458275e ) )
    {
        foreach ( index, var_e8c1b531 in evidence.var_4458275e )
        {
            scripted_widgets::function_f2a9266( #"hash_3ccc1702bc979da8", index, "IsPrimaryObjective", var_e8c1b531.IsPrimaryObjective === 1 );
            scripted_widgets::function_f2a9266( #"hash_3ccc1702bc979da8", index, "Index", var_e8c1b531.itemindex );
            scripted_widgets::function_f2a9266( #"hash_3ccc1702bc979da8", index, "Title", var_e8c1b531.title );
        }
    }
    
    if ( isdefined( evidence.var_dade7c7f ) )
    {
        var_61b3cfd0 = 0;
        var_68c47b96 = 0;
        
        if ( isdefined( evidence.var_8ca1d4a ) )
        {
            var_61b3cfd0 = collectibles::function_9f976c54( evidence.var_8ca1d4a );
            var_68c47b96 = collectibles::function_7be39f53( evidence.var_8ca1d4a );
        }
        
        index = ( isdefined( evidence.var_4458275e ) ? evidence.var_4458275e.size : 0 ) + 1;
        scripted_widgets::function_f2a9266( #"hash_3ccc1702bc979da8", index, "IsPrimaryObjective", 0 );
        scripted_widgets::function_f2a9266( #"hash_3ccc1702bc979da8", index, "Index", index );
        scripted_widgets::function_f2a9266( #"hash_3ccc1702bc979da8", index, "Count", var_61b3cfd0 );
        scripted_widgets::function_f2a9266( #"hash_3ccc1702bc979da8", index, "EvidenceCollectedCount", var_68c47b96 );
        scripted_widgets::function_f2a9266( #"hash_3ccc1702bc979da8", index, "Title", #"" );
    }
    
    scripted_widgets::set_focus( #"hash_3ccc1702bc979da8", 0 );
    player clientfield::set_to_player( "set_hub_dof", 4 );
    player clientfield::set_to_player( "set_hub_fov", 1 );
    namespace_c8e236da::removelist();
    
    if ( player function_305352b5() )
    {
        level thread namespace_4ed3ce47::function_6fe99ae0();
        scripted_widgets::hide_widgets( #"hash_3ccc1702bc979da8", [ #"interactive_map" ] );
        
        if ( isdefined( evidence.var_89616eaa ) )
        {
            level scene::play( "scene_hub_eboard_handler", evidence.var_89616eaa );
        }
        
        if ( isdefined( evidence.var_8f98dad8 ) )
        {
            level thread scene::play( "scene_hub_eboard_handler", evidence.var_8f98dad8 );
        }
        
        if ( isdefined( evidence.intro_vo ) && evidence.intro_vo.size > 0 && !is_true( savegame::function_2ee66e93( blackboard.var_c5bde695 + "_intro_vo_played" ) ) )
        {
            foreach ( vox in evidence.intro_vo )
            {
                player dialogue::radio( vox.vox );
            }
            
            savegame::set_player_data( blackboard.var_c5bde695 + "_intro_vo_played", 1 );
        }
        
        level clientfield::set( "eboard_notify_from_server", 1 );
    }
    
    scripted_widgets::set_focus( #"hash_3ccc1702bc979da8", 1 );
    namespace_c8e236da::addprompt( #"hash_6fd9204f76593a1b" );
    namespace_c8e236da::addprompt( #"hash_75a71993b5ef3343" );
}

// Namespace namespace_fa335fda/namespace_f784b4da
// Params 1, eflags: 0x4
// Checksum 0x8af834a1, Offset: 0x4998
// Size: 0x2a0
function private function_c7ffe282( *params )
{
    player = self;
    assert( isplayer( player ) );
    player endon( #"eboard_state_change" );
    
    while ( true )
    {
        option = level waittill( #"evidence_board_option_selected" );
        
        if ( option.optindex == 1 )
        {
            statemachine = player function_1bb19090();
            blackboard = statemachine.blackboard;
            assert( isdefined( blackboard.var_c5bde695 ) );
            evidence = blackboard.var_3cb3ede5[ blackboard.var_c5bde695 ];
            
            if ( isdefined( evidence.var_dade7c7f ) && evidence.var_dade7c7f.size > 0 )
            {
                player notify( #"evidence_board_review_selected" );
                break;
            }
            
            continue;
        }
        
        if ( option.optindex == 2 )
        {
            player notify( #"evidence_board_mission_unselected" );
            break;
        }
        
        if ( option.optindex == 0 )
        {
            statemachine = player function_1bb19090();
            blackboard = statemachine.blackboard;
            assert( isdefined( blackboard.var_c5bde695 ) );
            skipto::function_1c2dfc20( blackboard.var_c5bde695 );
            continue;
        }
        
        if ( option.optindex == 3 )
        {
            /#
                statemachine = player function_1bb19090();
                blackboard = statemachine.blackboard;
                assert( blackboard.var_c5bde695 == "<dev string:x132>" );
            #/
            
            player notify( #"evidence_board_review_suspects_selected" );
            break;
        }
        
        assertmsg( "<dev string:x248>" + option.optindex );
    }
}

// Namespace namespace_fa335fda/namespace_f784b4da
// Params 1, eflags: 0x4
// Checksum 0x1d8190fc, Offset: 0x4c40
// Size: 0x204
function private function_96e31558( *params )
{
    player = self;
    assert( isplayer( player ) );
    
    /#
        player function_d530ce5a();
    #/
    
    namespace_c8e236da::removelist();
    assert( scripted_widgets::exists( #"hash_3ccc1702bc979da8" ) );
    scripted_widgets::set_focus( #"hash_3ccc1702bc979da8", 0 );
    scripted_widgets::remove( #"hash_3ccc1702bc979da8" );
    statemachine = player function_1bb19090();
    
    if ( player function_a997529d() )
    {
        level clientfield::set( "eboard_notify_from_server", 2 );
        level thread namespace_4ed3ce47::function_f60575fd();
        level scene::stop( "scene_hub_eboard_handler" );
        player function_3ab14abb();
        player clientfield::set_to_player( "eboard_camera_position", 2 );
        wait statemachine.blackboard.var_b2257d78;
        player clientfield::set_to_player( "eboard_camera_position", 28 );
        scripted_widgets::function_f96376c5( #"hash_3ccc1702bc979da8" );
    }
}

// Namespace namespace_fa335fda/namespace_f784b4da
// Params 1, eflags: 0x4
// Checksum 0xa8d86a0a, Offset: 0x4e50
// Size: 0x1ac
function private function_de709256( *params )
{
    player = self;
    assert( isplayer( player ) );
    
    /#
        player function_fc845aca();
    #/
    
    statemachine = player function_1bb19090();
    blackboard = statemachine.blackboard;
    assert( isdefined( blackboard.var_c5bde695 ) );
    evidence = blackboard.var_3cb3ede5[ blackboard.var_c5bde695 ];
    scripted_widgets::hide_widgets( #"hash_34f10865afcf9af7", [ #"interactive_map" ] );
    namespace_46c3c08e::function_eadf5d0b();
    waitframe( 1 );
    namespace_c8e236da::removelist();
    namespace_c8e236da::addprompt( #"hash_338b558abc2e635" );
    namespace_c8e236da::addprompt( #"hash_75a71993b5ef3343" );
    namespace_c8e236da::addprompt( #"hash_480d246174c7faa7" );
    blackboard.var_1bfff22b show();
}

// Namespace namespace_fa335fda/namespace_f784b4da
// Params 1, eflags: 0x4
// Checksum 0xa18f6f6f, Offset: 0x5008
// Size: 0x104
function private function_35a396ee( *params )
{
    player = self;
    assert( isplayer( player ) );
    player endon( #"eboard_state_change" );
    var_26d73535 = namespace_46c3c08e::function_f9edf6c2();
    assert( var_26d73535 > 0 );
    player thread scripted_widgets::function_e13a1a9c( [ 1, var_26d73535 ], &function_54e62ef2, &function_4b6a0f, &function_85225ecb, undefined, undefined, "eboard_state_change", 0 );
}

// Namespace namespace_fa335fda/namespace_f784b4da
// Params 2, eflags: 0x4
// Checksum 0x77d9e312, Offset: 0x5118
// Size: 0x8c
function private function_54e62ef2( *var_ff2113f5, var_c8916295 )
{
    player = self;
    assert( isplayer( player ) );
    newindex = var_c8916295[ 1 ];
    scripted_widgets::function_9ade1d9b( #"hash_34f10865afcf9af7", "count", newindex );
}

// Namespace namespace_fa335fda/namespace_f784b4da
// Params 1, eflags: 0x4
// Checksum 0xcabfec7f, Offset: 0x51b0
// Size: 0x5e, Type: bool
function private function_4b6a0f( var_768a0348 )
{
    player = self;
    assert( isplayer( player ) );
    namespace_46c3c08e::function_407ee527( var_768a0348[ 1 ] );
    return false;
}

// Namespace namespace_fa335fda/namespace_f784b4da
// Params 0, eflags: 0x4
// Checksum 0xa5971315, Offset: 0x5218
// Size: 0x40
function private function_85225ecb()
{
    player = getplayers()[ 0 ];
    player notify( #"evidence_board_review_suspects_unselected" );
}

// Namespace namespace_fa335fda/namespace_f784b4da
// Params 0, eflags: 0x4
// Checksum 0xded885c3, Offset: 0x5260
// Size: 0xe2
function private function_3740b568()
{
    player = self;
    assert( isplayer( player ) );
    namespace_46c3c08e::function_2340e15a();
    scripted_widgets::function_f96376c5( #"hash_34f10865afcf9af7" );
    statemachine = player function_1bb19090();
    blackboard = statemachine.blackboard;
    assert( isdefined( blackboard.var_c5bde695 ) );
    blackboard.var_1bfff22b hide();
    waitframe( 1 );
}

// Namespace namespace_fa335fda/namespace_f784b4da
// Params 1, eflags: 0x4
// Checksum 0x7e1f445b, Offset: 0x5350
// Size: 0x44
function private function_c4deb1a2( *params )
{
    namespace_c8e236da::removelist();
    waitframe( 1 );
    namespace_c8e236da::addprompt( #"hash_75a71993b5ef3343" );
}

// Namespace namespace_fa335fda/namespace_f784b4da
// Params 1, eflags: 0x4
// Checksum 0xa86a6983, Offset: 0x53a0
// Size: 0x1e8
function private function_b00f82b( *params )
{
    player = self;
    assert( isplayer( player ) );
    statemachine = player function_1bb19090();
    blackboard = statemachine.blackboard;
    assert( isdefined( blackboard.var_c5bde695 ) );
    assert( isdefined( blackboard.var_bcd1e3f9 ) );
    evidence = blackboard.var_3cb3ede5[ blackboard.var_c5bde695 ];
    assert( isdefined( evidence.var_dade7c7f ) && isdefined( evidence.var_dade7c7f[ blackboard.var_bcd1e3f9 ] ) );
    assert( collectibles::function_606a97af( evidence.var_dade7c7f[ blackboard.var_bcd1e3f9 ].callback ) );
    
    if ( isdefined( blackboard.var_a83e0330 ) )
    {
        blackboard.var_a83e0330 clientfield::set( "eboard_review_handle_viewmodel", 0 );
    }
    
    collectibles::function_f539a1fa( evidence.var_dade7c7f[ blackboard.var_bcd1e3f9 ].callback );
    
    while ( scripted_widgets::function_57fbd346() )
    {
        waitframe( 1 );
    }
    
    player notify( #"evidence_board_evidence_callback_finished" );
}

// Namespace namespace_fa335fda/namespace_f784b4da
// Params 1, eflags: 0x4
// Checksum 0x961137a9, Offset: 0x5590
// Size: 0xbc
function private function_340179ff( *params )
{
    namespace_c8e236da::removelist();
    player = self;
    assert( isplayer( player ) );
    statemachine = player function_1bb19090();
    blackboard = statemachine.blackboard;
    
    if ( isdefined( blackboard.var_a83e0330 ) )
    {
        blackboard.var_a83e0330 clientfield::set( "eboard_review_handle_viewmodel", 1 );
    }
}

// Namespace namespace_fa335fda/namespace_f784b4da
// Params 1, eflags: 0x4
// Checksum 0xd92f0eb9, Offset: 0x5658
// Size: 0x4dc
function private function_e2e9758c( *params )
{
    player = self;
    assert( isplayer( player ) );
    
    /#
        player function_fc845aca();
    #/
    
    statemachine = player function_1bb19090();
    blackboard = statemachine.blackboard;
    assert( isdefined( blackboard.var_c5bde695 ) );
    
    if ( player function_305352b5() )
    {
        evidence = blackboard.var_3cb3ede5[ blackboard.var_c5bde695 ];
        assert( isdefined( evidence.var_dade7c7f ) && evidence.var_dade7c7f.size > 0 );
        assert( !scripted_widgets::exists( #"hash_afc09dfd34bcde0" ) );
        scripted_widgets::create( #"hash_afc09dfd34bcde0", #"hash_102694e2bfda6f95" );
        scripted_widgets::function_d3c3e5c3( #"hash_afc09dfd34bcde0", #"interactive_map" );
        scripted_widgets::function_9ade1d9b( #"hash_afc09dfd34bcde0", "LevelName", #"" );
        
        foreach ( index, collectible in evidence.var_dade7c7f )
        {
            scripted_widgets::function_f2a9266( #"hash_afc09dfd34bcde0", index, "Title", collectible.title );
            scripted_widgets::function_f2a9266( #"hash_afc09dfd34bcde0", index, "SubTitle", collectible.subtitle );
            scripted_widgets::function_f2a9266( #"hash_afc09dfd34bcde0", index, "Description", collectible.description );
            scripted_widgets::function_f2a9266( #"hash_afc09dfd34bcde0", index, "Thumbnail", collectible.thumbnail );
        }
        
        scripted_widgets::set_focus( #"hash_afc09dfd34bcde0", 1 );
        scripted_widgets::function_9ade1d9b( #"hash_afc09dfd34bcde0", "text", evidence.levelname );
        player clientfield::set_to_player( "set_hub_dof", 5 );
        player clientfield::set_to_player( "set_hub_fov", 1 );
        blackboard.var_a83e0330 = spawn( "script_model", ( 0, 0, 0 ) );
        blackboard.var_1bfff22b show();
    }
    
    namespace_c8e236da::removelist();
    
    if ( blackboard.var_c5bde695 == "cp_sidemission_takedown" || blackboard.var_c5bde695 == "cp_sidemission_tundra" )
    {
        namespace_c8e236da::addprompt( #"hash_17b9b456d5a6cd85" );
    }
    
    namespace_c8e236da::addprompt( #"hash_75a71993b5ef3343" );
    namespace_c8e236da::addprompt( #"hash_5f8370ec8d76d10c" );
    namespace_c8e236da::addprompt( #"hash_480d246174c7faa7" );
}

// Namespace namespace_fa335fda/namespace_f784b4da
// Params 1, eflags: 0x4
// Checksum 0x707059b1, Offset: 0x5b40
// Size: 0x174
function private function_109f3f2( *params )
{
    player = self;
    assert( isplayer( player ) );
    player endon( #"eboard_state_change" );
    statemachine = player function_1bb19090();
    blackboard = statemachine.blackboard;
    evidence = blackboard.var_3cb3ede5[ blackboard.var_c5bde695 ];
    var_75c8057d = evidence.var_dade7c7f.size;
    var_b500c944 = undefined;
    
    if ( isdefined( blackboard.var_bcd1e3f9 ) )
    {
        var_b500c944 = [ 0, blackboard.var_bcd1e3f9 ];
    }
    
    player thread scripted_widgets::function_e13a1a9c( [ 1, var_75c8057d ], &function_9019d1f0, &function_57c5b410, &function_5ad666ce, undefined, undefined, "eboard_state_change", 1, var_b500c944 );
}

// Namespace namespace_fa335fda/namespace_f784b4da
// Params 2, eflags: 0x4
// Checksum 0x75177c0c, Offset: 0x5cc0
// Size: 0xcc
function private function_9019d1f0( *var_ff2113f5, var_c8916295 )
{
    player = self;
    assert( isplayer( player ) );
    newindex = var_c8916295[ 1 ];
    scripted_widgets::function_9ade1d9b( #"hash_afc09dfd34bcde0", "count", newindex );
    statemachine = player function_1bb19090();
    player thread function_1ec0078f( newindex, statemachine.blackboard );
}

// Namespace namespace_fa335fda/namespace_f784b4da
// Params 1, eflags: 0x4
// Checksum 0x26867bed, Offset: 0x5d98
// Size: 0x140
function private function_57c5b410( var_768a0348 )
{
    player = self;
    assert( isplayer( player ) );
    index = var_768a0348[ 1 ];
    statemachine = player function_1bb19090();
    blackboard = statemachine.blackboard;
    assert( isdefined( blackboard.var_c5bde695 ) );
    evidence = blackboard.var_3cb3ede5[ blackboard.var_c5bde695 ];
    assert( isdefined( evidence.var_dade7c7f ) && isdefined( evidence.var_dade7c7f[ index ] ) );
    
    if ( collectibles::function_606a97af( evidence.var_dade7c7f[ index ].callback ) )
    {
        player notify( #"evidence_board_evidence_callback_execute" );
    }
}

// Namespace namespace_fa335fda/namespace_f784b4da
// Params 0, eflags: 0x4
// Checksum 0x5e2089ff, Offset: 0x5ee0
// Size: 0x50
function private function_5ad666ce()
{
    player = self;
    assert( isplayer( player ) );
    player notify( #"evidence_board_review_unselected" );
}

// Namespace namespace_fa335fda/namespace_f784b4da
// Params 2, eflags: 0x4
// Checksum 0xfe969953, Offset: 0x5f38
// Size: 0x25a
function private function_1ec0078f( index, blackboard )
{
    player = self;
    assert( isplayer( player ) );
    self notify( "50c109da0f8f22e3" );
    self endon( "50c109da0f8f22e3" );
    player endon( #"hash_206b23ce56f8caf7" );
    wait 0.25;
    evidence = blackboard.var_3cb3ede5[ blackboard.var_c5bde695 ];
    
    if ( isdefined( blackboard.var_bcd1e3f9 ) )
    {
        data = evidence.var_dade7c7f[ blackboard.var_bcd1e3f9 ];
        var_c3f78937 = getent( data.tagname, "script_noteworthy" );
        
        if ( isdefined( var_c3f78937 ) )
        {
            var_c3f78937 show();
        }
    }
    
    data = evidence.var_dade7c7f[ index ];
    var_afbac09f = getent( data.tagname, "script_noteworthy" );
    
    if ( isdefined( var_afbac09f ) )
    {
        var_afbac09f hide();
    }
    
    if ( isdefined( data.uimodel ) )
    {
        blackboard.var_a83e0330 setmodel( data.uimodel );
        blackboard.var_a83e0330 clientfield::set( "eboard_evidence_angle_limit_x", isdefined( data.var_4efbbcfe ) ? data.var_4efbbcfe : 0 );
        blackboard.var_a83e0330 clientfield::set( "eboard_evidence_angle_limit_y", isdefined( data.var_4138e7ed ) ? data.var_4138e7ed : 0 );
        blackboard.var_a83e0330 clientfield::set( "eboard_review_handle_viewmodel", 1 );
    }
    
    blackboard.var_bcd1e3f9 = index;
}

// Namespace namespace_fa335fda/namespace_f784b4da
// Params 1, eflags: 0x4
// Checksum 0x196bc485, Offset: 0x61a0
// Size: 0x20a
function private function_3db40935( *params )
{
    player = self;
    assert( isplayer( player ) );
    
    /#
        player function_d530ce5a();
    #/
    
    statemachine = player function_1bb19090();
    blackboard = statemachine.blackboard;
    
    if ( player function_a997529d() )
    {
        blackboard.var_1bfff22b hide();
        player notify( #"hash_206b23ce56f8caf7" );
        
        if ( isdefined( blackboard.var_bcd1e3f9 ) )
        {
            evidence = blackboard.var_3cb3ede5[ blackboard.var_c5bde695 ];
            data = evidence.var_dade7c7f[ blackboard.var_bcd1e3f9 ];
            var_afbac09f = getent( data.tagname, "script_noteworthy" );
            
            if ( isdefined( var_afbac09f ) )
            {
                var_afbac09f show();
            }
        }
        
        assert( scripted_widgets::exists( #"hash_afc09dfd34bcde0" ) );
        scripted_widgets::remove( #"hash_afc09dfd34bcde0" );
        blackboard.var_bcd1e3f9 = undefined;
        blackboard.var_a83e0330 delete();
        namespace_c8e236da::removelist();
        waitframe( 1 );
    }
}

/#

    // Namespace namespace_fa335fda/namespace_f784b4da
    // Params 0, eflags: 0x4
    // Checksum 0xc196a001, Offset: 0x63b8
    // Size: 0xac, Type: dev
    function private function_fc845aca()
    {
        player = self;
        assert( isplayer( player ) );
        
        if ( is_true( level.var_47df5f11 ) )
        {
            statemachine = player function_1bb19090();
            println( "<dev string:x28c>" + statemachine.current_state.name );
        }
    }

    // Namespace namespace_fa335fda/namespace_f784b4da
    // Params 0, eflags: 0x4
    // Checksum 0xbd1b83da, Offset: 0x6470
    // Size: 0xac, Type: dev
    function private function_d530ce5a()
    {
        player = self;
        assert( isplayer( player ) );
        
        if ( is_true( level.var_47df5f11 ) )
        {
            statemachine = player function_1bb19090();
            println( "<dev string:x2a7>" + statemachine.current_state.name );
        }
    }

#/
