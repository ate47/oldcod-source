#using script_1bf9ac5f65d7ecce;
#using script_38867f943fb86135;
#using script_76681e2a8b4ee520;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\easing;
#using scripts\core_common\load_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\serverfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\cp\cp_ger_hub_fx;

#namespace namespace_fa9f53a2;

// Namespace namespace_fa9f53a2/namespace_89829bca
// Params 0
// Checksum 0xa859ed10, Offset: 0x320
// Size: 0x37c
function main()
{
    clientfield::register( "scriptmover", "eboard_review_handle_viewmodel", 1, 1, "int", &eboard_review_handle_viewmodel, 0, 0 );
    clientfield::register( "scriptmover", "eboard_evidence_angle_limit_x", 1, 8, "int", &function_4c5fee2c, 0, 0 );
    clientfield::register( "scriptmover", "eboard_evidence_angle_limit_y", 1, 8, "int", &function_17de0559, 0, 0 );
    clientfield::register( "toplayer", "eboard_camera_position", 1, 5, "int", &function_75789681, 0, 0 );
    clientfield::register( "world", "eboard_notify_from_server", 1, 3, "int", &eboard_notify_from_server, 0, 0 );
    clientfield::register( "toplayer", "set_hub_fov", 1, 3, "int", &set_hub_fov, 0, 0 );
    clientfield::register( "toplayer", "set_hub_dof", 1, 3, "int", &set_hub_dof, 0, 0 );
    clientfield::register( "toplayer", "pstfx_t9_cp_hub_eboard_vignette", 1, 1, "int", &function_70550aed, 0, 0 );
    clientfield::register( "toplayer", "pstfx_t9_cp_hub_eboard_overview", 1, 1, "int", &function_de4bd542, 0, 0 );
    clientfield::register( "toplayer", "pstfx_teleport", 1, 3, "int", &pstfx_teleport, 0, 0 );
    clientfield::register( "toplayer", "computer_terminal_switch", 1, 1, "int", &computer_terminal_switch, 0, 0 );
    namespace_cd80be1c::function_107f09b();
    
    /#
        callback::on_localclient_connect( &function_d67e4971 );
    #/
    
    setdvar( #"hash_373bfe7468a7b3d2", 1 );
}

// Namespace namespace_fa9f53a2/namespace_89829bca
// Params 7
// Checksum 0xf300eddb, Offset: 0x6a8
// Size: 0x7c
function computer_terminal_switch( localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( bwastimejump )
    {
        function_ffe15984( fieldname );
        wait 5;
        return;
    }
    
    function_f80646f3( fieldname );
}

/#

    // Namespace namespace_fa9f53a2/namespace_89829bca
    // Params 1, eflags: 0x4
    // Checksum 0xa6a14bb3, Offset: 0x730
    // Size: 0x3c, Type: dev
    function private function_d67e4971( *localclientnum )
    {
        util::init_dvar( "<dev string:x38>", -1, &function_f0ab5077 );
    }

    // Namespace namespace_fa9f53a2/namespace_89829bca
    // Params 1, eflags: 0x4
    // Checksum 0xb8b52491, Offset: 0x778
    // Size: 0x136, Type: dev
    function private function_f0ab5077( params )
    {
        if ( params.value != -1 )
        {
            level.var_2221317a = 1;
            level notify( #"stop_model_lighting" );
        }
        else
        {
            level.var_2221317a = 0;
        }
        
        if ( params.value == 1 )
        {
            player = getlocalplayers()[ 0 ];
            localclientnum = player getlocalclientnumber();
            level.var_5fc7bc62 = function_a1c7b80( localclientnum );
            return;
        }
        
        if ( isdefined( level.var_5fc7bc62 ) )
        {
            player = getlocalplayers()[ 0 ];
            localclientnum = player getlocalclientnumber();
            stopfx( localclientnum, level.var_5fc7bc62 );
            level.var_5fc7bc62 = undefined;
        }
    }

#/

// Namespace namespace_fa9f53a2/namespace_89829bca
// Params 7
// Checksum 0x4b5c6b67, Offset: 0x8b8
// Size: 0x1e2
function set_hub_fov( *localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    n_time = 0.5;
    var_31f0ff13 = 0.2;
    
    switch ( bwastimejump )
    {
        case 1:
            self function_9298adaf( n_time );
            break;
        case 2:
            self easing::function_f95cb457( undefined, 22, var_31f0ff13, #"linear" );
            break;
        case 3:
            self easing::function_f95cb457( undefined, 22, 0, #"linear" );
            break;
        case 4:
            self easing::function_f95cb457( undefined, 20, n_time, #"linear" );
            break;
        case 5:
            self easing::function_f95cb457( undefined, 25, n_time, #"linear" );
            break;
        case 6:
            self easing::function_f95cb457( undefined, 30, n_time, #"linear" );
            break;
    }
}

// Namespace namespace_fa9f53a2/namespace_89829bca
// Params 7
// Checksum 0x85e54409, Offset: 0xaa8
// Size: 0x302
function set_hub_dof( *localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    n_time = 1;
    var_31f0ff13 = 0.2;
    var_1ea96e5d = 0.5;
    
    switch ( bwastimejump )
    {
        case 1:
            self function_9e574055( 0 );
            self function_3c54e2b8( var_31f0ff13 );
            self function_9ea7b4eb( var_31f0ff13 );
            self function_576abd46( 0 );
            break;
        case 2:
            self function_9e574055( 2 );
            self function_1816c600( 1.5, n_time );
            self function_d7be9a9f( 60, n_time );
            self function_576abd46( 1 );
            break;
        case 3:
            self function_9e574055( 2 );
            self function_1816c600( 1.5, n_time );
            self function_d7be9a9f( 90, n_time );
            self function_576abd46( 1 );
            break;
        case 4:
            self function_9e574055( 2 );
            self function_1816c600( 1.5, var_1ea96e5d );
            self function_d7be9a9f( 24, var_1ea96e5d );
            self function_576abd46( 1 );
            break;
        case 5:
            self function_9e574055( 2 );
            self function_1816c600( 1.5, var_1ea96e5d );
            self function_d7be9a9f( 14, var_1ea96e5d );
            self function_576abd46( 1 );
            break;
    }
}

// Namespace namespace_fa9f53a2/namespace_89829bca
// Params 7
// Checksum 0x642d7390, Offset: 0xdb8
// Size: 0x9a
function eboard_notify_from_server( *localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    switch ( bwastimejump )
    {
        case 1:
            level notify( #"evidence_board_mission_selected" );
            break;
        case 2:
            level notify( #"hash_3e8dc841ce47f8fd" );
            break;
    }
}

// Namespace namespace_fa9f53a2/namespace_89829bca
// Params 7
// Checksum 0xf6a6cf13, Offset: 0xe60
// Size: 0x4a
function function_4c5fee2c( *localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    self.var_4adf502b = bwastimejump;
}

// Namespace namespace_fa9f53a2/namespace_89829bca
// Params 7
// Checksum 0x1e2b9450, Offset: 0xeb8
// Size: 0x4a
function function_17de0559( *localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    self.var_5d8cf586 = bwastimejump;
}

// Namespace namespace_fa9f53a2/namespace_89829bca
// Params 7
// Checksum 0xefaead95, Offset: 0xf10
// Size: 0x500
function eboard_review_handle_viewmodel( localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( bwastimejump )
    {
        max_dist = 15;
        min_dist = 10;
        var_d5cbe081 = float( 60 ) / 1000;
        zoom_speed = float( 6 ) / 1000;
        var_fc67b3d2 = ( max_dist, -3, 0 );
        var_7b2c0c5a = ( 0, 0, 0 );
        
        if ( !isdefined( self.var_30ab6c90 ) )
        {
            self linktocamera( 4, var_fc67b3d2, var_7b2c0c5a );
            self.var_30ab6c90 = 1;
            self thread function_9b0161bf( fieldname );
        }
        
        player = function_5c10bd79( fieldname );
        time = player getclienttime();
        waitframe( 1 );
        current_model = #"none";
        
        while ( isdefined( self ) && isdefined( player ) && is_true( self.var_30ab6c90 ) )
        {
            if ( current_model != self.model )
            {
                current_model = self.model;
                var_c72514a7 = var_fc67b3d2;
                var_c2a4938f = var_7b2c0c5a;
                self linktocamera( 4, var_c72514a7, var_c2a4938f );
            }
            else
            {
                input = util::function_ca4b4e19( fieldname );
                var_bb432c3b = ( input[ #"look" ][ 1 ], input[ #"look" ][ 0 ], 0 );
                var_a23c6f11 = 0;
                
                if ( isbuttonpressed( fieldname, 14 ) )
                {
                    var_a23c6f11 = -1;
                }
                else if ( isbuttonpressed( fieldname, 15 ) )
                {
                    var_a23c6f11 = 1;
                }
                
                if ( var_bb432c3b != ( 0, 0, 0 ) || var_a23c6f11 != 0 )
                {
                    delta_time = player getclienttime() - time;
                    dist = var_c72514a7[ 0 ] + var_a23c6f11 * zoom_speed * delta_time;
                    
                    if ( dist < min_dist )
                    {
                        dist = min_dist;
                    }
                    else if ( dist > max_dist )
                    {
                        dist = max_dist;
                    }
                    
                    var_c72514a7 = ( dist, var_c72514a7[ 1 ], var_c72514a7[ 2 ] );
                    var_c2a4938f += var_bb432c3b * var_d5cbe081 * delta_time;
                    var_dc51c40d = var_c2a4938f[ 0 ];
                    
                    if ( isdefined( self.var_4adf502b ) && self.var_4adf502b !== 0 )
                    {
                        if ( var_dc51c40d < self.var_4adf502b * -1 )
                        {
                            var_dc51c40d = self.var_4adf502b * -1;
                        }
                        else if ( var_dc51c40d > self.var_4adf502b )
                        {
                            var_dc51c40d = self.var_4adf502b;
                        }
                    }
                    
                    var_4a239faf = var_c2a4938f[ 1 ];
                    
                    if ( isdefined( self.var_5d8cf586 ) && self.var_5d8cf586 !== 0 )
                    {
                        if ( var_4a239faf < self.var_5d8cf586 * -1 )
                        {
                            var_4a239faf = self.var_5d8cf586 * -1;
                        }
                        else if ( var_4a239faf > self.var_5d8cf586 )
                        {
                            var_4a239faf = self.var_5d8cf586;
                        }
                    }
                    
                    var_c2a4938f = ( var_dc51c40d, var_4a239faf, 0 );
                    self linktocamera( 4, var_c72514a7, var_c2a4938f );
                }
            }
            
            time = player getclienttime();
            waitframe( 1 );
        }
        
        return;
    }
    
    self function_a052b638();
    self.var_30ab6c90 = undefined;
    level notify( #"stop_model_lighting" );
}

// Namespace namespace_fa9f53a2/namespace_89829bca
// Params 1, eflags: 0x4
// Checksum 0xae4afd11, Offset: 0x1418
// Size: 0x3a
function private function_a1c7b80( localclientnum )
{
    return playfxoncamera( localclientnum, #"hash_7ca576e17e844485", ( 0, 0, 0 ), ( 1, 0, 0 ), ( 0, 0, 1 ) );
}

// Namespace namespace_fa9f53a2/namespace_89829bca
// Params 1, eflags: 0x4
// Checksum 0x1d05beec, Offset: 0x1460
// Size: 0x8c
function private function_9b0161bf( localclientnum )
{
    /#
        if ( is_true( level.var_2221317a ) )
        {
            return;
        }
    #/
    
    fx_id = function_a1c7b80( localclientnum );
    util::waittill_any_ents_two( self, "death", level, "stop_model_lighting" );
    stopfx( localclientnum, fx_id );
}

// Namespace namespace_fa9f53a2/namespace_89829bca
// Params 7
// Checksum 0x13ab34ac, Offset: 0x14f8
// Size: 0x22a
function function_75789681( *localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    var_a91f6be = undefined;
    var_4ef20eaa = struct::get( "evidence_board_player_pos", "targetname" );
    var_67367725 = var_4ef20eaa.origin;
    var_8939da60 = var_4ef20eaa.angles;
    level.var_420bb8d1 = self getcampos();
    var_a0497201 = 0.75;
    
    switch ( bwastimejump )
    {
        case 28:
            break;
        case 1:
            self easing::function_b6f1c993( undefined, 5000, var_a0497201, #"linear" );
            self easing::function_136edb11( undefined, 50, var_a0497201, #"linear" );
            break;
        case 2:
            var_d298ff03 = self getcamangles();
            self easing::ease_camera_position( level.var_420bb8d1, var_67367725, var_a0497201, #"quintic" );
            self easing::ease_camera_angles( ( angleclamp180( var_d298ff03[ 0 ] ), angleclamp180( var_d298ff03[ 1 ] ), angleclamp180( var_d298ff03[ 2 ] ) ), var_8939da60, var_a0497201, #"quintic" );
            break;
    }
}

// Namespace namespace_fa9f53a2/namespace_89829bca
// Params 7
// Checksum 0x2c8eb7f3, Offset: 0x1730
// Size: 0xa4
function function_70550aed( *localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( bwastimejump == 1 )
    {
        self postfx::playpostfxbundle( "pstfx_t9_cp_hub_eboard_vignette" );
        return;
    }
    
    if ( self postfx::function_556665f2( "pstfx_t9_cp_hub_eboard_vignette" ) )
    {
        self postfx::exitpostfxbundle( "pstfx_t9_cp_hub_eboard_vignette" );
    }
}

// Namespace namespace_fa9f53a2/namespace_89829bca
// Params 7
// Checksum 0x244b8a4e, Offset: 0x17e0
// Size: 0xa4
function function_de4bd542( *localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( bwastimejump == 1 )
    {
        self postfx::playpostfxbundle( "pstfx_t9_cp_hub_eboard_overview" );
        return;
    }
    
    if ( self postfx::function_556665f2( "pstfx_t9_cp_hub_eboard_overview" ) )
    {
        self postfx::exitpostfxbundle( "pstfx_t9_cp_hub_eboard_overview" );
    }
}

// Namespace namespace_fa9f53a2/namespace_89829bca
// Params 7
// Checksum 0x9f2f0442, Offset: 0x1890
// Size: 0x54
function pstfx_teleport( *localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    self thread function_4902644c( bwastimejump );
}

// Namespace namespace_fa9f53a2/namespace_89829bca
// Params 1, eflags: 0x4
// Checksum 0x309d6a0b, Offset: 0x18f0
// Size: 0x188
function private function_4902644c( newval )
{
    self endon( #"death" );
    self notify( "3e7d29af74aea4cb" );
    self endon( "3e7d29af74aea4cb" );
    wait 0.1;
    bundles[ 1 ] = "pstfx_t9_cp_prisoner_mkultra_transition";
    bundles[ 2 ] = "pstfx_t9_cp_prisoner_mkultra_transition_short";
    bundles[ 3 ] = "pstfx_t9_cp_prisoner_mkultra_white_transition_short";
    
    foreach ( key, value in bundles )
    {
        if ( newval != key && self postfx::function_556665f2( value ) )
        {
            if ( !isdefined( bundles[ newval ] ) )
            {
                self postfx::exitpostfxbundle( value );
            }
            else
            {
                self postfx::stoppostfxbundle( value );
            }
        }
        
        if ( newval == key && !self postfx::function_556665f2( value ) )
        {
            self postfx::playpostfxbundle( value );
        }
    }
}

