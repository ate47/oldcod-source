#using scripts\core_common\ai\archetype_brutus_interface;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\spawner_shared;

#namespace archetypebrutus;

// Namespace archetypebrutus/archetype_brutus
// Params 0, eflags: 0x2
// Checksum 0x7e4a6c41, Offset: 0x80
// Size: 0x54
function autoexec init()
{
    brutusinterface::registerbrutusinterfaceattributes();
    registerbehaviorscriptfunctions();
    spawner::add_archetype_spawn_function( #"brutus", &function_517fd069 );
}

/#

    // Namespace archetypebrutus/archetype_brutus
    // Params 0, eflags: 0x4
    // Checksum 0x44084e56, Offset: 0xe0
    // Size: 0x24, Type: dev
    function private function_651f04c3()
    {
        assert( isdefined( self.ai ) );
    }

#/

// Namespace archetypebrutus/archetype_brutus
// Params 0, eflags: 0x4
// Checksum 0x175c6ba0, Offset: 0x110
// Size: 0x62
function private function_517fd069()
{
    blackboard::createblackboardforentity( self );
    ai::createinterfaceforentity( self );
    self.___archetypeonanimscriptedcallback = &function_666b2409;
    self.___archetypeonbehavecallback = &function_3cdbfffd;
}

// Namespace archetypebrutus/archetype_brutus
// Params 1, eflags: 0x4
// Checksum 0x5c8725eb, Offset: 0x180
// Size: 0xc
function private function_3cdbfffd( *entity )
{
    
}

// Namespace archetypebrutus/archetype_brutus
// Params 1, eflags: 0x4
// Checksum 0x31371638, Offset: 0x198
// Size: 0x2c
function private function_666b2409( *entity )
{
    self.__blackboard = undefined;
    self function_517fd069();
}

// Namespace archetypebrutus/archetype_brutus
// Params 0, eflags: 0x4
// Checksum 0x80f724d1, Offset: 0x1d0
// Size: 0x4
function private registerbehaviorscriptfunctions()
{
    
}

/#

    // Namespace archetypebrutus/archetype_brutus
    // Params 1, eflags: 0x4
    // Checksum 0x73b51293, Offset: 0x1e0
    // Size: 0x54, Type: dev
    function private function_f9f08bb1( message )
    {
        if ( getdvarint( #"scr_brutusdebug", 0 ) )
        {
            println( "<dev string:x38>" + message );
        }
    }

#/

// Namespace archetypebrutus/archetype_brutus
// Params 4
// Checksum 0x539f4d03, Offset: 0x240
// Size: 0x44
function function_f8aa76ea( entity, *attribute, *oldvalue, value )
{
    if ( value )
    {
        oldvalue function_d4c687c9();
    }
}

