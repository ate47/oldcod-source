#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_5443b356;

// Namespace namespace_5443b356/namespace_88f6bc3c
// Params 0, eflags: 0x2
// Checksum 0x59457cb1, Offset: 0x130
// Size: 0xdc
function autoexec main()
{
    clientfield::register( "toplayer", "player_cam_blur", 1, 1, "int", &player_cam_blur, 0, 1 );
    clientfield::register( "toplayer", "player_cam_bubbles", 1, 1, "int", &player_cam_bubbles, 0, 1 );
    clientfield::register( "toplayer", "player_cam_fire", 1, 1, "int", &player_cam_fire, 0, 0 );
}

// Namespace namespace_5443b356/namespace_88f6bc3c
// Params 7
// Checksum 0x42065f8f, Offset: 0x218
// Size: 0x96
function player_cam_blur( localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( bwastimejump == 1 && !function_1cbf351b( fieldname ) )
    {
        self thread function_3c4a545b( fieldname );
        return;
    }
    
    self notify( #"hash_31875ebd426b00c1" );
}

// Namespace namespace_5443b356/namespace_88f6bc3c
// Params 1
// Checksum 0x5986103e, Offset: 0x2b8
// Size: 0x6a
function function_3c4a545b( *localclientnum )
{
    self endon( #"disconnect" );
    self endon( #"hash_31875ebd426b00c1" );
    var_f052fbf4 = 0.5;
    
    while ( var_f052fbf4 <= 1 )
    {
        var_f052fbf4 += 0.04;
        waitframe( 1 );
    }
}

// Namespace namespace_5443b356/namespace_88f6bc3c
// Params 7
// Checksum 0xcd21c8fc, Offset: 0x330
// Size: 0x114
function player_cam_bubbles( localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( bwastimejump == 1 && !function_1cbf351b( fieldname ) )
    {
        if ( isdefined( self.n_fx_id ) )
        {
            deletefx( fieldname, self.n_fx_id, 1 );
        }
        
        self.n_fx_id = playfxoncamera( fieldname, "player/fx_plyr_swim_bubbles_body", ( 0, 0, 0 ), ( 1, 0, 0 ), ( 0, 0, 1 ) );
        self playrumbleonentity( fieldname, "damage_heavy" );
        return;
    }
    
    if ( isdefined( self.n_fx_id ) )
    {
        deletefx( fieldname, self.n_fx_id, 1 );
    }
}

// Namespace namespace_5443b356/namespace_88f6bc3c
// Params 7
// Checksum 0xdccdb633, Offset: 0x450
// Size: 0x8c
function player_cam_fire( localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( bwastimejump == 1 && !function_1cbf351b( fieldname ) )
    {
        burn_on_postfx();
        return;
    }
    
    function_97a0dd0a();
}

// Namespace namespace_5443b356/namespace_88f6bc3c
// Params 0
// Checksum 0x3e9342f2, Offset: 0x4e8
// Size: 0x4c
function burn_on_postfx()
{
    self endon( #"disconnect" );
    self endon( #"hash_8098b25d66c781c" );
    self thread postfx::playpostfxbundle( #"pstfx_burn_loop" );
}

// Namespace namespace_5443b356/namespace_88f6bc3c
// Params 0
// Checksum 0xd575e5af, Offset: 0x540
// Size: 0x34
function function_97a0dd0a()
{
    self notify( #"hash_8098b25d66c781c" );
    self postfx::stoppostfxbundle( "pstfx_burn_loop" );
}

