#using scripts\core_common\ai\systems\fx_character;
#using scripts\core_common\ai_shared;
#using scripts\core_common\system_shared;

#namespace namespace_8c89a9e9;

// Namespace namespace_8c89a9e9/namespace_8c89a9e9
// Params 0
// Checksum 0xba23d1d1, Offset: 0x78
// Size: 0x34
function init()
{
    ai::add_archetype_spawn_function( #"ghost", &function_e7d2a256 );
}

// Namespace namespace_8c89a9e9/namespace_8c89a9e9
// Params 1, eflags: 0x4
// Checksum 0x1e313a1, Offset: 0xb8
// Size: 0x24
function private function_e7d2a256( localclientnum )
{
    self thread function_20705e4c( localclientnum );
}

// Namespace namespace_8c89a9e9/namespace_8c89a9e9
// Params 1, eflags: 0x4
// Checksum 0x38415ca7, Offset: 0xe8
// Size: 0x106
function private function_20705e4c( localclientnum )
{
    self endon( #"death" );
    
    while ( true )
    {
        waitresult = self waittill( #"set_invisible", #"set_visible", #"hash_6ab654a4c018818c" );
        
        switch ( waitresult._notify )
        {
            case #"set_invisible":
                self fxclientutils::function_ae92446( localclientnum, self, self.fxdef );
                break;
            case #"set_visible":
            case #"hash_6ab654a4c018818c":
                self fxclientutils::playfxbundle( localclientnum, self, self.fxdef );
                break;
        }
    }
}

