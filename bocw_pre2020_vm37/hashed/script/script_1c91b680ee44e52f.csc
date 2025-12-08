#using scripts\core_common\ai\archetype_brutus;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\util_shared;

#namespace namespace_df4fbf0;

// Namespace namespace_df4fbf0/namespace_df4fbf0
// Params 0
// Checksum 0x38daafea, Offset: 0x140
// Size: 0xac
function init()
{
    function_cae618b4( "spawner_zombietron_brutus" );
    clientfield::register( "toplayer", "brutus_shock_attack_player", 1, 1, "counter", &brutus_shock_attack_player, 0, 0 );
    clientfield::register( "actor", "brutus_shock_attack", 1, 1, "counter", &brutus_shock_attack_fx, 0, 0 );
}

// Namespace namespace_df4fbf0/namespace_df4fbf0
// Params 7
// Checksum 0xf7e5510b, Offset: 0x1f8
// Size: 0x5c
function brutus_shock_attack_player( localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwasdemojump )
{
    function_36e4ebd4( bwasdemojump, "damage_heavy" );
}

// Namespace namespace_df4fbf0/namespace_df4fbf0
// Params 7
// Checksum 0xea39b523, Offset: 0x260
// Size: 0xc4
function brutus_shock_attack_fx( localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwasdemojump )
{
    self util::waittill_dobj( bwasdemojump );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    playfx( bwasdemojump, "maps/zm_escape/fx8_alcatraz_brut_shock", self.origin, anglestoup( self.angles ) );
    earthquake( bwasdemojump, 1, 1, self.origin, 512 );
}

