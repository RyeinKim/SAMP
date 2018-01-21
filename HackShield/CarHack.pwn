/*==================================================================================*/
/*                              Made By. Leehi                                      */
/*==================================================================================*/
#include <a.samp>
/*====================new, forward====================*/
new	g_VehTime[MAX_PLAYERS];
/*====================================================*/

public OnPlayerChangeVehicle(playerid, vehicleid)
{
    new string[256];
	new PlayerIP[256];
	GetPlayerIp(playerid,PlayerIP,sizeof(PlayerIP));
	#pragma unused vehicleid
	if((GetTickCount() - g_VehTime[ playerid ]) < 500)
	{
        new bquery[200], IP[16];
	    format(string,sizeof(string),"[ IP : %s 이름 : %s 번호 : %d ] 가 차량 클레오 사용으로 영구 밴 처리 됩니다.",PlayerIP, PlayerName(playerid), playerid);
		SendAdminMessage(0xFF0000FF, string);
	    SendClientMessage(playerid, 0xFF0000FF, "차량 클레오를 사용 하여 서비스 블럭 처리됩니다.");
		format(bquery, sizeof(bquery),"INSERT INTO hackdata(player, reason, IP, banned) VALUES('%s', '차량클레오','%s', 1)", PlayerName(playerid), IP);
		mysql_query(bquery);
		format(string, sizeof(string),"%s 가 서비스 블럭처리 되었습니다. [사유: 차량클레오]", PlayerName(playerid));
		SendClientMessageToAll(0xFF0000FF, string);
		mysql_free_result();
		Kick(playerid);
	}
	g_VehTime[playerid] = GetTickCount();
	return 1;
}
