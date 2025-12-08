#using script_18910f59cc847b42;
#using script_30c7fb449869910;
#using script_3314b730521b9666;
#using script_38635d174016f682;
#using script_42cbbdcd1e160063;
#using script_64e5d3ad71ce8140;
#using script_67049b48b589d81;
#using script_6b71c9befed901f2;
#using script_71603a58e2da0698;
#using script_75c3996cce8959f7;
#using script_76abb7986de59601;
#using script_77163d5a569e2071;
#using script_771f5bff431d8d57;
#using script_7bf1bd99605135bf;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_7f5aeb59;

// Namespace namespace_7f5aeb59/namespace_7f5aeb59
// Params 1
// Checksum 0xb14870b5, Offset: 0x168
// Size: 0x412
function function_f3143608( localclientnum )
{
    self.doa = spawnstruct();
    self.topdowncamera = 1;
    self.doa.cameramode = 1;
    self.doa.hintmask = 0;
    self.entnum = self getentitynumber();
    self cameraforcedisablescriptcam( 0 );
    self camerasetupdatecallback( &namespace_ac2a80f5::function_14f1aa2b );
    self.var_88a2ff29 = level.default_mapping;
    self function_4d692cc4( localclientnum, self.var_88a2ff29 );
    self util::waittill_dobj( localclientnum );
    name = self getplayername();
    
    switch ( self.entnum )
    {
        case 0:
            setuimodelvalue( getuimodel( getuimodel( function_5f72e972( #"doa_world" ), "player1" ), "playerName" ), name );
            break;
        case 1:
            setuimodelvalue( getuimodel( getuimodel( function_5f72e972( #"doa_world" ), "player2" ), "playerName" ), name );
            break;
        case 2:
            setuimodelvalue( getuimodel( getuimodel( function_5f72e972( #"doa_world" ), "player3" ), "playerName" ), name );
            break;
        case 3:
            setuimodelvalue( getuimodel( getuimodel( function_5f72e972( #"doa_world" ), "player4" ), "playerName" ), name );
            break;
    }
    
    if ( islocalplayer( self ) )
    {
        localclientnum = self getlocalclientnumber();
        
        switch ( self.entnum )
        {
            case 0:
                self setcontrollerlightbarcolor( localclientnum, ( 0, 1, 0 ) );
                break;
            case 1:
                self setcontrollerlightbarcolor( localclientnum, ( 0, 0, 1 ) );
                break;
            case 2:
                self setcontrollerlightbarcolor( localclientnum, ( 1, 0, 0 ) );
                break;
            case 3:
                self setcontrollerlightbarcolor( localclientnum, ( 1, 1, 0 ) );
                break;
        }
    }
}

// Namespace namespace_7f5aeb59/namespace_7f5aeb59
// Params 1
// Checksum 0xa26d6a41, Offset: 0x588
// Size: 0x52
function function_fcc90081( *var_45b95f80 )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self.skits = undefined;
    self.doa.cameramode = 1;
    self.doa.var_903d75b1 = undefined;
    self.var_88a2ff29 = level.default_mapping;
}

// Namespace namespace_7f5aeb59/namespace_7f5aeb59
// Params 2
// Checksum 0x27a04d0f, Offset: 0x5e8
// Size: 0x124
function function_4d692cc4( localclientnum, mapping = "zombietron" )
{
    /#
        namespace_1e25ad94::debugmsg( "<dev string:x38>" + ( isdefined( self.name ) ? self.name : "<dev string:x5c>" ) + "<dev string:x6a>" + mapping + "<dev string:x7a>" + ( islocalplayer( self ) ? "<dev string:x8e>" : "<dev string:x96>" ) );
    #/
    
    if ( islocalplayer( self ) )
    {
        /#
            namespace_1e25ad94::debugmsg( "<dev string:x9f>" + localclientnum );
        #/
        
        forcegamemodemappings( localclientnum, mapping );
        return;
    }
    
    /#
        namespace_1e25ad94::debugmsg( "<dev string:xcd>" );
    #/
}

// Namespace namespace_7f5aeb59/namespace_7f5aeb59
// Params 1
// Checksum 0x8a89c07b, Offset: 0x718
// Size: 0x4a
function islocalplayer( player )
{
    assert( isdefined( player ), "<dev string:x106>" );
    return isinarray( level.localplayers, player );
}

