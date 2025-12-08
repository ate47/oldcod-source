#using script_35ae72be7b4fec10;
#using scripts\core_common\util_shared;
#using scripts\cp_common\gametypes\globallogic_ui;

#namespace entname;

// Namespace entname/ent_name
// Params 2
// Checksum 0xe9f22492, Offset: 0x90
// Size: 0x134
function add( name, team = 1 )
{
    if ( !isdefined( level.var_479cdca1 ) )
    {
        level.var_479cdca1 = [];
    }
    
    var_b40f1dcd = level.var_479cdca1.size == 0;
    
    if ( ishash( team ) )
    {
        if ( team == #"axis" || team == #"enemy" )
        {
            team = 2;
        }
        else
        {
            team = 1;
        }
    }
    
    level.var_479cdca1[ self getentitynumber() ] = { #name:name, #team:team };
    
    if ( var_b40f1dcd )
    {
        thread _think();
    }
    
    self thread function_ef33f38e();
}

// Namespace entname/ent_name
// Params 0
// Checksum 0xf0ba1f2e, Offset: 0x1d0
// Size: 0x72
function remove()
{
    if ( isdefined( level.var_479cdca1[ self getentitynumber() ] ) )
    {
        level.var_479cdca1[ self getentitynumber() ] = undefined;
        self notify( #"hash_3e2d8e6c2f824c2e" );
        
        if ( level.var_479cdca1.size == 0 )
        {
            level.var_479cdca1 = undefined;
        }
    }
}

// Namespace entname/ent_name
// Params 0
// Checksum 0x8582bbf, Offset: 0x250
// Size: 0x20
function remove_all()
{
    level.var_479cdca1 = undefined;
    level notify( #"hash_5c4bc066a7176a66" );
}

// Namespace entname/ent_name
// Params 0, eflags: 0x4
// Checksum 0xbe0b65c2, Offset: 0x278
// Size: 0x54
function private function_ef33f38e()
{
    level endon( #"hash_5c4bc066a7176a66" );
    self endon( #"hash_3e2d8e6c2f824c2e" );
    self waittill( #"death" );
    self thread remove();
}

// Namespace entname/ent_name
// Params 0, eflags: 0x4
// Checksum 0xa52c8492, Offset: 0x2d8
// Size: 0x2ec
function private _think()
{
    level endon( #"level_restarting" );
    
    for ( player = getplayers()[ 0 ]; !isdefined( player ) ; player = getplayers()[ 0 ] )
    {
        waitframe( 1 );
    }
    
    player endon( #"death" );
    level.var_435c3a22 = [];
    util::init_dvar( "cg_maxActorNameDist", 500, &function_e65ba67 );
    scripted_widgets::create( #"entname", #"hash_1624d8814bab0c71" );
    name = #"";
    team = 0;
    scripted_widgets::set_text( #"entname", name );
    scripted_widgets::set_state( #"entname", team );
    
    while ( isdefined( level.var_479cdca1 ) )
    {
        new_name = #"";
        new_team = 0;
        
        if ( isdefined( player.lookatent ) && distancesquared( player.origin, player.lookatent.origin ) <= level.var_435c3a22[ #"cg_maxActorNameDist" ] )
        {
            ent_num = player.lookatent getentitynumber();
            ent_name = level.var_479cdca1[ ent_num ];
            
            if ( isdefined( ent_name ) )
            {
                new_name = ent_name.name;
                new_team = ent_name.team;
            }
        }
        
        if ( name != new_name )
        {
            name = new_name;
            team = new_team;
            scripted_widgets::set_text( #"entname", name );
            scripted_widgets::set_state( #"entname", team );
        }
        
        waitframe( 1 );
    }
    
    scripted_widgets::remove( #"entname" );
    level.var_435c3a22 = undefined;
    function_7a4ff65b( "cg_maxActorNameDist", &function_e65ba67 );
}

// Namespace entname/ent_name
// Params 1, eflags: 0x4
// Checksum 0xa41f9f53, Offset: 0x5d0
// Size: 0x5c
function private function_e65ba67( dvar )
{
    if ( dvar.name == "cg_maxActorNameDist" )
    {
        dvar.value *= dvar.value;
    }
    
    level.var_435c3a22[ dvar.name ] = dvar.value;
}

