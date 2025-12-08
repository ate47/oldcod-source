#using scripts/core_common/abilities/gadgets/gadget_armor_regen;
#using scripts/core_common/array_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/gameobjects_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/mp_common/gametypes/dogtags;
#using scripts/mp_common/killstreaks/armor_station;

#namespace armor;

// Namespace armor/GameType_Init
// Params 1, eflags: 0x40
// Checksum 0x60ba397e, Offset: 0x308
// Size: 0x2c
function event_handler[GameType_Init] main( eventstruct )
{
    callback::on_player_killed( &on_player_killed );
}

// Namespace armor/armor
// Params 1
// Checksum 0xbe6af4cb, Offset: 0x340
// Size: 0xf4
function setlightarmorhp( newvalue )
{
    if ( isdefined( newvalue ) )
    {
        self.lightarmorhp = newvalue;
        
        if ( isplayer( self ) && isdefined( self.var_89273a50 ) && self.var_89273a50 > 0 )
        {
            lightarmorpercent = math::clamp( self.lightarmorhp / self.var_89273a50, 0, 1 );
            self setcontrolleruimodelvalue( "hudItems.armorPercent", lightarmorpercent );
        }
        
        return;
    }
    
    self.lightarmorhp = undefined;
    self.var_89273a50 = undefined;
    self setcontrolleruimodelvalue( "hudItems.armorPercent", 0 );
}

// Namespace armor/armor
// Params 1
// Checksum 0x545c72f5, Offset: 0x440
// Size: 0xb4
function setlightarmor( optionalarmorvalue )
{
    self notify( #"give_light_armor" );
    
    if ( isdefined( self.lightarmorhp ) )
    {
        unsetlightarmor();
    }
    
    self thread removelightarmorondeath();
    self thread removelightarmoronmatchend();
    
    if ( isdefined( optionalarmorvalue ) )
    {
        self.var_89273a50 = optionalarmorvalue;
    }
    else
    {
        self.var_89273a50 = 150;
    }
    
    self setlightarmorhp( self.var_89273a50 );
}

// Namespace armor/armor
// Params 0
// Checksum 0x97c92a58, Offset: 0x500
// Size: 0x4c
function removelightarmorondeath()
{
    self endon( #"disconnect" );
    self endon( #"give_light_armor" );
    self endon( #"remove_light_armor" );
    self waittill( "death" );
    unsetlightarmor();
}

// Namespace armor/armor
// Params 0
// Checksum 0x928f2994, Offset: 0x558
// Size: 0x2a
function unsetlightarmor()
{
    self setlightarmorhp( undefined );
    self notify( #"remove_light_armor" );
}

// Namespace armor/armor
// Params 0
// Checksum 0xc4f94689, Offset: 0x590
// Size: 0x44
function removelightarmoronmatchend()
{
    self endon( #"disconnect" );
    self endon( #"remove_light_armor" );
    level waittill( "game_ended" );
    self thread unsetlightarmor();
}

// Namespace armor/armor
// Params 0
// Checksum 0xc3883d3, Offset: 0x5e0
// Size: 0x22, Type: bool
function haslightarmor()
{
    return isdefined( self.lightarmorhp ) && self.lightarmorhp > 0;
}

// Namespace armor/armor
// Params 0
// Checksum 0x2ac2c71e, Offset: 0x610
// Size: 0x4c
function function_3e7fdc00()
{
    total_armor = self.armor;
    total_armor += isdefined( self.lightarmorhp ) ? self.lightarmorhp : 0;
    return total_armor;
}

// Namespace armor/armor
// Params 0
// Checksum 0x11e238be, Offset: 0x668
// Size: 0x440
function function_8f97774c()
{
    self notify( #"hash_19f8943a" );
    self endon( #"death" );
    self endon( #"disconnect" );
    self endon( #"hash_19f8943a" );
    self endon( #"hash_13b0eff6" );
    
    if ( self.armorregentime == 0 )
    {
        return;
    }
    
    var_679884b3 = gettime();
    
    if ( self.armorregendelay > 0 )
    {
        do
        {
            waitframe( 1 );
            var_3edd7383 = 1;
            
            if ( isdefined( self armor_station::get_nearby_armor_station() ) )
            {
                var_3edd7383 = armor_station::get_regen_delay_multiplier();
            }
            
            var_35043ec4 = self gadget_armor_regen::is_regen_active();
            
            if ( var_35043ec4 )
            {
                var_3edd7383 *= gadget_armor_regen::get_regen_delay_multiplier();
            }
            
            var_c0358226 = int( var_679884b3 + self.armorregendelay * 1000 * var_3edd7383 );
        }
        while ( gettime() < var_c0358226 );
    }
    
    if ( self.armorregentime <= 0.05 )
    {
        self.armor = self.maxarmor;
        return;
    }
    
    assert( self.armorregentime != 0 );
    var_7a0c07c3 = gettime();
    var_bc35dfee = self.armorperbar / self.armorregentime;
    var_186d5ed0 = self.armor;
    
    while ( self.armor < self.maxarmor && !self at_peak_armor_bars() || armor_station::any_armor_stations_exist_for_team( self.team ) )
    {
        waitframe( 1 );
        var_e508be56 = gettime();
        
        if ( var_e508be56 <= var_7a0c07c3 )
        {
            continue;
        }
        
        timemultiplier = 1;
        
        if ( isdefined( self armor_station::get_nearby_armor_station() ) )
        {
            timemultiplier = math::clamp( armor_station::get_regen_time_multiplier(), 0.01, 1 );
        }
        
        var_35043ec4 = self gadget_armor_regen::is_regen_active();
        
        if ( var_35043ec4 )
        {
            timemultiplier *= math::clamp( gadget_armor_regen::get_regen_time_multiplier(), 0.01, 1 );
        }
        
        deltatime = ( var_e508be56 - var_7a0c07c3 ) / 1000;
        regen_amount = var_bc35dfee * 1 / timemultiplier * deltatime;
        var_186d5ed0 = math::clamp( var_186d5ed0 + regen_amount, self.armor, self.var_f7ccb749 );
        self.armor = int( var_186d5ed0 );
        
        if ( self.armor == self.maxarmor && self gadget_armor_regen::can_increase_max_armor() )
        {
            update_max_armor( 1 );
            self gadget_armor_regen::max_armor_increased();
        }
        
        var_7a0c07c3 = gettime();
    }
}

// Namespace armor/armor
// Params 0
// Checksum 0xa3a7139d, Offset: 0xab0
// Size: 0x96
function function_e05ca844()
{
    var_35043ec4 = self gadget_armor_regen::is_regen_active();
    var_97874bb0 = self.armor > 0 || self hasperk( "specialty_armor" ) && var_35043ec4;
    
    if ( var_97874bb0 )
    {
        self thread function_8f97774c();
        return;
    }
    
    self notify( #"hash_13b0eff6" );
}

// Namespace armor/armor
// Params 1
// Checksum 0x9ee6d92a, Offset: 0xb50
// Size: 0x56
function get_damage_time_threshold_ms( not_damaged_time_seconds )
{
    if ( !isdefined( not_damaged_time_seconds ) )
    {
        not_damaged_time_seconds = 0.5;
    }
    
    damage_time_threshold_ms = gettime() - int( not_damaged_time_seconds * 1000 );
    return damage_time_threshold_ms;
}

// Namespace armor/armor
// Params 2
// Checksum 0x7c658888, Offset: 0xbb0
// Size: 0x14c
function boost_armor( bars_to_give, damage_time_threshold_ms )
{
    player = self;
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( bars_to_give <= 0 )
    {
        return;
    }
    
    if ( !player has_armor_bar_capability() )
    {
        return;
    }
    
    if ( player at_peak_armor_bars() )
    {
        return;
    }
    
    if ( isdefined( damage_time_threshold_ms ) && isdefined( player.lastdamagetime ) && player.lastdamagetime > 0 && player.lastdamagetime > damage_time_threshold_ms )
    {
        return;
    }
    
    empty_bars = get_empty_bars();
    
    if ( empty_bars < bars_to_give )
    {
        player update_max_armor( 1 );
    }
    
    player.armor += int( bars_to_give * player.armorperbar );
}

// Namespace armor/armor
// Params 0
// Checksum 0x80a418c5, Offset: 0xd08
// Size: 0x40
function get_empty_bars()
{
    if ( self.armorperbar <= 0 )
    {
        return 0;
    }
    
    return ( self.maxarmor - self.armor ) / self.armorperbar;
}

// Namespace armor/armor
// Params 0
// Checksum 0x1b5f66a3, Offset: 0xd50
// Size: 0x48, Type: bool
function at_peak_armor_bars()
{
    if ( self.armorperbar <= 0 )
    {
        return true;
    }
    
    return self.armor == self.maxarmor && self.maxarmor >= self.spawnarmor;
}

// Namespace armor/armor
// Params 1
// Checksum 0xd3fed68b, Offset: 0xda0
// Size: 0x7c
function update_max_armor( bonus_bars )
{
    if ( !isdefined( bonus_bars ) )
    {
        bonus_bars = 0;
    }
    
    new_max_bars = get_max_armor_bars( bonus_bars );
    self.maxarmor = int( ceil( new_max_bars * self.armorperbar ) );
}

// Namespace armor/armor
// Params 0
// Checksum 0x4afdc40b, Offset: 0xe28
// Size: 0x22
function has_armor_bar_capability()
{
    return self hasperk( "specialty_armor" );
}

// Namespace armor/armor
// Params 1
// Checksum 0x3c5c9240, Offset: 0xe58
// Size: 0x82
function get_max_armor_bars( bonus_bars )
{
    if ( self.armorperbar <= 0 )
    {
        return 0;
    }
    
    return math::clamp( ceil( self.armor / self.armorperbar ) + bonus_bars, 0, max( self.armorbarmaxcount, 1 ) );
}

// Namespace armor/armor
// Params 0
// Checksum 0x22a7155b, Offset: 0xee8
// Size: 0x22
function get_armor_bars()
{
    return math::clamp( self.armorbarcount, 1, 10 );
}

// Namespace armor/armor
// Params 0
// Checksum 0x728f8bf4, Offset: 0xf18
// Size: 0x80
function function_b9712125()
{
    armortier = 0;
    
    if ( self hasperk( "specialty_armor_tier_three" ) )
    {
        armortier = 2;
    }
    else if ( self hasperk( "specialty_armor_tier_two" ) )
    {
        armortier = 1;
    }
    
    self.armortier = armortier;
}

// Namespace armor/armor
// Params 1
// Checksum 0xc531c1de, Offset: 0xfa0
// Size: 0xf4
function apply_damage( damage )
{
    if ( self.armor <= 0 )
    {
        return damage;
    }
    
    var_63da323f = self get_armor_bars();
    armor_damage = math::clamp( damage, 0, self.armor );
    self.armor -= armor_damage;
    self update_max_armor();
    self function_e05ca844();
    remaining_damage = math::clamp( damage - armor_damage, 0, damage );
    return remaining_damage;
}

// Namespace armor/armor
// Params 0
// Checksum 0xb8a77b2c, Offset: 0x10a0
// Size: 0x1b8
function on_player_killed()
{
    player = self;
    attacker = self.lastattacker;
    
    if ( !isdefined( attacker ) )
    {
        return;
    }
    
    attackerisplayer = isplayer( attacker );
    
    if ( attackerisplayer && attacker hasperk( "specialty_spawnarmorpickups" ) )
    {
        visuals = [];
        visuals[ 0 ] = spawn( "script_model", player.origin );
        visuals[ 0 ] setmodel( "p7_dogtags_friendly" );
        trigger = spawn( "trigger_radius", ( 0, 0, 0 ), 0, 32, 32 );
        pickup_item_object = gameobjects::create_use_object( player.team, trigger, visuals, ( 0, 0, 32 ), istring( "pickup_item" ) );
        pickup_item_object gameobjects::allow_use( "friendly" );
        pickup_item_object gameobjects::set_use_time( 0 );
        pickup_item_object.onuse = &function_3cb47def;
    }
}

// Namespace armor/armor
// Params 1
// Checksum 0x96776ada, Offset: 0x1260
// Size: 0x24
function function_3cb47def( player )
{
    self delete();
}

