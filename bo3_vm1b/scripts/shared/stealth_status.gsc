#using scripts/shared/stealth;
#using scripts/shared/stealth_aware;
#using scripts/shared/stealth_debug;
#using scripts/shared/stealth_player;
#using scripts/shared/stealth_tagging;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;

#namespace stealth_status;

// Namespace stealth_status
// Params 0
// Checksum 0x9d1d498d, Offset: 0x1e8
// Size: 0xba
function init()
{
    assert( isdefined( self.stealth ) );
    assert( !isdefined( self.stealth.status ) );
    
    if ( !isdefined( self.stealth.status ) )
    {
        self.stealth.status = spawnstruct();
    }
    
    self.stealth.status.icons = [];
    self.stealth.status.icon_ent = undefined;
    self thread clean_icon_on_death();
    self thread status_monitor_thread();
}

// Namespace stealth_status
// Params 0
// Checksum 0x875c60e1, Offset: 0x2b0
// Size: 0x1e, Type: bool
function enabled()
{
    return isdefined( self.stealth ) && isdefined( self.stealth.status );
}

// Namespace stealth_status
// Params 4
// Checksum 0x58088bc9, Offset: 0x2d8
// Size: 0x100
function create_stealth_indicator( str_shader, v_origin, z_offset, forplayer )
{
    hud_waypoint = undefined;
    
    if ( !isdefined( forplayer ) )
    {
        hud_waypoint = newhudelem();
    }
    else
    {
        hud_waypoint = newclienthudelem( forplayer );
    }
    
    hud_waypoint.horzalign = "right";
    hud_waypoint.vertalign = "middle";
    hud_waypoint.sort = 2;
    hud_waypoint setshader( str_shader, 5, 5 );
    hud_waypoint setwaypoint( 1, str_shader, 0, 0 );
    hud_waypoint.hidewheninmenu = 1;
    hud_waypoint.immunetodemogamehudsettings = 1;
    hud_waypoint.x = v_origin[ 0 ];
    hud_waypoint.y = v_origin[ 1 ];
    hud_waypoint.z = v_origin[ 2 ] + z_offset;
    return hud_waypoint;
}

// Namespace stealth_status
// Params 2
// Checksum 0xd0338a5f, Offset: 0x3e0
// Size: 0x167
function icon_show( forplayer, var_f69107b4 )
{
    if ( !isdefined( var_f69107b4 ) )
    {
        var_f69107b4 = 0;
    }
    
    index = -1;
    
    if ( isdefined( forplayer ) )
    {
        index = forplayer getentitynumber() + var_f69107b4;
    }
    
    if ( !isdefined( self.stealth.status.icon_ent ) )
    {
        ent = util::spawn_model( "tag_origin", self.origin + ( 0, 0, 92 ), ( 0, 0, 0 ) );
        ent linkto( self );
        self.stealth.status.icon_ent = ent;
    }
    
    if ( !isdefined( self.stealth.status.icons[ index ] ) )
    {
        icon = create_stealth_indicator( "white_stealth_arrow_01", self.stealth.status.icon_ent.origin, 16, forplayer );
        icon settargetent( self.stealth.status.icon_ent );
        self.stealth.status.icons[ index ] = icon;
    }
}

// Namespace stealth_status
// Params 2
// Checksum 0xaafcd2db, Offset: 0x550
// Size: 0x1d1
function function_180adb28( index, var_f69107b4 )
{
    if ( !isdefined( self ) || !isdefined( self.stealth ) || !isdefined( self.stealth.status ) || !isdefined( self.stealth.status.icons ) )
    {
        return;
    }
    
    if ( !isdefined( var_f69107b4 ) )
    {
        var_f69107b4 = 0;
    }
    
    if ( isdefined( index ) )
    {
        if ( isdefined( self.stealth.status.icons[ index ] ) )
        {
            self.stealth.status.icons[ index ] destroy();
            self.stealth.status.icons[ index ] = undefined;
        }
    }
    else
    {
        foreach ( icon in self.stealth.status.icons )
        {
            if ( isdefined( icon ) )
            {
                icon destroy();
            }
        }
        
        self.stealth.status.icons = [];
    }
    
    if ( isdefined( self.stealth.status.icon_ent ) && self.stealth.status.icons.size == 0 )
    {
        self.stealth.status.icon_ent delete();
        self.stealth.status.icon_ent = undefined;
    }
}

// Namespace stealth_status
// Params 0
// Checksum 0x7e015acf, Offset: 0x730
// Size: 0x71
function status_monitor_thread()
{
    self endon( #"stop_stealth" );
    self endon( #"death" );
    
    while ( true )
    {
        util::waittill_any( "stealth_sight_start", "alert" );
        
        while ( isalive( self ) )
        {
            if ( !self update() )
            {
                break;
            }
            
            wait 0.05;
        }
    }
}

// Namespace stealth_status
// Params 1
// Checksum 0xbe491f19, Offset: 0x7b0
// Size: 0x53
function shader_for_alert_level( alertlevel )
{
    if ( alertlevel < 0 )
    {
        alertlevel = 0;
    }
    
    if ( alertlevel > 1 )
    {
        alertlevel = 1;
    }
    
    return "white_stealth_arrow_0" + 1 + int( 7 * alertlevel );
}

// Namespace stealth_status
// Params 0
// Checksum 0x34d113e3, Offset: 0x810
// Size: 0x485
function update()
{
    banyvisible = 0;
    playerlist = getplayers();
    
    foreach ( player in playerlist )
    {
        index = player getentitynumber();
        alertthisenemy = self getstealthsightvalue( player );
        awareness = self stealth_aware::get_awareness();
        balerted = awareness == "combat" || awareness == "high_alert";
        balertedthisenemy = balerted && isdefined( self.stealth.aware_alerted[ index ] );
        bcombatthisenemy = isdefined( self.stealth.aware_combat[ index ] );
        baware = alertthisenemy > 0;
        bcansee = self stealth::can_see( player ) && !self.ignoreall;
        
        if ( !( isdefined( self.silenced ) && self.silenced ) && player stealth_player::enabled() )
        {
            if ( balertedthisenemy )
            {
                player stealth_player::inc_detected( self, alertthisenemy );
            }
            
            if ( isdefined( self.stealth.aware_sighted[ index ] ) || baware )
            {
                player thread stealth_player::update_audio( self, bcansee, awareness );
                
                if ( balertedthisenemy || bcombatthisenemy )
                {
                    player stealth_player::inc_aware( self, 1 );
                }
                else
                {
                    player stealth_player::inc_aware( self, alertthisenemy );
                }
                
                banyvisible = banyvisible || balertedthisenemy || bcombatthisenemy || baware;
            }
        }
        
        var_c1cdaaeb = 0;
        
        /#
            var_c1cdaaeb = stealth_debug::enabled();
        #/
        
        if ( baware || ( getdvarint( "stealth_display", 1 ) == 2 || var_c1cdaaeb ) && balerted )
        {
            self icon_show( player );
            banyvisible = 1;
            str_shader = "white_stealth_arrow_01";
            color = stealth::awareness_color( "unaware" );
            
            if ( !balertedthisenemy && balerted )
            {
                color = stealth::awareness_color( awareness );
            }
            else if ( self stealth_aware::get_awareness() == "unaware" )
            {
                str_shader = shader_for_alert_level( alertthisenemy );
                color = stealth::awareness_color( awareness );
            }
            else
            {
                str_shader = shader_for_alert_level( alertthisenemy );
                color = stealth::awareness_color( awareness );
            }
            
            if ( isdefined( self.stealth.status.icon_ent ) && isdefined( self.stealth.status.icons[ index ] ) )
            {
                self.stealth.status.icons[ index ] settargetent( self.stealth.status.icon_ent );
                self.stealth.status.icons[ index ] setshader( str_shader, 5, 5 );
                self.stealth.status.icons[ index ] setwaypoint( 0, str_shader, 0, 0 );
                self.stealth.status.icons[ index ].color = color;
            }
            
            continue;
        }
        
        if ( isdefined( self.stealth.status.icons[ index ] ) )
        {
            self function_180adb28( index );
        }
    }
    
    return banyvisible;
}

// Namespace stealth_status
// Params 0
// Checksum 0x867671ac, Offset: 0xca0
// Size: 0x3a
function clean_icon_on_death()
{
    self notify( #"stealth_status_clean_icons_on_death" );
    self endon( #"stealth_status_clean_icons_on_death" );
    self util::waittill_any( "death" );
    self function_180adb28();
}

