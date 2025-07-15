#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;

#namespace root_cinematics;

// Namespace root_cinematics
// Params 0
// Checksum 0xb57060ce, Offset: 0x160
// Size: 0x2b
function main()
{
    init_clientfields();
    level._effect[ "exploding_tree" ] = "explosions/fx_exp_lightning_fold_infection";
}

// Namespace root_cinematics
// Params 0
// Checksum 0x54fd6ff, Offset: 0x198
// Size: 0x3a
function init_clientfields()
{
    clientfield::register( "scriptmover", "exploding_tree", 1, 1, "counter", &function_85138237, 0, 0 );
}

// Namespace root_cinematics
// Params 7
// Checksum 0x5ba48f8b, Offset: 0x1e0
// Size: 0x62
function function_85138237( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    playfx( localclientnum, level._effect[ "exploding_tree" ], self.origin );
}

