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
	    format(string,sizeof(string),"[ IP : %s �̸� : %s ��ȣ : %d ] �� ���� Ŭ���� ������� ���� �� ó�� �˴ϴ�.",PlayerIP, PlayerName(playerid), playerid);
		SendAdminMessage(0xFF0000FF, string);
	    SendClientMessage(playerid, 0xFF0000FF, "���� Ŭ������ ��� �Ͽ� ���� �� ó���˴ϴ�.");
		format(bquery, sizeof(bquery),"INSERT INTO hackdata(player, reason, IP, banned) VALUES('%s', '����Ŭ����','%s', 1)", PlayerName(playerid), IP);
		mysql_query(bquery);
		format(string, sizeof(string),"%s �� ���� ��ó�� �Ǿ����ϴ�. [����: ����Ŭ����]", PlayerName(playerid));
		SendClientMessageToAll(0xFF0000FF, string);
		mysql_free_result();
		Kick(playerid);
	}
	g_VehTime[playerid] = GetTickCount();
	return 1;
}
