#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flashlight;

#namespace cp_rus_yamantau_flashlight;

// Namespace cp_rus_yamantau_flashlight/cp_rus_yamantau_flashlight
// Params 0
// Checksum 0x9c81c438, Offset: 0xf0
// Size: 0x94
function preload()
{
    clientfield::register( "toplayer", "cp_rus_yamantau_flashlight", 1, 2, "int", &function_70723e25, 0, 0 );
    clientfield::register( "actor", "set_flashlight_fx", 1, 1, "int", &set_flashlight_fx, 0, 0 );
}

// Namespace cp_rus_yamantau_flashlight/cp_rus_yamantau_flashlight
// Params 0
// Checksum 0xe0a78f5a, Offset: 0x190
// Size: 0x2c
function postload()
{
    level._effect[ #"player_flashlight" ] = #"hash_670a56e843776b6f";
}

// Namespace cp_rus_yamantau_flashlight/cp_rus_yamantau_flashlight
// Params 7
// Checksum 0x7a5b616b, Offset: 0x1c8
// Size: 0x126
function function_70723e25( localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( bwastimejump )
    {
        if ( isdefined( level.var_d392b4d1 ) )
        {
            stopfx( fieldname, level.var_d392b4d1 );
            level.var_d392b4d1 = undefined;
        }
        
        n_offset = 4;
        
        if ( bwastimejump == 2 )
        {
            n_offset = 0;
        }
        
        level.var_d392b4d1 = playfxoncamera( fieldname, level._effect[ #"player_flashlight" ], ( 0, n_offset, 1.5 ), ( 1, 0, -0.1 ), ( 0, 0, 1 ) );
        return;
    }
    
    stopfx( fieldname, level.var_d392b4d1 );
    level.var_d392b4d1 = undefined;
}

// Namespace cp_rus_yamantau_flashlight/cp_rus_yamantau_flashlight
// Params 7
// Checksum 0x45a9e98b, Offset: 0x2f8
// Size: 0x6c
function set_flashlight_fx( localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwasdemojump )
{
    flashlightfx = "maps/cp_rus_yamantau/fx9_yam_flashlight_ai";
    self flashlight::function_69258685( bwasdemojump, flashlightfx );
}

