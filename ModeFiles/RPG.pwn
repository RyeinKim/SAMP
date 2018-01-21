/*==================================================================================*/
/*                              Made By. Leehi                                      */
/*==================================================================================*/
//------------------------------------------------------------------------------
#include <a_samp.inc>
#include <SINI.inc>
#include <iamm_pos.inc>
//------------------------------------------------------------------------------
#define MAX_PLAYER_INVENTORIES  30
//------------------------------------------------------------------------------
#define JOB_NONE            	0
#define JOB_KNIGHT          	1
//------------------------------------------------------------------------------
#define ITEM_TYPE_NONE      	0
#define ITEM_TYPE_CONSUME   	1
#define ITEM_TYPE_EQUIPMENT 	2
//------------------------------------------------------------------------------
#define DIALOG_REGISTER 		1
#define DIALOG_LOGIN    		2
#define DIALOG_CHANGEPASS 		3 // ���߿�
#define DIALOG_SET_NICKNAME 	4

#define DIALOG_MENU         	11
#define DIALOG_STATS        	12
#define DIALOG_SELLLIST     	13
#define DIALOG_INVENTORY    	14
#define DIALOG_EQUIPMENT        15

#define DIALOG_SCRIPT_END   	1000
// �ٸ���, ��� ����
#define DIALOG_SCRIPT_1     	1001
#define DIALOG_SCRIPT_2     	1002
#define DIALOG_SCRIPT_3     	1003
// ���, ����
#define DIALOG_SCRIPT_4     	1004
// ����, â��
#define DIALOG_SCRIPT_5     	1005
// �轼, �ǻ�
#define DIALOG_SCRIPT_6     	1006
// ȣ��, ����
#define DIALOG_SCRIPT_7     	1007
// ȫ��, ��� ����
#define DIALOG_SCRIPT_8         1008
//------------------------------------------------------------------------------
forward AutoSaveTimer();
forward LevelUpTimer();
forward s0beit(playerid);
forward ShowMenu(playerid);
forward ShowEquipments(playerid);
forward ShowStats(playerid);
forward ShowInventoryForPlayer(playerid, showplayerid);
forward ShowSellList(playerid, itemtype);
//------------------------------------------------------------------------------
enum pInfo
{
	pPassword[128],
	pTutorial,
	pLevel,
	pEXP,
	pNickname[MAX_PLAYER_NAME],
	pAdminLevel,
	Float:pPos[4],
	pInterior,
	pWorld,
	pJob,
	pMoney,
	Float:pHealth,
	Float:pArmour
};
new PlayerInfo[MAX_PLAYERS][pInfo];

enum piInfo
{
	piItemID,
	piItemAmount
};
new PlayerInventoryInfo[MAX_PLAYERS][MAX_PLAYER_INVENTORIES][piInfo];

enum peInfo
{
	peItemID,
	peItemModel,
	Float:peItemOffset[3],
	Float:peItemRot[3],
	Float:peItemScale[3]
};
new PlayerEquipmentInfo[MAX_PLAYERS][19][peInfo];
/*
0 ����
1 ~ 18 ��
*/

new bool:Account[MAX_PLAYERS] = { false, ... };
new bool:Logined[MAX_PLAYERS] = { false, ... };
new s0beit_Passed[MAX_PLAYERS] = { 0, ... };

new Text3D:PlayerLabel[MAX_PLAYERS] = { Text3D:INVALID_3DTEXT_ID, ... };

new bool:AutoSave = false;

new TalkingActor[MAX_PLAYERS] = { -1, ... };
new PlayerEquipedWeapon[MAX_PLAYERS] = { 0, ... };
new BuyingItemType[MAX_PLAYERS] = { 0, ... };
//------------------------------------------------------------------------------
enum itInfo
{
    itType,
    itName[24],
	itPrice,
	itModel,
	bool:itSell,
};
new ItemInfo[][itInfo] = {
	{ITEM_TYPE_CONSUME, 	"���� ȸ����", 	50,		0,		true},
	{ITEM_TYPE_CONSUME, 	"���� ȸ����", 	100,	0,		true},
	{ITEM_TYPE_EQUIPMENT,   "����",         500,    322,	true},
	{ITEM_TYPE_CONSUME, 	"���� ȸ����", 	200,	0,		true},
	{ITEM_TYPE_EQUIPMENT,   "������",       5000,	341,	true}
};
//------------------------------------------------------------------------------
enum aInfo
{
	aName[MAX_PLAYER_NAME],
	aSub[MAX_PLAYER_NAME],
	aModel,
	Float:aPos[4]
};
new ActorInfo[][aInfo] = {
	{"�ٸ���", 	"��� ����", 	150, 	{-777.9976, 1437.6735, 13.7891, 0.0000}},
	{"���", 	"����", 		287, 	{-815.8527, 1447.6820, 13.9453, 0.0000}},
	{"����",	"â��",			187,	{-828.2936, 1500.7463, 19.3686, 0.0000}},
	{"�轼",	"�ǻ�", 		275,	{-817.4917, 1551.0803, 27.1172, 0.0000}},
	{"ȣ��",	"�Һ� ����", 	29,		{-780.1939, 1500.6450, 23.8044, 0.0000}},
	{"ȫ��",	"��� ����", 	29,		{-797.5771, 1525.7927, 27.0789, 270.0000}}
};
new Text3D:ActorTag[MAX_ACTORS] = { Text3D:INVALID_3DTEXT_ID, ... };
//------------------------------------------------------------------------------
stock strtok(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}

	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}

stock GivePlayerItem(playerid, itemid, amount)
{
	if (IsPlayerConnected(playerid))
	{
	    if (amount > 0)
	    {
		    if (ItemInfo[itemid][itType] != ITEM_TYPE_NONE)
		    {
		        new inventory_index = -1;
		        for (new i; i < MAX_PLAYER_INVENTORIES; i++)
		        {
		            if (PlayerInventoryInfo[playerid][i][piItemID] == -1 ||
						PlayerInventoryInfo[playerid][i][piItemID] == itemid
					)
		            {
		                inventory_index = i;
		                break;
		            }
		        }
		        if (PlayerInventoryInfo[playerid][inventory_index][piItemID] == -1)
		        {
		            PlayerInventoryInfo[playerid][inventory_index][piItemID] = itemid;
		            PlayerInventoryInfo[playerid][inventory_index][piItemAmount] ++;
		        }
		        else if (PlayerInventoryInfo[playerid][inventory_index][piItemID] == itemid)
		        {
		            PlayerInventoryInfo[playerid][inventory_index][piItemAmount] ++;
		        }
		        return 1;
		    }
	    }
	}
	return 0;
}

stock GetWeaponModel(weaponid)
{
	new modelid = 0;
	switch (weaponid)
	{
	    case 1: modelid = 331;
	    case 2: modelid = 333;
	    case 3: modelid = 334;
	    case 4: modelid = 335;
	    case 5: modelid = 336;
	    case 6: modelid = 337;
	    case 7: modelid = 338;
	    case 8: modelid = 339;
	    case 9: modelid = 341;
	    case 10: modelid = 321;
	    case 11: modelid = 322;
	    case 12: modelid = 323;
	    case 13: modelid = 324;
	    case 14: modelid = 325;
	    case 15: modelid = 326;
	    case 16: modelid = 342;
	    case 17: modelid = 343;
	    case 18: modelid = 344;
	    case 22: modelid = 346;
	    case 23: modelid = 347;
	    case 24: modelid = 348;
	    case 25: modelid = 349;
	    case 26: modelid = 350;
	    case 27: modelid = 351;
	    case 28: modelid = 352;
	    case 29: modelid = 353;
	    case 30: modelid = 355;
	    case 31: modelid = 356;
	    case 32: modelid = 372;
	    case 33: modelid = 357;
	    case 34: modelid = 358;
	    case 35: modelid = 359;
	    case 36: modelid = 360;
	    case 37: modelid = 361;
	    case 38: modelid = 362;
	    case 39: modelid = 363;
	    case 40: modelid = 364;
	    case 41: modelid = 365;
	    case 42: modelid = 366;
	    case 43: modelid = 367;
	    case 44: modelid = 368;
	    case 45: modelid = 369;
	    case 46: modelid = 371;
	}
	return modelid;
}

stock GetActorFrontPos(actorid, Float:Distance, &Float:X, &Float:Y, &Float:Z)
{
	new Float:oldpos[3], Float:angle;
	GetActorPos(actorid, oldpos[0], oldpos[1], oldpos[2]);
	GetActorFacingAngle(actorid, angle);

	new Float:newpos[3];
	newpos[0] = oldpos[0] + (Distance * floatcos(angle + 90, degrees));
	newpos[1] = oldpos[1] + (Distance * floatsin(angle + 90, degrees));
	newpos[2] = oldpos[2];

	X = newpos[0];
	Y = newpos[1];
	Z = newpos[2];

	return 1;
}

stock SetActorLookAt(actorid, Float:x, Float:y)
{
	new Float:Px, Float:Py, Float: Pa;
	GetActorPos(actorid, Px, Py, Pa);
	Pa = floatabs(atan((y-Py)/(x-Px)));
	if (x <= Px && y >= Py) Pa = floatsub(180, Pa);
	else if (x < Px && y < Py) Pa = floatadd(Pa, 180);
	else if (x >= Px && y <= Py) Pa = floatsub(360.0, Pa);
	Pa = floatsub(Pa, 90.0);
	if (Pa >= 360.0) Pa = floatsub(Pa, 360.0);
	SetActorFacingAngle(actorid, Pa);
}

stock SendCloseMessage(Float:X, Float:Y, Float:Z, Float:distance, color, const message[])
{
	for (new i; i < GetMaxPlayers(); i++)
	    if (IsPlayerConnected(i))
	        if (Logined[i] == true)
	            if (IsPlayerInRangeOfPoint(i, distance, X, Y, Z))
					SendClientMessage(i, color, message);
}

stock SendServerMessage(color, const message[])
{
	for (new i; i < GetMaxPlayers(); i++)
	    if (IsPlayerConnected(i))
	        if (Logined[i] == true)
				SendClientMessage(i, color, message);
}

stock PlayerName(playerid)
{
	new playername[MAX_PLAYER_NAME];
	GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
	return playername;
}

stock KickLog(text[])
{
	new entry[1024];
 	format(entry, 1024, "%s\n", text);
	new File:logfile = fopen("kick_log.txt", io_append);
	fwrite(logfile, entry);
	fclose(logfile);
}

stock BanLog(text[])
{
	new entry[1024];
	format(entry, 1024, "%s\n", text);
	new File:logfile = fopen("ban_log.txt", io_append);
	fwrite(logfile, entry);
	fclose(logfile);
}

stock LoadPlayer(playerid)
{
	new playername[MAX_PLAYER_NAME];
	GetPlayerName(playerid, playername, 24);
	new file[256];
	format(file, 256, "Userfiles/%s.ini", playername);
	if (INI_Exist(file))
	{
	    INI_Open(file, Read);
		strmid(PlayerInfo[playerid][pPassword], INI_Read("Password"),0, 128,128);
		PlayerInfo[playerid][pLevel] =  strval(INI_Read("Level"));
		PlayerInfo[playerid][pEXP] =  strval(INI_Read("EXP"));
		PlayerInfo[playerid][pTutorial] =  strval(INI_Read("Tutorial"));
		strmid(PlayerInfo[playerid][pNickname],INI_Read("Nickname"),0, 128,128);
		PlayerInfo[playerid][pAdminLevel] = strval(INI_Read("AdminLevel"));
		PlayerInfo[playerid][pPos][0] = floatstr(INI_Read("X"));
		PlayerInfo[playerid][pPos][1] = floatstr(INI_Read("Y"));
		PlayerInfo[playerid][pPos][2] = floatstr(INI_Read("Z"));
		PlayerInfo[playerid][pPos][3] = floatstr(INI_Read("Angle"));
		PlayerInfo[playerid][pInterior] = strval(INI_Read("Interior")); // IntSet ���丮�� ó��
		PlayerInfo[playerid][pWorld] = strval(INI_Read("World"));
		PlayerInfo[playerid][pJob] = strval(INI_Read("Job"));
		PlayerInfo[playerid][pMoney] = strval(INI_Read("Money"));
		PlayerInfo[playerid][pHealth] = floatstr(INI_Read("Health"));
		PlayerInfo[playerid][pArmour] = floatstr(INI_Read("Armour"));
		printf("[load] %s loaded.", playername);
		INI_Close();
		//----------------------------------------------------------------------
		GivePlayerMoney(playerid, PlayerInfo[playerid][pMoney]);
		SetPlayerHealth(playerid, PlayerInfo[playerid][pHealth]);
		SetPlayerArmour(playerid, PlayerInfo[playerid][pArmour]);
		return 1;
	}
	return 0;
}

stock SavePlayer(playerid)
{
	new playername[MAX_PLAYER_NAME];
	GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
	new file[256];
	format(file, 256, "Userfiles/%s.ini", playername);
	if (INI_Exist(file))
	{
	    GetPlayerPos(
			playerid,
			PlayerInfo[playerid][pPos][0],
			PlayerInfo[playerid][pPos][1],
			PlayerInfo[playerid][pPos][2]
		);
		GetPlayerFacingAngle(
		    playerid,
		    PlayerInfo[playerid][pPos][3]
		);
		PlayerInfo[playerid][pInterior] = GetPlayerInterior(playerid);
		PlayerInfo[playerid][pWorld] = GetPlayerVirtualWorld(playerid);
		PlayerInfo[playerid][pMoney] = GetPlayerMoney(playerid);
		GetPlayerHealth(playerid, PlayerInfo[playerid][pHealth]);
		GetPlayerArmour(playerid, PlayerInfo[playerid][pArmour]);
	    if(INI_Exist(file))
	    {
		    INI_Open(file, Write);
			INI_Write("Password", PlayerInfo[playerid][pPassword]);
			INI_WriteInt("Level", PlayerInfo[playerid][pLevel]);
			INI_WriteInt("EXP", PlayerInfo[playerid][pEXP]);
			INI_WriteInt("Tutorial", PlayerInfo[playerid][pTutorial]);
			INI_Write("Nickname", PlayerInfo[playerid][pNickname]);
			INI_WriteInt("AdminLevel", PlayerInfo[playerid][pAdminLevel]);
			INI_WriteFloat("X", PlayerInfo[playerid][pPos][0]);
			INI_WriteFloat("Y", PlayerInfo[playerid][pPos][1]);
			INI_WriteFloat("Z", PlayerInfo[playerid][pPos][2]);
			INI_WriteFloat("Angle", PlayerInfo[playerid][pPos][3]);
			INI_WriteInt("Interior", PlayerInfo[playerid][pInterior]);
			INI_WriteInt("World", PlayerInfo[playerid][pWorld]);
			INI_WriteInt("Job", PlayerInfo[playerid][pJob]);
			INI_WriteInt("Money", PlayerInfo[playerid][pMoney]);
			INI_WriteFloat("Health", PlayerInfo[playerid][pHealth]);
			INI_WriteFloat("Armour", PlayerInfo[playerid][pArmour]);
			printf("[save] %s saved.", playername);
			INI_Close();
		}
		return 1;
	}
	return 1;
}

stock RegisterPlayer(playerid, password[])
{
	new playername[MAX_PLAYER_NAME];
	GetPlayerName(playerid, playername, 24);
	new file[256];
	format(file, 256, "Userfiles/%s.ini", playername);
	if (!INI_Exist(file))
	{
	    INI_Open(file, Write);
		strmid(PlayerInfo[playerid][pPassword], password, 0, 24, 24);
		INI_Write("Password", PlayerInfo[playerid][pPassword]);
		PlayerInfo[playerid][pLevel] = 1;
		INI_WriteInt("Level", PlayerInfo[playerid][pLevel]);
		PlayerInfo[playerid][pEXP] = 0;
		INI_WriteInt("EXP", PlayerInfo[playerid][pEXP]);
		PlayerInfo[playerid][pTutorial] = 0;
		INI_WriteInt("Tutorial", PlayerInfo[playerid][pTutorial]);
		strmid(PlayerInfo[playerid][pNickname], "None", 0, 24, 24);
		INI_Write("Nickname", PlayerInfo[playerid][pNickname]);
		PlayerInfo[playerid][pAdminLevel] = 0;
		INI_WriteInt("AdminLevel", PlayerInfo[playerid][pAdminLevel]);
		PlayerInfo[playerid][pPos][0] = 0.0000;
		INI_WriteFloat("X", PlayerInfo[playerid][pPos][0]);
		PlayerInfo[playerid][pPos][1] = 0.0000;
		INI_WriteFloat("Y", PlayerInfo[playerid][pPos][1]);
		PlayerInfo[playerid][pPos][2] = 0.0000;
		INI_WriteFloat("Z", PlayerInfo[playerid][pPos][2]);
		PlayerInfo[playerid][pPos][3] = 0.0000;
		INI_WriteFloat("Angle", PlayerInfo[playerid][pPos][3]);
		PlayerInfo[playerid][pInterior] = 0;
		INI_WriteInt("Interior", PlayerInfo[playerid][pInterior]);
		PlayerInfo[playerid][pWorld] = 0;
		INI_WriteInt("World", PlayerInfo[playerid][pWorld]);
		PlayerInfo[playerid][pJob] = JOB_NONE;
		INI_WriteInt("Job", PlayerInfo[playerid][pJob]);
		PlayerInfo[playerid][pMoney] = 500;
		INI_WriteInt("Money", PlayerInfo[playerid][pMoney]);
		PlayerInfo[playerid][pHealth] = 100.0;
		INI_WriteFloat("Health", PlayerInfo[playerid][pHealth]);
		PlayerInfo[playerid][pArmour] = 100.0;
		INI_WriteFloat("Armour", PlayerInfo[playerid][pArmour]);
		INI_Close();
		printf("[registry] %s registerd.", playername);
		return 1;
	}
	return 0;
}

stock LoadPlayerInventories(playerid)
{
	new playername[MAX_PLAYER_NAME];
	GetPlayerName(playerid, playername, 24);
	new file[256];
	format(file, 256, "Userfiles/Inventories/%s.ini", playername);
	if (!INI_Exist(file))
	{
	    INI_Open(file, Write);
	    INI_Close();
	}
    INI_Open(file, Read);
	new info[256];
	for (new i; i < MAX_PLAYER_INVENTORIES; i++)
    {
        format(info, 256, "%d_ID", i + 1); PlayerInventoryInfo[playerid][i][piItemID] =  strval(INI_Read(info));
		format(info, 256, "%d_Amount", i + 1); PlayerInventoryInfo[playerid][i][piItemAmount] = strval(INI_Read(info));
        if (PlayerInventoryInfo[playerid][i][piItemAmount] == 0)
            PlayerInventoryInfo[playerid][i][piItemID] = -1;
	}
	INI_Close();
	return 1;
}

stock SavePlayerInventories(playerid)
{
	new playername[MAX_PLAYER_NAME];
	GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
	new file[256], info[256];
	format(file, 256, "Userfiles/Inventories/%s.ini", playername);
	INI_Open(file, Write);
	for (new i; i < MAX_PLAYER_INVENTORIES; i++)
    {
        format(info, 256, "%d_ID", i + 1); INI_WriteInt(info, PlayerInventoryInfo[playerid][i][piItemID]);
		format(info, 256, "%d_Amount", i + 1); INI_WriteInt(info, PlayerInventoryInfo[playerid][i][piItemAmount]);
	}
	INI_Close();
	return 1;
}

stock LoadPlayerEquipments(playerid)
{
	new playername[MAX_PLAYER_NAME];
	GetPlayerName(playerid, playername, 24);
	new file[256];
	format(file, 256, "Userfiles/Equipments/%s.ini", playername);
	if (!INI_Exist(file))
	{
	    INI_Open(file, Write);
	    new tmp[256];
		for (new i; i < 19; i++)
	    {
	        format(tmp, 256, "%d_ID", i + 1); INI_WriteInt(tmp, -1);
	        format(tmp, 256, "%d_Model", i + 1); INI_WriteInt(tmp, 0);
	        format(tmp, 256, "%d_OffsetX", i + 1); INI_WriteFloat(tmp, 0.0000);
	        format(tmp, 256, "%d_OffsetY", i + 1); INI_WriteFloat(tmp, 0.0000);
	        format(tmp, 256, "%d_OffsetZ", i + 1); INI_WriteFloat(tmp, 0.0000);
	        format(tmp, 256, "%d_RotX", i + 1); INI_WriteFloat(tmp, 0.0000);
	        format(tmp, 256, "%d_RotY", i + 1); INI_WriteFloat(tmp, 0.0000);
	        format(tmp, 256, "%d_RotZ", i + 1); INI_WriteFloat(tmp, 0.0000);
	        format(tmp, 256, "%d_ScaleX", i + 1); INI_WriteFloat(tmp, 0.0000);
	        format(tmp, 256, "%d_ScaleY", i + 1); INI_WriteFloat(tmp, 0.0000);
	        format(tmp, 256, "%d_ScaleZ", i + 1); INI_WriteFloat(tmp, 0.0000);
		}
	    INI_Close();
	}
    INI_Open(file, Read);
	new info[256];
	for (new i; i < 19; i++)
    {
        format(info, 256, "%d_ID", i + 1); PlayerEquipmentInfo[playerid][i][peItemID] = strval(INI_Read(info));
        format(info, 256, "%d_Model", i + 1); PlayerEquipmentInfo[playerid][i][peItemModel] = strval(INI_Read(info));
        format(info, 256, "%d_OffsetX", i + 1); PlayerEquipmentInfo[playerid][i][peItemOffset][0] = floatstr(INI_Read(info));
        format(info, 256, "%d_OffsetY", i + 1); PlayerEquipmentInfo[playerid][i][peItemOffset][1] = floatstr(INI_Read(info));
        format(info, 256, "%d_OffsetZ", i + 1); PlayerEquipmentInfo[playerid][i][peItemOffset][2] = floatstr(INI_Read(info));
       	format(info, 256, "%d_RotX", i + 1); PlayerEquipmentInfo[playerid][i][peItemRot][0] = floatstr(INI_Read(info));
        format(info, 256, "%d_RotY", i + 1); PlayerEquipmentInfo[playerid][i][peItemRot][1] = floatstr(INI_Read(info));
        format(info, 256, "%d_RotZ", i + 1); PlayerEquipmentInfo[playerid][i][peItemRot][2] = floatstr(INI_Read(info));
       	format(info, 256, "%d_ScaleX", i + 1); PlayerEquipmentInfo[playerid][i][peItemScale][0] = floatstr(INI_Read(info));
        format(info, 256, "%d_ScaleY", i + 1); PlayerEquipmentInfo[playerid][i][peItemScale][1] = floatstr(INI_Read(info));
        format(info, 256, "%d_ScaleZ", i + 1); PlayerEquipmentInfo[playerid][i][peItemScale][2] = floatstr(INI_Read(info));
	}
	INI_Close();
	if (PlayerEquipmentInfo[playerid][0][peItemID] != -1)
	{
	    new itemid = PlayerEquipmentInfo[playerid][0][peItemID];
	    switch (itemid)
	    {
	    	case 2: PlayerEquipedWeapon[playerid] = 11;
	    	case 4: PlayerEquipedWeapon[playerid] = 9;
	    }
	}
	return 1;
}

stock SavePlayerEquipments(playerid)
{
	new playername[MAX_PLAYER_NAME];
	GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
	new file[256], info[256];
	format(file, 256, "Userfiles/Equipments/%s.ini", playername);
	INI_Open(file, Write);
	for (new i; i < 19; i++)
    {
        format(info, 256, "%d_ID", i + 1); INI_WriteInt(info, PlayerEquipmentInfo[playerid][i][peItemID]);
        format(info, 256, "%d_Model", i + 1); INI_WriteInt(info, PlayerEquipmentInfo[playerid][i][peItemModel]);
        format(info, 256, "%d_OffsetX", i + 1); INI_WriteFloat(info, PlayerEquipmentInfo[playerid][i][peItemOffset][0]);
        format(info, 256, "%d_OffsetY", i + 1); INI_WriteFloat(info, PlayerEquipmentInfo[playerid][i][peItemOffset][1]);
        format(info, 256, "%d_OffsetZ", i + 1); INI_WriteFloat(info, PlayerEquipmentInfo[playerid][i][peItemOffset][2]);
        format(info, 256, "%d_RotX", i + 1); INI_WriteFloat(info, PlayerEquipmentInfo[playerid][i][peItemRot][0]);
        format(info, 256, "%d_RotY", i + 1); INI_WriteFloat(info, PlayerEquipmentInfo[playerid][i][peItemRot][1]);
        format(info, 256, "%d_RotZ", i + 1); INI_WriteFloat(info, PlayerEquipmentInfo[playerid][i][peItemRot][2]);
        format(info, 256, "%d_ScaleX", i + 1); INI_WriteFloat(info, PlayerEquipmentInfo[playerid][i][peItemScale][0]);
        format(info, 256, "%d_ScaleY", i + 1); INI_WriteFloat(info, PlayerEquipmentInfo[playerid][i][peItemScale][1]);
        format(info, 256, "%d_ScaleZ", i + 1); INI_WriteFloat(info, PlayerEquipmentInfo[playerid][i][peItemScale][2]);
	}
	INI_Close();
	return 1;
}

stock GetJobName(jobid)
{
	new jobname[64];
	switch (jobid)
	{
	    case 1: jobname = "���";
	    default: jobname = "����";
	}
	return jobname;
}

stock GetBoneName(boneid)
{
	new bonename[64];
	switch (boneid)
	{
	    case 1: bonename = "�㸮";
	    case 2: bonename = "�Ӹ�";
	    case 3: bonename = "���� (��)";
	    case 4: bonename = "������ (��)";
	    case 5: bonename = "�޼�";
	    case 6: bonename = "������";
	    case 7: bonename = "���� �����";
	    case 8: bonename = "������ �����";
	    case 9: bonename = "�޹�";
	    case 10: bonename = "������";
	    case 11: bonename = "������ ���Ƹ�";
	    case 12: bonename = "���� ���Ƹ�";
	    case 13: bonename = "���� �ȶ�";
	    case 14: bonename = "������ �ȶ�";
	    case 15: bonename = "���� ���";
	    case 16: bonename = "������ ���";
	    case 17: bonename = "��";
	    case 18: bonename = "��";
	    default: bonename = "�� �� ����";
	}
	return bonename;
}

stock GetCloseActorID(playerid)
{
	new index = -1;
	for (new a; a < MAX_ACTORS; a++)
	{
	    if (ActorInfo[a][aModel] > 0)
	    {
			if (IsPlayerInRangeOfPoint(playerid, 3.0000, ActorInfo[a][aPos][0], ActorInfo[a][aPos][1], ActorInfo[a][aPos][2]))
			{
			    index = a;
			    break;
			}
		}
	}
	return index;
}

public ShowMenu(playerid)
{
	ShowPlayerDialog(playerid, DIALOG_MENU, DIALOG_STYLE_LIST, "�޴�", "�� ����\n�κ��丮\n���", "����", "�ݱ�");
	return 1;
}

public ShowEquipments(playerid)
{
	new info[2048], str[256];
	strcat(info, "����\t�̸�\n");
	for (new i; i < 19; i++)
	{
	    if (i == 0)
	    {
			format(str, 256, "����\t");
		}
		else
		{
		    format(str, 256, "�� (%s)\t", GetBoneName(i));
		}
		new itemid = PlayerEquipmentInfo[playerid][i][peItemID];
		if (itemid == -1)
		{
		    strcat(str, "����"); strcat(str, "\n");
		}
		else
		{
			strcat(str, ItemInfo[itemid][itName]); strcat(str, "\n");
		}
		strcat(info, str);
	}
	ShowPlayerDialog(playerid, DIALOG_EQUIPMENT, DIALOG_STYLE_TABLIST_HEADERS, "���", info, "����", "�ݱ�");
	return 1;
}

public ShowStats(playerid)
{
	new info[1024];
	new expneed = 100 + ((300 * (PlayerInfo[playerid][pLevel] - 1)));
	format(
		info,
		1024,
		"\
		    �г��� : %s\n\
		    ���� : %s\n\
		    ���� : %d\n\
		    ����ġ : %d/%d\
		",
		PlayerInfo[playerid][pNickname],
		GetJobName(PlayerInfo[playerid][pJob]),
		PlayerInfo[playerid][pLevel],
		PlayerInfo[playerid][pEXP], expneed
	);
	ShowPlayerDialog(playerid, DIALOG_STATS, DIALOG_STYLE_MSGBOX, "�� ����", info, "�ݱ�", "");
	return 1;
}

public ShowInventoryForPlayer(playerid, showplayerid)
{
	new info[2048], str[256];
	strcat(info, "��ȣ\t�̸�\t����\n");
	new tmp[256];
	new itmp = -1;
	for (new i; i < MAX_PLAYER_INVENTORIES; i++)
	{
	    if (PlayerInventoryInfo[playerid][i][piItemID] != -1)
	    {
         	itmp ++;
	        format(tmp, 256, "InventoryListID_%d", itmp);
	        SetPVarInt(playerid, tmp, i);
	        format(
				str, 256, "%d\t%s\t%d\n",
				itmp + 1,
				ItemInfo[PlayerInventoryInfo[playerid][i][piItemID]][itName],
				PlayerInventoryInfo[playerid][i][piItemAmount]
			);
	        strcat(info, str);
	    }
	}
	ShowPlayerDialog(showplayerid, DIALOG_INVENTORY, DIALOG_STYLE_TABLIST_HEADERS, "�κ��丮", info, "�����ϱ�", "�ݱ�");
	return 1;
}

public ShowSellList(playerid, itemtype)
{
	new info[2048], str[256];
	strcat(info, "��ȣ\t�̸�\t����\n");
	new tmp[256];
	new itmp = -1;
	for (new i; i < sizeof(ItemInfo); i++)
	{
	    if (ItemInfo[i][itType] == itemtype)
	    {
	        if (ItemInfo[i][itSell] == true)
	        {
                itmp ++;
	            format(tmp, 256, "BuyItemListID_%d", itmp);
	            SetPVarInt(playerid, tmp, i);
		        format(str, 256, "%d\t%s\t$%d\n", itmp + 1, ItemInfo[i][itName], ItemInfo[i][itPrice]);
		        strcat(info, str);
	        }
	    }
	}
	ShowPlayerDialog(playerid, DIALOG_SELLLIST, DIALOG_STYLE_TABLIST_HEADERS, "����", info, "�����ϱ�", "������");
	return 1;
}
//------------------------------------------------------------------------------
public AutoSaveTimer()
{
	if (AutoSave == true)
	{
		for (new i; i < GetMaxPlayers(); i++)
		{
		    if (IsPlayerConnected(i))
		    {
		        if (Logined[i] == true)
		        {
		            SavePlayer(i);
		        }
		    }
		}
	}
}

public LevelUpTimer()
{
	for (new i; i < GetMaxPlayers(); i++)
	{
	    if (IsPlayerConnected(i))
	    {
	        if (Logined[i] == true)
	        {
	            new expneed = 100 + ((300 * (PlayerInfo[i][pLevel] - 1)));
	            if (PlayerInfo[i][pEXP] >= expneed)
	            {
					PlayerInfo[i][pLevel] ++;
					PlayerInfo[i][pEXP] -= expneed;
					SendClientMessage(i, -1, "���� ��!");
	            }
	        }
	    }
	}
}

public s0beit(playerid)
{
    new Float:x, Float:y, Float:z;
	GetPlayerCameraFrontVector(playerid, x, y, z);
	#pragma unused x
	#pragma unused y
	new bool:detected = false;
	if (z < -0.7)
	{
	    detected = true;
	}
	else
	{
	    detected = false;
	}
	if (detected == true) // detected
	{
	    SendClientMessage(playerid, -1, "s0beit detected.");
	    s0beit_Passed[playerid] = 1;
	}
	else if (detected == false) // not detected
	{
	    SendClientMessage(playerid, -1, "s0beit not detected.");
	    s0beit_Passed[playerid] = 2;
	}
	SpawnPlayer(playerid);
}
//------------------------------------------------------------------------------
main()
{
	print(" ");
}
//------------------------------------------------------------------------------
public OnGameModeInit()
{
	SetGameModeText("MMORPG TEST");
	ShowPlayerMarkers(1);
	ShowNameTags(0);
	AutoSave = false;
	for (new a; a < MAX_ACTORS; a++)
	{
		if (ActorInfo[a][aModel] > 0)
		{
		    CreateActor(ActorInfo[a][aModel], ActorInfo[a][aPos][0], ActorInfo[a][aPos][1], ActorInfo[a][aPos][2], ActorInfo[a][aPos][3]);
		    new actortag[64]; format(actortag, 64, "%s\n%s", ActorInfo[a][aName], ActorInfo[a][aSub]);
	        ActorTag[a] = Create3DTextLabel(actortag, -1, ActorInfo[a][aPos][0], ActorInfo[a][aPos][1], ActorInfo[a][aPos][2] + 1.5000, 20.0000, 0, 0);
	        SetActorInvulnerable(a, true);
        }
	}
	SetTimer("AutoSaveTimer", 30000, 1);
	SetTimer("LevelUpTimer", 1000, 1);
	return 1;
}


public OnPlayerConnect(playerid)
{
	strmid(PlayerInfo[playerid][pPassword], "", 0, 24, 24);
	PlayerInfo[playerid][pTutorial] = 0;
	PlayerInfo[playerid][pLevel] = 1;
	PlayerInfo[playerid][pEXP] = 0;
	strmid(PlayerInfo[playerid][pNickname], "None", 0, 24, 24);
	PlayerInfo[playerid][pAdminLevel] = 0;
	PlayerInfo[playerid][pPos][0] = 0.0000;
	PlayerInfo[playerid][pPos][1] = 0.0000;
	PlayerInfo[playerid][pPos][2] = 0.0000;
	PlayerInfo[playerid][pPos][3] = 0.0000;
	PlayerInfo[playerid][pInterior] = 0;
	PlayerInfo[playerid][pWorld] = 0;
	PlayerInfo[playerid][pJob] = 0;
	for (new i; i < MAX_PLAYER_INVENTORIES; i++)
	{
	    PlayerInventoryInfo[playerid][i][piItemID] = -1;
	    PlayerInventoryInfo[playerid][i][piItemAmount] = -1;
	}
	for (new i; i < 19; i++)
	{
	    PlayerEquipmentInfo[playerid][i][peItemID] = -1;
	}

	Account[playerid] = false;
	Logined[playerid] = false;
	s0beit_Passed[playerid] = 0;

	PlayerLabel[playerid] = Create3DTextLabel(" ", 0xFFFFFFFF, 0.0000, 0.0000, 0.0000, 15.0000, 0, 0);

	new playername[MAX_PLAYER_NAME];
	GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
	new file[256];
	format(file, 256, "Userfiles/%s.ini", playername);
	if (INI_Exist(file))
	    Account[playerid] = true;
	else
		Account[playerid] = false;
	
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	Delete3DTextLabel(PlayerLabel[playerid]);
	PlayerLabel[playerid] = Text3D:INVALID_3DTEXT_ID;
	if (Logined[playerid] == true)
	{
	    SavePlayer(playerid);
	}
	return 1;
}

public OnPlayerSpawn(playerid)
{
	SetCameraBehindPlayer(playerid);
	if (s0beit_Passed[playerid] == 0)
	{
	    TogglePlayerControllable(playerid, 0);
	    SetTimerEx("s0beit", 5000, 0, "i", playerid);
	}
	else if (s0beit_Passed[playerid] == 1)
	{
	    TogglePlayerControllable(playerid, 1);
	    Kick(playerid);
	}
	else if (s0beit_Passed[playerid] == 2)
	{
	    if (PlayerInfo[playerid][pTutorial] == 0)
	    {
	        TogglePlayerControllable(playerid, 0);
	        ShowPlayerDialog(
				playerid,
				DIALOG_SET_NICKNAME,
				DIALOG_STYLE_INPUT,
				"�г��� ����",
				"\
					����� �г����� �Է����ּ���.\n\
					����, �ѱ�, Ư������ �� ��� ����� �� �ֽ��ϴ�.\
				",
				"Ȯ��",
				""
			);
	    }
	    else
		{
		    TogglePlayerControllable(playerid, 1);
		    if (PlayerInfo[playerid][pPos][0] == 0.0000 &&
		        PlayerInfo[playerid][pPos][1] == 0.0000 &&
		        PlayerInfo[playerid][pPos][2] == 0.0000 &&
		        PlayerInfo[playerid][pPos][3] == 0.0000)
			{
		    	SetPlayerPos(playerid, 1777.6136, -1774.3833, 52.4688);
		    	SetPlayerFacingAngle(playerid, 0.0000);
		    	SetPlayerInterior(playerid, 0);
		    	SetPlayerVirtualWorld(playerid, 0);
		    }
		    else
		    {
		        SetPlayerPos(
		            playerid,
		            PlayerInfo[playerid][pPos][0],
		            PlayerInfo[playerid][pPos][1],
		            PlayerInfo[playerid][pPos][2]
				);
				SetPlayerFacingAngle(
				    playerid,
				    PlayerInfo[playerid][pPos][3]
				);
		    	SetPlayerInterior(playerid, PlayerInfo[playerid][pInterior]);
		    	SetPlayerVirtualWorld(playerid, PlayerInfo[playerid][pWorld]);
		    }
	    }
	}
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	if (Logined[playerid] == false)
	{
	    SendClientMessage(playerid, -1, "�α����� ���� �ؾ��մϴ�.");
	    return 0;
	}
	new str[1024];
	format(str, 1024, "[��ȭ] %s: %s", PlayerInfo[playerid][pNickname], text);
	new Float:X,
	    Float:Y,
	    Float:Z;
	GetPlayerPos(playerid, X, Y, Z);
	SendCloseMessage(X, Y, Z, 15.0000, -1, str);
	/*
 	for (new i; i < GetMaxPlayers(); i++)
	{
	    if (Logined[i] == true)
	    {
			if (IsPlayerInRangeOfPoint(i, 15.0000, X, Y, Z))
			{
				SendClientMessage(i, -1, str);
			}
	    }
	}
	*/
	return 0;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	new cmd[256], tmp[256], idx;
	new str[1024];
	cmd = strtok(cmdtext, idx);
	if (Logined[playerid] == false)
	{
	    return SendClientMessage(playerid, -1, "�α����� ���� �ؾ��մϴ�.");
	}
	if (strcmp(cmd, "/�������Ӹ�", true) == 0)
	{
		if (!IsPlayerAdmin(playerid))
		{
		    SendClientMessage(playerid, -1, "���� ����");
		    return 1;
		}
	
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
		    SendClientMessage(playerid, -1, "/�������Ӹ� [�÷��̾� ��ȣ] [����]");
		    return 1;
		}
		new targetid = strval(tmp);
		if (!IsPlayerConnected(targetid))
		{
		    SendClientMessage(playerid, -1, "��������");
		    return 1;
		}
		
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
		    SendClientMessage(playerid, -1, "/�������Ӹ� [�÷��̾� ��ȣ] [����]");
		    return 1;
		}
		new level = strval(tmp);
		if (level < 0)
		{
		    SendClientMessage(playerid, -1, "0 �̻�");
		    return 1;
		}

		PlayerInfo[targetid][pAdminLevel] = level;
		SavePlayer(targetid);
		format(str, 1024, "����� %s(��)�� �����ڷ� ��������ϴ�.", PlayerName(targetid));
		SendClientMessage(playerid, -1, str);
		format(str, 1024, "����� %s�� ���� �����ڰ� �Ǿ����ϴ�.", PlayerName(playerid));
		SendClientMessage(targetid, -1, str);
		return 1;
	}
	if (strcmp(cmd, "/����", true) == 0)
	{
		SendRconCommand("gmx");
		return 1;
	}
	if (strcmp(cmd, "/������", true) == 0)
	{
		ShowStats(playerid);
	    return 1;
	}
	if (strcmp(cmd, "/�κ��丮", true) == 0)
	{
		ShowInventoryForPlayer(playerid, playerid);
	    return 1;
	}
	if (strcmp(cmd, "/���ͷ�", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
		    SendClientMessage(playerid, -1, "/���ͷ� [���� ��ȣ]");
		    return 1;
		}
		new actorid = strval(tmp);
		if (IsValidActor(actorid))
		{
		    new Float:X,
		        Float:Y,
		        Float:Z;
			GetActorPos(actorid, X, Y, Z);
			SetPlayerPos(playerid, X + 1, Y + 1, Z);
			return 1;
		}
		else
		{
		    return 1;
		}
	}
	if (strcmp("/�ڵ�����", cmdtext, true) == 0)
	{
		if (PlayerInfo[playerid][pAdminLevel] == 2)
		{
		    if (AutoSave == false)
			{
				AutoSave = true;
				SendClientMessage(playerid, -1, "�ڵ� ���� On");
			}
			else
			{
			    AutoSave = false;
			    SendClientMessage(playerid, -1, "�ڵ� ���� Off");
			}
			return 1;
		}
		SendClientMessage(playerid, -1, "������ �����ϴ�.");
		return 1;
	}
	if (strcmp(cmd, "/��ȯ", true) == 0)
	{
	    if (PlayerInfo[playerid][pAdminLevel] > 0)
	    {
			tmp = strtok(cmdtext, idx);
			if (!strlen(tmp))
			{
			    SendClientMessage(playerid, -1, "/��ȯ [�÷��̾� ��ȣ]");
			    return 1;
			}
			new targetid = strval(tmp);
			if (!IsPlayerConnected(targetid))
			{
			    SendClientMessage(playerid, -1, "���������Դϴ�.");
			    return 1;
			}
			if (targetid == playerid)
			{
			    SendClientMessage(playerid, -1, "�ڱ� �ڽ��� ��ȯ�� �� �����ϴ�.");
			    return 1;
			}
		    format(str, 1024, "����� %s(��)�� ��ȯ�߽��ϴ�.", PlayerName(targetid));
		    SendClientMessage(playerid, -1, str);
		    format(str, 1024, "������ %s(��)�� ����� ��ȯ�߽��ϴ�.", PlayerName(playerid));
		    SendClientMessage(targetid, -1, str);
		    new Float:X,
		        Float:Y,
		        Float:Z,
				Float:Angle;
			GetPlayerFrontPos(playerid, 1.0000, X, Y, Z);
			GetPlayerFacingAngle(playerid, Angle);
			SetPlayerPos(targetid, X, Y, Z);
			SetPlayerFacingAngle(targetid, Angle - 180.0000);
			SetPlayerInterior(targetid, GetPlayerInterior(playerid));
			SetPlayerVirtualWorld(targetid, GetPlayerVirtualWorld(playerid));
		    return 1;
	    }
	}
	if (strcmp(cmd, "/ű", true) == 0)
	{
	    if (PlayerInfo[playerid][pAdminLevel] > 0)
	    {
			tmp = strtok(cmdtext, idx);
			if (!strlen(tmp))
			{
			    SendClientMessage(playerid, -1, "/ű [�÷��̾� ��ȣ]");
			    return 1;
			}
			new targetid = strval(tmp);
			if (IsPlayerConnected(targetid))
			{
			    format(str, 1024, "����� %s(��)�� ű�߽��ϴ�.", PlayerName(targetid));
			    SendClientMessage(playerid, -1, str);
			    format(str, 1024, "����� %s�� ���� ű���߽��ϴ�.", PlayerName(playerid));
			    SendClientMessage(targetid, -1, str);
				format(str, 1024, "%s kicked %s.", PlayerName(playerid), PlayerName(targetid));
				KickLog(str);
				Kick(targetid);
			    return 1;
			}
	    }
	}
	if (strcmp(cmd, "/��", true) == 0)
	{
	    if (PlayerInfo[playerid][pAdminLevel] == 2)
	    {
			tmp = strtok(cmdtext, idx);
			if (!strlen(tmp))
			{
			    SendClientMessage(playerid, -1, "/�� [�÷��̾� ��ȣ]");
			    return 1;
			}
			new targetid = strval(tmp);
			if (IsPlayerConnected(targetid))
			{
			    format(str, 1024, "����� %s(��)�� ���߽��ϴ�.", PlayerName(targetid));
			    SendClientMessage(playerid, -1, str);
			    format(str, 1024, "����� %s�� ���� ����߽��ϴ�.", PlayerName(playerid));
			    SendClientMessage(targetid, -1, str);
				format(str, 1024, "%s baned %s.", PlayerName(playerid), PlayerName(targetid));
				BanLog(str);
				Ban(targetid);
			    return 1;
			}
	    }
	}
	if (strcmp(cmd, "/�г��Ӻ���", true) == 0)
	{
	    if (PlayerInfo[playerid][pAdminLevel] > 0)
	    {
			tmp = strtok(cmdtext, idx);
			if (!strlen(tmp))
			{
			    SendClientMessage(playerid, -1, "/�г��Ӻ��� [�÷��̾� ��ȣ] [�г���]");
			    return 1;
			}
			new targetid = strval(tmp);
			if (!IsPlayerConnected(targetid))
			{
			    SendClientMessage(playerid, -1, "��������");
			    return 1;
			}

			tmp = strtok(cmdtext, idx);
			if (!strlen(tmp))
			{
			    SendClientMessage(playerid, -1, "/�г��Ӻ��� [�÷��̾� ��ȣ] [�г���]");
				return 1;
			}
			if (strlen(tmp) > MAX_PLAYER_NAME)
			{
			    SendClientMessage(playerid, -1, "�ʹ� �� �г���");
			    return 1;
			}
			new old_nick_file[256];
			format(old_nick_file, 256, "UserNickName/%s.ini", PlayerInfo[targetid][pNickname]);
	        new new_nick_file[256];
	        format(new_nick_file, 256, "UserNickName/%s.ini", tmp);
	        if (!INI_Exist(new_nick_file))
	        {

				strmid(PlayerInfo[targetid][pNickname], tmp, 0, 24, 24);
				SavePlayer(targetid);

				fremove(old_nick_file);

	            INI_Open(new_nick_file, Write);
	            INI_Close();

			    format(str, 1024, "����� %s�� �г����� %s(��)�� �ٲپ����ϴ�.", PlayerName(targetid), tmp);
			    SendClientMessage(playerid, -1, str);
			    format(str, 1024, "����� ������ %s�� ���� �г����� %s(��)�� �ٲ�����ϴ�.", PlayerName(playerid), tmp);
			    SendClientMessage(targetid, -1, str);

				return 1;
			}
			else
			{
			    // �̹� �ִ� �г���
			    return 1;
			}
		}
	}
	if (strcmp(cmd, "/��������", true) == 0)
	{
	    if (PlayerInfo[playerid][pAdminLevel] > 0)
	    {
			tmp = strtok(cmdtext, idx);
			if (!strlen(tmp))
			{
			    SendClientMessage(playerid, -1, "/�������� [�÷��̾� ��ȣ] [���� ��ȣ]");
			    return 1;
			}
			new targetid = strval(tmp);
			if (!IsPlayerConnected(targetid))
			{
			    SendClientMessage(playerid, -1, "��������");
			    return 1;
			}

			tmp = strtok(cmdtext, idx);
			if (!strlen(tmp))
			{
			    SendClientMessage(playerid, -1, "/�������� [�÷��̾� ��ȣ] [���� ��ȣ]");
				return 1;
			}
			new jobid = strval(tmp);
			if (jobid < 0)
			{
			    SendClientMessage(playerid, -1, "0 �̻�");
			    return 1;
			}

			PlayerInfo[targetid][pJob] = jobid;
			SavePlayer(targetid);

		    format(str, 1024, "����� %s�� ������ %s(��)�� �ٲپ����ϴ�.", PlayerName(targetid), GetJobName(jobid));
		    SendClientMessage(playerid, -1, str);
		    format(str, 1024, "����� ������ %s�� ���� ������ %s(��)�� �ٲ�����ϴ�.", PlayerName(playerid), GetJobName(jobid));
		    SendClientMessage(targetid, -1, str);

			return 1;
		}
	}
	if (strcmp(cmd, "/��������", true) == 0)
	{
	    if (PlayerInfo[playerid][pAdminLevel] > 0)
	    {
			tmp = strtok(cmdtext, idx);
			if (!strlen(tmp))
			{
			    SendClientMessage(playerid, -1, "/�������� [�÷��̾� ��ȣ] [����ġ]");
			    return 1;
			}
			new targetid = strval(tmp);
			if (!IsPlayerConnected(targetid))
			{
			    SendClientMessage(playerid, -1, "��������");
			    return 1;
			}

			tmp = strtok(cmdtext, idx);
			if (!strlen(tmp))
			{
			    SendClientMessage(playerid, -1, "/�������� [�÷��̾� ��ȣ] [����ġ]");
				return 1;
			}
			new level = strval(tmp);
			if (level < 1)
			{
			    SendClientMessage(playerid, -1, "1 �̻�");
			    return 1;
			}

			PlayerInfo[targetid][pLevel] = level;
			SavePlayer(targetid);

		    format(str, 1024, "����� %s�� ������ %d(��)�� �ٲپ����ϴ�.", PlayerName(targetid), level);
		    SendClientMessage(playerid, -1, str);
		    format(str, 1024, "����� ������ %s�� ���� ������ %d(��)�� �ٲ�����ϴ�.", PlayerName(playerid), level);
		    SendClientMessage(targetid, -1, str);
			
			return 1;
		}
	}
	if (strcmp(cmd, "/���ֱ�", true) == 0)
	{
	    if (PlayerInfo[playerid][pAdminLevel] > 0)
	    {
			tmp = strtok(cmdtext, idx);
			if (!strlen(tmp))
			{
			    SendClientMessage(playerid, -1, "/���ֱ� [�÷��̾� ��ȣ] [��]");
			    return 1;
			}
			new targetid = strval(tmp);
			if (!IsPlayerConnected(targetid))
			{
			    SendClientMessage(playerid, -1, "��������");
			    return 1;
			}

			tmp = strtok(cmdtext, idx);
			if (!strlen(tmp))
			{
			    SendClientMessage(playerid, -1, "/���ֱ� [�÷��̾� ��ȣ] [��]");
				return 1;
			}
			new money = strval(tmp);
			if (money < 1)
			{
			    SendClientMessage(playerid, -1, "1 �̻�");
			    return 1;
			}

			GivePlayerMoney(targetid, money);
			SavePlayer(targetid);

			return 1;
		}
	}
	if (strcmp(cmd, "/����ġ����", true) == 0)
	{
	    if (PlayerInfo[playerid][pAdminLevel] > 0)
	    {
			tmp = strtok(cmdtext, idx);
			if (!strlen(tmp))
			{
			    SendClientMessage(playerid, -1, "/����ġ���� [�÷��̾� ��ȣ] [����ġ]");
			    return 1;
			}
			new targetid = strval(tmp);
			if (!IsPlayerConnected(targetid))
			{
			    SendClientMessage(playerid, -1, "��������");
			    return 1;
			}

			tmp = strtok(cmdtext, idx);
			if (!strlen(tmp))
			{
			    SendClientMessage(playerid, -1, "/����ġ���� [�÷��̾� ��ȣ] [����ġ]");
				return 1;
			}
			new exp = strval(tmp);
			if (exp < 0)
			{
			    SendClientMessage(playerid, -1, "0 �̻�");
			    return 1;
			}

			PlayerInfo[targetid][pEXP] = exp;
			SavePlayer(targetid);

		    format(str, 1024, "����� %s�� ����ġ�� %d(��)�� �ٲپ����ϴ�.", PlayerName(targetid), exp);
		    SendClientMessage(playerid, -1, str);
		    format(str, 1024, "����� ������ %s�� ���� ����ġ�� %d(��)�� �ٲ�����ϴ�.", PlayerName(playerid), exp);
		    SendClientMessage(targetid, -1, str);

			return 1;
		}
	}
	if (strcmp(cmd, "/ü��", true) == 0)
	{
	    if (PlayerInfo[playerid][pAdminLevel] > 0)
	    {
			tmp = strtok(cmdtext, idx);
			if (!strlen(tmp))
			{
			    SendClientMessage(playerid, -1, "/ü�� [�÷��̾� ��ȣ] [ü��]");
			    return 1;
			}
			new targetid = strval(tmp);
			if (!IsPlayerConnected(targetid))
			{
			    SendClientMessage(playerid, -1, "��������");
			    return 1;
			}

			tmp = strtok(cmdtext, idx);
			if (!strlen(tmp))
			{
			    SendClientMessage(playerid, -1, "/ü�� [�÷��̾� ��ȣ] [ü��]");
				return 1;
			}
			new Float:health = floatstr(tmp);
			if (health < 0.0)
			{
			    SendClientMessage(playerid, -1, "0 �̻�");
			    return 1;
			}

			SetPlayerHealth(targetid, health);

		    format(str, 1024, "����� %s�� ü���� %.1f(��)�� �ٲپ����ϴ�.", PlayerName(targetid), health);
		    SendClientMessage(playerid, -1, str);
		    format(str, 1024, "������ %s(��)�� ����� ü���� %.1f(��)�� �ٲپ����ϴ�.", PlayerName(playerid), health);
		    SendClientMessage(targetid, -1, str);

			return 1;
		}
	}
	if (strcmp(cmd, "/����", true) == 0)
	{
		SavePlayer(playerid);
		SavePlayerInventories(playerid);
		SavePlayerEquipments(playerid);
		SendClientMessage(playerid, -1, "����Ǿ����ϴ�.");
	    return 1;
	}
	if (strcmp(cmd, "/�޴�", true) == 0)
	{
	    ShowMenu(playerid);
	    return 1;
	}
	format(str, 1024, "[�˸�] \"%s\"��� ��ɾ�� �������� �ʽ��ϴ�.", cmdtext);
	return SendClientMessage(playerid, -1, str);
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	if (Logined[playerid] == false)
	{
	    if (Account[playerid] == true)
		    ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Login", "Enter your password.", "OK", "Cancel");
		else
		    ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "Register", "Enter your password.", "OK", "Cancel");
	}
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if (Logined[playerid] == false)
	{
	    return 1;
	}
	if (newkeys == KEY_YES)
	{
	    ShowMenu(playerid);
	    return 1;
	}
	if (newkeys == KEY_SECONDARY_ATTACK)
	{
	    new actor_index = GetCloseActorID(playerid);
	    if (actor_index != -1)
	    {
	        SetCameraBehindPlayer(playerid);
	        TalkingActor[playerid] = actor_index;
	        new
				Float:X,
				Float:Y,
				Float:Z;
			GetPlayerPos(playerid, X, Y, Z);
	        SetActorLookAt(actor_index, X, Y);
	        new caption[64]; format(caption, 64, "%s(��)���� ��ȭ", ActorInfo[actor_index][aName]);
	        new string[1024]; format(string, 1024, "[��ȭ] %s: ", ActorInfo[actor_index][aName]);
	        switch (actor_index)
	        {
				case 0: // �ٸ���
				{
					strcat(string, "���� ã�� ������ ����?");
					SendClientMessage(playerid, -1, string);
				    ShowPlayerDialog(playerid, DIALOG_SCRIPT_1, DIALOG_STYLE_LIST, caption, "��Ű� �� ���� �־��.\n�� ����� ã�� �ʾҾ��.", "����", "������");
				}
				case 1: // ���
				{
					strcat(string, "�̺�, �����!");
					SendClientMessage(playerid, -1, string);
				    ShowPlayerDialog(playerid, DIALOG_SCRIPT_4, DIALOG_STYLE_LIST, caption, "�����ض�.\n(�����Ѵ�.)", "����", "������");
				}
				case 2: // ����
				{
					strcat(string, "������ ���͵帱���?");
					SendClientMessage(playerid, -1, string);
				    ShowPlayerDialog(playerid, DIALOG_SCRIPT_5, DIALOG_STYLE_LIST, caption, "â�� �̿��Ϸ�����.\n�ƹ� �ϵ� �ƴմϴ�.", "����", "������");
				}
				case 3: // �轼
				{
					strcat(string, "������ ���͵帱���?");
					SendClientMessage(playerid, -1, string);
				    ShowPlayerDialog(playerid, DIALOG_SCRIPT_6, DIALOG_STYLE_LIST, caption, "���� ġ�ᰡ �ʿ��ؿ�.\n�ƹ� �ϵ� �ƴմϴ�.", "����", "������");
				}
				case 4: // ȣ��
				{
					strcat(string, "������ ���͵帱���?");
					SendClientMessage(playerid, -1, string);
				    ShowPlayerDialog(playerid, DIALOG_SCRIPT_7, DIALOG_STYLE_LIST, caption, "�� �Ȱ� ����� �� �� �������?.\n�ƹ� �ϵ� �ƴմϴ�.", "����", "������");
				}
				case 5: // ȫ��
				{
					strcat(string, "������ ���͵帱���?");
					SendClientMessage(playerid, -1, string);
				    ShowPlayerDialog(playerid, DIALOG_SCRIPT_8, DIALOG_STYLE_LIST, caption, "�� �Ȱ� ����� �� �� �������?.\n�ƹ� �ϵ� �ƴմϴ�.", "����", "������");
				}
				default:
				{
				    TalkingActor[playerid] = -1;
				}
			}
	    }
	}
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	if (Logined[playerid] == false)
	{
	    return 1;
	}
	if (s0beit_Passed[playerid] != 2)
	{
	    return 1;
	}
	new str[1024];
    format(str, 128, "%s", PlayerInfo[playerid][pNickname]);
	Update3DTextLabelText(PlayerLabel[playerid], -1, str);
	Attach3DTextLabelToPlayer(PlayerLabel[playerid], playerid, 0, 0, 0.3);
	if (GetPlayerWeapon(playerid) != PlayerEquipedWeapon[playerid])
	{
		ResetPlayerWeapons(playerid);
		GivePlayerWeapon(playerid, PlayerEquipedWeapon[playerid], 99999);
	}
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
//------------------------------------------------------------------------------
	if (dialogid == DIALOG_REGISTER)
	{
	    if (response)
	    {
		    if (!strlen(inputtext))
		    {
		        ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "����", "�н����带 �Է����ּ���.", "OK", "Cancel");
		        return 1;
		    }
		    else if (strlen(inputtext) < 4 || strlen(inputtext) > 24)
		    {
		        ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "����", "�н����带 �Է����ּ���.", "OK", "Cancel");
		        return 1;
			}
		    else
		    {
		        new playername[MAX_PLAYER_NAME];
				GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
				new file[256];
				format(file, 256, "Userfiles/%s.ini", playername);
				if (!INI_Exist(file))
				{
				    RegisterPlayer(playerid, inputtext);
				    ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "�α���", "�н����带 �Է����ּ���.", "OK", "Cancel");
				    return 1;
				}
				else
				{
				    ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "�α���", "�н����带 �Է����ּ���.", "OK", "Cancel");
				    return 1;
				}
		    }
	    }
	    else
	    {
	        ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "����", "�н����带 �Է����ּ���.", "OK", "Cancel");
			return 1;
	    }
	}
	if (dialogid == DIALOG_LOGIN)
	{
	    if (response)
	    {
		    if (!strlen(inputtext))
		    {
		        ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "�α���", "�н����带 �Է����ּ���.", "OK", "Cancel");
		        return 1;
		    }
		    else
		    {
		        new playername[MAX_PLAYER_NAME];
				GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
				new file[256];
				format(file, 256, "Userfiles/%s.ini", playername);
				if (INI_Exist(file))
				{
				    INI_Open(file, Read);
		        	if (strcmp(inputtext, INI_Read("Password"), true) == 0)
		        	{
		        	    Logined[playerid] = true;
		        	    LoadPlayer(playerid);
		        	    LoadPlayerInventories(playerid);
		        	    LoadPlayerEquipments(playerid);
		        	    SetSpawnInfo(playerid, 0, 0, 0.0000, 0.0000, 0.0000, 0.0000, 0, 0, 0, 0, 0, 0);
		        	    SpawnPlayer(playerid);
		        	    SetPlayerColor(playerid, 0xFFFFFFFF);
		        	}
		        	else
		        	{
	                    ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "�α���", "�н����带 �Է����ּ���.", "OK", "Cancel");
		        	}
		        	INI_Close();
		        	return 1;
				}
				else
				{
				    ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "����", "�н����带 �Է����ּ���.", "OK", "Cancel");
				    return 1;
				}
			}
		}
	}
	if (dialogid == DIALOG_SET_NICKNAME)
	{
		if (response)
		{
		    if (!strlen(inputtext))
		    {
		        ShowPlayerDialog(
					playerid,
					DIALOG_SET_NICKNAME,
					DIALOG_STYLE_INPUT,
					"�г��� ����",
					"\
						����� �г����� �Է����ּ���.\n\
						����, �ѱ�, Ư������ �� ��� ����� �� �ֽ��ϴ�.\
					",
					"Ȯ��",
					""
				);
		        return 1;
		    }
		    else
		    {
		        new file[256];
		        format(file, 256, "UserNickName/%s.ini", inputtext);
		        if (!INI_Exist(file))
		        {
		            INI_Open(file, Write);
		            INI_Close();
					strmid(PlayerInfo[playerid][pNickname], inputtext, 0, 24, 24);
					PlayerInfo[playerid][pTutorial] = 1;
					SpawnPlayer(playerid);
					SavePlayer(playerid);
		        }
				else
				{
				    ShowPlayerDialog(
						playerid,
						DIALOG_SET_NICKNAME,
						DIALOG_STYLE_INPUT,
						"�г��� ����",
						"\
							����� �г����� �Է����ּ���.\n\
							����, �ѱ�, Ư������ �� ��� ����� �� �ֽ��ϴ�.\n\
							�̹� �����ϴ� �г����Դϴ�.\
						",
						"Ȯ��",
						""
					);
				}
		    }
		}
		else
		{
	        ShowPlayerDialog(
				playerid,
				DIALOG_SET_NICKNAME,
				DIALOG_STYLE_INPUT,
				"�г��� ����",
				"\
					����� �г����� �Է����ּ���.\n\
					����, �ѱ�, Ư������ �� ��� ����� �� �ֽ��ϴ�.\
				",
				"Ȯ��",
				""
			);
		    return 1;
		}
	}
//------------------------------------------------------------------------------
	if (dialogid == DIALOG_MENU)
	{
	    if (response)
	    {
	        if (listitem == 0)
	        {
	            ShowStats(playerid);
	        }
	        else if (listitem == 1)
	        {
	            ShowInventoryForPlayer(playerid, playerid);
	        }
	        else if (listitem == 2)
	        {
	            ShowEquipments(playerid);
	        }
	    }
     	return 1;
	}
	if (dialogid == DIALOG_STATS)
	{
	    if (response)
	    {
	        return 1;
	    }
	    else
	    {
	        return 1;
	    }
	}
	if (dialogid == DIALOG_SELLLIST)
	{
		if (response)
		{
			new tmp[256], string[256];
            format(tmp, 256, "BuyItemListID_%d", listitem);
            new itemid = GetPVarInt(playerid, tmp);
            for (new j; j < sizeof(ItemInfo); j++)
            {
				format(tmp, 256, "BuyItemListID_%d", j);
				DeletePVar(playerid, tmp);
            }
            if (GetPlayerMoney(playerid) >= ItemInfo[itemid][itPrice])
            {
				GivePlayerItem(playerid, itemid, 1);
				GivePlayerMoney(playerid, - ItemInfo[itemid][itPrice]);
				SavePlayerInventories(playerid);
			    format(string, 256, "[�˸�] ����� ������ %s(��)�� $%d�� �������� �����߽��ϴ�.", ItemInfo[itemid][itName], ItemInfo[itemid][itPrice]);
				SendClientMessage(playerid, -1, string);
			}
			else
			{
			    format(string, 256, "[�˸�] ������ %s(��)�� ������ ���� �����ϴ�.", ItemInfo[itemid][itName]);
				SendClientMessage(playerid, -1, string);
			}
			ShowSellList(playerid, BuyingItemType[playerid]);
			return 1;
		}
		else
		{
		    BuyingItemType[playerid] = ITEM_TYPE_NONE;
			return 1;
		}
	}
	if (dialogid == DIALOG_INVENTORY)
	{
		if (response)
		{
			new tmp[256];
            format(tmp, 256, "InventoryListID_%d", listitem);
            new pi_index = GetPVarInt(playerid, tmp);
            for (new j; j < MAX_PLAYER_INVENTORIES; j++)
            {
				format(tmp, 256, "InventoryListID_%d", j);
				DeletePVar(playerid, tmp);
            }
			new itemid = PlayerInventoryInfo[playerid][pi_index][piItemID];
			if (itemid == -1)
			{
			    SendClientMessage(playerid, -1, "�������� �����ϴ�!");
			}
			else
			{
				if (ItemInfo[itemid][itType] == ITEM_TYPE_CONSUME)
				{
				    if (PlayerInventoryInfo[playerid][pi_index][piItemAmount] > 0)
				    {
					    PlayerInventoryInfo[playerid][pi_index][piItemAmount] --;
					    SendClientMessage(playerid, -1, "�������� ����Ͽ����ϴ�!");
				    }
					if (PlayerInventoryInfo[playerid][pi_index][piItemAmount] == 0)
					{
					    PlayerInventoryInfo[playerid][pi_index][piItemID] = -1;
					    SendClientMessage(playerid, -1, "�������� ��� ����Ͽ����ϴ�!");
					}
					//----------------------------------------------------------
					if (itemid == 0)
					{
						new Float:health;
						GetPlayerHealth(playerid, health);
						health += 10;
						SetPlayerHealth(playerid, health);
					}
					else if (itemid == 1)
					{
						new Float:health;
						GetPlayerHealth(playerid, health);
						health += 30;
						SetPlayerHealth(playerid, health);
					}
					else if (itemid == 3)
					{
						new Float:health;
						GetPlayerHealth(playerid, health);
						health += 50;
						SetPlayerHealth(playerid, health);
					}
					//----------------------------------------------------------
				}
				else if (ItemInfo[itemid][itType] == ITEM_TYPE_EQUIPMENT)
				{
					new boneid = -1;
					/*
					boneid
						0 ����
						1 ~ 18 ��
					*/
					switch (itemid)
					{
						case 2: boneid = 0;
						case 4: boneid = 0;
					}
				    if (PlayerEquipmentInfo[playerid][boneid][peItemID] != -1)
				    {
				        SendClientMessage(playerid, -1, "�̹� �� ���� ��� �����ϰ� �ֽ��ϴ�.");
				    }
				    else
				    {
					    if (PlayerInventoryInfo[playerid][pi_index][piItemAmount] > 0)
					    {
						    PlayerInventoryInfo[playerid][pi_index][piItemAmount] --;
						    SendClientMessage(playerid, -1, "��� �����Ͽ����ϴ�!");
					    }
						if (PlayerInventoryInfo[playerid][pi_index][piItemAmount] == 0)
						{
						    PlayerInventoryInfo[playerid][pi_index][piItemID] = -1;
						}
						PlayerEquipmentInfo[playerid][boneid][peItemID] = itemid;
						if (boneid == 0)
						{
							switch (itemid)
							{
								case 2: PlayerEquipedWeapon[playerid] = 11;
								case 4: PlayerEquipedWeapon[playerid] = 9;
							}
						}
					}
					SavePlayerEquipments(playerid);
					//----------------------------------------------------------
				}
				else
				{
				    SendClientMessage(playerid, -1, "����� �� ���� �������Դϴ�!");
			    }
		    }
		    ShowInventoryForPlayer(playerid, playerid);
		    return 1;
		}
		else
		{
			return 1;
		}
	}
//------------------------------------------------------------------------------
	if (dialogid == DIALOG_EQUIPMENT)
	{
	    if (response)
	    {
			new boneid = listitem;
			new itemid = PlayerEquipmentInfo[playerid][boneid][peItemID];
			if (itemid == -1)
			{
				SendClientMessage(playerid, -1, "�� ���� ��� �������� �ʾҽ��ϴ�.");
			}
			else
			{
			    PlayerEquipmentInfo[playerid][boneid][peItemID] = -1;
			    if (boneid == 0)
			    {
					PlayerEquipedWeapon[playerid] = 0;
					ResetPlayerWeapons(playerid);
			    }
			    else
			    {
			    }
			    GivePlayerItem(playerid, itemid, 1);
			    SavePlayerEquipments(playerid);
			    SendClientMessage(playerid, -1, "����� ������ �����߽��ϴ�.");
			}
			ShowEquipments(playerid);
			return 1;
	    }
		else
		{
		    return 1;
		}
	}
//------------------------------------------------------------------------------
	new actor_index = TalkingActor[playerid];
    new caption[64]; format(caption, 64, "%s(��)���� ��ȭ", ActorInfo[actor_index][aName]);
    new actor_msg[1024]; format(actor_msg, 1024, "[��ȭ] %s: ", ActorInfo[actor_index][aName]);
	if (dialogid == DIALOG_SCRIPT_END)
	{
		TalkingActor[playerid] = -1;
		return 1;
	}
	//--------------------------------------------------------------------------
	// �ٸ���
	else if (dialogid == DIALOG_SCRIPT_1) // ���� ã�� ������ ����?
	{
	    if (response)
	    {
			if (listitem == 0)
	        {
	            strcat(actor_msg, "������ �ϰ��� ���� ������?");
	            SendClientMessage(playerid, -1, actor_msg);
	            ShowPlayerDialog(playerid, DIALOG_SCRIPT_2, DIALOG_STYLE_LIST, caption, "�� �ϰ� ���� ���� �ֽ��ϴ�.\n���ڽó׿�.", "����", "������");
				return 1;
	        }
	        else
	        {
		        strcat(actor_msg, "�׷� �����ؿ�.");
		        SendClientMessage(playerid, -1, actor_msg);
		        ShowPlayerDialog(playerid, DIALOG_SCRIPT_END, DIALOG_STYLE_MSGBOX, caption, "��ȭ�� �������ϴ�.", "Ȯ��", "");
		        return 1;
	        }
		}
        else
        {
	        ShowPlayerDialog(playerid, DIALOG_SCRIPT_END, DIALOG_STYLE_MSGBOX, caption, "��ȭ�� �������ϴ�.", "Ȯ��", "");
	        return 1;
        }
	}
	else if (dialogid == DIALOG_SCRIPT_2) // ������ �ϰ��� ���� ������?
	{
	    if (response)
	    {
			if (listitem == 0)
	        {
	            strcat(actor_msg, "���� ���� �ϰ� �ʹٴ� �ſ���?");
	            SendClientMessage(playerid, -1, actor_msg);
	            ShowPlayerDialog(playerid, DIALOG_SCRIPT_3, DIALOG_STYLE_LIST, caption, "���\n����� ����ģ��", "����", "������");
				return 1;
	        }
	        else
	        {
	            strcat(actor_msg, "���� �˰� �־��!");
	            SendClientMessage(playerid, -1, actor_msg);
	            ShowPlayerDialog(playerid, DIALOG_SCRIPT_END, DIALOG_STYLE_MSGBOX, caption, "��ȭ�� �������ϴ�.", "Ȯ��", "");
	            return 1;
	        }
		}
        else
        {
	        ShowPlayerDialog(playerid, DIALOG_SCRIPT_END, DIALOG_STYLE_MSGBOX, caption, "��ȭ�� �������ϴ�.", "Ȯ��", "");
	        return 1;
        }
	}
	else if (dialogid == DIALOG_SCRIPT_3) // ���� ���� �ϰ� �ʹٴ� �ſ���?
	{
	    if (response)
	    {
			if (listitem == 0) // ���
	        {
	            if (PlayerInfo[playerid][pJob] == JOB_NONE)
	            {
		            strcat(actor_msg, "��ſ��� �⺻���� �屸���� �ְھ��, ������ ���� �ϵ��� �ؿ�.");
		            SendClientMessage(playerid, -1, actor_msg);
		            ShowPlayerDialog(playerid, DIALOG_SCRIPT_END, DIALOG_STYLE_MSGBOX, caption, "��ȭ�� �������ϴ�.", "Ȯ��", "");
		            PlayerInfo[playerid][pJob] = JOB_KNIGHT;
		            SavePlayer(playerid);
					return 1;
				}
				else
				{
		            strcat(actor_msg, "����� �̹� �� ���� �־�̴±���.");
		            SendClientMessage(playerid, -1, actor_msg);
		            ShowPlayerDialog(playerid, DIALOG_SCRIPT_END, DIALOG_STYLE_MSGBOX, caption, "��ȭ�� �������ϴ�.", "Ȯ��", "");
				    return 1;
				}
	        }
	        else // ����� ����ģ��
	        {
	            strcat(actor_msg, "���! *����*");
	            SendClientMessage(playerid, -1, actor_msg);
	            ShowPlayerDialog(playerid, DIALOG_SCRIPT_END, DIALOG_STYLE_MSGBOX, caption, "��ȭ�� �������ϴ�.", "Ȯ��", "");
	            return 1;
	        }
		}
        else
        {
	        ShowPlayerDialog(playerid, DIALOG_SCRIPT_END, DIALOG_STYLE_MSGBOX, caption, "��ȭ�� �������ϴ�.", "Ȯ��", "");
	        return 1;
        }
	}
//------------------------------------------------------------------------------
	// ���
	else if (dialogid == DIALOG_SCRIPT_4) // �̺�, �����!
	{
	    if (response)
	    {
			if (listitem == 0) // �����ض�.
	        {
	            strcat(actor_msg, "�˰ڽ��ϴ�!");
	            SendClientMessage(playerid, -1, actor_msg);
	            ShowPlayerDialog(playerid, DIALOG_SCRIPT_END, DIALOG_STYLE_MSGBOX, caption, "��ȭ�� �������ϴ�.", "Ȯ��", "");
				return 1;
	        }
	        else // (�����Ѵ�.)
	        {
	            ShowPlayerDialog(playerid, DIALOG_SCRIPT_END, DIALOG_STYLE_MSGBOX, caption, "��ȭ�� �������ϴ�.", "Ȯ��", "");
	            return 1;
	        }
		}
        else
        {
	        ShowPlayerDialog(playerid, DIALOG_SCRIPT_END, DIALOG_STYLE_MSGBOX, caption, "��ȭ�� �������ϴ�.", "Ȯ��", "");
	        return 1;
        }
	}
//------------------------------------------------------------------------------
	// ����
	else if (dialogid == DIALOG_SCRIPT_5) // ������ ���͵帱���?
	{
	    if (response)
	    {
			if (listitem == 0) // â�� �̿��Ϸ�����.
	        {
	            strcat(actor_msg, "��.");
	            SendClientMessage(playerid, -1, actor_msg);
	            ShowPlayerDialog(playerid, DIALOG_SCRIPT_END, DIALOG_STYLE_MSGBOX, caption, "��ȭ�� �������ϴ�.", "Ȯ��", "");
				return 1;
	        }
	        else // �ƹ��ϵ� �ƴմϴ�.
	        {
	            strcat(actor_msg, "�ȳ���������.");
	            SendClientMessage(playerid, -1, actor_msg);
	            ShowPlayerDialog(playerid, DIALOG_SCRIPT_END, DIALOG_STYLE_MSGBOX, caption, "��ȭ�� �������ϴ�.", "Ȯ��", "");
	            return 1;
	        }
		}
        else
        {
	        ShowPlayerDialog(playerid, DIALOG_SCRIPT_END, DIALOG_STYLE_MSGBOX, caption, "��ȭ�� �������ϴ�.", "Ȯ��", "");
	        return 1;
        }
	}
//------------------------------------------------------------------------------
	// �轼
	else if (dialogid == DIALOG_SCRIPT_6) // ������ ���͵帱���?
	{
	    if (response)
	    {
			if (listitem == 0) // ���� ġ�ᰡ �ʿ��ؿ�.
	        {
	            new Float:health;
	            GetPlayerHealth(playerid, health);
				if (health == 100.0000)
				{
		            strcat(actor_msg, "����� ġ���� �ʿ䰡 ���� ���̴°ɿ�.");
		            SendClientMessage(playerid, -1, actor_msg);
		            ShowPlayerDialog(playerid, DIALOG_SCRIPT_END, DIALOG_STYLE_MSGBOX, caption, "��ȭ�� �������ϴ�.", "Ȯ��", "");
					return 1;
				}
				else
				{
				    SetPlayerHealth(playerid, 100.0000);
		            strcat(actor_msg, "ġ���ص�Ƚ��ϴ�. �ȳ���������.");
		            SendClientMessage(playerid, -1, actor_msg);
		            ShowPlayerDialog(playerid, DIALOG_SCRIPT_END, DIALOG_STYLE_MSGBOX, caption, "��ȭ�� �������ϴ�.", "Ȯ��", "");
					return 1;
				}
	        }
	        else // �ƹ� �ϵ� �ƴմϴ�.
	        {
	            strcat(actor_msg, "�ȳ���������.");
	            SendClientMessage(playerid, -1, actor_msg);
	            ShowPlayerDialog(playerid, DIALOG_SCRIPT_END, DIALOG_STYLE_MSGBOX, caption, "��ȭ�� �������ϴ�.", "Ȯ��", "");
	            return 1;
	        }
		}
        else
        {
	        ShowPlayerDialog(playerid, DIALOG_SCRIPT_END, DIALOG_STYLE_MSGBOX, caption, "��ȭ�� �������ϴ�.", "Ȯ��", "");
	        return 1;
        }
	}
//------------------------------------------------------------------------------
	// ȣ��
	else if (dialogid == DIALOG_SCRIPT_7) // ������ ���͵帱���?
	{
	    if (response)
	    {
			if (listitem == 0) // �� �Ȱ� ��Ű���?
	        {
	            strcat(actor_msg, "���캸����.");
	            SendClientMessage(playerid, -1, actor_msg);
				TalkingActor[playerid] = -1;
	            ShowSellList(playerid, ITEM_TYPE_CONSUME);
	            BuyingItemType[playerid] = ITEM_TYPE_CONSUME;
				return 1;
	        }
	        else // �ƹ� �ϵ� �ƴմϴ�.
	        {
	            strcat(actor_msg, "�ƹ��͵� �� ����� �� ���� ���� �ٷ���?");
	            SendClientMessage(playerid, -1, actor_msg);
	            ShowPlayerDialog(playerid, DIALOG_SCRIPT_END, DIALOG_STYLE_MSGBOX, caption, "��ȭ�� �������ϴ�.", "Ȯ��", "");
	            return 1;
	        }
		}
        else
        {
	        ShowPlayerDialog(playerid, DIALOG_SCRIPT_END, DIALOG_STYLE_MSGBOX, caption, "��ȭ�� �������ϴ�.", "Ȯ��", "");
	        return 1;
        }
	}
//------------------------------------------------------------------------------
	// ȫ��
	else if (dialogid == DIALOG_SCRIPT_8) // ������ ���͵帱���?
	{
	    if (response)
	    {
			if (listitem == 0) // �� �Ȱ� ��Ű���?
	        {
	            strcat(actor_msg, "���캸����.");
	            SendClientMessage(playerid, -1, actor_msg);
				TalkingActor[playerid] = -1;
	            ShowSellList(playerid, ITEM_TYPE_EQUIPMENT);
	            BuyingItemType[playerid] = ITEM_TYPE_EQUIPMENT;
				return 1;
	        }
	        else // �ƹ� �ϵ� �ƴմϴ�.
	        {
	            strcat(actor_msg, "�ƹ��͵� �� ����� �� ���� ���� �ٷ���?");
	            SendClientMessage(playerid, -1, actor_msg);
	            ShowPlayerDialog(playerid, DIALOG_SCRIPT_END, DIALOG_STYLE_MSGBOX, caption, "��ȭ�� �������ϴ�.", "Ȯ��", "");
	            return 1;
	        }
		}
        else
        {
	        ShowPlayerDialog(playerid, DIALOG_SCRIPT_END, DIALOG_STYLE_MSGBOX, caption, "��ȭ�� �������ϴ�.", "Ȯ��", "");
	        return 1;
        }
	}
//------------------------------------------------------------------------------
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}
