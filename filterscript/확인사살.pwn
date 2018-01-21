/*==================================================================================*/
/*                              Made By. Leehi                                      */
/*==================================================================================*/
#include <a_samp>
/*====================new, forward====================*/
new
	Float:DPos[MAX_PLAYERS][3],
	bool:PLAYER_DEATH[MAX_PLAYERS],
	DEATH_HIT[MAX_PLAYERS]
;
/*====================================================*/

public OnPlayerSpawn(playerid)
{
	if(PLAYER_DEATH[playerid] == true)
	{
	    SetPlayerPos(playerid,DPos[playerid][0],DPos[playerid][1],DPos[playerid][2]);
	    ApplyAnimation(playerid,"CRACK","crckdeth2",4.0999,0,1,1,0,1);
	    ApplyAnimation(playerid,"CRACK","crckdeth2",4.0999,0,1,1,0,1);
	    return 1;
	}
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
    PLAYER_DEATH[playerid] = true;
	GetPlayerPos(playerid,DPos[playerid][0],DPos[playerid][1],DPos[playerid][2]);
	return 1;
}

public OnPlayerTakeDamage(playerid, issuerid, Float: amount, weaponid)
{
	new str[128];
	if(PLAYER_DEATH[playerid] == true)
	{
	    DEATH_HIT[issuerid] ++;
	    format(str,sizeof(str),"확인사살 : %d/5",DEATH_HIT[issuerid]);
	    SendClientMessage(issuerid,-1,str);
	    format(str,sizeof(str),"확인사살 : %d/5",DEATH_HIT[issuerid]);
	    SendClientMessage(playerid,-1,str);
		SetPlayerHealth(playerid,100);
	    if(DEATH_HIT[issuerid] >= 5)
	    {
	        SendClientMessage(issuerid,-1,"상대방을 확인사살했습니다.");
	        SendClientMessage(playerid,-1,"당신 확인사살당했습니다.");
			DEATH_HIT[issuerid] = 0;
			PLAYER_DEATH[playerid] = false;
			SpawnPlayer(playerid);
			return 1;
		}
	}
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/무기", cmdtext, true, 10) == 0)
	{
		GivePlayerWeapon(playerid,24,1000);
		GivePlayerWeapon(playerid,16,1000);
		return 1;
	}
	if (strcmp("/모션", cmdtext, true, 10) == 0)
	{
	    ApplyAnimation(playerid, "CRACK","crckdeth2", 4.0999, 0, 1, 1, 1, 0, 1);
	    ApplyAnimation(playerid, "CRACK","crckdeth2", 4.0999, 0, 1, 1, 1, 0, 1);
		return 1;
	}
	return 0;
}
