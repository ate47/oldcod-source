#using script_140d5347de8af85c;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\easing;
#using scripts\core_common\system_shared;

#namespace action_utility;

// Namespace action_utility/action_utility
// Params 0, eflags: 0x6
// Checksum 0xefe84b9d, Offset: 0xe0
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"action_utility", &preinit, undefined, undefined, undefined );
}

// Namespace action_utility/action_utility
// Params 0, eflags: 0x4
// Checksum 0xa2b23311, Offset: 0x128
// Size: 0xdc
function private preinit()
{
    clientfield::register( "scriptmover", "link_to_camera", 1, 1, "int", &link_to_camera, 0, 0 );
    clientfield::register( "actor", "link_to_camera", 1, 1, "int", &link_to_camera, 0, 0 );
    clientfield::register( "toplayer", "fake_ads", 1, 1, "int", &fake_ads, 0, 0 );
}

// Namespace action_utility/action_utility
// Params 7, eflags: 0x4
// Checksum 0xfe1f8264, Offset: 0x210
// Size: 0xac
function private link_to_camera( localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    player = function_5c10bd79( fieldname );
    
    if ( bwastimejump )
    {
        self thread function_bd9c7275();
        return;
    }
    
    self notify( #"hash_97425a408a077df" );
    self function_a052b638();
}

// Namespace action_utility/action_utility
// Params 7, eflags: 0x4
// Checksum 0xd0ec436c, Offset: 0x2c8
// Size: 0x14c
function private fake_ads( localclientnum, oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    self notify( "2e682ee9f9b29c84" );
    self endon( "2e682ee9f9b29c84" );
    
    if ( bwastimejump && bwastimejump != fieldname )
    {
        self easing::function_f95cb457( undefined, 20.64, 0.2, #"sine" );
        return;
    }
    
    if ( !bwastimejump && bwastimejump != fieldname )
    {
        self easing::function_f95cb457( undefined, 14.64, 0.2, #"sine" );
        
        while ( true )
        {
            result = self waittill( #"ease_done" );
            
            if ( result.target_value === 14.64 )
            {
                self function_9298adaf( binitialsnap );
                break;
            }
        }
    }
}

// Namespace action_utility/action_utility
// Params 0, eflags: 0x4
// Checksum 0xe6724533, Offset: 0x420
// Size: 0x84
function private function_bd9c7275()
{
    self notify( #"hash_97425a408a077df" );
    self endon( #"hash_97425a408a077df" );
    self linktocamera( 4, ( 0, 0, -60 ) );
    self waittill( #"death", #"entitydeleted" );
    self function_a052b638();
}

