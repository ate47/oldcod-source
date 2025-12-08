#using script_581877678e31274c;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\ai\zombie_dog_toxic_cloud;

#namespace zm_ai_dog;

// Namespace zm_ai_dog/zm_ai_dog
// Params 0, eflags: 0x6
// Checksum 0xcee9fa32, Offset: 0xa8
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"zm_ai_dog", &preinit, undefined, undefined, undefined );
}

// Namespace zm_ai_dog/zm_ai_dog
// Params 0, eflags: 0x4
// Checksum 0xc2ff073c, Offset: 0xf0
// Size: 0x4c
function private preinit()
{
    clientfield::register( "actor", "ZombieDogVocals", 1, 2, "int", &zombiedogvocals, 0, 0 );
}

// Namespace zm_ai_dog/zm_ai_dog
// Params 7
// Checksum 0xb9ff42d, Offset: 0x148
// Size: 0x172
function zombiedogvocals( localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *wasdemojump )
{
    self endon( #"death" );
    
    if ( isdefined( self.var_64e89a2f ) )
    {
        self stoploopsound( self.var_64e89a2f );
    }
    
    if ( wasdemojump )
    {
        switch ( wasdemojump )
        {
            case 1:
                var_e5404960 = undefined;
                var_9c464736 = #"hash_50a34ea4add0897";
                break;
            case 2:
                var_e5404960 = #"hash_16838de4eb2b7f00";
                var_9c464736 = #"hash_219cfeed2cbf8adc";
                break;
        }
        
        if ( isdefined( var_e5404960 ) )
        {
            self playsound( fieldname, var_e5404960, self.origin + ( 20, 0, 30 ) );
        }
        
        self.var_35e2a4c0 = self playloopsound( var_9c464736, 1.5, ( 20, 0, 30 ) );
    }
}

