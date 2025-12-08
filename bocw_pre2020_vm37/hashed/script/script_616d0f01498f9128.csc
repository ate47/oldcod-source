#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;

#namespace namespace_1d4ee4f8;

// Namespace namespace_1d4ee4f8/namespace_1d4ee4f8
// Params 0
// Checksum 0x79807159, Offset: 0xa8
// Size: 0x4c
function preload()
{
    clientfield::register( "toplayer", "optional_objective_camera_fx", 1, 1, "int", &optional_objective_camera_fx, 0, 0 );
}

// Namespace namespace_1d4ee4f8/namespace_1d4ee4f8
// Params 0
// Checksum 0x56a02542, Offset: 0x100
// Size: 0x2c
function postload()
{
    level._effect[ #"hash_57ee68985468f554" ] = #"wz/fx8_plyr_pstfx_numbers";
}

// Namespace namespace_1d4ee4f8/namespace_1d4ee4f8
// Params 7
// Checksum 0x5621e0c6, Offset: 0x138
// Size: 0xba
function optional_objective_camera_fx( localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( isdefined( self.var_dcb8af99 ) )
    {
        stopfx( fieldname, self.var_dcb8af99 );
        self.var_d392b4d1 = undefined;
    }
    
    if ( bwastimejump )
    {
        self.var_dcb8af99 = playfxoncamera( fieldname, level._effect[ #"hash_57ee68985468f554" ], undefined, ( 1, 0, 0 ), ( 0, 0, 1 ) );
    }
}

