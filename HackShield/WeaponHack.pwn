/*==================================================================================*/
/*                              Made By. Leehi                                      */
/*==================================================================================*/
#include <a.samp>
/*======================new, forward========================*/
new bool:WeaponHack[MAX_PLAYERS][WEAPON_HACK];
/*==========================================================*/

public OnPlayerConnect(playerid)
{
    for(new w = 1; w < WEAPON_HACK; w++)
	{
		WeaponHack[playerid][w] = false;
	}
	return 1;
}

public OnPlayerUpdate(playerid)
{
    new weaponid = GetPlayerWeapon(playerid);
    new vehicleid = GetPlayerVehicleID(playerid);
	if (weaponid > 0)
	{
	    if (WeaponHack[playerid][weaponid] == false)
	    {
		    new string[128];
			ResetPlayerWeapons(playerid);
			format(string, sizeof(string), "%s 님이 무기핵을 사용하여 자동으로 서비스 블럭 처리 되었습니다.", PlayerName(playerid)); // use hack: server msg
			SendClientMessageToAll(0xFC595AFF, string);
			new bquery[200], IP[16];
			format(bquery, sizeof(bquery),"INSERT INTO hackdata(player, reason, IP, banned) VALUES('%s', '무기핵사용','%s', 1)", PlayerName(playerid), IP);
			mysql_query(bquery);
			format(string, sizeof(string),"%s 가 서비스 블럭처리 되었습니다. [사유: 무기핵사용]", PlayerName(playerid)); // usehack: server msg
			SendClientMessageToAll(0xFF0000FF, string);
			mysql_free_result();
			Kick(playerid);
		}
	}
	return 1;
}

public SafeGivePlayerWeapon(playerid, weaponid, ammo)
{
	GWeapon[playerid] = 5;
	WeaponHack[playerid][weaponid] = true;
	if (GetPlayerWeapon(playerid) == weaponid)
	{
	    ammo += GetPlayerAmmo(playerid);
	}
	GivePlayerWeapon(playerid, weaponid, ammo);
	return 1;
}
