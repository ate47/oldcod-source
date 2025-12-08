#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\util;

#namespace friendlyfire;

// Namespace friendlyfire/friendlyfire
// Params 0, eflags: 0x6
// Checksum 0x4dc81921, Offset: 0x188
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"friendlyfire", &preinit, undefined, undefined, undefined );
}

// Namespace friendlyfire/friendlyfire
// Params 0, eflags: 0x4
// Checksum 0xce50bca0, Offset: 0x1d0
// Size: 0x184
function private preinit()
{
    level.var_911cdf6e[ #"min_participation" ] = -1600;
    level.var_911cdf6e[ #"max_participation" ] = 1000;
    level.var_911cdf6e[ #"enemy_kill_points" ] = 250;
    level.var_911cdf6e[ #"friend_kill_points" ] = -600;
    level.var_911cdf6e[ #"hash_308b6e99638b7c04" ] = -900;
    level.var_911cdf6e[ #"point_loss_interval" ] = 0.75;
    level.var_edbfa7b = 0.5;
    
    if ( util::coopgame() )
    {
        setdvar( #"bg_friendlyfiremode", 1 );
        
        /#
            function_bba23c40( #"bg_friendlyfiredist", 500 );
        #/
    }
    
    if ( sessionmodeiscampaigngame() && level.gametype !== "coop" )
    {
        level.friendlyfiredisabled = 0;
    }
    
    if ( !isdefined( level.friendlyfiredisabled ) )
    {
        level.friendlyfiredisabled = 0;
    }
    
    callback::on_connect( &init_player );
}

// Namespace friendlyfire/friendlyfire
// Params 0
// Checksum 0x158b203f, Offset: 0x360
// Size: 0x5c
function init_player()
{
    assert( isdefined( self ), "<dev string:x38>" );
    self.participation = 0;
    
    /#
        self thread debug_friendlyfire();
    #/
    
    self thread participation_point_flattenovertime();
}

// Namespace friendlyfire/friendlyfire
// Params 1
// Checksum 0x632786f7, Offset: 0x3c8
// Size: 0xa4
function function_b943ac72( msg )
{
    /#
        if ( getdvarstring( #"debug_friendlyfire" ) == "<dev string:x4f>" )
        {
            iprintlnbold( msg );
        }
        
        if ( getdvarstring( #"hash_2d7cfd6663c775a7" ) == "<dev string:x4f>" )
        {
            println( "<dev string:x55>" + msg );
        }
    #/
}

/#

    // Namespace friendlyfire/friendlyfire
    // Params 0, eflags: 0x4
    // Checksum 0x51ffa25c, Offset: 0x478
    // Size: 0xebc, Type: dev
    function private function_25d6cf14()
    {
        if ( !isdefined( self.var_d5b6872a ) )
        {
            self.var_d5b6872a = spawnstruct();
            self.var_d5b6872a.var_987926ba = level.var_911cdf6e[ #"max_participation" ] - level.var_911cdf6e[ #"min_participation" ];
            self.var_d5b6872a.var_db612029 = 520;
            self.var_d5b6872a.var_40b5d571 = 620;
            self.var_d5b6872a.ypos = 130;
            self.var_d5b6872a.bar_width = self.var_d5b6872a.var_40b5d571 - self.var_d5b6872a.var_db612029;
        }
        
        if ( !isdefined( self.var_d5b6872a.friendly_fire ) )
        {
            self.var_d5b6872a.friendly_fire = newdebughudelem();
            self.var_d5b6872a.friendly_fire.fontscale = 3;
            self.var_d5b6872a.friendly_fire.alignx = "<dev string:x68>";
            self.var_d5b6872a.friendly_fire.aligny = "<dev string:x71>";
            self.var_d5b6872a.friendly_fire.x = self.var_d5b6872a.var_40b5d571 - self.var_d5b6872a.bar_width * level.var_911cdf6e[ #"max_participation" ] / self.var_d5b6872a.var_987926ba - log( self.participation ) * self.var_d5b6872a.friendly_fire.fontscale;
            self.var_d5b6872a.friendly_fire.y = 100;
            self.var_d5b6872a.friendly_fire.alpha = 1;
        }
        
        if ( !isdefined( self.var_d5b6872a.var_9a2c2205 ) )
        {
            self.var_d5b6872a.var_9a2c2205 = newdebughudelem();
            self.var_d5b6872a.var_9a2c2205.fontscale = 1.5;
            self.var_d5b6872a.var_9a2c2205.alignx = "<dev string:x68>";
            self.var_d5b6872a.var_9a2c2205.aligny = "<dev string:x71>";
            self.var_d5b6872a.var_9a2c2205.x = self.var_d5b6872a.var_db612029 - ( ceil( max( log( abs( level.var_911cdf6e[ #"min_participation" ] ) ) / log( 10 ), 0 ) ) - 2 + ( self.participation < 0 ) ) * self.var_d5b6872a.friendly_fire.fontscale;
            self.var_d5b6872a.var_9a2c2205.y = self.var_d5b6872a.ypos;
            self.var_d5b6872a.var_9a2c2205.alpha = 1;
            self.var_d5b6872a.var_9a2c2205 setvalue( level.var_911cdf6e[ #"min_participation" ] );
        }
        
        if ( !isdefined( self.var_d5b6872a.var_67b2f7ad ) )
        {
            self.var_d5b6872a.var_67b2f7ad = newdebughudelem();
            self.var_d5b6872a.var_67b2f7ad.fontscale = 1.5;
            self.var_d5b6872a.var_67b2f7ad.alignx = "<dev string:x68>";
            self.var_d5b6872a.var_67b2f7ad.aligny = "<dev string:x71>";
            self.var_d5b6872a.var_67b2f7ad.x = self.var_d5b6872a.var_40b5d571 + 2 * ( ceil( max( log( abs( level.var_911cdf6e[ #"max_participation" ] ) ) / log( 10 ), 0 ) ) + 2.5 + ( self.participation < 0 ) ) * self.var_d5b6872a.friendly_fire.fontscale;
            self.var_d5b6872a.var_67b2f7ad.y = self.var_d5b6872a.ypos;
            self.var_d5b6872a.var_67b2f7ad.alpha = 1;
            self.var_d5b6872a.var_67b2f7ad setvalue( level.var_911cdf6e[ #"max_participation" ] );
        }
        
        if ( !isdefined( self.var_d5b6872a.var_ce0ada2c ) )
        {
            self.var_d5b6872a.var_ce0ada2c = newdebughudelem( self );
            self.var_d5b6872a.var_ce0ada2c.alignx = "<dev string:x68>";
            self.var_d5b6872a.var_ce0ada2c.aligny = "<dev string:x71>";
            self.var_d5b6872a.var_ce0ada2c.x = self.var_d5b6872a.var_40b5d571;
            self.var_d5b6872a.var_ce0ada2c.y = self.var_d5b6872a.ypos;
            self.var_d5b6872a.var_ce0ada2c.sort = 1;
            self.var_d5b6872a.var_ce0ada2c.alpha = 1;
            self.var_d5b6872a.var_ce0ada2c.foreground = 1;
            self.var_d5b6872a.var_ce0ada2c.color = ( 0.4, 0.4, 0.4 );
            self.var_d5b6872a.var_ce0ada2c setshader( #"white", self.var_d5b6872a.bar_width, 9 );
        }
        
        if ( !isdefined( self.var_d5b6872a.debug_health_bar ) )
        {
            self.var_d5b6872a.debug_health_bar = newdebughudelem( self );
            self.var_d5b6872a.debug_health_bar.alignx = "<dev string:x68>";
            self.var_d5b6872a.debug_health_bar.aligny = "<dev string:x71>";
            self.var_d5b6872a.debug_health_bar.x = 620;
            self.var_d5b6872a.debug_health_bar.y = self.var_d5b6872a.ypos;
            self.var_d5b6872a.debug_health_bar.sort = 4;
            self.var_d5b6872a.debug_health_bar.alpha = 1;
            self.var_d5b6872a.debug_health_bar.foreground = 1;
            self.var_d5b6872a.debug_health_bar.color = ( 0, 0, 0.9 );
            self.var_d5b6872a.debug_health_bar setshader( #"white", 4, 15 );
        }
        
        if ( !isdefined( self.var_d5b6872a.var_704a4d3b ) )
        {
            self.var_d5b6872a.var_704a4d3b = newdebughudelem( self );
            self.var_d5b6872a.var_704a4d3b.alignx = "<dev string:x68>";
            self.var_d5b6872a.var_704a4d3b.aligny = "<dev string:x71>";
            self.var_d5b6872a.var_704a4d3b.x = self.var_d5b6872a.var_db612029;
            self.var_d5b6872a.var_704a4d3b.y = self.var_d5b6872a.ypos;
            self.var_d5b6872a.var_704a4d3b.sort = 2;
            self.var_d5b6872a.var_704a4d3b.alpha = 1;
            self.var_d5b6872a.var_704a4d3b.foreground = 1;
            self.var_d5b6872a.var_704a4d3b setshader( #"black", 4, 21 );
        }
        
        if ( !isdefined( self.var_d5b6872a.var_203309fa ) )
        {
            self.var_d5b6872a.var_203309fa = newdebughudelem( self );
            self.var_d5b6872a.var_203309fa.alignx = "<dev string:x68>";
            self.var_d5b6872a.var_203309fa.aligny = "<dev string:x71>";
            self.var_d5b6872a.var_203309fa.x = self.var_d5b6872a.var_40b5d571;
            self.var_d5b6872a.var_203309fa.y = self.var_d5b6872a.ypos;
            self.var_d5b6872a.var_203309fa.sort = 2;
            self.var_d5b6872a.var_203309fa.alpha = 1;
            self.var_d5b6872a.var_203309fa.foreground = 1;
            self.var_d5b6872a.var_203309fa setshader( #"black", 4, 21 );
        }
        
        if ( !isdefined( self.var_d5b6872a.var_c16c1379 ) )
        {
            self.var_d5b6872a.var_c16c1379 = newdebughudelem( self );
            self.var_d5b6872a.var_c16c1379.alignx = "<dev string:x68>";
            self.var_d5b6872a.var_c16c1379.aligny = "<dev string:x71>";
            self.var_d5b6872a.var_c16c1379.x = self.var_d5b6872a.var_db612029 + level.var_911cdf6e[ #"min_participation" ] * -1 / self.var_d5b6872a.var_987926ba * self.var_d5b6872a.bar_width;
            self.var_d5b6872a.var_c16c1379.y = self.var_d5b6872a.ypos + 9;
            self.var_d5b6872a.var_c16c1379.sort = 2;
            self.var_d5b6872a.var_c16c1379.alpha = 1;
            self.var_d5b6872a.var_c16c1379.foreground = 1;
            self.var_d5b6872a.var_c16c1379 setshader( #"black", 4, 4 );
        }
        
        if ( !isdefined( self.var_d5b6872a.var_24736d8c ) )
        {
            self.var_d5b6872a.var_24736d8c = newdebughudelem( self );
            self.var_d5b6872a.var_24736d8c.alignx = "<dev string:x68>";
            self.var_d5b6872a.var_24736d8c.aligny = "<dev string:x71>";
            self.var_d5b6872a.var_24736d8c.x = self.var_d5b6872a.var_db612029 + level.var_911cdf6e[ #"min_participation" ] * -1 / self.var_d5b6872a.var_987926ba * self.var_d5b6872a.bar_width;
            self.var_d5b6872a.var_24736d8c.y = self.var_d5b6872a.ypos - 9;
            self.var_d5b6872a.var_24736d8c.sort = 2;
            self.var_d5b6872a.var_24736d8c.alpha = 1;
            self.var_d5b6872a.var_24736d8c.foreground = 1;
            self.var_d5b6872a.var_24736d8c setshader( #"black", 4, 4 );
        }
    }

    // Namespace friendlyfire/friendlyfire
    // Params 0
    // Checksum 0xb4cc0995, Offset: 0x1340
    // Size: 0x498, Type: dev
    function debug_friendlyfire()
    {
        self endon( #"disconnect", #"hash_1ff2bf35392915" );
        
        if ( getdvarstring( #"debug_friendlyfire" ) == "<dev string:x7b>" )
        {
            setdvar( #"debug_friendlyfire", "<dev string:x7f>" );
        }
        
        if ( getdvarstring( #"hash_2d7cfd6663c775a7" ) == "<dev string:x7b>" )
        {
            setdvar( #"hash_2d7cfd6663c775a7", "<dev string:x7f>" );
        }
        
        for ( ;; )
        {
            function_25d6cf14();
            
            if ( getdvarstring( #"debug_friendlyfire" ) == "<dev string:x4f>" )
            {
                self.var_d5b6872a.friendly_fire.alpha = 1;
                self.var_d5b6872a.var_9a2c2205.alpha = 1;
                self.var_d5b6872a.var_67b2f7ad.alpha = 1;
                self.var_d5b6872a.var_ce0ada2c.alpha = 1;
                self.var_d5b6872a.debug_health_bar.alpha = 1;
                self.var_d5b6872a.var_704a4d3b.alpha = 1;
                self.var_d5b6872a.var_203309fa.alpha = 1;
                self.var_d5b6872a.var_c16c1379.alpha = 1;
                self.var_d5b6872a.var_24736d8c.alpha = 1;
            }
            else
            {
                self.var_d5b6872a.friendly_fire.alpha = 0;
                self.var_d5b6872a.var_9a2c2205.alpha = 0;
                self.var_d5b6872a.var_67b2f7ad.alpha = 0;
                self.var_d5b6872a.var_ce0ada2c.alpha = 0;
                self.var_d5b6872a.debug_health_bar.alpha = 0;
                self.var_d5b6872a.var_704a4d3b.alpha = 0;
                self.var_d5b6872a.var_203309fa.alpha = 0;
                self.var_d5b6872a.var_c16c1379.alpha = 0;
                self.var_d5b6872a.var_24736d8c.alpha = 0;
            }
            
            xpos = ( level.var_911cdf6e[ #"max_participation" ] - self.participation ) / self.var_d5b6872a.var_987926ba * self.var_d5b6872a.bar_width;
            self.var_d5b6872a.debug_health_bar.x = self.var_d5b6872a.var_40b5d571 - xpos;
            self.var_d5b6872a.friendly_fire setvalue( self.participation );
            self.var_d5b6872a.friendly_fire.x = self.var_d5b6872a.var_40b5d571 - self.var_d5b6872a.bar_width * level.var_911cdf6e[ #"max_participation" ] / self.var_d5b6872a.var_987926ba + ( ceil( max( log( abs( self.participation ) ) / log( 10 ), 0 ) ) + 1 + ( self.participation < 0 ) ) * self.var_d5b6872a.friendly_fire.fontscale * 2;
            wait 0.25;
        }
    }

#/

// Namespace friendlyfire/friendlyfire
// Params 1
// Checksum 0x5cc99057, Offset: 0x17e0
// Size: 0x36, Type: bool
function function_9d79ae6f( entity )
{
    if ( entity.archetype === "warlord_soldier" )
    {
        return ( entity.shieldhealth <= 0 );
    }
    
    return false;
}

// Namespace friendlyfire/friendlyfire
// Params 4
// Checksum 0x868bc539, Offset: 0x1820
// Size: 0x5ec
function function_1ad87afd( entity, damage, attacker, method )
{
    if ( !isdefined( entity ) )
    {
        return;
    }
    
    if ( !isdefined( entity.team ) )
    {
        entity.team = #"allies";
    }
    
    if ( !isdefined( entity ) )
    {
        return;
    }
    
    var_bee3a418 = function_9d79ae6f( entity );
    
    if ( entity.health <= 0 )
    {
        if ( !var_bee3a418 )
        {
            return;
        }
    }
    
    if ( level.friendlyfiredisabled )
    {
        return;
    }
    
    if ( is_true( entity.nofriendlyfire ) )
    {
        return;
    }
    
    if ( !isdefined( attacker ) )
    {
        return;
    }
    
    var_f6cca883 = 0;
    
    if ( isplayer( attacker ) )
    {
        var_f6cca883 = 1;
    }
    else if ( isdefined( attacker.classname ) && attacker.classname == "script_vehicle" )
    {
        owner = attacker getvehicleowner();
        
        if ( isdefined( owner ) )
        {
            if ( isplayer( owner ) )
            {
                if ( !isdefined( owner.var_a4dee4fd ) )
                {
                    var_f6cca883 = 1;
                    attacker = owner;
                }
            }
        }
    }
    
    if ( !var_f6cca883 )
    {
        return;
    }
    
    same_team = entity.team == attacker.team;
    
    if ( attacker.team == #"allies" )
    {
        if ( entity.team == #"neutral" && !is_true( level.var_cd2635a5 ) )
        {
            same_team = 1;
        }
    }
    
    same_team |= util::function_9b7092ef( entity.team, attacker.team );
    
    if ( entity.team != #"neutral" || entity.team == #"neutral" && !is_true( level.var_cd2635a5 ) )
    {
        attacker.var_97a2e324 = entity.team;
    }
    
    killed = damage >= entity.health || var_bee3a418;
    
    if ( !entity.allowdeath )
    {
        killed = 0;
    }
    
    if ( !same_team )
    {
        if ( killed )
        {
            attacker.participation += level.var_911cdf6e[ #"enemy_kill_points" ];
            attacker participation_point_cap();
            function_b943ac72( "Enemy killed: +" + level.var_911cdf6e[ #"enemy_kill_points" ] );
        }
        
        return;
    }
    
    if ( isdefined( entity.var_2609b537 ) )
    {
        return;
    }
    
    if ( killed )
    {
        if ( entity.archetype === #"civilian" || entity.team == #"neutral" )
        {
            level notify( #"hash_3f3c07e5660a9695" );
            attacker.participation += level.var_911cdf6e[ #"hash_308b6e99638b7c04" ];
            function_b943ac72( "Civilian killed: -" + 0 - level.var_911cdf6e[ #"hash_308b6e99638b7c04" ] );
        }
        else if ( isdefined( entity ) && isdefined( entity.var_f9a443f6 ) )
        {
            attacker.participation += entity.var_f9a443f6;
            function_b943ac72( "Friendly killed with custom penalty: -" + 0 - entity.var_f9a443f6 );
        }
        else
        {
            attacker.participation += level.var_911cdf6e[ #"friend_kill_points" ];
            function_b943ac72( "Friendly killed: -" + 0 - level.var_911cdf6e[ #"friend_kill_points" ] );
        }
    }
    else
    {
        if ( damage == 0 && is_true( entity.var_ff25c56e ) )
        {
            attacker.participation -= 40;
        }
        
        attacker.participation -= damage;
        function_b943ac72( "Friendly hurt: -" + damage );
    }
    
    attacker participation_point_cap();
    
    if ( check_grenade( entity, method ) && savecommit_aftergrenade() )
    {
        return;
    }
    
    attacker friendly_fire_checkpoints();
}

// Namespace friendlyfire/friendlyfire
// Params 1
// Checksum 0xa3adaaa3, Offset: 0x1e18
// Size: 0x658
function friendly_fire_think( entity )
{
    level endon( #"mission failed" );
    entity endon( #"no_friendly_fire" );
    
    if ( !isdefined( entity ) )
    {
        return;
    }
    
    if ( !isdefined( entity.team ) )
    {
        entity.team = #"allies";
    }
    
    for ( ;; )
    {
        if ( !isdefined( entity ) )
        {
            return;
        }
        
        waitresult = entity waittill( #"damage" );
        attacker = waitresult.attacker;
        damage = waitresult.amount;
        method = waitresult.mod;
        
        if ( level.friendlyfiredisabled )
        {
            continue;
        }
        
        if ( !isdefined( entity ) )
        {
            return;
        }
        
        if ( is_true( entity.nofriendlyfire ) )
        {
            continue;
        }
        
        if ( !isdefined( attacker ) )
        {
            continue;
        }
        
        var_f6cca883 = 0;
        
        if ( isplayer( attacker ) )
        {
            var_f6cca883 = 1;
        }
        else if ( isdefined( attacker.classname ) && attacker.classname == "script_vehicle" )
        {
            owner = attacker getvehicleowner();
            
            if ( isdefined( owner ) )
            {
                if ( isplayer( owner ) )
                {
                    if ( !isdefined( owner.var_a4dee4fd ) )
                    {
                        var_f6cca883 = 1;
                        attacker = owner;
                    }
                }
            }
        }
        
        if ( !var_f6cca883 )
        {
            continue;
        }
        
        same_team = entity.team == attacker.team;
        
        if ( attacker.team == #"allies" )
        {
            if ( entity.team == #"neutral" && !is_true( level.var_cd2635a5 ) )
            {
                same_team = 1;
            }
        }
        
        same_team |= util::function_9b7092ef( entity.team, attacker.team );
        
        if ( entity.team != #"neutral" || entity.team == #"neutral" && !is_true( level.var_cd2635a5 ) )
        {
            attacker.var_97a2e324 = entity.team;
        }
        
        killed = damage >= entity.health;
        
        if ( !same_team )
        {
            if ( killed )
            {
                attacker.participation += level.var_911cdf6e[ #"enemy_kill_points" ];
                attacker participation_point_cap();
                function_b943ac72( "Enemy killed: +" + level.var_911cdf6e[ #"enemy_kill_points" ] );
            }
            
            return;
        }
        
        if ( isdefined( entity.var_2609b537 ) )
        {
            continue;
        }
        
        if ( killed )
        {
            if ( entity.archetype === #"civilian" || entity.team == #"neutral" )
            {
                level notify( #"hash_3f3c07e5660a9695" );
                
                if ( attacker.participation <= 0 )
                {
                    attacker.participation += level.var_911cdf6e[ #"min_participation" ];
                    function_b943ac72( "Civilian killed with negative score, autofail!" );
                }
                else
                {
                    attacker.participation += level.var_911cdf6e[ #"hash_308b6e99638b7c04" ];
                    function_b943ac72( "Civilian killed: -" + 0 - level.var_911cdf6e[ #"hash_308b6e99638b7c04" ] );
                }
            }
            else if ( isdefined( entity ) && isdefined( entity.var_f9a443f6 ) )
            {
                attacker.participation += entity.var_f9a443f6;
                function_b943ac72( "Friendly killed with custom penalty: -" + 0 - entity.var_f9a443f6 );
            }
            else
            {
                attacker.participation += level.var_911cdf6e[ #"friend_kill_points" ];
                function_b943ac72( "Friendly killed: -" + 0 - level.var_911cdf6e[ #"friend_kill_points" ] );
            }
        }
        else
        {
            attacker.participation -= damage;
            function_b943ac72( "Friendly hurt: -" + damage );
        }
        
        attacker participation_point_cap();
        
        if ( check_grenade( entity, method ) && savecommit_aftergrenade() )
        {
            if ( killed )
            {
                return;
            }
            
            continue;
        }
        
        attacker friendly_fire_checkpoints();
    }
}

// Namespace friendlyfire/friendlyfire
// Params 0
// Checksum 0xc7de3f03, Offset: 0x2478
// Size: 0x3c
function friendly_fire_checkpoints()
{
    if ( self.participation <= level.var_911cdf6e[ #"min_participation" ] )
    {
        self thread function_708f45ad();
    }
}

// Namespace friendlyfire/friendlyfire
// Params 2
// Checksum 0x929c4ec6, Offset: 0x24c0
// Size: 0x8e
function check_grenade( entity, method )
{
    if ( !isdefined( entity ) )
    {
        return 0;
    }
    
    wasgrenade = 0;
    
    if ( isdefined( entity.damageweapon ) && entity.damageweapon.name == "none" )
    {
        wasgrenade = 1;
    }
    
    if ( isdefined( method ) && method == "MOD_GRENADE_SPLASH" )
    {
        wasgrenade = 1;
    }
    
    return wasgrenade;
}

// Namespace friendlyfire/friendlyfire
// Params 0
// Checksum 0xd4cc0356, Offset: 0x2558
// Size: 0x44, Type: bool
function savecommit_aftergrenade()
{
    currenttime = gettime();
    
    if ( currenttime < 4500 )
    {
        println( "<dev string:x86>" );
        return true;
    }
    
    return false;
}

// Namespace friendlyfire/friendlyfire
// Params 0
// Checksum 0x9373c716, Offset: 0x25a8
// Size: 0xae
function participation_point_cap()
{
    if ( !isdefined( self.participation ) )
    {
        assertmsg( "<dev string:xf2>" );
        return;
    }
    
    if ( self.participation > level.var_911cdf6e[ #"max_participation" ] )
    {
        self.participation = level.var_911cdf6e[ #"max_participation" ];
    }
    
    if ( self.participation < level.var_911cdf6e[ #"min_participation" ] )
    {
        self.participation = level.var_911cdf6e[ #"min_participation" ];
    }
}

// Namespace friendlyfire/friendlyfire
// Params 0
// Checksum 0x985db5bb, Offset: 0x2660
// Size: 0x82
function participation_point_flattenovertime()
{
    level endon( #"hash_7d1398df3ecfd3bf" );
    self endon( #"disconnect" );
    
    for ( ;; )
    {
        if ( self.participation > 0 )
        {
            self.participation--;
        }
        else if ( self.participation < 0 )
        {
            self.participation++;
        }
        
        wait level.var_911cdf6e[ #"point_loss_interval" ];
    }
}

// Namespace friendlyfire/friendlyfire
// Params 0
// Checksum 0x8406b649, Offset: 0x26f0
// Size: 0x10
function turnbackon()
{
    level.friendlyfiredisabled = 0;
}

// Namespace friendlyfire/friendlyfire
// Params 0
// Checksum 0x5a03652c, Offset: 0x2708
// Size: 0x14
function turnoff()
{
    level.friendlyfiredisabled = 1;
}

// Namespace friendlyfire/friendlyfire
// Params 0
// Checksum 0xcc5d5de1, Offset: 0x2728
// Size: 0xcc
function missionfail()
{
    self endon( #"death" );
    level endon( #"mine death" );
    self.participation = 0;
    self.lives = 0;
    
    if ( self.var_97a2e324 === #"neutral" )
    {
        util::function_2a8f4806( #"hash_293687c2ffb1b911", #"hash_7d45646726cd7f74" );
        return;
    }
    
    util::function_2a8f4806( #"hash_23aab5a843404b78", #"hash_7d45646726cd7f74" );
}

// Namespace friendlyfire/friendlyfire
// Params 0
// Checksum 0x74ad0a72, Offset: 0x2800
// Size: 0x4a
function function_708f45ad()
{
    self endon( #"death" );
    level endon( #"mine death" );
    self.participation = 0;
    wait 0.05;
    self.participation = 0;
}

// Namespace friendlyfire/friendlyfire
// Params 1
// Checksum 0xbfe5b6f1, Offset: 0x2858
// Size: 0x6c
function notifydamage( entity )
{
    level endon( #"mission failed" );
    entity endon( #"death" );
    
    for ( ;; )
    {
        entity notify( #"friendlyfire_notify", entity waittill( #"damage" ) );
    }
}

// Namespace friendlyfire/friendlyfire
// Params 1
// Checksum 0x46347ef2, Offset: 0x28d0
// Size: 0x68
function notifydamagenotdone( entity )
{
    level endon( #"mission failed" );
    waitresult = entity waittill( #"damage_notdone" );
    waitresult.amount = -1;
    entity notify( #"friendlyfire_notify", waitresult );
}

// Namespace friendlyfire/friendlyfire
// Params 1
// Checksum 0x4482f965, Offset: 0x2940
// Size: 0x68
function notifydeath( entity )
{
    level endon( #"mission failed" );
    waitresult = entity waittill( #"death" );
    waitresult.amount = -1;
    entity notify( #"friendlyfire_notify", waitresult );
}

