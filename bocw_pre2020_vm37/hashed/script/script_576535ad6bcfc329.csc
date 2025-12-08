#using scripts\core_common\ai\archetype_skeleton;
#using scripts\core_common\ai\systems\fx_character;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_d1abdcb5;

// Namespace namespace_d1abdcb5/namespace_d1abdcb5
// Params 0
// Checksum 0xf59778fb, Offset: 0x1b0
// Size: 0x18c
function init()
{
    function_cae618b4( "spawner_zombietron_skeleton" );
    function_cae618b4( "spawner_zombietron_skeleton_giant" );
    clientfield::register( "scriptmover", "" + #"spartoi_reassemble_clientfield", 1, 1, "int", &function_d83c0144, 0, 0 );
    clientfield::register( "actor", "" + #"hash_3a6a3e4ef0a1a999", 1, 1, "counter", &function_9e6319c8, 0, 0 );
    clientfield::register( "actor", "skel_spawn_fx", 1, 1, "counter", &skel_spawn_fx, 0, 0 );
    ai::add_archetype_spawn_function( #"skeleton", &skeletonspawnsetup );
    ai::add_archetype_spawn_function( #"skeleton", &function_3b8e5273 );
}

// Namespace namespace_d1abdcb5/namespace_d1abdcb5
// Params 7
// Checksum 0x97ca8d28, Offset: 0x348
// Size: 0x74
function skel_spawn_fx( localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwasdemojump )
{
    util::playfxontag( bwasdemojump, level._effect[ #"lightning_dog_spawn" ], self, "j_spine2" );
}

// Namespace namespace_d1abdcb5/namespace_d1abdcb5
// Params 1, eflags: 0x4
// Checksum 0x805a84e0, Offset: 0x3c8
// Size: 0x4c
function private skeletonspawnsetup( localclientnum )
{
    self util::waittill_dobj( localclientnum );
    
    if ( isdefined( self ) )
    {
        fxclientutils::playfxbundle( localclientnum, self, self.fxdef );
    }
}

// Namespace namespace_d1abdcb5/namespace_d1abdcb5
// Params 1, eflags: 0x4
// Checksum 0xfdd3adfd, Offset: 0x420
// Size: 0xc0
function private function_3b8e5273( *localclientnum )
{
    if ( self.subarchetype === #"hash_342763a42d8fbca" || self.subarchetype === #"hash_fd7b9665529dd42" )
    {
        if ( !is_true( level.shield_streaming ) )
        {
            level.shield_streaming = 1;
            forcestreamxmodel( #"c_t8_zmb_dlc2_skeleton_shield" );
            wait 3;
            stopforcestreamingxmodel( #"c_t8_zmb_dlc2_skeleton_shield" );
            level.shield_streaming = 0;
        }
    }
}

// Namespace namespace_d1abdcb5/namespace_d1abdcb5
// Params 7, eflags: 0x4
// Checksum 0xa743c7db, Offset: 0x4e8
// Size: 0x146
function private function_d83c0144( localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    util::waittill_dobj( fieldname );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( bwastimejump == 1 )
    {
        self.fx = function_239993de( fieldname, "zm_ai/fx8_spartoi_reassemble_displace_trail", self, "tag_origin" );
        
        if ( !isdefined( self.var_45dc5e53 ) )
        {
            self playsound( 0, #"hash_6804d485c5a3300a" );
            self.var_45dc5e53 = self playloopsound( #"hash_2ee9559ba02d2e9e" );
        }
        
        return;
    }
    
    stopfx( fieldname, self.fx );
    
    if ( isdefined( self.var_45dc5e53 ) )
    {
        self stoploopsound( self.var_45dc5e53 );
        self.var_45dc5e53 = undefined;
    }
}

// Namespace namespace_d1abdcb5/namespace_d1abdcb5
// Params 7, eflags: 0x4
// Checksum 0x6ffae83a, Offset: 0x638
// Size: 0x124
function private function_9e6319c8( localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    util::waittill_dobj( fieldname );
    
    if ( bwastimejump == 1 )
    {
        point = self gettagorigin( "j_skeleton_shield" );
        
        if ( !isdefined( point ) )
        {
            return;
        }
        
        angles = self.angles;
        forward = anglestoforward( angles );
        up = anglestoup( angles );
        playsound( fieldname, #"hash_72db6f3f0e602a33", point );
        playfx( fieldname, "impacts/fx8_bul_impact_metal_lg", point, forward, up );
    }
}

