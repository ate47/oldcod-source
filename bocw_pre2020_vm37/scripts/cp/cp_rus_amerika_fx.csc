#using scripts\core_common\clientfield_shared;

#namespace namespace_f942705d;

// Namespace namespace_f942705d/cp_rus_amerika_fx
// Params 0
// Checksum 0x1afa69, Offset: 0xe8
// Size: 0x94
function preload()
{
    clientfield::register( "scriptmover", "play_coin_fx", 1, 1, "counter", &play_coin_fx, 0, 0 );
    clientfield::register( "scriptmover", "kill_coin_fx", 1, 1, "counter", &kill_coin_fx, 0, 0 );
}

// Namespace namespace_f942705d/cp_rus_amerika_fx
// Params 7
// Checksum 0x7d39b84a, Offset: 0x188
// Size: 0x6a
function play_coin_fx( localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    self.var_9053876c = function_239993de( bwastimejump, "maps/cp_rus_amerika/fx9_amerika_quarter_glint_runner", self, "tag_origin" );
}

// Namespace namespace_f942705d/cp_rus_amerika_fx
// Params 7
// Checksum 0xc09e5ecc, Offset: 0x200
// Size: 0x5c
function kill_coin_fx( localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    killfx( bwastimejump, self.var_9053876c );
}

