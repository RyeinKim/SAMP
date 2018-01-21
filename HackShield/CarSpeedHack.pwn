/*==================================================================================*/
/*                              Made By. Leehi                                      */
/*==================================================================================*/
#include <a_samp>
#include <foreach>
/*====================new, forward====================*/
forward AntiSpeedHack();
new SpeedWarnings[MAX_PLAYERS];
/*====================================================*/

/*=======================define=======================*/
#define red "{FF002B}"
#define MAX_SPEED_WARNINGS 3
#define MAX_SPEED 450
/*====================================================*/

new VehicleNames[][] =
{
  "Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel", "Dumper", "Firetruck", "Trashmaster",
  "Stretch", "Manana", "Infernus", "Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam",
  "Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BF Injection", "Hunter", "Premier", "Enforcer",
  "Securicar", "Banshee", "Predator", "Bus", "Rhino", "Barracks", "Hotknife", "Trailer", "Previon", "Coach",
  "Cabbie", "Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral", "Squalo", "Seasparrow",
  "Pizzaboy", "Tram", "Trailer", "Turismo", "Speeder", "Reefer", "Tropic", "Flatbed", "Yankee", "Caddy", "Solair",
  "Berkley's RC Van", "Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale", "Oceanic",
  "Sanchez", "Sparrow", "Patriot", "Quad", "Coastguard", "Dinghy", "Hermes", "Sabre", "Rustler", "ZR-350", "Walton",
  "Regina", "Comet", "BMX", "Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick", "News Chopper", "Rancher",
  "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking", "Blista Compact", "Police Maverick",
  "Boxvillde", "Benson", "Mesa", "RC Goblin", "Hotring Racer A", "Hotring Racer B", "Bloodring Banger", "Rancher",
  "Super GT", "Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropduster", "Stunt", "Tanker", "Roadtrain",
  "Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra", "FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Tow Truck",
  "Fortune", "Cadrona", "FBI Truck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer", "Remington", "Slamvan",
  "Blade", "Freight", "Streak", "Vortex", "Vincent", "Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder",
  "Primo", "Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada", "Yosemite", "Windsor", "Monster", "Monster",
  "Uranus", "Jester", "Sultan", "Stratum", "Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito",
  "Freight Flat", "Streak Carriage", "Kart", "Mower", "Dune", "Sweeper", "Broadway", "Tornado", "AT-400", "DFT-30",
  "Huntley", "Stafford", "BF-400", "News Van", "Tug", "Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club",
  "Freight Box", "Trailer", "Andromada", "Dodo", "RC Cam", "Launch", "Police Car", "Police Car", "Police Car",
  "Police Ranger", "Picador", "S.W.A.T", "Alpha", "Phoenix", "Glendale", "Sadler", "Luggage", "Luggage", "Stairs",
  "Boxville", "Tiller", "Utility Trailer"
};

public OnPlayerConnect(playerid)
{
    SpeedWarnings[playerid] = 0;
    SetPVarInt(playerid, "spawned", 0);
    return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
    SetPVarInt(playerid, "spawned", 0);
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	SetPVarInt(playerid, "spawned", 0);
	return 1;
}

public OnPlayerSpawn(playerid)
{
    SetPVarInt(playerid, "spawned", 1);
    return 1;
}

public AntiSpeedHack()
{
	foreach (new i : Player)
	{
	 	new currentspeed = GetPlayerSpeed(i,true);
		if(currentspeed > MAX_SPEED)
		{
		    new tmpcar = GetPlayerVehicleID(i), surf = GetPlayerSurfingVehicleID(i);
			if(!IsAPlane(tmpcar) && !(GetPlayerState(i) == PLAYER_STATE_PASSENGER) && !(IsATrain(tmpcar)) && surf == INVALID_VEHICLE_ID && GetPVarInt(i, "spawned") == 1)
			{
			 	new sendername[MAX_PLAYER_NAME];
				GetPlayerName(i, sendername, sizeof(sendername));
				new vehicleid = GetPlayerVehicleID(i);
				new Float:hp; GetVehicleHealth(vehicleid, hp);
				new string[150];
				format(string, sizeof(string), "** System Report: Possible speedhack by %s (%d) (%d km/h) in a %s with %.2f VehHp.",sendername,i,currentspeed,VehicleNames[GetVehicleModel(GetPlayerVehicleID(i))-400],hp);
				SendClientMessageToAll(-1, string);
				SpeedWarnings[i]++; 
				if(SpeedWarnings[i] >= MAX_SPEED_WARNINGS)
				{
					new ok[128];
					new IP[16];
					GetPlayerIp(i, IP, sizeof(IP));
					SendClinetMessage(playerid, -1, "스피드핵으로 당신은 밴됩니다."); //Ban Msg
				    format(ok, sizeof(ok), "** System: %s (%d) - Speedhack (%d km/h)", sendername,i,currentspeed);
					SendClientMessageToAll(-1, ok);
					Ban(i);
					SpeedWarnings[i] = 0;
				}
			}
		}
	}
}

stock GetPlayerSpeed(playerid,bool:kmh)
{
  new Float:Vx,Float:Vy,Float:Vz,Float:rtn;
  if(IsPlayerInAnyVehicle(playerid)) GetVehicleVelocity(GetPlayerVehicleID(playerid),Vx,Vy,Vz); else GetPlayerVelocity(playerid,Vx,Vy,Vz);
  rtn = floatsqroot(floatabs(floatpower(Vx + Vy + Vz,2)));
  return kmh?floatround(rtn * 100 * 1.61):floatround(rtn * 100);
}

stock IsATrain(vehicleid)
{
    switch(GetVehicleModel(vehicleid))
    {
        case 449,537,538,569,570,590: return 1;
    }
    return 0;
}

stock IsAPlane(vehicleid)
{
    switch(GetVehicleModel(vehicleid))
    {
        case 460,464,476,511,512,513,519,520,553,577,592,593: return 1;
    }
    return 0;
}
