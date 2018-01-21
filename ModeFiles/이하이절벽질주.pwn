/*==================================================================================*/
/*                              Made By. Leehi                                      */
/*==================================================================================*/
																																												*/
#define SERVER_NAME_PASS "서버 점검 중입니다"
#define SERVER_PASSWORD ""

#define SERVER_NAME "◈이하이절벽 : 24시간 풀가동◈"
#define SERVER_WEBSITE "cafe.naver.com/leehi123/"
#define SERVER_MAPNAME "국내 5위서버"
#define SERVER_TITLE "이하이 절벽질주"
#define SERVER_MEMVER "[S]"

#define MODE_NAME "Beta 1.0ver"
#define MODE_VERSION "Client Version 1.0.133"
#define MODE_MAKER "C.L.N_Vlast"
/*SERVER_NAME|MODE_MAKER|SERVER_MAPNAME*/

#define DIALOG_1 1000
#define DIALOG_2 2000
#define DIALOG_3 3000
#define DIALOG_4 4000
#define DIALOG_5 5000
#define MSGBOX_NONE 1000000
#define COLOR_GREENYELLOW   0xADFF2FAA
#define COLOR_ORANGE		0xFF9900AA
#define COLOR_TOMATO		0xFF6347AA
#define COLOR_LIME		0x10F441AA
#define COLOR_IVORY		0xFFFF82AA
#define COLOR_lawngreen 0x7CFC00AA
#define COLOR_cyan 0x00FFFFAA
#define COLOR_LIGHTRED 0xFF0000AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_LIGHTBLUE 0x33CCFFAA
#define COLOR_LIGHTGREEN 0x24FF0AB9
#define green 0x00FF00AA
#define COLOR_GOLD		0xE3B92496
#define COLOR_RED 		0xFF000096
#define COLOR_WHITE 0xFFFFFFAA
#define AQUA 0x00FFFFAA

#define MAX_WARING 2

#define M_P 50
#define ESC_MESSAGE "ESC 상태인 유저입니다."
#define C_YELLOW 0xFFFF00FF


#include <SERVER>/*Last Load Include*/
#include <a_samp>
#include <streamer>
#include <audio>
#include <CCT>

#include <core>/*안티 Deamx*/
#include <float>

#pragma tabsize 0 /*빼면 워링 늘어나요*/

#define SPECIAL_ACTION_PISSING 68

#define speedcolor 0x008080FF




new CONSOLE_PLAYER;
new USER_PLAYER;
new a;
new b;
new door1;
new door2;
new elb;
new A;

new lock[MAX_VEHICLES];
new lockvehicle[MAX_PLAYERS];
new freezing[MAX_PLAYERS];

new bool:PlayerESC[M_P]; // ESC
new Text3D:ESCDO[M_P];
new ESC1[M_P] = 0;

new NPC_carid;



forward money();
forward carrespawn();
forward OnPlayerCommandText(playerid, cmdtext[]);
forward Speed();
forward escTimer();
forward Countdown();





new Text3D:NicknameTag[MAX_PLAYERS];

new VehicleName[212][] = {
"Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel", "Dumper", "Firetruck", "Trashmaster", "Stretch", "Manana",  /*속도계*/
"Infernus", "Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam", "Esperanto", "Taxi", "Washington", "Bobcat",
"Whoopee", "BF Injection", "Hunter", "Premier", "Enforcer", "Securicar", "Banshee", "Predator", "Bus", "Rhino", "Barracks", "Hotknife",
"Trailer 1", "Previon", "Coach", "Cabbie", "Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral", "Squalo",
"Seasparrow", "Pizzaboy", "Tram", "Trailer 2", "Turismo", "Speeder", "Reefer", "Tropic", "Flatbed", "Yankee", "Caddy", "Solair",
"Berkley's RC Van", "Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale", "Oceanic", "Sanchez", "Sparrow",
"Patriot", "Quad", "Coastguard", "Dinghy", "Hermes", "Sabre", "Rustler", "ZR-350", "Walton", "Regina", "Comet", "BMX", "Burrito",
"Camper", "Marquis", "Baggage", "Dozer", "Maverick", "News Chopper", "Rancher", "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring",
"Sandking", "Blista Compact", "Police Maverick", "Boxvillde", "Benson", "Mesa", "RC Goblin", "Hotring Racer A", "Hotring Racer B",
"Bloodring Banger", "Rancher", "Super GT", "Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropduster","Stunt",  "Tanker",
"Roadtrain", "Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra", "FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Tow Truck", "Fortune",
"Cadrona", "FBI Truck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer", "Remington", "Slamvan", "Blade", "Freight", "Streak",
"Vortex", "Vincent", "Bullet", "Clover", "Sadler", "Firetruck LA", "Hustler", "Intruder", "Primo", "Cargobob", "Tampa", "Sunrise", "Merit",
"Utility", "Nevada", "Yosemite", "Windsor", "Monster A", "Monster B", "Uranus", "Jester", "Sultan", "Stratum", "Elegy", "Raindance",
"RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito", "Freight Flat", "Streak Carriage", "Kart", "Mower", "Dune", "Sweeper", "Broadway",
"Tornado", "AT-400", "DFT-30", "Huntley", "Stafford", "BF-400", "News Van", "Tug", "Trailer 3", "Emperor", "Wayfarer", "Euros", "Hotdog",
"Club", "Freight Carriage", "Trailer 4", "Andromada", "Dodo", "RC Cam", "Launch", "Police Car (LSPD)", "Police Car (SFPD)",
"Police Car (LVPD)", "Police Ranger", "Picador", "S.W.A.T", "Alpha", "Phoenix", "Glendale", "Sadler", "Luggage Trailer A",
"Luggage Trailer B", "Stairs", "Boxville", "Tiller", "Utility Trailer" };

new
	PlayerText3D:speedo3Dtext,
	Speedoff,
	bool:OneCreateTextDraw[MAX_PLAYERS];


main()
{
    new Hours,Minutes,Seconds,Days,Months,Years;
	gettime(Hours,Minutes,Seconds);
	getdate(Years,Months,Days);
	printf("\n	━━━━━━━━━━━━━━━━━━━━\n");
	printf("	%dMonths %dDay - %d:%d",Months,Days,Hours,Minutes);
	printf("	%s - %s",MODE_NAME,MODE_VERSION);
	printf("	Make By %s",MODE_MAKER);
	printf("	Server starting Complete");
	printf("	Find Code (SC-5207R)");
	printf("\n	━━━━━━━━━━━━━━━━━━━━\n");
}


AntiDeAMX()
{
    new a[][] =
    {
        "Unarmed (Fist)",
        "Brass K"
    };
    #pragma unused a
}
																																												/*
================================================================================
																																												*/
public OnGameModeInit()
{
    /*========================================================================*/
    NoticeNumber=0; MakeByNumber=0;
    UsePlayerPedAnims(); DisableInteriorEnterExits(); AllowAdminTeleport(1);
    /*========================================================================*/
    AntiDeAMX();
    /*========================================================================*/
	SendRconCommand("rcon_password root123456789");
    /*========================================================================*/
    SetTimer("Notice",60000,true);
    SetTimer("MakeBy",240000,true);
    SetTimer("Timer",1000,true);
    SetTimer("money",60000,true);
    SetTimer("carrespawn",120000,true); // 차리스폰
    SetTimer("escTimer",1500,1);
	/*=====================================================================*/
	new string[256];
	format(string,sizeof(string),"%s",MODE_VERSION);
	SetGameModeText(string);
	format(string, sizeof(string),"hostname %s",SERVER_NAME);
	SendRconCommand(string);
	format(string, sizeof(string),"mapname %s",SERVER_MAPNAME);
	SendRconCommand(string);
	format(string, sizeof(string),"weburl %s",SERVER_WEBSITE);
	SendRconCommand(string);
	if(strlen(SERVER_PASSWORD)!=0) {
	format(string, sizeof(string),"password %s",SERVER_PASSWORD);
	SendRconCommand(string);
	format(string, sizeof(string),"hostname %s",SERVER_NAME_PASS);
	SendRconCommand(string); }
	/*========================================================================*/
	Create3DTextLabel("시작점\n즐거운게임 되세요",COLOR_3D_LED,-5507.8477,471.4926,1202.8463,50,0);
	Create3DTextLabel("점프대\n점프하시면 됩니다",COLOR_3D_LED,-3194.8533,471.8275,39.9945,60,0);
	Create3DTextLabel("점프대\n점프하시면 됩니다",COLOR_3D_LED,-3822.2449,471.7276,247.1164,60,0);
	Create3DTextLabel("해상구조대 기지",COLOR_3D_PINK,-2935.7839,566.8976,12.8403,40,0);
	TextPickup(1254,COLOR_3D_BLUE,-2903.8286,469.9194,4.9141,70,"데스매치존 육지\n규칙 - 빨간 부분 안에선 데스매치 가능 자유롭게 노세요 단, 막장 금지");
	TextPickup(1254,COLOR_3D_BLUE,2940.4067,-565.9489,7.0725,70,"비무장지대 [DMZ]\nDMZ구역 규칙 - 비무장지대 들어가기전 어드민에게 무기몰수받고 싸움금지!");
	TextPickup(1254,COLOR_3D_BLUE,3427.3469,-567.2681,7.5644,70,"비무장지대 [DMZ]\nDMZ구역 규칙 - 무기소지하거나 싸움, 차소환 할시 킥합니다.");
	TextPickup(1254,COLOR_3D_BLUE,1544.2072,-1354.3921,329.4725,176.4750,"낙하지역\n낙하 하기전 - /낙하산 으로 낙하산을 착용하시오.");
	TextPickup(1254,COLOR_3D_BLUE,2041.9293,991.5485,10.6719,93.3741,"클럽\n저쪽 안으로 들어가시오. 안에는 총괄 면상이 있을것이요.");
	TextPickup(1254,COLOR_3D_BLUE,1786.2317,-1303.4502,125.8814,64.6609,"회사 낙하\n회사낙하 - /낙하산 으로 낙하산을 착용, 낙사해도 모름");
	TextPickup(1254,COLOR_3D_BLUE,-407.2456,2547.1995,40.1889,165.2887,"크고 아름다움\n그것을 보는법 - 헬기를 이용해 더욱 자세히 보시오.");
	TextPickup(1247,COLOR_3D_BLUE,-2843.9597,425.2397,4.6638,70,"무장 센터\n이곳은 작동하지 않습니다. /무기 를 이용하세요.");
	TextPickup(1247,COLOR_3D_BLUE,2003.6899,988.3652,10.8127,172.3115,"범퍼카 하는법\n /범퍼카help 를 하시게나 동무.");
    TextPickup(1318,COLOR_3D_LED,-2915.7515,175.5923,3.3294,70,"해적 기지");
    TextPickup(1318,COLOR_3D_LED,-396.2138,1256.1169,6.9611,10,"출구");
   	TextPickup(1247,COLOR_3D_BLUE,3449.8152,-2092.6135,3.1774,354.3090,"시장님 차들입니다. 함부로 가져가지 마세요.");
   	TextPickup(1247,COLOR_3D_BLUE,3443.9236,-2101.2620,4.6298,174.6223,"시장님집 - 함부로 들어오면 곧바로 처벌");
   	TextPickup(1247,COLOR_3D_BLUE,3444.8176,-2115.0847,4.6298,275.7217,"비서의집 - 회장님과 비서만 입장가능");
   	TextPickup(1247,COLOR_3D_BLUE,3072.6875,-1972.5310,7.0138,88.7964,"이곳은 1층입니다 - 이곳은 모두가 주차할수 있습니다.");
   	TextPickup(1247,COLOR_3D_BLUE,3444.8176,-2115.0847,4.6298,275.7217,"이곳은 2층입니다 - 주민부터 주차 가능합니다.");
   	TextPickup(1247,COLOR_3D_BLUE,3071.3574,-1972.5028,32.5251,88.7964,"이곳은 3층입니다 - 공무원 부터 주차 가능합니다.");
   	TextPickup(1247,COLOR_3D_BLUE,3070.3413,-1973.2146,35.8858,88.7964,"이곳은 4층입니다 - 군부대, 경찰 탈것만 주차 가능.");
   	TextPickup(1247,COLOR_3D_BLUE,3214.3633,-2137.4663,4.2814,264.5547,"무기고 입니다 - 군인, 경찰, 시장, 비서만 입장가능");
	/*========================================================================*/
	AddPlayerClass(2,-5559.6191,471.1245,1202.8463,269.4457,0,0,0,0,0,0);
	AddPlayerClass(84,-5559.6191,471.1245,1202.8463,269.4457,0,0,0,0,0,0);
	AddPlayerClass(154,-5559.6191,471.1245,1202.8463,269.4457,0,0,0,0,0,0);
	AddPlayerClass(155,-5559.6191,471.1245,1202.8463,269.4457,0,0,0,0,0,0);
	AddPlayerClass(271,-5559.6191,471.1245,1202.8463,269.4457,0,0,0,0,0,0);
	AddPlayerClass(264,-5559.6191,471.1245,1202.8463,269.4457,0,0,0,0,0,0);
	AddPlayerClass(268,-5559.6191,471.1245,1202.8463,269.4457,0,0,0,0,0,0);
	AddPlayerClass(269,-5559.6191,471.1245,1202.8463,269.4457,0,0,0,0,0,0);
	AddPlayerClass(294,-5559.6191,471.1245,1202.8463,269.4457,0,0,0,0,0,0);
	/*========================================================================*/
	CreateObject(987,-2856.704,499.204,3.914,0.0,0.0,-289.922);/*철조망 오브젝트*/
	CreateObject(987,-2859.668,487.801,3.925,0.0,0.0,75.312);
	CreateObject(987,-2865.057,416.695,3.907,0.0,0.0,90.000);
	CreateObject(987,-2865.128,428.702,3.914,0.0,0.0,90.000);
	CreateObject(987,-2865.125,440.702,3.875,0.0,0.0,90.000);

	CreateObject(10631,-2834.520,424.733,7.820,0.0,0.0,90.000);/*육지 오브젝트*/
	CreateObject(11008,-2925.026,570.237,10.051,0.0,0.0,32.891);
	CreateObject(1556,-2843.416,426.067,3.850,0.0,0.0,-90.000);
	CreateObject(8947,-2936.511,576.854,0.180,0.0,0.0,33.750);
	CreateObject(8947,-2922.874,556.443,0.181,0.0,0.0,-146.250);

	CreateObject(18450,-3407.446,471.838,85.901,0.0,0.859,0.0);/*도로 오브젝트*/
	CreateObject(18450,-3480.748,471.889,106.744,0.0,30.940,0.0);
	CreateObject(18450,-3554.769,471.911,130.271,0.0,4.297,0.0);
	CreateObject(18450,-3618.132,471.904,163.586,0.0,50.707,0.0);
	CreateObject(18450,-3675.561,471.907,218.080,0.0,36.096,0.0);
	CreateObject(18450,-3351.035,471.837,49.171,0.0,65.317,0.0);
	CreateObject(18450,-3747.661,471.871,242.771,0.0,1.719,0.0);
	CreateObject(18450,-4071.465,471.703,320.380,0.0,31.799,0.0);
	CreateObject(18450,-3850.935,471.737,249.530,0.0,7.735,0.0);
	CreateObject(18450,-3923.915,471.729,275.721,0.0,31.799,0.0);
	CreateObject(18450,-3997.714,471.709,297.948,0.0,1.719,0.0);
	CreateObject(18450,-4118.989,471.705,377.385,0.0,68.755,0.0);
	CreateObject(18450,-4172.858,471.698,419.819,0.0,7.735,0.0);
	CreateObject(18450,-4251.723,471.667,432.351,0.0,10.313,0.0);
	CreateObject(18450,-4293.507,471.665,479.496,0.0,86.803,0.0);
	CreateObject(18450,-4331.823,471.672,535.983,0.0,24.924,0.0);
	CreateObject(18450,-4400.287,471.671,576.288,0.0,36.096,0.0);
	CreateObject(18450,-4472.271,471.682,603.385,0.0,5.157,0.0);
	CreateObject(18450,-4526.778,471.688,643.026,0.0,67.895,0.0);
	CreateObject(18450,-4581.307,471.629,684.057,0.0,6.016,0.0);
	CreateObject(18450,-4655.285,471.559,708.884,0.0,30.940,0.0);
	CreateObject(18450,-4729.351,471.577,731.818,0.0,3.438,0.0);
	CreateObject(18450,-4801.048,471.606,757.440,0.0,36.096,0.0);
	CreateObject(18450,-4848.271,471.623,818.171,0.0,67.895,0.0);
	CreateObject(18450,-4900.558,471.625,869.139,0.0,20.626,0.0);
	CreateObject(18450,-4972.267,471.668,901.895,0.0,28.361,0.0);
	CreateObject(18450,-5047.268,471.627,920.858,0.0,0.0,0.0);
	CreateObject(18450,-5110.247,471.614,953.592,0.0,55.004,0.0);
	CreateObject(18450,-5171.815,471.563,995.726,0.0,13.751,0.0);
	CreateObject(18450,-5246.994,471.601,1019.652,0.0,21.486,0.0);
	CreateObject(18450,-5300.037,471.587,1070.506,0.0,66.177,0.0);
	CreateObject(18450,-5354.025,471.576,1119.283,0.0,18.048,0.0);
	CreateObject(18450,-5411.491,471.588,1166.765,0.0,61.020,0.0);
	CreateObject(18450,-5470.588,471.560,1201.502,0.0,0.0,0.0);
	CreateObject(18450,-3309.399,471.829,41.498,0.0,4.297,0.0);
	CreateObject(18450,-3230.425,471.816,38.541,0.0,0.0,0.0);
	CreateObject(18450,-3128.545,471.813,38.696,0.0,0.0,-180.000);
	CreateObject(18450,-3056.127,471.845,15.658,0.0,35.237,0.0);
	CreateObject(18450,-3022.104,471.851,8.691,0.0,8.594,0.0);

	CreateObject(17091,-5662.335,517.493,1197.776,0.0,0.0,0.0);/*하늘 오브젝트*/
	CreateObject(17091,-5636.386,388.379,1197.558,0.0,0.0,90.000);
	CreateObject(16110,-5683.027,367.914,1208.013,0.0,0.0,22.500);
	CreateObject(7520,-5568.489,463.839,1202.106,0.0,0.0,90.000);
	CreateObject(14876,-5573.245,480.866,1192.584,0.0,0.0,-180.000);
	CreateObject(16501,-5577.750,476.358,1193.870,0.0,0.0,-90.000);

	CreateObject(1633,-3819.514,471.886,246.582,0.0,0.0,-90.000);/*점프대 오브젝트*/
	CreateObject(1633,-3818.297,471.897,247.286,15.470,0.0,-90.000);
	CreateObject(1633,-3815.585,471.879,249.013,25.783,0.0,-90.000);
	CreateObject(1633,-3191.787,471.946,39.560,0.0,0.0,-90.000);
	CreateObject(1633,-3188.615,471.936,40.594,14.610,0.0,-90.000);
	CreateObject(1633,-3185.914,471.932,42.307,25.783,0.0,-90.000);

	CreateObject(17071,-2917.468,179.074,3.062,0.0,0.0,45.000);/*해적기지 오브젝트*/
	CreateObject(18273,-2892.222,164.468,21.255,0.0,0.0,-261.432);
	CreateObject(695,-2885.769,118.205,5.910,0.0,0.0,0.0);
	CreateObject(1497,-2914.882,176.358,2.600,-4.297,0.0,-90.859);
	CreateObject(1463,-2925.103,178.913,0.970,0.0,0.0,-67.500);
	CreateObject(3461,-2925.058,178.948,-0.471,0.0,0.0,0.0);
	CreateObject(1721,-2923.085,179.531,0.957,-9.454,0.0,101.250);
	CreateObject(1721,-2925.643,181.474,0.543,0.859,8.594,-167.891);
	CreateObject(1608,-2924.802,179.120,9.607,-85.944,4.297,11.250);
	CreateObject(1387,-2924.840,179.355,16.799,0.0,0.0,258.750);
	CreateObject(1391,-2924.468,186.228,6.576,25.783,2.578,0.0);
	CreateObject(16121,-431.565,1460.258,9.060,0.0,0.0,-67.500);/*해적 내부*/
	CreateObject(16121,-394.835,1249.865,-10.519,0.0,0.0,67.500);
	CreateObject(1497,-396.248,1254.849,6.043,44.691,0.0,41.562);
	CreateObject(2063,-395.030,1275.415,7.953,0.0,4.297,-78.750);
	CreateObject(2063,-397.967,1269.770,7.348,0.0,6.016,-78.750);
	CreateObject(1421,-396.638,1266.553,6.974,0.0,1.719,-33.750);
	CreateObject(1417,-398.077,1273.859,7.153,0.0,-6.016,90.000);
	CreateObject(1442,-398.878,1289.717,9.122,5.157,0.859,0.0);
	CreateObject(3461,-398.863,1289.704,7.928,0.0,0.0,0.0);
	CreateObject(1728,-397.361,1291.152,8.644,0.0,6.016,-78.750);
	CreateObject(897,-401.047,1298.458,9.313,0.0,0.0,0.0);
	CreateObject(874,-395.913,1276.174,6.707,0.0,0.0,-9.531);

	CreateDynamicObject(16400,260.304,1956.158,16.640,0.0,0.0,0.0); /*잡것*/
	CreateDynamicObject(18274,244.306,1939.249,16.631,0.0,0.0,-120.312);
	CreateDynamicObject(18236,227.141,1988.357,16.636,0.0,0.0,-180.000);
	CreateDynamicObject(18234,260.286,2023.524,16.636,0.0,0.0,-360.000);
	CreateDynamicObject(16770,238.529,2021.657,18.238,0.0,0.0,-180.000);
	CreateDynamicObject(11454,258.931,1991.889,16.860,0.0,0.0,90.000);
	CreateDynamicObject(13060,208.122,1975.633,19.671,0.0,0.0,-90.000);
	CreateDynamicObject(16100,226.203,2028.573,18.234,0.0,0.0,0.0);
	CreateDynamicObject(16770,238.539,2039.245,18.231,0.0,0.0,-180.000);

	CreateDynamicObject(18449, -2947.3688964844, 307.84936523438, 0, 0, 0, 5.998046875);  /*추가*/
	CreateDynamicObject(18449, -3019.8503417969, 298.81292724609, 0.10598468780518, 0, 0, 8);
	CreateDynamicObject(3749, -3054.986328125, 294.24594116211, 6.3081493377686, 0, 0, 276);
	CreateDynamicObject(17545, -3081.8134765625, 289.4260559082, 1.2448978424072, 0, 0, 8);
	CreateDynamicObject(7231, -3058.6840820313, 265.39535522461, 22.618537902832, 0, 0, 98);
	CreateDynamicObject(967, -723.75598144531, 974.76983642578, 11.320244789124, 0, 0, 152);
	CreateDynamicObject(16093, -719.43310546875, 1002.6697387695, 15.413657188416, 0, 0, 0);
	CreateDynamicObject(9482, -787.21264648438, 1002.6046142578, 24.167543411255, 0, 0, 350);
	CreateDynamicObject(987, -728.85980224609, 910.69897460938, 11.264505386353, 0, 0, 0);
	CreateDynamicObject(8042, -698.20025634766, 965.09808349609, 17.17714881897, 0, 0, 192);
	CreateDynamicObject(1662, -846.29357910156, 1008.5524291992, 26.259021759033, 0, 0, 119.99993896484);
	CreateDynamicObject(4514, -584.44970703125, 1104.1584472656, 12.625818252563, 0, 0, 314);
	CreateDynamicObject(10473, -553.57781982422, 918.99377441406, 5.921727180481, 0, 0, 335.99584960938);
	CreateDynamicObject(979, -615.74719238281, 894.56140136719, 6.2862648963928, 0, 0, 332);
	CreateDynamicObject(979, -515.43298339844, 899.17224121094, 6.2613196372986, 0, 0, 62);
	CreateDynamicObject(10470, -560.28668212891, 914.97534179688, 5.270320892334, 0, 0, 18);
	CreateDynamicObject(10470, -559.68499755859, 924.78997802734, 5.2719326019287, 0, 0, 286);
	CreateDynamicObject(3514, -604.9267578125, 936.60528564453, 10.231140136719, 0, 0, 60);
	CreateDynamicObject(1320, -555.33306884766, 923.017578125, 6.5531826019287, 0, 0, 152);
	CreateDynamicObject(978, -608.27996826172, 890.16784667969, 6.4488115310669, 0, 0, 332);
	CreateDynamicObject(978, -600.23999023438, 885.77569580078, 6.4857697486877, 0, 0, 332);
	CreateDynamicObject(978, -592.59356689453, 881.55487060547, 6.4773755073547, 0, 0, 332);
	CreateDynamicObject(978, -585.04888916016, 877.24432373047, 6.4519243240356, 0, 0, 332);
	CreateDynamicObject(978, -577.60614013672, 872.90472412109, 6.4388947486877, 0, 0, 332);
	CreateDynamicObject(978, -569.59271240234, 868.37286376953, 6.4388947486877, 0, 0, 332);
	CreateDynamicObject(983, -589.00695800781, 895.22509765625, 6.3603544235229, 0, 0, 62);
	CreateDynamicObject(978, -560.10040283203, 864.01422119141, 6.7070021629333, 0, 0, 336);
	CreateDynamicObject(978, -549.53564453125, 860.57220458984, 6.7070021629333, 0, 0, 352);
	CreateDynamicObject(978, -537.38391113281, 862.59741210938, 6.7070021629333, 0, 0, 24);
	CreateDynamicObject(978, -528.93334960938, 871.58843994141, 6.6992049217224, 0, 0, 60);
	CreateDynamicObject(978, -523.02532958984, 882.32000732422, 6.7070021629333, 0, 0, 62);
	CreateDynamicObject(978, -517.71203613281, 892.19586181641, 6.6753969192505, 0, 0, 58);
	CreateDynamicObject(978, -507.77053833008, 910.97241210938, 6.7070021629333, 0, 0, 62);
	CreateDynamicObject(978, -501.60028076172, 921.80322265625, 6.8244624137878, 0, 0, 62);
	CreateDynamicObject(978, -497.11895751953, 931.13507080078, 6.8322596549988, 0, 0, 84);
	CreateDynamicObject(978, -498.73577880859, 945.14324951172, 6.8322596549988, 0, 0, 108);
	CreateDynamicObject(978, -508.14166259766, 954.43762207031, 6.8322596549988, 0, 0, 154);
	CreateDynamicObject(978, -519.60375976563, 959.44018554688, 6.8322596549988, 0, 0, 158);
	CreateDynamicObject(978, -531.49530029297, 965.10107421875, 6.8322596549988, 0, 0, 158);
	CreateDynamicObject(978, -542.64514160156, 969.65600585938, 6.8555898666382, 0, 0, 156);
	CreateDynamicObject(978, -554.39599609375, 975.35070800781, 6.8791346549988, 0, 0, 154);
	CreateDynamicObject(978, -567.03094482422, 979.52960205078, 6.8791346549988, 0, 0, 174);
	CreateDynamicObject(978, -578.60076904297, 977.66796875, 6.8791346549988, 0, 0, 208);
	CreateDynamicObject(978, -587.77575683594, 965.77185058594, 6.8680505752563, 0, 0, 246);
	CreateDynamicObject(978, -614.75390625, 905.09344482422, 6.8631658554077, 0, 0, 244);
	CreateDynamicObject(978, -609.42626953125, 916.32965087891, 6.8713488578796, 0, 0, 244);
	CreateDynamicObject(4003, -2806.9069824219, 375.79559326172, 14.920323371887, 0, 0, 87.994995117188);
	CreateDynamicObject(16442, -2922.490234375, 312.53189086914, 2.2476530075073, 0, 0, 12);
	CreateDynamicObject(6965, -2791.4438476563, 409.39086914063, 30.573400497437, 0, 0, 0);
	CreateDynamicObject(6965, -2789.4675292969, 342.1728515625, 30.573400497437, 0, 0, 0);
	CreateDynamicObject(9833, -2943.4379882813, 457.93206787109, 7.1166062355042, 0, 0, 0);
	CreateDynamicObject(9833, -2950.40625, 457.53256225586, 7.1166062355042, 0, 0, 0);
	CreateDynamicObject(9833, -2961.5756835938, 457.08401489258, 7.1166062355042, 0, 0, 0);
	CreateDynamicObject(9833, -2971.8168945313, 457.00628662109, 7.1166062355042, 0, 0, 0);
	CreateDynamicObject(16778, -2981.7294921875, 456.59552001953, 3.9140625, 0, 0, 0);
	CreateDynamicObject(2892, -2947.4670410156, 308.00326538086, 0.34375, 0, 0, 6);
	CreateDynamicObject(3279, -3066.2863769531, 318.45053100586, 0.93298196792603, 0, 0, 6);
	CreateDynamicObject(3279, -2981.1184082031, 484.18942260742, 3.9103393554688, 0, 0, 0);
	CreateDynamicObject(1461, -2963.3791503906, 424.93804931641, 1.2754142284393, 0, 0, 90);
	CreateDynamicObject(1598, -2957.9821777344, 420.3486328125, 1.803848028183, 0, 0, 0);
	CreateDynamicObject(1608, -2982.9345703125, 422.83251953125, 0, 0, 0, 0);
	CreateDynamicObject(1637, -2954.0727539063, 429.22827148438, 3.2511878013611, 0, 0, 0);
	CreateDynamicObject(1641, -2951.2067871094, 423.27249145508, 2.1730680465698, 0, 0, 92);
	CreateDynamicObject(2404, -2951.087890625, 424.97204589844, 3.2499289512634, 0, 0, 0);
	CreateDynamicObject(6295, -2956.5893554688, 404.15579223633, 20.958961486816, 0, 0, 0);
	CreateDynamicObject(1503, -2905.2915039063, 418.9026184082, 3.9140625, 0, 0, 180);
	CreateDynamicObject(1634, -2971.7060546875, 470.27694702148, 5.2113800048828, 0, 0, 270);
	CreateDynamicObject(1634, -2965.4362792969, 470.18997192383, 5.2113800048828, 0, 0, 88);
	CreateDynamicObject(13641, -2809.2763671875, 234.70510864258, 7.8575110435486, 0, 0, 268);
	CreateDynamicObject(1681, -2861.6545410156, 468.94638061523, 40.08517074585, 0, 0, 86);
	CreateDynamicObject(2472, -2809.4658203125, 472.6376953125, 18.121286392212, 0, 0, 0);
	CreateDynamicObject(13831, -2871.4462890625, 466.26306152344, 83.627975463867, 0, 0, 276);
	CreateDynamicObject(1337, -2947.5407714844, 504.16439819336, 3.4902286529541, 0, 0, 0);
	CreateDynamicObject(1337, -2976.2856445313, 503.94195556641, 3.5281553268433, 0, 0, 352);
	CreateDynamicObject(3496, -2968.7722167969, 486.32379150391, 3.911018371582, 0, 0, 180);
	CreateDynamicObject(2114, -2967.4479980469, 485.10272216797, 4.0573282241821, 0, 0, 0);
	CreateDynamicObject(1646, -2954.3286132813, 417.43838500977, 2.5120086669922, 0, 0, 266);
	CreateDynamicObject(3279, -2868.2065429688, 507.15115356445, 3.9140625, 0, 0, 270);
	CreateDynamicObject(3279, -2879.5266113281, 507.18316650391, 3.9140625, 0, 0, 270);
	CreateDynamicObject(3279, -2891.0007324219, 507.10235595703, 3.9140625, 0, 0, 272);
	CreateDynamicObject(9833, -2901.1740722656, 506.82470703125, 7.1166062355042, 0, 0, 0);
	CreateDynamicObject(9833, -728.06805419922, 963.65893554688, 14.680215835571, 0, 0, 0);
	CreateDynamicObject(9833, -727.24243164063, 979.56970214844, 14.750465393066, 0, 0, 0);
	CreateDynamicObject(13641, -2809.0324707031, 209.79627990723, 7.8661918640137, 0, 0, 88);
	CreateDynamicObject(9833, -2925.4272460938, 420.15301513672, 7.1166062355042, 0, 0, 0);
	CreateObject(5871, -2914.384765625, 224.623046875, 93.587692260742, 0, 0, 91.99951171875);
	CreateDynamicObject(7929, -2887.0720214844, 172.51333618164, 97.045967102051, 0, 0, 182);
	CreateDynamicObject(7929, -2915.0888671875, 170.31745910645, 97.29443359375, 0, 0, 184);


	CreateDynamicObject(1634, -2901.19995, -207.89999, 3.7, 0, 0, 0);    /*임시옵젝 언제든 주석처리가능*/
	CreateDynamicObject(5871, -3074.5, -140.10001, 1016.70001, 0, 0, 0);
	CreateDynamicObject(7929, -3126.69995, -161.89999, 1020.90002, 0, 0, 92);
	CreateDynamicObject(7929, -3126, -133.3, 1020.40002, 0, 0, 90);
	CreateDynamicObject(1318, -3121.69995, -138.8, 1014.29999, 0, 0, 0);
	CreateDynamicObject(1318, -3121.8999, -167.10001, 1014.79999, 0, 0, 0);
	CreateDynamicObject(8168, -3014.5, -132.2, 1015.79999, 0, 0, 18);
	CreateDynamicObject(18022, -3056.80005, -113.6, 1139.40002, 0, 0, 0);
	CreateObject(15034, -3152.69995, -554.40002, 1115.59998, 0, 0, 0);
	CreateObject(15034, -3176.8999, -552.59998, 1113.19995, 0, 0, 0);
	CreateDynamicObject(1318, -3145.3999, -560.59998, 1114.40002, 0, 0, 0);
	CreateDynamicObject(1318, -3170.1001, -558.59998, 1112, 0, 0, 0);
	CreateObject(18023, -3198, -557.09998, 1109.09998, 0, 0, 0);
	CreateDynamicObject(2763, -3195, -558.90002, 1107.40002, 0, 0, 0);
	CreateObject(14881, -3178.80005, -573.90002, 1112.59998, 0, 0, 0);
	CreateDynamicObject(1318, -3199.3999, -567.09998, 1107.5, 0, 0, 270);
	CreateDynamicObject(1318, -3179, -581.29999, 1111.09998, 0, 0, 270);
	CreateDynamicObject(1318, -2802, 375.70001, 5.8, 0, 0, 0);
	CreateDynamicObject(1318, -2671.3999, 258.20001, 4.1, 0, 0, 274);


	CreateDynamicObject(16610, 2994.9938964844, -567.40631103516, 9.611554145813, 0, 0, 0);  /*감옥필터 언제든 주석처리 가능*/
	CreateDynamicObject(16610, 3115.8623046875, -567.23504638672, 9.5465507507324, 0, 0, 0);
	CreateDynamicObject(16610, 3234.470703125, -567.42303466797, 9.5, 0, 0, 0);
	CreateDynamicObject(16610, 3355.181640625, -567.31433105469, 9.4641208648682, 0, 0, 0);
	CreateDynamicObject(8420, 3453.9970703125, -563.28405761719, 6.5878410339355, 0, 0, 0);
	CreateDynamicObject(3749, 3414.1057128906, -566.62744140625, 11.783473014832, 0, 0, 270.67565917969);
	CreateDynamicObject(986, 3415.1203613281, -571.03216552734, 7.4296875, 0, 0, 270.67565917969);
	CreateDynamicObject(1696, 2930.5786132813, -562.05908203125, 5.3997869491577, 0, 0, 270.67565917969);
	CreateDynamicObject(1696, 2930.642578125, -567.09338378906, 5.5797214508057, 0, 0, 268.69067382813);
	CreateDynamicObject(987, 3415.3208007813, -572.78216552734, 5.9296875, 0, 0, 268.69067382813);
	CreateDynamicObject(987, 3414.9887695313, -584.10980224609, 5.9296875, 0, 0, 0);
	CreateDynamicObject(987, 3426.9663085938, -584.16857910156, 5.9296875, 0, 0, 0);
	CreateDynamicObject(987, 3438.474609375, -584.19842529297, 5.9296875, 0, 0, 270.67565917969);
	CreateDynamicObject(987, 3438.6225585938, -596.02764892578, 5.7265625, 0, 0, 324.27026367188);
	CreateDynamicObject(987, 3448.2353515625, -602.939453125, 5.9296875, 0, 0, 0);
	CreateDynamicObject(987, 3460.2563476563, -602.95770263672, 5.9219169616699, 0, 0, 0);
	CreateDynamicObject(987, 3472.2338867188, -602.93804931641, 5.9219169616699, 0, 0, 0);
	CreateDynamicObject(987, 3482.2941894531, -602.37371826172, 5.7265625, 0, 0, 0);
	CreateDynamicObject(987, 3494.5981445313, -602.50463867188, 5.7265625, 0, 0, 89.324493408203);
	CreateDynamicObject(987, 3494.7563476563, -590.38189697266, 5.7265625, 0, 0, 89.324493408203);
	CreateDynamicObject(987, 3494.8657226563, -578.42517089844, 5.7265625, 0, 0, 89.324493408203);
	CreateDynamicObject(987, 3494.9106445313, -566.49426269531, 5.7265625, 0, 0, 91.309509277344);
	CreateDynamicObject(987, 3494.783203125, -554.49713134766, 5.7265625, 0, 0, 89.324493408203);
	CreateDynamicObject(987, 3494.8857421875, -542.45367431641, 5.7265625, 0, 0, 91.309509277344);
	CreateDynamicObject(987, 3494.8896484375, -535.24627685547, 5.7265625, 0, 0, 91.309509277344);
	CreateDynamicObject(987, 3494.6889648438, -523.54602050781, 5.7265625, 0, 0, 179.36633300781);
	CreateDynamicObject(987, 3482.7280273438, -523.53002929688, 5.6114149093628, 0, 0, 179.36633300781);
	CreateDynamicObject(987, 3470.7661132813, -523.48004150391, 5.9296875, 0, 0, 179.36633300781);
	CreateDynamicObject(987, 3459.0727539063, -523.47863769531, 5.7265625, 0, 0, 179.36633300781);
	CreateDynamicObject(987, 3446.7495117188, -523.34265136719, 5.7265625, 0, 0, 181.35131835938);
	CreateDynamicObject(987, 3435.0500488281, -523.40161132813, 5.7265625, 0, 0, 270.67565917969);
	CreateDynamicObject(987, 3435.0034179688, -531.87518310547, 5.7265625, 0, 0, 270.67565917969);
	CreateDynamicObject(987, 3434.728515625, -543.34796142578, 5.9296875, 0, 0, 179.36633300781);
	CreateDynamicObject(987, 3426.2258300781, -543.61737060547, 5.9296875, 0, 0, 179.36633300781);
	CreateDynamicObject(987, 3415.1662597656, -543.33245849609, 5.9296875, 0, 0, 270.67565917969);
	CreateDynamicObject(985, 3415.1833496094, -555.31011962891, 7.6796875, 0, 0, 91.309509277344);
	CreateDynamicObject(3279, 3488.4033203125, -596.11865234375, 6.5644035339355, 0, 0, 173.41137695313);
	CreateDynamicObject(3279, 3487.9912109375, -528.10974121094, 6.5722122192383, 0, 0, 0);
	CreateDynamicObject(3279, 3439.8779296875, -527.1357421875, 6.5644035339355, 0, 0, 0);
	CreateDynamicObject(6960, 3462.6689453125, -581.08679199219, 8.7734813690186, 0, 0, 0);
	CreateDynamicObject(1696, 3411.4921875, -563.49597167969, 5.9322881698608, 0, 0, 268.69067382813);
	CreateDynamicObject(3940, 3462.3322753906, -527.32165527344, 9.7341117858887, 0, 0, 270.67565917969);
	CreateDynamicObject(1946, 3446.3732910156, -573.67700195313, 6.7702074050903, 0, 0, 0);
	CreateDynamicObject(2985, 3487.26953125, -593.88671875, 22.642528533936, 0, 0, 123.06942749023);
	CreateDynamicObject(2985, 3486.5991210938, -529.89691162109, 22.650337219238, 0, 0, 223.03601074219);
	CreateDynamicObject(987, 3493.9528808594, -539.52691650391, 6.5644035339355, 0, 0, 183.33630371094);
	CreateDynamicObject(987, 3479.7592773438, -540.36126708984, 6.5722117424011, 0, 0, 270.67565917969);
	CreateDynamicObject(987, 3482.0224609375, -552.39672851563, 6.5644035339355, 0, 0, 0);
	CreateDynamicObject(1499, 3480.1525878906, -552.05914306641, 6.5644035339355, 0, 0, 0);
	CreateDynamicObject(1499, 3480.4409179688, -540.11059570313, 6.5722122192383, 0, 0, 0);
	CreateDynamicObject(2113, 3442.041015625, -571.23980712891, 9.7468376159668, 0, 0, 85.3544921875);
	CreateDynamicObject(2113, 3483.1652832031, -570.93103027344, 9.7468376159668, 0, 0, 272.66064453125);
	CreateDynamicObject(3928, 3486.8994140625, -546.74224853516, 6.5644035339355, 0, 0, 0);
	CreateDynamicObject(3550, 2946.0297851563, -569.61944580078, 8.4395008087158, 0, 0, 0);
	CreateDynamicObject(3749, 2931.7282714844, -567.01812744141, 12.043055534363, 0, 0, 272.66064453125);
	CreateDynamicObject(3550, 2945.5532226563, -573.59594726563, 8.5879383087158, 0, 0, 0);



		CreateDynamicObject(8421, 401.83, -2314.91, 26.90,   0.00, 90.00, 0.00);     /*슈퍼레이싱 오브젝트 언제든 주석가능*/
        CreateDynamicObject(8421, 450.11, -2314.91, 26.90,   0.00, 90.00, 0.00);
        CreateDynamicObject(16113, 444.48, -2326.72, 6.23,   36.58, 27.81, 288.55);
        CreateDynamicObject(16113, 423.27, -2306.75, 45.40,   42.80, 78.64, 270.46);
        CreateDynamicObject(16116, 346.81, -2396.28, -2.80,   0.00, 0.00, 316.00);
        CreateDynamicObject(16116, 355.99, -2351.18, -5.25,   0.00, 0.00, 290.00);
        CreateDynamicObject(16116, 339.99, -2381.44, 21.09,   317.88, 52.42, 333.06);
        CreateDynamicObject(16116, 358.09, -2340.38, 11.87,   317.88, 52.42, 289.06);
        CreateDynamicObject(16116, 498.45, -2355.89, 0.00,   317.88, 52.42, 187.06);
        CreateDynamicObject(16116, 503.40, -2403.70, 0.00,   317.88, 52.41, 157.06);
        CreateDynamicObject(16116, 505.05, -2375.14, 14.43,   317.88, 52.41, 157.06);
        CreateDynamicObject(16116, 482.96, -2331.30, 13.27,   317.88, 52.41, 157.06);
        CreateDynamicObject(16116, 497.92, -2413.78, 15.28,   317.88, 52.41, 137.06);
        CreateDynamicObject(17034, 354.85, -2378.18, -5.62,   0.00, 0.00, 302.00);
        CreateDynamicObject(17034, 489.33, -2380.06, -7.80,   0.00, 0.00, 82.00);
        CreateDynamicObject(9088, 423.23, -2290.86, 26.55,   0.00, 0.00, 0.00);
        CreateDynamicObject(8558, 406.00, -2415.42, 2.88,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 442.48, -2420.52, 2.89,   0.00, 0.00, 0.00);
        CreateDynamicObject(8558, 406.00, -2420.52, 2.88,   0.00, 0.00, 0.00);
        CreateDynamicObject(8558, 406.00, -2425.63, 2.88,   0.00, 0.00, 0.00);
        CreateDynamicObject(8558, 406.00, -2430.73, 2.88,   0.00, 0.00, 0.00);
        CreateDynamicObject(8558, 406.00, -2435.84, 2.88,   0.00, 0.00, 0.00);
        CreateDynamicObject(8558, 406.00, -2440.94, 2.88,   0.00, 0.00, 0.00);
        CreateDynamicObject(8558, 406.00, -2446.05, 2.88,   0.00, 0.00, 0.00);
        CreateDynamicObject(8558, 406.00, -2451.15, 2.88,   0.00, 0.00, 0.00);
        CreateDynamicObject(8558, 406.00, -2456.26, 2.88,   0.00, 0.00, 0.00);
        CreateDynamicObject(8558, 406.00, -2461.36, 2.88,   0.00, 0.00, 0.00);
        CreateDynamicObject(8558, 406.00, -2466.47, 2.88,   0.00, 0.00, 0.00);
        CreateDynamicObject(8558, 406.00, -2471.57, 2.88,   0.00, 0.00, 0.00);
        CreateDynamicObject(8558, 406.00, -2476.68, 2.88,   0.00, 0.00, 0.00);
        CreateDynamicObject(8558, 406.00, -2481.78, 2.88,   0.00, 0.00, 0.00);
        CreateDynamicObject(8558, 406.00, -2486.89, 2.88,   0.00, 0.00, 0.00);
        CreateDynamicObject(8558, 406.00, -2491.99, 2.88,   0.00, 0.00, 0.00);
        CreateDynamicObject(8558, 406.00, -2497.09, 2.88,   0.00, 0.00, 0.00);
        CreateDynamicObject(8558, 406.00, -2502.20, 2.88,   0.00, 0.00, 0.00);
        CreateDynamicObject(8558, 406.00, -2507.30, 2.88,   0.00, 0.00, 0.00);
        CreateDynamicObject(8558, 406.00, -2512.41, 2.88,   0.00, 0.00, 0.00);
        CreateDynamicObject(8558, 406.00, -2517.51, 2.88,   0.00, 0.00, 0.00);
        CreateDynamicObject(8558, 406.00, -2522.62, 2.88,   0.00, 0.00, 0.00);
        CreateDynamicObject(8558, 406.00, -2527.72, 2.88,   0.00, 0.00, 0.00);
        CreateDynamicObject(8558, 406.00, -2532.83, 2.88,   0.00, 0.00, 0.00);
        CreateDynamicObject(8558, 406.00, -2537.93, 2.88,   0.00, 0.00, 0.00);
        CreateDynamicObject(8558, 406.00, -2543.04, 2.88,   0.00, 0.00, 0.00);
        CreateDynamicObject(8558, 406.00, -2548.14, 2.88,   0.00, 0.00, 0.00);
        CreateDynamicObject(8558, 406.00, -2553.25, 2.88,   0.00, 0.00, 0.00);
        CreateDynamicObject(8558, 406.00, -2558.35, 2.88,   0.00, 0.00, 0.00);
        CreateDynamicObject(8558, 406.00, -2563.46, 2.88,   0.00, 0.00, 0.00);
        CreateDynamicObject(8558, 406.00, -2568.56, 2.88,   0.00, 0.00, 0.00);
        CreateDynamicObject(8558, 406.00, -2573.67, 2.88,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 442.48, -2425.63, 2.89,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 442.48, -2430.73, 2.89,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 442.48, -2435.84, 2.89,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 442.48, -2440.94, 2.89,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 442.48, -2446.05, 2.89,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 442.48, -2451.15, 2.89,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 442.48, -2456.26, 2.89,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 442.48, -2461.36, 2.89,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 442.48, -2466.47, 2.89,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 442.48, -2471.57, 2.89,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 442.48, -2476.68, 2.89,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 442.48, -2481.78, 2.89,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 442.48, -2486.89, 2.89,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 442.48, -2491.99, 2.89,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 442.48, -2497.09, 2.89,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 442.48, -2502.20, 2.89,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 442.48, -2507.30, 2.89,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 442.48, -2512.41, 2.89,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 442.48, -2517.51, 2.89,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 442.48, -2522.62, 2.89,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 442.48, -2527.72, 2.89,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 442.48, -2532.83, 2.89,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 442.48, -2537.93, 2.89,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 442.48, -2543.04, 2.89,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 442.48, -2548.14, 2.89,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 442.48, -2553.25, 2.89,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 442.48, -2558.35, 2.89,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 442.48, -2563.46, 2.89,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 442.48, -2568.56, 2.89,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 442.48, -2573.67, 2.89,   0.00, 0.00, 0.00);
        CreateDynamicObject(5644, 474.01, -2421.50, -9.99,   180.00, 90.00, 0.00);
        CreateDynamicObject(5644, 474.01, -2444.88, -9.99,   179.99, 90.00, 0.00);
        CreateDynamicObject(5644, 474.01, -2468.25, -9.99,   179.99, 90.00, 0.00);
        CreateDynamicObject(5644, 474.01, -2491.63, -9.99,   179.98, 90.00, 0.00);
        CreateDynamicObject(5644, 474.01, -2515.00, -9.99,   179.98, 90.00, 0.00);
        CreateDynamicObject(5644, 474.01, -2538.38, -9.99,   179.97, 90.00, 0.00);
        CreateDynamicObject(5644, 474.01, -2561.75, -9.99,   179.97, 90.00, 0.00);
        CreateDynamicObject(5644, 474.01, -2398.13, -9.99,   180.01, 90.00, 0.00);
        CreateDynamicObject(5644, 474.01, -2374.76, -9.99,   180.01, 90.00, 0.00);
        CreateDynamicObject(5644, 474.01, -2351.38, -9.99,   180.02, 90.00, 0.00);
        CreateDynamicObject(5644, 474.01, -2328.01, -9.99,   180.02, 90.00, 0.00);
        CreateDynamicObject(5644, 374.81, -2421.50, -10.00,   179.99, 90.00, 0.00);
        CreateDynamicObject(5644, 374.81, -2444.88, -10.00,   0.00, 270.00, 180.00);
        CreateDynamicObject(5644, 374.81, -2468.25, -10.00,   179.99, 90.00, 0.00);
        CreateDynamicObject(5644, 374.81, -2491.63, -10.00,   179.99, 90.00, 0.00);
        CreateDynamicObject(5644, 374.81, -2515.00, -10.00,   179.99, 90.00, 0.00);
        CreateDynamicObject(5644, 374.81, -2538.38, -10.00,   179.99, 90.00, 0.00);
        CreateDynamicObject(5644, 374.81, -2561.75, -10.00,   179.99, 90.00, 0.00);
        CreateDynamicObject(5644, 374.81, -2398.13, -10.00,   359.99, -90.00, -180.00);
        CreateDynamicObject(5644, 374.81, -2374.76, -10.00,   539.98, -270.00, -360.00);
        CreateDynamicObject(5644, 374.81, -2351.38, -10.00,   359.97, 269.99, 179.99);
        CreateDynamicObject(5644, 374.81, -2328.01, -10.00,   899.97, -630.00, -720.00);
        CreateDynamicObject(5644, 399.71, -2351.38, -10.00,   359.97, 269.99, 179.99);
        CreateDynamicObject(5644, 424.60, -2351.38, -10.00,   359.97, 269.99, 179.99);
        CreateDynamicObject(5644, 449.50, -2351.38, -10.00,   359.97, 269.99, 179.99);
        CreateDynamicObject(16613, 520.39, -2376.64, 6.21,   9.73, 325.43, 6.92);
        CreateDynamicObject(10357, 336.48, -2392.85, 72.46,   0.00, 348.00, 86.00);
        CreateDynamicObject(8480, 550.65, -2466.35, -8.18,   0.00, 324.00, 180.00);
        CreateDynamicObject(8480, 294.21, -2493.64, -8.18,   0.00, 324.00, 0.00);
        CreateDynamicObject(8489, 423.36, -2556.63, 8.72,   0.00, 270.00, 270.00);
        CreateDynamicObject(16116, 356.07, -2526.71, -6.55,   0.00, 0.00, 0.00);
        CreateDynamicObject(16116, 488.34, -2529.84, 2.16,   0.00, 0.00, 88.00);
        CreateDynamicObject(8489, 423.52, -2556.41, 77.09,   0.00, 270.00, 269.99);
        CreateDynamicObject(8838, 422.58, -2578.58, 2.89,   0.00, 0.00, 0.00);
        CreateDynamicObject(8838, 422.58, -2578.58, 2.89,   0.00, 0.00, 0.00);
        CreateDynamicObject(8838, 422.58, -2583.70, 2.93,   -0.90, 0.00, 0.00);
        CreateDynamicObject(8838, 422.58, -2588.81, 3.05,   -1.80, 0.00, 0.00);
        CreateDynamicObject(8838, 422.58, -2593.93, 3.25,   -2.70, 0.00, 0.00);
        CreateDynamicObject(8838, 422.58, -2599.04, 3.53,   -3.60, 0.00, 0.00);
        CreateDynamicObject(8838, 422.58, -2604.15, 3.89,   -4.50, 0.00, 0.00);
        CreateDynamicObject(8838, 422.58, -2609.25, 4.33,   -5.40, 0.00, 0.00);
        CreateDynamicObject(8838, 422.58, -2614.34, 4.86,   -6.30, 0.00, 0.00);
        CreateDynamicObject(8838, 422.58, -2619.43, 5.46,   -7.20, 0.00, 0.00);
        CreateDynamicObject(8838, 422.58, -2624.50, 6.14,   -8.10, 0.00, 0.00);
        CreateDynamicObject(8838, 422.58, -2629.57, 6.90,   -9.00, 0.00, 0.00);
        CreateDynamicObject(8838, 422.58, -2634.62, 7.74,   -9.90, 0.00, 0.00);
        CreateDynamicObject(8838, 422.58, -2639.65, 8.66,   -10.80, 0.00, 0.00);
        CreateDynamicObject(8838, 422.58, -2644.68, 9.66,   -11.70, 0.00, 0.00);
        CreateDynamicObject(8838, 422.58, -2649.68, 10.74,   -12.60, 0.00, 0.00);
        CreateDynamicObject(8838, 422.58, -2654.67, 11.89,   -13.50, 0.00, 0.00);
        CreateDynamicObject(8838, 422.58, -2659.64, 13.13,   -14.40, 0.00, 0.00);
        CreateDynamicObject(8838, 422.58, -2664.59, 14.44,   -15.30, 0.00, 0.00);
        CreateDynamicObject(8838, 422.58, -2669.51, 15.83,   -16.20, 0.00, 0.00);
        CreateDynamicObject(8838, 422.58, -2674.42, 17.30,   -17.10, 0.00, 0.00);
        CreateDynamicObject(8838, 422.58, -2679.30, 18.84,   -18.00, 0.00, 0.00);
        CreateDynamicObject(8838, 422.58, -2684.16, 20.46,   -18.90, 0.00, 0.00);
        CreateDynamicObject(8838, 422.58, -2688.99, 22.16,   -19.80, 0.00, 0.00);
        CreateDynamicObject(8838, 422.58, -2693.79, 23.93,   -20.70, 0.00, 0.00);
        CreateDynamicObject(8838, 422.58, -2698.57, 25.78,   -21.60, 0.00, 0.00);
        CreateDynamicObject(8838, 422.58, -2703.31, 27.70,   -22.50, 0.00, 0.00);
        CreateDynamicObject(8838, 422.58, -2708.03, 29.70,   -23.40, 0.00, 0.00);
        CreateDynamicObject(8838, 422.58, -2712.71, 31.77,   -24.30, 0.00, 0.00);
        CreateDynamicObject(8838, 422.58, -2717.36, 33.91,   -25.20, 0.00, 0.00);
        CreateDynamicObject(8838, 422.58, -2721.98, 36.13,   -26.10, 0.00, 0.00);
        CreateDynamicObject(8838, 422.58, -2726.56, 38.41,   -27.00, 0.00, 0.00);
        CreateDynamicObject(8838, 422.58, -2731.10, 40.77,   -27.90, 0.00, 0.00);
        CreateDynamicObject(8838, 422.58, -2735.60, 43.21,   -28.80, 0.00, 0.00);
        CreateDynamicObject(8838, 422.58, -2740.07, 45.71,   -29.70, 0.00, 0.00);
        CreateDynamicObject(8838, 422.58, -2744.50, 48.28,   -30.60, 0.00, 0.00);
        CreateDynamicObject(8838, 422.58, -2748.89, 50.92,   -31.50, 0.00, 0.00);
        CreateDynamicObject(8838, 422.58, -2753.23, 53.63,   -32.40, 0.00, 0.00);
        CreateDynamicObject(8838, 422.58, -2757.53, 56.41,   -33.30, 0.00, 0.00);
        CreateDynamicObject(8838, 422.58, -2761.79, 59.25,   325.80, 0.00, 0.00);
        CreateDynamicObject(8838, 422.58, -2761.79, 59.25,   215.00, 180.00, 180.00);
        CreateDynamicObject(8838, 422.58, -2765.98, 62.14,   214.10, 180.00, 180.00);
        CreateDynamicObject(8838, 422.58, -2770.22, 64.96,   213.20, 180.00, 180.00);
        CreateDynamicObject(8838, 422.58, -2774.51, 67.72,   212.30, 180.00, 180.00);
        CreateDynamicObject(8838, 422.58, -2778.84, 70.41,   211.40, 180.00, 180.00);
        CreateDynamicObject(8838, 422.58, -2783.21, 73.03,   210.50, 180.00, 180.00);
        CreateDynamicObject(8838, 422.58, -2787.62, 75.58,   209.60, 180.00, 180.00);
        CreateDynamicObject(8838, 422.58, -2792.06, 78.06,   208.70, 180.00, 180.00);
        CreateDynamicObject(8838, 422.58, -2796.55, 80.47,   207.80, 180.00, 180.00);
        CreateDynamicObject(8838, 422.58, -2801.08, 82.81,   206.90, 180.00, 180.00);
        CreateDynamicObject(8838, 422.58, -2805.64, 85.08,   206.00, 180.00, 180.00);
        CreateDynamicObject(8838, 422.58, -2810.23, 87.28,   205.10, 180.00, 180.00);
        CreateDynamicObject(8838, 422.58, -2814.86, 89.40,   204.20, 180.00, 180.00);
        CreateDynamicObject(8838, 422.58, -2819.53, 91.45,   203.30, 180.00, 180.00);
        CreateDynamicObject(8838, 422.58, -2824.22, 93.43,   202.40, 180.00, 180.00);
        CreateDynamicObject(8838, 422.58, -2828.95, 95.34,   201.50, 180.00, 180.00);
        CreateDynamicObject(8838, 422.58, -2833.70, 97.17,   200.60, 180.00, 180.00);
        CreateDynamicObject(8838, 422.58, -2838.48, 98.92,   199.70, 180.00, 180.00);
        CreateDynamicObject(8838, 422.58, -2843.29, 100.60,   198.80, 180.00, 180.00);
        CreateDynamicObject(8838, 422.58, -2848.13, 102.20,   197.90, 180.00, 180.00);
        CreateDynamicObject(8838, 422.58, -2852.99, 103.73,   197.00, 180.00, 180.00);
        CreateDynamicObject(8838, 422.58, -2857.87, 105.18,   196.10, 180.00, 180.00);
        CreateDynamicObject(8838, 422.58, -2862.78, 106.56,   195.20, 180.00, 180.00);
        CreateDynamicObject(8838, 422.58, -2867.70, 107.85,   194.30, 180.00, 180.00);
        CreateDynamicObject(8838, 422.58, -2872.65, 109.07,   193.40, 180.00, 180.00);
        CreateDynamicObject(8838, 422.58, -2877.61, 110.22,   192.50, 180.00, 180.00);
        CreateDynamicObject(8838, 422.58, -2882.60, 111.28,   191.60, 180.00, 180.00);
        CreateDynamicObject(8838, 422.58, -2887.60, 112.26,   190.70, 180.00, 180.00);
        CreateDynamicObject(8838, 422.58, -2892.61, 113.17,   189.80, 180.00, 180.00);
        CreateDynamicObject(8838, 422.58, -2897.64, 114.00,   188.90, 180.00, 180.00);
        CreateDynamicObject(8838, 422.58, -2902.67, 114.75,   188.00, 180.00, 180.00);
        CreateDynamicObject(8838, 422.58, -2907.72, 115.42,   187.10, 180.00, 180.00);
        CreateDynamicObject(8838, 422.58, -2912.78, 116.01,   186.20, 180.00, 180.00);
        CreateDynamicObject(8838, 422.58, -2917.85, 116.52,   185.30, 180.00, 180.00);
        CreateDynamicObject(8838, 422.58, -2922.93, 116.95,   184.40, 180.00, 180.00);
        CreateDynamicObject(8838, 422.58, -2928.01, 117.30,   183.50, 180.00, 180.00);
        CreateDynamicObject(8838, 422.58, -2933.10, 117.57,   182.60, 180.00, 180.00);
        CreateDynamicObject(8838, 422.58, -2938.19, 117.76,   181.70, 180.00, 180.00);
        CreateDynamicObject(8838, 422.58, -2943.28, 117.87,   180.80, 179.99, 179.99);
        CreateDynamicObject(8838, 422.58, -2948.38, 117.90,   179.90, 180.00, 180.00);
        CreateDynamicObject(8838, 422.58, -2953.47, 117.85,   179.00, 179.99, 179.99);
        CreateDynamicObject(8838, 422.58, -2953.47, 117.85,   179.00, 179.99, 179.99);
        CreateDynamicObject(8838, 422.58, -2958.59, 117.72,   178.10, 179.99, 179.99);
        CreateDynamicObject(8838, 422.58, -2963.70, 117.51,   177.20, 179.99, 179.99);
        CreateDynamicObject(8838, 422.58, -2968.82, 117.22,   176.30, 179.99, 179.99);
        CreateDynamicObject(8838, 422.58, -2973.92, 116.85,   175.40, 179.99, 179.99);
        CreateDynamicObject(8838, 422.57, -2979.02, 116.40,   174.50, 179.99, 179.99);
        CreateDynamicObject(8838, 422.57, -2984.12, 115.87,   173.60, 179.99, 179.99);
        CreateDynamicObject(8838, 422.57, -2989.20, 115.26,   172.70, 179.99, 179.99);
        CreateDynamicObject(8838, 422.57, -2994.27, 114.57,   171.80, 179.99, 179.99);
        CreateDynamicObject(8838, 422.57, -2999.33, 113.80,   170.90, 179.99, 179.99);
        CreateDynamicObject(8838, 422.57, -3004.38, 112.95,   170.00, 179.99, 179.99);
        CreateDynamicObject(8838, 422.57, -3009.42, 112.02,   169.10, 179.99, 179.99);
        CreateDynamicObject(8838, 422.57, -3014.44, 111.02,   168.20, 179.99, 179.99);
        CreateDynamicObject(8838, 422.57, -3019.44, 109.93,   167.30, 179.99, 179.99);
        CreateDynamicObject(8838, 422.57, -3024.43, 108.76,   166.40, 179.99, 179.99);
        CreateDynamicObject(8838, 422.57, -3029.39, 107.52,   165.50, 179.99, 179.99);
        CreateDynamicObject(8838, 422.57, -3034.34, 106.20,   164.60, 179.99, 179.99);
        CreateDynamicObject(8838, 422.57, -3039.27, 104.80,   163.70, 179.99, 179.99);
        CreateDynamicObject(8838, 422.57, -3044.17, 103.33,   162.80, 179.99, 179.99);
        CreateDynamicObject(8838, 422.57, -3049.05, 101.77,   161.90, 179.99, 179.99);
        CreateDynamicObject(8838, 422.57, -3053.90, 100.15,   161.00, 179.99, 179.99);
        CreateDynamicObject(8838, 422.57, -3058.73, 98.44,   160.10, 179.99, 179.99);
        CreateDynamicObject(8838, 422.57, -3063.53, 96.66,   159.20, 179.99, 179.99);
        CreateDynamicObject(8838, 422.57, -3068.30, 94.81,   158.30, 179.99, 179.99);
        CreateDynamicObject(8838, 422.57, -3073.04, 92.87,   157.40, 179.99, 179.99);
        CreateDynamicObject(8838, 422.57, -3077.75, 90.87,   156.50, 179.99, 179.99);
        CreateDynamicObject(8838, 422.56, -3082.43, 88.79,   155.60, 179.99, 179.99);
        CreateDynamicObject(8838, 422.56, -3087.08, 86.64,   154.70, 179.99, 179.99);
        CreateDynamicObject(8838, 422.56, -3091.69, 84.42,   153.80, 179.99, 179.99);
        CreateDynamicObject(8838, 422.56, -3096.27, 82.12,   152.90, 179.99, 179.99);
        CreateDynamicObject(8838, 422.56, -3100.81, 79.75,   152.00, 179.99, 179.99);
        CreateDynamicObject(8838, 422.56, -3105.31, 77.31,   151.10, 179.99, 179.99);
        CreateDynamicObject(8838, 422.56, -3109.77, 74.80,   150.20, 179.99, 179.99);
        CreateDynamicObject(8838, 422.56, -3114.19, 72.22,   149.30, 179.99, 179.99);
        CreateDynamicObject(8838, 422.56, -3118.58, 69.58,   148.40, 179.99, 179.99);
        CreateDynamicObject(8838, 422.56, -3122.92, 66.86,   147.50, 179.99, 179.99);
        CreateDynamicObject(8838, 422.56, -3127.21, 64.07,   146.60, 179.99, 179.99);
        CreateDynamicObject(8838, 422.56, -3131.46, 61.22,   145.70, 179.99, 179.99);
        CreateDynamicObject(8838, 422.56, -3135.67, 58.30,   144.80, 179.99, 179.99);
        CreateDynamicObject(8838, 422.56, -3139.83, 55.32,   143.90, 179.99, 179.99);
        CreateDynamicObject(8838, 422.56, -3143.94, 52.27,   323.00, 0.00, 180.00);
        CreateDynamicObject(8838, 422.56, -3143.94, 52.27,   323.00, 0.00, 180.00);
        CreateDynamicObject(8838, 422.56, -3148.07, 49.23,   324.20, 0.00, 180.00);
        CreateDynamicObject(8838, 422.56, -3152.25, 46.28,   325.40, 0.00, 180.00);
        CreateDynamicObject(8838, 422.56, -3156.49, 43.42,   326.60, 0.00, 180.00);
        CreateDynamicObject(8838, 422.56, -3160.80, 40.64,   327.80, 0.00, 180.00);
        CreateDynamicObject(8838, 422.56, -3165.16, 37.96,   329.00, 0.00, 180.00);
        CreateDynamicObject(8838, 422.56, -3169.57, 35.37,   330.20, 0.00, 180.00);
        CreateDynamicObject(8838, 422.56, -3174.04, 32.87,   331.40, 0.00, 180.00);
        CreateDynamicObject(8838, 422.56, -3178.56, 30.47,   332.60, 0.00, 180.00);
        CreateDynamicObject(8838, 422.56, -3183.14, 28.16,   333.80, 0.00, 180.00);
        CreateDynamicObject(8838, 422.56, -3187.75, 25.95,   335.00, 0.00, 180.00);
        CreateDynamicObject(8838, 422.56, -3192.42, 23.83,   336.20, 0.00, 180.00);
        CreateDynamicObject(8838, 422.56, -3197.12, 21.82,   337.40, 0.00, 180.00);
        CreateDynamicObject(8838, 422.56, -3201.87, 19.90,   338.60, 0.00, 180.00);
        CreateDynamicObject(8838, 422.56, -3206.65, 18.08,   339.80, 0.00, 180.00);
        CreateDynamicObject(8838, 422.56, -3211.48, 16.36,   341.00, 0.00, 180.00);
        CreateDynamicObject(8838, 422.56, -3216.34, 14.75,   342.20, 0.00, 180.00);
        CreateDynamicObject(8838, 422.56, -3221.23, 13.23,   343.40, 0.00, 180.00);
        CreateDynamicObject(8838, 422.56, -3226.15, 11.82,   344.60, 0.00, 180.00);
        CreateDynamicObject(8838, 422.56, -3231.10, 10.51,   345.80, 0.00, 180.00);
        CreateDynamicObject(8838, 422.56, -3236.08, 9.31,   347.00, 0.00, 180.00);
        CreateDynamicObject(8838, 422.56, -3241.08, 8.21,   348.20, 0.00, 180.00);
        CreateDynamicObject(8838, 422.56, -3246.10, 7.21,   349.40, 0.00, 180.00);
        CreateDynamicObject(8838, 422.56, -3251.14, 6.33,   350.60, 0.00, 180.00);
        CreateDynamicObject(8838, 422.56, -3256.20, 5.54,   351.80, 0.00, 180.00);
        CreateDynamicObject(8838, 422.56, -3261.28, 4.87,   353.00, 0.00, 179.99);
        CreateDynamicObject(8838, 422.56, -3266.36, 4.29,   354.20, 0.00, 180.00);
        CreateDynamicObject(8838, 422.56, -3271.46, 3.83,   355.40, 0.00, 180.00);
        CreateDynamicObject(8838, 422.56, -3276.57, 3.47,   356.60, 0.00, 180.00);
        CreateDynamicObject(8838, 422.56, -3281.68, 3.22,   357.80, 0.00, 180.00);
        CreateDynamicObject(8838, 422.56, -3286.80, 3.08,   359.00, 0.00, 179.99);
        CreateDynamicObject(8838, 422.56, -3286.80, 3.08,   359.00, 0.00, 179.99);
        CreateDynamicObject(8838, 422.56, -3291.92, 3.15,   362.60, 0.00, 179.99);
        CreateDynamicObject(8838, 422.56, -3297.03, 3.54,   366.20, 0.00, 179.99);
        CreateDynamicObject(8838, 422.56, -3302.10, 4.26,   369.80, 0.00, 179.99);
        CreateDynamicObject(8838, 422.56, -3307.11, 5.29,   373.40, 0.00, 179.99);
        CreateDynamicObject(8838, 422.56, -3312.05, 6.63,   377.00, 0.00, 179.99);
        CreateDynamicObject(8838, 422.56, -3316.90, 8.28,   380.60, 0.00, 179.99);
        CreateDynamicObject(8838, 422.56, -3321.63, 10.23,   384.20, 0.00, 179.99);
        CreateDynamicObject(8838, 422.55, -3326.24, 12.48,   387.80, 0.00, 179.99);
        CreateDynamicObject(8838, 422.55, -3330.69, 15.00,   391.40, 0.00, 179.99);
        CreateDynamicObject(8838, 422.55, -3334.97, 17.81,   395.00, 0.00, 179.99);
        CreateDynamicObject(8838, 422.55, -3339.07, 20.87,   398.60, 0.00, 179.99);
        CreateDynamicObject(8838, 422.55, -3342.97, 24.19,   42.20, 0.00, 179.99);
        CreateDynamicObject(8397, 436.65, -2943.52, 92.34,   0.00, 0.00, 0.00);
        CreateDynamicObject(8397, 408.58, -2943.52, 92.34,   0.00, 0.00, 0.00);
        CreateDynamicObject(8558, 422.55, -3492.10, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 422.55, -3497.21, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 422.55, -3502.32, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 422.55, -3507.43, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 422.55, -3512.54, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 422.55, -3517.65, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 422.55, -3522.76, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 422.55, -3527.87, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 422.55, -3532.98, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 422.55, -3538.09, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 422.55, -3543.20, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 422.55, -3548.31, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 422.55, -3553.42, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 422.55, -3558.53, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 422.55, -3563.64, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 422.55, -3568.75, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 422.55, -3573.86, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 422.55, -3578.97, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 422.55, -3584.08, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 422.55, -3589.19, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 422.55, -3594.30, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 422.55, -3599.41, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 422.55, -3604.52, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 422.55, -3609.63, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 422.55, -3614.74, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(8558, 422.55, -3491.03, -0.98,   270.00, 0.00, 0.00);
        CreateDynamicObject(3458, 422.55, -3614.74, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 422.55, -3619.85, 0.20,   -4.50, 0.00, 0.00);
        CreateDynamicObject(3458, 422.55, -3624.94, 0.80,   -9.00, 0.00, 0.00);
        CreateDynamicObject(3458, 422.55, -3629.96, 1.80,   -13.50, 0.00, 0.00);
        CreateDynamicObject(3458, 422.55, -3634.89, 3.19,   -18.00, 0.00, 0.00);
        CreateDynamicObject(3458, 422.55, -3639.69, 4.96,   -22.50, 0.00, 0.00);
        CreateDynamicObject(3458, 422.55, -3644.34, 7.11,   -27.00, 0.00, 0.00);
        CreateDynamicObject(3458, 422.55, -3648.81, 9.61,   -31.50, 0.00, 0.00);
        CreateDynamicObject(3458, 422.55, -3653.06, 12.45,   -36.00, 0.00, 0.00);
        CreateDynamicObject(3458, 422.55, -3657.08, 15.62,   -40.50, 0.00, 0.00);
        CreateDynamicObject(3458, 422.55, -3660.84, 19.10,   -45.00, 0.00, 0.00);
        CreateDynamicObject(8558, 422.55, -3664.32, 22.86,   310.50, 0.00, 0.00);
        CreateDynamicObject(978, 429.97, -3664.82, 26.51,   0.00, 0.00, 0.00);
        CreateDynamicObject(978, 424.76, -3664.74, 26.52,   0.00, 0.00, 0.00);
        CreateDynamicObject(978, 415.47, -3664.75, 26.48,   0.00, 0.00, 0.00);
        CreateDynamicObject(3666, 442.67, -3664.76, 26.25,   0.00, 0.00, 0.00);
        CreateDynamicObject(3666, 434.56, -3664.49, 26.36,   0.00, 0.00, 0.00);
        CreateDynamicObject(3666, 410.83, -3664.43, 26.28,   0.00, 0.00, 0.00);
        CreateDynamicObject(3666, 402.44, -3664.73, 26.20,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 476.90, -3769.32, 12.45,   36.00, 0.00, 0.00);
        CreateDynamicObject(3458, 476.90, -3773.58, 9.61,   31.50, 0.00, 0.00);
        CreateDynamicObject(3458, 476.90, -3778.05, 7.11,   27.00, 0.00, 0.00);
        CreateDynamicObject(3458, 476.90, -3782.70, 4.96,   22.50, 0.00, 0.00);
        CreateDynamicObject(3458, 476.90, -3787.50, 3.19,   18.00, 0.00, 0.00);
        CreateDynamicObject(3458, 476.90, -3792.43, 1.80,   13.50, 0.00, 0.00);
        CreateDynamicObject(3458, 476.90, -3797.45, 0.80,   9.00, 0.00, 0.00);
        CreateDynamicObject(3458, 476.90, -3802.53, 0.20,   4.50, 0.00, 0.00);
        CreateDynamicObject(3458, 476.90, -3807.65, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(8558, 432.06, -3666.33, 25.37,   0.00, 90.00, 90.00);
        CreateDynamicObject(8558, 426.94, -3666.33, 25.37,   0.00, 90.00, 90.00);
        CreateDynamicObject(8558, 421.82, -3666.33, 25.37,   0.00, 90.00, 90.00);
        CreateDynamicObject(8558, 416.70, -3666.33, 25.37,   0.00, 90.00, 90.00);
        CreateDynamicObject(8558, 413.31, -3666.38, 25.37,   0.00, 90.00, 90.00);
        CreateDynamicObject(3458, 378.65, -3769.02, 12.45,   36.00, 0.00, 0.00);
        CreateDynamicObject(3458, 378.65, -3769.02, 12.45,   36.00, 0.00, 0.00);
        CreateDynamicObject(3458, 378.65, -3773.28, 9.61,   31.50, 0.00, 0.00);
        CreateDynamicObject(3458, 378.65, -3777.74, 7.11,   27.00, 0.00, 0.00);
        CreateDynamicObject(3458, 378.65, -3782.39, 4.96,   22.50, 0.00, 0.00);
        CreateDynamicObject(3458, 378.65, -3787.20, 3.19,   18.00, 0.00, 0.00);
        CreateDynamicObject(3458, 378.65, -3792.12, 1.80,   13.50, 0.00, 0.00);
        CreateDynamicObject(3458, 378.65, -3797.15, 0.80,   9.00, 0.00, 0.00);
        CreateDynamicObject(3458, 378.65, -3802.23, 0.20,   4.50, 0.00, 0.00);
        CreateDynamicObject(3458, 378.65, -3807.35, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 378.65, -3812.45, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 378.65, -3817.55, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 378.65, -3822.66, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 378.65, -3827.76, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 378.65, -3832.87, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 378.65, -3837.97, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 378.65, -3843.07, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 378.65, -3848.18, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 378.65, -3853.28, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 378.65, -3858.38, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 378.65, -3863.49, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 378.65, -3868.59, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 378.65, -3873.70, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 378.65, -3878.80, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 378.65, -3883.90, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 378.65, -3889.01, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 378.65, -3894.11, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 378.65, -3899.21, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 378.65, -3904.32, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 378.65, -3909.42, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 378.65, -3914.53, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 378.65, -3919.63, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 378.65, -3924.73, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 378.65, -3929.84, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 378.65, -3934.94, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 378.65, -3940.04, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 476.90, -3812.45, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 476.90, -3817.55, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 476.90, -3822.66, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 476.90, -3827.76, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 476.90, -3832.86, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 476.90, -3837.97, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 476.90, -3843.07, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 476.90, -3848.17, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 476.90, -3853.28, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 476.90, -3858.38, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 476.90, -3863.48, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 476.90, -3868.59, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 476.90, -3873.69, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 476.90, -3878.79, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 476.90, -3883.90, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 476.90, -3889.00, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 476.90, -3894.10, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 476.90, -3899.21, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 476.90, -3904.31, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 476.90, -3909.41, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 476.90, -3914.52, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 476.90, -3919.62, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 476.90, -3924.72, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 476.90, -3929.83, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 476.90, -3934.93, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 476.90, -3940.03, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 476.90, -3940.03, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 474.90, -3945.24, 0.33,   -7.20, 0.00, 0.00);
        CreateDynamicObject(3458, 472.90, -3950.37, 1.31,   -14.40, 0.00, 0.00);
        CreateDynamicObject(3458, 470.90, -3955.34, 2.92,   -21.60, 0.00, 0.00);
        CreateDynamicObject(3458, 468.90, -3960.07, 5.14,   -28.80, 0.00, 0.00);
        CreateDynamicObject(3458, 466.90, -3964.48, 7.94,   -36.00, 0.00, 0.00);
        CreateDynamicObject(3458, 464.90, -3968.50, 11.27,   -43.20, 0.00, 0.00);
        CreateDynamicObject(3458, 462.90, -3972.07, 15.08,   -50.40, 0.00, 0.00);
        CreateDynamicObject(3458, 460.90, -3975.14, 19.30,   -57.60, 0.00, 0.00);
        CreateDynamicObject(3458, 458.90, -3977.66, 23.88,   -64.80, 0.00, 0.00);
        CreateDynamicObject(3458, 456.90, -3979.58, 28.74,   -72.00, 0.00, 0.00);
        CreateDynamicObject(3458, 454.90, -3980.88, 33.79,   -79.20, 0.00, 0.00);
        CreateDynamicObject(3458, 452.90, -3981.54, 38.97,   -86.40, 0.00, 0.00);
        CreateDynamicObject(8558, 450.90, -3981.54, 44.20,   266.40, 0.00, 0.00);
        CreateDynamicObject(3458, 378.65, -3940.04, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 380.65, -3945.26, 0.33,   -7.20, 0.00, 0.00);
        CreateDynamicObject(3458, 382.65, -3950.39, 1.31,   -14.40, 0.00, 0.00);
        CreateDynamicObject(3458, 384.65, -3955.35, 2.92,   -21.60, 0.00, 0.00);
        CreateDynamicObject(3458, 386.65, -3960.08, 5.14,   -28.80, 0.00, 0.00);
        CreateDynamicObject(3458, 388.65, -3964.49, 7.94,   -36.00, 0.00, 0.00);
        CreateDynamicObject(3458, 390.65, -3968.51, 11.27,   -43.20, 0.00, 0.00);
        CreateDynamicObject(3458, 392.65, -3972.09, 15.08,   -50.40, 0.00, 0.00);
        CreateDynamicObject(3458, 394.65, -3975.16, 19.30,   -57.60, 0.00, 0.00);
        CreateDynamicObject(3458, 396.65, -3977.67, 23.88,   -64.80, 0.00, 0.00);
        CreateDynamicObject(3458, 398.65, -3979.59, 28.73,   -72.00, 0.00, 0.00);
        CreateDynamicObject(3458, 400.65, -3980.89, 33.79,   280.80, 0.00, 0.00);
        CreateDynamicObject(3458, 402.65, -3981.55, 38.97,   273.60, 0.00, 0.00);
        CreateDynamicObject(8558, 404.65, -3981.55, 44.20,   266.40, 0.00, 0.00);
        CreateDynamicObject(8558, 427.82, -3981.24, 49.13,   266.39, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -3980.61, 54.32,   259.85, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -3979.40, 59.39,   253.31, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -3977.62, 64.30,   246.76, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -3975.29, 68.98,   240.21, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -3972.44, 73.35,   233.67, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -3969.11, 77.38,   227.12, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -3965.34, 81.00,   220.58, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -3961.19, 84.16,   214.03, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -3956.70, 86.83,   207.49, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -3951.94, 88.97,   200.94, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -3946.96, 90.56,   194.40, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -3941.84, 91.57,   187.85, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -3936.63, 91.98,   181.31, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -3931.41, 91.80,   174.76, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -3926.25, 91.03,   168.21, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -3921.21, 89.67,   161.67, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -3916.35, 87.75,   155.12, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -3911.74, 85.29,   148.58, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -3907.45, 82.31,   142.03, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -3903.52, 78.87,   135.49, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -3900.02, 75.00,   128.94, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -3896.97, 70.76,   122.40, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -3894.43, 66.20,   115.85, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -3892.42, 61.38,   109.31, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -3890.98, 56.36,   102.76, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -3890.12, 51.21,   96.21, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -3889.85, 45.99,   89.67, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -3890.18, 40.78,   83.12, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -3891.10, 35.64,   76.58, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -3892.60, 30.64,   70.03, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -3894.66, 25.84,   63.49, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -3897.26, 21.31,   56.94, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -3900.35, 17.10,   50.40, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -3903.90, 13.27,   43.85, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -3907.87, 9.87,   37.31, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -3912.20, 6.95,   30.76, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -3916.83, 4.54,   24.21, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -3921.71, 2.67,   17.67, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -3926.77, 1.38,   11.12, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -3931.94, 0.66,   4.58, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -3937.16, 0.54,   358.03, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -3942.36, 1.02,   -8.51, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -3947.47, 2.09,   -15.06, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -3952.43, 3.73,   -21.60, 0.00, 0.00);
        CreateDynamicObject(8558, 427.82, -3957.17, 5.93,   331.85, 0.00, 0.00);
        CreateDynamicObject(7584, 469.74, -3413.02, -20.08,   44.00, 270.00, 270.00);
        CreateDynamicObject(7584, 377.60, -3412.76, -20.08,   316.01, 269.99, 270.00);
        CreateDynamicObject(7584, 423.72, -3421.33, 116.95,   0.00, 76.00, 91.50);
        CreateDynamicObject(8392, 467.48, -3545.10, 27.78,   0.00, 0.00, 90.00);
        CreateDynamicObject(8392, 377.67, -3545.10, 27.78,   0.00, 0.00, 90.00);
        CreateDynamicObject(16113, 452.79, -3518.58, -10.54,   0.00, 0.00, 122.00);
        CreateDynamicObject(16113, 455.03, -3566.43, -8.98,   0.00, 0.00, 132.00);
        CreateDynamicObject(16113, 391.24, -3511.72, -9.13,   0.00, 0.00, 307.00);
        CreateDynamicObject(16113, 388.70, -3559.15, -8.90,   0.00, 0.00, 315.00);
        CreateDynamicObject(709, 451.49, -3614.75, -1.96,   0.00, 0.00, 122.00);
        CreateDynamicObject(709, 395.60, -3614.75, -0.75,   0.00, 0.00, 132.00);
        CreateDynamicObject(6986, 429.41, -3664.82, 39.36,   0.00, 0.00, 270.00);
        CreateDynamicObject(6986, 415.73, -3664.64, 39.36,   0.00, 0.00, 90.00);
        CreateDynamicObject(7584, 427.33, -3833.36, 24.55,   180.00, 269.99, 270.00);
        CreateDynamicObject(8480, 563.58, -3853.18, -22.76,   0.00, 308.00, 180.00);
        CreateDynamicObject(8480, 291.28, -3882.16, -22.76,   0.00, 308.00, 0.00);
        CreateDynamicObject(16113, 519.29, -3802.36, -1.76,   0.00, 0.00, 18.00);
        CreateDynamicObject(16113, 332.08, -3799.40, -2.80,   0.00, 0.00, 82.00);
        CreateDynamicObject(8397, 515.97, -3790.12, -6.98,   0.00, 0.00, 0.00);
        CreateDynamicObject(8397, 515.97, -3790.12, -6.98,   0.00, 22.00, 0.00);
        CreateDynamicObject(8397, 515.97, -3790.12, -6.98,   0.00, 43.99, 0.00);
        CreateDynamicObject(8397, 515.97, -3790.12, -6.98,   0.00, 65.99, 0.00);
        CreateDynamicObject(8397, 341.98, -3784.83, -6.98,   0.00, 0.00, 0.00);
        CreateDynamicObject(8397, 341.98, -3784.83, -6.98,   0.00, 338.00, 0.00);
        CreateDynamicObject(8397, 341.98, -3784.83, -6.98,   0.00, 676.00, 0.00);
        CreateDynamicObject(8397, 341.98, -3784.83, -6.98,   0.00, 1014.00, 0.00);
        CreateDynamicObject(8558, 476.90, -3765.59, 13.66,   0.00, 0.00, 0.00);
        CreateDynamicObject(8558, 476.90, -3764.51, 12.64,   270.00, 0.00, 0.00);
        CreateDynamicObject(8558, 476.91, -3764.51, 7.61,   269.99, 0.00, 0.00);
        CreateDynamicObject(8558, 476.92, -3764.51, 2.59,   269.99, 0.00, 0.00);
        CreateDynamicObject(8558, 476.92, -3764.51, -2.44,   269.98, 0.00, 0.00);
        CreateDynamicObject(4550, 496.72, -3930.76, -65.54,   0.00, 38.00, 324.00);
        CreateDynamicObject(4550, 362.29, -3928.58, -65.54,   0.00, 322.00, 36.00);
        CreateDynamicObject(3510, 457.85, -3889.13, 1.53,   0.00, 0.00, 0.00);
        CreateDynamicObject(3510, 457.85, -3899.48, 1.53,   0.00, 0.00, 0.00);
        CreateDynamicObject(3510, 457.85, -3909.82, 1.53,   0.00, 0.00, 0.00);
        CreateDynamicObject(3510, 457.85, -3920.16, 1.53,   0.00, 0.00, 0.00);
        CreateDynamicObject(3510, 457.85, -3930.50, 1.53,   0.00, 0.00, 0.00);
        CreateDynamicObject(3510, 457.85, -3940.85, 1.53,   0.00, 0.00, 0.00);
        CreateDynamicObject(3510, 397.45, -3889.13, 1.53,   0.00, 0.00, 162.00);
        CreateDynamicObject(3510, 397.45, -3899.48, 1.53,   0.00, 0.00, 162.00);
        CreateDynamicObject(3510, 397.45, -3909.82, 1.53,   0.00, 0.00, 162.00);
        CreateDynamicObject(3510, 397.45, -3920.16, 1.53,   0.00, 0.00, 162.00);
        CreateDynamicObject(3510, 397.45, -3930.50, 1.53,   0.00, 0.00, 162.00);
        CreateDynamicObject(3510, 397.45, -3940.85, 1.53,   0.00, 0.00, 161.99);
        CreateDynamicObject(7584, 428.01, -4003.61, 124.32,   357.95, 67.34, 89.84);
        CreateDynamicObject(8558, 378.65, -3765.29, 13.67,   0.00, 0.00, 0.00);
        CreateDynamicObject(8558, 378.64, -3764.24, 12.67,   269.99, 0.00, 0.00);
        CreateDynamicObject(8558, 378.64, -3764.24, 7.71,   269.99, 0.00, 0.00);
        CreateDynamicObject(8558, 378.64, -3764.24, 2.75,   269.99, 0.00, 0.00);
        CreateDynamicObject(8558, 378.64, -3764.24, -2.21,   269.99, 0.00, 0.00);
        CreateDynamicObject(8397, 436.51, -3342.84, -3.39,   0.00, 0.00, 0.00);
        CreateDynamicObject(8397, 408.52, -3342.84, -3.39,   0.00, 0.00, 0.00);
        CreateDynamicObject(8558, 427.82, -4106.85, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -4111.96, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -4117.07, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -4122.18, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -4127.29, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -4132.40, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -4137.51, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -4142.62, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -4147.73, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -4152.83, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -4157.94, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -4163.05, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -4168.16, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -4173.27, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -4178.38, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -4183.49, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -4188.60, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -4193.71, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -4198.82, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -4203.93, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -4209.04, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -4214.15, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -4219.26, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -4224.37, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -4229.48, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -4234.59, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 427.82, -4239.70, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(8558, 427.82, -4105.76, -1.01,   270.00, 0.00, 0.00);
        CreateDynamicObject(3458, 408.43, -4244.85, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 448.80, -4244.92, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 458.02, -4254.45, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 398.17, -4254.45, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 467.24, -4263.97, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 476.46, -4273.50, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 485.68, -4283.03, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 494.90, -4292.56, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 504.12, -4302.09, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 513.34, -4311.62, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 522.56, -4321.14, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 531.78, -4330.67, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 541.00, -4340.20, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 550.22, -4349.73, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 559.44, -4359.26, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 568.66, -4368.79, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 577.88, -4378.31, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 587.10, -4387.84, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 596.32, -4397.37, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 605.54, -4406.90, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 614.76, -4416.43, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 623.98, -4425.96, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 633.20, -4435.48, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 642.42, -4445.01, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 651.64, -4454.54, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 660.85, -4464.07, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 670.07, -4473.60, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 679.29, -4483.13, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 688.51, -4492.65, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 697.73, -4502.18, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 706.95, -4511.71, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 716.17, -4521.24, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 725.39, -4530.77, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 734.65, -4541.27, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 387.92, -4264.04, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 377.67, -4273.64, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 367.42, -4283.24, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 357.17, -4292.84, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 346.91, -4302.44, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 336.66, -4312.04, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 326.41, -4321.64, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 316.16, -4331.24, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 305.91, -4340.84, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 295.65, -4350.44, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 285.40, -4360.04, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 275.15, -4369.64, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 264.90, -4379.23, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 254.65, -4388.83, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 244.40, -4398.43, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 234.14, -4408.03, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 223.89, -4417.63, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 213.64, -4427.23, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 203.39, -4436.83, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 193.14, -4446.43, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 182.88, -4456.03, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 172.63, -4465.63, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 162.38, -4475.23, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 152.13, -4484.82, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 141.88, -4494.42, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 131.62, -4504.02, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 121.37, -4513.62, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 111.12, -4523.22, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 100.87, -4532.82, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 90.62, -4542.42, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 100.87, -4552.35, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 725.39, -4552.25, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 716.23, -4562.28, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 111.12, -4562.28, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 121.37, -4572.20, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 131.62, -4582.13, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 141.88, -4592.06, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 152.13, -4601.99, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 162.38, -4611.92, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 172.63, -4621.84, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 182.88, -4631.77, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 193.14, -4641.70, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 203.39, -4651.63, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 213.64, -4661.56, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 223.89, -4671.49, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 234.14, -4681.41, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 244.40, -4691.34, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 254.65, -4701.27, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 264.90, -4711.20, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 275.15, -4721.13, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 285.40, -4731.06, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 295.66, -4740.98, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 305.91, -4750.91, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 316.16, -4760.84, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 326.41, -4770.77, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 336.66, -4780.70, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 346.92, -4790.62, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 357.17, -4800.55, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 367.42, -4810.48, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 377.67, -4820.41, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 387.92, -4830.34, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 398.17, -4840.27, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 408.43, -4850.19, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 707.07, -4572.20, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 697.91, -4582.13, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 688.74, -4592.06, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 679.58, -4601.99, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 670.42, -4611.92, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 661.26, -4621.84, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 652.09, -4631.77, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 642.93, -4641.70, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 633.77, -4651.63, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 624.61, -4661.56, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 615.45, -4671.49, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 606.28, -4681.41, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 597.12, -4691.34, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 587.96, -4701.27, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 578.80, -4711.20, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 569.64, -4721.13, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 560.47, -4731.06, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 551.31, -4740.98, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 542.15, -4750.91, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 532.99, -4760.84, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 523.83, -4770.77, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 514.66, -4780.70, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 505.50, -4790.62, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 496.34, -4800.55, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 487.18, -4810.48, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 478.01, -4820.41, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 468.85, -4830.34, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 459.69, -4840.27, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 450.53, -4850.19, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 408.43, -4850.19, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 412.43, -4855.41, 0.33,   -7.20, 0.00, 0.00);
        CreateDynamicObject(3458, 428.43, -4860.54, 1.31,   345.60, 0.00, 0.00);
        CreateDynamicObject(3458, 428.43, -4865.50, 2.92,   338.40, 0.00, 0.00);
        CreateDynamicObject(3458, 428.43, -4870.23, 5.14,   331.20, 0.00, 0.00);
        CreateDynamicObject(3458, 428.43, -4874.64, 7.94,   324.00, 0.00, 0.00);
        CreateDynamicObject(3458, 428.51, -4878.56, 11.27,   316.80, 0.00, 0.00);
        CreateDynamicObject(3458, 428.43, -4889.74, 28.74,   288.00, 0.00, 0.00);
        CreateDynamicObject(3458, 452.43, -4891.04, 33.79,   -79.20, 0.00, 0.00);
        CreateDynamicObject(3458, 456.43, -4891.70, 38.97,   -86.40, 0.00, 0.00);
        CreateDynamicObject(8558, 460.44, -4891.87, 44.15,   270.00, 0.00, 0.00);
        CreateDynamicObject(3458, 450.53, -4850.19, 0.00,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 446.53, -4855.41, 0.33,   -7.20, 0.00, 0.00);
        CreateDynamicObject(3458, 428.43, -4882.24, 15.08,   309.59, 0.00, 0.00);
        CreateDynamicObject(3458, 428.43, -4885.31, 19.30,   302.40, 0.00, 0.00);
        CreateDynamicObject(3458, 428.43, -4887.82, 23.88,   295.20, 0.00, 0.00);
        CreateDynamicObject(3458, 406.53, -4891.04, 33.79,   -79.20, 0.00, 0.00);
        CreateDynamicObject(3458, 402.53, -4891.70, 38.97,   -86.40, 0.00, 0.00);
        CreateDynamicObject(8558, 398.56, -4891.84, 44.12,   270.00, 0.00, 0.00);
        CreateDynamicObject(8558, 398.17, -4253.41, -1.06,   270.00, 0.00, 0.00);
        CreateDynamicObject(8558, 387.92, -4263.01, -1.06,   270.00, 180.00, 180.00);
        CreateDynamicObject(8558, 377.67, -4272.61, -1.06,   270.00, 360.00, 360.00);
        CreateDynamicObject(8558, 367.42, -4282.21, -1.06,   270.00, 540.00, 540.00);
        CreateDynamicObject(8558, 357.17, -4291.81, -1.06,   270.00, 720.00, 720.00);
        CreateDynamicObject(8558, 346.91, -4301.41, -1.06,   270.00, 900.00, 900.00);
        CreateDynamicObject(8558, 336.66, -4311.01, -1.06,   270.00, 1080.00, 1080.00);
        CreateDynamicObject(8558, 326.41, -4320.61, -1.06,   270.00, 1260.00, 1260.00);
        CreateDynamicObject(8558, 316.16, -4330.21, -1.06,   270.00, 1440.00, 1440.00);
        CreateDynamicObject(8558, 305.91, -4339.81, -1.06,   270.00, 1620.00, 1620.00);
        CreateDynamicObject(8558, 295.65, -4349.41, -1.06,   270.00, 1800.00, 1800.00);
        CreateDynamicObject(8558, 285.40, -4359.01, -1.06,   270.00, 1980.00, 1980.00);
        CreateDynamicObject(8558, 275.15, -4368.61, -1.06,   270.00, 2160.00, 2160.00);
        CreateDynamicObject(8558, 264.90, -4378.21, -1.06,   270.00, 2340.00, 2340.00);
        CreateDynamicObject(8558, 254.65, -4387.81, -1.06,   270.00, 2520.00, 2520.00);
        CreateDynamicObject(8558, 244.40, -4397.41, -1.06,   270.00, 2700.00, 2700.00);
        CreateDynamicObject(8558, 234.14, -4407.01, -1.06,   270.00, 2880.00, 2880.00);
        CreateDynamicObject(8558, 223.89, -4416.61, -1.06,   270.00, 3060.00, 3060.00);
        CreateDynamicObject(8558, 213.64, -4426.21, -1.06,   270.00, 3240.00, 3240.00);
        CreateDynamicObject(8558, 203.39, -4435.81, -1.06,   270.00, 3420.00, 3420.00);
        CreateDynamicObject(8558, 193.14, -4445.41, -1.06,   270.00, 3600.00, 3600.00);
        CreateDynamicObject(8558, 182.88, -4455.01, -1.06,   270.00, 3780.00, 3780.00);
        CreateDynamicObject(8558, 172.63, -4464.61, -1.06,   270.00, 3960.00, 3960.00);
        CreateDynamicObject(8558, 162.38, -4474.21, -1.06,   270.00, 4140.00, 4140.00);
        CreateDynamicObject(8558, 152.13, -4483.81, -1.06,   270.00, 4320.00, 4320.00);
        CreateDynamicObject(8558, 141.88, -4493.41, -1.06,   270.00, 4500.00, 4500.00);
        CreateDynamicObject(8558, 131.62, -4503.01, -1.06,   270.00, 4680.00, 4680.00);
        CreateDynamicObject(8558, 121.37, -4512.61, -1.06,   270.00, 4860.00, 4860.00);
        CreateDynamicObject(8558, 111.12, -4522.21, -1.06,   270.00, 5040.00, 5040.00);
        CreateDynamicObject(8558, 100.87, -4531.81, -1.06,   270.00, 5220.00, 5220.00);
        CreateDynamicObject(8558, 90.62, -4541.41, -1.06,   270.00, 0.00, 0.00);
        CreateDynamicObject(8558, 100.87, -4551.31, -1.05,   270.00, 0.00, 0.00);
        CreateDynamicObject(8558, 111.12, -4561.24, -1.05,   270.00, 180.00, 180.00);
        CreateDynamicObject(8558, 121.37, -4571.17, -1.05,   270.00, 0.00, 0.00);
        CreateDynamicObject(8558, 131.62, -4581.09, -1.05,   270.00, 0.00, 0.00);
        CreateDynamicObject(8558, 141.88, -4591.02, -1.05,   270.00, 0.00, 0.00);
        CreateDynamicObject(8558, 152.13, -4600.95, -1.05,   270.00, 0.00, 0.00);
        CreateDynamicObject(8558, 162.38, -4610.88, -1.05,   270.00, 0.00, 0.00);
        CreateDynamicObject(8558, 172.63, -4620.81, -1.05,   270.00, 0.00, 0.00);
        CreateDynamicObject(8558, 182.88, -4630.73, -1.05,   270.00, 0.00, 0.00);
        CreateDynamicObject(8558, 193.14, -4640.66, -1.05,   270.00, 0.00, 0.00);
        CreateDynamicObject(8558, 203.39, -4650.59, -1.05,   270.00, 0.00, 0.00);
        CreateDynamicObject(8558, 213.64, -4660.52, -1.05,   270.00, 0.00, 0.00);
        CreateDynamicObject(8558, 223.89, -4670.44, -1.05,   270.00, 0.00, 0.00);
        CreateDynamicObject(8558, 234.14, -4680.37, -1.05,   270.00, 0.00, 0.00);
        CreateDynamicObject(8558, 244.40, -4690.30, -1.05,   270.00, 0.00, 0.00);
        CreateDynamicObject(8558, 254.65, -4700.23, -1.05,   270.00, 0.00, 0.00);
        CreateDynamicObject(8558, 264.90, -4710.16, -1.05,   270.00, 0.00, 0.00);
        CreateDynamicObject(8558, 275.15, -4720.08, -1.05,   270.00, 0.00, 0.00);
        CreateDynamicObject(8558, 285.40, -4730.01, -1.05,   270.00, 0.00, 0.00);
        CreateDynamicObject(8558, 295.66, -4739.94, -1.05,   270.00, 0.00, 0.00);
        CreateDynamicObject(8558, 305.91, -4749.87, -1.05,   270.00, 0.00, 0.00);
        CreateDynamicObject(8558, 316.16, -4759.79, -1.05,   270.00, 0.00, 0.00);
        CreateDynamicObject(8558, 326.41, -4769.72, -1.05,   270.00, 0.00, 0.00);
        CreateDynamicObject(8558, 336.66, -4779.65, -1.05,   270.00, 0.00, 0.00);
        CreateDynamicObject(8558, 346.92, -4789.58, -1.05,   270.00, 0.00, 0.00);
        CreateDynamicObject(8558, 357.17, -4799.50, -1.05,   270.00, 0.00, 0.00);
        CreateDynamicObject(8558, 367.42, -4809.43, -1.05,   270.00, 0.00, 0.00);
        CreateDynamicObject(8558, 377.67, -4819.36, -1.05,   270.00, 0.00, 0.00);
        CreateDynamicObject(8558, 387.92, -4829.29, -1.05,   270.00, 0.00, 0.00);
        CreateDynamicObject(8558, 398.17, -4839.22, -1.05,   270.00, 0.00, 0.00);
        CreateDynamicObject(8558, 408.43, -4849.14, -1.05,   270.00, 0.00, 0.00);
        CreateDynamicObject(8882, 444.49, -4311.18, -6.11,   0.00, 0.00, 242.00);
        CreateDynamicObject(8882, 378.58, -4334.72, -5.35,   0.00, 4.00, 336.00);
        CreateDynamicObject(8397, 427.85, -4250.53, -16.05,   0.00, 0.00, 0.00);
        CreateDynamicObject(8558, 408.42, -4243.81, -1.06,   270.00, 179.99, 179.99);
        CreateDynamicObject(8558, 458.02, -4253.41, -1.06,   270.00, 179.99, 179.99);
        CreateDynamicObject(8558, 467.24, -4262.94, -1.06,   270.00, 179.99, 179.99);
        CreateDynamicObject(8558, 476.46, -4272.47, -1.06,   270.00, 179.99, 179.99);
        CreateDynamicObject(8558, 485.68, -4282.00, -1.06,   270.00, 179.99, 179.99);
        CreateDynamicObject(8558, 494.90, -4291.52, -1.06,   270.00, 179.99, 179.99);
        CreateDynamicObject(8558, 504.12, -4301.05, -1.06,   270.00, 179.99, 179.99);
        CreateDynamicObject(8558, 513.34, -4310.58, -1.06,   270.00, 179.99, 179.99);
        CreateDynamicObject(8558, 522.56, -4320.11, -1.06,   270.00, 179.99, 179.99);
        CreateDynamicObject(8558, 531.78, -4329.64, -1.06,   270.00, 179.99, 179.99);
        CreateDynamicObject(8558, 541.00, -4339.17, -1.06,   270.00, 179.99, 179.99);
        CreateDynamicObject(8558, 550.22, -4348.69, -1.06,   270.00, 179.99, 179.99);
        CreateDynamicObject(8558, 559.44, -4358.22, -1.06,   270.00, 179.99, 179.99);
        CreateDynamicObject(8558, 568.66, -4367.75, -1.06,   270.00, 179.99, 179.99);
        CreateDynamicObject(8558, 577.88, -4377.28, -1.06,   270.00, 179.99, 179.99);
        CreateDynamicObject(8558, 587.10, -4386.81, -1.06,   270.00, 179.99, 179.99);
        CreateDynamicObject(8558, 596.32, -4396.34, -1.06,   270.00, 179.99, 179.99);
        CreateDynamicObject(8558, 605.54, -4405.86, -1.06,   270.00, 179.99, 179.99);
        CreateDynamicObject(8558, 614.76, -4415.39, -1.06,   270.00, 179.99, 179.99);
        CreateDynamicObject(8558, 623.98, -4424.92, -1.06,   270.00, 179.99, 179.99);
        CreateDynamicObject(8558, 633.20, -4434.45, -1.06,   270.00, 179.99, 179.99);
        CreateDynamicObject(8558, 642.42, -4443.98, -1.06,   270.00, 179.99, 179.99);
        CreateDynamicObject(8558, 651.64, -4453.51, -1.06,   270.00, 179.99, 179.99);
        CreateDynamicObject(8558, 660.85, -4463.03, -1.06,   270.00, 179.99, 179.99);
        CreateDynamicObject(8558, 670.07, -4472.56, -1.06,   270.00, 179.99, 179.99);
        CreateDynamicObject(8558, 679.29, -4482.09, -1.06,   270.00, 179.99, 179.99);
        CreateDynamicObject(8558, 688.51, -4491.62, -1.06,   270.00, 179.99, 179.99);
        CreateDynamicObject(8558, 697.73, -4501.15, -1.06,   270.00, 179.99, 179.99);
        CreateDynamicObject(8558, 706.95, -4510.68, -1.06,   270.00, 179.99, 179.99);
        CreateDynamicObject(8558, 716.17, -4520.20, -1.06,   270.00, 179.99, 179.99);
        CreateDynamicObject(8558, 725.39, -4529.73, -1.06,   270.00, 179.99, 179.99);
        CreateDynamicObject(8558, 448.80, -4243.88, -1.06,   270.00, 179.99, 179.99);
        CreateDynamicObject(8558, 725.39, -4551.21, -1.07,   270.00, 179.99, 179.99);
        CreateDynamicObject(8558, 716.23, -4561.24, -1.07,   270.00, 180.00, 180.00);
        CreateDynamicObject(8558, 707.07, -4571.17, -1.07,   270.00, 179.99, 179.99);
        CreateDynamicObject(8558, 697.91, -4581.10, -1.07,   270.00, 179.99, 179.99);
        CreateDynamicObject(8558, 688.74, -4591.03, -1.07,   270.00, 179.99, 179.99);
        CreateDynamicObject(8558, 679.58, -4600.96, -1.07,   270.00, 179.98, 179.98);
        CreateDynamicObject(8558, 670.42, -4610.89, -1.07,   270.00, 179.98, 179.98);
        CreateDynamicObject(8558, 661.26, -4620.81, -1.07,   270.00, 179.97, 179.97);
        CreateDynamicObject(8558, 652.09, -4630.74, -1.07,   270.00, 179.97, 179.97);
        CreateDynamicObject(8558, 642.93, -4640.67, -1.07,   270.00, 179.97, 179.97);
        CreateDynamicObject(8558, 633.77, -4650.60, -1.07,   270.00, 179.96, 179.96);
        CreateDynamicObject(8558, 624.61, -4660.53, -1.07,   270.00, 179.96, 179.96);
        CreateDynamicObject(8558, 615.45, -4670.46, -1.07,   270.00, 179.95, 179.95);
        CreateDynamicObject(8558, 606.28, -4680.39, -1.07,   270.00, 179.95, 179.95);
        CreateDynamicObject(8558, 597.12, -4690.32, -1.07,   270.00, 179.95, 179.95);
        CreateDynamicObject(8558, 587.96, -4700.25, -1.07,   270.00, 179.94, 179.94);
        CreateDynamicObject(8558, 578.80, -4710.18, -1.07,   270.00, 179.94, 179.94);
        CreateDynamicObject(8558, 569.64, -4720.11, -1.07,   270.00, 179.93, 179.93);
        CreateDynamicObject(8558, 560.47, -4730.04, -1.07,   270.00, 179.93, 179.93);
        CreateDynamicObject(8558, 551.31, -4739.97, -1.07,   270.00, 179.93, 179.93);
        CreateDynamicObject(8558, 542.15, -4749.89, -1.07,   270.00, 179.92, 179.92);
        CreateDynamicObject(8558, 532.99, -4759.82, -1.07,   270.00, 179.92, 179.92);
        CreateDynamicObject(8558, 523.83, -4769.75, -1.07,   270.00, 179.91, 179.91);
        CreateDynamicObject(8558, 514.66, -4779.68, -1.07,   270.00, 179.91, 179.91);
        CreateDynamicObject(8558, 505.50, -4789.61, -1.07,   270.00, 179.91, 179.91);
        CreateDynamicObject(8558, 496.34, -4799.54, -1.07,   270.00, 179.90, 179.90);
        CreateDynamicObject(8558, 487.18, -4809.47, -1.07,   270.00, 179.90, 179.90);
        CreateDynamicObject(8558, 478.01, -4819.40, -1.07,   270.00, 179.89, 179.89);
        CreateDynamicObject(8558, 468.85, -4829.33, -1.07,   270.00, 179.89, 179.89);
        CreateDynamicObject(8558, 459.69, -4839.26, -1.07,   270.00, 179.89, 179.89);
        CreateDynamicObject(8558, 450.53, -4849.19, -1.07,   270.00, 179.88, 179.88);
        CreateDynamicObject(8397, 429.42, -4849.97, -18.34,   0.00, 0.00, 0.00);
        CreateDynamicObject(8558, 734.65, -4540.21, -1.07,   270.00, 179.99, 179.99);
        CreateDynamicObject(8171, 734.79, -4538.68, 1.52,   0.00, 180.00, 0.00);
        CreateDynamicObject(8171, 84.54, -4538.88, 1.48,   0.00, 180.00, 0.00);
        CreateDynamicObject(8171, 146.86, -4594.53, 1.53,   0.00, 179.99, 44.75);
        CreateDynamicObject(8558, 563.08, -4881.24, 38.94,   82.80, 0.00, 0.00);
        CreateDynamicObject(3458, 567.08, -4882.22, 33.81,   75.60, 0.00, 0.00);
        CreateDynamicObject(3458, 571.08, -4883.83, 28.84,   68.40, 0.00, 0.00);
        CreateDynamicObject(3458, 575.08, -4886.06, 24.11,   61.20, 0.00, 0.00);
        CreateDynamicObject(3458, 579.08, -4888.86, 19.70,   54.00, 0.00, 0.00);
        CreateDynamicObject(3458, 583.08, -4892.19, 15.68,   46.80, 0.00, 0.00);
        CreateDynamicObject(3458, 587.08, -4895.99, 12.11,   39.60, 0.00, 0.00);
        CreateDynamicObject(3458, 591.08, -4900.22, 9.04,   32.40, 0.00, 0.00);
        CreateDynamicObject(3458, 595.08, -4904.79, 6.52,   25.20, 0.00, 0.00);
        CreateDynamicObject(3458, 599.08, -4909.65, 4.60,   18.00, 0.00, 0.00);
        CreateDynamicObject(3458, 603.08, -4914.71, 3.30,   10.80, 0.00, 0.00);
        CreateDynamicObject(3458, 607.08, -4919.89, 2.82,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 607.08, -4924.98, 2.82,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 607.08, -4930.07, 2.82,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 607.08, -4935.16, 2.82,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 607.08, -4940.25, 2.82,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 607.08, -4945.35, 2.82,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 607.08, -4950.44, 2.82,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 607.08, -4955.53, 2.82,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 607.08, -4960.62, 2.82,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 607.08, -4965.71, 2.82,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 607.08, -4970.80, 2.82,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 607.08, -4975.89, 2.82,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 607.08, -4980.99, 2.82,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 607.08, -4986.08, 2.82,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 607.08, -4991.17, 2.82,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 607.08, -4996.26, 2.82,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 607.08, -5001.35, 2.82,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 607.08, -5006.44, 2.82,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 607.08, -5011.53, 2.82,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 607.08, -5016.62, 2.82,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 607.08, -5021.72, 2.82,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 607.08, -5026.81, 2.82,   0.00, 0.00, 0.00);
        CreateDynamicObject(3437, 433.21, -3664.64, 51.13,   0.00, 0.00, 0.00);
        CreateDynamicObject(3437, 430.98, -3664.64, 51.13,   0.00, 0.00, 0.00);
        CreateDynamicObject(3437, 428.75, -3664.64, 51.13,   0.00, 0.00, 0.00);
        CreateDynamicObject(3437, 426.51, -3664.64, 51.13,   0.00, 0.00, 0.00);
        CreateDynamicObject(3437, 424.28, -3664.32, 51.13,   0.00, 0.00, 0.00);
        CreateDynamicObject(3437, 422.04, -3664.37, 51.13,   0.00, 0.00, 0.00);
        CreateDynamicObject(3437, 419.82, -3664.64, 51.13,   0.00, 0.00, 0.00);
        CreateDynamicObject(3437, 417.59, -3664.64, 51.13,   0.00, 0.00, 0.00);
        CreateDynamicObject(3437, 415.35, -3664.64, 51.13,   0.00, 0.00, 0.00);
        CreateDynamicObject(3437, 413.12, -3664.64, 51.13,   0.00, 0.00, 0.00);
        CreateDynamicObject(3437, 412.09, -3664.67, 51.13,   0.00, 0.00, 0.00);
        CreateDynamicObject(8171, 686.65, -4591.96, 1.52,   0.00, 179.99, 316.00);
        CreateDynamicObject(8882, 495.71, -4369.03, 0.02,   0.00, 0.00, 242.00);
        CreateDynamicObject(8882, 565.63, -4435.07, 0.02,   0.00, 0.00, 252.00);
        CreateDynamicObject(8882, 637.39, -4509.69, 0.02,   0.00, 0.00, 261.99);
        CreateDynamicObject(8882, 620.08, -4575.61, 1.26,   0.00, 0.00, 169.99);
        CreateDynamicObject(8882, 554.51, -4646.55, 4.43,   0.00, 0.00, 169.99);
        CreateDynamicObject(8882, 492.23, -4721.92, 5.03,   0.00, 0.00, 169.99);
        CreateDynamicObject(8882, 305.16, -4410.06, 2.26,   0.00, 4.00, 335.99);
        CreateDynamicObject(8882, 237.02, -4472.41, 1.90,   0.00, 4.00, 337.49);
        CreateDynamicObject(8882, 176.64, -4546.35, 4.68,   0.00, 354.00, 5.49);
        CreateDynamicObject(8882, 238.21, -4609.49, 9.90,   0.00, 0.00, 67.49);
        CreateDynamicObject(8882, 314.29, -4676.13, -2.37,   0.00, 0.00, 67.49);
        CreateDynamicObject(8882, 379.65, -4750.79, 1.20,   0.00, 0.00, 67.49);
        CreateDynamicObject(8558, 280.30, -4881.24, 38.94,   82.80, 0.00, 0.00);
        CreateDynamicObject(3458, 276.30, -4882.22, 33.81,   75.60, 0.00, 0.00);
        CreateDynamicObject(3458, 272.30, -4883.83, 28.84,   68.40, 0.00, 0.00);
        CreateDynamicObject(3458, 268.30, -4886.06, 24.11,   61.20, 0.00, 0.00);
        CreateDynamicObject(3458, 264.30, -4888.86, 19.70,   54.00, 0.00, 0.00);
        CreateDynamicObject(3458, 260.30, -4892.19, 15.68,   46.80, 0.00, 0.00);
        CreateDynamicObject(3458, 256.30, -4895.99, 12.11,   39.60, 0.00, 0.00);
        CreateDynamicObject(3458, 252.30, -4900.22, 9.04,   32.40, 0.00, 0.00);
        CreateDynamicObject(3458, 248.30, -4904.79, 6.52,   25.20, 0.00, 0.00);
        CreateDynamicObject(3458, 244.30, -4909.65, 4.60,   18.00, 0.00, 0.00);
        CreateDynamicObject(3458, 240.30, -4914.71, 3.30,   10.80, 0.00, 0.00);
        CreateDynamicObject(3458, 236.30, -4919.89, 2.82,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 236.30, -4924.98, 2.82,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 236.30, -4930.07, 2.82,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 236.30, -4935.16, 2.82,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 236.30, -4940.25, 2.82,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 236.30, -4945.35, 2.82,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 236.30, -4950.44, 2.82,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 236.30, -4955.53, 2.82,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 236.30, -4960.62, 2.82,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 236.30, -4965.71, 2.82,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 236.30, -4970.80, 2.82,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 236.30, -4975.89, 2.82,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 236.30, -4980.99, 2.82,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 236.30, -4986.08, 2.82,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 236.30, -4991.17, 2.82,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 236.30, -4996.26, 2.82,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 236.30, -5001.35, 2.82,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 236.30, -5006.44, 2.82,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 236.30, -5011.53, 2.82,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 236.30, -5016.62, 2.82,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 236.30, -5021.72, 2.82,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 236.30, -5026.81, 2.82,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 236.30, -5026.81, 2.82,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 238.30, -5031.92, 2.98,   -3.60, 0.00, 0.00);
        CreateDynamicObject(3458, 240.30, -5037.02, 3.46,   -7.20, 0.00, 0.00);
        CreateDynamicObject(3458, 242.30, -5042.08, 4.26,   -10.80, 0.00, 0.00);
        CreateDynamicObject(3458, 244.30, -5047.08, 5.38,   -14.40, 0.00, 0.00);
        CreateDynamicObject(3458, 246.30, -5051.99, 6.81,   -18.00, 0.00, 0.00);
        CreateDynamicObject(3458, 248.30, -5056.81, 8.54,   -21.60, 0.00, 0.00);
        CreateDynamicObject(3458, 250.30, -5061.51, 10.58,   -25.20, 0.00, 0.00);
        CreateDynamicObject(3458, 252.30, -5066.07, 12.90,   -28.80, 0.00, 0.00);
        CreateDynamicObject(3458, 254.30, -5070.48, 15.51,   -32.40, 0.00, 0.00);
        CreateDynamicObject(3458, 256.30, -5074.71, 18.38,   -36.00, 0.00, 0.00);
        CreateDynamicObject(3458, 258.30, -5078.76, 21.52,   -39.60, 0.00, 0.00);
        CreateDynamicObject(3458, 260.30, -5082.60, 24.91,   -43.20, 0.00, 0.00);
        CreateDynamicObject(3458, 262.30, -5086.22, 28.53,   -46.80, 0.00, 0.00);
        CreateDynamicObject(3458, 264.30, -5089.60, 32.37,   -50.40, 0.00, 0.00);
        CreateDynamicObject(3458, 266.30, -5092.74, 36.42,   -54.00, 0.00, 0.00);
        CreateDynamicObject(3458, 268.30, -5095.62, 40.65,   -57.60, 0.00, 0.00);
        CreateDynamicObject(8558, 270.30, -5098.23, 45.06,   298.80, 0.00, 0.00);
        CreateDynamicObject(3458, 607.08, -5026.81, 2.82,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 605.08, -5031.92, 2.98,   -3.60, 0.00, 0.00);
        CreateDynamicObject(3458, 603.08, -5037.02, 3.46,   -7.20, 0.00, 0.00);
        CreateDynamicObject(3458, 601.08, -5042.08, 4.26,   -10.80, 0.00, 0.00);
        CreateDynamicObject(3458, 599.08, -5047.08, 5.38,   -14.40, 0.00, 0.00);
        CreateDynamicObject(3458, 597.08, -5051.99, 6.81,   -18.00, 0.00, 0.00);
        CreateDynamicObject(3458, 595.08, -5056.81, 8.54,   -21.60, 0.00, 0.00);
        CreateDynamicObject(3458, 593.08, -5061.51, 10.58,   -25.20, 0.00, 0.00);
        CreateDynamicObject(3458, 591.08, -5066.07, 12.90,   -28.80, 0.00, 0.00);
        CreateDynamicObject(3458, 589.08, -5070.48, 15.51,   -32.40, 0.00, 0.00);
        CreateDynamicObject(3458, 587.08, -5074.71, 18.38,   -36.00, 0.00, 0.00);
        CreateDynamicObject(3458, 585.08, -5078.76, 21.52,   -39.60, 0.00, 0.00);
        CreateDynamicObject(3458, 583.08, -5082.60, 24.91,   -43.20, 0.00, 0.00);
        CreateDynamicObject(3458, 581.08, -5086.22, 28.53,   -46.80, 0.00, 0.00);
        CreateDynamicObject(3458, 579.08, -5089.60, 32.37,   -50.40, 0.00, 0.00);
        CreateDynamicObject(3458, 577.08, -5092.74, 36.42,   -54.00, 0.00, 0.00);
        CreateDynamicObject(3458, 575.08, -5095.62, 40.65,   -57.60, 0.00, 0.00);
        CreateDynamicObject(8558, 573.08, -5098.23, 45.06,   298.80, 0.00, 0.00);
        CreateDynamicObject(8558, 511.66, -5171.35, 45.06,   61.20, 0.00, 0.00);
        CreateDynamicObject(3458, 509.66, -5173.96, 40.65,   57.60, 0.00, 0.00);
        CreateDynamicObject(3458, 507.66, -5176.84, 36.41,   54.00, 0.00, 0.00);
        CreateDynamicObject(3458, 505.66, -5179.97, 32.37,   50.40, 0.00, 0.00);
        CreateDynamicObject(3458, 503.66, -5183.36, 28.53,   46.80, 0.00, 0.00);
        CreateDynamicObject(3458, 501.66, -5186.98, 24.91,   43.20, 0.00, 0.00);
        CreateDynamicObject(3458, 499.66, -5190.82, 21.52,   39.60, 0.00, 0.00);
        CreateDynamicObject(3458, 497.66, -5194.87, 18.38,   36.00, 0.00, 0.00);
        CreateDynamicObject(3458, 495.66, -5199.10, 15.50,   32.40, 0.00, 0.00);
        CreateDynamicObject(3458, 493.66, -5203.51, 12.90,   28.80, 0.00, 0.00);
        CreateDynamicObject(3458, 491.66, -5208.07, 10.57,   25.20, 0.00, 0.00);
        CreateDynamicObject(3458, 489.66, -5212.77, 8.54,   21.60, 0.00, 0.00);
        CreateDynamicObject(3458, 487.66, -5217.58, 6.80,   18.00, 0.00, 0.00);
        CreateDynamicObject(3458, 485.66, -5222.50, 5.38,   14.40, 0.00, 0.00);
        CreateDynamicObject(3458, 483.66, -5227.50, 4.26,   10.80, 0.00, 0.00);
        CreateDynamicObject(3458, 481.66, -5232.55, 3.46,   7.20, 0.00, 0.00);
        CreateDynamicObject(3458, 479.66, -5237.65, 2.97,   3.60, 0.00, 0.00);
        CreateDynamicObject(3458, 477.66, -5242.77, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 477.66, -5247.86, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 477.66, -5252.95, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 477.66, -5258.04, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 477.66, -5263.13, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 477.66, -5268.21, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 477.66, -5273.30, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 477.66, -5278.39, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 477.66, -5283.48, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 477.66, -5288.57, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 477.66, -5293.66, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 477.66, -5298.75, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 477.66, -5303.84, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 477.66, -5308.92, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 477.66, -5314.01, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 477.66, -5319.10, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 477.66, -5324.19, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 477.66, -5329.28, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 477.66, -5334.37, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 477.66, -5339.46, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 477.66, -5344.55, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 477.66, -5349.64, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 477.66, -5354.72, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 477.66, -5359.81, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 477.66, -5364.90, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 477.66, -5369.99, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 477.66, -5375.08, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 477.66, -5380.17, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 477.66, -5385.26, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 477.66, -5390.35, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 477.66, -5395.44, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 477.66, -5400.52, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(8558, 336.98, -5171.35, 45.06,   61.20, 0.00, 0.00);
        CreateDynamicObject(3458, 338.98, -5173.96, 40.65,   57.60, 0.00, 0.00);
        CreateDynamicObject(3458, 340.98, -5176.84, 36.41,   54.00, 0.00, 0.00);
        CreateDynamicObject(3458, 342.98, -5179.97, 32.37,   50.40, 0.00, 0.00);
        CreateDynamicObject(3458, 344.98, -5183.36, 28.53,   46.80, 0.00, 0.00);
        CreateDynamicObject(3458, 346.98, -5186.98, 24.91,   43.20, 0.00, 0.00);
        CreateDynamicObject(3458, 348.98, -5190.82, 21.52,   39.60, 0.00, 0.00);
        CreateDynamicObject(3458, 350.98, -5194.87, 18.38,   36.00, 0.00, 0.00);
        CreateDynamicObject(3458, 352.98, -5199.10, 15.50,   32.40, 0.00, 0.00);
        CreateDynamicObject(3458, 354.98, -5203.51, 12.90,   28.80, 0.00, 0.00);
        CreateDynamicObject(3458, 356.98, -5208.07, 10.57,   25.20, 0.00, 0.00);
        CreateDynamicObject(3458, 358.98, -5212.77, 8.54,   21.60, 0.00, 0.00);
        CreateDynamicObject(3458, 360.98, -5217.58, 6.80,   18.00, 0.00, 0.00);
        CreateDynamicObject(3458, 362.98, -5222.50, 5.38,   14.40, 0.00, 0.00);
        CreateDynamicObject(3458, 364.98, -5227.50, 4.26,   10.80, 0.00, 0.00);
        CreateDynamicObject(3458, 366.98, -5232.55, 3.46,   7.20, 0.00, 0.00);
        CreateDynamicObject(3458, 368.98, -5237.65, 2.97,   3.60, 0.00, 0.00);
        CreateDynamicObject(3458, 370.98, -5242.77, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 370.98, -5247.86, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 370.98, -5252.95, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 370.98, -5258.04, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 370.98, -5263.13, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 370.98, -5268.21, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 370.98, -5273.30, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 370.98, -5278.39, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 370.98, -5283.48, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 370.98, -5288.57, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 370.98, -5293.66, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 370.98, -5298.75, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 370.98, -5303.84, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 370.98, -5308.92, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 370.98, -5314.01, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 370.98, -5319.10, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 370.98, -5324.19, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 370.98, -5329.28, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 370.98, -5334.37, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 370.98, -5339.46, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 370.98, -5344.55, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 370.98, -5349.64, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 370.98, -5354.72, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 370.98, -5359.81, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 370.98, -5364.90, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 370.98, -5369.99, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 370.98, -5375.08, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 370.98, -5380.17, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 370.98, -5385.26, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 370.98, -5390.35, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 370.98, -5395.44, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 370.98, -5400.52, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 477.66, -5400.52, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 475.66, -5405.74, 3.14,   -7.20, 0.00, 0.00);
        CreateDynamicObject(3458, 473.66, -5410.87, 4.12,   -14.40, 0.00, 0.00);
        CreateDynamicObject(3458, 471.66, -5415.83, 5.73,   -21.60, 0.00, 0.00);
        CreateDynamicObject(3458, 469.66, -5420.56, 7.96,   -28.80, 0.00, 0.00);
        CreateDynamicObject(3458, 467.66, -5424.97, 10.76,   -36.00, 0.00, 0.00);
        CreateDynamicObject(3458, 465.66, -5428.99, 14.09,   -43.20, 0.00, 0.00);
        CreateDynamicObject(3458, 463.66, -5432.57, 17.89,   -50.40, 0.00, 0.00);
        CreateDynamicObject(3458, 461.66, -5435.64, 22.12,   -57.60, 0.00, 0.00);
        CreateDynamicObject(3458, 459.66, -5438.15, 26.69,   -64.80, 0.00, 0.00);
        CreateDynamicObject(3458, 457.66, -5440.08, 31.55,   -72.00, 0.00, 0.00);
        CreateDynamicObject(3458, 455.66, -5441.37, 36.61,   -79.20, 0.00, 0.00);
        CreateDynamicObject(3458, 453.66, -5442.03, 41.79,   -86.40, 0.00, 0.00);
        CreateDynamicObject(8558, 451.66, -5442.03, 47.01,   266.40, 0.00, 0.00);
        CreateDynamicObject(3458, 370.98, -5400.52, 2.81,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 372.98, -5405.74, 3.14,   -7.20, 0.00, 0.00);
        CreateDynamicObject(3458, 374.98, -5410.87, 4.12,   -14.40, 0.00, 0.00);
        CreateDynamicObject(3458, 376.98, -5415.83, 5.73,   -21.60, 0.00, 0.00);
        CreateDynamicObject(3458, 378.98, -5420.56, 7.96,   -28.80, 0.00, 0.00);
        CreateDynamicObject(3458, 380.98, -5424.97, 10.76,   -36.00, 0.00, 0.00);
        CreateDynamicObject(3458, 382.98, -5428.99, 14.08,   -43.20, 0.00, 0.00);
        CreateDynamicObject(3458, 384.98, -5432.57, 17.89,   -50.40, 0.00, 0.00);
        CreateDynamicObject(3458, 386.98, -5435.64, 22.12,   -57.60, 0.00, 0.00);
        CreateDynamicObject(3458, 388.98, -5438.15, 26.69,   -64.80, 0.00, 0.00);
        CreateDynamicObject(3458, 390.98, -5440.08, 31.55,   -72.00, 0.00, 0.00);
        CreateDynamicObject(3458, 392.98, -5441.37, 36.61,   280.80, 0.00, 0.00);
        CreateDynamicObject(3458, 394.98, -5442.03, 41.79,   -86.40, 0.00, 0.00);
        CreateDynamicObject(8558, 396.98, -5442.03, 47.01,   266.40, 0.00, 0.00);
        CreateDynamicObject(8558, 424.56, -5441.74, 51.87,   266.39, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5441.12, 57.05,   259.85, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5439.91, 62.13,   253.31, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5438.12, 67.04,   246.76, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5435.79, 71.71,   240.21, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5432.94, 76.09,   233.67, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5429.61, 80.11,   227.12, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5425.85, 83.73,   220.58, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5421.69, 86.90,   214.03, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5417.21, 89.57,   207.49, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5412.44, 91.71,   200.94, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5407.47, 93.30,   194.40, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5402.34, 94.30,   187.85, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5397.14, 94.72,   181.31, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5391.92, 94.54,   174.76, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5386.75, 93.77,   168.21, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5381.71, 92.41,   161.67, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5376.85, 90.49,   155.12, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5372.25, 88.02,   148.58, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5367.96, 85.05,   142.03, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5364.03, 81.61,   135.49, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5360.52, 77.74,   128.94, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5357.47, 73.50,   122.40, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5354.93, 68.94,   115.85, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5352.93, 64.11,   109.31, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5351.48, 59.10,   102.76, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5350.62, 53.94,   96.21, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5350.36, 48.73,   89.67, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5350.68, 43.52,   83.12, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5351.60, 38.38,   76.58, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5353.10, 33.37,   70.03, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5355.17, 28.58,   63.49, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5357.76, 24.04,   56.94, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5360.85, 19.84,   50.40, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5364.41, 16.01,   43.85, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5368.37, 12.61,   37.31, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5372.70, 9.69,   30.76, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5377.33, 7.28,   24.21, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5382.21, 5.41,   17.67, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5387.27, 4.11,   11.12, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5392.44, 3.40,   4.58, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5397.67, 3.28,   -1.97, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5402.87, 3.76,   -8.51, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5407.98, 4.82,   -15.06, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5412.94, 6.47,   -21.60, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5417.67, 8.66,   -28.15, 0.00, 0.00);
        CreateDynamicObject(8558, 424.56, -5422.13, 11.39,   325.31, 0.00, 0.00);
        CreateDynamicObject(8558, 424.56, -5573.33, 11.39,   34.69, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5577.78, 8.66,   28.15, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5582.52, 6.47,   21.60, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5587.48, 4.82,   15.06, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5592.59, 3.76,   8.51, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5597.79, 3.36,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5602.88, 3.36,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5607.97, 3.36,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5613.06, 3.36,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5618.16, 3.36,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5623.25, 3.36,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5628.34, 3.36,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5633.43, 3.36,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5638.52, 3.36,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5643.61, 3.36,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5648.70, 3.36,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5653.79, 3.36,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5658.89, 3.36,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5663.98, 3.36,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5669.07, 3.36,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5674.16, 3.36,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5679.25, 3.36,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5684.34, 3.36,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5689.43, 3.36,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5694.52, 3.36,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5699.62, 3.36,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5704.71, 3.36,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5709.80, 3.36,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5714.89, 3.36,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5719.98, 3.36,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5725.07, 3.36,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5730.16, 3.36,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5735.26, 3.36,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5740.35, 3.36,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5745.44, 3.36,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5750.53, 3.36,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5755.62, 3.36,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5569.52, 12.58,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5564.47, 12.58,   0.00, 0.00, 0.00);
        CreateDynamicObject(8558, 424.56, -5563.41, 11.54,   270.00, 0.00, 0.00);
        CreateDynamicObject(8558, 424.56, -5563.41, 6.63,   269.99, 0.00, 0.00);
        CreateDynamicObject(8558, 424.56, -5563.41, 1.71,   269.99, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5755.62, 3.36,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5760.83, 3.68,   -7.20, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5765.96, 4.66,   -14.40, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5770.93, 6.28,   -21.60, 0.00, 0.00);
        CreateDynamicObject(3458, 424.56, -5775.65, 8.50,   -28.80, 0.00, 0.00);
        CreateDynamicObject(8558, 424.56, -5780.06, 11.30,   324.00, 0.00, 0.00);
        CreateDynamicObject(7584, 424.56, -5978.12, -14.88,   0.00, 270.00, 270.00);
        CreateDynamicObject(7584, 424.56, -5500.43, 109.16,   180.00, 270.00, 269.99);
        CreateDynamicObject(7584, 424.56, -5500.43, -16.24,   0.00, 270.00, 269.99);
        CreateDynamicObject(7584, 424.56, -6081.43, -14.88,   0.00, 270.00, 269.99);
        CreateDynamicObject(7584, 424.56, -6184.75, -14.88,   0.00, 270.00, 269.99);
        CreateDynamicObject(7584, 424.56, -6288.06, -14.88,   0.00, 270.00, 269.98);
        CreateDynamicObject(7584, 424.56, -6391.38, -14.88,   0.00, 270.00, 269.98);
        CreateDynamicObject(7584, 424.56, -6081.43, 100.84,   179.99, 270.00, 269.99);
        CreateDynamicObject(7584, 424.56, -6184.75, 101.96,   179.98, 270.00, 269.98);
        CreateDynamicObject(7584, 424.56, -6288.06, 102.65,   179.98, 270.00, 269.98);
        CreateDynamicObject(7584, 424.56, -6391.38, 103.08,   179.97, 270.00, 269.97);
        CreateDynamicObject(3458, 424.51, -6462.74, 14.91,   0.00, 0.00, 90.00);
        CreateDynamicObject(3458, 424.51, -6462.74, 14.91,   0.00, 0.00, 90.00);
        CreateDynamicObject(3458, 424.51, -6467.86, 15.08,   0.00, 3.71, 90.00);
        CreateDynamicObject(3458, 424.51, -6472.95, 15.58,   0.00, 7.42, 90.00);
        CreateDynamicObject(3458, 424.51, -6478.01, 16.40,   0.00, 11.13, 90.00);
        CreateDynamicObject(3458, 424.51, -6483.00, 17.55,   0.00, 14.85, 90.00);
        CreateDynamicObject(3458, 424.51, -6487.90, 19.02,   0.00, 18.56, 90.00);
        CreateDynamicObject(3458, 424.51, -6492.70, 20.81,   0.00, 22.27, 90.00);
        CreateDynamicObject(3458, 424.51, -6497.37, 22.90,   0.00, 25.98, 90.00);
        CreateDynamicObject(3458, 424.51, -6501.90, 25.29,   0.00, 29.69, 90.00);
        CreateDynamicObject(3458, 424.51, -6506.26, 27.97,   0.00, 33.40, 90.00);
        CreateDynamicObject(3458, 424.51, -6510.44, 30.93,   0.00, 37.11, 90.00);
        CreateDynamicObject(3458, 424.51, -6514.42, 34.15,   0.00, 40.82, 90.00);
        CreateDynamicObject(3458, 424.51, -6518.19, 37.62,   0.00, 44.54, 90.00);
        CreateDynamicObject(3458, 424.51, -6521.72, 41.32,   0.00, 48.25, 90.00);
        CreateDynamicObject(3458, 424.51, -6525.00, 45.25,   0.00, 51.96, 90.00);
        CreateDynamicObject(3458, 424.51, -6528.03, 49.38,   0.00, 55.67, 90.00);
        CreateDynamicObject(3458, 424.51, -6530.77, 53.70,   0.00, 59.38, 90.00);
        CreateDynamicObject(3458, 424.51, -6533.24, 58.19,   0.00, 63.09, 90.00);
        CreateDynamicObject(3458, 424.51, -6535.41, 62.83,   0.00, 66.80, 90.00);
        CreateDynamicObject(3458, 424.51, -6537.27, 67.60,   0.00, 70.52, 90.00);
        CreateDynamicObject(3458, 424.51, -6538.82, 72.48,   0.00, 74.23, 90.00);
        CreateDynamicObject(3458, 424.51, -6540.05, 77.45,   0.00, 77.94, 90.00);
        CreateDynamicObject(3458, 424.51, -6540.96, 82.49,   0.00, 81.65, 90.00);
        CreateDynamicObject(3458, 424.51, -6541.54, 87.58,   0.00, 85.36, 90.00);
        CreateDynamicObject(3458, 424.51, -6541.79, 92.69,   0.00, 89.07, 90.00);
        CreateDynamicObject(3458, 424.51, -6541.70, 97.81,   0.00, 92.78, 90.00);
        CreateDynamicObject(3458, 424.51, -6541.29, 102.91,   0.00, 96.49, 90.00);
        CreateDynamicObject(3458, 424.51, -6540.55, 107.98,   0.00, 100.21, 90.00);
        CreateDynamicObject(3458, 424.51, -6539.48, 112.98,   0.00, 103.92, 90.00);
        CreateDynamicObject(3458, 424.51, -6538.08, 117.91,   0.00, 107.63, 90.00);
        CreateDynamicObject(3458, 424.51, -6536.38, 122.74,   0.00, 111.34, 90.00);
        CreateDynamicObject(3458, 424.51, -6534.36, 127.44,   0.00, 115.05, 90.00);
        CreateDynamicObject(3458, 424.51, -6532.04, 132.01,   0.00, 118.76, 90.00);
        CreateDynamicObject(3458, 424.51, -6529.44, 136.42,   0.00, 122.47, 90.00);
        CreateDynamicObject(3458, 424.51, -6526.55, 140.64,   0.00, 126.19, 90.00);
        CreateDynamicObject(3458, 424.51, -6523.39, 144.68,   0.00, 129.90, 90.00);
        CreateDynamicObject(3458, 424.51, -6519.98, 148.50,   0.00, 133.61, 90.00);
        CreateDynamicObject(3458, 424.51, -6516.33, 152.09,   0.00, 137.32, 90.00);
        CreateDynamicObject(3458, 424.51, -6512.46, 155.43,   0.00, 141.03, 90.00);
        CreateDynamicObject(3458, 424.51, -6508.38, 158.52,   0.00, 144.74, 90.00);
        CreateDynamicObject(3458, 424.51, -6504.10, 161.34,   0.00, 148.45, 90.00);
        CreateDynamicObject(3458, 424.51, -6499.65, 163.88,   0.00, 152.16, 90.00);
        CreateDynamicObject(3458, 424.51, -6495.05, 166.12,   0.00, 155.88, 90.00);
        CreateDynamicObject(3458, 424.51, -6490.31, 168.06,   0.00, 159.59, 90.00);
        CreateDynamicObject(3458, 424.51, -6485.46, 169.69,   0.00, 163.30, 90.00);
        CreateDynamicObject(3458, 424.51, -6480.51, 171.00,   0.00, 167.01, 90.00);
        CreateDynamicObject(3458, 424.51, -6475.49, 171.99,   0.00, 170.72, 90.00);
        CreateDynamicObject(3458, 424.51, -6470.41, 172.65,   0.00, 174.43, 90.00);
        CreateDynamicObject(3458, 424.51, -6465.30, 172.98,   0.00, 178.14, 90.00);
        CreateDynamicObject(3458, 424.51, -6453.19, 172.98,   0.00, 181.85, 90.00);
        CreateDynamicObject(4002, 427.25, -4920.30, 22.28,   0.00, 0.00, 0.00);
        CreateDynamicObject(16113, 521.27, -5272.30, -3.64,   0.00, 0.00, 118.00);
        CreateDynamicObject(16113, 538.41, -5254.81, -1.40,   0.00, 0.00, 300.00);
        CreateDynamicObject(16113, 531.09, -5296.55, -3.36,   0.00, 0.00, 274.00);
        CreateDynamicObject(16113, 540.44, -5323.36, -1.68,   0.00, 0.00, 69.99);
        CreateDynamicObject(16113, 516.03, -5343.76, -1.16,   0.00, 0.00, 347.99);
        CreateDynamicObject(4550, 512.61, -5286.82, -129.95,   0.00, 18.00, 4.00);
        CreateDynamicObject(16113, 570.06, -5262.74, -8.15,   0.00, 0.00, 24.00);
        CreateDynamicObject(16113, 517.29, -5387.18, -1.20,   0.00, 0.00, 123.99);
        CreateDynamicObject(4550, 554.12, -5380.38, -113.18,   0.00, 10.00, 128.00);
        CreateDynamicObject(8480, 421.27, -5318.81, -41.76,   0.00, 310.00, 0.00);
        CreateDynamicObject(8480, 427.39, -5288.58, -41.57,   0.00, 310.00, 180.00);
        CreateDynamicObject(8397, 424.09, -5262.72, 20.14,   0.00, 0.00, 0.00);
        CreateDynamicObject(8397, 424.09, -5262.72, 20.14,   0.00, 20.00, 0.00);
        CreateDynamicObject(8397, 424.09, -5262.72, 20.14,   0.00, 40.00, 0.00);
        CreateDynamicObject(8397, 424.09, -5262.72, 20.14,   0.00, 60.00, 0.00);
        CreateDynamicObject(8397, 424.09, -5262.72, 20.14,   0.00, 80.00, 0.00);
        CreateDynamicObject(8397, 424.09, -5262.72, 20.14,   0.00, 340.00, 0.00);
        CreateDynamicObject(8397, 424.09, -5262.72, 20.14,   0.00, 680.01, 0.00);
        CreateDynamicObject(8397, 424.09, -5262.72, 20.14,   0.00, 1020.01, 0.00);
        CreateDynamicObject(8397, 424.09, -5262.72, 20.14,   0.00, 1360.02, 0.00);
        CreateDynamicObject(8882, 375.64, -4156.75, 0.08,   0.00, 0.00, 208.00);
        CreateDynamicObject(8882, 483.85, -4164.15, 2.77,   0.00, 0.00, 28.74);
        CreateDynamicObject(8397, 752.40, -4541.26, -26.71,   0.00, 0.00, 0.00);
        CreateDynamicObject(8397, 72.87, -4542.42, -26.71,   0.00, 0.00, 0.00);
        CreateDynamicObject(10947, 664.85, -4956.09, -10.04,   0.00, 90.00, 90.00);
        CreateDynamicObject(10947, 664.85, -4997.74, -10.04,   0.00, 90.00, 90.00);
        CreateDynamicObject(10947, 664.85, -5039.40, -10.04,   0.00, 90.00, 90.00);
        CreateDynamicObject(10947, 170.32, -4955.87, -3.92,   0.00, 90.00, 90.00);
        CreateDynamicObject(10947, 170.32, -4998.19, -3.92,   0.00, 90.00, 90.00);
        CreateDynamicObject(10947, 170.32, -5040.52, -3.92,   0.00, 90.00, 90.00);
        CreateDynamicObject(8397, 586.34, -5025.47, 0.00,   0.00, 306.00, 0.00);
        CreateDynamicObject(8397, 586.34, -5008.92, 0.00,   0.00, 306.00, 0.00);
        CreateDynamicObject(8397, 586.34, -4992.37, 0.00,   0.00, 305.99, 0.00);
        CreateDynamicObject(8397, 586.34, -4975.82, 0.00,   0.00, 305.99, 0.00);
        CreateDynamicObject(8397, 586.34, -4959.28, 0.00,   0.00, 305.99, 0.00);
        CreateDynamicObject(8397, 586.34, -4942.73, 0.00,   0.00, 305.98, 0.00);
        CreateDynamicObject(8397, 586.34, -4926.18, 0.00,   0.00, 305.97, 0.00);
        CreateDynamicObject(8397, 253.62, -4922.03, -2.24,   0.00, 54.03, 0.00);
        CreateDynamicObject(8397, 253.62, -4940.58, -2.24,   0.00, 54.02, 0.00);
        CreateDynamicObject(8397, 253.62, -4959.13, -2.24,   0.00, 54.01, 0.00);
        CreateDynamicObject(8397, 253.62, -4977.69, -2.24,   0.00, 54.01, 0.00);
        CreateDynamicObject(8397, 253.62, -4996.24, -2.24,   0.00, 54.00, 0.00);
        CreateDynamicObject(8397, 253.62, -5014.80, -2.24,   0.00, 54.00, 0.00);
        CreateDynamicObject(16113, 325.19, -5256.92, -1.40,   0.00, 0.00, 300.00);
        CreateDynamicObject(16113, 322.14, -5304.89, -2.24,   0.00, 2.00, 310.00);
        CreateDynamicObject(16113, 298.34, -5259.06, -1.68,   0.00, 0.00, 72.00);
        CreateDynamicObject(16113, 294.89, -5300.17, -2.24,   0.00, 0.00, 137.99);
        CreateDynamicObject(4550, 346.15, -5287.46, -129.95,   0.00, 342.00, 356.00);
        CreateDynamicObject(16113, 301.87, -5323.18, -2.87,   0.00, 2.00, 278.00);
        CreateDynamicObject(16113, 317.88, -5342.48, -8.56,   0.00, 2.00, 278.00);
        CreateDynamicObject(16113, 325.26, -5351.92, -5.87,   0.00, 2.00, 297.99);
        CreateDynamicObject(16113, 292.55, -5378.18, -3.24,   0.00, 2.00, 359.99);
        CreateDynamicObject(4550, 285.84, -5383.47, -113.18,   0.00, 350.01, 232.00);
        CreateDynamicObject(7584, 424.56, -5978.12, 99.72,   180.01, 270.00, 270.00);
        CreateDynamicObject(8397, 424.58, -5943.86, 138.54,   0.00, 0.00, 0.00);
        CreateDynamicObject(8397, 468.31, -2410.45, -25.77,   0.00, 0.00, 0.00);
        CreateDynamicObject(8397, 468.46, -2363.86, -25.77,   0.00, 0.00, 0.00);
        CreateDynamicObject(8397, 380.09, -2363.85, -25.77,   0.00, 0.00, 0.00);
        CreateDynamicObject(8397, 380.19, -2410.49, -25.77,   0.00, 0.00, 0.00);
        CreateDynamicObject(1226, 465.69, -2422.02, 8.28,   0.00, 0.00, 0.00);
        CreateDynamicObject(1226, 465.69, -2428.78, 8.28,   0.00, 0.00, 0.00);
        CreateDynamicObject(1226, 465.69, -2435.55, 8.28,   0.00, 0.00, 0.00);
        CreateDynamicObject(1226, 465.69, -2442.31, 8.28,   0.00, 0.00, 0.00);
        CreateDynamicObject(1226, 465.69, -2449.08, 8.28,   0.00, 0.00, 0.00);
        CreateDynamicObject(1226, 465.69, -2455.84, 8.28,   0.00, 0.00, 0.00);
        CreateDynamicObject(1226, 465.69, -2462.60, 8.28,   0.00, 0.00, 0.00);
        CreateDynamicObject(1226, 465.69, -2469.37, 8.28,   0.00, 0.00, 0.00);
        CreateDynamicObject(1226, 465.69, -2476.13, 8.28,   0.00, 0.00, 0.00);
        CreateDynamicObject(1226, 465.69, -2482.89, 8.28,   0.00, 0.00, 0.00);
        CreateDynamicObject(1226, 465.69, -2489.66, 8.28,   0.00, 0.00, 0.00);
        CreateDynamicObject(1226, 465.69, -2496.42, 8.28,   0.00, 0.00, 0.00);
        CreateDynamicObject(1226, 378.41, -2422.02, 8.27,   0.00, 0.00, 180.00);
        CreateDynamicObject(1226, 378.41, -2428.78, 8.27,   0.00, 0.00, 179.99);
        CreateDynamicObject(1226, 378.41, -2435.55, 8.27,   0.00, 0.00, 179.99);
        CreateDynamicObject(1226, 378.41, -2442.31, 8.27,   0.00, 0.00, 179.98);
        CreateDynamicObject(1226, 378.41, -2449.08, 8.27,   0.00, 0.00, 179.98);
        CreateDynamicObject(1226, 378.41, -2455.84, 8.27,   0.00, 0.00, 179.97);
        CreateDynamicObject(1226, 378.41, -2462.60, 8.27,   0.00, 0.00, 179.97);
        CreateDynamicObject(1226, 378.41, -2469.37, 8.27,   0.00, 0.00, 179.96);
        CreateDynamicObject(1226, 378.41, -2476.13, 8.27,   0.00, 0.00, 179.96);
        CreateDynamicObject(1226, 378.41, -2482.89, 8.28,   0.00, 0.00, 179.95);
        CreateDynamicObject(1226, 378.41, -2489.66, 8.28,   0.00, 0.00, 179.95);
        CreateDynamicObject(1226, 378.41, -2496.42, 8.28,   0.00, 0.00, 179.94);
        CreateDynamicObject(7584, 422.88, -2623.91, 66.46,   0.00, 112.00, 91.50);
        CreateDynamicObject(3666, 447.70, -2413.09, 4.97,   0.00, 0.00, 0.00);
        CreateDynamicObject(3666, 462.63, -2413.06, 4.97,   0.00, 0.00, 0.00);
        CreateDynamicObject(3666, 404.30, -2413.16, 4.97,   0.00, 0.00, 0.00);
        CreateDynamicObject(3666, 385.97, -2413.35, 4.97,   0.00, 0.00, 0.00);
        CreateDynamicObject(18752, -3356.93, -422.43, 0.08,   0.00, 0.00, 0.00);
        CreateDynamicObject(3458, 442.48, -2415.42, 2.89,   0.00, 0.00, 0.00);
        CreateDynamicObject(16113, 396.05, -2327.07, 6.23,   36.58, 27.81, 288.55);
        CreateDynamicObject(8171, 360.15, -4289.94, 1.37,   0.00, 180.00, 314.00);
        CreateDynamicObject(8171, 261.28, -4385.81, 1.37,   0.00, 180.00, 314.00);
        CreateDynamicObject(8171, 164.51, -4479.31, 1.47,   0.00, 180.00, 314.00);
        CreateDynamicObject(8171, 110.20, -4554.78, 1.48,   0.00, 180.00, 43.97);
        CreateDynamicObject(8171, 226.70, -4674.28, 1.53,   0.00, 179.99, 44.75);
        CreateDynamicObject(8171, 323.39, -4771.97, 1.53,   0.00, 179.99, 44.75);
        CreateDynamicObject(8171, 414.51, -4863.72, 1.53,   0.00, 179.99, 44.75);
        CreateDynamicObject(8171, 488.94, -4286.73, 1.36,   0.00, 0.00, 43.63);
        CreateDynamicObject(8171, 580.57, -4383.21, 1.36,   0.00, 0.00, 43.63);
        CreateDynamicObject(8171, 669.67, -4474.77, 1.36,   0.00, 0.00, 43.63);
        CreateDynamicObject(8171, 730.58, -4538.66, 1.36,   0.00, 0.00, 43.63);
        CreateDynamicObject(8171, 718.97, -4560.35, 1.36,   0.00, 0.00, 318.70);
        CreateDynamicObject(8171, 645.03, -4641.85, 1.36,   0.00, 0.00, 318.70);
        CreateDynamicObject(8171, 564.97, -4727.27, 1.36,   0.00, 0.00, 317.91);
        CreateDynamicObject(8171, 490.15, -4807.69, 1.36,   0.00, 0.00, 317.91);
        CreateObject(8419, 424.43, -2387.14, -7.27,   0.00, 0.00, 90.00);
        

	CreateDynamicObject(2910, -1280.34, 365.36, 1335.69,   0.00, 0.00, 0.00);   /*리버티시티 빠짐 방지*/
	CreateDynamicObject(2910, -1280.33, 512.81, 1333.41,   0.00, 0.00, 0.00);
	CreateDynamicObject(2910, -1258.97, 496.21, 1333.70,   0.00, 0.00, 0.00);
	CreateDynamicObject(2910, -1261.05, 356.61, 1335.35,   0.00, 0.00, 0.00);
	CreateDynamicObject(2910, -1184.94, 388.62, 1334.94,   0.00, 0.00, 92.00);
	CreateDynamicObject(2910, -1184.37, 377.53, 1334.94,   0.00, 0.00, 90.00);
	CreateDynamicObject(2910, -1092.43, 503.57, 1334.66,   0.00, 0.00, 89.99);
	CreateDynamicObject(18483, -971.82, 479.80, 1340.56,   0.00, 0.00, 90.00);
	CreateDynamicObject(18483, -987.26, 375.89, 1335.53,   0.00, 0.00, 179.99);
	CreateDynamicObject(18483, -987.44, 369.08, 1335.69,   0.00, 0.00, 179.99);
	CreateDynamicObject(18483, -970.37, 329.06, 1335.99,   0.00, 0.00, 269.99);
	CreateDynamicObject(18483, -1012.25, 327.07, 1336.15,   0.00, 0.00, 179.98);
	CreateDynamicObject(18483, -1010.46, 346.43, 1336.07,   0.00, 0.00, 179.98);
	CreateDynamicObject(12814, -896.50, 642.58, 1345.53,   0.00, 0.00, 179.99);
	CreateDynamicObject(12814, -725.90, 599.53, 1370.87,   0.00, 0.00, 179.99);
	CreateDynamicObject(12814, -726.37, 574.39, 1370.94,   0.00, 0.00, 179.99);
	CreateDynamicObject(12814, -726.62, 535.22, 1370.89,   0.00, 0.00, 179.99);
	CreateDynamicObject(2910, -824.22, 608.55, 1354.70,   11.00, 0.00, 270.00);
	CreateDynamicObject(2910, -970.99, 557.04, 1340.90,   0.00, 0.00, 0.00);
	CreateDynamicObject(2910, -970.82, 574.32, 1340.89,   0.00, 0.00, 0.00);
	CreateDynamicObject(3976, -934.11, 561.71, 1362.55,   0.00, 0.00, 0.00);
	CreateDynamicObject(12814, -946.30, 574.41, 1341.07,   0.00, 0.00, 0.00);
	CreateDynamicObject(12814, -957.97, 544.10, 1340.64,   0.00, 0.00, 0.00);
	CreateDynamicObject(8615, -782.20, 428.60, 1366.46,   0.00, 0.00, 225.99);
	CreateDynamicObject(12814, -1161.96, 453.05, 1334.73,   0.00, 0.00, 0.00);
	CreateDynamicObject(12814, -1116.92, 614.88, 1329.57,   0.00, 0.00, 90.00);
	CreateDynamicObject(12814, -1187.93, 596.75, 1335.46,   0.00, 0.00, 359.99);
	CreateDynamicObject(5020, -740.80, 585.49, 1372.63,   0.00, 0.00, 0.00);
	CreateDynamicObject(5020, -740.74, 588.10, 1372.63,   0.00, 0.00, 0.00);
	CreateDynamicObject(5020, -740.73, 591.24, 1373.21,   0.00, 0.00, 0.00);
	CreateDynamicObject(5020, -743.91, 572.55, 1371.38,   0.00, 0.00, 270.00);
	CreateDynamicObject(5020, -742.86, 577.09, 1372.71,   0.00, 0.00, 2.00);
	CreateDynamicObject(5020, -749.00, 572.51, 1370.97,   0.00, 0.00, 272.00);
	CreateDynamicObject(5020, -742.52, 579.50, 1372.87,   0.00, 0.00, 360.00);
	CreateDynamicObject(3440, -740.13, 572.60, 1373.33,   0.00, 0.00, 0.00);
	CreateDynamicObject(3440, -740.14, 573.04, 1373.33,   0.00, 0.00, 0.00);
	CreateDynamicObject(3440, -740.13, 573.48, 1373.33,   0.00, 0.00, 0.00);
	CreateDynamicObject(3440, -740.31, 565.47, 1373.33,   0.00, 0.00, 0.00);
	CreateDynamicObject(3440, -740.13, 564.94, 1373.33,   0.00, 0.00, 0.00);
	CreateDynamicObject(3440, -740.08, 564.44, 1373.33,   0.00, 0.00, 0.00);
	CreateDynamicObject(9188, -741.06, 569.11, 1379.51,   0.00, 0.00, 90.00);
	CreateDynamicObject(18244, -742.02, 576.06, 1370.81,   0.00, 0.00, 90.00);
	CreateDynamicObject(18244, -741.99, 579.22, 1370.78,   0.00, 0.00, 90.00);
	CreateDynamicObject(18244, -743.46, 574.08, 1370.55,   0.00, 0.00, 2.00);
	CreateDynamicObject(14467, -741.07, 580.42, 1372.25,   0.00, 0.00, 22.00);
	CreateDynamicObject(3441, -740.80, 581.64, 1372.83,   0.00, 0.00, 0.00);
	CreateDynamicObject(18240, -706.05, 523.61, 1370.28,   0.00, 0.00, 272.00);
	CreateDynamicObject(17537, -703.25, 552.09, 1382.01,   0.00, 0.00, 272.00);
	CreateDynamicObject(9190, -702.77, 533.35, 1377.91,   0.00, 0.00, 0.00);
	CreateDynamicObject(12847, -699.82, 588.70, 1375.20,   0.00, 0.00, 0.00);
	CreateDynamicObject(7191, -681.80, 597.41, 1372.88,   0.00, 0.00, 0.00);
	CreateDynamicObject(8062, -688.61, 631.29, 1374.07,   0.00, 0.00, 0.00);
	CreateDynamicObject(16000, -684.50, 578.50, 1370.91,   0.00, 0.00, 356.00);
	CreateDynamicObject(16000, -711.20, 544.33, 1376.37,   0.00, 0.00, 92.00);
	CreateDynamicObject(10394, -896.99, 640.80, 1348.28,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -721.34, 638.67, 1370.68,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -762.62, 625.33, 1366.58,   271.00, 1.00, 0.00);
	CreateDynamicObject(6959, -769.19, 625.20, 1369.40,   271.00, 1.00, 2.00);
	CreateDynamicObject(6959, -761.09, 593.44, 1366.81,   270.99, 0.99, 4.00);
	CreateDynamicObject(2910, -823.75, 626.98, 1354.67,   11.00, 0.00, 270.00);
	CreateDynamicObject(6959, -771.32, 625.19, 1365.86,   271.00, 1.00, 2.00);
	CreateDynamicObject(2910, -823.74, 588.65, 1354.82,   11.00, 0.00, 270.00);
	CreateDynamicObject(6959, -763.88, 573.05, 1349.25,   286.01, 273.47, 272.62);
	CreateDynamicObject(6959, -825.20, 593.06, 1357.87,   270.99, 0.98, 1.99);
	CreateDynamicObject(6959, -856.19, 593.35, 1348.46,   270.99, 0.99, 359.99);
	CreateDynamicObject(6959, -868.69, 593.44, 1354.03,   270.99, 0.98, 359.99);
	CreateDynamicObject(6959, -890.27, 536.21, 1346.07,   270.99, 0.98, 91.99);
	CreateDynamicObject(6959, -869.95, 473.30, 1348.45,   270.99, 0.97, 181.98);
	CreateDynamicObject(6959, -853.38, 473.67, 1351.04,   270.99, 0.98, 181.99);
	CreateDynamicObject(6959, -819.48, 473.89, 1354.60,   270.99, 0.98, 181.99);
	CreateDynamicObject(6959, -929.36, 502.06, 1345.72,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -930.98, 507.72, 1345.72,   0.00, 0.00, 0.00);
	CreateDynamicObject(14414, -954.73, 507.31, 1342.60,   0.00, 0.00, 90.00);
	CreateDynamicObject(6959, -740.55, 532.99, 1370.93,   270.99, 0.00, 270.00);
	CreateDynamicObject(6959, -740.61, 536.59, 1372.47,   270.99, 0.00, 270.00);
	CreateDynamicObject(6959, -869.73, 441.55, 1353.30,   270.99, 0.00, 0.00);
	CreateDynamicObject(6959, -861.48, 441.47, 1356.23,   270.99, 0.00, 0.00);
	CreateDynamicObject(6959, -862.01, 625.15, 1352.23,   270.99, 0.00, 0.00);
	CreateDynamicObject(11513, -699.78, 488.48, 1379.92,   0.00, 0.00, 118.00);
	CreateDynamicObject(11513, -669.18, 567.65, 1388.56,   0.00, 0.00, 151.99);
	CreateDynamicObject(11513, -669.84, 650.23, 1396.33,   0.00, 0.00, 161.99);
	CreateDynamicObject(11513, -896.81, 365.91, 1375.79,   0.00, 0.00, 347.98);
	CreateDynamicObject(11513, -944.60, 281.19, 1350.58,   0.00, 0.00, 147.98);
	CreateDynamicObject(11513, -926.53, 302.81, 1382.91,   0.00, 0.00, 147.97);
	CreateDynamicObject(11533, -1014.62, 234.00, 1346.49,   0.00, 0.00, 344.00);
	CreateDynamicObject(11533, -1133.93, 226.38, 1375.89,   0.00, 0.00, 65.99);
	CreateDynamicObject(18259, -874.42, 374.29, 1362.42,   0.00, 0.00, 184.00);
	CreateDynamicObject(6959, -894.92, 422.43, 1347.97,   270.99, 0.00, 357.99);
	CreateDynamicObject(10847, -899.05, 431.86, 1352.24,   0.00, 0.00, 0.00);
	CreateDynamicObject(10828, -860.70, 410.64, 1364.02,   0.00, 0.00, 14.00);
	CreateDynamicObject(10828, -834.33, 422.02, 1361.98,   0.00, 0.00, 29.99);
	CreateDynamicObject(2774, -814.71, 441.37, 1363.07,   0.00, 0.00, 0.00);
	CreateDynamicObject(2774, -818.19, 430.93, 1368.02,   0.00, 0.00, 0.00);
	CreateDynamicObject(987, -813.34, 431.94, 1359.43,   0.00, 0.00, 90.00);
	CreateDynamicObject(987, -813.48, 431.90, 1354.57,   0.00, 0.00, 90.00);
	CreateDynamicObject(2774, -816.87, 431.53, 1360.49,   0.00, 0.00, 0.00);
	CreateDynamicObject(2774, -814.97, 432.33, 1358.44,   0.00, 0.00, 0.00);
	CreateDynamicObject(11429, -866.42, 692.34, 1382.18,   0.00, 0.00, 353.99);
	CreateDynamicObject(16148, -1398.14, 381.71, 1349.91,   0.00, 0.00, 202.00);
	CreateDynamicObject(16148, -1404.17, 507.01, 1344.33,   0.00, 0.00, 201.99);
	CreateDynamicObject(16169, -1304.07, 602.71, 1368.56,   0.00, 0.00, 16.00);
	CreateDynamicObject(16169, -1207.02, 626.10, 1362.26,   0.00, 0.00, 332.00);
	CreateDynamicObject(16169, -1093.89, 607.49, 1370.72,   0.00, 0.00, 8.00);
	CreateDynamicObject(2933, -950.83, 420.43, 1342.46,   270.99, 0.00, 0.00);
	CreateDynamicObject(971, -943.25, 419.06, 1342.47,   271.00, 0.00, 0.00);
	CreateDynamicObject(971, -939.19, 410.52, 1342.57,   270.99, 0.00, 0.00);
	CreateDynamicObject(971, -950.99, 374.42, 1335.96,   270.99, 0.00, 0.00);
	CreateDynamicObject(971, -951.10, 369.02, 1335.74,   270.99, 0.00, 0.00);
	CreateDynamicObject(971, -950.08, 364.01, 1334.78,   270.99, 0.00, 0.00);
	CreateDynamicObject(971, -951.23, 359.54, 1335.81,   270.99, 0.00, 0.00);
	CreateDynamicObject(971, -957.88, 378.82, 1335.94,   270.99, 0.00, 0.00);
	CreateDynamicObject(986, -942.08, 410.68, 1342.77,   0.00, 0.00, 266.00);
	CreateDynamicObject(1698, -953.66, 378.73, 1336.35,   0.00, 0.00, 270.00);
	CreateDynamicObject(1698, -951.47, 378.76, 1336.35,   0.00, 0.00, 270.00);
	CreateDynamicObject(1698, -951.38, 379.24, 1336.59,   0.00, 0.00, 270.00);
	CreateDynamicObject(1698, -953.62, 379.35, 1336.59,   0.00, 0.00, 270.00);
	CreateDynamicObject(1698, -953.70, 379.95, 1336.83,   0.00, 0.00, 270.00);
	CreateDynamicObject(1698, -951.45, 379.86, 1336.83,   0.00, 0.00, 270.00);
	CreateDynamicObject(1698, -951.52, 380.48, 1337.08,   0.00, 0.00, 270.00);
	CreateDynamicObject(1698, -953.77, 380.49, 1337.08,   0.00, 0.00, 270.00);
	CreateDynamicObject(1698, -954.10, 381.05, 1337.32,   0.00, 0.00, 270.00);
	CreateDynamicObject(1698, -951.86, 381.01, 1337.32,   0.00, 0.00, 270.00);
	CreateDynamicObject(1698, -953.79, 381.71, 1337.57,   0.00, 0.00, 270.00);
	CreateDynamicObject(1698, -951.50, 381.54, 1337.57,   0.00, 0.00, 270.00);
	CreateDynamicObject(1698, -953.72, 382.37, 1337.81,   0.00, 0.00, 270.00);
	CreateDynamicObject(1698, -951.68, 382.14, 1337.81,   0.00, 0.00, 270.00);
	CreateDynamicObject(1698, -953.74, 382.96, 1338.06,   0.00, 0.00, 270.00);
	CreateDynamicObject(1698, -951.57, 382.78, 1338.06,   0.00, 0.00, 270.00);
	CreateDynamicObject(1698, -951.79, 383.44, 1338.30,   0.00, 0.00, 270.00);
	CreateDynamicObject(1698, -954.04, 383.45, 1338.30,   0.00, 0.00, 270.00);
	CreateDynamicObject(1698, -951.58, 384.03, 1338.54,   0.00, 0.00, 270.00);
	CreateDynamicObject(1698, -953.92, 384.02, 1338.54,   0.00, 0.00, 270.00);
	CreateDynamicObject(1698, -951.89, 384.62, 1338.79,   0.00, 0.00, 270.00);
	CreateDynamicObject(1698, -953.65, 384.62, 1338.79,   0.00, 0.00, 270.00);
	CreateDynamicObject(1698, -951.95, 385.16, 1339.03,   0.00, 0.00, 270.00);
	CreateDynamicObject(1698, -953.66, 385.00, 1339.03,   0.00, 0.00, 270.00);
	CreateDynamicObject(1698, -952.18, 385.83, 1339.28,   0.00, 0.00, 270.00);
	CreateDynamicObject(1698, -953.55, 385.82, 1339.11,   0.00, 0.00, 270.00);
	CreateDynamicObject(1698, -954.09, 386.33, 1339.36,   0.00, 0.00, 270.00);
	CreateDynamicObject(1698, -951.41, 386.44, 1339.52,   0.00, 0.00, 270.00);
	CreateDynamicObject(1698, -951.41, 387.03, 1339.76,   0.00, 0.00, 270.00);
	CreateDynamicObject(1698, -953.93, 387.07, 1339.76,   0.00, 0.00, 270.00);
	CreateDynamicObject(1698, -951.47, 387.70, 1340.01,   0.00, 0.00, 270.00);
	CreateDynamicObject(1698, -953.67, 387.69, 1340.01,   0.00, 0.00, 270.00);
	CreateDynamicObject(1698, -951.74, 388.34, 1340.25,   0.00, 0.00, 270.00);
	CreateDynamicObject(1698, -953.76, 388.32, 1340.25,   0.00, 0.00, 270.00);
	CreateDynamicObject(1698, -953.66, 388.85, 1340.50,   0.00, 0.00, 270.00);
	CreateDynamicObject(1698, -951.43, 388.73, 1340.50,   0.00, 0.00, 270.00);
	CreateDynamicObject(1698, -951.45, 389.38, 1340.74,   0.00, 0.00, 270.00);
	CreateDynamicObject(1698, -953.57, 389.32, 1340.74,   0.00, 0.00, 270.00);
	CreateDynamicObject(1698, -953.56, 389.85, 1340.99,   0.00, 0.00, 270.00);
	CreateDynamicObject(1698, -950.54, 389.94, 1340.99,   0.00, 0.00, 270.00);
	CreateDynamicObject(1698, -953.69, 390.43, 1341.23,   0.00, 0.00, 270.00);
	CreateDynamicObject(1698, -951.27, 390.44, 1341.23,   0.00, 0.00, 270.00);
	CreateDynamicObject(1698, -951.77, 390.93, 1341.47,   0.00, 0.00, 270.00);
	CreateDynamicObject(1698, -953.62, 390.89, 1341.47,   0.00, 0.00, 270.00);
	CreateDynamicObject(1698, -951.63, 391.51, 1341.72,   0.00, 0.00, 270.00);
	CreateDynamicObject(1698, -953.56, 391.39, 1341.72,   0.00, 0.00, 270.00);
	CreateDynamicObject(1698, -953.55, 391.96, 1341.96,   0.00, 0.00, 270.00);
	CreateDynamicObject(1698, -951.20, 392.00, 1341.96,   0.00, 0.00, 270.00);
	CreateDynamicObject(1698, -953.66, 394.50, 1342.17,   0.00, 0.00, 270.00);
	CreateDynamicObject(1698, -953.61, 393.70, 1342.16,   0.00, 0.00, 270.00);
	CreateDynamicObject(1698, -951.15, 395.30, 1342.16,   0.00, 0.00, 270.00);
	CreateDynamicObject(6959, -988.75, 497.65, 1335.42,   271.00, 0.00, 90.00);
	CreateDynamicObject(6959, -985.02, 515.20, 1336.40,   270.99, 0.00, 90.00);
	CreateDynamicObject(6959, -984.44, 522.29, 1341.70,   270.99, 0.00, 90.00);
	CreateDynamicObject(6959, -931.55, 484.73, 1342.83,   270.99, 0.00, 0.00);
	CreateDynamicObject(6959, -931.21, 624.95, 1342.61,   270.99, 0.00, 179.99);
	CreateDynamicObject(12814, -705.78, 501.47, 1370.61,   0.00, 0.00, 306.00);
	CreateDynamicObject(12814, -762.31, 441.92, 1361.01,   0.00, 0.00, 306.00);
	CreateDynamicObject(980, -771.50, 427.54, 1364.30,   270.99, 0.00, 316.00);
	CreateDynamicObject(980, -778.69, 435.05, 1364.19,   270.99, 0.00, 316.00);
	CreateDynamicObject(980, -781.51, 432.59, 1364.19,   270.99, 0.00, 316.00);
	CreateDynamicObject(980, -775.49, 426.24, 1364.13,   270.99, 0.00, 316.00);
	CreateDynamicObject(980, -789.49, 437.08, 1364.10,   270.99, 0.00, 316.00);
	CreateDynamicObject(980, -795.03, 424.88, 1366.73,   270.99, 0.00, 316.00);
	CreateDynamicObject(980, -803.24, 432.96, 1366.72,   270.99, 0.00, 316.00);
	CreateDynamicObject(980, -788.18, 439.63, 1361.06,   0.00, 0.00, 316.00);
	CreateDynamicObject(980, -784.78, 436.78, 1361.35,   0.00, 0.00, 46.00);
	CreateDynamicObject(980, -784.80, 442.30, 1361.04,   270.99, 0.00, 6.00);
	CreateDynamicObject(8572, -785.59, 439.60, 1363.26,   0.00, 0.00, 314.00);
	CreateDynamicObject(6296, -708.56, 503.38, 1372.83,   0.00, 0.00, 354.00);
	CreateDynamicObject(6863, -866.23, 420.84, 1384.81,   0.00, 0.00, 270.00);
	CreateDynamicObject(1231, -770.40, 451.51, 1367.18,   0.00, 0.00, 0.00);
	CreateDynamicObject(1231, -747.29, 463.01, 1371.43,   0.00, 0.00, 0.00);
	CreateDynamicObject(1231, -726.50, 484.43, 1373.86,   0.00, 0.00, 0.00);
	CreateDynamicObject(1231, -716.36, 512.82, 1373.86,   0.00, 0.00, 0.00);
	CreateDynamicObject(1231, -715.65, 560.52, 1373.68,   0.00, 0.00, 0.00);
	CreateDynamicObject(1231, -715.45, 593.49, 1373.68,   0.00, 0.00, 0.00);
	CreateDynamicObject(1231, -738.82, 593.27, 1373.68,   0.00, 0.00, 0.00);
	CreateDynamicObject(1231, -739.14, 548.35, 1373.62,   0.00, 0.00, 0.00);
	CreateDynamicObject(1231, -739.17, 512.96, 1373.86,   0.00, 0.00, 0.00);
	CreateDynamicObject(1231, -772.28, 473.35, 1368.07,   0.00, 0.00, 0.00);
	CreateDynamicObject(1231, -813.75, 470.03, 1359.13,   0.00, 0.00, 0.00);
	CreateDynamicObject(1231, -814.01, 445.00, 1359.10,   0.00, 0.00, 0.00);
	CreateDynamicObject(1231, -806.15, 444.85, 1360.65,   0.00, 0.00, 0.00);
	CreateDynamicObject(16061, -735.65, 559.89, 1370.95,   0.00, 0.00, 2.00);
	CreateDynamicObject(655, -732.57, 479.39, 1370.78,   0.00, 0.00, 0.00);
	CreateDynamicObject(655, -762.63, 459.24, 1365.46,   0.00, 0.00, 0.00);
	CreateDynamicObject(655, -757.41, 461.44, 1366.79,   0.00, 0.00, 0.00);
	CreateDynamicObject(655, -751.27, 464.67, 1368.21,   0.00, 0.00, 0.00);
	CreateDynamicObject(655, -736.81, 474.90, 1370.31,   0.00, 0.00, 0.00);
	CreateDynamicObject(655, -726.16, 489.80, 1370.98,   0.00, 0.00, 0.00);
	CreateDynamicObject(655, -722.90, 495.10, 1370.98,   0.00, 0.00, 0.00);
	CreateDynamicObject(709, -899.45, 618.68, 1345.54,   0.00, 0.00, 4.00);
	CreateDynamicObject(2714, -713.16, 503.58, 1372.99,   0.00, 0.00, 258.00);
	CreateDynamicObject(2714, -711.05, 554.56, 1373.29,   0.00, 0.00, 271.99);
	CreateDynamicObject(1321, -740.46, 595.98, 1372.58,   0.00, 0.00, 0.00);
	CreateDynamicObject(1321, -739.32, 621.69, 1372.36,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -938.29, 625.00, 1343.60,   270.99, 0.00, 179.99);
	CreateDynamicObject(18231, -1315.65, 326.16, 1338.27,   0.00, 0.00, 110.00);
	CreateDynamicObject(18231, -1233.43, 298.26, 1346.94,   0.00, 0.00, 132.00);
	CreateDynamicObject(10377, -1297.23, 459.34, 1353.08,   0.00, 0.00, 0.00);
	CreateDynamicObject(10381, -1193.58, 390.09, 1347.55,   0.00, 0.00, 359.99);
	CreateDynamicObject(5812, -1265.46, 447.74, 1336.22,   0.00, 0.00, 0.00);
	CreateDynamicObject(10631, -990.28, 364.65, 1340.20,   0.00, 0.00, 179.99);
	CreateDynamicObject(2910, -970.20, 368.78, 1336.08,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -793.50, 593.12, 1359.86,   270.99, 0.98, 2.00);
	CreateDynamicObject(17927, -981.45, 395.44, 1339.00,   0.00, 4.00, 270.00);
	CreateDynamicObject(6959, -964.55, 458.90, 1340.96,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -1000.35, 398.55, 1335.84,   0.00, 0.00, 0.00);
	CreateDynamicObject(5740, -991.37, 419.37, 1318.99,   0.00, 0.00, 270.00);
	CreateDynamicObject(5767, -1132.60, 348.89, 1383.12,   0.00, 0.00, 2.00);
	CreateDynamicObject(5882, -1195.12, 431.01, 1374.32,   0.00, 0.00, 92.00);
	CreateDynamicObject(5882, -1226.95, 432.62, 1373.82,   0.00, 0.00, 91.99);
	CreateDynamicObject(11533, -1062.15, 281.32, 1361.27,   0.00, 0.00, 341.99);
	CreateDynamicObject(6391, -1037.51, 336.61, 1373.29,   0.00, 0.00, 8.00);
	CreateDynamicObject(6959, -996.63, 358.42, 1334.84,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -1033.38, 360.17, 1334.79,   0.00, 0.00, 0.00);
	CreateDynamicObject(3049, -1019.73, 341.39, 1338.17,   0.00, 0.00, 266.00);
	CreateDynamicObject(3049, -1005.42, 355.52, 1338.33,   0.00, 0.00, 179.99);
	CreateDynamicObject(3049, -1009.74, 355.56, 1338.33,   0.00, 0.00, 179.99);
	CreateDynamicObject(3049, -1022.53, 355.94, 1337.00,   0.00, 0.00, 179.99);
	CreateDynamicObject(3049, -1018.75, 350.41, 1338.17,   0.00, 0.00, 269.99);
	CreateDynamicObject(3049, -1018.71, 351.96, 1338.33,   0.00, 0.00, 269.99);
	CreateDynamicObject(3049, -1013.96, 355.48, 1338.33,   0.00, 0.00, 179.99);
	CreateDynamicObject(3049, -1018.28, 355.39, 1338.33,   0.00, 0.00, 179.99);
	CreateDynamicObject(3049, -1020.01, 355.48, 1338.33,   0.00, 0.00, 177.99);
	CreateDynamicObject(3049, -1019.80, 323.44, 1338.26,   0.00, 0.00, 266.00);
	CreateDynamicObject(3049, -1019.85, 324.97, 1338.26,   0.00, 0.00, 266.00);
	CreateDynamicObject(1597, -982.42, 319.84, 1338.88,   0.00, 0.00, 90.00);
	CreateDynamicObject(1597, -995.46, 319.90, 1338.88,   0.00, 0.00, 90.00);
	CreateDynamicObject(1597, -1011.42, 319.91, 1338.83,   0.00, 0.00, 90.00);
	CreateDynamicObject(1597, -984.59, 338.95, 1338.81,   0.00, 0.00, 88.00);
	CreateDynamicObject(1597, -997.87, 339.07, 1338.80,   0.00, 0.00, 87.99);
	CreateDynamicObject(1597, -1017.70, 338.70, 1338.75,   0.00, 0.00, 87.99);
	CreateDynamicObject(3508, -988.91, 320.31, 1336.22,   0.00, 0.00, 0.00);
	CreateDynamicObject(3508, -1002.66, 320.58, 1336.21,   0.00, 0.00, 0.00);
	CreateDynamicObject(3508, -990.87, 338.93, 1336.15,   0.00, 0.00, 0.00);
	CreateDynamicObject(3508, -1004.69, 338.51, 1336.13,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -1001.21, 318.60, 1339.44,   270.99, 0.00, 0.00);
	CreateDynamicObject(6959, -980.58, 296.98, 1336.28,   270.99, 0.00, 270.00);
	CreateDynamicObject(6959, -955.47, 357.86, 1336.01,   0.00, 0.00, 0.00);
	CreateDynamicObject(17927, -1110.71, 493.28, 1337.16,   0.00, 0.00, 0.00);
	CreateDynamicObject(8391, -1012.01, 504.90, 1351.74,   0.00, 0.00, 0.00);
	CreateDynamicObject(8391, -1008.15, 515.55, 1349.95,   0.00, 0.00, 179.99);
	CreateDynamicObject(8555, -1046.12, 589.84, 1358.97,   0.00, 0.00, 0.00);
	CreateDynamicObject(18234, -1057.01, 504.46, 1334.57,   0.00, 0.00, 2.00);
	CreateDynamicObject(9361, -1058.94, 490.13, 1338.45,   0.00, 0.00, 223.99);
	CreateDynamicObject(9361, -959.11, 419.79, 1341.62,   0.00, 0.00, 223.99);
	CreateDynamicObject(980, -981.43, 556.93, 1343.75,   0.00, 0.00, 272.00);
	CreateDynamicObject(980, -984.29, 477.82, 1343.70,   0.00, 0.00, 86.00);
	CreateDynamicObject(5507, -940.89, 459.13, 1342.82,   0.00, 354.00, 0.00);
	CreateDynamicObject(5507, -1013.31, 458.55, 1337.41,   0.00, 353.00, 0.00);
	CreateDynamicObject(5507, -1026.81, 458.32, 1337.19,   0.00, 356.00, 0.00);
	CreateDynamicObject(5507, -1071.73, 458.62, 1335.98,   0.00, 0.00, 0.00);
	CreateDynamicObject(5507, -865.34, 608.65, 1348.93,   0.00, 353.00, 0.00);
	CreateDynamicObject(6959, -1047.06, 480.92, 1335.51,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -1090.82, 512.17, 1336.01,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -1050.02, 511.15, 1335.66,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -1101.74, 463.35, 1335.89,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -1036.11, 550.87, 1335.80,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -1080.82, 565.47, 1335.84,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -1090.10, 529.45, 1335.93,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -1085.47, 555.97, 1335.84,   0.00, 0.00, 0.00);
	CreateDynamicObject(5507, -1131.82, 568.63, 1335.75,   0.00, 0.00, 0.00);
	CreateDynamicObject(5507, -1145.26, 568.64, 1335.76,   0.00, 0.00, 0.00);
	CreateDynamicObject(1698, -1083.23, 568.34, 1335.93,   0.00, 0.00, 0.00);
	CreateDynamicObject(1698, -1083.19, 565.11, 1335.93,   0.00, 0.00, 0.00);
	CreateDynamicObject(1698, -1083.20, 562.17, 1335.93,   0.00, 0.00, 0.00);
	CreateDynamicObject(5507, -1049.70, 497.83, 1335.95,   0.00, 0.00, 270.00);
	CreateDynamicObject(5507, -1049.87, 541.15, 1335.90,   0.00, 0.00, 270.00);
	CreateDynamicObject(6959, -1040.88, 576.47, 1335.58,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -1078.30, 549.96, 1335.97,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -1079.00, 535.42, 1335.97,   0.00, 0.00, 0.00);
	CreateDynamicObject(5507, -1093.49, 543.13, 1336.03,   0.00, 0.00, 90.00);
	CreateDynamicObject(5507, -1181.20, 505.91, 1335.77,   0.00, 0.00, 0.00);
	CreateDynamicObject(5507, -1212.62, 503.97, 1335.77,   0.00, 0.00, 0.00);
	CreateDynamicObject(5507, -1267.03, 503.74, 1335.92,   0.00, 0.00, 0.00);
	CreateDynamicObject(6988, -1063.45, 380.40, 1318.50,   0.00, 0.00, 90.00);
	CreateDynamicObject(5507, -939.62, 610.01, 1342.98,   0.00, 354.00, 0.00);
	CreateDynamicObject(5507, -959.63, 608.97, 1341.08,   0.00, 356.00, 0.00);
	CreateDynamicObject(10871, -1071.92, 430.20, 1463.07,   0.00, 0.00, 359.99);
	CreateDynamicObject(10871, -1052.50, 390.29, 1424.95,   0.00, 0.00, 32.00);
	CreateDynamicObject(6959, -1056.41, 444.57, 1335.81,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -1085.29, 446.59, 1335.77,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -1045.18, 443.79, 1335.81,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -1007.19, 434.55, 1335.62,   0.00, 0.00, 0.00);
	CreateDynamicObject(12814, -1235.75, 390.22, 1336.11,   0.00, 0.00, 0.00);
	CreateDynamicObject(12814, -1206.22, 390.47, 1335.94,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -1230.02, 460.18, 1336.33,   0.00, 0.00, 0.00);
	CreateDynamicObject(9254, -1267.57, 540.52, 1336.28,   0.00, 0.00, 90.00);
	CreateDynamicObject(9254, -1233.00, 390.10, 1336.73,   0.00, 0.00, 90.00);
	CreateDynamicObject(9551, -1344.29, 382.13, 1370.68,   0.00, 0.00, 190.00);
	CreateDynamicObject(9551, -1351.05, 487.78, 1373.96,   0.00, 0.00, 170.00);
	CreateDynamicObject(9551, -1307.68, 588.75, 1369.97,   0.00, 0.00, 92.00);
	CreateDynamicObject(10379, -1302.99, 363.47, 1341.21,   0.00, 0.00, 90.00);
	CreateDynamicObject(10379, -1297.72, 560.93, 1340.96,   0.00, 0.00, 90.00);
	CreateDynamicObject(5507, -1259.84, 371.87, 1336.07,   0.00, 0.00, 270.00);
	CreateDynamicObject(5507, -1279.72, 372.05, 1336.09,   0.00, 0.00, 270.00);
	CreateDynamicObject(17533, -821.27, 632.44, 1371.08,   0.00, 0.00, 270.00);
	CreateDynamicObject(10948, -1305.18, 567.96, 1396.98,   0.00, 0.00, 0.00);
	CreateDynamicObject(10947, -1016.24, 605.42, 1345.43,   0.00, 0.00, 270.00);
	CreateDynamicObject(9907, -1226.21, 528.12, 1324.35,   0.00, 0.00, 90.00);
	CreateDynamicObject(3749, -911.43, 534.24, 1351.60,   0.00, 0.00, 87.99);
	CreateDynamicObject(974, -910.91, 476.69, 1347.13,   0.00, 0.00, 90.00);
	CreateDynamicObject(974, -910.91, 479.99, 1347.70,   0.00, 0.00, 90.00);
	CreateDynamicObject(7191, -1066.80, 446.81, 1335.82,   0.00, 270.99, 90.00);
	CreateDynamicObject(974, -912.46, 471.55, 1345.46,   270.99, 0.00, 0.00);
	CreateDynamicObject(974, -910.92, 476.83, 1345.71,   270.99, 0.00, 0.00);
	CreateDynamicObject(974, -910.78, 479.68, 1345.77,   270.99, 0.00, 0.00);
	CreateDynamicObject(974, -910.62, 505.46, 1345.96,   270.99, 0.00, 0.00);
	CreateDynamicObject(974, -744.08, 512.79, 1374.41,   0.00, 0.00, 0.00);
	CreateDynamicObject(974, -752.01, 512.25, 1375.22,   0.00, 0.00, 2.00);
	CreateDynamicObject(974, -757.98, 512.24, 1374.90,   0.00, 0.00, 2.00);
	CreateDynamicObject(974, -760.93, 512.02, 1374.81,   0.00, 0.00, 2.00);
	CreateDynamicObject(974, -756.65, 568.04, 1348.80,   0.00, 0.00, 2.00);
	CreateDynamicObject(974, -772.75, 512.17, 1380.69,   0.00, 0.00, 2.00);
	CreateDynamicObject(974, -780.08, 512.26, 1383.37,   0.00, 0.00, 360.00);
	CreateDynamicObject(974, -785.72, 512.09, 1383.37,   0.00, 0.00, 359.99);
	CreateDynamicObject(974, -792.84, 512.02, 1383.37,   0.00, 0.00, 359.99);
	CreateDynamicObject(974, -766.40, 512.18, 1379.29,   0.00, 0.00, 0.00);
	CreateDynamicObject(3049, -780.95, 572.50, 1364.48,   0.00, 0.00, 181.99);
	CreateDynamicObject(3049, -807.33, 572.45, 1359.30,   0.00, 0.00, 181.99);
	CreateDynamicObject(3049, -843.71, 572.63, 1353.39,   0.00, 0.00, 179.99);
	CreateDynamicObject(3049, -871.81, 572.45, 1350.47,   0.00, 0.00, 179.99);
	CreateDynamicObject(4199, -820.89, 578.66, 1354.91,   0.00, 0.00, 268.00);
	CreateDynamicObject(3049, -821.36, 572.99, 1358.34,   0.00, 0.00, 177.99);
	CreateDynamicObject(3049, -825.43, 573.23, 1358.39,   0.00, 0.00, 177.99);
	CreateDynamicObject(3049, -829.76, 573.34, 1358.42,   0.00, 0.00, 177.99);
	CreateDynamicObject(3049, -830.70, 573.47, 1358.36,   0.00, 0.00, 177.99);
	CreateDynamicObject(1231, -848.23, 447.78, 1353.10,   0.00, 0.00, 0.00);
	CreateDynamicObject(1231, -873.55, 447.61, 1350.58,   0.00, 0.00, 0.00);
	CreateDynamicObject(1231, -888.77, 446.20, 1348.96,   0.00, 0.00, 0.00);
	CreateDynamicObject(1231, -890.55, 471.16, 1348.78,   0.00, 0.00, 0.00);
	CreateDynamicObject(1231, -874.57, 471.61, 1350.47,   0.00, 0.00, 0.00);
	CreateDynamicObject(1231, -857.31, 471.60, 1352.52,   0.00, 0.00, 0.00);
	CreateDynamicObject(1231, -842.51, 470.96, 1353.86,   0.00, 0.00, 0.00);
	CreateDynamicObject(1231, -891.62, 480.55, 1348.78,   0.00, 0.00, 0.00);
	CreateDynamicObject(1231, -891.97, 514.60, 1348.78,   0.00, 0.00, 0.00);
	CreateDynamicObject(1231, -892.29, 546.11, 1348.78,   0.00, 0.00, 0.00);
	CreateDynamicObject(1231, -892.00, 572.67, 1348.78,   0.00, 0.00, 0.00);
	CreateDynamicObject(1231, -890.83, 592.80, 1348.78,   0.00, 0.00, 0.00);
	CreateDynamicObject(1231, -889.66, 623.42, 1348.27,   0.00, 0.00, 0.00);
	CreateDynamicObject(1231, -861.31, 623.35, 1350.01,   0.00, 0.00, 0.00);
	CreateDynamicObject(1231, -837.63, 623.07, 1354.61,   0.00, 0.00, 0.00);
	CreateDynamicObject(1231, -802.66, 623.22, 1361.41,   0.00, 0.00, 0.00);
	CreateDynamicObject(1231, -757.75, 623.55, 1370.13,   0.00, 0.00, 0.00);
	CreateDynamicObject(1231, -739.04, 623.93, 1373.60,   0.00, 0.00, 0.00);
	CreateDynamicObject(1231, -714.36, 624.07, 1373.60,   0.00, 0.00, 0.00);
	CreateDynamicObject(1231, -770.35, 594.49, 1368.01,   0.00, 0.00, 0.00);
	CreateDynamicObject(1231, -792.52, 594.48, 1363.70,   0.00, 0.00, 0.00);
	CreateDynamicObject(1231, -813.44, 593.92, 1359.64,   0.00, 0.00, 0.00);
	CreateDynamicObject(1231, -847.34, 594.44, 1353.05,   0.00, 0.00, 0.00);
	CreateDynamicObject(1231, -910.78, 602.45, 1348.80,   0.00, 0.00, 0.00);
	CreateDynamicObject(1231, -962.63, 600.51, 1343.71,   0.00, 0.00, 0.00);
	CreateDynamicObject(1231, -960.11, 623.15, 1343.71,   0.00, 0.00, 0.00);
	CreateDynamicObject(1231, -906.33, 623.81, 1348.27,   0.00, 0.00, 0.00);
	CreateDynamicObject(1231, -979.19, 523.70, 1343.71,   0.00, 0.00, 0.00);
	CreateDynamicObject(1231, -979.80, 470.57, 1343.71,   0.00, 0.00, 0.00);
	CreateDynamicObject(1231, -963.17, 470.72, 1343.71,   0.00, 0.00, 0.00);
	CreateDynamicObject(1231, -910.41, 470.12, 1348.75,   0.00, 0.00, 0.00);
	CreateDynamicObject(1231, -910.73, 520.27, 1348.42,   0.00, 0.00, 0.00);
	CreateDynamicObject(1231, -908.57, 544.47, 1348.78,   0.00, 0.00, 0.00);
	CreateDynamicObject(1231, -908.99, 447.35, 1348.78,   0.00, 0.00, 0.00);
	CreateDynamicObject(1231, -961.31, 448.08, 1343.66,   0.00, 0.00, 0.00);
	CreateDynamicObject(1231, -963.20, 429.11, 1342.85,   0.00, 0.00, 0.00);
	CreateDynamicObject(1231, -961.68, 372.10, 1338.96,   0.00, 0.00, 0.00);
	CreateDynamicObject(1231, -979.44, 371.75, 1338.93,   0.00, 0.00, 0.00);
	CreateDynamicObject(1231, -980.44, 443.54, 1343.66,   0.00, 0.00, 0.00);
	CreateDynamicObject(1231, -961.11, 320.26, 1338.90,   0.00, 0.00, 0.00);
	CreateDynamicObject(1231, -1043.95, 448.04, 1338.89,   0.00, 0.00, 0.00);
	CreateDynamicObject(1231, -1042.23, 464.77, 1338.91,   0.00, 0.00, 0.00);
	CreateDynamicObject(1231, -1042.03, 537.72, 1338.70,   0.00, 0.00, 0.00);
	CreateDynamicObject(1231, -1056.03, 515.16, 1338.76,   0.00, 0.00, 0.00);
	CreateDynamicObject(1231, -1060.00, 469.72, 1338.59,   0.00, 0.00, 0.00);
	CreateDynamicObject(1231, -1064.44, 494.27, 1338.78,   0.00, 0.00, 0.00);
	CreateDynamicObject(1231, -1064.37, 513.57, 1338.90,   0.00, 0.00, 0.00);
	CreateDynamicObject(1231, -1106.86, 494.74, 1338.73,   0.00, 0.00, 0.00);
	CreateDynamicObject(1231, -1100.91, 450.46, 1338.79,   0.00, 0.00, 0.00);
	CreateDynamicObject(7191, -929.61, 621.35, 1343.93,   6.00, 270.99, 270.00);
	CreateDynamicObject(6959, -888.36, 619.56, 1346.07,   0.00, 0.00, 0.00);
	CreateDynamicObject(987, -909.95, 544.22, 1345.75,   0.00, 0.00, 90.00);
	CreateDynamicObject(987, -909.94, 555.95, 1345.75,   0.00, 0.00, 89.99);
	CreateDynamicObject(987, -909.94, 567.95, 1345.75,   0.00, 0.00, 89.99);
	CreateDynamicObject(987, -909.95, 579.37, 1345.75,   0.00, 0.00, 89.99);
	CreateDynamicObject(987, -909.95, 588.55, 1345.75,   0.00, 0.00, 89.99);
	CreateDynamicObject(987, -910.19, 599.41, 1345.75,   0.00, 0.00, 179.99);
	CreateDynamicObject(987, -922.32, 599.48, 1345.75,   0.00, 0.00, 181.99);
	CreateDynamicObject(2774, -909.84, 600.06, 1346.17,   0.00, 0.00, 0.00);
	CreateDynamicObject(2774, -911.62, 524.11, 1358.83,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -927.77, 579.54, 1345.78,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -923.18, 542.33, 1345.78,   0.00, 0.00, 0.00);
	CreateDynamicObject(981, -893.62, 624.36, 1346.18,   0.00, 0.00, 0.00);
	CreateDynamicObject(2946, -1090.82, 575.00, 1335.85,   0.00, 0.00, 2.00);
	CreateDynamicObject(9946, -1091.30, 587.54, 1335.73,   0.00, 0.00, 90.00);
	CreateDynamicObject(1432, -1104.43, 573.56, 1335.85,   0.00, 0.00, 0.00);
	CreateDynamicObject(1432, -1107.84, 577.23, 1335.85,   0.00, 0.00, 0.00);
	CreateDynamicObject(1432, -1104.02, 576.12, 1335.85,   0.00, 0.00, 0.00);
	CreateDynamicObject(11674, -1093.55, 582.04, 1335.85,   0.00, 0.00, 38.00);
	CreateDynamicObject(14434, -1078.68, 568.23, 1344.98,   0.00, 0.00, 0.00);
	CreateDynamicObject(9833, -1107.42, 565.25, 1331.72,   0.00, 0.00, 0.00);
	CreateDynamicObject(9482, -1095.53, 520.47, 1342.57,   0.00, 0.00, 90.00);
	CreateDynamicObject(9482, -1105.34, 567.73, 1341.52,   0.00, 0.00, 0.00);
	CreateDynamicObject(3533, -1107.21, 559.96, 1340.06,   0.00, 0.00, 0.00);
	CreateDynamicObject(2933, -946.79, 413.45, 1342.42,   270.99, 0.00, 0.00);
	CreateDynamicObject(2933, -950.95, 413.39, 1341.97,   270.99, 0.00, 0.00);
	CreateDynamicObject(2933, -950.83, 410.68, 1342.39,   270.99, 0.00, 0.00);
	CreateDynamicObject(2933, -945.88, 410.90, 1342.45,   270.99, 0.00, 0.00);
	CreateDynamicObject(2933, -945.71, 407.77, 1342.44,   270.99, 0.00, 0.00);
	CreateDynamicObject(2933, -951.28, 407.53, 1342.48,   270.99, 0.00, 0.00);
	CreateDynamicObject(2933, -950.36, 404.60, 1342.47,   270.99, 0.00, 0.00);
	CreateDynamicObject(2774, -790.28, 473.84, 1363.58,   0.00, 0.00, 352.00);
	CreateDynamicObject(2774, -840.57, 473.94, 1364.22,   0.00, 0.00, 352.00);
	CreateDynamicObject(6959, -1184.75, 565.50, 1335.63,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -1189.04, 532.68, 1335.72,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -1061.53, 534.72, 1344.43,   270.99, 0.00, 90.00);
	CreateDynamicObject(6959, -1061.31, 540.35, 1345.26,   270.99, 0.00, 90.00);
	CreateDynamicObject(7307, -1060.99, 544.76, 1362.18,   0.00, 0.00, 46.00);
	CreateDynamicObject(6959, -1085.02, 534.77, 1344.47,   270.99, 0.00, 90.00);
	CreateDynamicObject(2774, -1084.26, 555.17, 1349.18,   0.00, 0.00, 0.00);
	CreateDynamicObject(9345, -1283.29, 488.01, 1335.86,   0.00, 0.00, 272.00);
	CreateDynamicObject(9345, -1283.38, 477.97, 1335.86,   0.00, 0.00, 90.00);
	CreateDynamicObject(9345, -1283.49, 441.09, 1335.90,   0.00, 0.00, 89.99);
	CreateDynamicObject(9345, -1283.34, 427.05, 1335.85,   0.00, 0.00, 89.99);
	CreateDynamicObject(9345, -1283.11, 414.46, 1335.85,   0.00, 0.00, 89.99);
	CreateDynamicObject(9345, -1283.12, 407.47, 1335.85,   0.00, 0.00, 89.99);
	CreateDynamicObject(9345, -1287.43, 519.65, 1336.22,   0.00, 0.00, 89.99);
	CreateDynamicObject(1597, -1282.11, 408.12, 1338.77,   0.00, 0.00, 0.00);
	CreateDynamicObject(1597, -1282.13, 421.43, 1338.77,   0.00, 0.00, 0.00);
	CreateDynamicObject(1597, -1282.67, 435.53, 1338.81,   0.00, 0.00, 0.00);
	CreateDynamicObject(1597, -1283.24, 480.59, 1338.78,   0.00, 0.00, 0.00);
	CreateDynamicObject(1597, -1283.37, 493.15, 1338.77,   0.00, 0.00, 0.00);
	CreateDynamicObject(3507, -1283.12, 474.23, 1336.11,   0.00, 0.00, 350.00);
	CreateDynamicObject(3507, -1283.44, 487.13, 1336.12,   0.00, 0.00, 350.00);
	CreateDynamicObject(3507, -1282.95, 443.84, 1336.16,   0.00, 0.00, 342.00);
	CreateDynamicObject(3507, -1282.30, 428.70, 1336.11,   0.00, 0.00, 341.99);
	CreateDynamicObject(3507, -1281.68, 414.64, 1336.11,   0.00, 0.00, 341.99);
	CreateDynamicObject(3507, -1282.67, 401.95, 1336.10,   0.00, 0.00, 341.99);
	CreateDynamicObject(3507, -1215.17, 368.72, 1335.95,   0.00, 0.00, 0.00);
	CreateDynamicObject(3507, -1207.15, 380.28, 1335.95,   0.00, 0.00, 12.00);
	CreateDynamicObject(3507, -1207.77, 400.19, 1335.95,   0.00, 0.00, 20.00);
	CreateDynamicObject(3507, -1214.91, 411.11, 1335.95,   0.00, 0.00, 20.00);
	CreateDynamicObject(1597, -1206.77, 373.35, 1338.61,   0.00, 0.00, 0.00);
	CreateDynamicObject(1597, -1207.12, 406.08, 1338.61,   0.00, 0.00, 0.00);
	CreateDynamicObject(1597, -1209.71, 411.70, 1338.61,   0.00, 0.00, 90.00);
	CreateDynamicObject(1597, -1209.68, 368.98, 1338.61,   0.00, 0.00, 90.00);
	CreateDynamicObject(6959, -1229.53, 367.90, 1348.07,   270.99, 0.00, 0.00);
	CreateDynamicObject(6213, -1223.02, 368.23, 1336.98,   0.00, 0.00, 180.00);
	CreateDynamicObject(7191, -1250.31, 414.01, 1338.09,   0.00, 0.00, 0.00);
	CreateDynamicObject(7191, -1250.43, 363.96, 1338.11,   0.00, 179.00, 180.00);
	CreateDynamicObject(3441, -1250.87, 386.50, 1338.17,   0.00, 0.00, 0.00);
	CreateDynamicObject(3441, -1250.78, 391.70, 1338.11,   0.00, 0.00, 0.00);
	CreateDynamicObject(3471, -1251.25, 386.72, 1341.42,   0.00, 0.00, 178.00);
	CreateDynamicObject(3471, -1250.83, 391.84, 1341.37,   0.00, 0.00, 177.99);
	CreateDynamicObject(1698, -1250.89, 389.04, 1336.26,   0.00, 0.00, 0.00);
	CreateDynamicObject(1698, -1250.49, 389.02, 1336.50,   0.00, 0.00, 0.00);
	CreateDynamicObject(1698, -1250.08, 388.99, 1336.75,   0.00, 0.00, 0.00);
	CreateDynamicObject(1698, -1210.59, 389.62, 1336.96,   0.00, 0.00, 0.00);
	CreateDynamicObject(1698, -1211.23, 389.71, 1337.21,   0.00, 0.00, 0.00);
	CreateDynamicObject(1698, -1211.77, 389.71, 1337.45,   0.00, 0.00, 0.00);
	CreateDynamicObject(1698, -1212.49, 389.62, 1337.54,   0.00, 0.00, 0.00);
	CreateDynamicObject(1231, -908.84, 620.09, 1348.93,   0.00, 0.00, 0.00);
	CreateDynamicObject(7191, -870.41, 621.23, 1347.66,   354.00, 270.99, 90.00);
	CreateDynamicObject(7191, -936.43, 624.97, 1341.63,   0.00, 270.99, 270.00);
	CreateDynamicObject(7191, -919.91, 625.01, 1344.37,   8.00, 270.99, 270.00);
	CreateDynamicObject(14394, -950.88, 561.56, 1341.45,   0.00, 0.00, 0.00);
	CreateDynamicObject(2946, -949.90, 560.36, 1342.26,   0.00, 0.00, 356.00);
	CreateDynamicObject(2946, -949.72, 563.35, 1342.26,   0.00, 0.00, 178.00);
	CreateDynamicObject(1566, -991.71, 355.57, 1337.75,   0.00, 0.00, 0.00);
	CreateDynamicObject(10150, -946.77, 361.02, 1337.18,   0.00, 0.00, 0.00);
	CreateDynamicObject(10150, -946.76, 358.39, 1336.85,   0.00, 0.00, 0.00);
	CreateDynamicObject(10150, -946.67, 372.05, 1337.36,   0.00, 0.00, 0.00);
	CreateDynamicObject(10150, -946.55, 375.02, 1337.00,   0.00, 0.00, 0.00);
	CreateDynamicObject(10184, -946.50, 365.19, 1336.18,   0.00, 0.00, 0.00);
	CreateDynamicObject(2948, -946.79, 372.42, 1336.12,   0.00, 0.00, 0.00);
	CreateDynamicObject(2948, -946.74, 372.47, 1336.14,   0.00, 0.00, 182.00);
	CreateDynamicObject(9361, -959.06, 412.18, 1341.68,   0.00, 0.00, 223.99);
	CreateDynamicObject(2987, -960.70, 419.12, 1340.69,   0.00, 0.00, 270.00);
	CreateDynamicObject(10150, -960.62, 411.05, 1339.65,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -1103.31, 538.43, 1335.93,   270.99, 0.00, 270.00);
	CreateDynamicObject(6959, -1180.07, 491.24, 1335.48,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -951.53, 554.88, 1340.83,   0.00, 0.00, 88.00);
	CreateDynamicObject(6959, -952.00, 581.81, 1340.61,   0.00, 0.00, 358.00);
	CreateDynamicObject(2910, -970.29, 236.88, 1336.00,   0.00, 0.00, 0.00);
	CreateDynamicObject(11533, -1015.58, 131.63, 1342.87,   0.00, 0.00, 40.00);
	CreateDynamicObject(11533, -935.34, 44.29, 1336.00,   0.00, 0.00, 157.99);
	CreateDynamicObject(11533, -894.71, 245.22, 1382.17,   0.00, 0.00, 161.99);
	CreateDynamicObject(12870, -1029.72, 169.38, 1342.51,   0.00, 0.00, 356.00);
	CreateDynamicObject(16097, -978.02, 143.33, 1336.77,   0.00, 0.00, 24.00);
	CreateDynamicObject(16148, -887.21, 182.88, 1337.72,   0.00, 0.00, 38.00);
	CreateDynamicObject(11533, -920.47, 78.57, 1355.83,   0.00, 0.00, 161.99);
	CreateDynamicObject(6959, -1000.34, 52.64, 1336.11,   0.00, 0.00, 0.00);
	CreateDynamicObject(1320, -978.73, 321.23, 1337.18,   0.00, 0.00, 56.00);
	CreateDynamicObject(1320, -979.97, 220.55, 1336.83,   0.00, 0.00, 56.00);
	CreateDynamicObject(1320, -962.22, 39.84, 1338.71,   0.00, 0.00, 68.00);
	CreateDynamicObject(3507, -981.84, 266.09, 1335.58,   0.00, 0.00, 0.00);
	CreateDynamicObject(3507, -959.29, 269.82, 1335.65,   0.00, 0.00, 0.00);
	CreateDynamicObject(3507, -958.47, 248.74, 1335.65,   0.00, 0.00, 0.00);
	CreateDynamicObject(3507, -982.58, 189.34, 1335.49,   0.00, 0.00, 0.00);
	CreateDynamicObject(3507, -981.78, 213.10, 1335.41,   0.00, 0.00, 0.00);
	CreateDynamicObject(3507, -958.46, 150.94, 1335.45,   0.00, 0.00, 0.00);
	CreateDynamicObject(3507, -955.42, 113.87, 1335.52,   0.00, 0.00, 0.00);
	CreateDynamicObject(3507, -956.50, 137.11, 1335.45,   0.00, 0.00, 0.00);
	CreateDynamicObject(3507, -982.60, 132.62, 1335.41,   0.00, 0.00, 0.00);
	CreateDynamicObject(3507, -984.28, 119.31, 1335.41,   0.00, 0.00, 0.00);
	CreateDynamicObject(3507, -983.74, 98.62, 1335.42,   0.00, 0.00, 0.00);
	CreateDynamicObject(3507, -983.24, 77.03, 1335.42,   0.00, 0.00, 0.00);
	CreateDynamicObject(1597, -958.79, 258.62, 1338.56,   0.00, 0.00, 0.00);
	CreateDynamicObject(1597, -982.64, 204.34, 1338.57,   0.00, 0.00, 0.00);
	CreateDynamicObject(1597, -981.96, 173.63, 1338.15,   0.00, 0.00, 0.00);
	CreateDynamicObject(1597, -957.80, 143.65, 1338.60,   0.00, 0.00, 0.00);
	CreateDynamicObject(1597, -956.89, 126.73, 1338.68,   0.00, 0.00, 0.00);
	CreateDynamicObject(1597, -984.13, 125.98, 1338.56,   0.00, 0.00, 0.00);
	CreateDynamicObject(1597, -983.45, 109.15, 1338.56,   0.00, 0.00, 0.00);
	CreateDynamicObject(1597, -983.15, 88.12, 1338.57,   0.00, 0.00, 0.00);
	CreateDynamicObject(6988, -807.09, 654.82, 1358.22,   0.00, 0.00, 179.99);
	CreateDynamicObject(10143, -1222.09, 576.65, 1331.70,   0.00, 0.00, 180.00);
	CreateDynamicObject(8427, -867.64, 595.25, 1351.31,   6.00, 0.00, 268.00);
	CreateDynamicObject(11513, -741.27, 444.53, 1379.92,   0.00, 0.00, 102.00);
	CreateDynamicObject(11513, -742.95, 453.11, 1379.92,   0.00, 0.00, 96.00);
	CreateDynamicObject(11513, -703.81, 489.90, 1379.92,   0.00, 0.00, 95.99);
	CreateDynamicObject(11513, -725.96, 468.61, 1379.92,   0.00, 0.00, 95.99);
	CreateDynamicObject(11513, -787.15, 439.61, 1379.92,   0.00, 0.00, 77.99);
	CreateDynamicObject(17533, -928.36, 427.90, 1371.74,   0.00, 0.00, 90.00);
	CreateDynamicObject(6959, -925.89, 429.15, 1344.67,   0.00, 356.00, 0.00);
	CreateDynamicObject(2910, -900.35, 450.08, 1345.65,   0.00, 0.00, 0.00);
	CreateDynamicObject(5507, -933.67, 459.40, 1341.82,   0.00, 358.00, 0.00);
	CreateDynamicObject(8427, -955.84, 395.78, 1339.05,   0.00, 0.00, 180.00);
	CreateDynamicObject(8427, -950.61, 395.90, 1339.05,   0.00, 0.00, 179.99);
	CreateDynamicObject(11429, -880.30, 636.47, 1382.18,   0.00, 0.00, 271.99);
	CreateDynamicObject(8136, -1001.51, 444.03, 1311.46,   272.00, 90.00, 90.01);
	CreateDynamicObject(974, -947.89, 355.03, 1338.15,   0.00, 0.00, 36.00);
	CreateDynamicObject(974, -950.53, 349.78, 1338.15,   0.00, 0.00, 90.00);
	CreateDynamicObject(974, -950.35, 343.51, 1338.15,   0.00, 0.00, 89.99);
	CreateDynamicObject(974, -950.38, 336.97, 1338.15,   0.00, 0.00, 89.99);
	CreateDynamicObject(974, -950.36, 334.46, 1338.15,   0.00, 0.00, 89.99);
	CreateDynamicObject(974, -948.44, 329.50, 1341.90,   0.00, 26.00, 119.99);
	CreateDynamicObject(974, -920.66, 436.11, 1347.79,   0.00, 0.00, 359.99);
	CreateDynamicObject(974, -914.82, 436.07, 1347.79,   0.00, 0.00, 359.99);
	CreateDynamicObject(974, -923.94, 436.07, 1347.79,   0.00, 0.00, 359.99);
	CreateDynamicObject(974, -927.23, 436.04, 1347.29,   0.00, 0.00, 359.99);
	CreateDynamicObject(974, -931.75, 435.79, 1347.29,   0.00, 0.00, 359.99);
	CreateDynamicObject(974, -936.85, 435.96, 1347.29,   0.00, 0.00, 359.99);
	CreateDynamicObject(974, -938.65, 436.17, 1346.54,   0.00, 0.00, 359.99);
	CreateDynamicObject(974, -941.91, 423.74, 1346.54,   0.00, 0.00, 89.99);
	CreateDynamicObject(974, -913.79, 436.10, 1347.79,   0.00, 0.00, 359.99);
	CreateDynamicObject(5507, -865.34, 608.65, 1348.93,   0.00, 353.00, 0.00);
	CreateDynamicObject(2774, -942.08, 434.96, 1341.68,   0.00, 0.00, 0.00);
	CreateDynamicObject(3049, -1001.11, 355.53, 1338.33,   0.00, 0.00, 179.99);
	CreateDynamicObject(12814, -945.81, 525.70, 1341.07,   0.00, 0.00, 0.00);
	CreateDynamicObject(12814, -945.92, 499.64, 1341.07,   0.00, 0.00, 359.99);
	CreateDynamicObject(14414, -954.83, 511.06, 1342.60,   0.00, 0.00, 90.00);
	CreateDynamicObject(621, -953.64, 581.90, 1330.37,   0.00, 0.00, 86.00);
	CreateDynamicObject(621, -953.13, 571.14, 1330.37,   0.00, 0.00, 86.00);
	CreateDynamicObject(621, -953.44, 551.87, 1330.37,   0.00, 0.00, 86.00);
	CreateDynamicObject(621, -953.04, 540.56, 1330.37,   0.00, 0.00, 86.00);
	CreateDynamicObject(1597, -953.35, 576.69, 1343.73,   0.00, 0.00, 0.00);
	CreateDynamicObject(1597, -953.91, 546.38, 1343.73,   0.00, 0.00, 0.00);
	CreateDynamicObject(11533, -1044.53, 72.19, 1342.87,   0.00, 0.00, 308.00);
	CreateDynamicObject(11533, -1137.90, 73.62, 1342.87,   0.00, 0.00, 243.99);
	CreateDynamicObject(5423, -1009.65, -1.90, 1339.32,   0.00, 0.00, 90.00);
	CreateDynamicObject(2910, -970.39, 66.03, 1336.00,   0.00, 0.00, 0.00);
	CreateDynamicObject(2910, -970.43, -104.64, 1336.00,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -1000.82, 92.42, 1336.11,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -1000.46, 132.32, 1336.11,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -944.60, 95.64, 1336.11,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -940.32, 59.54, 1336.11,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -940.88, 19.75, 1336.11,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -944.40, 135.63, 1336.11,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -940.16, 175.35, 1336.11,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -940.49, 215.31, 1336.11,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -939.67, 255.30, 1336.11,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -939.72, 294.28, 1336.11,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -940.19, 334.07, 1336.11,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -1000.07, 298.55, 1336.11,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -999.40, 258.74, 1336.11,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -999.70, 208.21, 1336.11,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -1000.58, 168.72, 1336.11,   0.00, 0.00, 0.00);
	CreateDynamicObject(5425, -1011.30, -74.45, 1339.89,   0.00, 0.00, 270.00);
	CreateDynamicObject(5416, -999.17, -64.16, 1339.79,   0.00, 0.00, 0.00);
	CreateDynamicObject(5341, -993.27, 10.21, 1339.98,   0.00, 0.00, 90.00);
	CreateDynamicObject(6959, -1038.29, 59.64, 1336.11,   0.00, 0.00, 2.00);
	CreateDynamicObject(5421, -995.24, -83.46, 1341.12,   0.00, 0.00, 0.00);
	CreateDynamicObject(2910, -1047.96, 45.23, 1336.00,   0.00, 0.00, 0.00);
	CreateDynamicObject(2910, -1048.13, -125.48, 1336.00,   0.00, 0.00, 0.00);
	CreateDynamicObject(3830, -1026.74, -84.46, 1341.90,   0.00, 0.00, 0.00);
	CreateDynamicObject(3842, -1028.64, -34.32, 1341.82,   0.00, 0.00, 0.00);
	CreateDynamicObject(3843, -1031.57, 10.46, 1341.70,   0.00, 0.00, 0.00);
	CreateDynamicObject(3844, -1025.33, 34.08, 1341.78,   0.00, 0.00, 0.00);
	CreateDynamicObject(13127, -1007.75, -197.32, 1336.11,   0.00, 0.00, 270.00);
	CreateDynamicObject(13088, -1047.85, -338.31, 1322.52,   0.00, 0.00, 0.00);
	CreateDynamicObject(5494, -1032.47, -239.17, 1335.98,   0.00, 0.00, 179.99);
	CreateDynamicObject(5494, -978.03, -231.34, 1335.98,   0.00, 0.00, 270.00);
	CreateDynamicObject(12814, -1006.68, -216.19, 1335.96,   0.00, 0.00, 0.00);
	CreateDynamicObject(12814, -1009.92, -166.47, 1335.96,   0.00, 0.00, 0.00);
	CreateDynamicObject(12814, -1026.74, -145.93, 1335.96,   0.00, 0.00, 0.00);
	CreateDynamicObject(12814, -1004.67, -127.53, 1335.96,   0.00, 0.00, 90.00);
	CreateDynamicObject(12814, -1024.46, -96.41, 1335.96,   0.00, 0.00, 0.00);
	CreateDynamicObject(12814, -1000.61, -152.18, 1335.96,   0.00, 0.00, 90.00);
	CreateDynamicObject(11008, -1007.49, -217.05, 1342.61,   0.00, 0.00, 0.00);
	CreateDynamicObject(11015, -1006.31, -188.73, 1337.93,   0.00, 0.00, 0.00);
	CreateDynamicObject(826, -1017.77, -181.29, 1336.01,   0.00, 0.00, 0.00);
	CreateDynamicObject(826, -1017.31, -186.77, 1336.01,   0.00, 0.00, 0.00);
	CreateDynamicObject(826, -1016.88, -192.00, 1336.01,   0.00, 0.00, 0.00);
	CreateDynamicObject(826, -1016.71, -194.00, 1336.01,   0.00, 0.00, 0.00);
	CreateDynamicObject(826, -997.26, -196.29, 1336.01,   0.00, 0.00, 0.00);
	CreateDynamicObject(826, -997.49, -190.29, 1336.01,   0.00, 0.00, 0.00);
	CreateDynamicObject(826, -997.92, -186.04, 1336.01,   0.00, 0.00, 0.00);
	CreateDynamicObject(826, -997.68, -181.19, 1336.01,   0.00, 0.00, 0.00);
	CreateDynamicObject(7191, -980.17, -141.45, 1337.95,   0.00, 0.00, 0.00);
	CreateDynamicObject(7191, -980.19, -137.15, 1337.95,   0.00, 0.00, 180.00);
	CreateDynamicObject(3749, -970.24, -166.30, 1341.77,   0.00, 0.00, 0.00);
	CreateDynamicObject(7191, -1039.96, -137.47, 1337.95,   0.00, 0.00, 179.99);
	CreateDynamicObject(3749, -1038.41, -207.56, 1341.91,   0.00, 0.00, 88.00);
	CreateDynamicObject(984, -1019.00, -237.20, 1336.67,   0.00, 0.00, 270.00);
	CreateDynamicObject(984, -1006.17, -237.14, 1336.67,   0.00, 0.00, 270.00);
	CreateDynamicObject(984, -1002.79, -237.25, 1336.67,   0.00, 0.00, 270.00);
	CreateDynamicObject(984, -997.62, -230.95, 1336.67,   0.00, 0.00, 2.00);
	CreateDynamicObject(826, -997.99, -234.04, 1336.01,   0.00, 0.00, 0.00);
	CreateDynamicObject(826, -1003.20, -233.81, 1336.01,   0.00, 0.00, 0.00);
	CreateDynamicObject(826, -1010.10, -233.95, 1336.01,   0.00, 0.00, 0.00);
	CreateDynamicObject(826, -1016.10, -234.22, 1336.01,   0.00, 0.00, 0.00);
	CreateDynamicObject(984, -975.43, -171.64, 1336.72,   0.00, 0.00, 0.00);
	CreateDynamicObject(984, -975.31, -182.67, 1336.83,   0.00, 0.00, 360.00);
	CreateDynamicObject(984, -975.37, -195.24, 1336.83,   0.00, 0.00, 359.99);
	CreateDynamicObject(984, -975.18, -218.89, 1336.83,   0.00, 0.00, 359.99);
	CreateDynamicObject(984, -975.15, -229.99, 1336.83,   0.00, 0.00, 359.99);
	CreateDynamicObject(984, -965.33, -173.65, 1336.83,   0.00, 0.00, 359.99);
	CreateDynamicObject(984, -965.31, -186.40, 1336.83,   0.00, 0.00, 359.99);
	CreateDynamicObject(984, -965.28, -199.15, 1336.83,   0.00, 0.00, 359.99);
	CreateDynamicObject(984, -965.25, -212.65, 1336.83,   0.00, 0.00, 359.99);
	CreateDynamicObject(984, -965.31, -225.10, 1336.83,   0.00, 0.00, 359.99);
	CreateDynamicObject(984, -965.36, -235.00, 1336.83,   0.00, 0.00, 359.99);
	CreateDynamicObject(3749, -970.91, -166.25, 1341.77,   0.00, 0.00, 0.00);
	CreateDynamicObject(11533, -946.18, -21.46, 1322.00,   0.00, 0.00, 157.99);
	CreateDynamicObject(11513, -950.16, -104.14, 1353.78,   0.00, 0.00, 152.00);
	CreateDynamicObject(11513, -951.78, -182.53, 1353.78,   0.00, 0.00, 152.00);
	CreateDynamicObject(11513, -949.73, -272.28, 1353.78,   0.00, 0.00, 152.00);
	CreateDynamicObject(11513, -977.98, -272.53, 1353.78,   0.00, 0.00, 50.00);
	CreateDynamicObject(11513, -1025.71, -272.31, 1353.78,   0.00, 0.00, 49.99);
	CreateDynamicObject(11513, -1066.24, -243.26, 1353.78,   0.00, 0.00, 333.99);
	CreateDynamicObject(11513, -1069.30, -156.56, 1353.78,   0.00, 0.00, 333.99);
	CreateDynamicObject(11513, -1069.12, -94.46, 1353.78,   0.00, 0.00, 325.99);
	CreateDynamicObject(11513, -1067.59, -15.33, 1353.78,   0.00, 0.00, 331.99);
	CreateDynamicObject(11513, -1058.98, 73.43, 1353.78,   0.00, 0.00, 321.98);
	CreateDynamicObject(6959, -943.62, -18.30, 1336.11,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -942.88, -95.83, 1336.11,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -940.02, -179.80, 1336.11,   0.00, 0.00, 0.00);
	CreateDynamicObject(12814, -973.11, -271.39, 1335.96,   0.00, 0.00, 90.00);
	CreateDynamicObject(12814, -1026.04, -270.47, 1335.96,   0.00, 0.00, 90.00);
	CreateDynamicObject(12814, -1070.09, -239.28, 1335.96,   0.00, 0.00, 180.00);
	CreateDynamicObject(12814, -1067.90, -148.14, 1335.96,   0.00, 0.00, 179.99);
	CreateDynamicObject(12814, -1071.76, -98.54, 1335.96,   0.00, 0.00, 179.99);
	CreateDynamicObject(12814, -1070.75, -22.17, 1335.96,   0.00, 0.00, 179.99);
	CreateDynamicObject(5341, -1014.37, -6.16, 1339.73,   0.00, 0.00, 0.00);
	CreateDynamicObject(3843, -1025.78, -106.93, 1343.25,   0.00, 0.00, 0.00);
	CreateDynamicObject(11513, -945.83, 180.26, 1350.58,   0.00, 0.00, 147.98);
	CreateDynamicObject(16148, -878.84, 116.91, 1337.72,   0.00, 0.00, 38.00);
	CreateDynamicObject(10774, -1019.73, -142.45, 1335.87,   0.00, 0.00, 270.00);
	CreateDynamicObject(1503, -1011.59, -124.25, 1335.97,   0.00, 0.00, 182.00);
	CreateDynamicObject(6959, -1205.84, 468.74, 1335.72,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -1235.79, 462.15, 1335.72,   0.00, 0.00, 0.00);
	CreateDynamicObject(10951, -1221.57, 536.01, 1344.21,   0.00, 0.00, 0.00);
	CreateDynamicObject(3049, -1250.56, 343.37, 1338.40,   0.00, 0.00, 357.99);
	CreateDynamicObject(9951, -1157.39, 480.05, 1347.39,   0.00, 0.00, 90.00);
	CreateDynamicObject(9931, -1268.77, 317.84, 1352.19,   0.00, 0.00, 90.00);
	CreateDynamicObject(12814, -1240.08, 323.94, 1335.98,   0.00, 0.00, 0.00);
	CreateDynamicObject(12814, -1284.05, 317.15, 1335.98,   0.00, 0.00, 0.00);
	CreateDynamicObject(12814, -1303.41, 355.45, 1335.98,   0.00, 0.00, 0.00);
	CreateDynamicObject(12814, -1225.08, 336.68, 1335.98,   0.00, 0.00, 0.00);
	CreateDynamicObject(12814, -1311.23, 329.32, 1335.98,   0.00, 0.00, 0.00);
	CreateDynamicObject(9951, -1198.50, 480.51, 1347.39,   0.00, 0.00, 90.00);
	CreateDynamicObject(9951, -1200.07, 485.08, 1347.39,   0.00, 0.00, 270.00);
	CreateDynamicObject(5507, -1130.88, 458.55, 1335.98,   0.00, 0.00, 0.00);
	CreateDynamicObject(5507, -1153.87, 448.94, 1393.85,   0.00, 0.00, 0.00);
	CreateDynamicObject(10951, -1221.12, 573.78, 1343.71,   0.00, 0.00, 0.00);
	CreateDynamicObject(10951, -1220.93, 609.42, 1343.71,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -761.20, 594.18, 1366.81,   270.99, 0.98, 2.00);
	CreateDynamicObject(6959, -788.44, 593.91, 1359.81,   270.99, 0.98, 1.99);
	CreateDynamicObject(6959, -819.23, 593.91, 1356.06,   270.99, 0.98, 1.99);
	CreateDynamicObject(6959, -856.98, 593.32, 1356.06,   270.99, 0.98, 1.99);
	CreateDynamicObject(6959, -931.47, 484.73, 1339.25,   270.99, 0.98, 1.99);
	CreateDynamicObject(6959, -939.62, 513.38, 1344.81,   270.99, 0.97, 181.99);
	CreateDynamicObject(974, -930.36, 510.21, 1348.47,   0.00, 0.00, 270.00);
	CreateDynamicObject(974, -930.05, 506.22, 1348.47,   0.00, 0.00, 270.00);
	CreateDynamicObject(974, -927.11, 502.80, 1348.47,   0.00, 0.00, 0.00);
	CreateDynamicObject(974, -921.34, 502.92, 1348.47,   0.00, 0.00, 0.00);
	CreateDynamicObject(974, -916.34, 502.83, 1348.47,   0.00, 0.00, 0.00);
	CreateDynamicObject(974, -914.56, 503.21, 1348.47,   0.00, 0.00, 0.00);
	CreateDynamicObject(974, -911.09, 506.33, 1348.47,   0.00, 0.00, 90.00);
	CreateDynamicObject(974, -911.38, 509.82, 1348.47,   0.00, 0.00, 90.00);
	CreateDynamicObject(974, -911.17, 516.57, 1348.47,   0.00, 0.00, 90.00);
	CreateDynamicObject(974, -911.20, 520.38, 1348.47,   0.00, 0.00, 90.00);
	CreateDynamicObject(6959, -932.05, 523.43, 1344.81,   270.99, 0.97, 181.99);
	CreateDynamicObject(5507, -900.91, 502.64, 1345.87,   0.00, 0.00, 90.00);
	CreateDynamicObject(5507, -899.42, 552.29, 1345.87,   0.00, 0.00, 90.00);
	CreateDynamicObject(5507, -900.58, 569.09, 1345.87,   0.00, 0.00, 90.00);
	CreateDynamicObject(6959, -870.27, 486.89, 1353.62,   270.99, 0.97, 183.98);
	CreateDynamicObject(6959, -865.86, 487.00, 1353.12,   270.99, 0.97, 183.98);
	CreateDynamicObject(6959, -868.41, 515.24, 1348.37,   270.99, 0.97, 179.98);
	CreateDynamicObject(6959, -866.39, 515.34, 1348.37,   270.99, 0.97, 179.97);
	CreateDynamicObject(3361, -891.92, 510.04, 1348.14,   0.00, 0.00, 180.00);
	CreateDynamicObject(3361, -882.86, 510.00, 1348.14,   0.00, 0.00, 357.99);
	CreateDynamicObject(974, -881.54, 505.52, 1350.90,   0.00, 0.00, 0.00);
	CreateDynamicObject(974, -881.54, 505.52, 1354.40,   0.00, 0.00, 0.00);
	CreateDynamicObject(974, -887.09, 505.54, 1354.40,   0.00, 0.00, 0.00);
	CreateDynamicObject(974, -887.09, 505.54, 1349.65,   0.00, 0.00, 0.00);
	CreateDynamicObject(16438, -881.60, 496.72, 1347.75,   0.00, 0.00, 0.00);
	CreateDynamicObject(974, -889.15, 514.26, 1348.65,   0.00, 0.00, 90.00);
	CreateDynamicObject(974, -888.52, 505.69, 1348.65,   0.00, 0.00, 90.00);
	CreateDynamicObject(974, -889.02, 505.66, 1348.65,   0.00, 0.00, 90.00);
	CreateDynamicObject(16438, -882.78, 483.71, 1347.75,   0.00, 0.00, 0.00);
	CreateDynamicObject(12814, -958.89, 490.46, 1340.09,   87.17, 45.02, 225.01);
	CreateDynamicObject(974, -960.25, 520.11, 1343.46,   0.00, 0.00, 270.00);
	CreateDynamicObject(974, -960.16, 516.40, 1343.72,   0.00, 0.00, 270.00);
	CreateDynamicObject(974, -947.90, 487.88, 1348.47,   0.00, 0.00, 270.00);
	CreateDynamicObject(974, -947.86, 493.04, 1348.47,   0.00, 0.00, 270.00);
	CreateDynamicObject(974, -947.83, 498.19, 1348.47,   0.00, 0.00, 270.00);
	CreateDynamicObject(974, -947.81, 501.75, 1348.47,   0.00, 0.00, 270.00);
	CreateDynamicObject(974, -951.04, 505.00, 1348.47,   0.00, 0.00, 0.00);
	CreateDynamicObject(974, -955.32, 505.18, 1347.72,   0.00, 0.00, 0.00);
	CreateDynamicObject(974, -955.32, 505.18, 1342.22,   0.00, 0.00, 0.00);
	CreateDynamicObject(8136, -997.84, 436.29, 1311.46,   273.99, 269.95, 269.95);
	CreateDynamicObject(8136, -997.87, 433.43, 1311.46,   273.99, 269.95, 269.95);
	CreateDynamicObject(8419, -1154.65, 600.65, 1347.51,   0.00, 0.00, 270.00);
	CreateDynamicObject(4564, -1144.07, 528.84, 1442.33,   0.00, 0.00, 88.00);
	CreateDynamicObject(4564, -1144.23, 539.79, 1442.33,   0.00, 0.00, 89.99);
	CreateDynamicObject(6959, -1134.63, 513.77, 1336.38,   270.99, 0.00, 179.99);
	CreateDynamicObject(6959, -1154.96, 513.69, 1336.38,   270.99, 0.00, 179.99);
	CreateDynamicObject(6959, -1103.49, 533.97, 1335.93,   270.99, 0.00, 270.00);
	CreateDynamicObject(6959, -1123.82, 516.39, 1335.93,   270.99, 0.00, 172.00);
	CreateDynamicObject(6959, -1123.73, 513.44, 1336.38,   270.99, 0.00, 179.99);
	CreateDynamicObject(6959, -1123.98, 558.71, 1335.93,   270.99, 0.00, 0.00);
	CreateDynamicObject(974, -1064.65, 560.93, 1338.71,   0.00, 0.00, 0.00);
	CreateDynamicObject(974, -1071.11, 560.97, 1338.71,   0.00, 0.00, 0.00);
	CreateDynamicObject(974, -1077.68, 560.89, 1338.71,   0.00, 0.00, 0.00);
	CreateDynamicObject(974, -1079.36, 560.88, 1338.71,   0.00, 0.00, 0.00);
	CreateDynamicObject(974, -1082.51, 557.58, 1338.71,   0.00, 0.00, 92.00);
	CreateDynamicObject(974, -1081.78, 515.66, 1338.71,   0.00, 0.00, 180.00);
	CreateDynamicObject(974, -1075.60, 516.06, 1338.71,   0.00, 0.00, 179.99);
	CreateDynamicObject(974, -1071.40, 515.83, 1338.71,   0.00, 0.00, 179.99);
	CreateDynamicObject(974, -1067.66, 516.06, 1338.40,   0.00, 0.00, 179.99);
	CreateDynamicObject(974, -1065.61, 516.06, 1338.71,   0.00, 0.00, 179.99);
	CreateDynamicObject(974, -1065.12, 515.74, 1338.40,   0.00, 0.00, 179.99);
	CreateDynamicObject(6959, -1119.13, 447.95, 1335.51,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -1031.61, 563.11, 1345.26,   270.99, 0.00, 90.00);
	CreateDynamicObject(8136, -1005.74, 444.04, 1311.46,   273.99, 269.94, 269.95);
	CreateDynamicObject(3598, -993.70, -108.74, 1339.75,   0.00, 0.00, 0.00);
	CreateDynamicObject(3599, -993.15, -9.03, 1343.10,   0.00, 0.00, 0.00);
	CreateDynamicObject(2946, -992.87, -12.41, 1337.65,   0.00, 0.00, 90.00);
	CreateDynamicObject(2946, -993.28, -12.41, 1337.68,   0.00, 0.00, 270.00);
	CreateDynamicObject(1493, -1021.21, -13.73, 1337.71,   0.00, 0.00, 0.00);
	CreateDynamicObject(1496, -990.36, -86.54, 1338.56,   0.00, 0.00, 90.00);
	CreateDynamicObject(7191, -1040.10, -179.21, 1337.95,   0.00, 0.00, 179.99);
	CreateDynamicObject(3759, -996.87, -35.08, 1341.71,   0.00, 0.00, 180.00);
	CreateDynamicObject(826, -993.68, 34.36, 1336.14,   0.00, 0.00, 0.00);
	CreateDynamicObject(826, -989.40, 34.09, 1336.14,   0.00, 0.00, 0.00);
	CreateDynamicObject(826, -985.66, 34.29, 1336.14,   0.00, 0.00, 0.00);
	CreateDynamicObject(826, -981.42, 34.52, 1336.14,   0.00, 0.00, 0.00);
	CreateDynamicObject(826, -981.01, 27.03, 1336.14,   0.00, 0.00, 0.00);
	CreateDynamicObject(826, -985.00, 26.81, 1336.14,   0.00, 0.00, 0.00);
	CreateDynamicObject(826, -988.99, 26.60, 1336.14,   0.00, 0.00, 0.00);
	CreateDynamicObject(826, -993.49, 26.35, 1336.14,   0.00, 0.00, 0.00);
	CreateDynamicObject(826, -985.13, -35.10, 1338.45,   0.00, 0.00, 0.00);
	CreateDynamicObject(826, -985.13, -35.10, 1338.45,   0.00, 0.00, 0.00);
	CreateDynamicObject(14738, -1116.42, 487.38, 1326.37,   0.00, 0.00, 182.00);
	CreateDynamicObject(6959, -1068.98, 463.45, 1335.89,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -1052.90, 474.12, 1335.89,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -1093.71, 509.09, 1335.89,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -1096.01, 483.63, 1315.64,   270.00, 0.00, 0.00);
	CreateDynamicObject(6959, -1092.36, 486.12, 1329.03,   20.00, 0.00, 270.00);
	CreateDynamicObject(6959, -1085.47, 489.29, 1315.64,   269.99, 0.00, 0.00);
	CreateDynamicObject(9310, -1299.55, 362.96, 1341.82,   0.00, 0.00, 178.00);
	CreateDynamicObject(974, -1106.68, 486.28, 1332.32,   0.00, 0.00, 272.00);
	CreateDynamicObject(974, -1106.68, 486.28, 1332.82,   0.00, 0.00, 272.00);
	CreateDynamicObject(974, -1106.62, 486.52, 1332.82,   0.00, 0.00, 272.00);
	CreateDynamicObject(974, -1106.62, 486.52, 1331.57,   0.00, 0.00, 272.00);
	CreateDynamicObject(1491, -1106.42, 486.39, 1323.88,   0.00, 0.00, 268.00);
	CreateDynamicObject(1597, -1147.37, 575.42, 1338.48,   0.00, 0.00, 270.00);
	CreateDynamicObject(1597, -1127.06, 575.09, 1338.48,   0.00, 0.00, 270.00);
	CreateDynamicObject(1597, -1183.06, 574.36, 1338.25,   0.00, 0.00, 270.00);
	CreateDynamicObject(1597, -1177.03, 498.81, 1338.49,   0.00, 0.00, 270.00);
	CreateDynamicObject(1597, -1151.93, 497.98, 1338.66,   0.00, 0.00, 270.00);
	CreateDynamicObject(1597, -1124.31, 497.71, 1338.66,   0.00, 0.00, 270.00);
	CreateDynamicObject(6959, -1175.59, 534.31, 1335.38,   270.99, 0.00, 89.99);
	CreateDynamicObject(6959, -1175.49, 538.06, 1335.38,   270.99, 0.00, 89.99);
	CreateDynamicObject(6959, -1154.58, 558.73, 1335.38,   270.99, 0.00, 359.99);
	CreateDynamicObject(2395, -1106.32, 486.98, 1323.91,   0.00, 0.00, 88.00);
	CreateDynamicObject(2395, -1106.25, 481.72, 1323.91,   0.00, 0.00, 87.99);
	CreateDynamicObject(2395, -1106.32, 486.98, 1326.16,   0.00, 0.00, 87.99);
	CreateDynamicObject(2395, -1106.32, 486.98, 1328.91,   0.00, 0.00, 87.99);
	CreateDynamicObject(2395, -1106.32, 486.98, 1331.41,   0.00, 0.00, 87.99);
	CreateDynamicObject(2395, -1106.32, 486.98, 1332.91,   0.00, 0.00, 87.99);
	CreateDynamicObject(2395, -1106.43, 483.73, 1332.91,   0.00, 0.00, 87.99);
	CreateDynamicObject(2395, -1106.43, 483.73, 1330.66,   0.00, 0.00, 87.99);
	CreateDynamicObject(2395, -1106.43, 483.73, 1328.66,   0.00, 0.00, 87.99);
	CreateDynamicObject(2395, -1106.43, 483.73, 1326.16,   0.00, 0.00, 87.99);
	CreateDynamicObject(2395, -1106.27, 482.22, 1326.41,   0.00, 0.00, 87.99);
	CreateDynamicObject(2395, -1106.27, 482.22, 1328.91,   0.00, 0.00, 87.99);
	CreateDynamicObject(2395, -1106.27, 482.22, 1331.16,   0.00, 0.00, 87.99);
	CreateDynamicObject(2395, -1106.27, 482.22, 1332.91,   0.00, 0.00, 87.99);
	CreateDynamicObject(16151, -1120.35, 484.26, 1324.25,   0.00, 0.00, 272.00);
	CreateDynamicObject(2924, -1107.95, 491.59, 1324.95,   0.00, 0.00, 0.00);
	CreateDynamicObject(12814, -944.97, 473.51, 1340.09,   87.17, 45.02, 315.01);
	CreateDynamicObject(12814, -926.09, 473.34, 1340.09,   87.17, 45.02, 315.01);
	CreateDynamicObject(6959, -931.04, 490.12, 1343.76,   6.00, 0.00, 270.00);
	CreateDynamicObject(6959, -940.54, 490.06, 1343.01,   5.99, 0.00, 270.00);
	CreateDynamicObject(974, -878.15, 502.17, 1350.90,   0.00, 0.00, 272.00);
	CreateDynamicObject(974, -878.11, 495.41, 1350.90,   0.00, 0.00, 270.00);
	CreateDynamicObject(974, -878.30, 489.41, 1350.90,   0.00, 0.00, 269.99);
	CreateDynamicObject(1231, -1130.59, 450.36, 1338.79,   0.00, 0.00, 0.00);
	CreateDynamicObject(1231, -1131.64, 466.02, 1338.79,   0.00, 0.00, 0.00);
	CreateDynamicObject(1231, -1104.47, 465.73, 1338.79,   0.00, 0.00, 0.00);
	CreateDynamicObject(1522, -1164.93, 575.95, 1335.83,   0.00, 0.00, 0.00);
	CreateDynamicObject(1522, -1165.18, 575.94, 1335.83,   0.00, 0.00, 0.00);
	CreateDynamicObject(10184, -941.76, 428.18, 1346.61,   0.00, 0.00, 0.00);
	CreateDynamicObject(2395, -1113.96, 491.46, 1325.41,   0.00, 0.00, 1.99);
	CreateDynamicObject(6985, -931.01, 702.10, 1341.02,   0.00, 0.00, 90.00);
	CreateDynamicObject(6959, -955.18, 636.57, 1340.81,   0.00, 0.00, 0.00);
	CreateDynamicObject(2910, -970.89, 744.85, 1340.89,   0.00, 0.00, 0.00);
	CreateDynamicObject(2910, -970.89, 744.85, 1340.89,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -1001.29, 713.19, 1341.06,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -1001.22, 673.35, 1341.06,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -1001.18, 753.09, 1341.06,   0.00, 0.00, 0.00);
	CreateDynamicObject(8409, -692.53, 683.13, 1373.72,   0.00, 0.00, 270.00);
	CreateDynamicObject(8411, -998.46, 846.86, 1343.33,   0.00, 0.00, 90.00);
	CreateDynamicObject(10412, -1013.43, 716.42, 1367.58,   0.00, 0.00, 26.00);
	CreateDynamicObject(5408, -918.98, 890.58, 1363.18,   0.00, 0.00, 0.00);
	CreateDynamicObject(2910, -970.87, 914.65, 1340.89,   0.00, 0.00, 0.00);
	CreateDynamicObject(8420, -921.06, 816.80, 1341.01,   0.00, 0.00, 180.00);
	CreateDynamicObject(6959, -940.37, 758.06, 1341.06,   0.00, 0.00, 0.00);
	CreateDynamicObject(2910, -722.46, 710.01, 1370.96,   0.00, 0.00, 179.99);
	CreateDynamicObject(3749, -722.87, 625.48, 1376.74,   0.00, 0.00, 0.00);
	CreateDynamicObject(3749, -721.62, 625.47, 1376.74,   0.00, 0.00, 0.00);
	CreateDynamicObject(2910, -722.31, 880.58, 1370.96,   0.00, 0.00, 179.99);
	CreateDynamicObject(2910, -878.87, 1013.66, 1353.12,   12.00, 0.00, 269.99);
	CreateDynamicObject(5494, -737.94, 1006.08, 1370.91,   0.00, 0.00, 359.98);
	CreateDynamicObject(5494, -962.97, 998.02, 1341.05,   0.00, 0.00, 89.99);
	CreateDynamicObject(4101, -792.08, 729.86, 1388.45,   0.00, 0.00, 270.00);
	CreateDynamicObject(5426, -681.11, 764.06, 1373.39,   0.00, 0.00, 270.00);
	CreateDynamicObject(5435, -782.01, 777.07, 1371.04,   0.00, 0.00, 0.00);
	CreateDynamicObject(5435, -841.46, 777.19, 1371.04,   0.00, 0.00, 179.99);
	CreateDynamicObject(1597, -822.23, 765.42, 1373.62,   0.00, 0.00, 268.00);
	CreateDynamicObject(1597, -742.03, 765.62, 1373.62,   0.00, 0.00, 269.99);
	CreateDynamicObject(6959, -960.98, 984.61, 1351.00,   270.00, 179.03, 269.04);
	CreateDynamicObject(2910, -817.56, 995.04, 1370.96,   0.00, 0.00, 89.99);
	CreateDynamicObject(11083, -669.80, 906.78, 1373.25,   0.00, 0.00, 0.00);
	CreateDynamicObject(8136, -792.15, 909.62, 1375.50,   0.00, 0.00, 0.00);
	CreateDynamicObject(1597, -712.15, 682.72, 1373.62,   0.00, 0.00, 359.99);
	CreateDynamicObject(8664, -890.91, 1004.74, 1296.28,   0.00, 270.00, 270.00);
	CreateDynamicObject(11429, -866.78, 746.97, 1382.18,   0.00, 0.00, 357.99);
	CreateDynamicObject(6959, -960.92, 965.43, 1351.00,   270.00, 179.04, 269.04);
	CreateDynamicObject(3988, -915.76, 968.31, 1378.94,   0.00, 0.00, 270.00);
	CreateDynamicObject(6959, -920.80, 964.52, 1370.62,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -940.45, 964.46, 1371.12,   0.00, 0.00, 0.00);
	CreateDynamicObject(2910, -876.25, 994.95, 1370.96,   0.00, 0.00, 89.99);
	CreateDynamicObject(11429, -862.01, 837.85, 1382.18,   0.00, 0.00, 19.99);
	CreateDynamicObject(11429, -879.04, 818.01, 1382.18,   0.00, 0.00, 235.98);
	CreateDynamicObject(11429, -867.99, 785.00, 1378.68,   0.00, 0.00, 121.98);
	CreateDynamicObject(11429, -859.11, 759.20, 1439.91,   0.00, 0.00, 283.97);
	CreateDynamicObject(6959, -845.09, 760.07, 1389.25,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -846.17, 788.41, 1389.25,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -805.87, 772.35, 1389.25,   0.00, 0.00, 0.00);
	CreateDynamicObject(11429, -879.04, 818.01, 1382.18,   0.00, 0.00, 235.98);
	CreateDynamicObject(6959, -802.76, 1004.90, 1351.25,   270.00, 179.03, 179.03);
	CreateDynamicObject(8664, -891.13, 945.00, 1296.28,   0.00, 270.00, 90.00);
	CreateDynamicObject(4894, -838.97, 970.19, 1377.84,   0.00, 0.00, 0.00);
	CreateDynamicObject(5182, -755.92, 969.93, 1373.98,   0.00, 0.00, 0.00);
	CreateDynamicObject(5140, -783.60, 963.27, 1372.97,   0.00, 0.00, 270.00);
	CreateDynamicObject(6959, -797.81, 967.25, 1371.12,   0.00, 0.00, 0.00);
	CreateDynamicObject(11083, -669.73, 939.05, 1373.25,   0.00, 0.00, 0.00);
	CreateDynamicObject(8663, -799.29, 856.36, 1394.33,   0.00, 0.00, 0.00);
	CreateDynamicObject(9254, -748.76, 813.05, 1371.43,   0.00, 0.00, 270.00);
	CreateDynamicObject(9254, -782.63, 817.34, 1371.43,   0.00, 0.00, 90.00);
	CreateDynamicObject(6959, -752.78, 857.18, 1371.12,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -752.69, 896.98, 1371.12,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -752.70, 896.98, 1371.12,   0.00, 0.00, 0.00);
	CreateDynamicObject(11429, -869.71, 820.12, 1382.18,   0.00, 0.00, 225.98);
	CreateDynamicObject(6959, -752.59, 936.46, 1371.12,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -732.06, 968.60, 1351.34,   270.00, 180.70, 90.70);
	CreateDynamicObject(11513, -637.48, 723.38, 1396.33,   0.00, 0.00, 153.99);
	CreateDynamicObject(11513, -639.92, 726.22, 1396.33,   0.00, 0.00, 87.98);
	CreateDynamicObject(11513, -643.83, 817.30, 1396.33,   0.00, 0.00, 153.98);
	CreateDynamicObject(11513, -654.88, 913.55, 1396.33,   0.00, 0.00, 153.98);
	CreateDynamicObject(11513, -666.95, 1011.98, 1396.33,   0.00, 0.00, 153.98);
	CreateDynamicObject(11513, -707.22, 1030.88, 1396.33,   0.00, 0.00, 231.98);
	CreateDynamicObject(11513, -752.33, 1033.11, 1390.59,   0.00, 10.00, 243.98);
	CreateDynamicObject(11513, -851.30, 1041.47, 1390.59,   0.00, 10.00, 221.98);
	CreateDynamicObject(11513, -887.27, 1039.93, 1374.35,   0.00, 10.00, 221.98);
	CreateDynamicObject(11513, -912.39, 1037.77, 1355.01,   0.00, 10.00, 221.98);
	CreateDynamicObject(11513, -924.40, 1029.90, 1342.45,   0.00, 10.00, 243.98);
	CreateDynamicObject(11513, -944.18, 1054.18, 1342.45,   0.00, 10.00, 197.97);
	CreateDynamicObject(11513, -924.66, 1038.34, 1374.10,   0.00, 10.00, 227.97);
	CreateDynamicObject(6959, -924.51, 1039.90, 1343.43,   0.00, 348.00, 0.00);
	CreateDynamicObject(6959, -834.93, 1038.93, 1362.56,   0.00, 348.00, 0.00);
	CreateDynamicObject(6959, -815.16, 1039.48, 1366.48,   0.00, 348.00, 0.00);
	CreateDynamicObject(6959, -774.65, 1039.29, 1370.91,   0.00, 0.00, 0.00);
	CreateDynamicObject(9132, -745.05, 909.81, 1389.96,   0.00, 0.00, 270.00);
	CreateDynamicObject(8136, -813.24, 917.34, 1375.50,   0.00, 0.00, 0.00);
	CreateDynamicObject(8136, -851.27, 916.75, 1375.50,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -903.65, 791.03, 1340.83,   0.00, 0.00, 0.00);
	CreateDynamicObject(6522, -1019.09, 717.07, 1348.58,   0.00, 0.00, 0.00);
	CreateDynamicObject(6285, -1009.18, 505.31, 1340.37,   0.00, 0.00, 270.00);
	CreateDynamicObject(4585, -1000.86, 872.40, 1330.56,   90.00, 180.70, 179.30);
	CreateDynamicObject(4576, -1008.67, 958.77, 1317.95,   0.00, 0.00, 180.00);
	CreateDynamicObject(2910, -1066.12, 1013.50, 1341.17,   0.00, 0.00, 89.99);
	CreateDynamicObject(6959, -1000.28, 990.33, 1341.06,   0.00, 0.00, 0.00);
	CreateDynamicObject(7940, -1035.29, 991.20, 1344.06,   0.00, 0.00, 180.00);
	CreateDynamicObject(8427, -1100.26, 999.91, 1344.39,   0.00, 0.00, 270.00);
	CreateDynamicObject(3486, -1065.31, 987.32, 1348.08,   0.00, 0.00, 180.00);
	CreateDynamicObject(11513, -1008.55, 1039.86, 1337.99,   0.00, 10.00, 217.97);
	CreateDynamicObject(6959, -988.91, 1038.99, 1341.06,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -967.14, 1040.69, 1341.06,   0.00, 0.00, 0.00);
	CreateDynamicObject(11513, -981.43, 1021.27, 1337.99,   0.00, 10.00, 317.97);
	CreateDynamicObject(3110, -968.40, 1020.64, 1339.00,   0.00, 0.00, 22.00);
	CreateDynamicObject(2946, -955.20, 890.78, 1340.70,   0.00, 0.00, 0.00);
	CreateDynamicObject(2946, -955.20, 890.79, 1340.72,   0.00, 0.00, 182.00);
	CreateDynamicObject(2957, -955.23, 886.91, 1342.32,   0.00, 0.00, 90.00);
	CreateDynamicObject(2957, -955.14, 894.51, 1342.32,   0.00, 0.00, 90.00);
	CreateDynamicObject(11513, -986.23, 1023.92, 1356.83,   0.00, 10.00, 317.97);
	CreateDynamicObject(11513, -1019.35, 937.43, 1356.83,   0.00, 10.00, 295.97);
	CreateDynamicObject(11513, -1016.06, 870.67, 1356.83,   0.00, 10.00, 355.97);
	CreateDynamicObject(3037, -794.21, 782.85, 1372.66,   0.00, 0.00, 0.00);
	CreateDynamicObject(3037, -794.21, 782.85, 1376.66,   0.00, 0.00, 0.00);
	CreateDynamicObject(3037, -798.97, 776.77, 1373.16,   0.00, 0.00, 270.00);
	CreateDynamicObject(3037, -798.97, 776.77, 1377.16,   0.00, 0.00, 270.00);
	CreateDynamicObject(6959, -902.07, 965.84, 1371.12,   0.00, 0.00, 0.00);
	CreateDynamicObject(8136, -911.11, 964.74, 1375.50,   0.00, 0.00, 90.00);
	CreateDynamicObject(8136, -910.73, 964.40, 1375.50,   0.00, 0.00, 270.00);
	CreateDynamicObject(6959, -940.37, 965.35, 1370.62,   0.00, 0.00, 0.00);
	CreateDynamicObject(7900, -960.88, 954.21, 1351.97,   0.00, 0.00, 270.00);
	CreateDynamicObject(7901, -961.02, 976.01, 1352.51,   0.00, 0.00, 270.00);
	CreateDynamicObject(7907, -960.95, 992.21, 1364.39,   0.00, 0.00, 270.00);
	CreateDynamicObject(7908, -911.47, 1004.90, 1358.86,   0.00, 0.00, 180.00);
	CreateDynamicObject(7909, -939.69, 1004.82, 1357.78,   0.00, 0.00, 180.00);
	CreateDynamicObject(7910, -960.82, 996.38, 1352.56,   0.00, 0.00, 270.00);
	CreateDynamicObject(7909, -1120.74, 491.58, 1324.33,   0.00, 0.00, 2.00);
	CreateDynamicObject(7909, -1103.93, 492.22, 1324.33,   0.00, 0.00, 2.00);
	CreateDynamicObject(6959, -1205.84, 468.74, 1335.72,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -1189.56, 457.30, 1335.58,   0.00, 2.00, 0.00);
	CreateDynamicObject(5507, -1191.05, 458.55, 1335.98,   0.00, 0.00, 0.00);
	CreateDynamicObject(5507, -1108.78, 418.66, 1335.98,   0.00, 0.00, 90.00);
	CreateDynamicObject(5507, -1123.61, 418.48, 1335.98,   0.00, 0.00, 90.00);
	CreateDynamicObject(7033, -1115.95, 441.25, 1340.56,   0.00, 0.00, 0.00);
	CreateDynamicObject(7191, -1114.15, 426.00, 1337.02,   0.00, 0.00, 0.00);
	CreateDynamicObject(7191, -1117.76, 426.41, 1337.02,   0.00, 0.00, 0.00);
	CreateDynamicObject(7191, -1118.51, 426.30, 1337.02,   0.00, 0.00, 0.00);
	CreateDynamicObject(7191, -1118.26, 426.34, 1337.02,   0.00, 0.00, 0.00);
	CreateDynamicObject(7191, -1118.01, 426.37, 1337.02,   0.00, 0.00, 0.00);
	CreateDynamicObject(7922, -1115.17, 447.44, 1337.44,   0.00, 0.00, 0.00);
	CreateDynamicObject(7922, -1117.39, 447.53, 1337.44,   0.00, 0.00, 0.00);
	CreateDynamicObject(7191, -1114.05, 411.75, 1337.02,   0.00, 0.00, 0.00);
	CreateDynamicObject(7191, -1118.63, 411.78, 1337.02,   0.00, 0.00, 0.00);
	CreateDynamicObject(7922, -1117.96, 389.53, 1337.44,   0.00, 0.00, 90.00);
	CreateDynamicObject(7922, -1115.94, 389.54, 1337.44,   0.00, 0.00, 90.00);
	CreateDynamicObject(7922, -1114.67, 389.64, 1337.44,   0.00, 0.00, 90.00);
	CreateDynamicObject(6959, -1158.08, 428.90, 1335.92,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -1158.36, 389.01, 1335.92,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -1117.36, 368.98, 1335.92,   0.00, 0.00, 0.00);
	CreateDynamicObject(7191, -1133.32, 411.51, 1337.02,   0.00, 0.00, 0.00);
	CreateDynamicObject(7191, -1137.35, 411.63, 1337.02,   0.00, 0.00, 0.00);
	CreateDynamicObject(7922, -1136.39, 389.83, 1337.44,   0.00, 0.00, 90.00);
	CreateDynamicObject(7922, -1134.64, 389.73, 1337.44,   0.00, 0.00, 180.00);
	CreateDynamicObject(6959, -1164.39, 349.40, 1335.92,   0.00, 0.00, 2.00);
	CreateDynamicObject(618, -1116.25, 392.28, 1334.05,   0.00, 0.00, 0.00);
	CreateDynamicObject(618, -1115.26, 400.06, 1334.05,   0.00, 0.00, 38.00);
	CreateDynamicObject(618, -1114.02, 408.75, 1334.05,   0.00, 0.00, 86.00);
	CreateDynamicObject(618, -1114.59, 418.75, 1334.05,   0.00, 0.00, 146.00);
	CreateDynamicObject(618, -1115.08, 427.24, 1334.05,   0.00, 0.00, 145.99);
	CreateDynamicObject(618, -1115.42, 433.23, 1334.05,   0.00, 0.00, 145.99);
	CreateDynamicObject(7191, -1144.94, 422.15, 1337.02,   0.00, 0.00, 0.00);
	CreateDynamicObject(7191, -1144.97, 426.45, 1337.02,   0.00, 0.00, 0.00);
	CreateDynamicObject(974, -1141.65, 448.69, 1338.83,   0.00, 0.00, 0.00);
	CreateDynamicObject(974, -1134.43, 448.55, 1338.83,   0.00, 0.00, 0.00);
	CreateDynamicObject(974, -1140.16, 448.70, 1338.83,   0.00, 0.00, 0.00);
	CreateDynamicObject(974, -1131.15, 445.19, 1338.82,   0.00, 0.00, 270.00);
	CreateDynamicObject(974, -1131.14, 442.44, 1338.82,   0.00, 0.00, 270.00);
	CreateDynamicObject(974, -1134.44, 439.16, 1338.26,   0.00, 0.00, 178.00);
	CreateDynamicObject(974, -1141.78, 399.38, 1338.67,   0.00, 0.00, 179.99);
	CreateDynamicObject(974, -1134.37, 399.62, 1337.81,   0.00, 0.00, 179.99);
	CreateDynamicObject(974, -1131.19, 403.27, 1338.83,   0.00, 0.00, 269.99);
	CreateDynamicObject(974, -1131.15, 407.86, 1338.83,   0.00, 0.00, 269.99);
	CreateDynamicObject(974, -1131.26, 415.71, 1338.83,   0.00, 0.00, 269.99);
	CreateDynamicObject(974, -1134.51, 418.84, 1338.83,   0.00, 0.00, 1.99);
	CreateDynamicObject(974, -1132.96, 422.29, 1338.83,   0.00, 0.00, 269.99);
	CreateDynamicObject(974, -1132.97, 427.08, 1338.82,   0.00, 0.00, 269.98);
	CreateDynamicObject(974, -1132.97, 432.19, 1338.82,   0.00, 0.00, 269.98);
	CreateDynamicObject(974, -1132.80, 436.22, 1338.82,   0.00, 0.00, 269.98);
	CreateDynamicObject(16409, -765.62, 893.29, 1371.09,   0.00, 0.00, 180.00);
	CreateDynamicObject(974, -1172.96, 368.73, 1338.83,   0.00, 0.00, 359.99);
	CreateDynamicObject(974, -1176.46, 368.80, 1338.83,   0.00, 0.00, 359.98);
	CreateDynamicObject(11429, -795.08, 849.22, 1428.41,   0.00, 0.00, 13.97);


	
	
	CreateDynamicObject(6959, 2998.5, 1275.2998046875, 6.1999998092651, 0, 0, 0);  /*신도시*/
	CreateDynamicObject(6959, 2998.5, 1315.3000488281, 6.1999998092651, 0, 0, 0);
	CreateDynamicObject(6959, 2998.5, 1355.3000488281, 6.1999998092651, 0, 0, 0);
	CreateDynamicObject(6959, 2998.5, 1395.19921875, 6.1999998092651, 0, 0, 0);
	CreateDynamicObject(6959, 3039.8000488281, 1275.3000488281, 6.1999998092651, 0, 0, 0);
	CreateDynamicObject(6959, 3039.8000488281, 1315.3000488281, 6.1999998092651, 0, 0, 0);
	CreateDynamicObject(6959, 3039.8000488281, 1355.3000488281, 6.1999998092651, 0, 0, 0);
	CreateDynamicObject(6959, 3039.8000488281, 1395.3000488281, 6.1999998092651, 0, 0, 0);
	CreateDynamicObject(6959, 3081.1000976563, 1275.3000488281, 6.1999998092651, 0, 0, 0);
	CreateDynamicObject(6959, 3081.1000976563, 1315.3000488281, 6.1999998092651, 0, 0, 0);
	CreateDynamicObject(6959, 3081.1000976563, 1355.3000488281, 6.1999998092651, 0, 0, 0);
	CreateDynamicObject(6959, 3081.1000976563, 1395.3000488281, 6.1999998092651, 0, 0, 0);
	CreateDynamicObject(13132, 3083.8994140625, 1263.69921875, 9.3999996185303, 0, 0, 0);
	CreateDynamicObject(16051, 3059.1999511719, 1262.4000244141, 9.3000001907349, 0, 0, 179.5);
	CreateDynamicObject(3249, 3085.8000488281, 1278, 6.1999998092651, 0, 0, 270.25);
	CreateDynamicObject(4887, 3120.2998046875, 1297.599609375, 16, 0, 0, 89.994506835938);
	CreateDynamicObject(5189, 3113.6000976563, 1355.9000244141, 11.699999809265, 0, 0, 0);
	CreateDynamicObject(6959, 3122.3999023438, 1355.3000488281, 6.1999998092651, 0, 0, 0);
	CreateDynamicObject(13361, 3076.8000488281, 1400.3000488281, 13.10000038147, 0, 0, 179.99993896484);
	CreateDynamicObject(16012, 3022.6000976563, 1257.5, 6.1999998092651, 0, 0, 0);
	CreateDynamicObject(16067, 3081.8999023438, 1443.3000488281, 6.0999999046326, 0, 0, 0.4942626953125);
	CreateDynamicObject(6959, 3122.3999023438, 1395.3000488281, 6.1999998092651, 0, 0, 0);
	CreateDynamicObject(4857, 3105.6999511719, 1408.4000244141, 8.5, 0, 359.75, 269.99996948242);
	CreateDynamicObject(4888, 2995.3999023438, 1349.8000488281, 15, 0, 0, 272.99438476563);
	CreateDynamicObject(5189, 3143.8999023438, 1446.1999511719, 11.699999809265, 0, 0, 0);
	CreateDynamicObject(8663, 3206.1999511719, 1391.6999511719, 30.200000762939, 0, 0, 180.25004577637);
	CreateDynamicObject(6959, 3122.3994140625, 1435.2998046875, 6.1999998092651, 0, 0, 0);
	CreateDynamicObject(6959, 3163.6999511719, 1435.3000488281, 6.1999998092651, 0, 0, 0);
	CreateDynamicObject(6959, 3163.6999511719, 1395.3000488281, 6.1999998092651, 0, 0, 0);
	CreateDynamicObject(6959, 3163.6999511719, 1355.3000488281, 6.1999998092651, 0, 0, 0);
	CreateDynamicObject(6959, 3122.3000488281, 1315.3000488281, 6.1999998092651, 0, 0, 0);
	CreateDynamicObject(6959, 3163.6000976563, 1315.3000488281, 6.1999998092651, 0, 0, 0);
	CreateDynamicObject(7089, 3142.099609375, 1292.2998046875, 12.60000038147, 0, 0, 270.24719238281);
	CreateDynamicObject(7017, 3144.69921875, 1288.099609375, 7.0999999046326, 0, 0, 270);
	CreateDynamicObject(2960, 3142.1000976563, 1338.5999755859, 6.5, 0, 0, 0);
	CreateDynamicObject(2960, 3142.1000976563, 1338.5999755859, 6.9000000953674, 0, 0, 0);
	CreateDynamicObject(2960, 3142.1000976563, 1338.9000244141, 6.5, 0, 0, 0);
	CreateDynamicObject(2960, 3142.1000976563, 1338.9000244141, 6.9000000953674, 0, 0, 0);
	CreateDynamicObject(3502, 3135.2998046875, 1340.5, 8, 0, 0, 268.99475097656);
	CreateDynamicObject(6959, 3163.6000976563, 1275.3000488281, 6.1999998092651, 0, 0, 0);
	CreateDynamicObject(6959, 3163.599609375, 1266.2998046875, 6.1999998092651, 0, 0, 0);
	CreateDynamicObject(6959, 3204.8994140625, 1315.2998046875, 6.1999998092651, 0, 0, 0);
	CreateDynamicObject(6959, 3246.1999511719, 1315.3000488281, 6.1999998092651, 0, 0, 0);
	CreateDynamicObject(6959, 3287.5, 1315.2998046875, 6.1999998092651, 0, 0, 0);
	CreateDynamicObject(6959, 3287.5, 1355.3000488281, 6.1999998092651, 0, 0, 0);
	CreateDynamicObject(6959, 3287.5, 1395.3000488281, 6.1999998092651, 0, 0, 0);
	CreateDynamicObject(6959, 3287.5, 1435.3000488281, 6.1999998092651, 0, 0, 0);
	CreateDynamicObject(6959, 3246.19921875, 1435.2998046875, 6.1999998092651, 0, 0, 0);
	CreateDynamicObject(6959, 3122.3999023438, 1475.3000488281, 6.1999998092651, 0, 0, 0);
	CreateDynamicObject(6959, 3163.6999511719, 1475.3000488281, 6.1999998092651, 0, 0, 0);
	CreateDynamicObject(6959, 3163.6999511719, 1475.3000488281, 6.1999998092651, 0, 0, 0);
	CreateDynamicObject(6959, 3204.8999023438, 1475.3000488281, 6.1999998092651, 0, 0, 0);
	CreateDynamicObject(6959, 3204.8999023438, 1435.3000488281, 6.1999998092651, 0, 0, 0);
	CreateDynamicObject(6959, 3246.1999511719, 1475.3000488281, 6.1999998092651, 0, 0, 0);
	CreateDynamicObject(6959, 3287.5, 1475.3000488281, 6.1999998092651, 0, 0, 0);
	CreateDynamicObject(5109, 3194.2998046875, 1189.5, -1.3999999761581, 0, 0, 271.99951171875);
	CreateDynamicObject(7089, 3190.7998046875, 1249, 12.60000038147, 0, 0, 0.2471923828125);
	CreateDynamicObject(7017, 3181.599609375, 1251.69921875, 7.0999999046326, 0, 0, 0.4998779296875);
	CreateDynamicObject(10794, 3231, 1112.5999755859, 3.7000000476837, 0, 0, 2.5);
	CreateDynamicObject(10795, 3228.8999023438, 1112.5999755859, 13.60000038147, 0, 0, 2.25);
	CreateDynamicObject(10793, 3155.8999023438, 1109.6999511719, 32.099998474121, 0, 0, 2);
	CreateDynamicObject(5184, 3309, 1200.5999755859, 25.10000038147, 0, 0, 94);
	CreateDynamicObject(5176, 3156.1000976563, 885.70001220703, 11.300000190735, 0, 0, 271.75);
	CreateDynamicObject(9956, 3349.69921875, 1364.2998046875, -12.199999809265, 0, 0, 269.99450683594);
	CreateDynamicObject(10827, 3317.1000976563, 1206.3000488281, -7.5999999046326, 0, 0, 93.746337890625);
	CreateDynamicObject(3578, 3054.1000976563, 1253.3000488281, 6.9000000953674, 0, 0, 0);
	CreateDynamicObject(3578, 3083.099609375, 1253.8994140625, 6.9000000953674, 0, 0, 0);
	CreateDynamicObject(3886, 3160.3999023438, 1034.0999755859, 0, 0, 0, 93);
	CreateDynamicObject(8311, 3205.7998046875, 1218.3994140625, 8.6999998092651, 0, 0, 5.4986572265625);
	CreateDynamicObject(8313, 3172.3994140625, 1219.7998046875, 8.5, 0, 0, 285.74890136719);
	CreateDynamicObject(8147, 3050.1000976563, 1182.0999755859, 9.3000001907349, 0, 0, 2.25);
	CreateDynamicObject(8165, 3127.6999511719, 1231.1999511719, 8.3000001907349, 0, 0, 50);
	CreateDynamicObject(8210, 3105.1999511719, 1255.5, 9.1000003814697, 0, 0, 0);
	CreateDynamicObject(8313, 3093.8999023438, 1246.5, 9.8000001907349, 0, 0, 64);
	CreateDynamicObject(6959, 3287.5, 1295.4000244141, -13.699999809265, 89.749755859375, 180, 180.25);
	CreateDynamicObject(6959, 3246.3000488281, 1295.3000488281, -13.699999809265, 89.747436523438, 179.99450683594, 179.74719238281);
	CreateDynamicObject(6959, 3204.8999023438, 1295.3000488281, -13.699999809265, 89.747436523438, 179.97814941406, 179.76354980469);
	CreateDynamicObject(6959, 3184.1999511719, 1274.8000488281, -13.699999809265, 89.747436523438, 179.97802734375, 270.00830078125);
	CreateDynamicObject(6959, 3203.1999511719, 1251.9000244141, -13.800000190735, 89.747436523438, 179.97253417969, 0.25552368164063);
	CreateDynamicObject(6959, 3184.1000976563, 1272.4000244141, -13.800000190735, 89.747314453125, 179.97253417969, 270.00549316406);
	CreateDynamicObject(7191, 2986.3000488281, 1414.4000244141, 18.200000762939, 0, 0, 92.74658203125);
	CreateDynamicObject(6959, 3081.1000976563, 1435.3000488281, 6.1999998092651, 0, 0, 0);
	CreateDynamicObject(6959, 3039.8000488281, 1435.3000488281, 6.1999998092651, 0, 0, 0);
	CreateDynamicObject(6959, 2998.5, 1435.1999511719, 6.1999998092651, 0, 0, 0);
	CreateDynamicObject(4058, 3050.7998046875, 1474.599609375, 26, 0, 0, 179.74731445313);
	CreateDynamicObject(4112, 3169.1000976563, 1490.5, 16.60000038147, 0, 0, 88.25);
	CreateDynamicObject(4114, 3292.6000976563, 1474.4000244141, 16.700000762939, 0, 0, 15);
	CreateDynamicObject(4117, 3255.8999023438, 1504.1999511719, 16.10000038147, 0, 358, 98.75);
	CreateDynamicObject(6959, 3307.8999023438, 1444, -13.89999961853, 89.747436523438, 179.97253417969, 270.00549316406);
	CreateDynamicObject(6959, 3307.8000488281, 1474.6999511719, -13.800000190735, 89.747314453125, 179.97253417969, 270.00549316406);
	CreateDynamicObject(6959, 3256.1999511719, 1395.3000488281, 6.1999998092651, 0, 0, 0);
	CreateDynamicObject(6959, 3008.6000976563, 1255.4000244141, -13.60000038147, 89.747314453125, 179.97802734375, 179.75830078125);
	CreateDynamicObject(3638, 3177, 1287.9000244141, 9.5, 0, 0, 0);
	CreateDynamicObject(3638, 3177, 1272.9000244141, 9.5, 0, 0, 0);
	CreateDynamicObject(10377, 3042.8999023438, 1338.8000488281, 24.200000762939, 0, 0, 0);
	CreateDynamicObject(10378, 3080.6000976563, 1338.5, 6.1999998092651, 0, 0, 0);
	CreateDynamicObject(16004, 3032.6000976563, 1428.5999755859, 8.8999996185303, 0, 0, 91);
	CreateDynamicObject(1280, 3089.8000488281, 1355, 6.5999999046326, 0, 0, 0);
	CreateDynamicObject(1280, 3089.8000488281, 1360.3000488281, 6.5999999046326, 0, 0, 0);
	CreateDynamicObject(1280, 3089.8000488281, 1364.9000244141, 6.5999999046326, 0, 0, 0);
	CreateDynamicObject(1280, 3071.3999023438, 1354.6999511719, 6.5999999046326, 0, 0, 180);
	CreateDynamicObject(1280, 3071.3999023438, 1361.6999511719, 6.5999999046326, 0, 0, 179.99450683594);
	CreateDynamicObject(1280, 3071.3999023438, 1366.6999511719, 6.5999999046326, 0, 0, 179.99450683594);
	CreateDynamicObject(1280, 3071.3000488281, 1310.3000488281, 6.5999999046326, 0, 0, 179.99450683594);
	CreateDynamicObject(1280, 3071.3999023438, 1316, 6.5999999046326, 0, 0, 179.99450683594);
	CreateDynamicObject(1280, 3071.5, 1320.4000244141, 6.5999999046326, 0, 0, 179.99450683594);
	CreateDynamicObject(1280, 3090, 1322, 6.5999999046326, 0, 0, 0);
	CreateDynamicObject(1280, 3090, 1316.0999755859, 6.5999999046326, 0, 0, 0);
	CreateDynamicObject(1280, 3089.8999023438, 1310.5999755859, 6.5999999046326, 0, 0, 0);
	CreateDynamicObject(955, 3070.1000976563, 1376.0999755859, 6.5999999046326, 0, 0, 90.5);
	CreateDynamicObject(617, 3068.3000488281, 1366.0999755859, 6.5, 0, 0, 0);
	CreateDynamicObject(617, 3061.5, 1360, 6.5, 0, 0, 0);
	CreateDynamicObject(617, 3060.3000488281, 1365.9000244141, 6.5, 0, 0, 0);
	CreateDynamicObject(617, 3092.8999023438, 1364.5999755859, 6.5, 0, 0, 0);
	CreateDynamicObject(617, 3097.6999511719, 1359, 6.5, 0, 0, 0);
	CreateDynamicObject(617, 3094.8999023438, 1356.1999511719, 6.5, 0, 0, 0);
	CreateDynamicObject(617, 3098.1999511719, 1312.8000488281, 6.5, 0, 0, 0);
	CreateDynamicObject(617, 3092.1000976563, 1315.5, 6.5, 0, 0, 0);
	CreateDynamicObject(617, 3095.5, 1319.5999755859, 6.5, 0, 0, 0);
	CreateDynamicObject(617, 3067.5, 1312.9000244141, 6.5, 0, 0, 0);
	CreateDynamicObject(617, 3059.6000976563, 1312.8000488281, 6.5, 0, 0, 0);
	CreateDynamicObject(617, 3062.5, 1320.3000488281, 6.5, 0, 0, 0);
	CreateDynamicObject(870, 3092, 1315.6999511719, 7.1999998092651, 0, 0, 0);
	CreateDynamicObject(870, 3095.3000488281, 1319.4000244141, 6.8000001907349, 0, 0, 0);
	CreateDynamicObject(870, 3098.1000976563, 1313.0999755859, 7, 0, 0, 0);
	CreateDynamicObject(870, 3068.1000976563, 1313.4000244141, 7.5999999046326, 0, 0, 0);
	CreateDynamicObject(870, 3063.1000976563, 1320.3000488281, 7.0999999046326, 0, 0, 0);
	CreateDynamicObject(870, 3060.5, 1313.3000488281, 6.8000001907349, 0, 0, 0);
	CreateDynamicObject(870, 3095.1000976563, 1355.9000244141, 7.0999999046326, 0, 0, 0);
	CreateDynamicObject(870, 3098.1000976563, 1358.5999755859, 6.6999998092651, 0, 0, 0);
	CreateDynamicObject(870, 3093.3000488281, 1364.3000488281, 6.8000001907349, 0, 0, 0);
	CreateDynamicObject(870, 3068.8999023438, 1366, 6.9000000953674, 0, 0, 0);
	CreateDynamicObject(870, 3062, 1360.0999755859, 6.8000001907349, 0, 0, 0);
	CreateDynamicObject(870, 3061.6999511719, 1365.4000244141, 6.6999998092651, 0, 0, 0);
	CreateDynamicObject(14819, 3078.3000488281, 1262.5999755859, 7.5, 0, 0, 87.25);
	CreateDynamicObject(14819, 3078.3999023438, 1264.0999755859, 7.5, 0, 0, 87.247924804688);
	CreateDynamicObject(10827, 3418.6999511719, 1203.6999511719, 21, 0, 0, 273.74633789063);
	CreateDynamicObject(14819, 3081.6999511719, 1397.6999511719, 7.4000000953674, 0, 0, 0);
	CreateDynamicObject(8670, 3136.3000488281, 1395.5999755859, 12, 0, 0, 0);
	CreateDynamicObject(3029, 3143.1999511719, 1393.8000488281, 6.0999999046326, 0, 0, 0);
	CreateDynamicObject(3029, 3143.1000976563, 1397.3000488281, 6.0999999046326, 0, 0, 180.75);
	CreateDynamicObject(5463, 2994.1999511719, 1432.4000244141, 30.39999961853, 0, 0, 1.5);
	CreateDynamicObject(7191, 2986.3000488281, 1414.4000244141, 8.1000003814697, 0, 0, 92.74658203125);
	CreateDynamicObject(7191, 2986.3000488281, 1414.4000244141, 11.800000190735, 0, 0, 92.74658203125);
	CreateDynamicObject(7191, 2986.3000488281, 1414.4000244141, 15.39999961853, 0, 0, 92.74658203125);
	CreateDynamicObject(16067, 3079, 1425, 6.1999998092651, 0, 0, 179.98889160156);
	CreateDynamicObject(16067, 3054.5, 1443, 6.1999998092651, 0, 0, 0.4888916015625);
	CreateDynamicObject(16067, 3051.6000976563, 1425, 6.1999998092651, 0, 0, 179.98352050781);
	CreateDynamicObject(3941, 3019.6999511719, 1433.8000488281, 9.3000001907349, 0, 0, 0);
	

	CreateDynamicObject(8399,2014.311,991.653,14.661,0.0,0.0,-90.000); /*드카앞 나이트클럽*/
	CreateDynamicObject(3472,2037.512,986.682,7.189,0.0,0.0,38.675);
	CreateDynamicObject(3472,2037.286,997.045,6.939,0.0,0.0,-120.321);
	CreateDynamicObject(3472,2037.407,986.683,4.832,0.0,0.0,0.0);
	CreateDynamicObject(3472,2037.108,997.147,4.088,0.0,0.0,-30.940);
	CreateDynamicObject(3461,2035.254,989.783,11.395,0.0,0.0,0.0);
	CreateDynamicObject(3461,2035.296,992.917,11.395,0.0,0.0,0.0);
	a = CreatePickup(1318,1,2033.664,991.230,11.217);
	CreateDynamicObject(18018,1308.056,-28.525,1339.054,0.0,0.0,0.0);
	CreateDynamicObject(16152,1316.005,-17.455,1341.488,0.0,0.0,-90.000);
	CreateDynamicObject(16152,1316.246,-21.393,1341.488,0.0,0.0,-90.000);
	CreateDynamicObject(16151,1298.691,-25.959,1339.454,0.0,0.0,-180.000);
	CreateDynamicObject(14565,1296.771,-25.350,1343.215,0.0,0.0,0.0);
	CreateDynamicObject(1836,1294.447,-40.873,1339.060,0.0,0.0,90.000);
	CreateDynamicObject(1836,1294.442,-37.688,1339.052,0.0,0.0,90.000);
	CreateDynamicObject(1978,1299.222,-38.776,1340.113,0.0,0.0,-180.000);
	CreateDynamicObject(1979,1299.434,-40.131,1340.111,0.0,0.0,0.0);
	CreateDynamicObject(2229,1319.408,-38.391,1340.460,0.0,0.0,-146.250);
	CreateDynamicObject(2229,1308.154,-38.391,1340.460,0.0,0.0,-191.250);
	CreateDynamicObject(2232,1319.077,-38.294,1341.083,0.0,0.0,-146.250);
	CreateDynamicObject(2232,1309.608,-38.440,1341.058,0.0,0.0,-191.250);
	CreateDynamicObject(2780,1314.015,-30.861,1333.208,0.0,0.0,0.0);
	CreateDynamicObject(2780,1314.114,-39.588,1334.323,0.0,0.0,0.0);
	CreateDynamicObject(18102,1317.494,-41.948,1341.006,95.397,0.0,0.0);
	CreateDynamicObject(18102,1318.267,-27.925,1345.006,0.0,0.0,0.0);
	CreateDynamicObject(18102,1323.957,-25.100,1341.013,93.679,0.0,90.000);
	CreateDynamicObject(14391,1314.504,-40.073,1341.471,0.0,0.0,-450.000);
	CreateDynamicObject(14608,1321.573,-31.333,1340.690,0.0,0.0,45.000);
	b = CreatePickup(1318,1,1307.935,-18.220,1340.253);
	
	CreateDynamicObject(900,4059.467,-1696.361,-1.837,0.0,0.0,-52.348);    /*무인도*/
	CreateDynamicObject(900,4057.223,-1673.102,-2.092,6.016,0.0,146.250);
	CreateDynamicObject(900,4074.688,-1690.744,-1.443,0.0,0.0,-52.348);
	CreateDynamicObject(17026,4040.213,-1678.906,-6.432,0.0,0.0,-45.000);
	CreateDynamicObject(17029,4078.617,-1704.536,-8.184,0.0,0.0,40.394);
	CreateDynamicObject(10166,4005.864,-1743.187,-4.175,-1.719,-9.454,15.702);
	CreateDynamicObject(619,4074.485,-1689.440,3.204,0.0,0.0,270.000);
	CreateDynamicObject(619,4053.274,-1674.522,2.103,0.0,0.0,56.250);
	CreateDynamicObject(9831,4083.411,-1678.976,-1.709,0.0,0.0,8.826);
	CreateDynamicObject(3524,4066.698,-1682.718,1.103,-59.301,0.0,90.000);

	CreateDynamicObject(972,1991.109,1013.633,37.938,0.0,0.0,-180.000);    /*범퍼카*/
	CreateDynamicObject(972,2002.603,1020.603,38.013,0.0,0.0,-270.000);
	CreateDynamicObject(972,1991.084,1005.913,37.988,0.0,0.0,-180.000);
	CreateDynamicObject(972,2009.484,1020.626,38.088,0.0,0.0,90.000);
	CreateDynamicObject(972,2016.489,1009.298,38.088,0.0,0.0,0.0);
	CreateDynamicObject(972,2016.575,1001.360,38.088,0.0,0.0,0.0);
	door1 = CreateObject(972,1988.710,994.829,37.988,0.0,0.0,-90.000);
	door2 = CreateObject(972,2005.242,994.824,38.088,0.0,0.0,-90.000);
	CreateDynamicObject(10281,2017.293,1007.682,39.580,0.0,0.0,-87.422);
	CreateDynamicObject(16644,2001.527,994.020,37.926,0.0,0.0,90.000);
	CreateDynamicObject(16644,2004.086,994.118,37.870,0.0,0.0,90.000);
	elb = CreateObject(5837,2003.155,984.601,11.559,0.0,0.0,0.0);
	
	
	CreateDynamicObject(18367, 101.498, 2487.1171, 14.6913, 353.9838, 355.7027, 289.5262); /*롤러코스터*/
	CreateDynamicObject(18367, 74.5042, 2477.5815, 20.891, 351.4056, 0.0, 247.4998);
	CreateDynamicObject(13648, 29.8621, 2496.8757, 28.3699, 0.0, 0.0, 65.8584);
	CreateDynamicObject(18367, 12.9824, 2504.487, 29.5581, 331.6386, 359.1405, 244.9217);
	CreateDynamicObject(18262, -14.3645, 2517.1345, 47.7484, 10.3131, 0.0, 67.5);
	CreateDynamicObject(18367, -15.6926, 2517.9318, 47.5087, 336.7951, 354.8434, 161.7971);
	CreateDynamicObject(16303, 2.7773, 2543.8693, 62.1866, 358.281, 338.514, 2.5782);
	CreateDynamicObject(13638, 18.9401, 2533.552, 76.9591, 0.0, 0.0, 168.75);
	CreateDynamicObject(13638, 12.4469, 2535.0356, 84.9582, 0.0, 0.0, 348.75);
	CreateDynamicObject(8375, 16.6378, 2552.9113, 88.5607, 0.0, 0.0, 78.75);
	CreateDynamicObject(18367, 10.71, 2539.6069, 90.0921, 6.016, 0.0, 168.75);
	CreateDynamicObject(18367, 22.1791, 2540.2749, 88.8768, 357.4216, 0.0, 78.75);
	CreateDynamicObject(18367, 25.6188, 2549.4401, 88.3541, 355.7027, 0.0, 78.75);
	CreateDynamicObject(18367, 28.5513, 2558.8793, 87.887, 351.4056, 1.7188, 89.1405);
	CreateDynamicObject(18367, 50.1809, 2534.9382, 93.334, 0.0, 0.0, 11.25);
	CreateDynamicObject(18367, 55.5548, 2507.3149, 96.36, 0.0, 0.0, 315.0);
	CreateDynamicObject(13645, 33.4036, 2485.0266, 100.6535, 9.4538, 0.8593, 137.5783);
	CreateDynamicObject(13639, 27.8424, 2479.5273, 100.4081, 0.0, 0.0, 315.0);
	CreateDynamicObject(5152, 28.4386, 2479.6123, 100.6262, 0.0, 10.3131, 33.0368);
	CreateDynamicObject(18367, 0.0784, 2458.736, 113.758, 31.7992, 359.1405, 123.75);
	CreateDynamicObject(18367, 0.6557, 2459.3647, 113.3279, 333.3575, 357.4216, 328.8283);
	CreateDynamicObject(18367, -19.4536, 2420.8107, 149.3801, 52.4255, 0.0, 157.5);
	CreateDynamicObject(18367, -19.1985, 2422.4526, 147.5296, 0.0, 0.0, 0.0);
	CreateDynamicObject(1634, -20.022, 2394.5063, 151.3721, 0.0, 0.0, 168.7498);
	CreateDynamicObject(5152, 59.0045, 2558.8366, 96.6795, 0.0, 0.0, 7.8122);
	CreateDynamicObject(6052, 71.409, 2562.0756, 99.7427, 0.0, 0.0, 67.5);
	CreateDynamicObject(16401, 85.7713, 2570.8522, 102.0902, 0.0, 0.0, 56.25);
	CreateDynamicObject(13604, 88.7928, 2574.5617, 105.2947, 0.0, 0.0, 326.25);
	CreateDynamicObject(16084, 103.4206, 2595.2045, 98.8367, 0.0, 0.0, 78.75);
	CreateDynamicObject(18367, 111.2031, 2611.3718, 106.1039, 326.4819, 2.5782, 161.7971);
	CreateDynamicObject(18367, 115.8793, 2632.341, 124.0266, 336.7951, 354.8434, 125.546);
	CreateDynamicObject(18451, 141.2031, 2649.7194, 139.8569, 0.0, 306.7149, 297.915);
	CreateDynamicObject(18367, 54.0425, 2543.853, 93.5394, 348.8273, 351.4056, 67.5);
	CreateDynamicObject(13648, 90.7429, 2516.7312, 100.7007, 0.0, 0.0, 33.75);
	CreateDynamicObject(13604, 106.8581, 2489.7934, 103.3047, 0.0, 0.0, 22.5);
	CreateDynamicObject(13590, 106.5206, 2486.8444, 102.0525, 0.0, 0.0, 202.5);
	CreateDynamicObject(18262, 117.3862, 2463.8737, 103.8847, 343.6706, 0.0, 281.25);
	CreateDynamicObject(18367, 125.0743, 2440.1748, 109.6435, 24.9237, 3.4377, 180.0);
	CreateDynamicObject(18367, 124.951, 2441.8237, 108.9599, 334.2168, 357.4216, 1.7188);
	CreateDynamicObject(18367, 125.6356, 2416.582, 124.9629, 0.0, 0.0, 326.25);
	CreateDynamicObject(18367, 110.7771, 2393.5512, 127.844, 334.2168, 0.0, 0.0);
	CreateDynamicObject(18367, 110.6802, 2368.6687, 143.1838, 351.4056, 23.2047, 78.75);
	CreateDynamicObject(13638, 134.9523, 2358.414, 149.9441, 0.0, 0.0, 168.75);
	CreateDynamicObject(16401, 130.6184, 2349.1152, 155.427, 0.0, 0.0, 202.5);
	CreateDynamicObject(6052, 125.7338, 2338.6105, 160.0466, 353.1245, 0.0, 303.75);
	CreateDynamicObject(6052, 133.4326, 2325.5485, 166.1067, 353.1245, 0.0, 45.0);
	CreateDynamicObject(8500, 203.9738, 2266.7944, 176.5912, 0.0, 0.0, 270.0);
	CreateDynamicObject(4007, 332.4341, 2199.9316, 62.193, 0.0, 0.0, 11.25);
	CreateDynamicObject(18367, 283.6952, 2223.8339, 163.9436, 325.6224, 0.0, 78.75);
	CreateDynamicObject(18367, 306.0656, 2219.4113, 182.7607, 0.0, 0.0, 326.25);
	CreateDynamicObject(18367, 289.2826, 2194.1069, 186.2399, 38.6747, 358.281, 314.1405);
	CreateDynamicObject(18367, 270.0752, 2176.9152, 170.8785, 37.8152, 0.0, 22.5);
	CreateDynamicObject(18367, 279.1339, 2154.3164, 156.2418, 0.0, 0.0, 135.0);
	CreateDynamicObject(13648, 312.9405, 2188.2612, 158.2899, 358.281, 0.0, 135.0);
	

	CreateDynamicObject(18450,2937.069,-2063.186,1.463,0.0,0.0,0.0);           /*신도시*/
	CreateDynamicObject(18450,3009.740,-2063.045,1.436,0.0,0.0,0.0); // object (1)
	CreateDynamicObject(18450,3084.840,-2063.038,1.429,0.0,0.0,0.0); // object (2)
	CreateDynamicObject(18450,3158.971,-2063.021,1.428,0.0,0.0,0.0); // object (3)
	CreateDynamicObject(4142,3246.941,-2033.139,1.780,0.0,0.0,0.0); // object (9)
	CreateDynamicObject(4142,3236.947,-2122.679,1.832,0.0,0.0,-90.000); // object (15)
	CreateDynamicObject(3241,3253.043,-2050.572,2.091,0.0,0.0,90.000); // object (17)
	CreateDynamicObject(13132,3223.808,-2097.472,4.902,0.0,0.0,-90.000); // object (20)
	CreateDynamicObject(5177,3244.416,-2117.980,6.037,0.0,0.0,-270.000); // object (23)
	CreateDynamicObject(18282,3186.758,-2085.206,2.050,0.0,0.0,90.000); // object (26)
	CreateDynamicObject(3994,3257.212,-2181.866,1.838,0.0,0.0,180.000); // object (29)
	CreateDynamicObject(4647,3326.951,-2173.497,1.878,0.0,0.0,-180.000); // object (33)
	CreateDynamicObject(3776,3226.513,-2122.651,10.363,0.0,0.0,-180.000); // object (35)
	CreateDynamicObject(18282,3185.093,-2153.792,1.959,0.0,0.0,90.000); // object (37)
	CreateDynamicObject(6404,3247.844,-2158.135,9.019,0.0,0.0,0.0); // object (39)
	CreateDynamicObject(16002,3216.788,-2073.626,4.571,0.0,0.0,90.000); // object (56)
	CreateDynamicObject(17457,3222.000,-2137.773,5.008,0.0,0.0,90.000); // object (67)
	CreateDynamicObject(18265,3188.550,-2118.313,2.953,0.0,0.0,-180.000); // object (70)
	CreateDynamicObject(3988,3242.307,-2206.606,10.102,0.0,0.0,-90.000); // object (72)
	CreateDynamicObject(4647,3199.735,-1983.347,1.772,0.0,0.0,-90.000); // object (74)
	CreateDynamicObject(5177,3201.583,-1996.995,-1.643,0.0,0.0,-270.000); // object (75)
	CreateDynamicObject(18242,3272.508,-2095.573,1.567,0.0,0.0,270.000); // object (77)
	CreateDynamicObject(4647,3318.428,-2082.692,1.818,0.0,0.0,-90.000); // object (78)
	CreateDynamicObject(4647,3314.982,-2063.122,1.901,0.0,0.0,-270.000); // object (82)
	CreateDynamicObject(8064,3297.206,-2107.859,4.775,0.0,0.0,0.0); // object (84)
	CreateDynamicObject(4647,3326.867,-2152.962,1.619,0.0,0.0,-180.000); // object (85)
	CreateDynamicObject(8260,3305.242,-2148.076,4.995,0.0,0.0,0.0); // object (86)
	CreateDynamicObject(8300,3303.066,-2206.543,4.589,0.0,0.0,-270.000); // object (87)
	CreateDynamicObject(8546,3283.411,-2158.908,-1.662,0.0,0.0,90.000); // object (88)
	CreateDynamicObject(8546,3283.372,-2119.328,-1.685,0.0,0.0,90.000); // object (89)
	CreateDynamicObject(8546,3251.229,-2123.587,-1.515,0.0,0.0,90.000); // object (90)
	CreateDynamicObject(8546,3267.302,-2101.616,-1.668,0.0,0.0,90.000); // object (91)
	CreateDynamicObject(8546,3239.561,-2136.819,-1.547,0.0,0.0,90.000); // object (92)
	CreateDynamicObject(9243,3345.814,-2115.307,6.551,0.0,0.0,0.0); // object (93)
	CreateDynamicObject(10843,3282.913,-2040.135,9.656,0.0,0.0,-90.000); // object (96)
	CreateDynamicObject(10844,3341.671,-2045.461,4.606,0.0,0.0,0.0); // object (97)
	CreateDynamicObject(8546,3291.373,-2170.815,-1.870,0.0,0.0,90.000); // object (98)
	CreateDynamicObject(10843,3309.217,-2042.702,7.751,0.0,0.0,-90.000); // object (99)
	CreateDynamicObject(4647,3318.936,-1983.129,1.810,0.0,0.0,-90.000); // object (100)
	CreateDynamicObject(3707,3282.465,-2007.797,9.446,0.0,0.0,90.000); // object (101)
	CreateDynamicObject(4142,3416.118,-2023.144,1.822,0.0,0.0,270.000); // object (110)
	CreateDynamicObject(3304,3228.852,-2041.016,4.805,0.0,0.0,-90.000); // object (111)
	CreateDynamicObject(3305,3229.288,-2004.066,4.826,0.0,0.0,0.0); // object (112)
	CreateDynamicObject(3306,3185.632,-2041.946,3.063,0.0,0.0,0.0); // object (113)
	CreateDynamicObject(3306,3185.214,-2003.822,3.228,0.0,0.0,0.0); // object (114)
	CreateDynamicObject(8546,3232.975,-2023.628,-1.678,0.0,0.0,90.000); // object (115)
	CreateDynamicObject(8546,3258.302,-2040.230,-1.698,0.0,0.0,90.000); // object (116)
	CreateDynamicObject(8546,3232.885,-2000.541,-1.720,0.0,0.0,90.000); // object (117)
	CreateDynamicObject(3242,3246.970,-1994.953,3.690,0.0,0.0,-180.000); // object (119)
	CreateDynamicObject(3305,3205.084,-1964.049,4.798,0.0,0.0,90.000); // object (123)
	CreateDynamicObject(3305,3180.498,-1964.045,4.810,0.0,0.0,90.000); // object (124)
	CreateDynamicObject(3311,3185.117,-2179.100,4.701,0.0,0.0,-270.000); // object (126)
	CreateDynamicObject(8390,3073.250,-1982.981,21.098,0.0,0.0,-90.000); // object (128)
	CreateDynamicObject(18450,2963.902,-1980.994,1.438,0.0,0.0,0.0); // object (129)
	CreateDynamicObject(18450,2917.307,-1981.104,1.437,0.0,0.0,0.0); // object (130)
	CreateDynamicObject(4018,3250.711,-1971.325,1.448,0.0,0.0,0.0); // object (131)
	CreateDynamicObject(4048,3286.426,-1966.978,13.427,0.0,0.0,0.0); // object (132)
	CreateDynamicObject(4058,3391.149,-1954.006,21.805,0.0,0.0,180.000); // object (133)
	CreateDynamicObject(3776,3326.735,-1965.075,9.806,0.0,0.0,270.000); // object (134)
	CreateDynamicObject(3776,3326.666,-2002.459,10.023,0.0,0.0,90.000); // object (135)
	CreateDynamicObject(5310,3361.367,-2023.298,7.381,0.0,0.0,90.000); // object (136)
	CreateDynamicObject(6404,3414.462,-2024.408,9.213,0.0,0.0,-90.000); // object (137)
	CreateDynamicObject(3306,3156.417,-1963.365,3.263,0.0,0.0,-90.000); // object (139)
	CreateDynamicObject(3306,3155.068,-2003.753,3.122,0.0,0.0,-270.000); // object (140)
	CreateDynamicObject(3996,3386.108,-2093.184,1.748,0.0,0.0,90.000); // object (141)
	CreateDynamicObject(3996,3463.860,-1991.484,1.953,0.0,0.0,90.000); // object (143)
	CreateDynamicObject(3776,3441.930,-2001.987,10.468,0.0,0.0,90.000); // object (145)
	CreateDynamicObject(3776,3444.374,-2031.903,9.470,0.0,0.0,0.0); // object (146)
	CreateDynamicObject(3996,3463.652,-2092.508,1.753,0.0,0.0,90.000); // object (147)
	CreateDynamicObject(3996,3428.657,-2083.033,1.543,0.0,0.0,-0.859); // object (148)
	CreateDynamicObject(17021,3414.854,-2059.568,9.436,0.0,0.0,-90.000); // object (149)
	CreateDynamicObject(1677,3441.313,-2059.818,5.299,0.0,0.0,-270.000); // object (150)
	CreateDynamicObject(8546,3246.608,-2131.961,0.607,0.0,0.0,90.000); // object (152)
	CreateDynamicObject(8546,3266.723,-2124.906,0.707,0.0,0.0,90.000); // object (153)
	CreateDynamicObject(8546,3278.362,-2146.675,0.630,0.0,0.0,90.000); // object (154)
	CreateDynamicObject(17021,3363.957,-2112.028,9.046,0.0,0.0,0.0); // object (155)
	CreateDynamicObject(3313,3486.101,-2082.278,4.591,0.0,0.0,-450.000); // object (160)
	CreateDynamicObject(3314,3412.438,-2098.976,2.678,0.0,0.0,-90.000); // object (161)
	CreateDynamicObject(3314,3447.005,-2109.852,2.945,0.0,0.0,-180.000); // object (162)
	CreateDynamicObject(3444,3486.597,-2107.744,4.199,0.0,0.0,0.0); // object (163)
	CreateDynamicObject(3446,3408.962,-2124.429,5.268,0.0,0.0,-90.000); // object (164)
	CreateDynamicObject(3996,3424.779,-2149.567,1.569,0.0,0.0,0.859); // object (168)
	CreateDynamicObject(3449,3486.972,-2132.400,3.769,0.0,0.0,-360.000); // object (170)
	CreateDynamicObject(3555,3449.012,-2133.706,4.175,0.0,0.0,0.0); // object (172)
	CreateDynamicObject(3556,3399.172,-2137.276,4.135,0.0,0.0,-270.000); // object (174)
	CreateDynamicObject(3558,3412.493,-2138.654,4.530,0.0,0.0,180.000); // object (175)
	CreateDynamicObject(3580,3438.058,-2135.583,5.463,0.0,0.0,-180.000); // object (176)
	CreateDynamicObject(3580,3428.886,-2135.418,5.717,0.0,0.0,-180.000); // object (177)
	CreateDynamicObject(8546,3334.536,-2012.544,-1.536,0.0,0.0,90.000); // object (178)
	CreateDynamicObject(8546,3316.260,-2034.250,-1.345,0.0,0.0,0.0); // object (179)
	CreateDynamicObject(8546,3329.292,-2035.648,-1.611,0.0,0.0,0.0); // object (180)
	CreateDynamicObject(13132,3191.344,-2025.160,4.908,0.0,0.0,-180.000); // object (183)
	CreateDynamicObject(3313,3485.730,-2057.443,4.687,0.0,0.0,-450.000); // object (184)
	CreateDynamicObject(3313,3485.648,-2032.688,4.864,0.0,0.0,-450.000); // object (185)
	CreateDynamicObject(3313,3485.698,-2007.862,4.857,0.0,0.0,-450.000); // object (186)
	CreateDynamicObject(3988,3351.476,-2182.496,10.444,0.0,0.0,0.0); // object (187)
	CreateDynamicObject(16146,3368.978,-2142.000,4.810,0.0,0.0,-180.000); // object (189)
	CreateDynamicObject(17523,3484.550,-2152.906,3.678,0.0,0.0,-0.705); // object (190)
	CreateDynamicObject(6987,3419.223,-2193.893,1.577,0.0,0.0,-180.000); // object (192)
	CreateDynamicObject(17523,3364.527,-2153.657,2.886,0.0,0.0,-360.782); // object (193)
	CreateDynamicObject(1677,3416.078,-2126.861,-1.965,0.0,0.0,-270.000); // object (194)
	CreateDynamicObject(3313,3485.975,-1982.865,4.890,0.0,0.0,-450.000); // object (195)
	CreateDynamicObject(3313,3486.011,-1958.111,4.880,0.0,0.0,-450.000); // object (196)
	CreateDynamicObject(3313,3468.058,-1946.613,4.800,0.0,0.0,-720.000); // object (197)
	
	
	CreateDynamicObject(18450,5049.383,-1056.526,186.292,0.0,-34.377,-180.000); 	/* 오토바이 슛 */
	CreateDynamicObject(18450,4976.592,-1056.505,208.797,0.0,0.0,0.0); // object (25)
	CreateDynamicObject(6928,5272.225,-1061.341,25.134,0.0,0.0,0.0); // object (27)
	CreateDynamicObject(1655,5081.395,-1056.451,166.109,-30.080,0.0,-90.000); // object (28)
	CreateDynamicObject(1655,5088.370,-1056.426,166.441,-12.892,0.0,-90.000); // object (29)
	CreateDynamicObject(1655,5094.121,-1056.404,168.323,3.438,0.0,-90.000); // object (30)
	CreateDynamicObject(18450,4976.812,-1041.105,209.208,0.0,0.0,0.0); // object (34)
	CreateDynamicObject(902,5013.096,-1057.001,209.823,0.0,0.0,0.0); // object (35)
	

	CreateDynamicObject(10023, 2043.693481, 909.755676, 75.250168, 0.0000, 0.0000, 270.0000);   /*신전*/
	CreateDynamicObject(10023, 1943.060791, 909.791931, 75.414474, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(8397, 1991.771973, 908.958313, 77.613205, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(14637, 1931.648193, 909.654480, 68.959427, 0.0000, 0.0000, 180.0000);
	CreateDynamicObject(14637, 2055.122314, 909.777466, 68.785301, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(14562, 1976.331055, 909.121704, 68.378883, 0.0000, 0.0000, 180.0000);
	CreateDynamicObject(14562, 2011.241455, 909.723267, 68.378883, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(3528, 2056.344238, 909.072815, 73.336754, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(3528, 1931.067505, 909.804382, 72.062614, 0.0000, 0.0000, 180.0000);
	CreateDynamicObject(9833, 2001.986816, 915.618347, 70.312332, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(9833, 1997.518311, 919.856873, 70.312332, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(9833, 1991.176636, 920.046814, 70.312332, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(9833, 1984.352051, 919.715698, 70.312332, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(9833, 1980.653198, 915.325439, 70.312332, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(9833, 1981.077026, 902.116150, 70.312332, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(9833, 1985.611816, 897.583008, 70.312332, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(9833, 1992.449707, 897.163513, 70.312332, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(9833, 1999.845459, 897.313171, 70.312332, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(9833, 2002.796021, 901.627258, 70.312332, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(14608, 1992.952637, 908.924744, 69.380798, 0.0000, 0.0000, 225.0000);
	CreateDynamicObject(14608, 1988.862549, 909.134277, 69.380798, 0.0000, 0.0000, 45.0000);
	CreateDynamicObject(3877, 1939.464844, 903.900024, 68.775528, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(3877, 1943.352539, 903.935425, 68.775528, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(3877, 1939.353638, 915.525757, 68.775528, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(3877, 1943.339600, 915.696716, 68.775528, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(8378, 1985.074219, 874.535217, 76.944473, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(8378, 2000.718140, 945.105591, 77.214874, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(8378, 2001.072388, 874.453979, 76.828949, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(8378, 1985.979980, 945.139771, 76.823166, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(3525, 2048.791260, 917.519714, 75.525932, 0.0000, 0.0000, 281.2500);
	CreateDynamicObject(3525, 2048.967773, 901.472656, 75.337013, 0.0000, 0.0000, 281.2500);
	CreateDynamicObject(3525, 1937.689697, 901.964783, 75.559845, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(3525, 1937.712402, 917.928162, 75.906265, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(2631, 1982.010498, 910.124329, 67.156113, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(2631, 1982.037109, 908.195679, 67.156113, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(2632, 2000.864624, 907.683228, 67.156113, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(2632, 2000.855713, 909.617737, 67.156113, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(2773, 1998.393921, 906.727783, 67.627014, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(2773, 1998.463135, 911.217834, 67.627014, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(2773, 1998.429321, 908.992004, 67.627014, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(2773, 1984.701538, 911.250305, 67.627014, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(2773, 1984.657104, 906.689575, 67.627014, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(2773, 1984.680542, 908.954102, 67.627014, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1491, 2054.672607, 907.930481, 66.933594, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(1491, 2054.600342, 910.901611, 66.933594, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(17951, 2054.699707, 913.988403, 68.722389, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(17951, 2054.686279, 904.913147, 68.722389, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(17951, 2054.763184, 909.234619, 71.095871, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(17951, 2054.710449, 913.432190, 71.104317, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(17951, 2054.659180, 904.930176, 71.051224, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1736, 2055.009033, 909.413757, 68.758675, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(17951, 1932.121338, 914.133179, 68.886696, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1491, 1932.126587, 909.533081, 67.097900, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(1491, 1932.128418, 908.020874, 67.097900, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(17951, 1932.092773, 905.010681, 68.886696, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(17951, 1932.093506, 909.606812, 71.281334, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(17951, 1932.099243, 912.440369, 71.256149, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(17951, 1932.050781, 906.434753, 71.302887, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1736, 1931.768188, 909.571350, 68.458878, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(3877, 2047.373779, 903.933472, 68.611221, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(3877, 2043.347290, 903.865234, 68.611221, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(3877, 2047.370728, 915.494019, 68.611221, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(3877, 2043.187134, 915.585815, 68.611221, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(3877, 1943.588745, 921.936768, 68.775528, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(3877, 1943.583130, 927.447632, 68.775528, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(3877, 1943.312622, 933.222656, 68.775528, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(3877, 1950.484497, 934.290955, 68.775528, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(3877, 1958.215698, 934.536743, 68.781311, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(3877, 1966.398071, 934.301392, 68.775528, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(3877, 1973.235229, 934.173340, 68.775528, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(3877, 1980.040161, 934.143311, 68.775528, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(3877, 1987.100952, 934.153320, 68.775528, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(3877, 1995.882690, 934.173401, 68.775528, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(3877, 2003.755371, 934.173035, 68.775528, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(3877, 2012.562988, 934.144226, 68.775528, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(3877, 2021.569702, 934.199402, 68.617004, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(3877, 2031.477661, 933.994629, 68.617004, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(3877, 2042.025391, 934.043884, 68.611221, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(3877, 2043.128296, 928.201416, 68.611221, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(3877, 2043.156860, 921.681824, 68.611221, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(3877, 2043.332642, 895.760620, 68.611221, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(3877, 2043.379395, 887.428711, 68.611221, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(3877, 2036.865967, 885.134277, 68.611221, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(3877, 2029.051270, 885.136230, 68.617004, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(3877, 2020.637817, 885.153320, 68.611221, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(3877, 2011.656006, 885.206238, 68.775528, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(3877, 2001.170288, 885.391785, 68.775528, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(3877, 1991.734375, 885.318909, 68.781311, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(3877, 1980.457520, 885.393372, 68.781311, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(3877, 1969.188354, 885.229614, 68.781311, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(3877, 1959.702637, 885.417297, 68.781311, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(3877, 1950.055664, 885.478149, 68.775528, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(3877, 1943.539307, 887.220764, 68.775528, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(3877, 1943.416382, 892.717224, 68.775528, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(3877, 1943.538208, 898.739014, 68.775528, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1215, 1987.365479, 911.816345, 67.674110, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1215, 1987.409912, 908.956909, 67.674110, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1215, 1987.379028, 906.242737, 67.674110, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1215, 1994.111084, 906.095947, 67.674110, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1215, 1994.174194, 908.810364, 67.674110, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1215, 1994.466919, 911.578125, 67.674110, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(625, 2035.794067, 905.828247, 68.001190, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(625, 2031.568970, 905.644653, 68.001190, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(625, 2027.338135, 905.663391, 68.001190, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(625, 2023.052612, 905.606689, 68.001190, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(625, 2018.824707, 905.475098, 68.001190, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(625, 2035.855957, 914.077087, 68.001190, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(625, 2031.397461, 914.000732, 68.001190, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(625, 2027.073242, 913.928345, 68.001190, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(625, 2022.864014, 914.003845, 68.001190, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(625, 2018.838989, 913.981201, 68.001190, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(625, 1954.963867, 906.433167, 68.165497, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(625, 1959.708130, 906.442383, 68.165497, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(625, 1964.542603, 906.478027, 68.165497, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(625, 1969.040649, 906.583740, 68.165497, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(625, 1973.776855, 906.652222, 68.165497, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(625, 1954.992432, 913.934814, 68.165497, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(625, 1959.833984, 913.999878, 68.165497, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(625, 1964.347046, 913.986328, 68.165497, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(625, 1968.910156, 913.909180, 68.165497, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(625, 1973.566528, 914.117981, 68.165497, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1212, 1983.607422, 909.216675, 67.235474, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1212, 1999.223755, 908.587036, 67.235474, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1215, 1955.609985, 913.084534, 67.674110, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1215, 1960.124634, 913.097473, 67.674110, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1215, 1965.097290, 913.059509, 67.674110, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1215, 1970.140747, 913.109314, 67.674110, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1215, 1955.683838, 907.273254, 67.674110, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1215, 1959.984985, 907.439575, 67.674110, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1215, 1965.244995, 907.583374, 67.674110, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1215, 1970.433228, 907.570984, 67.674110, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1215, 2031.855591, 906.718811, 67.509804, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1215, 2027.739502, 906.744568, 67.509804, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1215, 2023.360596, 906.609070, 67.509804, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1215, 2018.859985, 906.511353, 67.509804, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1215, 2031.794312, 912.796021, 67.509804, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1215, 2027.234253, 912.715210, 67.509804, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1215, 2023.041748, 912.796082, 67.509804, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(1215, 2019.195190, 912.744141, 67.509804, 0.0000, 0.0000, 0.0000);
	A = CreateObject(5837, 2082.492920, 908.827332, 8.760883, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(1698, 2078.022705, 910.177917, 66.177704, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(1698, 2074.836914, 910.150635, 66.179306, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(1698, 2071.557861, 910.160828, 66.182465, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(1698, 2068.177979, 910.196045, 66.195694, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(1698, 2064.919434, 910.193787, 66.210678, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(1698, 2061.673828, 910.241577, 66.241478, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(1698, 2058.306152, 910.241577, 66.230370, 0.0000, 0.0000, 270.0000);
	

	CreateObject(8838, -823.2002, 5743.5019, 12.4879, 0.0, 0.0, 0.0, 0);        /*제라레이싱*/
	CreateObject(3458, -823.4844, 5748.5429, 12.49, 0.0, 0.0, 0.0, 0);
	CreateObject(8838, -823.7678, 5753.5839, 12.4921, 0.0, 0.0, 0.0, 0);
	CreateObject(3458, -824.0511, 5758.625, 12.4943, 0.0, 0.0, 0.0, 0);
	CreateObject(8838, -824.3345, 5763.666, 12.4964, 0.0, 0.0, 0.0, 0);
	CreateObject(3458, -824.6172, 5768.707, 12.4985, 0.0, 0.0, 0.0, 0);
	CreateObject(8838, -824.9013, 5773.748, 12.5006, 0.0, 0.0, 0.0, 0);
	CreateObject(3458, -825.1846, 5778.789, 12.5028, 0.0, 0.0, 0.0, 0);
	CreateObject(8838, -825.4681, 5783.83, 12.5049, 0.0, 0.0, 0.0, 0);
	CreateObject(3458, -825.751, 5788.871, 12.507, 0.0, 0.0, 0.0, 0);
	CreateObject(8838, -826.0348, 5793.9121, 12.5091, 0.0, 0.0, 0.0, 0);
	CreateObject(3458, -826.3174, 5798.9531, 12.5113, 0.0, 0.0, 0.0, 0);
	CreateObject(8838, -826.6016, 5803.9941, 12.5134, 0.0, 0.0, 0.0, 0);
	CreateObject(3458, -826.885, 5809.0351, 12.5155, 0.0, 0.0, 0.0, 0);
	CreateObject(8838, -827.1684, 5814.0761, 12.5176, 0.0, 0.0, 0.0, 0);
	CreateObject(3458, -827.4518, 5819.1171, 12.5198, 0.0, 0.0, 0.0, 0);
	CreateObject(8838, -827.7352, 5824.1582, 12.5219, 0.0, 0.0, 0.0, 0);
	CreateObject(3458, -828.0185, 5829.1992, 12.524, 0.0, 0.0, 0.0, 0);
	CreateObject(8838, -828.3019, 5834.2402, 12.5261, 0.0, 0.0, 0.0, 0);
	CreateObject(3458, -828.5853, 5839.2812, 12.5283, 0.0, 0.0, 0.0, 0);
	CreateObject(8838, -828.8687, 5844.3222, 12.5304, 0.0, 0.0, 0.0, 0);
	CreateObject(3458, -829.1521, 5849.3632, 12.5325, 0.0, 0.0, 0.0, 0);
	CreateObject(8838, -829.4355, 5854.4042, 12.5346, 0.0, 0.0, 0.0, 0);
	CreateObject(3458, -829.7189, 5859.4453, 12.5368, 0.0, 0.0, 0.0, 0);
	CreateObject(8838, -830.0022, 5864.4863, 12.5389, 0.0, 0.0, 0.0, 0);
	CreateObject(3458, -830.2856, 5869.5273, 12.541, 0.0, 0.0, 0.0, 0);
	CreateObject(8838, -830.569, 5874.5683, 12.5431, 0.0, 0.0, 0.0, 0);
	CreateObject(3458, -830.8524, 5879.6093, 12.5453, 0.0, 0.0, 0.0, 0);
	CreateObject(8838, -831.1358, 5884.6503, 12.5474, 0.0, 0.0, 0.0, 0);
	CreateObject(3458, -831.4192, 5889.6914, 12.5495, 0.0, 0.0, 0.0, 0);
	CreateObject(8838, -831.7026, 5894.7324, 12.5516, 0.0, 0.0, 0.0, 0);
	CreateObject(3458, -831.986, 5899.7734, 12.5538, 0.0, 0.0, 0.0, 0);
	CreateObject(8838, -832.2693, 5904.8144, 12.5559, 0.0, 0.0, 0.0, 0);
	CreateObject(3458, -832.5527, 5909.8554, 12.558, 0.0, 0.0, 0.0, 0);
	CreateObject(8838, -832.8361, 5914.8964, 12.5601, 0.0, 0.0, 0.0, 0);
	CreateObject(3458, -833.1195, 5919.9375, 12.5623, 0.0, 0.0, 0.0, 0);
	CreateObject(8838, -833.4029, 5924.9785, 12.5644, 0.0, 0.0, 0.0, 0);
	CreateObject(3458, -833.6863, 5930.0195, 12.5665, 0.0, 0.0, 0.0, 0);
	CreateObject(8838, -833.9697, 5935.0605, 12.5686, 0.0, 0.0, 0.0, 0);
	CreateObject(3458, -834.253, 5940.1015, 12.5708, 0.0, 0.0, 0.0, 0);
	CreateObject(8838, -834.5364, 5945.1425, 12.5729, 0.0, 0.0, 0.0, 0);
	CreateObject(3458, -834.8198, 5950.1835, 12.575, 0.0, 0.0, 0.0, 0);
	CreateObject(8838, -835.1032, 5955.2246, 12.5771, 0.0, 0.0, 0.0, 0);
	CreateObject(3458, -835.3866, 5960.2656, 12.5793, 0.0, 0.0, 0.0, 0);
	CreateObject(8838, -835.67, 5965.3066, 12.5814, 0.0, 0.0, 0.0, 0);
	CreateObject(3458, -835.9534, 5970.3476, 12.5835, 0.0, 0.0, 0.0, 0);
	CreateDynamicObject(8838, 3293646630, 1169865500, 1095327474, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3293651273, 1169875824, 1095329702, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8838, 3293655916, 1169886148, 1095331930, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3293660559, 1169896472, 1095334158, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8838, 3293665202, 1169906796, 1095336386, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3293669845, 1169917120, 1095338614, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8838, 3293674488, 1169927444, 1095340842, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3293679131, 1169937768, 1095343070, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8838, 3293683774, 1169948092, 1095345298, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3293688417, 1169958416, 1095347526, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8838, 3293693060, 1169968740, 1095349754, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3293697703, 1169979064, 1095351982, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8838, 3293702346, 1169989388, 1095354210, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3293706989, 1169999712, 1095356438, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8838, 3293711632, 1170010036, 1095358666, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3293716275, 1170020360, 1095360894, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8838, 3293720918, 1170030684, 1095363122, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3293725552, 1170041008, 1095365350, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8838, 3293730204, 1170051332, 1095367578, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3293734847, 1170061656, 1095369806, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8838, 3293739490, 1170071980, 1095372034, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3293744133, 1170082304, 1095374262, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8838, 3293748776, 1170092628, 1095376490, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3293753408, 1170102952, 1095378718, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8838, 3293758062, 1170113276, 1095380946, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3293762704, 1170123600, 1095383174, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3293743043, 1170134274, 1095727022, 1088841318, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3293723382, 1170144780, 1096753134, 1097229926, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3293703722, 1170154952, 1098445338, 1101843660, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3293684048, 1170164630, 1099842284, 1105616000, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3293664400, 1170173660, 1101309400, 1108343968, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3293644739, 1170181901, 1103054704, 1110232269, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3293625078, 1170189223, 1105050651, 1112119706, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3293605418, 1170195510, 1107265774, 1114007143, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3293585757, 1170200662, 1108480698, 1115789722, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3293566096, 1170204600, 1109753574, 1116733296, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3293546432, 1170207258, 1111079584, 1117676496, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3293526774, 1170208600, 1112437815, 1118620876, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3293507114, 1170208600, 1113806835, 1119564594, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3293487453, 1170207259, 1115165060, 1120508312, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3293467792, 1170204600, 1116087967, 1121452030, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3293448128, 1170200662, 1116724405, 1122395372, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3293428464, 1170195510, 1117324247, 1123339300, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3293408810, 1170189223, 1117878030, 1124178328, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3293389149, 1170181901, 1118377016, 1124650187, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3293369488, 1170173660, 1118813340, 1125121904, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3293349827, 1170164630, 1119180120, 1125593905, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3293330166, 1170154952, 1119471570, 1126065764, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3293310496, 1170144780, 1119683093, 1126537424, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3293290832, 1170134274, 1119811357, 1127009384, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3293271184, 1170123600, 1119854342, 1127481341, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3293251523, 1170112926, 1119811362, 1127953200, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3293231862, 1170102420, 1119683098, 1128425059, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3293212202, 1170092248, 1119471574, 1128896918, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3293192528, 1170082570, 1119180121, 1129368464, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3293172880, 1170073540, 1118813343, 1129840424, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3293153219, 1170065299, 1118377022, 1130312495, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3293133558, 1170057977, 1117878037, 1130784354, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3293113898, 1170051690, 1117324256, 1131256213, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3293094237, 1170046538, 1116724416, 1131728072, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3293074576, 1170042600, 1116087973, 1132199864, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3293054912, 1170039940, 1115165072, 1132566772, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3293035254, 1170038600, 1113806848, 1132802865, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3293015594, 1170038600, 1112437826, 1133038795, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3292995920, 1170039940, 1111079600, 1133274712, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3292976272, 1170042600, 1109753584, 1133510655, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3292956608, 1170046538, 1108480694, 1133746492, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3292936944, 1170051690, 1107265766, 1133982472, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3292917290, 1170057977, 1105050646, 1134218445, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3292897629, 1170065299, 1103054699, 1134454375, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3292877968, 1170073540, 1101309405, 1134690304, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3292858307, 1170082570, 1099842285, 1134926235, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3292838640, 1170092248, 1098445300, 1135162012, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3292818976, 1170102420, 1096753104, 1135397992, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3292799325, 1170112926, 1095727010, 1135634025, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3292779664, 1170123600, 1095383174, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3292779664, 1170123600, 1095383174, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3292760000, 1170134274, 1095727022, 1088833024, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3292740336, 1170144780, 1096753134, 1097227392, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3292720672, 1170154952, 1098445316, 1101843200, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3292701008, 1170164630, 1099842284, 1105616000, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3292681360, 1170173660, 1101309411, 1108344832, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3292661696, 1170181900, 1103054704, 1110231808, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3292642032, 1170189222, 1105050651, 1112119648, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3292622368, 1170195510, 1107265774, 1114004608, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3292602704, 1170200662, 1108480692, 1115789376, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3292583056, 1170204600, 1109753574, 1116733296, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3292563392, 1170207258, 1111079584, 1117676496, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3291155937, 1170272826, 1111079600, 1133274712, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3291155937, 1170272826, 1111079600, 1133274712, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3291136276, 1170275485, 1109753586, 1133510642, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3291116615, 1170279422, 1108480698, 1133746572, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3291096955, 1170284575, 1107265757, 1133982502, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3291077294, 1170290862, 1105050623, 1134218432, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3291057633, 1170298183, 1103054663, 1134454362, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3291037972, 1170306424, 1101309348, 1134690292, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3291018311, 1170315455, 1099842218, 1134926222, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3290998640, 1170325132, 1098445152, 1135162012, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3290978990, 1170335304, 1096752912, 1135398082, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3290959329, 1170345810, 1095726764, 1135634012, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3290939668, 1170356485, 1095382888, 1135869942, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3290920007, 1170367159, 1095726708, 1136105872, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3290900347, 1170377665, 1096752796, 1136341802, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3290880686, 1170387837, 1098444972, 1136577732, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3290861025, 1170397515, 1099842106, 1136813662, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3290841364, 1170406545, 1101309212, 1137049592, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3290821703, 1170414786, 1103054504, 1137285522, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3290802043, 1170422108, 1105050445, 1137521452, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3290782382, 1170428394, 1107265562, 1137757382, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3290762721, 1170433547, 1108480594, 1137993312, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3290743060, 1170437484, 1109753476, 1138229242, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3290723399, 1170440144, 1111079486, 1138465172, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3290703739, 1170441485, 1112437717, 1138701102, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3290684078, 1170441485, 1113806738, 1138937032, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3290664417, 1170440144, 1115164965, 1139172962, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3290644756, 1170437485, 1116087920, 1139408892, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3290625095, 1170433547, 1116724363, 1139644822, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3290605435, 1170428395, 1117324210, 1139880752, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3290585774, 1170422108, 1117877990, 1140116682, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3290566113, 1170414787, 1118376978, 1140352612, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3290546452, 1170406546, 1118813302, 1140588542, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3290526791, 1170397515, 1119180082, 1140824472, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3290507131, 1170387837, 1119471534, 1140955545, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3290487470, 1170377665, 1119683060, 1141073510, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3290467809, 1170367159, 1119811325, 1141191475, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3290448148, 1170356485, 1119854306, 1141309440, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3290428487, 1170345811, 1119811325, 1141427405, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3290408827, 1170335305, 1119683060, 1141545370, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3290389166, 1170325133, 1119471535, 1141663335, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3290369505, 1170315455, 1119180082, 1141781300, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3290349844, 1170306424, 1118813302, 1141899264, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3290330183, 1170298183, 1118376978, 1142017230, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3290310523, 1170290862, 1117877990, 1142135195, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3290290862, 1170284575, 1117324210, 1142253160, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3290271201, 1170279423, 1116724363, 1142371125, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3290251540, 1170275485, 1116087920, 1142489090, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3290231879, 1170272826, 1115164964, 1142607055, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3290212219, 1170271485, 1113806738, 1142725020, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3290192558, 1170271485, 1112437716, 1142842985, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3290172896, 1170272826, 1111079490, 1133274712, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3290172896, 1170272826, 1111079490, 1133274712, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3290156512, 1170275485, 1109753476, 1133510642, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3290140128, 1170279422, 1108480588, 1133746572, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3290123744, 1170284575, 1107265537, 1133982502, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3290107360, 1170290862, 1105050403, 1134218432, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3290090976, 1170298183, 1103054443, 1134454362, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3290074592, 1170306424, 1101309128, 1134690232, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3290058208, 1170315455, 1099841998, 1134926222, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3290041824, 1170325132, 1098444712, 1135162152, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3290025440, 1170335304, 1096752472, 1135398082, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3290009056, 1170345810, 1095726324, 1135634012, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289992672, 1170356485, 1095382448, 1135869942, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289976288, 1170367159, 1095726268, 1136105872, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289959904, 1170377665, 1096752356, 1136341802, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289943520, 1170387837, 1098444532, 1136577732, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289927136, 1170397515, 1099841886, 1136813662, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289910752, 1170406545, 1101308992, 1137049592, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289894368, 1170414786, 1103054284, 1137285522, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289877984, 1170422108, 1105050225, 1137521452, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289861600, 1170428394, 1107265342, 1137757382, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289845216, 1170433547, 1108480484, 1137993312, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289828832, 1170437484, 1109753366, 1138229242, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289812448, 1170440144, 1111079376, 1138465172, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289796064, 1170441485, 1112437607, 1138701102, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289779680, 1170441485, 1113806628, 1138937032, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289763296, 1170440144, 1115164855, 1139172962, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289746912, 1170437485, 1116087866, 1139408892, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289730528, 1170433547, 1116724308, 1139644822, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289714144, 1170428395, 1117324154, 1139880752, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289697760, 1170422108, 1117877936, 1140116682, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289681376, 1170414787, 1118376923, 1140352612, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289664992, 1170406546, 1118813248, 1140588542, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289648608, 1170397515, 1119180027, 1140824472, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289632224, 1170387837, 1119471478, 1140955545, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289615840, 1170377665, 1119683006, 1141073510, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289599456, 1170367159, 1119811270, 1141191475, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289583072, 1170356485, 1119854251, 1141309440, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289566688, 1170345811, 1119811270, 1141427405, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289550304, 1170335305, 1119683006, 1141545370, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289533920, 1170325133, 1119471480, 1141663335, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289517536, 1170315455, 1119180027, 1141781300, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289501152, 1170306424, 1118813247, 1141899264, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289484768, 1170298183, 1118376923, 1142017230, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289468384, 1170290862, 1117877936, 1142135195, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289452000, 1170284575, 1117324154, 1142253160, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289435616, 1170279423, 1116724308, 1142371125, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289419232, 1170275485, 1116087865, 1142489090, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289402848, 1170272826, 1115164854, 1142607055, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289386464, 1170271485, 1113806628, 1142725020, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289370080, 1170271485, 1112437606, 1142842985, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289353696, 1170272826, 1111079380, 1133274712, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289353696, 1170272826, 1111079380, 1133274712, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289337312, 1170275485, 1109753366, 1133510642, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289320928, 1170279422, 1108480478, 1133746572, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289304544, 1170284575, 1107265317, 1133982502, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289288160, 1170290862, 1105050183, 1134218432, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289271776, 1170298183, 1103054223, 1134454362, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289255392, 1170306424, 1101308908, 1134690292, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289239008, 1170315455, 1099841778, 1134926222, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289222624, 1170325132, 1098444272, 1135162152, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289206240, 1170335304, 1096752032, 1135398082, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289189856, 1170345810, 1095725884, 1135634012, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289173472, 1170356485, 1095382008, 1135869942, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289157088, 1170367159, 1095725828, 1136105872, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289140704, 1170377665, 1096751916, 1136341802, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289124320, 1170387836, 1098444092, 1101843200, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289107936, 1170397515, 1099841666, 1136813662, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289091552, 1170406545, 1101308772, 1137049592, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289075168, 1170414786, 1103054064, 1137285522, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289058784, 1170422108, 1105050005, 1137521452, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289042400, 1170428394, 1107265122, 1137757382, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289026016, 1170433547, 1108480374, 1137993312, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289009632, 1170437484, 1109753256, 1138229242, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288993248, 1170440144, 1111079266, 1138465172, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3288994838, 1170441594, 1112437491, 1118568448, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3288965968, 1170444622, 1112437491, 1132986352, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288965968, 1170445605, 1111074270, 1133200848, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288965968, 1170447795, 1109734275, 1133415329, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288965968, 1170451165, 1108434970, 1133629810, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288965968, 1170455670, 1107090342, 1133844291, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288965968, 1170461251, 1104754652, 1134058772, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288965968, 1170467836, 1102597044, 1134273253, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288965968, 1170475338, 1100645662, 1134487734, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288965968, 1170483661, 1098925930, 1134702215, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288965968, 1170492695, 1096012916, 1134916696, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288965968, 1170502323, 1093627976, 1135131177, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288965968, 1170512419, 1091820500, 1135345658, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288965968, 1170522851, 1090614048, 1135560139, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288965968, 1170533485, 1089529648, 1135774620, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288966013, 1170544129, 1089179680, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3288966080, 1170554536, 1089179636, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289255829, 1170601115, 1089179680, 0, 0, 1132920832, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289171854, 1170600916, 1089179680, 0, 0, 1132920652, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3289005824, 1170600798, 1089179636, 0, 0, 1132920472, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3288922448, 1170600756, 1089179636, 0, 0, 1132920472, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288757056, 1170600526, 1089179680, 0, 0, 1132920652, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288676244, 1170600265, 1089179680, 0, 0, 1132920652, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289183483, 1170678044, 1089179680, 0, 0, 1132461720, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289104658, 1170675379, 1089127251, 0, 0, 1132461584, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3289024608, 1170672698, 1089127206, 0, 0, 1132461584, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3288876320, 1170672236, 1089127206, 0, 0, 1133215672, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288795907, 1170674300, 1089127251, 0, 0, 1133215672, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288715454, 1170676178, 1089127251, 0, 0, 1133215672, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(12857, 3288959536, 1170663308, 1087268448, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288978384, 1170752910, 1089179680, 0, 0, 1132920472, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288895498, 1170790321, 1089966115, 0, 1073741824, 1132920652, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3288978560, 1170790352, 1089966070, 0, 1073737728, 1132920472, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288981625, 1170856780, 3240622714, 0, 1119092736, 1132920832, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288981757, 1170895092, 1090740649, 0, 0, 1132920652, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3288898304, 1170895038, 1090740627, 0, 0, 1132920472, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288899296, 1170856804, 3240622714, 0, 1119092736, 1132920832, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288981650, 1170895194, 1090740649, 0, 1082126336, 1132920472, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288979784, 1170900232, 1090740649, 0, 1086322688, 1132920472, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3288899200, 1170895182, 1090740627, 0, 1082080256, 1132920472, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3288898656, 1170900258, 1090740627, 0, 1086321664, 1132920472, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288925600, 1171001634, 1093667239, 1135673212, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3288925808, 1170999670, 1092723493, 1118829936, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288925808, 1170999670, 1085071370, 1118830592, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288925808, 1170999670, 1051171388, 1118829936, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3288925472, 1171011904, 1093116723, 1135673212, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288925600, 1171021888, 1092671107, 1135738748, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288925949, 1171031554, 1092408967, 1135804268, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288925959, 1171041130, 1092330325, 1135869788, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288926188, 1171050833, 1092408967, 1073695744, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288926335, 1171060697, 1092671107, 1082105344, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288925957, 1171070703, 1093116757, 1086311168, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288926155, 1171080382, 1093719679, 1090504448, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288932884, 1171131779, 1095502247, 1090503424, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3288933008, 1171141818, 1096210003, 1090491904, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288933090, 1171151700, 1096917803, 1090503424, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3288932816, 1171129090, 1093929337, 1118829216, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288932762, 1171128784, 1086801483, 1118829936, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(13142, 3288911361, 1171016429, 1107071708, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(13142, 3288909438, 1171041189, 1107071708, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(13142, 3288907515, 1171065949, 1107071708, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(13142, 3288905592, 1171090709, 1107071708, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(13142, 3288903669, 1171115469, 1107071708, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(13142, 3288901746, 1171140229, 1107071708, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(13142, 3288899823, 1171164989, 1107071708, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(13142, 3288897900, 1171189749, 1107071708, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(13142, 3288895977, 1171214509, 1107071708, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(13142, 3288894054, 1171239269, 1107071708, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(13142, 3288892131, 1171264029, 1107071708, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(13142, 3288890208, 1171288789, 1107071708, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(13142, 3288888272, 1171313548, 1107071708, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(13142, 3288886352, 1171338308, 1107071708, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(13142, 3288884439, 1171363069, 1107071708, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(13142, 3288882516, 1171387829, 1107071708, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(13142, 3288880593, 1171412589, 1107071708, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17043, 3288917534, 1171172631, 1097715286, 0, 0, 1104936960, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17043, 3288917813, 1171248648, 1106506087, 0, 0, 1104936320, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17043, 3288918576, 1171248586, 1104760212, 0, 1127481344, 1125662640, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288920720, 1171424062, 1091250668, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288920566, 1171434500, 1091250668, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288920564, 1171444857, 1091250668, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3288884192, 1171265120, 1093667229, 1090491904, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288880972, 1171275383, 1094348815, 1090503424, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3288868384, 1171285628, 1095082785, 1090491904, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288856547, 1171295242, 1095764371, 1090503424, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3288845872, 1171305128, 1096472139, 1090480384, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288920116, 1171455263, 1091250668, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288920310, 1171465730, 1091250668, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288920304, 1171465730, 1091250668, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288920304, 1171476208, 1091461444, 1083176704, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288920310, 1171486621, 1092092468, 1091567616, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288920310, 1171496905, 1093139848, 1096286208, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288920310, 1171506997, 1094597136, 1099956224, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288920310, 1171516835, 1096455336, 1102315520, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288920310, 1171526357, 1098703000, 1104674816, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3288920304, 1171535506, 1100116945, 1107032960, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288920310, 1171544225, 1101608304, 1108344832, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288920310, 1171552459, 1103270170, 1109524480, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288920310, 1171560159, 1105092314, 1110704128, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288920310, 1171567277, 1107063494, 1111883776, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288920310, 1171573769, 1108233910, 1113063424, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288920310, 1171579594, 1109349890, 1114243072, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288920310, 1171584718, 1110520933, 1115422720, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288920310, 1171589108, 1111739822, 1116143616, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288920310, 1171592737, 1112999042, 1116733440, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288920310, 1171595583, 1114290826, 1117323264, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288920304, 1171597628, 1115607214, 1117912656, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288919499, 1171599203, 1116312476, 1118044160, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3288917395, 1171600438, 1116976491, 1118437376, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288920160, 1171652008, 1108642321, 1102678400, 0, 1127480984, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288920169, 1171642462, 1109259480, 1136865942, 0, 1127481344, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288920169, 1171633595, 1110024932, 1137101872, 0, 1127481344, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288920169, 1171625547, 1110926610, 1137337802, 0, 1127481344, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288920160, 1171618444, 1111950286, 1112537248, 0, 1127480984, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288920169, 1171612402, 1113079819, 1137809662, 0, 1127481344, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288920169, 1171607512, 1114297402, 1138045592, 0, 1127481344, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288920169, 1171603853, 1115583822, 1138281522, 0, 1127481344, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288920169, 1171601483, 1116301834, 1138517452, 0, 1127481344, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3288920160, 1171600438, 1116983069, 1118829216, 0, 1127480984, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288921728, 1171670224, 1107633077, 1102675520, 0, 1127480984, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288923306, 1171688442, 1105951410, 1102678400, 0, 1127480984, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288924879, 1171706659, 1103932922, 1102678400, 0, 1127480984, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288926452, 1171724876, 1101914434, 1102678400, 0, 1127480984, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288928025, 1171743093, 1099895946, 1102678400, 0, 1127480984, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288929598, 1171761310, 1096847268, 1102678400, 0, 1127480984, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288931171, 1171779527, 1092810292, 1102678400, 0, 1127480984, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288932736, 1171797744, 1086922734, 1102672640, 0, 1127480984, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288932646, 1171914462, 1108250866, 1133326717, 0, 1127480984, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288932649, 1171911517, 1106573324, 1133562647, 0, 1127480984, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288932652, 1171907306, 1104056431, 1133798577, 0, 1127480984, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288932656, 1171901895, 1101694510, 1134034507, 0, 1127480984, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288932661, 1171895372, 1099524798, 1134270437, 0, 1127480984, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288932667, 1171887837, 1096255366, 1134506367, 0, 1127480984, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288932673, 1171879410, 1092882952, 1134742297, 0, 1127480984, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288932680, 1171870225, 1089636696, 1134978227, 0, 1127480984, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288932688, 1171860425, 1085249664, 1135214157, 0, 1127480984, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288932696, 1171850165, 1082154976, 1135450087, 0, 1127480984, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288932704, 1171839608, 1078672432, 1135686017, 0, 1127480984, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288932712, 1171828919, 1077902912, 1135921947, 0, 1127480984, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3288932720, 1171807820, 1083356083, 1098886272, 0, 1127480984, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(4570, 3288950272, 1171998844, 1094556057, 0, 0, 1127480984, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8355, 3288868849, 1172150286, 1115469370, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(7584, 3288436544, 1172102048, 1123676830, 1119092736, 1127480984, 1127480984, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(7584, 3289660762, 1172102528, 1121428280, 1106116624, 1132920832, 1119091304, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(7584, 3289661443, 1172285545, 1121441388, 1106114240, 1132920652, 1119091296, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(7584, 3288435870, 1172294561, 1123676830, 1119092736, 1127480984, 1127480984, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(7584, 3288435182, 1172487073, 1123676830, 1119092736, 1127480624, 1127480624, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(7584, 3288434494, 1172679585, 1123676830, 1119092736, 1127480264, 1127480264, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(7584, 3288433806, 1172872097, 1123676830, 1119092736, 1127479904, 1127479904, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(7584, 3288433118, 1173064609, 1123676830, 1119092736, 1127479544, 1127479544, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(7584, 3288432430, 1173257121, 1123676830, 1119092736, 1127479184, 1127479184, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(7584, 3288431742, 1173449633, 1123676830, 1119092736, 1127478824, 1127478824, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(7584, 3288431054, 1173642145, 1123676830, 1119092736, 1127478464, 1127478464, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(7584, 3288430366, 1173834657, 1123676830, 1119092736, 1127478104, 1127478104, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(7584, 3289662124, 1172468562, 1121454496, 1106111856, 1132920472, 1119091288, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(7584, 3289662805, 1172651579, 1121467604, 1106109472, 1132920292, 1119091280, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(7584, 3289663486, 1172834596, 1121480712, 1106107088, 1132920112, 1119091272, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(7584, 3289664167, 1173017613, 1121493820, 1106104704, 1132919932, 1119091264, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(7584, 3289664848, 1173200630, 1121506928, 1106102320, 1132919752, 1119091256, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(7584, 3289665529, 1173383647, 1121520036, 1106099936, 1132919572, 1119091248, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(7584, 3289666210, 1173566664, 1121533144, 1106097552, 1132919392, 1119091240, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(7584, 3289666891, 1173749681, 1121546252, 1106095168, 1132919212, 1119091232, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288914472, 1171413846, 1091250668, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288850056, 1171315344, 1097153749, 1090491904, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(7584, 3288651008, 1172101906, 1114195596, 1133903812, 1119092736, 1132920472, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(7584, 3288650722, 1172300113, 1114189042, 1133903812, 1119092736, 1132920472, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(7584, 3288650432, 1172498318, 1114182488, 1133903632, 1119092736, 1132920112, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(7584, 3288650144, 1172696524, 1114175934, 1133903632, 1119092736, 1132920292, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(7584, 3288649864, 1172894731, 1114169380, 1133903632, 1119092736, 1132920460, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(7584, 3288649578, 1173092937, 1114162826, 1133903572, 1119092736, 1132920456, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(7584, 3288649292, 1173291143, 1114156272, 1133903512, 1119092736, 1132920452, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(7584, 3288649006, 1173489349, 1114149718, 1133903452, 1119092736, 1132920448, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(7584, 3288648720, 1173687554, 1114143164, 1133903272, 1119092736, 1132920292, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(4564, 3289805444, 1173958789, 1120248684, 0, 0, 1135476736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(7584, 3288650368, 1173765466, 1114130056, 1133903272, 1119092736, 1132920112, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289114320, 1173821416, 1116001307, 0, 1106247680, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289113944, 1173831882, 1116001307, 0, 1106246720, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289114638, 1173841862, 1116001307, 0, 1106246720, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289114672, 1173852305, 1116001307, 0, 1106246720, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289114087, 1173862309, 1116001307, 0, 1106246720, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289114087, 1173862309, 1116001307, 0, 1106246720, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289112776, 1173872741, 1116001307, 0, 1106246720, 3219547750, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289108844, 1173883163, 1116001307, 0, 1106246720, 3227936358, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289102296, 1173893564, 1116001307, 0, 1106246720, 3232550092, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289093136, 1173903934, 1116001307, 0, 1106246720, 3236324966, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289081376, 1173914264, 1116001307, 0, 1106246720, 3239051264, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289067026, 1173924541, 1116001307, 0, 1106246720, 3240938701, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289050100, 1173934758, 1116001307, 0, 1106246720, 3242826138, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289030614, 1173944903, 1116001307, 0, 1106246720, 3244713575, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3289008590, 1173954967, 1116001307, 0, 1106246720, 3246496154, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288984047, 1173964939, 1116001307, 0, 1106246720, 3247439872, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288957011, 1173974810, 1116001307, 0, 1106246720, 3248383590, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288927508, 1173984569, 1116001307, 0, 1106246720, 3249327308, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288895566, 1173994208, 1116001307, 0, 1106246720, 3250271026, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288861219, 1174003717, 1116001307, 0, 1106246720, 3251214744, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288824498, 1174013087, 1116001307, 0, 1106246720, 3252158462, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288785442, 1174022308, 1116001307, 0, 1106246720, 3253102180, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288744088, 1174031370, 1116001307, 0, 1106246720, 3254045898, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288700476, 1174040266, 1116001307, 0, 1106246720, 3254884760, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288654652, 1174048986, 1116001307, 0, 1106246720, 3255356619, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288606658, 1174057522, 1116001307, 0, 1106246720, 3255828478, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288556543, 1174065866, 1116001307, 0, 1106246720, 3256300337, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288504356, 1174074008, 1116001307, 0, 1106246720, 3256772196, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288450149, 1174081942, 1116001307, 0, 1106246720, 3257244055, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288393975, 1174089659, 1116001307, 0, 1106246720, 3257715914, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288335889, 1174097151, 1116001307, 0, 1106246720, 3258187773, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288217563, 1174104412, 1116001307, 0, 1106246720, 3258659632, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288094094, 1174111433, 1116001307, 0, 1106246720, 3259131491, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3287967157, 1174118209, 1116001307, 0, 1106246720, 3259603350, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3287836877, 1174124733, 1116001307, 0, 1106246720, 3260075209, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3287703384, 1174130997, 1116001307, 0, 1106246720, 3260547068, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3287566807, 1174136996, 1116001307, 0, 1106246720, 3261018927, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3287427283, 1174142724, 1116001307, 0, 1106246720, 3261490786, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3287284949, 1174148176, 1116001307, 0, 1106246720, 3261962645, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3287139946, 1174153345, 1116001307, 0, 1106246720, 3262434504, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3286992416, 1174158227, 1116001307, 0, 1106246720, 3262906363, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3286842506, 1174162817, 1116001307, 0, 1106246720, 3263273367, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3286690362, 1174167111, 1116001307, 0, 1106246720, 3263509297, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3286536135, 1174171103, 1116001307, 0, 1106246720, 3263745227, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3286379978, 1174174791, 1116001307, 0, 1106246720, 3263981157, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3286222044, 1174178171, 1116001307, 0, 1106246720, 3264217087, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3286062491, 1174181239, 1116001307, 0, 1106246720, 3264453017, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3285901474, 1174183992, 1116001307, 0, 1106246720, 3264688947, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3285739152, 1174186427, 1116001307, 0, 1106246720, 3264924877, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3285575688, 1174188543, 1116001307, 0, 1106246720, 3265160807, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3285411240, 1174190337, 1116001307, 0, 1106246720, 3265396737, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3285245972, 1174191807, 1116001307, 0, 1106246720, 3265632667, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3285080046, 1174192952, 1116001307, 0, 1106246720, 3265868597, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3284913628, 1174193771, 1116001307, 0, 1106246720, 3266104527, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3284746878, 1174194262, 1116001307, 0, 1106246720, 3266340457, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3284579966, 1174194426, 1116001307, 0, 1106246720, 3266576387, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3284413053, 1174194262, 1116001307, 0, 1106246720, 3266812317, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3284246304, 1174193770, 1116001307, 0, 1106246720, 3267048247, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3284079886, 1174192952, 1116001307, 0, 1106246720, 3267284177, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3283913960, 1174191807, 1116001307, 0, 1106246720, 3267520107, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3283748692, 1174190337, 1116001307, 0, 1106246720, 3267756037, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3283584244, 1174188543, 1116001307, 0, 1106246720, 3267991967, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3283420780, 1174186427, 1116001307, 0, 1106246720, 3268227897, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3283258458, 1174183992, 1116001307, 0, 1106246720, 3268463827, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3283097441, 1174181239, 1116001307, 0, 1106246720, 3268699757, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3282937888, 1174178171, 1116001307, 0, 1106246720, 3268935687, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3282779954, 1174174791, 1116001307, 0, 1106246720, 3269171617, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3282623797, 1174171103, 1116001307, 0, 1106246720, 3269407547, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3282469571, 1174167111, 1116001307, 0, 1106246720, 3269643477, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3282317427, 1174162817, 1116001307, 0, 1106246720, 3269879407, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3282167515, 1174158227, 1116001307, 0, 1106246720, 3270115337, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3282019986, 1174153345, 1116001307, 0, 1106246720, 3270351267, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3281874982, 1174148176, 1116001307, 0, 1106246720, 3270587197, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3281732648, 1174142724, 1116001307, 0, 1106246720, 3270823127, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3281593124, 1174136996, 1116001307, 0, 1106246720, 3271059057, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3281456548, 1174130997, 1116001307, 0, 1106246720, 3271294987, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3281323053, 1174124732, 1116001307, 0, 1106246720, 3271530917, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3281192774, 1174118209, 1116001307, 0, 1106246720, 3271661983, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3281065837, 1174111433, 1116001307, 0, 1106246720, 3271779948, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3280942367, 1174104411, 1116001307, 0, 1106246720, 3271897913, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3280822488, 1174097151, 1116001307, 0, 1106246720, 3272015878, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3280706317, 1174089658, 1116001307, 0, 1106246720, 3272133843, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3280593969, 1174081941, 1116001307, 0, 1106246720, 3272251808, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3280485555, 1174074008, 1116001307, 0, 1106246720, 3272369773, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3280381182, 1174065865, 1116001307, 0, 1106246720, 3272487738, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3280280950, 1174057522, 1116001307, 0, 1106246720, 3272605703, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3280184964, 1174048986, 1116001307, 0, 1106246720, 3272723668, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3280093314, 1174040266, 1116001307, 0, 1106246720, 3272841633, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3280006092, 1174031370, 1116001307, 0, 1106246720, 3272959598, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3279901038, 1174022307, 1116001307, 0, 1106246720, 3273077563, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3279744812, 1174013086, 1116001307, 0, 1106246720, 3273195528, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3279597932, 1174003717, 1116001307, 0, 1106246720, 3273313493, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3279460540, 1173994208, 1116001307, 0, 1106246720, 3273431458, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3279332776, 1173984569, 1116001307, 0, 1106246720, 3273549423, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3279214764, 1173974809, 1116001307, 0, 1106246720, 3273667388, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3279106620, 1173964938, 1116001307, 0, 1106246720, 3273785353, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3279008448, 1173954966, 1116001307, 0, 1106246720, 3273903318, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3278920352, 1173944902, 1116001307, 0, 1106246720, 3274021283, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3278842412, 1173934757, 1116001307, 0, 1106246720, 3274139248, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3278774708, 1173924541, 1116001307, 0, 1106246720, 3274257213, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3278717308, 1173914263, 1116001307, 0, 1106246720, 3274375178, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3278670268, 1173903933, 1116001307, 0, 1106246720, 3274493143, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3278633632, 1173893563, 1116001307, 0, 1106246720, 3274611108, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3278607436, 1173883162, 1116001307, 0, 1106246720, 3274729073, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3278591712, 1173872740, 1116001307, 0, 1106246720, 3274847038, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3278586468, 1173862308, 1116001307, 0, 1106246720, 3274965003, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3278591712, 1173851876, 1116001307, 0, 1106246720, 3275082968, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3278607440, 1173841454, 1116001307, 0, 1106246720, 3275200933, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3278633636, 1173831053, 1116001307, 0, 1106246720, 3275318898, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3278670276, 1173820683, 1116001307, 0, 1106246720, 3275436863, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(4585, 3277932480, 1173574838, 1105660058, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(4585, 3280416542, 1173575894, 1105660058, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(979, 3279643005, 1173820930, 1114705656, 0, 1134911488, 1135607808, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(978, 3278712160, 1173817165, 1116274578, 0, 1134903296, 1135673344, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(978, 3278213480, 1173815156, 1116844738, 0, 1134903172, 1135607740, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3877, 3279013547, 1173817467, 1116069613, 0, 1135149056, 1135607808, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3877, 3279395515, 1173820098, 1115589250, 0, 1135149052, 1135607692, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(978, 3277831824, 1173813389, 1117277290, 0, 1134902992, 1135607692, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(18450, 3279430976, 1173517664, 1085014016, 0, 0, 1132904272, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(18450, 3279475831, 1173364266, 1084961587, 0, 0, 1132904272, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(18450, 3279520576, 1173210868, 1084909158, 0, 0, 1132904092, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(18450, 3279565440, 1173057470, 1084856729, 0, 0, 1132903912, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(18450, 3279610255, 1172904072, 1084804300, 0, 0, 1132903744, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(18450, 3279655063, 1172750674, 1084751871, 0, 0, 1132903568, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(18450, 3279699871, 1172597276, 1084699442, 0, 0, 1132903392, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(18450, 3279744679, 1172443878, 1084647013, 0, 0, 1132903216, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(18450, 3279789487, 1172290480, 1084594584, 0, 0, 1132903040, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(18450, 3279834295, 1172137082, 1084542155, 0, 0, 1132902864, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(18450, 3279879040, 1171983684, 1084489726, 0, 0, 1132902472, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(18450, 3279923904, 1171830286, 1084437297, 0, 0, 1132902472, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(18450, 3279923904, 1171830286, 1087111176, 0, 1135804416, 1132902472, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(18450, 3279923904, 1171830286, 1089785055, 0, 1135673180, 1132902292, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(18450, 3279923904, 1171830286, 1089785055, 0, 1135607496, 1132902292, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(18450, 3279920096, 1171823387, 1090099629, 0, 1135541796, 1132902292, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(18450, 3279918848, 1171815166, 1090754980, 0, 1135475932, 1132902292, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(7584, 3278923924, 1173469064, 1109754118, 1119092736, 1127480984, 1127480984, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(7584, 3279042926, 1173470686, 1109747564, 1119092736, 1127481344, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(7584, 3279041755, 1173287389, 1109747564, 1119092736, 1127481344, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(7584, 3278924109, 1173285512, 1109754118, 1119092736, 1127480984, 1127480984, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(18450, 3279932029, 1171805778, 1090754980, 0, 1135344860, 1132902292, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288932720, 1171818266, 1079883136, 1091340672, 0, 1127480984, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3279964766, 1171473602, 1088337950, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3279964340, 1171463137, 1088337924, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3279963914, 1171452672, 1088337898, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3279963488, 1171442207, 1088337872, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3279963062, 1171431742, 1088337846, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3279962636, 1171421277, 1088337820, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3279962210, 1171410812, 1088337794, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3279961784, 1171400347, 1088337768, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3279961358, 1171389882, 1088337742, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3279960932, 1171379417, 1088337716, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3279960506, 1171368952, 1088337690, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3279960080, 1171358487, 1088337664, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3279959648, 1171348022, 1088337638, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3279959228, 1171337557, 1088337612, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3279958802, 1171327092, 1088337586, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3279958376, 1171316627, 1088337560, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3279957950, 1171306162, 1088337534, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3279957524, 1171295697, 1088337508, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3279957098, 1171285232, 1088337482, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3279956672, 1171274767, 1088337456, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3279956246, 1171264302, 1088337430, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3279955820, 1171253837, 1088337404, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3279955394, 1171243372, 1088337378, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3279954968, 1171232907, 1088337352, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3279954542, 1171222442, 1088337326, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3279954116, 1171211977, 1088337300, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3279953690, 1171201512, 1088337274, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3279953264, 1171191047, 1088337248, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3279952838, 1171180582, 1088337222, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3279952412, 1171170117, 1088337196, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3279951986, 1171159652, 1088337170, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3279951560, 1171149187, 1088337144, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3279951134, 1171138722, 1088337118, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3279950708, 1171128257, 1088337092, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3279950282, 1171117792, 1088337066, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3279949856, 1171107327, 1088337040, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3279949430, 1171096862, 1088337014, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3279949004, 1171086397, 1088336988, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3279948578, 1171075932, 1088336962, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3279948152, 1171065467, 1088336936, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3279947726, 1171055002, 1088336910, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3279947300, 1171044537, 1088336884, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3279946874, 1171034072, 1088336858, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3279946448, 1171023607, 1088336832, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3279946022, 1171013142, 1088336806, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3279945464, 1171002677, 1088336780, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3279944612, 1170992212, 1088336754, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3279943760, 1170981747, 1088336728, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3279942908, 1170971282, 1088336702, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3279942056, 1170960817, 1088336676, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3279941204, 1170950352, 1088336650, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3279940352, 1170939887, 1088336624, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3279939456, 1170929422, 1088336598, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3279938648, 1170918957, 1088336572, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3279937796, 1170908492, 1088336546, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3279936944, 1170898027, 1088336520, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3279936092, 1170887562, 1088336494, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3279935232, 1170877096, 1088336468, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3279934388, 1170866632, 1088336442, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3279933504, 1170856166, 1088336416, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3279933504, 1170856166, 1088336416, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3279936465, 1170771449, 1110948964, 1132920832, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8838, 3279933504, 1170772506, 1109589622, 1133274712, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3279933504, 1170775166, 1108264722, 1133510655, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3279933504, 1170779104, 1106687420, 1133746585, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3279933504, 1170784256, 1104288065, 1133982472, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3279933504, 1170790543, 1102072923, 1134218445, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3279933504, 1170797865, 1100076976, 1134454375, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3279933504, 1170806106, 1097755738, 1134690232, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3279933504, 1170815136, 1094821476, 1134926235, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3279933504, 1170824814, 1092489876, 1135162012, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3279933504, 1170834986, 1090797702, 1135397992, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3279933504, 1170845492, 1089024088, 1135633972, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3279933504, 1170856166, 1088336416, 1135869952, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8357, 3279943054, 1170774357, 1106611670, 1119092736, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(4113, 3277229888, 1170790570, 1109132620, 0, 0, 1086321664, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(978, 3292817616, 1170205153, 1111881298, 0, 0, 1127481344, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(978, 3292664312, 1170205133, 1111881298, 0, 0, 1127480984, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(979, 3292309877, 1170205091, 1111877856, 0, 0, 1127481344, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3472, 3293744339, 1169400773, 1096829930, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3472, 3293772122, 1169441664, 1096838842, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3472, 3293769832, 1169483356, 1096847754, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3472, 3293787570, 1169524645, 1096856666, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3472, 3293811455, 1169565199, 1096865578, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3472, 3293814471, 1169608254, 1096874490, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3472, 3293844582, 1169648391, 1096883402, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3472, 3293851667, 1169688615, 1096892314, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3472, 3293870706, 1169730284, 1096901226, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3472, 3293878880, 1169772666, 1096910138, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3472, 3293919269, 1169813948, 1096919050, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3472, 3293921879, 1169856222, 1096927962, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3472, 3293940104, 1169896709, 1096936874, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3472, 3293958616, 1169937809, 1096945786, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3472, 3293976847, 1169978295, 1096954698, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3472, 3293995919, 1170020620, 1096963610, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3472, 3294014016, 1170060800, 1096972522, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3472, 3294032394, 1170101592, 1096981434, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3472, 3293448187, 1170102579, 1096981434, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3472, 3293440544, 1170061423, 1096972522, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3472, 3293432787, 1170019655, 1096963610, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3472, 3293424927, 1169978846, 1096954698, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3472, 3293413350, 1169938629, 1096945786, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3472, 3293363002, 1169896665, 1096936874, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3472, 3293359165, 1169854928, 1096927962, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3472, 3293308824, 1169772919, 1096910138, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3472, 3293331184, 1169813650, 1096919050, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3472, 3293295843, 1169730742, 1096901226, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3472, 3293279987, 1169690744, 1096892314, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3472, 3293248043, 1169649099, 1096883402, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3472, 3293233782, 1169606829, 1096874490, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3472, 3293230183, 1169566213, 1096865578, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3472, 3293198541, 1169523846, 1096856666, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3472, 3293177625, 1169483701, 1096847754, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3472, 3293159923, 1169442066, 1096838842, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3472, 3293141782, 1169401246, 1096829930, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3288884139, 1171262468, 1092094383, 1118568448, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(4113, 3274819374, 1170787005, 1109119512, 0, 0, 1128251296, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3273521067, 1170782632, 1116730678, 1116995584, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3273521067, 1170782632, 1116730678, 1116995584, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3266578304, 1170782632, 1100448574, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3267247877, 1170782632, 1100609612, 1136066560, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3267912435, 1170782632, 1100983200, 1136197632, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3268568860, 1170782632, 1101541312, 1136328704, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3269213948, 1170782632, 1102281216, 1136459776, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3269844566, 1170782632, 1103199320, 1136590848, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3270457636, 1170782632, 1104291148, 1136721920, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3271050173, 1170782632, 1105551376, 1136852992, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3271588160, 1170782632, 1106973859, 1107819808, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3271859666, 1170782632, 1107923976, 1137115136, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3272116706, 1170782632, 1108786706, 1137246208, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3272358077, 1170782632, 1109719061, 1137377280, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3272582600, 1170782632, 1110716495, 1137508352, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3272789182, 1170782632, 1111774146, 1137639424, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3272976816, 1170782632, 1112886863, 1137770496, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3273144588, 1170782632, 1114049216, 1137901568, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3273291648, 1170782632, 1115255552, 1115946336, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3273417378, 1170782632, 1116092434, 1138163712, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3273521067, 1170782632, 1116730678, 1138294784, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3265921128, 1170782578, 1100448563, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3265263952, 1170782524, 1100448552, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3264606776, 1170782470, 1100448541, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3263949600, 1170782416, 1100448530, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3263292424, 1170782362, 1100448519, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3262101984, 1170782308, 1100448508, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3260787632, 1170782254, 1100448497, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3259473280, 1170782200, 1100448486, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3258158928, 1170782146, 1100448475, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3256844576, 1170782092, 1100448464, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3255530224, 1170782038, 1100448453, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3253651840, 1170781984, 1100448442, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3251023136, 1170781930, 1100448431, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3248394432, 1170781876, 1100448420, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3245140160, 1170781822, 1100448409, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 3239882752, 1170781768, 1100448398, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3231248000, 1170781714, 1100448387, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 1047552000, 1170781660, 1100448376, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 1084748928, 1170781606, 1100448365, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 1092891392, 1170781552, 1100448354, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 1098148800, 1170781498, 1100448343, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 1101156928, 1170781444, 1100448332, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 1103785632, 1170781390, 1100448321, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 1106414336, 1170781336, 1100448310, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 1108169648, 1170781282, 1100448299, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 1109484000, 1170781228, 1100448288, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 1110798352, 1170781174, 1100448277, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 1112112704, 1170781120, 1100448266, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 1113427056, 1170781066, 1100448255, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 1114741408, 1170781012, 1100448244, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 1115870312, 1170780958, 1100448233, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 1116527488, 1170780904, 1100448222, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 1117184664, 1170780850, 1100448211, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 1117841840, 1170780796, 1100448200, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 1118499016, 1170780742, 1100448189, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 1119156192, 1170780688, 1100448178, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 1119813368, 1170780634, 1100448167, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 1120470544, 1170780580, 1100448156, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 1121127720, 1170780526, 1100448145, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 1121784896, 1170780472, 1100448134, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 1122442072, 1170780418, 1100448123, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 1123099248, 1170780364, 1100448112, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 1123756416, 1170780310, 1100448101, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 1124243536, 1170780256, 1100448090, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 1124572124, 1170780202, 1100448079, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 1124900712, 1170780148, 1100448068, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 1125229300, 1170780094, 1100448057, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 1125557888, 1170780040, 1100448046, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 1125886476, 1170779986, 1100448035, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 1126215064, 1170779932, 1100448024, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 1126543652, 1170779878, 1100448013, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 1126872240, 1170779824, 1100448002, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 1127200828, 1170779770, 1100447991, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 1127529416, 1170779716, 1100447980, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 1127858004, 1170779662, 1100447969, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 1128186592, 1170779608, 1100447958, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 1128515180, 1170779554, 1100447947, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 1128843712, 1170779500, 1100447936, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 1129172352, 1170779446, 1100447925, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8558, 1129500944, 1170779392, 1100447914, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3499, 3273473923, 1170786888, 1117090687, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3499, 3273491002, 1170757958, 1117090687, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3499, 3273458597, 1170815247, 1117090687, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3499, 3273458353, 1170804259, 1117624150, 0, 1119092736, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3499, 3273459735, 1170782024, 1117624150, 0, 1119092736, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3499, 3273458136, 1170768026, 1117624150, 0, 1119092736, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3499, 3273433923, 1170801071, 1117473424, 0, 1119092736, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3499, 3273431669, 1170771487, 1117473424, 0, 1119092736, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3441, 3293539453, 1169425212, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3441, 3293455168, 1169388504, 1098822936, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(7264, 3294095830, 1169274269, 1099178504, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3293076036, 1169538563, 3268246463, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3293723090, 1169460646, 1095631270, 0, 1132920832, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3293684921, 1169483391, 1095631270, 0, 1132920832, 1115946984, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3293646016, 1169506345, 1095631270, 0, 1132920832, 1119092012, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3293592204, 1169527506, 1095631270, 0, 1132920832, 1113060480, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3293531993, 1169549043, 1095631270, 0, 1132920832, 1118828736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3293697801, 1169528364, 1095631270, 0, 1132920832, 1123284904, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3293747891, 1169549759, 1095631270, 0, 1132920832, 1119090240, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3293697078, 1169571316, 1095631270, 0, 1132920832, 1113581864, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3293583803, 1169570483, 1095631270, 0, 1132920832, 1123808016, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3293642656, 1169592130, 1095631270, 0, 1132920832, 1119088616, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3293587705, 1169547794, 1095631270, 0, 1132920832, 1123544740, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3293695154, 1169548186, 1095631270, 0, 1132920832, 1113577352, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3293642764, 1169569080, 1095631270, 0, 1132920832, 1119087992, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3293724289, 1169485152, 1095631270, 0, 1132920832, 1119087696, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3293724740, 1169508373, 1095631270, 0, 1132920832, 1119087696, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3293741387, 1169530970, 1095631270, 0, 1132920832, 1120398396, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3293405678, 1169550126, 1095631270, 0, 1132920832, 1118828496, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3293212693, 1169459747, 1095631270, 0, 1132920832, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3293263675, 1169481884, 1095631270, 0, 1132920832, 1123286844, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3293311158, 1169503798, 1095631270, 0, 1132920832, 1118829812, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3293362205, 1169529054, 1095631270, 0, 1132920832, 1123023400, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3293310494, 1169506663, 1095631270, 0, 1132920832, 1118829216, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3293352068, 1169526684, 1095631270, 0, 1132920832, 1123023212, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3293274738, 1169528513, 1095631270, 0, 1132920832, 1116732016, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3293245824, 1169551550, 1095631270, 0, 1132920832, 1119091120, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3293282774, 1169573647, 1095631270, 0, 1132920832, 1122236272, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3293366484, 1169572129, 1095631270, 0, 1132920832, 1115944744, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3293324500, 1169593620, 1095631270, 0, 1132920832, 1119089864, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3293284715, 1169549949, 1095631270, 0, 1132920832, 1122498888, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3293365517, 1169549445, 1095631270, 0, 1132920832, 1115157344, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3293323415, 1169571143, 1095631270, 0, 1132920832, 1119089856, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3293215455, 1169482339, 1095631270, 0, 1132920832, 1119354876, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3293221664, 1169505358, 1095631270, 0, 1132920832, 1119354816, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3293234523, 1169528885, 1095631270, 0, 1132920832, 1119879068, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3293453923, 1170013398, 1095657484, 0, 1132920832, 1119351860, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3293486365, 1170034542, 1095657484, 0, 1132920832, 1121710464, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3293518799, 1170056612, 1095657484, 0, 1132920832, 1119088432, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3293459883, 1170036341, 1095657484, 0, 1132920832, 1119350544, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3293466699, 1170059669, 1095657484, 0, 1132920832, 1119350496, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3293966035, 1170003696, 1095657484, 0, 1132920832, 1119351160, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3293944220, 1170026120, 1095657484, 0, 1132920832, 1116991152, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3293971387, 1170025924, 1095657484, 0, 1132920832, 1119350328, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3293920932, 1170047783, 1095657484, 0, 1132920832, 1119349776, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3293978406, 1170049205, 1095657484, 0, 1132920832, 1119349776, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3293985010, 1170071233, 1095657484, 0, 1132920832, 1119349776, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3293451696, 1170004126, 1095657484, 0, 1132920832, 1119349776, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3438, 3294366698, 1169944938, 1104058329, 0, 0, 1135214592, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3292160767, 1169383732, 1061662224, 0, 0, 1124204544, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17030, 3292315498, 1169470246, 3216283040, 0, 0, 1125384192, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17031, 3293393801, 1169691345, 3270745966, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17031, 3292398992, 1169540027, 1082235286, 0, 0, 1127874560, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3292323786, 1169608320, 1061662224, 0, 0, 1123286480, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(16133, 3292475016, 1169718616, 3208642560, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3292513472, 1169828770, 1061662224, 0, 0, 1123286016, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(16133, 3292652632, 1169925037, 3208642560, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3276743550, 1173140052, 0, 0, 0, 1122597884, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3293204335, 1170093699, 1061662224, 0, 0, 1121712572, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3294477392, 1170086624, 1061662224, 0, 0, 1133903272, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(16133, 3294427045, 1169985215, 3208642560, 0, 0, 1126957056, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3294456016, 1169889042, 1061662224, 0, 0, 1133903272, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(16133, 3294295588, 1169795727, 3208642560, 0, 0, 1126956824, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3294308974, 1169704389, 1061662224, 0, 0, 1133772200, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(16133, 3294268776, 1169595985, 3208642560, 0, 0, 1126956824, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3294368314, 1169486763, 1061662224, 0, 0, 1133772052, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(16133, 3294210256, 1169396788, 3208642560, 0, 0, 1126956824, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3294613580, 1169406816, 1097691298, 0, 0, 1134820628, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3292708735, 1169356541, 1085255187, 0, 1134690304, 1134427337, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3293149738, 1169340870, 1061662224, 0, 0, 1112538008, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3293470407, 1170070051, 1095657484, 0, 1132920832, 1119350496, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8397, 3292250797, 1169626262, 1097863591, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8397, 3288915216, 1171139468, 1117624788, 0, 1127480984, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8397, 3288342698, 1171138352, 1117739483, 0, 1129315992, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8397, 3289526258, 1171140219, 1117805013, 0, 1125514816, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8397, 3288901079, 1171190361, 3257548023, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8397, 3289044028, 1171217087, 3257548023, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8397, 3288921398, 1171221968, 3257548023, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8397, 3288726614, 1171197070, 3257548023, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8397, 3288669032, 1171238098, 3257548023, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8397, 3288816162, 1171211499, 3257548023, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8397, 3289019202, 1171172932, 3257548023, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8397, 3288848286, 1171170752, 3257548023, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8397, 3288817548, 1171186704, 3257548023, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8397, 3289013106, 1171200102, 3257548023, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3288920691, 1171660971, 1108144239, 1102675520, 0, 1127480984, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3438, 3292775228, 1169963707, 1103035973, 0, 0, 1129709528, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 1129829504, 1170779338, 1100447903, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 1132595328, 1170779338, 1117297676, 1132414420, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 1132629312, 1170779338, 1116626803, 1132652732, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 1132643936, 1170779338, 1115944804, 1132867212, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 1132639072, 1170779338, 1114836287, 1133081692, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 1132614720, 1170779338, 1113481201, 1133296174, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 1132571220, 1170779338, 1112157158, 1133510655, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 1132509134, 1170779338, 1110881422, 1133725136, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 1132396470, 1170779338, 1109670614, 1133939617, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 1132203288, 1170779338, 1108540530, 1134154098, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 1131979158, 1170779338, 1107505893, 1134368579, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 1131727006, 1170779338, 1105864139, 1134583060, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 1131450117, 1170779338, 1104254755, 1134797541, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 1131152100, 1170779338, 1102908367, 1135012022, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 1130836842, 1170779338, 1101842527, 1135226503, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 1130508416, 1170779338, 1101071125, 1135440832, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 1130171200, 1170779338, 1100604223, 1135655392, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 1129629546, 1170684282, 1115777683, 1133128038, 0, 1121452032, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 1129629504, 1170684282, 1115777683, 1133128038, 0, 1121452032, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 1129575284, 1170683731, 1114520638, 1133342519, 0, 1121452032, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 1129484790, 1170682812, 1113205593, 1133557000, 0, 1121452032, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 1129359244, 1170681537, 1111942500, 1133771481, 0, 1121452032, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 1129200283, 1170679923, 1110747831, 1133985962, 0, 1121452032, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 1129009980, 1170677991, 1109637164, 1134200443, 0, 1121452032, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 1128790813, 1170675765, 1108624970, 1134414924, 0, 1121452032, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 1128545643, 1170673276, 1107724452, 1134629405, 0, 1121452032, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 1128277663, 1170670555, 1106598428, 1134843886, 0, 1121452032, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 1127990369, 1170667638, 1105311300, 1135058367, 0, 1121452032, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 1127687504, 1170664563, 1104308032, 1135272848, 0, 1121452032, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 1127373017, 1170661370, 1103601708, 1135487329, 0, 1121452032, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 1127051010, 1170658100, 1103201540, 1135701810, 0, 1121452032, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 1126725677, 1170654797, 1103112738, 1135916291, 0, 1121452032, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 1126401263, 1170651503, 1103336462, 1136130772, 0, 1121452032, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 1126081994, 1170648261, 1103869798, 1136345253, 0, 1121452032, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 1125772034, 1170645114, 1104705794, 1136559734, 0, 1121452032, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 1125475424, 1170642102, 1105833542, 1136774215, 0, 1121452032, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 1125196029, 1170639265, 1107238352, 1136988696, 0, 1121452032, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 1124937493, 1170636640, 1108099078, 1137203177, 0, 1121452032, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 1124703186, 1170634261, 1109049383, 1137417658, 0, 1121452032, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 1124496162, 1170632159, 1110105824, 1137632139, 0, 1121452032, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 1124319104, 1170630360, 1111254636, 1114720288, 0, 1121451456, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3292927072, 1170012008, 1061662224, 0, 0, 1124859104, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3276738968, 1173054214, 1040187391, 0, 0, 1122597696, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3276734386, 1172968376, 1048575999, 0, 0, 1122597508, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3276729804, 1172882538, 1052770303, 0, 0, 1122597320, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3276725222, 1172796700, 1056964607, 0, 0, 1122597132, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3276720640, 1172710862, 1059061759, 0, 0, 1122596944, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3276716058, 1172625024, 1061158911, 0, 0, 1122596756, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3276711476, 1172539186, 1063256063, 0, 0, 1122596568, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3276706894, 1172453348, 1065353215, 0, 0, 1122596380, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3276702312, 1172367510, 1066401791, 0, 0, 1122596192, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3276697728, 1172281672, 1067450367, 0, 0, 1122595536, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3276693120, 1172195834, 1068498943, 0, 0, 1122595536, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3276688512, 1172109996, 1069547519, 0, 0, 1122595536, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3276683904, 1172024158, 1070596095, 0, 0, 1122595536, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3276679296, 1171938320, 1071644671, 0, 0, 1122595536, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3276674688, 1171852482, 1072693247, 0, 0, 1122595536, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3276670080, 1171766644, 1073741823, 0, 0, 1122595536, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3276665472, 1171680806, 1074266112, 0, 0, 1122595536, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3276660864, 1171594968, 1074790400, 0, 0, 1122595536, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3276656256, 1171509130, 1075314688, 0, 0, 1122595536, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3276651648, 1171423292, 1075838976, 0, 0, 1122594816, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3276647040, 1171337454, 1076363264, 0, 0, 1122594816, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3276642432, 1171251616, 1076887552, 0, 0, 1122594820, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3276637824, 1171165778, 1077411840, 0, 0, 1122594820, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3276633216, 1171079940, 1077936128, 0, 0, 1122594820, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3276628608, 1170994102, 1078460416, 0, 0, 1122594820, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3276624000, 1170908264, 1078984704, 0, 0, 1122594820, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3280806347, 1173128921, 1040187391, 0, 0, 1133862608, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3280830398, 1173041958, 1040187391, 0, 0, 1133862592, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3280854449, 1172954995, 1040187391, 0, 0, 1133862576, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3280878500, 1172868032, 1040187391, 0, 0, 1133862560, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3280902551, 1172781069, 1040187391, 0, 0, 1133862544, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3280926602, 1172694106, 1040187391, 0, 0, 1133862528, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3280950624, 1172607142, 1040187391, 0, 0, 1133862412, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3281234112, 1172516696, 1040187391, 0, 0, 1133665672, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3280998755, 1172433217, 1040187391, 0, 0, 1133862480, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3281022806, 1172346254, 1040187391, 0, 0, 1133862464, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3281046857, 1172259291, 1040187391, 0, 0, 1133862448, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3281070908, 1172172328, 1040187391, 0, 0, 1133862432, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3281094959, 1172085365, 1040187391, 0, 0, 1133862416, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3281119010, 1171998402, 1040187391, 0, 0, 1133862400, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3281143061, 1171911439, 1040187391, 0, 0, 1133862384, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3281167104, 1171824476, 1040187391, 0, 0, 1133862232, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3281191163, 1171737513, 1040187391, 0, 0, 1133862352, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3281215214, 1171650550, 1040187391, 0, 0, 1133862336, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3281239265, 1171563587, 1040187391, 0, 0, 1133862320, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3281263316, 1171476624, 1040187391, 0, 0, 1133862304, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3281287367, 1171389661, 1040187391, 0, 0, 1133862288, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3281311418, 1171302698, 1040187391, 0, 0, 1133862272, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3281335469, 1171215735, 1040187391, 0, 0, 1133862256, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3281359520, 1171128772, 1040187391, 0, 0, 1133862240, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3281383571, 1171041809, 1040187391, 0, 0, 1133862224, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3281407622, 1170954846, 1040187391, 0, 0, 1133862208, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3281431673, 1170867883, 1040187391, 0, 0, 1133862192, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3281135480, 1170780144, 1040187391, 0, 0, 1135238308, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3279225387, 1170739469, 1040187391, 0, 0, 1103478912, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3276927223, 1170820925, 1078984704, 0, 0, 1122594816, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3275052988, 1171058191, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3275727980, 1170868896, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3275727852, 1171013812, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3275738547, 1171099278, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3275632137, 1171140098, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3275429958, 1171217656, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3275446315, 1171314597, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3275305645, 1171396519, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3276070240, 1171557915, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3275488558, 1171627405, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3275896863, 1171842157, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3275909632, 1171953905, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3275924634, 1172125776, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3275883144, 1172199486, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3275860094, 1172240436, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3275760981, 1172416521, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3275705661, 1172514801, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3275632880, 1172652414, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3275612571, 1172783486, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3275597977, 1172877694, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3275591632, 1172918654, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3275568154, 1173070206, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3275405144, 1173167600, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3274016400, 1173198039, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3270468359, 1173227810, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3281630343, 1173147645, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3282480735, 1173196137, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3281473108, 1173041187, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3281437216, 1172971336, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3281454832, 1172922196, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3281501952, 1172790747, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3281611283, 1172646715, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3281614301, 1172435519, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3281598229, 1172193895, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3281684469, 1172019291, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3281718965, 1171974290, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3281838097, 1171743652, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3281848225, 1171678116, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3281870380, 1171534756, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3281878609, 1171481508, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3281919829, 1171320032, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3282237697, 1171075866, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3282091189, 1170965789, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3282433379, 1170820084, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3283292097, 1170998564, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3283826785, 1171154488, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3283945131, 1171419443, 1055222880, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3283816275, 1171753140, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3282835830, 1172228091, 1083579860, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3283078205, 1172730639, 1085381552, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3292197084, 1169899487, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3292233975, 1169842619, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3292185755, 1169688976, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3292003359, 1169510047, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3291919253, 1169441373, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3294615119, 1169466170, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3295178601, 1169432752, 1077801808, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3294579603, 1169663376, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3294758427, 1169793462, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3294859986, 1169902146, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3294878494, 1170004246, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3294849129, 1170121803, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8397, 3292250320, 1169536558, 1072245984, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8397, 3294500525, 1169597661, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8397, 3294697113, 1169969140, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8397, 3292783651, 1170009841, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8397, 3293498208, 1169325343, 1093254607, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8397, 3294135480, 1169309430, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8397, 3292299927, 1169785255, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8397, 3294754978, 1169735496, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3293165917, 1170019978, 1090882579, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3292778316, 1169863806, 1091033289, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3292581304, 1169623878, 1088377456, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3294261480, 1169526912, 1083814194, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3294111205, 1169577424, 1089264840, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3294105312, 1169690794, 1088961334, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3294285329, 1169811444, 1095364574, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3294337854, 1169931562, 1083977336, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3294250600, 1170092910, 1084888152, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3293231857, 1170140949, 1102760238, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3292382790, 1170205315, 1109910590, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3292586072, 1170205246, 1109910590, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3289066463, 1170715336, 1091452064, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3288794080, 1170713896, 1091425850, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3288688742, 1172038052, 1115836351, 0, 1134755840, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3288679792, 1172076693, 1115836351, 0, 1134755752, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3288670842, 1172115334, 1115836351, 0, 1134755664, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3288661892, 1172153975, 1115836351, 0, 1134755576, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3288652942, 1172192616, 1115836351, 0, 1134755488, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3288643992, 1172231257, 1115836351, 0, 1134755400, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3288635042, 1172269898, 1115836351, 0, 1134755312, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3288626092, 1172308539, 1115836351, 0, 1134755224, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3288617142, 1172347180, 1115836351, 0, 1134755136, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3288608192, 1172385821, 1115836351, 0, 1134755048, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3288599242, 1172424462, 1115836351, 0, 1134754960, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3288687525, 1172459994, 1115836351, 0, 1134754852, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3288687870, 1172505257, 1115836351, 0, 1134754852, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3288688215, 1172550520, 1115836351, 0, 1134754852, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3288688560, 1172595783, 1115836351, 0, 1134754852, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3288688905, 1172641046, 1115836351, 0, 1134754852, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3288689250, 1172686309, 1115836351, 0, 1134754852, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3288689595, 1172731572, 1115836351, 0, 1134754852, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3288689940, 1172776835, 1115836351, 0, 1134754852, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3288690285, 1172822098, 1115836351, 0, 1134754852, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3288690630, 1172867361, 1115836351, 0, 1134754852, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3288690975, 1172912624, 1115836351, 0, 1134754852, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3288691320, 1172957887, 1115836351, 0, 1134754852, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3288691665, 1173003150, 1115836351, 0, 1134754852, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3288692010, 1173048413, 1115836351, 0, 1134754852, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3288692355, 1173093676, 1115836351, 0, 1134754852, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3288692700, 1173138939, 1115836351, 0, 1134754852, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3288693045, 1173184202, 1115836351, 0, 1134754852, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3288693390, 1173229465, 1115836351, 0, 1134754852, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3288693735, 1173274728, 1115836351, 0, 1134754852, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3288694080, 1173319991, 1115836351, 0, 1134754852, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3288694416, 1173365254, 1115836351, 0, 1134754852, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3288694768, 1173410516, 1115836351, 0, 1134754852, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3288695120, 1173455778, 1115836351, 0, 1134754852, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3288695472, 1173501040, 1115836351, 0, 1134754852, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3288695824, 1173546302, 1115836351, 0, 1134754852, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3288696176, 1173591564, 1115836351, 0, 1134754852, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3288696528, 1173636826, 1115836351, 0, 1134754852, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3288696880, 1173682088, 1115836351, 0, 1134754852, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3288697232, 1173727350, 1115836351, 0, 1134754852, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3288697584, 1173772612, 1115836351, 0, 1134754852, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3288697936, 1173817874, 1115836351, 0, 1134754852, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3288698288, 1173863136, 1115836351, 0, 1134754852, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3289112164, 1173803483, 1115806858, 0, 1106231872, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3289110993, 1173772942, 1115806858, 0, 1106229440, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3289109822, 1173742401, 1115806858, 0, 1106227008, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3289108651, 1173711860, 1115806858, 0, 1106224576, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3289107480, 1173681319, 1115806858, 0, 1106222144, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3289106309, 1173650778, 1115806858, 0, 1106219712, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3289105138, 1173620237, 1115806858, 0, 1106217280, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3289103967, 1173589696, 1115806858, 0, 1106214848, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3289102796, 1173559155, 1115806858, 0, 1106212416, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3289101625, 1173528614, 1115806858, 0, 1106209984, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3289100454, 1173498073, 1115806858, 0, 1106207552, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3289099283, 1173467532, 1115806858, 0, 1106205120, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3289098112, 1173436991, 1115806858, 0, 1106202688, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3289096941, 1173406450, 1115806858, 0, 1106200256, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3289095770, 1173375909, 1115806858, 0, 1106197824, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3289094599, 1173345368, 1115806858, 0, 1106195392, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3289093428, 1173314827, 1115806858, 0, 1106192960, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3289092257, 1173284286, 1115806858, 0, 1106190528, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3289091086, 1173253745, 1115806858, 0, 1106188096, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3289089915, 1173223204, 1115806858, 0, 1106185664, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3289088744, 1173192663, 1115806858, 0, 1106183232, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3289087573, 1173162122, 1115806858, 0, 1106180800, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3289086402, 1173131581, 1115806858, 0, 1106178368, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3289085231, 1173101040, 1115806858, 0, 1106175936, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3289084060, 1173070499, 1115806858, 0, 1106173504, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3289082889, 1173039958, 1115806858, 0, 1106171072, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3289081718, 1173009417, 1115806858, 0, 1106168640, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3289080547, 1172978876, 1115806858, 0, 1106166208, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3289079376, 1172948335, 1115806858, 0, 1106163776, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3289078205, 1172917794, 1115806858, 0, 1106161344, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3289077034, 1172887253, 1115806858, 0, 1106158912, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3289075856, 1172856712, 1115806858, 0, 1106154560, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3289113375, 1172820436, 1115806858, 0, 1106154560, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3289113959, 1172780781, 1115806858, 0, 1106154560, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3289114543, 1172741126, 1115806858, 0, 1106154560, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3289115127, 1172701471, 1115806858, 0, 1106154560, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3289115711, 1172661816, 1115806858, 0, 1106154560, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3289116295, 1172622161, 1115806858, 0, 1106154560, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3289116879, 1172582506, 1115806858, 0, 1106154560, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3289117463, 1172542851, 1115806858, 0, 1106154560, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3289118047, 1172503196, 1115806858, 0, 1106154560, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3289118631, 1172463541, 1115806858, 0, 1106154560, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3289119200, 1172423886, 1115806858, 0, 1106151680, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3289119792, 1172384230, 1115806858, 0, 1106151680, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3289120384, 1172344574, 1115806858, 0, 1106151680, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3289120976, 1172304918, 1115806858, 0, 1106151680, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3289121568, 1172265262, 1115806858, 0, 1106151680, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3289122160, 1172225606, 1115806858, 0, 1106151680, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3289122752, 1172185950, 1115806858, 0, 1106151680, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3289123344, 1172146294, 1115806858, 0, 1106151680, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3289123936, 1172106638, 1115806858, 0, 1106151680, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3289124528, 1172066982, 1115806858, 0, 1106151680, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3289125120, 1172027326, 1115806858, 0, 1106151680, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3276624000, 1170908264, 1078984704, 0, 0, 1122594816, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(4569, 3260034236, 1170588957, 1096904866, 0, 0, 1132920832, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(4569, 1108139256, 1170589159, 1096904866, 0, 0, 1132920832, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(4569, 1122283772, 1170571196, 1096904866, 0, 0, 1132068864, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(4569, 3260275207, 1170906269, 1096904866, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(4569, 1106506294, 1170906488, 1096878652, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(4569, 1122231838, 1170906707, 1096852438, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(4569, 1128622040, 1170906926, 1096826224, 0, 0, 1119092736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(4569, 1132951872, 1170837376, 1096800010, 0, 0, 1109917696, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(4569, 1133339435, 1170758841, 1096800010, 0, 0, 1135673188, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(979, 1123915803, 1170660652, 1112137955, 0, 0, 1133477888, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(979, 1124178898, 1170644414, 1112137955, 0, 0, 1133576056, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(978, 1124635149, 1170599961, 1112075455, 0, 0, 1133477888, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(978, 1124499558, 1170613450, 1112075455, 0, 0, 1133477752, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3291725852, 1170375962, 1061662224, 0, 0, 1132658432, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3291294777, 1170454756, 1061662224, 0, 0, 1132658392, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3290719279, 1170499842, 1061662224, 0, 0, 1130626480, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3289901793, 1170504304, 1061662224, 0, 0, 1129053440, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3289287216, 1170462679, 1061662224, 0, 0, 1126562736, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3288501776, 1170404600, 1061662224, 0, 0, 1126562624, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3288435994, 1170305292, 1061662224, 0, 0, 1120925312, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3289065692, 1170231637, 1061662224, 0, 0, 1110961056, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3289921236, 1170219435, 1061662224, 0, 0, 1106236032, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3290724714, 1170255758, 1061662224, 0, 0, 1090469120, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3291601435, 1170293252, 1061662224, 0, 0, 1082030080, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3289778018, 1170570430, 1061662224, 0, 0, 1133575640, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3289733818, 1170665856, 1061662224, 0, 0, 1133575492, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3289528524, 1170757181, 1061662224, 0, 0, 1133116740, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3289484086, 1170845012, 1061662224, 0, 0, 1133640960, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3289454211, 1170931550, 1061662224, 0, 0, 1133640832, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3289646986, 1171000948, 1061662224, 0, 0, 1134492800, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3288481200, 1170463270, 1061662224, 0, 0, 1120400656, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3288346957, 1170553936, 1061662224, 0, 0, 1123021696, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3288393211, 1170651283, 1061662224, 0, 0, 1123021056, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3288459069, 1170718287, 1061662224, 0, 0, 1121186048, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3288453663, 1170791539, 1061662224, 0, 0, 1121185776, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3288440923, 1170875828, 1061662224, 0, 0, 1121185776, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3288390720, 1170951572, 1061662224, 0, 0, 1118826336, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3288887898, 1171043786, 1114405599, 0, 0, 1129052152, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3288672470, 1170749104, 1088748702, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3288679131, 1170781897, 1088355658, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3288659093, 1170831663, 1090741910, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3288670143, 1170902489, 1087617198, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3288634304, 1170943872, 1088874722, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3289239440, 1170939617, 1087542478, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3289175317, 1170891528, 1089713170, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3289275755, 1170821917, 1089921352, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3289322120, 1170732295, 1083025555, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3289518772, 1170621845, 1089986210, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3289539122, 1170679345, 1089961082, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3506, 3289528891, 1170537842, 1088521048, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3534, 3289583863, 1170556918, 1086489566, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3534, 3289562043, 1170584215, 1091118837, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3534, 3289580722, 1170642617, 1092866683, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3534, 3289388325, 1170718160, 1092026575, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3534, 3289253447, 1170882377, 1088878425, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3534, 3288622245, 1170925697, 1099043261, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3534, 3288700217, 1170850094, 1086883238, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3534, 3288646475, 1170717806, 1089479398, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3534, 3288540638, 1170571296, 1092457821, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3534, 3288472296, 1170540010, 1091526911, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3534, 3289528018, 1170489577, 1102200797, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3534, 3289655714, 1170564454, 1102154597, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3534, 3289485988, 1170708034, 1101412383, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3534, 3289376666, 1170956925, 1102644487, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3534, 3289208887, 1170998268, 1096824350, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3534, 3288651725, 1170998700, 1096801056, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3534, 3289169425, 1171140488, 1099002434, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3534, 3288656141, 1171142329, 1099068525, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3534, 3289086183, 1171244184, 1094176651, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3534, 3288739499, 1171245557, 1094174803, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3534, 3289143520, 1171414568, 1094217655, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3534, 3288647983, 1171415229, 1094217655, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3534, 3289381748, 1171952321, 1115758172, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3534, 3288549318, 1171952868, 1115760760, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3534, 3279047474, 1173817397, 1116315357, 0, 1135738880, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3534, 3279545109, 1173598278, 1088463477, 0, 1135738732, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3534, 3279429440, 1173819900, 1115889371, 0, 1135738732, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3534, 3279407492, 1173599312, 1088463477, 0, 1135738732, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3534, 3279419449, 1173591653, 1088463477, 0, 1135738732, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3534, 3279259220, 1173597630, 1088463477, 0, 1135738732, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(18450, 3279520576, 1173210868, 1090702548, 0, 1127481340, 1132904092, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3534, 1124274318, 1170635697, 1112490067, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3534, 1124415791, 1170621334, 1112431081, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8499, 3270981152, 1173015546, 1104508264, 0, 0, 1133076480, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8499, 3274067607, 1172465137, 1104508264, 0, 0, 1133534992, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8499, 3272762137, 1172096070, 1104508264, 0, 0, 1133534992, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8499, 3272553287, 1171785862, 1104508264, 0, 0, 1133534992, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8499, 3272646345, 1171522950, 1104508264, 0, 0, 1133534992, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8499, 3272328487, 1171209658, 1104508264, 0, 0, 1133534992, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(10412, 3282310672, 1173018239, 1107800524, 0, 0, 1105199104, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(10412, 3282437966, 1172764742, 1107800524, 0, 0, 1105198400, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(10425, 3281881298, 1172550122, 1105737284, 0, 0, 1134559232, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(4016, 3271805088, 1172701282, 1097383718, 0, 0, 1132724224, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(7240, 3281333326, 1172483986, 3230524555, 0, 0, 1116733440, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(7240, 3282021024, 1172325638, 3213424066, 0, 0, 1130233544, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(7240, 3282152674, 1172167858, 3213424066, 0, 0, 1130233544, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(7240, 3282169117, 1172037364, 3213424066, 0, 0, 1130233544, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3175, 3280488394, 1171472711, 1091031200, 0, 0, 1112539136, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3598, 3282711772, 1171360128, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3598, 3281305224, 1171322122, 1100671348, 0, 0, 1132724224, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3606, 3279980375, 1170760744, 1112359258, 0, 0, 1127350272, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3265436507, 1170851765, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3255993554, 1170837129, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 1095559133, 1170838375, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 1117114287, 1170841207, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 1126098862, 1170840577, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 1128851353, 1170840262, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 1128651217, 1170712604, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 1123391737, 1170691275, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 1102093648, 1170675795, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3252122738, 1170680876, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3264943876, 1170693747, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3272184261, 1170721319, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 1115418215, 1170687469, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3280497491, 1172565143, 3246750432, 0, 0, 1133665672, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3280465595, 1172476195, 3246750432, 0, 0, 1133665672, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8499, 3287647090, 1171893593, 1104508264, 0, 0, 1134845712, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8499, 3287093985, 1171625069, 1104508264, 0, 0, 1133076100, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8499, 3289882558, 1171603746, 1104508264, 0, 0, 1123383388, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8499, 3290087751, 1171868388, 1104508264, 0, 0, 1123383216, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8499, 3287729062, 1171384949, 1104508264, 0, 0, 1133862424, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8499, 3289742920, 1171329518, 1104508264, 0, 0, 1123383216, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(4564, 3289455260, 1174084609, 1120248684, 0, 0, 1135083436, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(4564, 3288944723, 1174175414, 1120248684, 0, 0, 1134296920, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(4564, 3288119259, 1174235507, 1120248684, 0, 0, 1133903536, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(4564, 3286319046, 1174281374, 1120248684, 0, 0, 1133444700, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(4564, 3284692575, 1174296465, 1120248684, 0, 0, 1133051416, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(4564, 3283067534, 1174278006, 1120248684, 0, 0, 1132460936, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(4564, 3281423868, 1174241447, 1120248684, 0, 0, 1131805504, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(4564, 3279516883, 1174177215, 1120248684, 0, 0, 1130887799, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(4564, 3276809987, 1174086269, 1120248684, 0, 0, 1129839087, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(4564, 3275061988, 1173974989, 1120248684, 0, 0, 1128659337, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(4564, 3274297565, 1173856501, 1120248684, 0, 0, 1127872832, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(4564, 3276317326, 1173745614, 1120248684, 0, 0, 1127217304, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(4564, 3276500625, 1173665437, 1120248684, 0, 0, 1127217104, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(4564, 3280573827, 1173768248, 1120248684, 0, 0, 1127217104, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(4564, 3280708308, 1173643592, 1120248684, 0, 0, 1127217104, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3598, 3281306796, 1171322096, 1102763250, 0, 0, 1132724092, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8663, 3290952892, 1170840067, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8663, 3286167676, 1170845714, 1104344513, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8663, 3286096225, 1170669683, 1104318299, 0, 0, 1118830592, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8663, 3290872732, 1170714368, 1104318299, 0, 0, 1118829936, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8663, 3290829072, 1170633104, 1104292085, 0, 0, 1098897792, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(12857, 3288828864, 1170600047, 1087268448, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(12857, 3289130683, 1170601823, 1087268448, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(9076, 1133776614, 1170782438, 1119449916, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3288651953, 1170561240, 1089785880, 0, 1132920832, 1119088336, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3293846963, 1169738188, 1095657484, 0, 1132920832, 1119120452, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3293327824, 1169737760, 1095657484, 0, 1132920832, 1119087696, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3288651586, 1170583252, 1089785880, 0, 1132920832, 1119087696, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3288651410, 1170606028, 1089785880, 0, 1132920832, 1119087696, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3288651092, 1170629144, 1089785880, 0, 1132920832, 1119087696, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3288667244, 1170652333, 1089785880, 0, 1132920832, 1120398388, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3288698859, 1170675287, 1089785880, 0, 1132920832, 1120398096, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3288731376, 1170698488, 1089785880, 0, 1132920832, 1120398096, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3289240405, 1170652095, 1089785880, 0, 1132920832, 1116990176, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3289265986, 1170561524, 1089785880, 0, 1132920832, 1119087696, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3289266227, 1170584293, 1089785880, 0, 1132920832, 1119087696, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3289266453, 1170605896, 1089785880, 0, 1132920832, 1119087696, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3289266588, 1170628832, 1089785880, 0, 1132920832, 1119087696, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3289189208, 1170674570, 1089785880, 0, 1132920832, 1116989616, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3289141890, 1170695393, 1089785880, 0, 1132920832, 1116989616, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3289117468, 1170705994, 1089785880, 0, 1132920832, 1116989616, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3288738816, 1170704161, 1089785880, 0, 1132920832, 1120398096, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(17029, 3293937944, 1169322428, 1061662224, 0, 0, 1104146752, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3458, 3288897729, 1170752898, 1089179636, 0, 0, 1132920472, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3288862342, 1170726538, 1089785880, 0, 1132920832, 1119087336, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3289009706, 1170727261, 1089785880, 0, 1132920832, 1119086976, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3289114970, 1170999012, 1093770036, 1119092736, 1132920832, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3288778341, 1170999016, 1093770036, 1119092736, 1132920832, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3288956592, 1170999056, 1093770036, 1119092736, 1132920832, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3288915052, 1171136497, 1110621295, 0, 1127349944, 1119092016, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3437, 3288914896, 1171137160, 1108032605, 0, 1127349944, 1119092016, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3472, 3294447590, 1169979287, 1101499284, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3472, 3292594312, 1169527674, 1093686142, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(3472, 3294130800, 1169428808, 1096058526, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3294791848, 1169526406, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3287723212, 1170690471, 1096047062, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3287825400, 1170589212, 1096047062, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3287862417, 1170943097, 1096099490, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3289866414, 1170966584, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3290266266, 1170853722, 1082534464, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3289850522, 1170732106, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3289638872, 1171534569, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3289930631, 1171609338, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3289450620, 1171715631, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3289480880, 1171826555, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3288471161, 1171847292, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3288435462, 1171637677, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3287291328, 1171621633, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3287641879, 1171757129, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3287716244, 1171391352, 0, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(689, 3288252273, 1170862438, 1096821268, 0, 0, 0, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateDynamicObject(8397, 3279428333, 1173551783, 1110203432, 0, 1113063424, 1118994432, 4294967295, 4294967295, 4294967295, 1128792064);
	CreateObject(18752, -3356.93, -422.43, 0.0799, 0.0, 0.0, 0.0, 0);
	
	
	CreateDynamicObject(5710,-2301.237793,-1648.487549,488.158997,0,0,157.4999); 			/*바위산 옵젝*/
	CreateDynamicObject(615,-2301.466064,-1630.676147,482.718231,0,0,0); // object (9)
	CreateDynamicObject(615,-2312.841064,-1662.750488,482.197510,0,0,0); // object (10)
	CreateDynamicObject(12921,-2303.241455,-1647.302490,496.125427,0,0,247.5); // object (11)
	CreateDynamicObject(14637,-2303.128174,-1647.432861,486.548523,0,0,157.5); // object (12)
	CreateDynamicObject(13831,-2378.961182,-1618.419556,503.240234,0,0,78.7499); // object (14)
	CreateDynamicObject(14781,-2298.232910,-1649.364746,494.796234,0,0,247.5); // object (15)
	CreateDynamicObject(955,-2308.403320,-1653.374268,485.022125,0,0,247.5); // object (16)
	CreateDynamicObject(14877,-2303.701172,-1668.682373,492.032471,0,0,337.5); // object (17)
	CreateDynamicObject(14411,-2307.076904,-1667.044067,493.123749,0,0,247.5); // object (20)
	CreateDynamicObject(14411,-2299.171875,-1670.602661,497.278473,0,0,247.5); // object (21)
	CreateDynamicObject(14411,-2305.265869,-1667.908081,495.497681,0,0,247.5); // object (22)
	CreateDynamicObject(14411,-2301.872070,-1671.229492,500.712158,0,0,247.5); // object (23)
	CreateDynamicObject(16778,-2298.245850,-1635.242065,489.685760,0,0,0); // object (25)
	CreateDynamicObject(16776,-2306.491943,-1621.714966,484.557190,0,0,337.5); // object (26)
	CreateDynamicObject(14608,-2318.759766,-1617.054932,485.017975,0,0,22.5); // object (27)
	CreateDynamicObject(9833,-2318.342041,-1654.148193,485.905670,0,0,0); // object (30)
	
	
	CreateDynamicObject(1632,2044.607422,1010.774658,10.971987,0,0,0);     /*개념없는 점프*/
	CreateDynamicObject(1632,2044.657593,1015.100830,12.354767,0,0,0);
	CreateDynamicObject(1632,2044.511475,1019.366516,13.849375,0,0,0);
	CreateDynamicObject(7392,2036.606934,1034.900513,19.540386,0,0,270);
	CreateDynamicObject(1632,2043.730957,1060.922729,10.971987,0,0,180);
	CreateDynamicObject(1632,2043.956177,1056.595947,12.353607,0,0,180);
	CreateDynamicObject(1632,2044.021606,1051.983765,13.207802,0,0,180);
	
	
	CreateObject(987, 734.5374, -2564.202, 6.5678, 0.0, 0.0, 4230.0);       /*프리즌브레이크 교도소*/
	CreateObject(985, 709.7344, -2468.2354, 9.2535, 0.0, 0.0, 0.0);
	CreateObject(986, 729.9488, -2555.0213, 9.4683, 0.0, 0.0, 0.0);
	CreateObject(986, 724.013, -2531.1636, 9.883, 0.0, 0.0, 0.0);
	CreateObject(985, 724.2601, -2657.7708, 9.883, 0.0, 0.0, 0.0);
	CreateObject(987, 681.6877, -2650.8079, 8.3377, 0.0, 0.0, 180.0);
	CreateObject(971, 679.3254, -2667.9581, 8.4903, 0.0, 0.0, 0.0);
	CreateObject(971, 683.6927, -2667.9581, 8.5951, 0.0, 0.0, 0.0);
	CreateObject(971, 670.4073, -2667.9581, 8.879, 0.0, 0.0, 0.0);
	CreateObject(971, 666.1788, -2667.9581, 9.0373, 0.0, 0.0, 0.0);
	CreateObject(971, 657.3155, -2667.9581, 8.627, 0.0, 0.0, 0.0);
	CreateObject(971, 683.6937, -2674.545, 13.8823, 0.0, 0.0, 0.0);
	CreateObject(971, 679.2763, -2674.545, 13.8823, 0.0, 0.0, 0.0);
	CreateObject(971, 670.478, -2674.545, 13.8823, 0.0, 0.0, 0.0);
	CreateObject(971, 666.1609, -2674.545, 13.8823, 0.0, 0.0, 0.0);
	CreateObject(971, 646.2224, -2683.3499, 13.8823, 0.0, 0.0, 0.0);
	CreateObject(971, 650.5965, -2683.3499, 13.8823, 0.0, 0.0, 0.0);
	CreateObject(971, 659.4892, -2683.3499, 13.8823, 0.0, 0.0, 0.0);
	CreateObject(971, 663.9434, -2683.3499, 13.8823, 0.0, 0.0, 0.0);
	CreateObject(971, 672.7721, -2683.3499, 13.8823, 0.0, 0.0, 0.0);
	CreateDynamicObject(971, 677.0804, -2683.3499, 13.8823, 0.0, 0.0, 0.0);
	CreateDynamicObject(971, 685.9853, -2683.3499, 13.8823, 0.0, 0.0, 0.0);
	CreateDynamicObject(3997, 721.0, -2615.0042, 8.883, 0.0, 0.0, 0.0);
	CreateDynamicObject(3997, 721.0, -2734.9544, 8.883, 0.0, 0.0, 0.0);
	CreateDynamicObject(3997, 721.0, -2495.0958, 8.883, 0.0, 0.0, 0.0);
	CreateDynamicObject(974, 684.8696, -2674.3082, 10.546, 0.0, 0.0, 0.0);
	CreateDynamicObject(974, 678.2429, -2674.3082, 10.546, 0.0, 0.0, 0.0);
	CreateDynamicObject(974, 671.5499, -2674.3082, 10.546, 0.0, 0.0, 0.0);
	CreateDynamicObject(974, 665.0108, -2674.3082, 10.546, 0.0, 0.0, 0.0);
	CreateDynamicObject(974, 658.3839, -2674.3082, 10.546, 0.0, 0.0, 0.0);
	CreateDynamicObject(974, 651.7605, -2674.3082, 10.546, 0.0, 0.0, 0.0);
	CreateDynamicObject(974, 645.1496, -2674.3082, 10.546, 0.0, 0.0, 0.0);
	CreateDynamicObject(974, 645.1496, -2681.6448, 13.3756, 90.0, 0.0, 0.0);
	CreateDynamicObject(974, 651.7605, -2681.6448, 13.3756, 90.0, 0.0, 0.0);
	CreateDynamicObject(974, 658.3839, -2681.6448, 13.3756, 90.0, 0.0, 0.0);
	CreateDynamicObject(974, 665.0108, -2681.6448, 13.3756, 90.0, 0.0, 0.0);
	CreateDynamicObject(974, 671.5499, -2681.6448, 13.3756, 90.0, 0.0, 0.0);
	CreateDynamicObject(974, 678.2429, -2681.6448, 13.3756, 90.0, 0.0, 0.0);
	CreateDynamicObject(974, 684.8696, -2681.6448, 13.3756, 90.0, 0.0, 0.0);
	CreateDynamicObject(974, 645.1496, -2687.1526, 13.3756, 90.0, 0.0, 0.0);
	CreateDynamicObject(974, 651.7605, -2687.1526, 13.3756, 90.0, 0.0, 0.0);
	CreateDynamicObject(974, 658.3839, -2687.1526, 13.3756, 90.0, 0.0, 0.0);
	CreateDynamicObject(974, 665.0108, -2687.1526, 13.3756, 90.0, 0.0, 0.0);
	CreateDynamicObject(974, 671.5499, -2687.1526, 13.3756, 90.0, 0.0, 0.0);
	CreateDynamicObject(974, 678.2429, -2687.1526, 13.3756, 90.0, 0.0, 0.0);
	CreateDynamicObject(974, 684.8696, -2687.1526, 13.3756, 90.0, 0.0, 0.0);
	CreateDynamicObject(974, 645.1496, -2676.1314, 13.3756, 90.0, 0.0, 0.0);
	CreateDynamicObject(974, 651.7605, -2676.1314, 13.3756, 90.0, 0.0, 0.0);
	CreateDynamicObject(974, 658.3839, -2676.1314, 13.3756, 90.0, 0.0, 0.0);
	CreateDynamicObject(974, 665.0108, -2676.1314, 13.3756, 90.0, 0.0, 0.0);
	CreateDynamicObject(974, 671.5499, -2676.1314, 13.3756, 90.0, 0.0, 0.0);
	CreateDynamicObject(974, 678.2429, -2676.1314, 13.3756, 90.0, 0.0, 0.0);
	CreateDynamicObject(974, 684.8696, -2676.1314, 13.3756, 90.0, 0.0, 0.0);
	CreateDynamicObject(974, 645.1496, -2670.6255, 13.3756, 90.0, 0.0, 0.0);
	CreateDynamicObject(974, 651.7605, -2670.6255, 13.3756, 90.0, 0.0, 0.0);
	CreateDynamicObject(974, 658.3839, -2670.6255, 13.3756, 90.0, 0.0, 0.0);
	CreateDynamicObject(974, 665.0108, -2670.6255, 13.3756, 90.0, 0.0, 0.0);
	CreateDynamicObject(974, 671.5499, -2670.6255, 13.3756, 90.0, 0.0, 0.0);
	CreateDynamicObject(974, 678.2429, -2670.6255, 13.3756, 90.0, 0.0, 0.0);
	CreateDynamicObject(974, 684.8696, -2670.6255, 13.3756, 90.0, 0.0, 0.0);
	CreateDynamicObject(974, 645.1496, -2689.908, 14.8246, 0.0, 0.0, 0.0);
	CreateDynamicObject(974, 651.7605, -2689.908, 14.8246, 0.0, 0.0, 0.0);
	CreateDynamicObject(974, 658.3839, -2689.908, 14.8246, 0.0, 0.0, 0.0);
	CreateDynamicObject(974, 665.0108, -2689.908, 14.8246, 0.0, 0.0, 0.0);
	CreateDynamicObject(974, 671.5499, -2689.908, 14.8246, 0.0, 0.0, 0.0);
	CreateDynamicObject(974, 678.2429, -2689.908, 14.8246, 0.0, 0.0, 0.0);
	CreateDynamicObject(974, 684.8696, -2689.908, 14.8246, 0.0, 0.0, 0.0);
	CreateDynamicObject(974, 688.2579, -2689.908, 9.3393, 0.0, 0.0, 0.0);
	CreateDynamicObject(974, 645.1496, -2667.8902, 10.59, 0.0, 0.0, 0.0);
	CreateDynamicObject(974, 651.7605, -2667.8902, 10.59, 0.0, 0.0, 0.0);
	CreateDynamicObject(974, 655.0, -2671.252, 10.59, 0.0, 0.0, 90.0);
	CreateDynamicObject(974, 655.0, -2677.917, 10.59, 0.0, 0.0, 90.0);
	CreateDynamicObject(974, 641.7495, -2686.5943, 14.8246, 0.0, 0.0, 1710.0);
	CreateDynamicObject(974, 641.7495, -2679.9222, 14.8246, 0.0, 0.0, 270.0);
	CreateDynamicObject(974, 641.7495, -2673.2701, 14.8246, 0.0, 0.0, 1710.0);
	CreateDynamicObject(974, 641.7495, -2666.6731, 14.8246, 0.0, 0.0, 270.0);
	CreateDynamicObject(974, 641.7495, -2666.6731, 9.3, 0.0, 0.0, 1710.0);
	CreateDynamicObject(974, 641.7495, -2660.0218, 14.8246, 0.0, 0.0, 270.0);
	CreateDynamicObject(974, 641.7495, -2660.0218, 9.3, 0.0, 0.0, 1710.0);
	CreateDynamicObject(974, 641.7495, -2654.0159, 14.8246, 0.0, 0.0, 270.0);
	CreateDynamicObject(974, 641.7495, -2654.0159, 9.3, 0.0, 0.0, 1710.0);
	CreateDynamicObject(974, 648.4457, -2686.5943, 14.8246, 0.0, 0.0, 90.0);
	CreateDynamicObject(974, 655.0278, -2686.5943, 14.8246, 0.0, 0.0, 90.0);
	CreateDynamicObject(974, 661.714, -2686.5943, 14.8246, 0.0, 0.0, 90.0);
	CreateDynamicObject(974, 668.388, -2686.5943, 14.8246, 0.0, 0.0, 90.0);
	CreateDynamicObject(974, 674.8565, -2686.5943, 14.8246, 0.0, 0.0, 90.0);
	CreateDynamicObject(974, 681.536, -2686.5943, 14.8246, 0.0, 0.0, 90.0);
	CreateDynamicObject(974, 661.714, -2671.2276, 14.8246, 0.0, 0.0, 270.0);
	CreateDynamicObject(974, 668.388, -2671.2276, 14.8246, 0.0, 0.0, 270.0);
	CreateDynamicObject(974, 674.8565, -2671.2276, 14.8246, 0.0, 0.0, 270.0);
	CreateDynamicObject(974, 681.536, -2671.2276, 14.8246, 0.0, 0.0, 270.0);
	CreateDynamicObject(974, 661.714, -2671.2276, 9.3318, 0.0, 0.0, 270.0);
	CreateDynamicObject(974, 668.388, -2671.2276, 9.3318, 0.0, 0.0, 270.0);
	CreateDynamicObject(974, 674.8565, -2671.2276, 9.3318, 0.0, 0.0, 270.0);
	CreateDynamicObject(974, 681.536, -2671.2276, 9.3318, 0.0, 0.0, 270.0);
	CreateDynamicObject(974, 661.714, -2677.8216, 10.5057, 0.0, 0.0, 630.0);
	CreateDynamicObject(974, 668.388, -2677.8216, 10.5057, 0.0, 0.0, 630.0);
	CreateDynamicObject(974, 674.8565, -2677.8216, 10.5057, 0.0, 0.0, 630.0);
	CreateDynamicObject(974, 681.536, -2677.8216, 10.5057, 0.0, 0.0, 630.0);
	CreateDynamicObject(974, 665.0763, -2667.8785, 14.8246, 0.0, 0.0, 0.0);
	CreateDynamicObject(974, 671.5668, -2667.8785, 14.8246, 0.0, 0.0, 0.0);
	CreateDynamicObject(974, 678.1908, -2667.8785, 14.8246, 0.0, 0.0, 0.0);
	CreateDynamicObject(974, 684.8042, -2667.8785, 14.8246, 0.0, 0.0, 0.0);
	CreateDynamicObject(974, 658.4139, -2667.8785, 14.8246, 0.0, 0.0, 0.0);
	CreateDynamicObject(974, 688.2005, -2677.9087, 14.8246, 0.0, 0.0, 450.0);
	CreateDynamicObject(974, 688.2005, -2671.1939, 14.8246, 0.0, 0.0, 90.0);
	CreateDynamicObject(974, 688.2005, -2677.9087, 10.5057, 0.0, 0.0, 450.0);
	CreateDynamicObject(974, 688.2005, -2671.1939, 10.5057, 0.0, 0.0, 90.0);
	CreateDynamicObject(974, 681.5192, -2667.8785, 9.3367, 0.0, 0.0, 0.0);
	CreateDynamicObject(974, 668.3394, -2667.8785, 9.3367, 0.0, 0.0, 0.0);
	CreateDynamicObject(974, 655.1084, -2667.8785, 9.3367, 0.0, 0.0, 0.0);
	CreateDynamicObject(974, 668.3713, -2674.5828, 14.8246, 0.0, 0.0, 0.0);
	CreateDynamicObject(974, 681.556, -2674.5828, 14.8246, 0.0, 0.0, 0.0);
	CreateDynamicObject(974, 648.4021, -2683.2835, 14.8246, 0.0, 0.0, 0.0);
	CreateDynamicObject(974, 661.6812, -2683.2835, 14.8246, 0.0, 0.0, 0.0);
	CreateDynamicObject(974, 674.8262, -2683.2835, 14.8246, 0.0, 0.0, 0.0);
	CreateDynamicObject(974, 688.2539, -2683.2835, 14.8246, 0.0, 0.0, 0.0);
	CreateDynamicObject(7488, 763.9121, -2769.2928, -10.3231, 0.0, 0.0, 0.0);
	CreateDynamicObject(7488, 691.6282, -2769.2928, -10.3231, 0.0, 0.0, 0.0);
	CreateDynamicObject(7488, 676.7743, -2769.2928, -10.3231, 0.0, 0.0, 0.0);
	CreateDynamicObject(7488, 775.4775, -2711.2256, -10.3231, 0.0, 0.0, 1530.0);
	CreateDynamicObject(7488, 775.4775, -2643.4459, -10.3231, 0.0, 0.0, 1530.0);
	CreateDynamicObject(7488, 775.4775, -2571.2515, -10.3231, 0.0, 0.0, 1530.0);
	CreateDynamicObject(7488, 775.4775, -2500.4324, -10.3231, 0.0, 0.0, 1530.0);
	CreateDynamicObject(7488, 775.4775, -2472.3191, -10.3231, 0.0, 0.0, 1530.0);
	CreateDynamicObject(7488, 718.1985, -2460.7537, -10.3231, 0.0, 0.0, 1620.0);
	CreateDynamicObject(7488, 678.0255, -2460.7537, -10.3231, 0.0, 0.0, 1620.0);
	CreateDynamicObject(7488, 666.4456, -2515.2247, -10.3231, 0.0, 0.0, 3870.0);
	CreateDynamicObject(7488, 666.4456, -2586.4578, -10.3231, 0.0, 0.0, 3870.0);
	CreateDynamicObject(7488, 666.4456, -2657.1541, -10.3231, 0.0, 0.0, 3870.0);
	CreateDynamicObject(7488, 666.4456, -2728.2083, -10.3231, 0.0, 0.0, 3870.0);
	CreateDynamicObject(7488, 666.4456, -2757.7276, -10.3231, 0.0, 0.0, 3870.0);
	CreateDynamicObject(987, 642.3908, -2602.9246, 8.77, 0.0, 0.0, 1350.0);
	CreateDynamicObject(987, 642.3908, -2614.8333, 8.77, 0.0, 0.0, 630.0);
	CreateDynamicObject(987, 642.3908, -2626.7474, 8.77, 0.0, 0.0, 1350.0);
	CreateDynamicObject(987, 642.3908, -2638.667, 8.77, 0.0, 0.0, 630.0);
	CreateDynamicObject(987, 787.8921, -2657.7688, 8.77, 0.0, 0.0, 0.0);
	CreateDynamicObject(987, 775.9395, -2657.7688, 8.77, 0.0, 0.0, 0.0);
	CreateDynamicObject(987, 764.005, -2657.7688, 8.77, 0.0, 0.0, 0.0);
	CreateDynamicObject(987, 752.0346, -2657.7688, 8.77, 0.0, 0.0, 0.0);
	CreateDynamicObject(987, 740.0587, -2657.7688, 8.77, 0.0, 0.0, 0.0);
	CreateDynamicObject(987, 728.1311, -2657.7688, 8.77, 0.0, 0.0, 0.0);
	CreateDynamicObject(7832, 675.7771, -2661.105, 13.4318, 0.0, 0.0, 270.0);
	CreateDynamicObject(8434, 702.56, -2687.7007, 13.7184, 0.0, 0.0, 2340.0);
	CreateDynamicObject(987, 708.3705, -2657.7688, 8.77, 0.0, 0.0, 0.0);
	CreateDynamicObject(8613, 646.909, -2663.782, 9.9786, 0.0, 0.0, 180.0);
	CreateDynamicObject(3753, 723.1219, -2427.4744, -1.3613, 0.0, 0.0, 0.0);
	CreateDynamicObject(1472, 714.2446, -2433.9368, 8.298, 0.0, 0.0, 1260.0);
	CreateDynamicObject(987, 749.4187, -2444.3062, 8.5699, 0.0, 0.0, 450.0);
	CreateDynamicObject(987, 749.4187, -2456.2613, 8.5699, 0.0, 0.0, 450.0);
	CreateDynamicObject(987, 749.4187, -2468.1771, 8.5699, 0.0, 0.0, 450.0);
	CreateDynamicObject(987, 737.5541, -2468.0943, 8.5699, 0.0, 0.0, 0.0);
	CreateDynamicObject(987, 725.6405, -2468.0943, 8.5699, 0.0, 0.0, 0.0);
	CreateDynamicObject(987, 713.684, -2468.0943, 8.5699, 0.0, 0.0, 0.0);
	CreateDynamicObject(987, 694.9335, -2463.1912, 8.5699, 0.0, 0.0, 336.0);
	CreateDynamicObject(4193, 679.299, -2451.0921, 22.8238, 0.0, 0.0, 0.0);
	CreateDynamicObject(3279, 704.6131, -2438.6419, 8.8063, 0.0, 0.0, 0.0);
	CreateDynamicObject(16093, 717.4464, -2462.306, 8.7036, 0.0, 0.0, 628.0);
	CreateDynamicObject(758, 739.3494, -2438.086, 8.995, 0.0, 0.0, 0.0);
	CreateDynamicObject(1689, 728.1479, -2436.702, 9.5341, 0.0, 0.0, 0.0);
	CreateDynamicObject(9833, 731.2955, -2453.848, 11.2866, 0.0, 0.0, 0.0);
	CreateDynamicObject(1216, 708.3603, -2438.8169, 9.5856, 0.0, 0.0, 90.0);
	CreateDynamicObject(620, 757.6859, -2441.7125, 8.9815, 0.0, 0.0, 0.0);
	CreateDynamicObject(620, 767.3907, -2441.4378, 8.9665, 0.0, 0.0, 0.0);
	CreateDynamicObject(620, 776.6198, -2441.0064, 9.2795, 0.0, 0.0, 0.0);
	CreateDynamicObject(620, 795.85, -2454.7334, 9.2372, 0.0, 0.0, 0.0);
	CreateDynamicObject(620, 796.0142, -2446.2122, 9.2103, 0.0, 0.0, 0.0);
	CreateDynamicObject(620, 785.2083, -2441.2679, 8.8529, 0.0, 0.0, 0.0);
	CreateDynamicObject(3707, 782.1149, -2498.1207, 16.5399, 0.0, 0.0, 11340.0);
	CreateDynamicObject(13061, 696.9373, -2499.597, 13.1139, 0.0, 0.0, 3060.0);
	CreateDynamicObject(6295, 654.7772, -2542.2662, 32.7503, 0.0, 0.0, 274.0);
	CreateDynamicObject(10610, 767.8339, -2568.275, 19.297, 0.0, 0.0, 0.0);
	CreateDynamicObject(3755, 723.7015, -2756.907, 14.0814, 0.0, 0.0, 180.0);
	CreateDynamicObject(3279, 794.2584, -2662.2273, 8.9004, 0.0, 0.0, 0.0);
	CreateDynamicObject(3279, 733.7263, -2662.0669, 8.8686, 0.0, 0.0, 0.0);
	CreateDynamicObject(3279, 702.7427, -2550.9031, 8.7854, 0.0, 0.0, 540.0);
	CreateDynamicObject(1232, 729.351, -2660.0364, 9.8439, 0.0, 0.0, 0.0);
	CreateDynamicObject(1232, 718.8617, -2660.0364, 9.8439, 0.0, 0.0, 0.0);
	CreateDynamicObject(12911, 794.6401, -2719.6172, 8.3711, 0.0, 0.0, 1272.0);
	CreateDynamicObject(3271, 748.7817, -2705.6116, 8.0834, 0.0, 0.0, 0.0);
	CreateDynamicObject(616, 758.7998, -2681.1841, 8.3489, 0.0, 0.0, 0.0);
	CreateDynamicObject(616, 774.1279, -2681.9012, 8.7644, 0.0, 0.0, 0.0);
	CreateDynamicObject(615, 794.0206, -2681.6133, 8.8257, 0.0, 0.0, 0.0);
	CreateDynamicObject(654, 795.2216, -2749.1143, 8.9336, 0.0, 0.0, 0.0);
	CreateDynamicObject(654, 795.3182, -2760.3682, 8.9336, 0.0, 0.0, 0.0);
	CreateDynamicObject(654, 786.998, -2765.1243, 8.9336, 0.0, 0.0, 0.0);
	CreateDynamicObject(654, 658.2606, -2764.3731, 8.9142, 0.0, 0.0, 0.0);
	CreateDynamicObject(654, 647.94, -2764.3731, 8.9142, 0.0, 0.0, 0.0);
	CreateDynamicObject(654, 648.0253, -2750.6141, 8.9142, 0.0, 0.0, 0.0);
	CreateDynamicObject(616, 737.0036, -2525.4676, 8.7911, 0.0, 0.0, 0.0);
	CreateDynamicObject(616, 754.4754, -2525.1016, 9.0633, 0.0, 0.0, 0.0);
	CreateDynamicObject(617, 706.1634, -2524.6355, 8.9826, 0.0, 0.0, 0.0);
	CreateDynamicObject(618, 696.905, -2525.2042, 9.0547, 0.0, 0.0, 0.0);
	CreateDynamicObject(617, 686.9915, -2525.2549, 8.9737, 0.0, 0.0, 0.0);
	CreateDynamicObject(620, 648.4679, -2457.8924, 8.8049, 0.0, 0.0, 0.0);
	CreateDynamicObject(620, 648.7082, -2451.2876, 8.7864, 0.0, 0.0, 0.0);
	CreateDynamicObject(620, 648.7055, -2443.0948, 9.0004, 0.0, 0.0, 0.0);
	CreateDynamicObject(620, 655.4914, -2441.917, 8.9103, 0.0, 0.0, 0.0);
	CreateDynamicObject(615, 657.8604, -2525.6312, 8.2689, 0.0, 0.0, 0.0);
	CreateDynamicObject(620, 648.4464, -2508.16, 8.9646, 0.0, 0.0, 0.0);
	CreateDynamicObject(620, 648.6856, -2515.6043, 8.915, 0.0, 0.0, 0.0);
	CreateDynamicObject(620, 648.782, -2523.0313, 8.7809, 0.0, 0.0, 0.0);
	CreateDynamicObject(987, 745.8425, -2555.2239, 8.77, 0.0, 0.0, 180.0);
	CreateDynamicObject(987, 725.9537, -2555.2239, 8.77, 0.0, 0.0, 180.0);
	CreateDynamicObject(987, 714.0518, -2555.2239, 8.77, 0.0, 0.0, 3420.0);
	CreateDynamicObject(987, 702.06, -2555.2239, 8.77, 0.0, 0.0, 1980.0);
	CreateDynamicObject(987, 690.1641, -2555.2239, 8.77, 0.0, 0.0, 3420.0);
	CreateDynamicObject(987, 678.2196, -2555.2239, 8.77, 0.0, 0.0, 1980.0);
	CreateDynamicObject(987, 666.3129, -2555.2239, 8.77, 0.0, 0.0, 3420.0);
	CreateDynamicObject(987, 654.3567, -2555.2239, 8.77, 0.0, 0.0, 1980.0);
	CreateDynamicObject(987, 739.7946, -2555.2176, 8.77, 0.0, 0.0, 90.0);
	CreateDynamicObject(987, 739.7946, -2543.3077, 8.77, 0.0, 0.0, 4410.0);
	CreateDynamicObject(987, 739.9273, -2531.2918, 8.77, 0.0, 0.0, 3060.0);
	CreateDynamicObject(987, 720.0802, -2531.2918, 8.77, 0.0, 0.0, 3060.0);
	CreateDynamicObject(987, 708.1926, -2531.3055, 8.77, 0.0, 0.0, 1710.0);
	CreateDynamicObject(987, 708.1926, -2543.2549, 8.77, 0.0, 0.0, 1710.0);
	CreateDynamicObject(987, 799.8148, -2598.1402, 8.77, 0.0, 0.0, 90.0);
	CreateDynamicObject(987, 799.8148, -2610.0562, 8.77, 0.0, 0.0, 16650.0);
	CreateDynamicObject(987, 799.8148, -2622.0411, 8.77, 0.0, 0.0, 90.0);
	CreateDynamicObject(987, 799.8148, -2633.9651, 8.77, 0.0, 0.0, 16650.0);
	CreateDynamicObject(987, 799.8148, -2645.9454, 8.77, 0.0, 0.0, 90.0);
	CreateDynamicObject(987, 799.8148, -2657.8357, 8.77, 0.0, 0.0, 16650.0);
	CreateDynamicObject(987, 642.4129, -2555.1802, 8.77, 0.0, 0.0, 1350.0);
	CreateDynamicObject(987, 642.3908, -2567.0999, 8.77, 0.0, 0.0, 630.0);
	CreateDynamicObject(987, 642.3908, -2579.0831, 8.77, 0.0, 0.0, 1350.0);
	CreateDynamicObject(987, 642.3908, -2590.9979, 8.77, 0.0, 0.0, 630.0);
	CreateDynamicObject(987, 704.8396, -2650.8079, 8.3377, 0.0, 0.0, 180.0);
	CreateDynamicObject(987, 658.671, -2650.8079, 8.3377, 0.0, 0.0, 180.0);
	CreateDynamicObject(987, 734.6109, -2576.6407, 6.5678, 0.0, 0.0, 0.0);
	CreateDynamicObject(987, 746.4592, -2563.8387, 6.5678, 0.0, 0.0, 180.0);
	CreateDynamicObject(1215, 721.0942, -2426.5547, 9.0022, 0.0, 0.0, 0.0);
	CreateDynamicObject(1215, 707.8659, -2426.5547, 9.0022, 0.0, 0.0, 0.0);
	CreateDynamicObject(1215, 714.2727, -2426.5547, 9.0022, 0.0, 0.0, 0.0);
	CreateDynamicObject(1232, 714.068, -2466.605, 9.7073, 0.0, 0.0, 0.0);
	CreateDynamicObject(1232, 705.3523, -2466.605, 9.7073, 0.0, 0.0, 0.0);
	CreateDynamicObject(1231, 734.6074, -2435.762, 9.883, 0.0, 0.0, 0.0);
	CreateDynamicObject(1231, 745.6032, -2435.9141, 9.883, 0.0, 0.0, 0.0);
	CreateDynamicObject(1231, 723.6517, -2435.8421, 9.883, 0.0, 0.0, 0.0);
	CreateDynamicObject(1231, 706.6062, -2504.2466, 9.883, 0.0, 0.0, 0.0);
	CreateDynamicObject(1231, 697.3772, -2504.2466, 9.883, 0.0, 0.0, 0.0);
	CreateDynamicObject(1231, 688.0009, -2504.2466, 9.883, 0.0, 0.0, 0.0);
	CreateDynamicObject(1232, 728.6606, -2530.5696, 9.883, 0.0, 0.0, 0.0);
	CreateDynamicObject(1232, 719.4514, -2530.5018, 9.883, 0.0, 0.0, 0.0);
	
	CreateDynamicObject(18750, -2944.3702, 468.9299, 43.3199, 90.0, 0.0, 90.0, 0);      /*지상꾸미기 [JE]*/
	CreateDynamicObject(19129, -2982.46, 470.75, 3.8599, 0.0, 0.0, 0.0, 0);
	CreateDynamicObject(19129, -2944.43, 470.8299, 3.8599, 0.0, 0.0, 0.0, 0);
	CreateDynamicObject(19129, -2963.16, 470.7099, 3.8599, 0.0, 0.0, 0.0, 0);
	CreateDynamicObject(19076, -2977.0, 482.6799, 3.8699, 0.0, 0.0, 0.0, 0);
	CreateDynamicObject(19076, -2957.5301, 459.98, 3.8699, 0.0, 0.0, 0.0, 0);
	CreateDynamicObject(19076, -2976.71, 460.01, 3.8699, 0.0, 0.0, 0.0, 0);
	CreateDynamicObject(19076, -2940.19, 482.42, 3.8699, 0.0, 0.0, 0.0, 0);
	CreateDynamicObject(19076, -2958.3899, 481.95, 3.8699, 0.0, 0.0, 0.0, 0);
	CreateDynamicObject(19076, -2938.5401, 460.5, 3.8699, 0.0, 0.0, 0.0, 0);
	CreateDynamicObject(18752, -3075.71, 368.79, -8.19, 0.0, 0.0, 0.0, 0);
	CreateDynamicObject(18771, -2919.7901, 487.22, 3.9, 0.0, 0.0, 0.0, 0);
	CreateDynamicObject(18771, -2919.7901, 487.22, 103.19, 0.0, 0.0, 328.2099, 0);
	CreateDynamicObject(18771, -2919.75, 487.23, 53.6599, 0.0, 0.0, 345.38, 0);
	
	
	CreateDynamicObject(8155, -292.79998779297, 1550.0999755859, 74.599998474121, 0, 0, 223.99987792969);   /*밀리터리시즌6 오브젝트*/
	CreateDynamicObject(8151, -348.5, 1591.5, 75.099998474121, 0, 0, 44);
	CreateDynamicObject(8154, -358.10000610352, 1534.3000488281, 77.5, 0, 0, 270);
	CreateDynamicObject(8313, -398.60000610352, 1575.0999755859, 76.599998474121, 0, 4, 10);
	CreateDynamicObject(4504, -309.29998779297, 1320.3000488281, 55.400001525879, 358.00122070313, 357.99877929688, 171.93017578125);
	CreateDynamicObject(10671, -397.20001220703, 1593.9000244141, 77.699996948242, 0, 0, 355.99353027344);
	CreateDynamicObject(3498, -400.5, 1589.4000244141, 72.900001525879, 0, 39.995727539063, 13.99658203125);
	CreateDynamicObject(3498, -400.20001220703, 1596.0999755859, 72.900001525879, 0, 39.995727539063, 5.9930419921875);
	CreateDynamicObject(3498, -394.10000610352, 1589.9000244141, 73.400001525879, 43.994750976563, 0, 265.99548339844);
	CreateDynamicObject(3498, -393.60000610352, 1596.4000244141, 73.199996948242, 43.9892578125, 0, 273.99353027344);
	CreateDynamicObject(9241, -281.10000610352, 1546.5999755859, 75.199996948242, 0, 0, 44);
	CreateDynamicObject(9241, -301.70001220703, 1567.8000488281, 75.199996948242, 0, 0, 43.994750976563);
	CreateDynamicObject(9241, -383.79998779297, 1533.8000488281, 76.199996948242, 0, 0, 179.99450683594);
	CreateDynamicObject(9241, -376.60000610352, 1567.9000244141, 75.699996948242, 0, 0, 133.99450683594);
	CreateDynamicObject(18248, -390.79998779297, 1596.9000244141, 81.699996948242, 6, 0, 240);
	CreateDynamicObject(10671, -397.20001220703, 1593.9000244141, 74.199996948242, 0, 0, 355.98999023438);
	CreateDynamicObject(3884, -326.60000610352, 1541.6999511719, 78.5, 0, 0, 125.99996948242);
	CreateDynamicObject(3884, -321.79998779297, 1541.4000244141, 78.5, 0, 0, 125.99670410156);
	CreateDynamicObject(3884, -332, 1541.6999511719, 78.5, 0, 0, 125.99670410156);
	CreateDynamicObject(3884, -343.10000610352, 1537, 78.5, 0, 0, 125.99670410156);
	CreateDynamicObject(3884, -343.20001220703, 1543, 78.5, 0, 0, 125.99670410156);
	CreateDynamicObject(3884, -343.10000610352, 1548.1999511719, 78.5, 0, 0, 125.99670410156);
	CreateDynamicObject(3884, -313.89999389648, 1554.6999511719, 78.5, 0, 0, 131.99670410156);
	CreateDynamicObject(3884, -308.10000610352, 1548.5, 78.5, 0, 0, 119.99523925781);
	CreateDynamicObject(3884, -302.79998779297, 1543.5, 78.5, 0, 0, 119.99523925781);
	CreateDynamicObject(16093, -312.29998779297, 1503.8000488281, 74.900001525879, 0, 0, 2);
	CreateDynamicObject(3787, -341, 1547.5, 75.099998474121, 0, 0, 0);
	CreateDynamicObject(3787, -341, 1544.9000244141, 75.099998474121, 0, 0, 0);
	CreateDynamicObject(3787, -340.89999389648, 1542.0999755859, 75.099998474121, 0, 0, 0);
	CreateDynamicObject(3279, -289.89999389648, 1515.5999755859, 74.599998474121, 0, 0, 136);
	CreateDynamicObject(3095, -293.39999389648, 1503.0999755859, 71.699996948242, 70, 0, 10);
	CreateDynamicObject(3498, -297, 1506.3000488281, 72, 32, 0, 4);
	CreateDynamicObject(3498, -290.89999389648, 1507.3000488281, 72, 31.997680664063, 0, 3.9990234375);
	CreateDynamicObject(9819, -345.60000610352, 1542.0999755859, 75.300003051758, 0, 0, 180);
	CreateDynamicObject(3066, -320.29998779297, 1514.9000244141, 75.199996948242, 0, 0, 278);
	CreateDynamicObject(3066, -333.89999389648, 1513, 75.199996948242, 0, 0, 283.99447631836);
	CreateDynamicObject(3066, -325.10000610352, 1510.0999755859, 75.199996948242, 0, 0, 261.98913574219);
	CreateDynamicObject(3799, -345.60000610352, 1536.5, 73.400001525879, 0, 0, 0);
	CreateDynamicObject(12912, -345.29998779297, 1516, 85.400001525879, 0, 0, 0);
	CreateDynamicObject(12911, -316.70001220703, 1580.9000244141, 73.599998474121, 0, 0, 328);
	CreateDynamicObject(3881,100.055,1916.342,19.118,0.0,0.0,-90.000);
	CreateDynamicObject(3882,100.486,1916.214,18.265,0.0,0.0,0.0);
	CreateDynamicObject(966,97.145,1925.603,17.158,0.0,0.0,90.000);
	CreateDynamicObject(968,97.140,1925.250,17.693,0.0,0.0,90.000);
	CreateDynamicObject(974,226.387,1859.175,16.033,0.0,0.0,90.000);
	CreateDynamicObject(18553,233.527,1822.682,7.706,0.0,0.0,0.0);
    CreateDynamicObject(8378,268.672,1884.901,15.436,91.960,0.0,90.000);
	CreateDynamicObject(2634,285.888,1821.062,17.785,0.0,0.0,90.000);
	CreateDynamicObject(2634,286.215,1821.068,17.785,0.0,0.0,-90.000);
	CreateDynamicObject(2641, 234.95133972168, 1842.9664306641, 18.165138244629, 0, 0, 181.99996948242);
	CreateDynamicObject(2642, 231.27252197266, 1842.8927001953, 17.820728302002, 0, 0, 178);
	CreateDynamicObject(2643, 233.14651489258, 1843.0054931641, 19.682027816772, 0, 0, 179.99993896484);
	CreateDynamicObject(16105, 180.28211975098, 1946.1400146484, 19.606397628784, 0, 0, 0);
	CreateDynamicObject(11501, 150.98515319824, 1977.9561767578, 18.062803268433, 0, 0, 358);
	CreateDynamicObject(8148, 143.59655761719, 2022.6962890625, 20.483827590942, 0, 0, 358);
	CreateDynamicObject(8210, 173.34129333496, 2101.2585449219, 21.44704246521, 0, 0, 358);
	CreateDynamicObject(8650, 173.74459838867, 2015.111328125, 16.802682876587, 1.99951171875, 0, 88);
	CreateDynamicObject(2634, 170.8158416748, 1941.1645507813, 18.495906829834, 0, 0, 178);
	CreateDynamicObject(2634, 170.830078125, 1941.3857421875, 18.495895385742, 0, 0, 0);
	CreateDynamicObject(618, 158.8094329834, 1985.2348632813, 17.953018188477, 0, 0, 0);
	CreateDynamicObject(617, 181.42218017578, 1972.9583740234, 16.977949142456, 0, 0, 0);
	CreateDynamicObject(18451, 182.64462280273, 2046.2218017578, 17.847509384155, 10, 0, 13.99853515625);
	CreateDynamicObject(1586, 152.07099914551, 2004.1519775391, 20.721832275391, 0, 0, 359.99548339844);
	CreateDynamicObject(1586, 175.46015930176, 1980.3742675781, 20.069141387939, 0, 0, 25.995971679688);
	CreateDynamicObject(1586, 171.31076049805, 1999.1722412109, 19.402114868164, 0, 0, 0);
	CreateDynamicObject(1586, 166.52224731445, 2015.5391845703, 18.158235549927, 0, 0, 357.99548339844);
	CreateDynamicObject(1586, 169.82432556152, 2015.3887939453, 18.028400421143, 0, 0, 359.99548339844);
	CreateDynamicObject(1586, 163.38018798828, 2015.6439208984, 18.334253311157, 0, 0, 359.99499511719);
	CreateDynamicObject(1622, 174.53285217285, 1941.5574951172, 22.060836791992, 0, 0, 272);
	CreateDynamicObject(617, 153.06915283203, 1966.3453369141, 18.205509185791, 0, 0, 0);
	CreateDynamicObject(11433, 183.90864562988, 2028.7673339844, 18.944078445435, 0, 0, 270);
	CreateDynamicObject(11457, 171.57780456543, 1998.4827880859, 16.300552368164, 0, 0, 88);
	CreateDynamicObject(11459, 175.79614257813, 1979.2420654297, 17.217578887939, 0, 0, 0);
	CreateDynamicObject(11457, 164.3056640625, 1976.6220703125, 16.982990264893, 0, 0, 0);
	CreateDynamicObject(11459, 164.6111907959, 1955.3510742188, 17.318319320679, 0, 0, 272);
	CreateDynamicObject(11458, 178.46061706543, 1962.5251464844, 17.083284378052, 0, 0, 179.99993896484);
	CreateDynamicObject(11457, 151.833984375, 2003.1396484375, 17.620269775391, 0, 0, 0);
	CreateDynamicObject(11459, 149.0478515625, 1954.6533203125, 18.052989959717, 0, 0, 0);
	CreateDynamicObject(16770, 163.4599609375, 2047.494140625, 18.099905014038, 0, 0, 265.99548339844);
	CreateDynamicObject(8650, 166.0966796875, 2015.3798828125, 17.121820449829, 1.99951171875, 0, 87.995483398438);
	CreateDynamicObject(11459, 148.6015625, 2043.8427734375, 16.534448623657, 0, 0, 85.995483398438);
	CreateDynamicObject(1586, 164.38745117188, 1978.6713867188, 20.834552764893, 0, 0, 359.99450683594);
	CreateDynamicObject(1586, 157.03861999512, 1994.9388427734, 20.823394775391, 0, 0, 0);
	CreateDynamicObject(1586, 179.73672485352, 1998.916015625, 22.378677368164, 0, 0, 359.99450683594);
	CreateDynamicObject(1586, 176.35084533691, 1963.6754150391, 17.202322006226, 0, 0, 355.99548339844);
	CreateDynamicObject(737, 184.52005004883, 2040.0378417969, 17.193279266357, 0, 0, 0);
	CreateDynamicObject(2047, 188.75012207031, 1931.5499267578, 19.439357757568, 0, 0, 269.99996948242);
	CreateDynamicObject(2048, 254.09690856934, 1801.9379882813, 9.4915180206299, 0, 0, 269.99996948242);
	CreateDynamicObject(970, 174.99711608887, 2043.9729003906, 17.055086135864, 0, 0, 356);
	CreateDynamicObject(970, 154.2353515625, 2045.61328125, 16.999059677124, 0, 0, 355.99548339844);
	CreateDynamicObject(970, 178.62239074707, 2043.8616943359, 17.148611068726, 0, 0, 0);
	CreateDynamicObject(970, 182.30520629883, 2038.4654541016, 17.141176223755, 0, 0, 266);
	CreateDynamicObject(970, 181.55795288086, 2042.1499023438, 17.321691513062, 0, 0, 296);
	CreateDynamicObject(941, 146.59698486328, 2047.9124755859, 16.947303771973, 0, 0, 356);
	CreateDynamicObject(941, 150.1194152832, 2047.6713867188, 16.919212341309, 0, 0, 358);
	CreateDynamicObject(3017, 150.79501342773, 2047.5251464844, 17.49157333374, 0, 0, 0);
	CreateDynamicObject(2894, 150.27993774414, 2047.8507080078, 17.394750595093, 0, 0, 0);
	CreateDynamicObject(2196, 150.07171630859, 2047.8629150391, 17.394750595093, 0, 0, 0);
	CreateDynamicObject(2036, 147.17713928223, 2047.5911865234, 17.456768035889, 0, 0, 0);
	CreateDynamicObject(2035, 147.51036071777, 2048.0151367188, 17.44727897644, 0, 0, 0);
	CreateDynamicObject(1672, 146.3751373291, 2047.6433105469, 17.628561019897, 0, 0, 0);
	CreateDynamicObject(2033, 146.76020812988, 2047.8979492188, 17.453662872314, 0, 0, 0);
	CreateDynamicObject(2044, 146.11964416504, 2047.9108886719, 17.450374603271, 0, 0, 0);
	CreateDynamicObject(2044, 146.48036193848, 2048.2346191406, 17.450374603271, 0, 0, 0);
	CreateDynamicObject(2035, 150.73675537109, 2047.8013916016, 17.419187545776, 0, 0, 38);
	CreateDynamicObject(1650, 149.3874206543, 2047.2741699219, 17.701414108276, 0, 0, 0);
	CreateDynamicObject(3787, 154.68745422363, 2046.3092041016, 16.91644859314, 0, 0, 356);
	CreateDynamicObject(3884, 148.60562133789, 2044.0278320313, 18.886011123657, 0, 0, 225.99996948242);
	CreateDynamicObject(1505, 2436.049805, -1718.775879, 220.876251, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(2297, 2467.702393, -1724.146118, 220.876144, 0.0000, 0.0000, 225.0000);
	CreateDynamicObject(2002, 2436.330078, -1726.719482, 220.885544, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(2002, 2436.321289, -1728.731201, 220.885544, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(1800, 2441.845703, -1729.177734, 220.893402, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(1800, 2445.045898, -1729.140015, 220.893402, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(1800, 2448.563232, -1729.119385, 220.893402, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(1800, 2447.802246, -1728.916138, 220.893402, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(1800, 2455.722412, -1729.188110, 220.868408, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(1800, 2454.895752, -1728.826172, 220.893402, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(1800, 2458.779541, -1728.904297, 220.893402, 0.0000, 0.0000, 270.0000);
	CreateDynamicObject(1742, 2465.728516, -1730.864014, 220.928513, 0.0000, 0.0000, 180.0000);
	CreateDynamicObject(1743, 2450.911621, -1729.389893, 220.777695, 0.0000, 0.0000, 180.0000);
	CreateDynamicObject(1743, 2461.551514, -1729.368774, 220.907898, 0.0000, 0.0000, 180.0000);
	CreateDynamicObject(1743, 2457.854980, -1729.378296, 220.907898, 0.0000, 0.0000, 180.0000);
	CreateDynamicObject(1743, 2454.115479, -1729.374390, 220.907898, 0.0000, 0.0000, 180.0000);
	CreateDynamicObject(1743, 2446.841553, -1729.367188, 220.907898, 0.0000, 0.0000, 180.0000);
	CreateDynamicObject(1743, 2443.464844, -1729.429321, 220.852676, 0.0000, 0.0000, 180.0000);
	CreateDynamicObject(1743, 2439.846680, -1729.367310, 220.907898, 0.0000, 0.0000, 180.0000);
	CreateDynamicObject(2053, 2439.580078, -1730.239014, 221.977295, 0.0000, 0.0000, 168.7500);
	CreateDynamicObject(2053, 2443.245361, -1730.285645, 221.897079, 0.0000, 0.0000, 180.0000);
	CreateDynamicObject(2053, 2446.617920, -1730.204712, 221.952301, 0.0000, 0.0000, 180.0000);
	CreateDynamicObject(2053, 2450.622803, -1730.293213, 221.847092, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(2053, 2453.877686, -1730.267456, 221.977295, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(2053, 2457.574463, -1730.289795, 221.977295, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(2053, 2461.276855, -1730.275024, 221.952301, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(2044, 2460.849121, -1730.265381, 221.920517, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(2044, 2457.187500, -1730.317871, 221.920517, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(2035, 2453.602539, -1730.234619, 221.917435, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(2035, 2450.387939, -1730.295898, 221.787231, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(2036, 2446.403809, -1730.255859, 221.926910, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(2044, 2442.832520, -1730.311035, 221.890289, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(2044, 2439.142822, -1730.244995, 221.920517, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(2299, 2443.569336, -1720.311279, 220.883820, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(2299, 2447.751465, -1720.288086, 220.876007, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(2299, 2451.603271, -1720.242798, 220.876007, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(2299, 2455.672119, -1720.311157, 220.883820, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(2299, 2459.824219, -1720.313843, 220.883820, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(2299, 2463.755127, -1720.392700, 220.876007, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(14782, 2434.921631, -1722.354126, 221.905991, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(3077, 216.54545593262, 1818.1384277344, 5.1640625, 0, 0, 312);
    CreateDynamicObject(2614, 234.76142883301, 1823.3206787109, 10.01490688324, 0, 2, 90);
	CreateDynamicObject(8263,330.105,2081.148,23.404,0.0,0.0,180.000);
	CreateDynamicObject(8263,390.087,2021.461,23.317,0.0,0.0,90.000);
	CreateDynamicObject(8263,390.093,1949.813,23.429,0.0,0.0,90.000);
	CreateDynamicObject(8210,355.496,1843.156,23.647,0.0,0.0,90.000);
	CreateDynamicObject(8209,189.011,1991.136,23.277,0.0,0.0,90.000);
	CreateDynamicObject(987,187.207,2052.459,22.883,-4.297,7.735,-83.907);
	CreateDynamicObject(987,188.190,2062.720,24.379,0.859,6.875,-93.360);
	CreateDynamicObject(987,188.146,2062.932,24.641,0.0,-5.157,157.500);
	CreateDynamicObject(987,177.595,2066.664,25.474,0.0,0.0,123.750);
	CreateDynamicObject(987,170.695,2076.635,25.330,0.0,0.0,90.000);
	CreateDynamicObject(987,170.244,2089.191,25.045,0.0,0.0,45.000);
	CreateDynamicObject(987,178.828,2097.886,24.959,0.0,0.0,11.250);
	CreateDynamicObject(987,188.774,2034.491,19.991,0.0,0.0,90.000);
	CreateDynamicObject(987,190.362,2100.087,25.134,0.0,0.0,-22.500);
	CreateDynamicObject(987,201.559,2095.572,24.934,0.0,0.0,-67.500);
	CreateDynamicObject(987,204.060,2093.954,24.192,0.0,0.0,-78.750);
	CreateDynamicObject(987,379.525,1885.410,20.221,0.0,0.0,22.500);
	CreateDynamicObject(987,368.491,1880.783,20.196,0.0,0.0,22.500);
	CreateDynamicObject(987,368.381,1880.976,19.995,0.0,0.0,-157.500);
	CreateDynamicObject(987,355.593,1875.573,19.774,0.0,0.0,-90.000);
	CreateDynamicObject(987,355.593,1875.868,20.449,0.0,0.0,22.500);
	CreateDynamicObject(987,355.669,1817.645,21.492,0.0,0.0,-90.000);
	CreateDynamicObject(987,275.456,1798.750,20.062,0.0,0.0,-86.562);
	CreateDynamicObject(987,275.989,1794.021,20.489,0.0,2.578,-90.000);
	CreateDynamicObject(987,276.340,1782.598,20.275,0.0,0.0,0.0);
	CreateDynamicObject(987,287.914,1782.594,20.325,0.0,0.0,0.0);
	CreateDynamicObject(987,300.037,1782.705,20.302,0.0,0.0,0.0);
	CreateDynamicObject(987,309.836,1782.807,20.278,0.0,0.0,0.0);
	CreateDynamicObject(987,321.760,1782.886,20.217,0.0,0.0,33.750);
	CreateDynamicObject(987,331.178,1788.698,20.100,0.0,0.0,33.750);
	CreateDynamicObject(8210,244.048,2081.565,23.104,0.0,0.0,0.0);
	CreateDynamicObject(8210,233.958,2083.046,24.120,0.0,0.0,0.0);
	CreateDynamicObject(3279,332.246,1796.746,17.028,0.0,0.0,123.750);
	CreateDynamicObject(3279,103.875,1928.907,17.501,0.0,0.0,0.0);
	CreateDynamicObject(8263,1475.936,2883.368,15.839,0.0,0.0,0.0);
	CreateDynamicObject(8263,1417.855,2823.217,15.972,0.0,0.0,90.000);
	CreateDynamicObject(8263,1417.719,2823.243,12.926,0.0,0.0,90.000);
	CreateDynamicObject(8263,1417.748,2790.623,12.921,0.0,0.0,90.000);
	CreateDynamicObject(8210,1534.153,2855.066,16.014,0.0,0.0,90.000);
	CreateDynamicObject(8210,1534.488,2816.551,15.649,0.0,0.0,90.000);
	CreateDynamicObject(8210,1533.857,2731.924,13.189,0.0,0.0,90.000);
	CreateDynamicObject(8209,1484.393,2723.725,16.214,0.0,0.0,0.0);
	CreateDynamicObject(8209,1385.520,2723.068,15.696,0.0,0.0,0.0);
	CreateDynamicObject(8209,665.089,1686.269,8.404,0.0,0.0,-135.000);
	CreateDynamicObject(8210,606.992,1635.771,8.536,0.0,0.0,-146.250);
	CreateDynamicObject(8210,561.023,1690.599,12.087,0.0,0.0,33.750);
	CreateDynamicObject(8210,606.293,1719.889,7.679,0.0,0.0,33.750);
	CreateDynamicObject(8210,607.913,1720.255,14.797,0.0,0.0,-146.250);
	CreateDynamicObject(8210,681.220,1740.565,9.101,0.0,0.0,-45.000);
	CreateDynamicObject(8210,573.879,1633.418,9.093,0.0,0.0,-56.250);
	CreateDynamicObject(987,542.334,1674.934,5.992,0.0,0.0,-56.250);
	CreateDynamicObject(987,662.452,1759.638,4.953,0.0,0.0,225.000);
	CreateDynamicObject(987,654.128,1752.118,4.651,0.0,0.0,-135.000);
	CreateDynamicObject(3279,655.224,1746.966,4.602,0.0,0.0,-56.250);
	CreateDynamicObject(3279,629.980,1728.620,5.177,0.0,0.0,-56.250);
	CreateDynamicObject(3279,564.246,1656.293,6.068,0.0,0.0,33.750);
	CreateDynamicObject(3279,553.386,1673.977,6.068,0.0,0.0,33.750);
	CreateDynamicObject(2036,590.762,1671.004,6.026,0.0,0.0,0.0);
	CreateDynamicObject(2035,583.326,1660.330,6.017,0.0,0.0,-45.000);
	CreateDynamicObject(2036,574.673,1676.324,6.026,0.0,0.0,0.0);
	CreateDynamicObject(2037,605.986,1660.000,6.065,0.0,0.0,0.0);
	CreateDynamicObject(2037,605.992,1660.237,6.065,0.0,0.0,0.0);
	CreateDynamicObject(2044,583.508,1682.177,6.020,0.0,0.0,0.0);
	CreateDynamicObject(2044,592.004,1651.561,6.020,0.0,0.0,0.0);
	CreateDynamicObject(2044,578.012,1650.537,6.020,0.0,0.0,0.0);
	CreateDynamicObject(2044,582.012,1644.290,6.020,0.0,0.0,-101.250);
	CreateDynamicObject(2036,616.109,1697.225,6.026,0.0,0.0,0.0);
	CreateDynamicObject(2036,634.790,1688.451,6.026,0.0,0.0,-56.250);
	CreateDynamicObject(2036,624.338,1713.583,6.026,0.0,0.0,146.250);
	CreateDynamicObject(2035,630.093,1706.864,6.017,0.0,0.0,-56.250);
	CreateDynamicObject(2035,637.630,1711.706,6.017,0.0,0.0,45.000);
	CreateDynamicObject(2035,633.794,1720.031,5.627,0.0,0.0,-101.250);
	CreateDynamicObject(2035,616.860,1708.485,6.017,0.0,0.0,-45.000);
	CreateDynamicObject(2035,623.582,1703.227,6.017,0.0,0.0,90.000);
	CreateDynamicObject(3525,623.930,1708.785,5.161,0.0,0.0,0.0);
	CreateDynamicObject(3525,618.659,1715.716,5.093,0.0,0.0,0.0);
	CreateDynamicObject(3525,636.946,1718.187,5.048,0.0,0.0,56.250);
	CreateDynamicObject(3525,637.214,1704.926,5.136,0.0,0.0,-90.000);
	CreateDynamicObject(3525,631.363,1686.938,5.236,0.0,0.0,0.0);
	CreateDynamicObject(3525,647.010,1725.092,5.094,0.0,0.0,0.0);
	CreateDynamicObject(3525,647.446,1715.092,5.211,0.0,0.0,0.0);
	CreateDynamicObject(3525,647.354,1702.858,5.236,0.0,0.0,0.0);
	CreateDynamicObject(3525,652.200,1717.961,5.218,0.0,0.0,0.0);
	CreateDynamicObject(3525,639.530,1728.216,4.615,0.0,0.0,0.0);
	CreateDynamicObject(3525,662.956,1741.068,4.692,0.0,0.0,0.0);
	CreateDynamicObject(3525,666.707,1738.918,4.943,0.0,0.0,0.0);
	CreateDynamicObject(3525,669.123,1731.656,5.236,0.0,0.0,0.0);
	CreateDynamicObject(3525,673.839,1738.453,5.236,0.0,0.0,0.0);
	CreateDynamicObject(3525,678.328,1728.813,5.236,0.0,0.0,0.0);
	CreateDynamicObject(3525,688.708,1725.237,5.186,0.0,0.0,0.0);
	CreateDynamicObject(3525,688.655,1717.561,5.261,0.0,0.0,0.0);
	CreateDynamicObject(3525,664.201,1748.890,4.194,0.0,0.0,0.0);
	CreateDynamicObject(3525,635.204,1691.097,5.211,0.0,0.0,0.0);
	CreateDynamicObject(3525,593.489,1675.318,5.186,0.0,0.0,0.0);
	CreateDynamicObject(3525,578.991,1678.075,5.136,0.0,0.0,0.0);
	CreateDynamicObject(3525,588.837,1652.221,5.161,0.0,0.0,0.0);
	CreateDynamicObject(3525,610.567,1678.020,5.211,0.0,0.0,0.0);
	CreateDynamicObject(3525,594.365,1699.678,5.261,0.0,0.0,0.0);
	CreateDynamicObject(3525,587.774,1642.675,5.211,0.0,0.0,0.0);
	CreateDynamicObject(3525,611.599,1653.914,5.236,0.0,0.0,0.0);
	CreateDynamicObject(3525,582.241,1691.455,5.211,0.0,0.0,0.0);
	CreateDynamicObject(987,178.325,2067.744,21.641,0.0,0.0,135.000);
	CreateDynamicObject(987,170.483,2089.035,22.259,0.0,0.0,45.000);
	CreateDynamicObject(987,170.717,2076.500,21.923,0.0,0.0,90.000);
	CreateDynamicObject(987,190.256,2099.632,22.091,0.0,0.0,-22.500);
	CreateDynamicObject(987,201.216,2094.957,21.491,0.0,0.0,-67.500);
	CreateDynamicObject(987,178.804,2097.707,22.001,0.0,0.0,11.250);
	CreateDynamicObject(987,188.779,2064.837,21.644,0.0,0.0,168.750);
	CreateDynamicObject(987,358.295,1807.010,21.099,0.0,0.0,-146.250);
	CreateDynamicObject(3279,348.311,1808.946,17.417,0.0,0.0,123.750);
	CreateDynamicObject(3279,992.016,2118.014,9.896,0.0,0.0,-180.000);
	CreateDynamicObject(3279,991.540,2146.493,9.896,0.0,0.0,-180.000);
	CreateDynamicObject(3525,980.884,2125.118,8.814,0.0,0.0,0.0);
	CreateDynamicObject(3525,983.635,2133.066,9.064,0.0,0.0,0.0);
	CreateDynamicObject(3525,982.639,2115.540,8.989,0.0,0.0,0.0);
	CreateDynamicObject(3525,968.753,2136.866,8.964,0.0,0.0,0.0);
	CreateDynamicObject(3525,974.474,2113.723,9.039,0.0,0.0,0.0);
	CreateDynamicObject(3525,973.703,2164.060,9.064,0.0,0.0,0.0);
	CreateDynamicObject(3525,978.992,2151.273,9.064,0.0,0.0,0.0);
	CreateDynamicObject(3525,981.575,2165.952,9.089,0.0,0.0,0.0);
	CreateDynamicObject(3525,973.442,2145.076,8.914,0.0,0.0,0.0);
	CreateDynamicObject(3525,990.780,2102.238,9.039,0.0,0.0,0.0);
	CreateDynamicObject(3525,977.820,2097.229,9.064,0.0,0.0,0.0);
    CreateDynamicObject(16093, 81.572593688965, 1905.3020019531, 16.719703674316, 359.99951171875, 0, 270);
	CreateDynamicObject(18070, 81.575675964355, 1905.5091552734, 20.58678817749, 0, 0, 269.99450683594);
	CreateDynamicObject(1237, 66.558334350586, 1917.3117675781, 16.640626907349, 0, 0, 0);
	CreateDynamicObject(3279, 82.234298706055, 1932.9399414063, 13.084005355835, 0, 0, 0);
	CreateDynamicObject(3884, 68.304306030273, 1917.5772705078, 18.989891052246, 0, 0, 88);
	CreateDynamicObject(2985, 79.909843444824, 1905.5159912109, 20.847152709961, 0, 0, 179.99993896484);
	CreateDynamicObject(13011, 86.361389160156, 1910.8154296875, 16.794548034668, 0, 0, 178);
	CreateDynamicObject(3091, 65.824264526367, 1903.6651611328, 17.285665512085, 0, 0, 272);
	CreateDynamicObject(8652, 81.957481384277, 1898.9544677734, 17.621332168579, 0, 0, 0);
	CreateDynamicObject(8652, 81.923278808594, 1941.0133056641, 17.331562042236, 0, 0, 0);
	CreateDynamicObject(8041, 68.4482421875, 1917.6220703125, 22.457475662231, 0, 0, 179.99450683594);
	CreateDynamicObject(985, 71.079559326172, 1941.1649169922, 16.595327377319, 0, 0, 0);
	CreateDynamicObject(985, 78.759666442871, 1941.0771484375, 16.611530303955, 0, 0, 357.99499511719);
	CreateDynamicObject(985, 86.482330322266, 1940.9533691406, 16.633354187012, 0, 0, 0);
	CreateDynamicObject(985, 94.358848571777, 1941.1535644531, 16.60534286499, 0, 0, 2);
	CreateDynamicObject(985, 71.112030029297, 1898.9805908203, 16.763833999634, 0, 0, 0);
	CreateDynamicObject(985, 78.859878540039, 1898.9512939453, 16.763833999634, 0, 0, 0);
	CreateDynamicObject(985, 86.563301086426, 1898.9609375, 16.763833999634, 0, 0, 0);
	CreateDynamicObject(985, 92.763092041016, 1898.9226074219, 16.763833999634, 0, 0, 0);
	CreateDynamicObject(970, 67.15682220459, 1938.7338867188, 17.192106246948, 0, 0, 268);
	CreateDynamicObject(970, 67.370536804199, 1901.2742919922, 17.192106246948, 0, 0, 272);
	CreateDynamicObject(970, 67.25301361084, 1905.4925537109, 17.192106246948, 0, 0, 271.99853515625);
	CreateDynamicObject(970, 67.025108337402, 1934.5789794922, 17.192106246948, 0, 0, 88);
	CreateDynamicObject(970, 66.863304138184, 1930.3663330078, 17.192106246948, 0, 0, 87.994995117188);
	CreateDynamicObject(3091, 66.06063079834, 1936.8604736328, 17.285665512085, 0, 0, 269.99951171875);
	CreateDynamicObject(3091, 65.965675354004, 1931.8264160156, 17.285665512085, 0, 0, 267.99951171875);
	CreateDynamicObject(2945, 71.174865722656, 1941.0010986328, 18.802762985229, 0, 0, 0);
	CreateDynamicObject(2945, 78.977912902832, 1940.9056396484, 18.893238067627, 0, 0, 0);
	CreateDynamicObject(2945, 86.898300170898, 1940.7895507813, 18.883367538452, 0, 0, 0);
	CreateDynamicObject(2945, 93.834732055664, 1940.9713134766, 18.802762985229, 0, 0, 0);
	CreateDynamicObject(2945, 71.474411010742, 1899.1448974609, 19.092533111572, 0, 0, 0);
	CreateDynamicObject(2945, 78.712966918945, 1899.1156005859, 19.092533111572, 0, 0, 0);
	CreateDynamicObject(2945, 86.22265625, 1899.1252441406, 19.020616531372, 0, 0, 0);
	CreateDynamicObject(2945, 93.711410522461, 1899.0869140625, 19.076610565186, 0, 0, 0);
	CreateDynamicObject(717, 70.29158782959, 1900.8367919922, 16.897617340088, 0, 0, 0);
	CreateDynamicObject(717, 70.2998046875, 1905.9375, 16.897617340088, 0, 0, 0);
	CreateDynamicObject(717, 70.282470703125, 1931.8623046875, 16.890625, 0, 0, 0);
	CreateDynamicObject(717, 70.40087890625, 1938.1689453125, 16.890625, 0, 0, 0);
	CreateDynamicObject(3594, 73.841911315918, 1935.9610595703, 17.021800994873, 0, 0, 344);
	CreateDynamicObject(3350, 80.086433410645, 1908.3823242188, 21.097152709961, 0, 0, 179.99993896484);
	CreateDynamicObject(11245, 65.254066467285, 1927.5540771484, 26.298330307007, 356.84887695313, 321.93218994141, 169.53479003906);
	CreateDynamicObject(11245, 65.25390625, 1927.5537109375, 26.298330307007, 356.84692382813, 321.92687988281, 169.53002929688);
	CreateDynamicObject(11245, 65.312683105469, 1907.9899902344, 26.648328781128, 358.42407226563, 321.98303222656, 176.76843261719);
	CreateDynamicObject(7313, 96.486503601074, 1920.8443603516, 21.520101547241, 0, 0, 270);
	CreateDynamicObject(2036,590.762,1671.004,6.026,0.0,0.0,0.0);
	CreateDynamicObject(2035,583.326,1660.330,6.017,0.0,0.0,-45.000);
	CreateDynamicObject(2036,574.673,1676.324,6.026,0.0,0.0,0.0);
	CreateDynamicObject(2037,605.986,1660.000,6.065,0.0,0.0,0.0);
	CreateDynamicObject(2037,605.992,1660.237,6.065,0.0,0.0,0.0);
	CreateDynamicObject(2044,583.508,1682.177,6.020,0.0,0.0,0.0);
	CreateDynamicObject(2044,592.004,1651.561,6.020,0.0,0.0,0.0);
	CreateDynamicObject(2044,578.012,1650.537,6.020,0.0,0.0,0.0);
	CreateDynamicObject(2044,582.012,1644.290,6.020,0.0,0.0,-101.250);
	CreateDynamicObject(2036,616.109,1697.225,6.026,0.0,0.0,0.0);
	CreateDynamicObject(2036,634.790,1688.451,6.026,0.0,0.0,-56.250);
	CreateDynamicObject(2036,624.338,1713.583,6.026,0.0,0.0,146.250);
	CreateDynamicObject(2035,630.093,1706.864,6.017,0.0,0.0,-56.250);
	CreateDynamicObject(2035,637.630,1711.706,6.017,0.0,0.0,45.000);
	CreateDynamicObject(2035,633.794,1720.031,5.627,0.0,0.0,-101.250);
	CreateDynamicObject(2035,616.860,1708.485,6.017,0.0,0.0,-45.000);
	CreateDynamicObject(2035,623.582,1703.227,6.017,0.0,0.0,90.000);
	CreateDynamicObject(987,178.325,2067.744,21.641,0.0,0.0,135.000);
	CreateDynamicObject(987,170.483,2089.035,22.259,0.0,0.0,45.000);
	CreateDynamicObject(987,170.717,2076.500,21.923,0.0,0.0,90.000);
	CreateDynamicObject(987,190.256,2099.632,22.091,0.0,0.0,-22.500);
	CreateDynamicObject(987,201.216,2094.957,21.491,0.0,0.0,-67.500);
	CreateDynamicObject(987,178.804,2097.707,22.001,0.0,0.0,11.250);
	CreateDynamicObject(987,188.779,2064.837,21.644,0.0,0.0,168.750);
	CreateDynamicObject(987,358.295,1807.010,21.099,0.0,0.0,-146.250);
	CreateDynamicObject(11245, 234.39999389648, 1827, 9.1999998092651, 0, 340, 0);
	CreateDynamicObject(11245, 234.19999694824, 1818.5, 9.1999998092651, 0, 339.99938964844, 0);
	CreateDynamicObject(987, 96.81958770752, 1869.6800537109, 14.738018035889, 0, 0, 0);
	CreateDynamicObject(987, 102.87578582764, 1869.5262451172, 15.046464920044, 0, 0, 0);
	CreateDynamicObject(987, 120.74780273438, 1869.6705322266, 14.8359375, 0, 0, 358);
	CreateDynamicObject(1228, 127.29275512695, 1871.3829345703, 17.257064819336, 0, 0, 270);
	CreateDynamicObject(1228, 106.69882202148, 1871.8229980469, 17.272201538086, 0, 0, 270);
	CreateDynamicObject(1228, 100.84167480469, 1871.8707275391, 17.217540740967, 0, 0, 269.99996948242);
	CreateDynamicObject(7313, 138.1061706543, 1850.0181884766, 21.527648925781, 0, 0, 269.99996948242);
	CreateDynamicObject(11245, 156.9052734375, 1901.853515625, 21.309240341187, 0, 327.99682617188, 0);
	CreateDynamicObject(11245, 156.78692626953, 1904.9183349609, 21.346351623535, 1.7319641113281, 329.98489379883, 1.0003051757813);
	CreateDynamicObject(7313, 156.380859375, 1903.2421875, 19.944942474365, 0, 0, 89.994506835938);
	CreateDynamicObject(936, 146.31422424316, 1911.609375, 18.281019210815, 0, 0, 180);
	CreateObject(986,96.653,1920.476,18.851,0.0,0.0,90.000);

	/*========================================================================*/

	AddStaticVehicle(541,-5564.5845,475.1686,1202.4724,271.0024,58,8);//뷰렛
	AddStaticVehicle(602,-5564.2446,469.4882,1202.6544,270.3264,69,1);//알파
	AddStaticVehicle(506,-5564.2373,463.9634,1202.5513,270.3636,6,6);//슈퍼지티
	AddStaticVehicle(434,-5564.1172,458.3627,1202.8157,270.9535,12,12);//핫나이프
	AddStaticVehicle(568,-5564.5498,452.6837,1202.7122,270.4475,9,39);//밴디토
	AddStaticVehicle(599,-5585.8979,451.7160,1203.0350,89.2105,0,1);//레인저 스왓차
	AddStaticVehicle(431,-5575.4150,492.0690,1202.9453,269.5607,75,59);//버스
	AddStaticVehicle(581,-5573.8916,511.1669,1202.4429,266.8111,58,1);//비에프 사백
	AddStaticVehicle(521,-5573.3672,515.2238,1202.4177,261.6985,75,13);//에프씨알 구백
	AddStaticVehicle(522,-5573.5234,513.1876,1202.4174,267.1901,3,8);//엔알지 오백
	AddStaticVehicle(589,-5571.3804,535.3465,1202.5044,267.6465,31,31);//각설탕
	AddStaticVehicle(562,-5578.6113,504.8333,1202.5051,268.8300,35,1);//엘리지
	AddStaticVehicle(494,-5587.2285,499.2543,1202.7418,270.8987,36,13);//핫링레이서
	AddStaticVehicle(420,-5559.0005,508.2218,1202.6259,269.1290,6,1);//택시
	AddStaticVehicle(571,-5557.5859,494.4417,1202.1302,267.7126,51,53);//카트
	AddStaticVehicle(571,-5557.6548,492.4236,1202.1300,268.4283,36,2);//카트
	AddStaticVehicle(483,-5571.7544,529.1694,1202.8386,266.7801,1,31);//캠프버스
	AddStaticVehicle(574,-5559.7593,501.9084,1202.5714,268.3122,26,26);//청소차
	AddStaticVehicle(495,-5584.2783,527.4841,1203.1981,267.3839,119,122);//샌드킹
	AddStaticVehicle(463,-5576.7744,514.4185,1202.3873,265.1143,84,84);//할리
	AddStaticVehicle(586,-5576.8643,512.2993,1202.3658,266.8724,122,1);//빅스쿠터
	AddStaticVehicle(448,-5579.6563,513.6465,1202.4456,264.9181,3,6);//피자보이 바이크
	AddStaticVehicle(558,-5578.6787,437.3877,1202.4760,270.6247,116,1);//유라너스
	AddStaticVehicle(565,-5578.8018,441.0735,1202.4718,270.5214,42,42);//각설탕
	AddStaticVehicle(542,-5578.4746,431.1879,1202.5897,271.1795,24,118);//클로버
	AddStaticVehicle(480,-5578.6582,426.0150,1202.6200,271.3641,12,12);//코맷
	AddStaticVehicle(597,-5538.4268,536.3384,1202.6152,272.3951,0,1);//경찰차
	AddStaticVehicle(596,-5538.2202,532.6547,1202.5675,272.4677,0,1);//경찰차
	AddStaticVehicle(598,-5538.0723,528.9080,1202.5919,272.9874,0,1);//경찰차
	AddStaticVehicle(523,-5585.9619,433.9153,1202.4097,270.0562,0,0);//경찰바이크
	AddStaticVehicle(536,-5586.5024,462.4667,1202.5837,89.6173,12,1);//블레이드
	AddStaticVehicle(505,-5658.9712,467.1974,1202.9900,269.8097,14,123);//레인저 노말
	AddStaticVehicle(449,-2351.3936,508.5000,30.0902,90.0000,1,74);//미니기차 트램
	AddStaticVehicle(416,-5649.0190,461.4645,1202.9952,269.1425,1,3);//앰뷸런스
	AddStaticVehicle(427,-5652.0801,475.4883,1202.9784,268.7465,0,1);//스왓트럭
	AddStaticVehicle(468,-5520.6968,488.7578,1202.5145,270.2767,53,53);//산체즈
	AddStaticVehicle(510,-5521.0059,494.2884,1202.4536,276.3862,46,46);//자전거
	AddStaticVehicle(471,-5520.9458,491.3416,1202.3274,275.2037,103,111);//사륜바이크
	AddStaticVehicle(457,-5520.8745,505.1541,1202.4730,269.6941,32,1);//골프차
	AddStaticVehicle(413,-5525.6455,440.3758,1202.9188,269.6849,88,1);//밴 포니
	AddStaticVehicle(566,-5525.1641,449.7829,1202.6261,268.0161,30,8);//로우라이더 타호마
	AddStaticVehicle(458,-5536.7573,419.2223,1202.7223,270.2736,101,1);//카렌스
	AddStaticVehicle(433,-5606.5596,458.5383,1203.2836,269.2668,43,0);//군인차
	AddStaticVehicle(555,-5610.8496,489.8051,1202.5305,270.2315,58,1);//윈드솔러
	AddStaticVehicle(561,-5640.4756,499.7397,1202.6603,269.3660,8,17);//카니발
	AddStaticVehicle(588,-5640.2144,510.0091,1202.7499,268.5399,1,1);//핫도그
	AddStaticVehicle(530,-5606.8623,433.0278,1202.6096,269.4104,111,1);//지게차
	AddStaticVehicle(461,-5525.0347,459.1185,1202.4315,267.0931,61,1);//피씨제이 육백
	AddStaticVehicle(522,-5524.9346,460.5016,1202.4154,267.4744,36,105);//엔알지 오백
	AddStaticVehicle(423,-5525.7065,455.6392,1202.8712,269.2112,1,56);//아이스크립차
	AddStaticVehicle(442,-5632.6841,503.8434,1202.7006,267.9272,11,105);//관 싣는 차
	AddStaticVehicle(415,-5616.1333,506.2698,1202.6178,266.5033,62,1);//치타
	AddStaticVehicle(451,-5615.5649,510.0575,1202.5533,265.6796,125,125);//투리스모
	AddStaticVehicle(603,-5615.7393,514.7059,1202.6847,266.5577,69,1);//피닉스
	AddStaticVehicle(428,-5615.1187,519.5504,1202.9719,266.5967,4,75);//돈훔치는 트럭
	AddStaticVehicle(506,-5615.2759,524.3322,1202.5508,266.8467,52,52);//슈퍼지티
	AddStaticVehicle(402,-5607.2935,517.1904,1202.6781,266.7365,13,13);//버팔로
	AddStaticVehicle(411,-5607.0161,522.8644,1202.5734,265.3925,64,1);//인페르너스 히든
	AddStaticVehicle(530,-5557.6221,398.5803,1202.6028,271.5419,112,1);//지게차
	AddStaticVehicle(583,-5557.2090,403.1018,1202.3798,271.1333,1,1);//돌연변이 청소차
	AddStaticVehicle(437,-5635.1138,408.4637,1202.9796,270.4202,79,7);//관광버스
	AddStaticVehicle(525,-5634.9546,417.4134,1202.7249,269.8448,17,20);//견인차
	AddStaticVehicle(454,-2968.3582,496.2656,0.5154,357.7762,26,26);//트로픽 보트
	AddStaticVehicle(493,-2983.0581,494.1483,0.0039,359.0515,36,13);//제트맥스 보트
	AddStaticVehicle(473,-2978.9409,445.8870,-0.4120,90.4079,56,53);//작은보트
	AddStaticVehicle(452,-2979.1006,434.3736,-1.1512,91.9419,1,5);//스피더 보트
	AddStaticVehicle(563,-2913.0442,497.1964,5.6188,89.3318,1,6);//육지헬기
	AddStaticVehicle(417,-2908.1536,523.7485,-0.3678,88.9528,0,0);//수륙양륙 헬기
	AddStaticVehicle(451,-2899.9749,474.6218,4.6201,90.1957,36,36);//육지 투리스모
	AddStaticVehicle(487,-2898.2986,437.6803,5.1378,90.2580,29,42);//헬기
	AddStaticVehicle(560,-2934.7400,457.3603,4.6111,89.5235,37,0);//술탄
	AddStaticVehicle(580,-5574.7832,542.5239,1202.6367,269.0853,81,81);//갓파더 차량
	AddStaticVehicle(419,-5607.8140,536.7406,1202.6437,270.5002,47,76);//모르는 차량
	AddStaticVehicle(421,-5571.9053,451.4756,1209.1443,270.0960,13,1);//야쿠자 차량
	AddStaticVehicle(556,-5571.9058,459.8892,1209.6417,270.6138,1,1);//몬스터 트럭
	AddStaticVehicle(542,-5537.5103,505.3759,1202.5892,270.6057,24,118);//클로버
	AddStaticVehicle(420,-5537.7070,508.9491,1202.6245,271.5889,6,1);//택시
	AddStaticVehicle(558,-5537.6885,500.6371,1202.4761,270.5327,116,1);//유라너스
	AddStaticVehicle(416,-5625.6436,476.1481,1203.0311,270.0516,1,3);//앰뷸런스
	AddStaticVehicle(451,-5520.6807,513.5558,1202.5516,269.1498,125,125);//투리스모
	AddStaticVehicle(451,-5524.2476,404.6970,1202.5671,269.1498,125,125);//투리스모
	AddStaticVehicle(434,-5537.5161,436.3888,1202.8478,269.4031,12,12);//핫나이프
	AddStaticVehicle(556,-2899.5872,454.6242,5.2926,90.2083,1,1);//육지몬스터
	AddStaticVehicle(411,-2927.2512,451.8643,4.6411,90.7762,64,1);//육지 인페
	AddStaticVehicle(411,-2899.8020,448.2431,4.6471,89.6767,64,3);//육지 인페
	AddStaticVehicle(508,-2889.4575,486.7600,4.6404,90.0356,64,6);//육지 인페
	AddStaticVehicle(493,-2947.1050,570.4872,0.4331,124.5076,36,13);//해상구조대 보트
	AddStaticVehicle(493,-2942.4333,563.5374,0.3736,123.9749,36,13);//해상구조대 보트
	AddStaticVehicle(493,-2937.6199,556.3919,0.3304,123.9749,36,13);//해상구조대 보트
	AddStaticVehicle(563,-2926.8508,574.1608,18.4781,121.7094,1,6);//해상구조대 헬기
	AddStaticVehicle(595,-2942.0696,498.9876,-0.1194,358.6660,112,20);//보트추가
	AddStaticVehicle(454,-2938.4407,174.8377,0.2844,89.3948,26,26);//해적 전용 트로픽
	AddStaticVehicle(454,-2938.5200,167.2103,0.2950,88.7368,26,26);//해적 전용 트로픽
	AddStaticVehicle(454,-2938.3572,160.2301,0.7032,90.5133,26,26);//해적 전용 트로픽
/*	AddStaticVehicle(432,-2705.5623,468.5577,4.1893,359.9216,43,0);//시저탱크*/
	AddStaticVehicle(602,-688.2613,965.4067,11.8570,88.1782,75,77); // 어드민차
	AddStaticVehicle(427,-835.9470,1013.5985,24.2061,191.6320,0,1); //
	AddStaticVehicle(427,-834.2233,994.5598,24.4431,10.1405,0,1); //
	AddStaticVehicle(490,-834.9459,1003.5227,24.5082,94.9014,0,0); //
	AddStaticVehicle(541,-696.6987,932.0510,11.4576,176.2899,60,1); //
	AddStaticVehicle(500,-703.1889,933.4758,12.4820,180.7695,40,84); //
	AddStaticVehicle(497,-655.4713,950.4075,12.3076,359.1955,0,1); //
	AddStaticVehicle(522,-692.3989,946.5189,11.7910,2.6555,7,79); //
	AddStaticVehicle(522,-684.1350,946.9004,11.7031,2.6330,7,79); //
	AddStaticVehicle(562,-666.2129,940.1108,11.8045,358.4064,17,1); //
	AddStaticVehicle(560,-669.8210,946.2644,11.8380,357.7811,21,1); //
	AddStaticVehicle(560,-675.3594,946.4788,11.8523,357.7808,21,1); //
	AddStaticVehicle(431,-679.7843,979.9309,12.2205,91.8828,92,72); //
	AddStaticVehicle(427,-720.8735,990.5170,12.2659,83.1216,0,1); //
	AddStaticVehicle(411,-708.4940,940.1972,12.3377,359.4846,123,1); //
	AddStaticVehicle(573,-723.0294,905.2346,12.7809,176.4709,115,43); //
	AddStaticVehicle(563,-706.2550,916.3931,13.1205,95.3691,1,6); //
	AddStaticVehicle(508,-674.6230,930.0593,12.5078,177.6812,1,1); //
	AddStaticVehicle(508,-669.7185,929.8608,12.5207,177.6822,1,1); //
	AddStaticVehicle(446,-635.8775,859.4244,-0.5968,224.6489,1,5); //
	AddStaticVehicle(409,-679.5231,956.7358,11.9328,91.8479,1,1); //
	AddStaticVehicle(492,-690.1779,957.1171,11.9663,88.7662,77,26); //
	AddStaticVehicle(484,4049.526,-1668.038,0.970,112.0,-1,-1); /*무인도 차*/
	AddStaticVehicle(539,1995.292,1014.918,38.741,293.0,-1,-1);
	AddStaticVehicle(539,2008.280,1015.249,38.741,101.0,-1,-1);
	AddStaticVehicle(539,1999.642,1007.257,38.741,0.0,-1,-1);
	AddStaticVehicle(539,2006.285,1009.016,38.741,304.0,-1,-1);
	AddStaticVehicle(539,2009.137,999.923,38.741,293.0,-1,-1);
	AddStaticVehicle(539,1996.060,1001.320,38.741,259.0,-1,-1);
	AddStaticVehicle(539,2002.519,999.476,38.741,282.0,-1,-1);
	AddStaticVehicle(539,2015.950,1000.136,38.741,33.0,-1,-1);
	AddStaticVehicle(539,2013.390,1011.298,38.741,146.0,-1,-1);
	AddStaticVehicle(539,2000.925,1021.019,38.741,203.0,-1,-1);
	AddStaticVehicle(539,1991.867,1008.293,38.741,259.0,-1,-1);
	AddStaticVehicle(405,-1000.4155,-20.0455,1338.2415,270.0693,36,1); // 시장차 and 픽업
	AddStaticVehicle(522,4987.034,-1063.106,210.003,270.0,-1,-1);   /*오토바이 슛 자동차들*/
	AddStaticVehicle(522,4983.068,-1063.320,210.003,270.0,-1,-1); // spawnpoint (8)
	AddStaticVehicle(522,4978.621,-1062.807,210.003,270.0,-1,-1); // spawnpoint (9)
	AddStaticVehicle(522,4974.211,-1062.826,210.003,270.0,-1,-1); // spawnpoint (10)
	AddStaticVehicle(522,4966.625,-1062.416,209.801,270.0,-1,-1); // spawnpoint (11)
	AddStaticVehicle(522,4960.949,-1061.516,209.801,270.0,-1,-1); // spawnpoint (12)
	AddStaticVehicle(522,4955.012,-1061.847,209.801,270.0,-1,-1); // spawnpoint (13)
	AddStaticVehicle(522,4951.420,-1062.302,209.801,270.0,-1,-1); // spawnpoint (14)
	AddStaticVehicle(522,4948.283,-1062.288,209.801,270.0,-1,-1); // spawnpoint (15)
	AddStaticVehicle(522,5010.933,-1048.279,209.801,270.0,-1,-1); // spawnpoint (16)
	AddStaticVehicle(522,5005.809,-1045.279,209.801,270.0,-1,-1); // spawnpoint (17)
	AddStaticVehicle(522,4999.861,-1044.250,209.801,270.0,-1,-1); // spawnpoint (18)
	AddStaticVehicle(522,4996.343,-1045.240,209.801,270.0,-1,-1); // spawnpoint (19)
	AddStaticVehicle(522,4994.102,-1044.208,209.801,270.0,-1,-1); // spawnpoint (20)
	AddStaticVehicle(522,4988.894,-1043.721,209.801,270.0,-1,-1); // spawnpoint (21)
	AddStaticVehicle(522,4980.328,-1042.455,209.801,270.0,-1,-1); // spawnpoint (22)
	AddStaticVehicle(522,4969.131,-1040.618,209.801,270.0,-1,-1); // spawnpoint (23)
	AddStaticVehicle(522,4954.155,-1039.762,209.801,270.0,-1,-1); // spawnpoint (24)
	AddStaticVehicle(522,4947.853,-1048.129,209.801,270.0,-1,-1); // spawnpoint (25)
	AddStaticVehicle(522,4972.375,-1050.280,209.801,270.0,-1,-1); // spawnpoint (26)
	AddStaticVehicle(522,4982.481,-1051.259,209.801,270.0,-1,-1); // spawnpoint (27)
	AddStaticVehicle(522,4987.521,-1050.130,209.801,270.0,-1,-1); // spawnpoint (28)
	AddStaticVehicle(522,4991.776,-1050.529,209.801,270.0,-1,-1); // spawnpoint (29)
	AddStaticVehicle(522,4995.929,-1050.347,209.801,270.0,-1,-1); // spawnpoint (30)
	AddStaticVehicle(522,4997.575,-1049.551,209.801,270.0,-1,-1); // spawnpoint (31)
	AddStaticVehicle(522,5014.191,-1063.163,210.003,270.0,-1,-1); // spawnpoint
	AddStaticVehicle(522,5009.860,-1063.061,210.003,270.0,-1,-1); // spawnpoint (1)
	AddStaticVehicle(522,5006.336,-1062.921,210.003,270.0,-1,-1); // spawnpoint (2)
	AddStaticVehicle(522,5002.711,-1062.900,210.003,270.0,-1,-1); // spawnpoint (3)
	AddStaticVehicle(522,4998.600,-1063.455,210.003,270.0,-1,-1); // spawnpoint (4)
	AddStaticVehicle(522,4994.367,-1063.047,210.003,270.0,-1,-1); // spawnpoint (5)
	AddStaticVehicle(522,4990.433,-1062.905,210.003,270.0,-1,-1); // spawnpoint (6)
	AddStaticVehicle(405,3447.4370,-2098.2524,3.4355,357.8253,40,1); // 회장님차1
	AddStaticVehicle(411,3451.5166,-2098.4922,3.6731,358.2839,106,1); // 회장님차2
	AddStaticVehicle(418,3447.9932,-2124.0991,3.9965,90.6152,117,227); // 비서차
	AddStaticVehicle(470,3008.6597,-1954.6638,34.6786,271.0302,43,0); // 군인차1
	AddStaticVehicle(470,3008.7205,-1958.0334,34.6847,271.0303,43,0); // 군인차2
	AddStaticVehicle(470,3008.7827,-1961.4980,34.6926,271.0302,43,0); // 군인차3
	AddStaticVehicle(470,3008.8352,-1964.4247,34.6990,271.0301,43,0); // 군인차4
	AddStaticVehicle(470,3008.9004,-1968.0360,34.6991,271.0301,43,0); // 군인차5
	AddStaticVehicle(470,3008.9587,-1971.2827,34.7050,271.0300,43,0); // 군인차6
	AddStaticVehicle(470,3009.0210,-1974.7465,34.7051,271.0300,43,0); // 군인차7
	AddStaticVehicle(470,3009.0801,-1978.0149,34.7051,271.0300,43,0); // 군인차8
	AddStaticVehicle(470,3009.1379,-1981.2129,34.6666,271.0299,43,0); // 군인차9
	AddStaticVehicle(470,3009.1965,-1984.5079,34.6789,271.0298,43,0); // 군인차10
	AddStaticVehicle(470,3009.2573,-1987.8754,34.6862,271.0297,43,0); // 군인차11
	AddStaticVehicle(433,3018.8755,-1938.6779,35.2300,180.3176,43,0); // 군인차12
	AddStaticVehicle(433,3009.5137,-2018.0038,35.2300,270.3262,43,0); // 군인차13
	AddStaticVehicle(427,3016.8428,-2027.0271,34.9313,0.3532,0,1); // 경찰1
	AddStaticVehicle(427,3021.4548,-2026.9982,34.9679,0.3542,0,1); // 경찰2
	AddStaticVehicle(596,3025.1667,-2028.1981,34.4835,1.5534,0,1); // 경찰3
	AddStaticVehicle(596,3028.8254,-2028.0988,34.4835,1.5534,0,1); // 경찰4
	AddStaticVehicle(596,3032.2412,-2028.0060,34.4835,1.5534,0,1); // 경찰5
	AddStaticVehicle(596,3035.7312,-2027.9113,34.4835,1.5534,0,1); // 경찰6
	AddStaticVehicle(596,3039.5391,-2027.8081,34.4835,1.5534,0,1); // 경찰7
	AddStaticVehicle(596,3042.5410,-2027.7264,34.4835,1.5534,0,1); // 경찰8
	AddStaticVehicle(596,3046.5198,-2027.6187,34.4835,1.5534,0,1); // 경찰9
	AddStaticVehicle(596,3050.0828,-2027.5220,34.4835,1.5534,0,1); // 경찰10
	AddStaticVehicle(596,3053.5732,-2027.4276,34.4835,1.5534,0,1); // 경찰11
	AddStaticVehicle(596,3057.2078,-2027.3291,34.4835,1.5534,0,1); // 경찰12
	AddStaticVehicle(596,3060.8215,-2027.2312,34.4835,1.5534,0,1); // 경찰13
	AddStaticVehicle(596,3064.4087,-2027.1340,34.4835,1.5534,0,1); // 경찰14
	AddStaticVehicle(596,3067.7517,-2027.0433,34.4835,1.5534,0,1); // 경찰15
	/*AddStaticVehicle(406,-5518.9458,533.5994,1204.3656,270.0012,1,1);//덩치 (위험)
	AddStaticVehicle(486,-5572.6128,522.1979,1203.0656,268.1058,1,1);//불도저 (위험)
	AddStaticVehicle(532,-5659.5454,452.8902,1203.8319,269.9341,0,0);//하비스트 (위험)*/
    /*========================================================================*/
	StartText = TextDrawCreate(116.000000,165.000000,"~g~Welcome ~w~to ~r~Leehi ~w~Server");
	TextDrawAlignment(StartText,0);
	TextDrawBackgroundColor(StartText,0x000000ff);
	TextDrawFont(StartText,0);
	TextDrawLetterSize(StartText,1.300000,4.700000);
	TextDrawColor(StartText,0xffffffff);
	TextDrawSetOutline(StartText,1);
	TextDrawSetProportional(StartText,1);
	TextDrawSetShadow(StartText,1);/*Made by Son-Nell*/

	GameText = TextDrawCreate(501.000000,102.000000,"Leehi Server");
	TextDrawUseBox(GameText,1);
	TextDrawBoxColor(GameText,0x000000ff);
	TextDrawTextSize(GameText,604.000000,-19.000000);
	TextDrawAlignment(GameText,0);
	TextDrawBackgroundColor(GameText,0x000000ff);
	TextDrawFont(GameText,0);
	TextDrawLetterSize(GameText,0.499999,1.800000);
	TextDrawColor(GameText,0xffffffff);
	TextDrawSetOutline(GameText,1);
	TextDrawSetProportional(GameText,1);
	TextDrawSetShadow(GameText,1);/*Made by Son-Nell*/
	/*========================================================================*/
	DMzone=GangZoneCreate(-3017.740478,390.819793,-2841.740478,542.819824);/*Death Math Zone*/
	/*========================================================================*/
	return 1;
	/*=======================================================================*/
	for(new i = 0; i<MAX_VEHICLES; i++)

	lock[i] = -1;

	return 1;
	/*=======================================================================*/
	 //차량 번호를 저장할 변수를 선언.

	NPC_carid = CreateVehicle(602,-2924.8855,425.7451,4.6979,271.0100,82,77);
}


public money()
{
for(new i=0;i<MAX_PLAYERS;i++)
{
    if(IsPlayerConnected(i))

    {
        SendClientMessage(i, COLOR_LIGHTGREEN, "GM블래스트께서 15000원을 손에 꼭 쥐어주셨습니다.");
        GivePlayerMoney(i,15000);
    }
}
return 1;
}

public OnGameModeExit()
{
    new Hours,Minutes,Seconds,Days,Months,Years;
	gettime(Hours,Minutes,Seconds);
	getdate(Years,Months,Days);
	printf("\n	━━━━━━━━━━━━━━━━━━━━\n");
	printf("	%dMonths %dDay - %d:%d",Months,Days,Hours,Minutes);
	printf("	%s - %s",MODE_NAME,MODE_VERSION);
	printf("	Make By %s",MODE_MAKER);
	printf("	Connectors (%d)",USER_PLAYER);
	printf("	Simultaneous Connectors (%d)",CONSOLE_PLAYER);
	printf("	Server shut down Complete");
	printf("	Find Code (SE-5207R)");
	printf("\n	━━━━━━━━━━━━━━━━━━━━\n");
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
    PlayerSpawn[playerid]=0;/*Copyright(C) Son-Nell*/
	SetPlayerPos(playerid,-2817.6714,1146.0491,20.3782);
	SetPlayerFacingAngle(playerid,329.7769);
	SetPlayerCameraPos(playerid,-2819.2588,1153.3491,20.3783);
	SetPlayerCameraLookAt(playerid,-2818.7070,1141.7084,23.1186);
	SetPlayerInterior(playerid,0);
	ApplyAnimation(playerid,"STRIP","strip_D",4.1,1,0,0,0,0);
	TextDrawShowForPlayer(playerid,StartText);
	TextDrawHideForPlayer(playerid,GameText);
	return 1;
	SetPlayerPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraLookAt(playerid, 1958.3783, 1343.1572, 15.3746);
	return 1;
}

public OnPlayerConnect(playerid)
{
    CONSOLE_PLAYER++; USER_PLAYER++;
    new string[256];
    StopAudioStreamForPlayer(playerid);
    //PlayAudioStreamForPlayer(playerid,"https://dl.dropbox.com/s/0l79fsl4vg6ucqy/%EB%B9%B0%EB%B9%B0%EB%BD%88%EB%A0%88.mp3?dl=1");
    //PlayAudioStreamForPlayer(playerid,"http://pds21.egloos.com/pds/201202/27/18/Brother.mp3");
    //PlayAudioStreamForPlayer(playerid,"https://dl.dropbox.com/s/vd5mmdcr732xraf/Piratas%20do%20Caribe%20-%20He%27s%20a%20Pirate%20%28Theme%29.mp3?dl=1");
    //PlayAudioStreamForPlayer(playerid,"http://maildown.nate.com/app/msg/attachdown/?mboxid=10&msgid=64&fi=1");
	switch(random(3))
	{
	case 0 : {PlayAudioStreamForPlayer(playerid,"https://dl.dropbox.com/s/417xn7nqcj6p0x2/Lee%20Hi%20%28%EC%9D%B4%ED%95%98%EC%9D%B4%29%20-%201%2C2%2C3%2C4.mp3?token_hash=AAG6WDYtPcl3QozVtlou7VOaMrf7rRSsc-D2Ow2FhgvJ3A&dl=1");}
	case 1 : {PlayAudioStreamForPlayer(playerid,"https://dl.dropbox.com/s/2yzaev0nb76d68n/Lee%20Hi%20%28%EC%9D%B4%ED%95%98%EC%9D%B4%29%20-%20It%27s%20Over.mp3?token_hash=AAHHBbxQyn04thsCXe34DK4s7tkaZ6nYgSnTpB7QQK9Oog&dl=1");}
	case 2 : {PlayAudioStreamForPlayer(playerid,"https://dl.dropbox.com/s/zjrnn9utabljwl2/%EC%9D%B4%ED%95%98%EC%9D%B4%20-%20Rose.mp3?token_hash=AAGAI0soMwOZvMXnxerpEEkUleJ6YRLqB97N__S7-bJw5Q&dl=1");}
	}
	new PlayerName[MAX_PLAYER_NAME];
	GetPlayerName(playerid,PlayerName,sizeof(PlayerName));
	Nickname[playerid]=(PlayerName);
	if(!IsPlayerNPC(playerid))
	{
	    format(string,sizeof(string),"(알림) (%d) %s님께서 이하이의 절벽질주를 하려고 오셨습니다. [New player is come]",playerid,PlayerName);
	    SendClientMessageToAll(COLOR_INFO,string);
    }
    ClearChat(playerid,5);
	format(string,sizeof(string),"%s - 어서 오십시오",SERVER_TITLE);
	SendClientMessage(playerid,COLOR_TITLE,string);
    SendClientMessage(playerid,COLOR_ROPE,"━━━━━━━━━━━━━━━━━━━━");
	SendInfoMessage(playerid,"이하이의 절벽 질주 서버에 오신것을 환영합니다");
	SendInfoMessage(playerid,"현재 저희서버가 서버호스팅 사기를 당하였습니다.");
	SendInfoMessage(playerid,"고개숙여 죄송합니다. 빠른시일내로 22시간 복구하겠습니다.");
	SendInfoMessage(playerid,"Here is a Global SA:MP Server. Just enjoying");
	SendInfoMessage(playerid,"Do you visit my server First time? Then you chat /english");
	SetPlayerColor(playerid,PlayerColors[playerid]);
	SetPlayerHealth(playerid,90);
	ResetInfo(playerid);
	return 1;
	OneCreateTextDraw[playerid] = true;
	return 1;
	//vehicleid 는 0부터 시작하기때문에 초기변수를 -1로 설정합니다.

	lockvehicle[playerid] = -1;

	freezing[playerid]=false;

	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    USER_PLAYER--;
    new string[256];
	new PlayerName[MAX_PLAYER_NAME];
	GetPlayerName(playerid,PlayerName,sizeof(PlayerName));
	Nickname[playerid]="";
	DeleteLabel(playerid);
	if(!IsPlayerNPC(playerid))
	{
	    switch(reason)
    	{
		    case 0: format(string,sizeof(string),"(알림) (%d) %s님께서 서버와의 연결이 끊어지셨습니다. (Timeout)",playerid,PlayerName);
		    case 1: format(string,sizeof(string),"(알림) (%d) %s님께서 게임을 종료하셨습니다. (Leave)",playerid,PlayerName);
		    case 2: format(string,sizeof(string),"(알림) (%d) %s님께서 관리자에 의해 강제퇴장 당하셨습니다. (Kick,Ban)",playerid,PlayerName);
		}
		SendClientMessageToAll(COLOR_INFO,string);
    }
	return 1;
	if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid)==PLAYER_STATE_DRIVER)

	{

	//접속 종료시에 차량잠금 해제

	lock[GetPlayerVehicleID(playerid)]=-1;

	}

	freezing[playerid]=false;

	return 1;
	Delete3DTextLabel(ESCDO[playerid]);
	return 1;
}

public Speed()
{
	new
		wplayerid = 0,
		GetPlayers = GetMaxPlayers();

	while(wplayerid != GetPlayers)
	{
		if(IsPlayerConnected(wplayerid) && !IsPlayerNPC(wplayerid))
		{
		    new
				string[128],
				VehicleID = GetPlayerVehicleID(wplayerid);
			if(VehicleID)
			{
		        new
					Float:X,
					Float:Y,
					Float:Z,
					Float:PointToPoint,
					Float:vhealth;
	         	GetVehicleVelocity(VehicleID, X, Y, Z);
	         	PointToPoint = (floatsqroot(floatpower(X, 2) + floatpower(Y, 2) + floatpower(Z, 2)))*100;
				GetVehicleHealth(VehicleID, vhealth);
				format(string,sizeof string ,"Vehicle: %s\nHealth: %.2f\nSpeed: %ikm/h", VehicleName[GetVehicleModel(VehicleID)-400], vhealth, floatround(PointToPoint, floatround_floor));
				if(OneCreateTextDraw[wplayerid] == true)
				{
					speedo3Dtext = CreatePlayer3DTextLabel(wplayerid, string, speedcolor, 0.0,-1.6,-0.35,20.0, INVALID_PLAYER_ID, VehicleID);
					OneCreateTextDraw[wplayerid] = false;
				}
		    	UpdatePlayer3DTextLabelText(wplayerid, speedo3Dtext, speedcolor, string);
			} else if(wplayerid) {
			    if(OneCreateTextDraw[wplayerid] == false)
			    {
					DeletePlayer3DTextLabel(wplayerid, speedo3Dtext);
		        	OneCreateTextDraw[wplayerid] = true;
				}
			}
		}
		wplayerid++;
	}
	return 1;
}

public OnFilterScriptExit()
{
	KillTimer(Speedoff);
	for(new forplayerid; forplayerid < MAX_PLAYERS; forplayerid++)
	{
		DeletePlayer3DTextLabel(forplayerid, speedo3Dtext);
	}
	return 1;
}

public OnPlayerSpawn(playerid)
{
	IconPlayer(playerid);
    SafeHealth(playerid);
    TextDrawHideForPlayer(playerid,StartText);
    TextDrawShowForPlayer(playerid,GameText);
    GivePlayerWeapon(playerid,46,100000);
	if(DriveKill[playerid]==1)
	{
	    SetPlayerPos(playerid,Pos[0],Pos[1],Pos[2]);
	    DriveKill[playerid]=0;
	    GameTextForPlayer(playerid,"~b~Funny ~w~Game",1000,3);
    }
	return 1;
	new playername[256];
	GetPlayerName(playerid,playername,sizeof(playername)); //이름을 얻습니다.
	if(IsPlayerNPC(playerid)) //NPC인지 확인 (NPC도 일반 유저처럼 playerid를 배정 받습니다.
	{
	    if(strcmp(playername,"바산행스포츠카",true) == 0) //아까 추가한 NPC의 이름이 맞는지 확인.
	        PutPlayerInVehicle(playerid,NPC_carid,0); //차량에 집어넣기.
	}

}

public OnPlayerDeath(playerid, killerid, reason)
{
    PlayerSpawn[playerid]=0;
    SendDeathMessage(killerid,playerid,reason);
    if(GetPlayerState(killerid)==PLAYER_STATE_ONFOOT)
    {
	    if(PlayerToPoint(65,playerid,-2921.5676,468.3167,4.9141))
		{
            GivePlayerMoney(killerid,1000);
	    	GameTextForPlayer(killerid,"~r~Kill ~w~Bonus~n~~g~$~w~1000",3000,3);
		}
		else
		{
		    GameTextForPlayer(killerid,"~r~This not ~y~DM Zone~n~~w~Going To ~r~DM ~y~Zone",3000,3);
		    SendInfoMessage(killerid,"데스매치는 미니맵의 빨간 육지부분에서만 합시다~");
		    GiveWarring(killerid);
		}
	}
		
	if(GetPlayerState(killerid)==PLAYER_STATE_DRIVER)
	{
	    RespawnCheck(killerid);
	    GameTextForPlayer(killerid,"~b~Please ~w~Don't~n~~r~Drive ~w~Kill",3000,3);
	    SetPlayerHealth(killerid,0);
	    GetPlayerPos(playerid,Pos[0],Pos[1],Pos[2]);
		DriveKill[playerid]=1;
		SendInfoMessage(killerid,"당신은 사람을 차로 죽였습니다,차로죽이는 킬은 무효입니다");
		SendInfoMessage(playerid,"당신은 사고를 당했습니다 잠시후 위치가 복구됩니다");
	}
	return 1;
}

public OnVehicleSpawn(vehicleid)
{

//차량이 스폰될때 잠금상태 해제
lock[vehicleid] = -1;
return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
   	if(!strcmp(text,"카페주소", true))
	{
		SendClientMessageToAll(green, "채팅BOT Systems :{FFFFFF} 네이버 검색창에 GTA산안드레스 이하이서버 를 검색해주세요!");
	}
 	if(!strcmp(text,"고멤하는법", true))
	{
		SendClientMessageToAll(green, "채팅BOT Systems :{FFFFFF} 카페가입 - 가입인사 - 고멤신청 순서로 하시면 됩니다^^");
	}
	if(!strcmp(text,"무기얻는법", true))
	{
		SendClientMessageToAll(green, "채팅BOT Systems :{FFFFFF} /무기 를 하시면 각종 무기 습득명령어를 보실수 있습니다.");
	}
	if(!strcmp(text,"GM신청법", true))
	{
		SendClientMessageToAll(green, "채팅BOT Systems :{FFFFFF} 고멤하는법을 숙지후 GM신청을 해주시면됩니다.");
	}
	if(!strcmp(text,"노래신청법", true))
	{
		SendClientMessageToAll(green, "채팅BOT Systems :{FFFFFF} /노래목록 을 보셔서 노래목록들을 숙지 하신뒤 부관리자 이상의 관리자에게 번호를 말해주세요.");
	}
	if(!strcmp(text,"노래추가신청법", true))
	{
		SendClientMessageToAll(green, "채팅BOT Systems :{FFFFFF} [※고멤만 가능합니다] 카페에 있는 노래추가신청 게시판에 글을남겨주세요.");
	}
	if(!strcmp(text,"신고하는방법", true))
	{
		SendClientMessageToAll(green, "채팅BOT Systems :{FFFFFF} /GM목록 명령어를 이용하여 접속해있는 GM에게 /귓말 로 신고를 해주시기바랍니다.");
	}
	if(!strcmp(text,"재미난놀거리", true))
	{
		SendClientMessageToAll(green, "채팅BOT Systems :{FFFFFF} /텔포 를 이용하면 저희서버만의 각종 옵젝을 이용하실수 있습니다.");
	}
    SetPlayerChatBubble(playerid, text, COLOR_WHITE, 30.0, 5000); //머리위에 말창
    PlayerPlaySound(playerid, 1139, 0.0, 0.0, 0.0); //말하면 소리
    new PlayerName[MAX_PLAYER_NAME];
	GetPlayerName(playerid,PlayerName,sizeof(PlayerName));
   	new string[256];
	format(string,sizeof(string),"(%d) %s 》%s",playerid,Nickname[playerid],text);
    SendClientMessageToAll(GetPlayerColor(playerid),string);
	return 0;
}

new COunt=6;
public Countdown()
{
{
 if(COunt==6){
 GameTextForAll("~r~5",1100,3);
 SetTimer("Countdown",1000,0);
 COunt--;
 }
 else if(COunt==5){
 GameTextForAll("~r~4",1100,3);
 SetTimer("Countdown",1000,0);
 COunt--;
 }
 else if(COunt==4){
 GameTextForAll("~r~3",1100,3);
 SetTimer("Countdown",1000,0);
 COunt--;
 }
 else if(COunt==3){
 GameTextForAll("~y~2",1000,3);
 SetTimer("Countdown",1000,0);
 COunt--;
 }
 else if(COunt==2){
 GameTextForAll("~y~1",1000,3);
 SetTimer("Countdown",1000,0);
 COunt--;
 }
 else if(COunt==1){
 GameTextForAll("~y~GO~g~GO~r~GO",1000,3);
 COunt=6;
 }
 }
 }



public OnPlayerCommandText(playerid, cmdtext[])/*Son-Nell Commands*/
{
	/*========================================================================*/
	new name[MAX_PLAYER_NAME];
	new str[256];
	new string[256];
	new PlayerName[MAX_PLAYER_NAME];
	GetPlayerName(playerid,PlayerName,sizeof(PlayerName));
	new MyVehicle=GetPlayerVehicleID(playerid);
	new idx,cmd[256]; cmd=strtok(cmdtext,idx);
	/*========================================================================*/
	if(strcmp("/help",cmdtext,true,10)==0||strcmp("/도움말",cmdtext,true,10)==0||strcmp("/?",cmdtext,true,10)==0)
	{
	    ClearChat(playerid,6);
		format(string,sizeof(string),"%s - 게임 도움말",SERVER_TITLE);
		SendClientMessage(playerid,COLOR_TITLE,string);
		SendClientMessage(playerid,COLOR_ROPE,"━━━━━━━━━━━━━━━━━━━━");
		SendFreeMessage(playerid,"명령어","[각종텔레포트: /텔포] [차량자동수리: /자동수리]");
		SendFreeMessage(playerid,"명령어","[리스폰: /re /kill] [무기얻기: /무기] [닉네임: /r (입력)]");
		SendFreeMessage(playerid,"명령어","[싸움기술: /무술] [노래신청: /노래목록] [체력 및 아머: /구매]");
		if(IsPlayerAdmin(playerid))
		{
		    SendFreeMessage(playerid,"관리자","[모든차복구: /차리스폰] [채팅창삭제: /지우개] [노래목록보기: /노래목록]");
		}
		return 1;
 	}
	/*==============================카운트다운===================================*/
	if (strcmp("/카운트다운",cmdtext) == 0)
	{
		Countdown();
		GetPlayerName(playerid,name,sizeof(name));
		format(str,sizeof(str)," %s님이 카운터 다운을 합니다.",name);
		SendClientMessageToAll(AQUA,str);
		return 1;
	}
 	/*================================업데이트 한것들===============================*/
	if(strcmp("/프로토타입",cmdtext,true)==0)
    {
    if(IsPlayerAdmin(playerid))
    {
	SetPlayerSkin(playerid,29);
	GivePlayerWeapon(playerid,4,1);
	SetPlayerAttachedObject( playerid, 0, 339, 6, -0.632497, -0.011946, -0.356025, 3.398799, 338.460876, 0.000000, 10.409181, 1.000000, 2.212146 ); // katana - p.1
	SetPlayerAttachedObject( playerid, 1, 339, 6, -0.498661, 0.018250, 0.075347, 177.213485, 359.639434, 0.000000, 8.072420, 1.000000, 2.050485 ); // katana - p.2
	}
	return 1;
	}
	if(strcmp("/프로토타입2",cmdtext,true)==0)
    {
    if(IsPlayerAdmin(playerid))
    {
	SetPlayerSkin(playerid,29);
	GivePlayerWeapon(playerid,4,1);
	SetPlayerAttachedObject( playerid, 0, 339, 14, 0.259601, -0.047791, 0.067374, 1.548442, 80.325965, 16.162498, 1.000000, 1.000000, 1.000000 ); // katana - p123
	SetPlayerAttachedObject( playerid, 1, 339, 14, 0.304448, 0.008143, 0.094352, 347.440032, 81.195472, 12.698534, 1.000000, 1.000000, 1.000000 ); // katana - p123
	SetPlayerAttachedObject( playerid, 2, 339, 15, 0.015867, 0.014437, -0.057570, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000 ); // katana - p123
	SetPlayerAttachedObject( playerid, 3, 339, 16, 0.054114, 0.022642, 0.073751, 0.752900, 187.971267, 179.579986, 1.000000, 1.000000, 1.000000 ); // katana - p123
	SetPlayerAttachedObject( playerid, 4, 339, 13, 0.239039, 0.000000, -0.070480, 151.348983, 83.711349, 0.000000, 1.000000, 1.000000, 1.000000 ); // katana - p123
	SetPlayerAttachedObject( playerid, 5, 339, 13, 0.238105, -0.021289, -0.076657, 145.337203, 94.804229, 11.157792, 1.000000, 1.000000, 1.000000 ); // katana - p123
	}
	return 1;
	}
	if(strcmp("/프로토타입3",cmdtext,true)==0)
    {
    if(IsPlayerAdmin(playerid))
    {
	SetPlayerSkin(playerid,29);
	GivePlayerWeapon(playerid,4,1);
	SetPlayerAttachedObject( playerid, 0, 341, 14, -0.036963, -0.186637, -0.142187, 115.081069, 38.760452, 0.922761, 1.442675, 1.000000, 1.654858 );
	}
	return 1;
	}
	if(strcmp("/프로토타입4",cmdtext,true)==0)
    {
    if(IsPlayerAdmin(playerid))
    {
	SetPlayerSkin(playerid,29);
	GivePlayerWeapon(playerid,4,1);
	SetPlayerAttachedObject( playerid, 0, 345, 3, 0.060273, -0.019446, -0.017534, 349.731719, 14.029537, 281.617584, 1.000000, 1.000000, 1.000000 );
	}
	return 1;
	}
	if(strcmp("/고스트라이더",cmdtext,true)==0)
    {
    if(IsPlayerAdmin(playerid))
    {
    SetPlayerAttachedObject( playerid, 0, 18688, 17, 0.126607, -0.185391, -1.651622, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000 );
	}
	return 1;
	}
	if(strcmp("/능력자",cmdtext,true)==0)
    {
    if(IsPlayerAdmin(playerid))
    {
    SetPlayerAttachedObject( playerid, 0, 18688, 5, 0.000000, -1.075653, -1.402693, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000 ); // fire - 8
	SetPlayerAttachedObject( playerid, 1, 18688, 6, 0.000000, -1.075653, -1.402693, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000 ); // fire - 8
	}
	return 1;
	}
	if(strcmp("/각성",cmdtext,true)==0)
    {
    if(IsPlayerAdmin(playerid))
    {
    SetPlayerAttachedObject( playerid, 0, 18689, 5, 0.000000, -1.075653, -1.402693, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000 ); // fire - 8
	SetPlayerAttachedObject( playerid, 1, 18689, 6, 0.000000, -1.075653, -1.402693, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000 ); // fire - 8
	}
	return 1;
	}
	if(strcmp("/후광",cmdtext,true)==0)
    {
    if(IsPlayerAdmin(playerid))
    {
	SetPlayerAttachedObject( playerid, 0, 18728, 1, -0.061580, 1.421013, 0.000000, 93.489868, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000 );
	}
	return 1;
	}
	if(strcmp("/화카",cmdtext,true)==0)
    {
    if(IsPlayerAdmin(playerid))
    {
	GivePlayerWeapon(playerid,8,1);
	SetPlayerAttachedObject( playerid, 0, 18694, 6, 0.075941, 1.638598, -0.009210, 91.633728, 0.141938, 0.276635, 1.000000, 1.000000, 1.000000 );
	}
	return 1;
	}
	if(strcmp("/제거",cmdtext,true)==0)
	{
	SendClientMessage(playerid, COLOR_ERROR, "System : 당신은 모든 이펙트 및 오브젝트를 제거했습니다");
 	RemovePlayerAttachedObject(playerid,0);
    RemovePlayerAttachedObject(playerid,1);
    RemovePlayerAttachedObject(playerid,2);
    RemovePlayerAttachedObject(playerid,3);
    RemovePlayerAttachedObject(playerid,4);
   	RemovePlayerAttachedObject(playerid,5);
    RemovePlayerAttachedObject(playerid,6);
    RemovePlayerAttachedObject(playerid,7);
    RemovePlayerAttachedObject(playerid,8);
    RemovePlayerAttachedObject(playerid,9);
   	return 1;
 	}

	/*============================업데이트 한것================================*/
	if (strcmp(cmdtext, "/현재시간", true)==0 || strcmp(cmdtext, "/시각") == 0 || strcmp(cmdtext, "/rtime") == 0)
	{
	new Hours;
	new Minutes;
	new Seconds;
	new Days;
	new Months;
	new Years;
	new string[256];
	gettime(Hours, Minutes, Seconds);
	getdate(Years, Months, Days);
	format(string, sizeof(string), " + %d년 %d월 %d일, 현재 시간  %d시 %d분 %d초 ", Years,Months,Days,Hours,Minutes,Seconds);
	SendClientMessage(playerid,0xFFFFFFAA,string);
	return 1;
	}
//--------------------------------------------------------------------------------//
	if(strcmp(cmdtext, "/애니도움말") == 0 || strcmp(cmdtext, "/애니헬미") == 0 || strcmp(cmdtext, "/애니help") == 0)
	{
	SendClientMessage(playerid,0x9FB1EEAA, "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓");
	SendClientMessage(playerid,0xFFFFFFAA, " /스킨 , /애니 , /rtime ,/색 ,/술담배 ,/infos  ");
	SendClientMessage(playerid,0x9FB1EEAA, "┗━━━━━━━━━━━━━━━━ BY.C.L.N_Vlast━━━━━━━┛");
	return 1;
	}
	if(strcmp(cmdtext, "/infos") == 0)
	{
	SendClientMessage(playerid,0x9FB1EEAA, "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓");
	SendClientMessage(playerid,0xFFFFFFAA, "    http://cafe.naver.com/leehi123/ ==>이하이 서버 카페!! ");
	SendClientMessage(playerid,0xFFFFFFAA, "    이하이절벽질주는 위대합니다!! ");
	SendClientMessage(playerid,0xFFFFFFAA, "    각종 애니 도움말은 /애니도움말!!");
	SendClientMessage(playerid,0xFFFFFFAA, "    저작권 은 C.L.N_Vlast 외에 체로 어드민님에게 있습니다.");
	SendClientMessage(playerid,0x9FB1EEAA, "┗━━━━━━━━━━━━━━━━BY.C.L.N_Vlast━━━━━━━━━┛");
	return 1;
	}
	if(strcmp(cmdtext, "/행동") == 0 || strcmp(cmdtext, "/애니") == 0 || strcmp(cmdtext, "/애니1") == 0)
	{
	SendClientMessage(playerid,0x9FB1EEAA, "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓");
	SendClientMessage(playerid,0xFFFFFFAA, " /인사, /응원, /대화, /앉기, /누워, /여기      ");
	SendClientMessage(playerid,0xFFFFFFAA, " /걸음, /점프, /실소, /젠장, /달려, /기특      ");
	SendClientMessage(playerid,0xFFFFFFAA, " /키스, /야호, /니킥, /건들, /시비, /낚시 /술담배   ");
	SendClientMessage(playerid,0xFFFFFFAA, " /담배, /형님, /존경, /집합, /태극권/복싱연습    ");
	SendClientMessage(playerid,0xFFFFFFAA, " /애니2    ");
	SendClientMessage(playerid,0x9FB1EEAA, "┗━━━━━━━━━━━━━━━BY.C.L.N_Vlast━━━━━━━━━━┛");
	return 1;
	}
	if(strcmp(cmdtext, "/술담배") == 0 || strcmp(cmdtext, "/술담배  ") == 0 || strcmp(cmdtext, "/술담배  ") == 0)
	{
	SendClientMessage(playerid,0x9FB1EEAA, "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓");
	SendClientMessage(playerid,0xFFFFFFAA, " /술 /술1 /술2      ");
	SendClientMessage(playerid,0xFFFFFFAA, " /담배      ");
	SendClientMessage(playerid,0xFFFFFFAA, " /마리화나      ");
	SendClientMessage(playerid,0xFFFFFFAA, " /음료수   ");
	SendClientMessage(playerid,0x9FB1EEAA, "┗━━━━━━━━━━━━BY.C.L.N_Vlast━━━━━━━━━━━━━┛");
	return 1;
	}
    if(strcmp(cmdtext, "/행동2") == 0 || strcmp(cmdtext, "/애니2") == 0)
	{
	SendClientMessage(playerid,0x9FB1EEAA, "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓");
	SendClientMessage(playerid,0xFFFFFFAA, " /손, /겁, /엿, /흥, /쉬, /잠, /술, /물        ");
	SendClientMessage(playerid,0xFFFFFFAA, " /콱, /악, /폰, /토, /랩, /롤, /딸, /춤        ");
	SendClientMessage(playerid,0xFFFFFFAA, " /돌려차, /스트립, /나이스 /엎드리기 /박기      ");
	SendClientMessage(playerid,0xFFFFFFAA, " /애니3 ");
	SendClientMessage(playerid,0x9FB1EEAA, "┗━━━━━━━━━━━━━━BY.C.L.N_Vlast━━━━━━━━━━━┛");
	return 1;
	}
	if(strcmp(cmdtext, "/행동3") == 0 || strcmp(cmdtext, "/애니3") == 0)
	{
	SendClientMessage(playerid,0x9FB1EEAA, "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓");
	SendClientMessage(playerid,0xFFFFFFAA, " (경찰):/경통과, /경정지, /경수갑, (조직)/조칼들기, /조앉기, /조협박, /조직   ");
	SendClientMessage(playerid,0xFFFFFFAA, " /조인사, /조복종, /갱인사, /갱인사2, (담배)/담배털기");
	SendClientMessage(playerid,0xFFFFFFAA, " /담배불, /걸담배(응급)/응급처치, /수술, /수술2 /발작    ");
	SendClientMessage(playerid,0xFFFFFFAA, " /애니3 ");
	SendClientMessage(playerid,0x9FB1EEAA, "┗━━━━━━━━━━━━━━━BY.C.L.N_Vlast━━━━━━━━━━┛");
	return 1;
	}

 if(strcmp(cmdtext, "/경통과", true) == 0)
   {
   if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
   {
   ApplyAnimation(playerid,"POLICE","CopTraf_Away",4.1,0,1,1,1,1);
   }
   return 1;
   }
   if(strcmp(cmdtext, "/경정지", true) == 0)
   {
   if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
   {
   ApplyAnimation(playerid,"POLICE","CopTraf_Stop",4.1,0,1,1,1,1);
   }
   return 1;
   }
   if(strcmp(cmdtext, "/경수갑", true) == 0)
   {
   if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
   {
   ApplyAnimation(playerid,"PED","pass_Smoke_in_car",4.1,0,1,1,1,1);
   }
   return 1;
   }
   //조직애니
   if(strcmp(cmdtext, "/조칼들기", true) == 0)
   {
   if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
   {
   ApplyAnimation(playerid,"CRACK","Bbalbat_Idle_02",4.1,0,1,1,1,1);
   }
   return 1;
   }
   if(strcmp(cmdtext, "/조앉기", true) == 0)
   {
   if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
   {
   ApplyAnimation(playerid,"JST_BUISNESS","girl_02",4.1,0,1,1,1,1);
   }
   return 1;
   }
   if(strcmp(cmdtext, "/조협박", true) == 0)
   {
   if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
   {
   ApplyAnimation(playerid,"TEC","TEC_reload",4.1,0,1,1,1,1);
   }
   return 1;
   }
   if(strcmp(cmdtext, "/조직", true) == 0)
   {
   if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
   {
   ApplyAnimation(playerid,"DEALER","DEALER_IDLE",4.1,0,1,1,1,1);
   }
   return 1;
   }
   if(strcmp(cmdtext, "/조인사", true) == 0)
   {
   if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
   {
   ApplyAnimation(playerid,"FAT","IDLE_tired",4.1,0,1,1,1,1);
   }
   return 1;
   }
   if(strcmp(cmdtext, "/조복종", true) == 0)
   {
   if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
   {
   ApplyAnimation(playerid,"COP_AMBIENT","Copbrowse_in",4.1,0,1,1,1,1);
   }
   return 1;
   }
   //갱애니
   if(strcmp(cmdtext, "/갱인사", true) == 0)
   {
   if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
   {
   ApplyAnimation(playerid,"RIOT","RIOT_ANGRY",4.1,0,1,1,1,1);
   }
   return 1;
   }
   if(strcmp(cmdtext, "/갱인사2", true) == 0)
   {
   if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
   {
   ApplyAnimation(playerid,"GANGS","hndshkfa",4.1,0,1,1,1,1);
   }
   return 1;
   }
   //담배애니
   if(strcmp(cmdtext, "/담배털기", true) == 0)
   {
   if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
   {
   ApplyAnimation(playerid,"SMOKING","M_smk_tap",4.1,0,1,1,1,1);
   }
   return 1;
   }
   if(strcmp(cmdtext, "/담배불", true) == 0)
   {
   if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
   {
   ApplyAnimation(playerid,"SMOKING","M_smk_in",4.1,0,1,1,1,1);
   }
   return 1;
   }
   if(strcmp(cmdtext, "/걸담배", true) == 0)
   {
   if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
   {
   ApplyAnimation(playerid,"GANGS","drnkbr_prtl",4.1,0,1,1,1,1);
   }
   return 1;
   }
   //병원애니
   if(strcmp(cmdtext, "/응급처치", true) == 0)
   {
   if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
   {
   ApplyAnimation(playerid,"MEDIC","CPR",4.1,0,1,1,1,1);
   }
   return 1;
   }
   if(strcmp(cmdtext, "/수술", true) == 0)
   {
   if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
   {
   ApplyAnimation(playerid,"INT_SHOP","shop_cashier",4.1,0,1,1,1,1);
   }
   return 1;
   }
   if(strcmp(cmdtext, "/수술2", true) == 0)
   {
   if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
   {
   ApplyAnimation(playerid,"INT_SHOP","shop_in",4.1,0,1,1,1,1);
   }
   return 1;
   }
   if(strcmp(cmdtext, "/발작", true) == 0)
   {
   if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
   {
   ApplyAnimation(playerid,"PED","KD_left",4.1,0,1,1,1,1);
   }
   return 1;
   }
	if(strcmp(cmdtext, "/손", true) == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_HANDSUP);
	}
	return 1;
	}
	}

	if(strcmp(cmdtext, "/태극권", true) == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"PARK","Tai_Chi_Loop",4.1,1,1,1,1,1);
    SendClientMessage(playerid,0xFFFFFFAA, "≫≫ 태극권을 수련하며 체력을 회복합니다. (/태극권 애니매이션은 체력회복기능)");
	SetPlayerHealth(playerid,100);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/달려", true) == 0) {
	ApplyAnimation(playerid,"SWAT","swt_go",4.1,1,1,1,1,1);
	new str[256];
	new playername[MAX_PLAYER_NAME];
    GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
    format(str, sizeof(str), " %s 님이 비명을 지릅니다. 워~매 오빠 달료!!!!!.", playername);
	SendClientMessageToAll(0xFFFFFFAA, str);
	return 1;
	}
	if(strcmp(cmdtext, "/쉬", true) == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_PISSING);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/겁", true) == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"PED","DUCK_cower",4.1,0,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/엿", true) == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"PED","fucku",4.1,1,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/흥", true) == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"OTB","wtchrace_in",4.1,0,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/젠장") == 0)
	{
	SendClientMessage(playerid,0xFF0000FF, "≫  /젠장 [1~2] ");
	return 1;
	}
	if(strcmp(cmdtext, "/젠장 1", true) == 0 || strcmp(cmdtext, "/젠장1") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"BSKTBALL","BBALL_react_miss",4.1,1,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/젠장 2", true) == 0 || strcmp(cmdtext, "/젠장2") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"OTB","wtchrace_lose",4.1,1,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/실소", true) == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
    ApplyAnimation(playerid,"RAPPING","Laugh_01",4.1,0,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/건들") == 0)
	{
	SendClientMessage(playerid,0xFF0000FF, "≫  /건들 [1~2] ");
	return 1;
	}
	if(strcmp(cmdtext, "/건들 1", true) == 0 || strcmp(cmdtext, "/건들1") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
    ApplyAnimation(playerid,"RAPPING","RAP_B_Loop",4.1,1,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/건들 2", true) == 0 || strcmp(cmdtext, "/건들2") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
    ApplyAnimation(playerid,"RAPPING","RAP_C_Loop",4.1,1,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/나이스", true) == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"CASINO","manwinb",4.1,0,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/담배피기", true) == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"SMOKING","M_smk_in",4.1,1,1,1,1,1);
	new str[256];
	new playername[MAX_PLAYER_NAME];
    GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
    format(str, sizeof(str), " %s 님이 담배를 꼬나물고 한탄합니다. 워~따 징하게 할일 없고마잉!.", playername);
	SendClientMessageToAll(0xFFFFFFAA, str);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/앉기") == 0)
	{
	SendClientMessage(playerid,0xFFFFFFAA, "≫  /앉기 [1~20] ");
	return 1;
	}
	if(strcmp(cmdtext, "/앉기 1", true) == 0 || strcmp(cmdtext, "/앉기1") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"JST_BUISNESS","girl_02",4.1,0,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/앉기 2", true) == 0 || strcmp(cmdtext, "/앉기2") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"Attractors","Stepsit_in",4.1,0,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/앉기 3", true) == 0 || strcmp(cmdtext, "/앉기3") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"INT_OFFICE","OFF_Sit_Bored_Loop",4.1,0,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/앉기 4", true) == 0 || strcmp(cmdtext, "/앉기4") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"INT_OFFICE","OFF_Sit_Crash",4.1,0,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/앉기 5", true) == 0 || strcmp(cmdtext, "/앉기5") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"INT_OFFICE","OFF_Sit_Drink",4.1,0,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/앉기 6", true) == 0 || strcmp(cmdtext, "/앉기6") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"INT_OFFICE","OFF_Sit_Idle_Loop",4.1,0,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/앉기 7", true) == 0 || strcmp(cmdtext, "/앉기7") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"INT_OFFICE","OFF_Sit_In",4.1,0,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/앉기 8", true) == 0 || strcmp(cmdtext, "/앉기8") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"INT_OFFICE","OFF_Sit_Read",4.1,0,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/앉기 9", true) == 0 || strcmp(cmdtext, "/앉기9") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"INT_OFFICE","OFF_Sit_Type_Loop",4.1,0,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/앉기 10", true) == 0 || strcmp(cmdtext, "/앉기10") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"FOOD","FF_Dam_Bkw",4.1,0,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/앉기 11", true) == 0 || strcmp(cmdtext, "/앉기11") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"FOOD","FF_Die_Bkw",4.1,0,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/앉기 12", true) == 0 || strcmp(cmdtext, "/앉기12") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"FOOD","FF_Die_Fwd",4.1,0,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/앉기 13", true) == 0 || strcmp(cmdtext, "/앉기13") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"FOOD","FF_Sit_Eat1",4.1,0,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/앉기 14", true) == 0 || strcmp(cmdtext, "/앉기14") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"FOOD","FF_Sit_In",4.1,0,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/앉기 15", true) == 0 || strcmp(cmdtext, "/앉기15") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"FOOD","FF_Sit_In",4.1,0,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/앉기 16", true) == 0 || strcmp(cmdtext, "/앉기16") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"FOOD","FF_Sit_In_L",4.1,0,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/앉기 17", true) == 0 || strcmp(cmdtext, "/앉기17") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"FOOD","FF_Sit_In_R",4.1,0,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/앉기 18", true) == 0 || strcmp(cmdtext, "/앉기18") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"FOOD","FF_Sit_Out_180",4.1,0,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/앉기 19", true) == 0 || strcmp(cmdtext, "/앉기19") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"FOOD","FF_Sit_Out_L_180",4.1,0,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/앉기 20", true) == 0 || strcmp(cmdtext, "/앉기20") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"FOOD","FF_Sit_Out_R_180",4.1,0,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/누워") == 0)
	{
	SendClientMessage(playerid,0xFFFFFFAA, "≫  /누워 [1~13] ");
	return 1;
	}
	if(strcmp(cmdtext, "/누워 1", true) == 0 || strcmp(cmdtext, "/누워1") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"SUNBATHE","batherup",4.1,0,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/누워 2", true) == 0 || strcmp(cmdtext, "/누워2") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"SUNBATHE","Lay_Bac_in",4.1,0,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/누워 3", true) == 0 || strcmp(cmdtext, "/누워3") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"SUNBATHE","Lay_Bac_out",4.1,0,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/누워 4", true) == 0 || strcmp(cmdtext, "/누워4") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"SUNBATHE","ParkSit_M_IdleA",4.1,0,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/누워 5", true) == 0 || strcmp(cmdtext, "/누워5") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"SUNBATHE","ParkSit_M_in",4.1,0,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/누워 6", true) == 0 || strcmp(cmdtext, "/누워6") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"SUNBATHE","ParkSit_M_out",4.1,0,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/누워 7", true) == 0 || strcmp(cmdtext, "/누워7") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"SUNBATHE","ParkSit_W_idleA",4.1,0,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/누워 8", true) == 0 || strcmp(cmdtext, "/누워8") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"SUNBATHE","ParkSit_W_idleB",4.1,0,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/누워 9", true) == 0 || strcmp(cmdtext, "/누워9") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"SUNBATHE","ParkSit_W_idleC",4.1,0,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/누워 10", true) == 0 || strcmp(cmdtext, "/누워10") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"SUNBATHE","ParkSit_W_in",4.1,0,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/누워 11", true) == 0 || strcmp(cmdtext, "/누워11") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"SUNBATHE","ParkSit_W_out",4.1,0,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/누워 12", true) == 0 || strcmp(cmdtext, "/누워12") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"SUNBATHE","SitnWait_in_W",4.1,0,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/누워 13", true) == 0 || strcmp(cmdtext, "/누워13") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"SUNBATHE","SitnWait_out_W",4.1,0,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/잠") == 0)
	{
	SendClientMessage(playerid,0xFF0000FF, "≫  /잠 [1~3] ");
	return 1;
	}
	if(strcmp(cmdtext, "/잠 1", true) == 0 || strcmp(cmdtext, "/잠1") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"CRACK","crckdeth1",4.1,0,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/잠 2", true) == 0 || strcmp(cmdtext, "/잠2") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"CRACK","crckdeth2",4.1,1,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/잠 3", true) == 0 || strcmp(cmdtext, "/잠3") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"CRACK","crckdeth3",4.1,0,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/술걷기", true) == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"PED","WALK_DRUNK",4.1,1,1,1,1,1);
	}
	return 1;
	}
	}

	if(strcmp(cmdtext, "/낚시", true) == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"PED","ARRESTgun",4.1,0,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/대화") == 0)
	{
	SendClientMessage(playerid,0xFF0000FF, "≫  /대화 [1~4] ");
	return 1;
	}
	if(strcmp(cmdtext, "/대화 1", true) == 0 || strcmp(cmdtext, "/대화1") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"PED","IDLE_CHAT",4.1,1,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/대화 2", true) == 0 || strcmp(cmdtext, "/대화2") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"GHANDS","gsign4",4.1,1,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/대화 3", true) == 0 || strcmp(cmdtext, "/대화3") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"GHANDS","gsign5",4.1,1,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/대화 4", true) == 0 || strcmp(cmdtext, "/대화4") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"RIOT","RIOT_challenge",4.1,1,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/물", true) == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"VENDING","VEND_Drink_P",4.1,0,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/형님", true) == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"COP_AMBIENT","Copbrowse_in",4.1,0,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/춤") == 0)
	{
	SendClientMessage(playerid,0xFFFFFFAA, "≫  /춤[1~12] ");
	return 1;
	}
	if(strcmp(cmdtext, "/춤 1", true) == 0 || strcmp(cmdtext, "/춤1") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"DANCING","dnce_M_a",4.1,1,1,1,1,1);
	new str[256];
	new playername[MAX_PLAYER_NAME];
    GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
    format(str, sizeof(str), " %s 님이 저질댄스를 추기시작합니다. 쉐이껴 바뤼 무브~무브~♪ ", playername);
	SendClientMessageToAll(0xFFFFFFAA, str);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/춤 2", true) == 0 || strcmp(cmdtext, "/춤2") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"DANCING","dnce_M_d",4.1,1,1,1,1,1);
	new str[256];
	new playername[MAX_PLAYER_NAME];
    GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
    format(str, sizeof(str), " %s 님이 달건이춤을 추기시작합니다. 음메~ 좋은거~♪ ", playername);
	SendClientMessageToAll(0xFFFFFFAA, str);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/춤 3", true) == 0 || strcmp(cmdtext, "/춤3") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"DANCING","dnce_M_e",4.1,1,1,1,1,1);
	new str[256];
	new playername[MAX_PLAYER_NAME];
    GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
    format(str, sizeof(str), " %s 님이 광년이댄스를 추기시작합니다. 암 고나비어 뱃~보이~♪ ", playername);
	SendClientMessageToAll(0xFFFFFFAA, str);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/춤 4", true) == 0 || strcmp(cmdtext, "/춤4") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"DANCING","DAN_Down_A",4.1,1,1,1,1,1);
	new str[256];
	new playername[MAX_PLAYER_NAME];
    GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
    format(str, sizeof(str), " %s 님이 저질댄스를 추기시작합니다. 쉐이낏~쉐이낏~♪ ", playername);
	SendClientMessageToAll(0xFFFFFFAA, str);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/춤 5", true) == 0 || strcmp(cmdtext, "/춤5") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"DANCING","DAN_Left_A",4.1,1,1,1,1,1);
	new str[256];
	new playername[MAX_PLAYER_NAME];
    GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
    format(str, sizeof(str), " %s 님이 광년이댄스를 추기시작합니다. 암 고나비어 뱃~보이~♪ ", playername);
	SendClientMessageToAll(0xFFFFFFAA, str);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/춤 6", true) == 0 || strcmp(cmdtext, "/춤6") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"DANCING","DAN_Loop_A",4.1,1,1,1,1,1);
	new str[256];
	new playername[MAX_PLAYER_NAME];
    GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
    format(str, sizeof(str), " %s 님이 느끼댄스를 추기시작합니다. 컴온~베베~♪ ", playername);
	SendClientMessageToAll(0xFFFFFFAA, str);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/춤 7", true) == 0 || strcmp(cmdtext, "/춤7") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"DANCING","DAN_Right_A",4.1,1,1,1,1,1);
	new str[256];
	new playername[MAX_PLAYER_NAME];
    GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
    format(str, sizeof(str), " %s 님이 나이트댄스를 추기시작합니다. 에압~베베~♪ ", playername);
	SendClientMessageToAll(0xFFFFFFAA, str);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/춤 8", true) == 0 || strcmp(cmdtext, "/춤8") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"DANCING","DAN_Up_A",4.1,1,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/춤 9", true) == 0 || strcmp(cmdtext, "/춤9") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/춤 10", true) == 0 || strcmp(cmdtext, "/춤10") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE2);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/춤 11", true) == 0 || strcmp(cmdtext, "/춤11") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE3);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/춤 12", true) == 0 || strcmp(cmdtext, "/춤12") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE4);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/니킥", true) == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"SHOP","SHP_Jump_Launch",4.1,1,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/걸음") == 0)
	{
	SendClientMessage(playerid,0xFFFFFFAA, "≫  /걸음 [1~5] ");
	return 1;
	}
	if(strcmp(cmdtext, "/걸음 1", true) == 0 || strcmp(cmdtext, "/걸음1") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"PED","WOMAN_runbusy",4.1,1,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/걸음 2", true) == 0 || strcmp(cmdtext, "/걸음2") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"PED","woman_runpanic",4.1,1,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/걸음 3", true) == 0 || strcmp(cmdtext, "/걸음3") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"PED","WOMAN_walkpro",4.1,1,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/걸음 4", true) == 0 || strcmp(cmdtext, "/걸음4") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"JST_BUISNESS","girl_01",4.1,1,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/걸음 5", true) == 0 || strcmp(cmdtext, "/걸음5") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"PED","WOMAN_walksexy",4.1,1,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/응원") == 0)
	{
	SendClientMessage(playerid,0xFFFFFFAA, "≫  /응원 [1~5] ");
	return 1;
	}
	if(strcmp(cmdtext, "/응원 1", true) == 0 || strcmp(cmdtext, "/응원1") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"RIOT","RIOT_CHANT",4.1,1,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/응원 2", true) == 0 || strcmp(cmdtext, "/응원2") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"ON_LOOKERS","shout_02",4.1,1,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/응원 3", true) == 0 || strcmp(cmdtext, "/응원3") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"OTB","wtchrace_win",3.5,1,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/응원 4", true) == 0 || strcmp(cmdtext, "/응원4") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"RIOT","RIOT_PUNCHES",4.1,1,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/응원 5", true) == 0 || strcmp(cmdtext, "/응원5") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"RIOT","RIOT_shout",4.1,1,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/복싱연습", true) == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"GYMNASIUM","gym_shadowbox",4.1,1,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/스트립") == 0)
	{
	SendClientMessage(playerid,0xFFFFFFAA, "≫  /스트립 [1~5] ");
	return 1;
	}
	if(strcmp(cmdtext, "/스트립 1", true) == 0 || strcmp(cmdtext, "/스트립1") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"STRIP","STR_A2B",4.1,1,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/스트립 2", true) == 0 || strcmp(cmdtext, "/스트립2") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"STRIP","STR_B2C",4.1,1,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/스트립 3", true) == 0 || strcmp(cmdtext, "/스트립3") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"STRIP","STR_C1",4.1,1,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/스트립 4", true) == 0 || strcmp(cmdtext, "/스트립4") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"STRIP","STR_C2",4.1,1,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/스트립 5", true) == 0 || strcmp(cmdtext, "/스트립5") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"STRIP","STR_Loop_C",3,1,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/기특", true) == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"SWEET","sweet_ass_slap",4.1,0,1,1,1,1);
	}
	return 1;
	}
	}

	if(strcmp(cmdtext, "/딸", true) == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"PAULNMAC","wank_loop",4.1,1,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/인사") == 0)
	{
	SendClientMessage(playerid,0xFFFFFFAA, "≫  /인사[1~5] ");
	return 1;
	}
	if(strcmp(cmdtext, "/인사 1", true) == 0 || strcmp(cmdtext, "/인사1") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"KISSING","gfwave2",4.1,1,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/인사 2", true) == 0 || strcmp(cmdtext, "/인사2") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"SCRATCHING","scdrulp",4.1,1,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/인사 3", true) == 0 || strcmp(cmdtext, "/인사3") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"GHANDS","gsign1LH",4.1,1,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/인사 4", true) == 0 || strcmp(cmdtext, "/인사4") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"GHANDS","gsign2LH",4.1,1,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/인사 5", true) == 0 || strcmp(cmdtext, "/인사5") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"RIOT","RIOT_ANGRY",4.1,0,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/콱", true) == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"RIOT","RIOT_ANGRY_B",4.1,0,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/여기") == 0)
	{
	SendClientMessage(playerid,0xFFFFFFAA, "≫  /여기 [1~2] ");
	return 1;
	}
	if(strcmp(cmdtext, "/여기 1", true) == 0 || strcmp(cmdtext, "/여기1") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"ON_LOOKERS","Pointup_in",4.1,0,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/여기 2", true) == 0 || strcmp(cmdtext, "/여기2") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"SCRATCHING","scdlulp",4.1,1,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/야호", true) == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"ON_LOOKERS","shout_01",4.1,1,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/악") == 0)
	{
	SendClientMessage(playerid,0xFFFFFFAA, "≫  /악 [1~7] ");
	return 1;
	}
	if(strcmp(cmdtext, "/악 1", true) == 0 || strcmp(cmdtext, "/악1") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"PED","KO_shot_face",4.1,0,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/악 2", true) == 0 || strcmp(cmdtext, "/악2") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"PED","KO_shot_stom",4.1,0,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/악 3", true) == 0 || strcmp(cmdtext, "/악3") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"SWEET","LaFin_Sweet",4.1,0,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/악 4", true) == 0 || strcmp(cmdtext, "/악4") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"MD_CHASE","Carhit_Tumble",4.1,0,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/악 5", true) == 0 || strcmp(cmdtext, "/악5") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"MD_CHASE","MD_BIKE_Lnd_Roll",4.1,0,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/악 6", true) == 0 || strcmp(cmdtext, "/악6") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"PED","BIKE_fallR",4.1,0,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/악 7", true) == 0 || strcmp(cmdtext, "/악7") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"PED","BIKE_fall_off",4.1,0,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/시비") == 0)
	{
	SendClientMessage(playerid,0xFFFFFFAA, "≫  /시비 [1~2] ");
	return 1;
	}
	if(strcmp(cmdtext, "/시비 1", true) == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"PED","DAM_armL_frmBK",4.1,0,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/시비 2", true) == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"PED","DAM_armR_frmBK",4.1,0,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/점프") == 0)
	{
	SendClientMessage(playerid,0xFFFFFFAA, "≫  /점프 [1~4] ");
	return 1;
	}
	if(strcmp(cmdtext, "/점프 1", true) == 0 || strcmp(cmdtext, "/점프1") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"DAM_JUMP","DAM_Launch",4.1,0,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/점프 2", true) == 0 || strcmp(cmdtext, "/점프2") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"DAM_JUMP","Jump_Roll",4.1,0,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/점프 3", true) == 0 || strcmp(cmdtext, "/점프3") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"DAM_JUMP","SF_JumpWall",4.1,0,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/점프 4", true) == 0 || strcmp(cmdtext, "/점프4") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"DAM_JUMP","DAM_Dive_Loop",4.1,0,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/폰") == 0)
	{
	SendClientMessage(playerid,0xFFFFFFAA, "≫  /폰 [1~2] ");
	return 1;
	}
	if(strcmp(cmdtext, "/폰 1", true) == 0 || strcmp(cmdtext, "/폰1") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_USECELLPHONE);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/폰 2", true) == 0 || strcmp(cmdtext, "/폰2") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_STOPUSECELLPHONE);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/키스", true) == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"KISSING","Grlfrd_Kiss_02",4.1,0,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/토", true) == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"FOOD","EAT_Vomit_P",4.1,0,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/랩", true) == 0) {
	ApplyAnimation(playerid,"LAPDAN3","LAPDAN_D",4.1,1,1,1,1,1);
	new str[256];
	new playername[MAX_PLAYER_NAME];
    GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
    format(str, sizeof(str), " %s 님이 랩댄스를 추기시작합니다. 에헤~~라 디여~~♪ ", playername);
	SendClientMessageToAll(0xFFFFFFAA, str);
	return 1;
	}
	if(strcmp(cmdtext, "/롤", true) == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"SKATE","skate_run",4.1,1,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/돌려차") == 0)
	{
	SendClientMessage(playerid,0xFFFFFFAA, "≫  /돌려차 [1~2] ");
	return 1;
	}
	if(strcmp(cmdtext, "/돌려차 1", true) == 0 || strcmp(cmdtext, "/돌려차1") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"SWAT","JMP_Wall1m_180",4.1,1,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/돌려차 2", true) == 0 || strcmp(cmdtext, "/돌려차1") == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	{
	ApplyAnimation(playerid,"SWAT","Rail_fall",4.1,0,1,1,1,1);
	}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/집합", true) == 0) {
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
    {
    ApplyAnimation(playerid,"DEALER","DEALER_IDLE",4.1,1,1,1,1,1);
    }
    return 1;
    }
    }
    if(strcmp(cmdtext, "/존경", true) == 0) {
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
    {
    ApplyAnimation(playerid,"COP_AMBIENT","Copbrowse_in",4.1,0,1,1,1,1);
    }
    return 1;
    }
    }
    if(strcmp(cmdtext, "/엎드리기", true) == 0) {
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
    {
    ApplyAnimation(playerid,"PED","cower",4.1,0,1,1,1,1);
    }
    return 1;
    }
    }
    if(strcmp(cmdtext, "/눕기", true) == 0) {
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
    {
    ApplyAnimation(playerid,"CRACK","crckidle2",4.1,1,1,1,1,1);
    }
    return 1;
    }
    }
    if(strcmp(cmdtext, "/투명", true) == 0) {
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
    {
    ApplyAnimation(playerid,"DAM_JUMP","SF_JumpWall",4.1,0,1,1,1,1);
    }
    return 1;
    }
    }
    if(strcmp(cmdtext, "/박기", true) == 0) {
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
    {
    ApplyAnimation(playerid,"BIKED","BIKEd_Back",4.1,1,1,1,1,1);
    }
    return 1;
    }
    }
    if (strcmp(cmdtext, "/엘보우", true)==0) // 무술, 30만원으로 되어있음
    {
    if (GetPlayerMoney(playerid) > 299999) // 30만원이니까 299999 원 이상이면 명령어가 가동되게.
    {
    SetPlayerFightingStyle (playerid, FIGHT_STYLE_ELBOW);
    GivePlayerMoney(playerid, -300000); // 30만원을 깎음
    }
    else // 돈이없다면
    {
    SendClientMessage(playerid, 0xFFFFFFAA, "** 돈이 부족합니다.");
    }
    return 1;
    }
    // 아래의 무술들도 같은원리
    if (strcmp(cmdtext, "/복싱", true)==0)
    {
    if (GetPlayerMoney(playerid) > 299999)
    {
    SetPlayerFightingStyle (playerid, FIGHT_STYLE_BOXING);
    GivePlayerMoney(playerid, -300000);
    }
    else
    {
    SendClientMessage(playerid, 0xFFFFFFAA, "** 돈이 부족합니다.");
    }
    return 1;
    }
    if (strcmp(cmdtext, "/그랩킥", true)==0)
    {
    if (GetPlayerMoney(playerid) > 299999)
    {
    SetPlayerFightingStyle (playerid, FIGHT_STYLE_GRABKICK);
    GivePlayerMoney(playerid, -300000);
    }
    else
    {
    SendClientMessage(playerid, 0xFFFFFFAA, "** 돈이 부족합니다.");
    }
    return 1;
    }
    if (strcmp(cmdtext, "/닉헤드", true)==0)
    {
    if (GetPlayerMoney(playerid) > 299999)
    {
    SetPlayerFightingStyle (playerid, FIGHT_STYLE_KNEEHEAD);
    GivePlayerMoney(playerid, -300000);
    }
    else
    {
    SendClientMessage(playerid, 0xFFFFFFAA, "** 돈이 부족합니다.");
    }
    return 1;
    }
    if (strcmp(cmdtext, "/쿵푸", true)==0)
    {
    if (GetPlayerMoney(playerid) > 299999)
    {
    SetPlayerFightingStyle (playerid, FIGHT_STYLE_KUNGFU);
    GivePlayerMoney(playerid, -300000);
    }
    else
    {
    SendClientMessage(playerid, 0xFFFFFFAA, "** 돈이 부족합니다.");
    }
    return 1;
    }
    if (strcmp(cmdtext, "/기본공격", true)==0)
    {
    SetPlayerFightingStyle (playerid, FIGHT_STYLE_NORMAL);
    return 1;
    }
    if (strcmp(cmdtext, "/마리화나", true)==0)
    {
    if (GetPlayerMoney(playerid) > 149999)
    {
    SetPlayerDrunkLevel(playerid, 50000);
    SetPlayerWeather(playerid, 209);
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_SMOKE_CIGGY);
    SendClientMessage(playerid, 0xFFFFFFAA, "** 마리화나를 없앨려면 /정상모드 를 입력하세요.");
    GivePlayerMoney(playerid, -150000);
    }
    else
    {
    SendClientMessage(playerid, 0xFFFFFFAA, "** 돈이 부족합니다.");
    }
    return 1;
    }
    if (strcmp(cmdtext, "/담배", true)==0)
    {
    if (GetPlayerMoney(playerid) > 149999)
    {
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_SMOKE_CIGGY);
    SendClientMessage(playerid, 0xFFFFFFAA, "** 담배를 없앨려면 /정상모드 를 입력하세요.");
    GivePlayerMoney(playerid, -150000);
    }
    else
    {
    SendClientMessage(playerid, 0xFFFFFFAA, "** 돈이 부족합니다.");
    }
    return 1;
    }
    if (strcmp(cmdtext, "/술", true)==0)
    {
    if (GetPlayerMoney(playerid) > 1)
    {
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_WINE);
    SendClientMessage(playerid, 0xFFFFFFAA, "** 술을 없앨려면 /정상모드 를 입력하세요.");
    GivePlayerMoney(playerid, -10000);
    }
    else
    {
    SendClientMessage(playerid, 0xFFFFFFAA, "** 돈이 부족합니다.");
    }
    return 1;
    }
    if (strcmp(cmdtext, "/술1", true)==0)
    {
    if (GetPlayerMoney(playerid) > 1)
    {
	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DRINK_BEER);
    SendClientMessage(playerid, 0xFFFFFFAA, "** 술을 없앨려면 /정상모드 를 입력하세요.");
    GivePlayerMoney(playerid, -10000);
    }
    else
    {
    SendClientMessage(playerid, 0xFFFFFFAA, "** 돈이 부족합니다.");
    }
    return 1;
    }
    if (strcmp(cmdtext, "/술2", true)==0)
    {
    if (GetPlayerMoney(playerid) > 1)
    {
	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DRINK_WINE);
    SendClientMessage(playerid, 0xFFFFFFAA, "** 술을 없앨려면 /정상모드 를 입력하세요.");
    GivePlayerMoney(playerid, -10000);
    }
    else
    {
    SendClientMessage(playerid, 0xFFFFFFAA, "** 돈이 부족합니다.");
    }
    return 1;
    }
    if (strcmp(cmdtext, "/음료수", true)==0)
    {
    if (GetPlayerMoney(playerid) > 1)
    {
	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DRINK_SPRUNK);
    SendClientMessage(playerid, 0xFFFFFFAA, "** 음료수를 없앨려면 /정상모드 를 입력하세요.");
    GivePlayerMoney(playerid, -10000);
    }
    else
    {
    SendClientMessage(playerid, 0xFFFFFFAA, "** 돈이 부족합니다.");
    }
    return 1;
    }
    if(!strcmp(cmdtext, "/정상모드", true))
    {
	SetPlayerDrunkLevel(playerid, 0);
	SetPlayerWeather(playerid, 1);
	ClearAnimations(playerid);
    return 1;
    }
	if (strcmp("/카메라", cmdtext, true, 10) == 0)
	{
		GivePlayerWeapon(playerid,43,10);
		return 1;
	}
	if (strcmp("/낙하산", cmdtext, true, 10) == 0)
	{
		GivePlayerWeapon(playerid,46,1);
		return 1;
	}
    if(strcmp(cmdtext, "/색", true) == 0 || strcmp(cmdtext, "/색깔") == 0)
	{
    SendClientMessage(playerid, 0xFFFFFFAA, "/색 [1~52]");
	return 1;
	}

	if(strcmp(cmdtext, "/색 1", true) == 0 || strcmp(cmdtext, "/색 1") == 0)
	{
	SetPlayerColor(playerid, 0xFF000096);
	return 1;
	}


	if(strcmp(cmdtext, "/색 2", true) == 0 || strcmp(cmdtext, "/색 2") == 0)
	{
	SetPlayerColor(playerid, 0xA6000096);
	return 1;
	}


	if(strcmp(cmdtext, "/색 3", true) == 0 || strcmp(cmdtext, "/색 3") == 0)
	{
	SetPlayerColor(playerid, 0xFF9900AA);
	return 1;
	}


	if(strcmp(cmdtext, "/색 4", true) == 0 || strcmp(cmdtext, "/색 4") == 0)
	{
	SetPlayerColor(playerid, 0xFF4500AA);
	return 1;
	}

	if(strcmp(cmdtext, "/색 5", true) == 0 || strcmp(cmdtext, "/색 5") == 0)
	{
	SetPlayerColor(playerid, 0xFA8072AA);
	return 1;
	}

	if(strcmp(cmdtext, "/색 6", true) == 0 || strcmp(cmdtext, "/색 6") == 0)
	{
	SetPlayerColor(playerid, 0xFF00FFFF);
	return 1;
	}

	if(strcmp(cmdtext, "/색 7", true) == 0 || strcmp(cmdtext, "/색 7") == 0)
	{
	SetPlayerColor(playerid, 0x8B008BAA);
	return 1;
	}

	if(strcmp(cmdtext, "/색 8", true) == 0 || strcmp(cmdtext, "/색 8") == 0)
	{
	SetPlayerColor(playerid, 0xDC143CAA);
	return 1;
	}

	if(strcmp(cmdtext, "/색 9", true) == 0 || strcmp(cmdtext, "/색 9") == 0)
	{
	SetPlayerColor(playerid, 0xFF7F50AA);
	return 1;
	}

	if(strcmp(cmdtext, "/색 10", true) == 0 || strcmp(cmdtext, "/색 10") == 0)
	{
	SetPlayerColor(playerid, 0xFFC0CBAA);
	return 1;
	}

	if(strcmp(cmdtext, "/색 11", true) == 0 || strcmp(cmdtext, "/색 11") == 0)
	{
	SetPlayerColor(playerid, 0xFF6347AA);
	return 1;
	}

	if(strcmp(cmdtext, "/색 12", true) == 0 || strcmp(cmdtext, "/색 12") == 0)
	{
	SetPlayerColor(playerid, 0xEE82EEFF);
	return 1;
	}

	if(strcmp(cmdtext, "/색 13", true) == 0 || strcmp(cmdtext, "/색 13") == 0)
	{
	SetPlayerColor(playerid, 0x33AA33AA);
	return 1;
	}

	if(strcmp(cmdtext, "/색 14", true) == 0 || strcmp(cmdtext, "/색 14") == 0)
	{
	SetPlayerColor(playerid, 0x00800096);
	return 1;
	}

	if(strcmp(cmdtext, "/색 15", true) == 0 || strcmp(cmdtext, "/색 15") == 0)
	{
	SetPlayerColor(playerid, 0x10F441AA);
	return 1;
	}


	if(strcmp(cmdtext, "/색 16", true) == 0 || strcmp(cmdtext, "/색 16") == 0)
	{
	SetPlayerColor(playerid, 0x7CFC00AA);
	return 1;
	}

	if(strcmp(cmdtext, "/색 17", true) == 0 || strcmp(cmdtext, "/색 17") == 0)
	{
	SetPlayerColor(playerid, 0x32CD32AA);
	return 1;
	}

	if(strcmp(cmdtext, "/색 18", true) == 0 || strcmp(cmdtext, "/색 18") == 0)
	{
	SetPlayerColor(playerid, 0x20B2AAAA);
	return 1;
	}

	if(strcmp(cmdtext, "/색 19", true) == 0 || strcmp(cmdtext, "/색 19") == 0)
	{
	SetPlayerColor(playerid, 0x2E8B57AA);
	return 1;
	}

	if(strcmp(cmdtext, "/색 20", true) == 0 || strcmp(cmdtext, "/색 20") == 0)
	{
	SetPlayerColor(playerid, 0x00FF7FAA);
	return 1;
	}

	if(strcmp(cmdtext, "/색 21", true) == 0 || strcmp(cmdtext, "/색 21") == 0)
	{
	SetPlayerColor(playerid, 0x9ACD32AA);
	return 1;
	}

	if(strcmp(cmdtext, "/색 22", true) == 0 || strcmp(cmdtext, "/색 22") == 0)
	{
	SetPlayerColor(playerid, 0xCBFEA9AA);
	return 1;
	}

	if(strcmp(cmdtext, "/색 23", true) == 0 || strcmp(cmdtext, "/색 23") == 0)
	{
	SetPlayerColor(playerid, 0x7FFF00AA);
	return 1;
	}

	if(strcmp(cmdtext, "/색 24", true) == 0 || strcmp(cmdtext, "/색 24") == 0)
	{
	SetPlayerColor(playerid, 0x6FA7FB96);
	return 1;
	}

	if(strcmp(cmdtext, "/색 25", true) == 0 || strcmp(cmdtext, "/색 24") == 0)
	{
	SetPlayerColor(playerid, 0x4169FFAA);
	return 1;
	}

	if(strcmp(cmdtext, "/색 26", true) == 0 || strcmp(cmdtext, "/색 24") == 0)
	{
	SetPlayerColor(playerid, 0x191970AA);
	return 1;
	}

	if(strcmp(cmdtext, "/색 27", true) == 0 || strcmp(cmdtext, "/색 24") == 0)
	{
	SetPlayerColor(playerid, 0x0000A896);
	return 1;
	}

	if(strcmp(cmdtext, "/색 28", true) == 0 || strcmp(cmdtext, "/색 24") == 0)
	{
	SetPlayerColor(playerid, 0x33CCFFAA);
	return 1;
	}

	if(strcmp(cmdtext, "/색 29", true) == 0 || strcmp(cmdtext, "/색 24") == 0)
	{
	SetPlayerColor(playerid, 0x6495EDAA);
	return 1;
	}

	if(strcmp(cmdtext, "/색 30", true) == 0 || strcmp(cmdtext, "/색 24") == 0)
	{
	SetPlayerColor(playerid, 0x3F63CCAA);
	return 1;
	}

	if(strcmp(cmdtext, "/색 31", true) == 0 || strcmp(cmdtext, "/색 24") == 0)
	{
	SetPlayerColor(playerid, 0x000080AA);
	return 1;
	}

	if(strcmp(cmdtext, "/색 32", true) == 0 || strcmp(cmdtext, "/색 24") == 0)
	{
	SetPlayerColor(playerid, 0xF0F8FFAA);
	return 1;
	}

	if(strcmp(cmdtext, "/색 33", true) == 0 || strcmp(cmdtext, "/색 24") == 0)
	{
	SetPlayerColor(playerid, 0x83BFBFAA);
	return 1;
	}

	if(strcmp(cmdtext, "/색 34", true) == 0 || strcmp(cmdtext, "/색 24") == 0)
	{
	SetPlayerColor(playerid, 0x00FFFFAA);
	return 1;
	}

	if(strcmp(cmdtext, "/색 35", true) == 0 || strcmp(cmdtext, "/색 24") == 0)
	{
	SetPlayerColor(playerid, 0x4B00B0AA);
	return 1;
	}

	if(strcmp(cmdtext, "/색 36", true) == 0 || strcmp(cmdtext, "/색 24") == 0)
	{
	SetPlayerColor(playerid, 0xEFEFF7AA);
	return 1;
	}

	if(strcmp(cmdtext, "/색 37", true) == 0 || strcmp(cmdtext, "/색 24") == 0)
	{
	SetPlayerColor(playerid, 0xFFFF00AA);
	return 1;
	}

	if(strcmp(cmdtext, "/색 38", true) == 0 || strcmp(cmdtext, "/색 24") == 0)
	{
	SetPlayerColor(playerid, 0xADFF2FAA);
	return 1;
	}

	if(strcmp(cmdtext, "/색 39", true) == 0 || strcmp(cmdtext, "/색 24") == 0)
	{
	SetPlayerColor(playerid, 0xF0E68CAA);
	return 1;
	}

	if(strcmp(cmdtext, "/색 40", true) == 0 || strcmp(cmdtext, "/색 24") == 0)
	{
	SetPlayerColor(playerid, 0xFFFF82AA);
	return 1;
	}

	if(strcmp(cmdtext, "/색 41", true) == 0 || strcmp(cmdtext, "/색 24") == 0)
	{
	SetPlayerColor(playerid, 0xE3B92496);
	return 1;
	}

	if(strcmp(cmdtext, "/색 42", true) == 0 || strcmp(cmdtext, "/색 24") == 0)
	{
	SetPlayerColor(playerid, 0xC1762B96);
	return 1;
	}

	if(strcmp(cmdtext, "/색 43", true) == 0 || strcmp(cmdtext, "/색 24") == 0)
	{
	SetPlayerColor(playerid, 0x80400096);
	return 1;
	}

	if(strcmp(cmdtext, "/색 44", true) == 0 || strcmp(cmdtext, "/색 24") == 0)
	{
	SetPlayerColor(playerid, 0xFFE4C4AA);
	return 1;
	}

	if(strcmp(cmdtext, "/색 45", true) == 0 || strcmp(cmdtext, "/색 24") == 0)
	{
	SetPlayerColor(playerid, 0x800000AA);
	return 1;
	}

	if(strcmp(cmdtext, "/색 46", true) == 0 || strcmp(cmdtext, "/색 24") == 0)
	{
	SetPlayerColor(playerid, 0xD8BFD8FF);
	return 1;
	}

	if(strcmp(cmdtext, "/색 47", true) == 0 || strcmp(cmdtext, "/색 24") == 0)
	{
	SetPlayerColor(playerid, 0xFFFFFF96);
	return 1;
	}

	if(strcmp(cmdtext, "/색 48", true) == 0 || strcmp(cmdtext, "/색 24") == 0)
	{
	SetPlayerColor(playerid, 0xD2D2D296);
	return 1;
	}

	if(strcmp(cmdtext, "/색 49", true) == 0 || strcmp(cmdtext, "/색 24") == 0)
	{
	SetPlayerColor(playerid, 0x80808096);
	return 1;
	}

	if(strcmp(cmdtext, "/색 50", true) == 0 || strcmp(cmdtext, "/색 24") == 0)
	{
	SetPlayerColor(playerid, 0xAFAFAFAA);
	return 1;
	}

	if(strcmp(cmdtext, "/색 51", true) == 0 || strcmp(cmdtext, "/색 24") == 0)
	{
	SetPlayerColor(playerid, 0x00000096);
	return 1;
	}

    if(strcmp(cmdtext, "/색 52", true) == 0 || strcmp(cmdtext, "/색 24") == 0)
	{
	SetPlayerColor(playerid, 0x00FF7FAA);
	return 1;
	}

    if(strcmp(cmdtext, "/투명이름", true) == 0 || strcmp(cmdtext, "/투명이름") == 0)
	{
	SetPlayerColor(playerid, 0xFFFFFF00);
	return 1;
	}
 	if(strcmp(cmdtext, "/skin") == 0 || strcmp(cmdtext, "/SKIN") == 0 || strcmp(cmdtext, "/스킨") == 0)
	{
	SendClientMessage(playerid,0xFF0000FF, "≫  /스킨[1~3] ");
	return 1;
	}
	if(strcmp(cmdtext, "/skin1") == 0 || strcmp(cmdtext, "/스킨1") == 0 || strcmp(cmdtext, "/SKIN1") == 0)
	{
	SendClientMessage(playerid,0x9FB1EEAA, "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓  ");
	SendClientMessage(playerid,0xFFFFFFAA, "     /복서1~2, /조깅1~4, /기사, /기장, /뚱보, /엘비스");
	SendClientMessage(playerid,0xFFFFFFAA, "     /노숙자1~8, /농부1~2, /아저씨1~3, /치킨         ");
	SendClientMessage(playerid,0xFFFFFFAA, "     /경호원1~4, /할매1~3, /할배1~2, /사장1~3        ");
	SendClientMessage(playerid,0xFFFFFFAA, "     /비키니1~2, /여자1~7, /비서1~2, /햄버거, /피자  ");
	SendClientMessage(playerid,0xFFFFFFAA, "     /짱깨1~3, /롤러1~2, /이발사1~3, /주차요원       ");
	SendClientMessage(playerid,0x9FB1EEAA, "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛   ");
	return 1;
	}
	if(strcmp(cmdtext, "/skin2") == 0 || strcmp(cmdtext, "/스킨2") == 0 || strcmp(cmdtext, "/SKIN2") == 0)
	{
	SendClientMessage(playerid,0x9FB1EEAA, "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓  ");
	SendClientMessage(playerid,0xFFFFFFAA, "     /씨제이, /빅스모크, /라이더, /스위트, /오지록 ");
	SendClientMessage(playerid,0xFFFFFFAA, "     /달건1~6                                      ");
	SendClientMessage(playerid,0xFFFFFFAA, "     /그루브1~3, /마약1~5                          ");
	SendClientMessage(playerid,0xFFFFFFAA, "     /보라1~3, /노랑1~3, /연두1~3, /삼합1~3        ");
	SendClientMessage(playerid,0xFFFFFFAA, "                                                   ");
	SendClientMessage(playerid,0x9FB1EEAA, "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛ ");
	return 1;
	}
	if(strcmp(cmdtext, "/skin3") == 0 || strcmp(cmdtext, "/스킨3") == 0 || strcmp(cmdtext, "/SKIN3") == 0)
	{
	SendClientMessage(playerid,0x9FB1EEAA, "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓ ");
	SendClientMessage(playerid,0xFFFFFFAA, "     /군인                                        ");
	SendClientMessage(playerid,0xFFFFFFAA, "     /경찰1~8, /소방관1~3                         ");
	SendClientMessage(playerid,0xFFFFFFAA, "     /스왓, /FBI1~4                               ");
	SendClientMessage(playerid,0xFFFFFFAA, "                                                  ");
	SendClientMessage(playerid,0x9FB1EEAA, "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛");
	return 1;
	}
	if(strcmp(cmdtext, "/빅스모크", true) == 0)
	{
	SetPlayerSkin(playerid, 269);
    SendClientMessage(playerid,0xFFFFFFAA, "빅스모크 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/스위트", true) == 0)
	{
	SetPlayerSkin(playerid, 270);
    SendClientMessage(playerid,0xFFFFFFAA, "스위트 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/라이더", true) == 0)
	{
	SetPlayerSkin(playerid, 271);
	SendClientMessage(playerid,0xFFFFFFAA, "라이더 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/씨제이", true) == 0)
	{
	SetPlayerSkin(playerid, 0);
    SendClientMessage(playerid,0xFFFFFFAA, "씨제이 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/오지록", true) == 0)
	{
	SetPlayerSkin(playerid, 293);
    SendClientMessage(playerid,0xFFFFFFAA, "O.G.Loc 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/노숙자1", true) == 0)
	{
	SetPlayerSkin(playerid, 137);
	SendClientMessage(playerid,0xFFFFFFAA, "노숙자 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/노숙자2", true) == 0)
	{
	SetPlayerSkin(playerid, 162);
	SendClientMessage(playerid,0xFFFFFFAA, "노숙자 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/노숙자3", true) == 0)
	{
	SetPlayerSkin(playerid, 230);
	SendClientMessage(playerid,0xFFFFFFAA, "노숙자 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/노숙자4", true) == 0)
	{
	SetPlayerSkin(playerid, 134);
	SendClientMessage(playerid,0xFFFFFFAA, "노숙자 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/노숙자5", true) == 0)
	{
	SetPlayerSkin(playerid, 200);
	SendClientMessage(playerid,0xFFFFFFAA, "노숙자 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/노숙자6", true) == 0)
	{
	SetPlayerSkin(playerid, 135);
	SendClientMessage(playerid,0xFFFFFFAA, "노숙자 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/노숙자7", true) == 0)
	{
	SetPlayerSkin(playerid, 136);
	SendClientMessage(playerid,0xFFFFFFAA, "노숙자 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/노숙자8", true) == 0)
	{
	SetPlayerSkin(playerid, 160);
	SendClientMessage(playerid,0xFFFFFFAA, "노숙자 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/경찰1", true) == 0)
	{
	SetPlayerSkin(playerid, 280);
	SendClientMessage(playerid,0xFFFFFFAA, "경찰 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/경찰2", true) == 0)
	{
	SetPlayerSkin(playerid, 281);
	SendClientMessage(playerid,0xFFFFFFAA, "경찰 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/경찰3", true) == 0)
	{
	SetPlayerSkin(playerid, 282);
	SendClientMessage(playerid,0xFFFFFFAA, "경찰 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/경찰4", true) == 0)
	{
	SetPlayerSkin(playerid, 283);
	SendClientMessage(playerid,0xFFFFFFAA, "경찰 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/경찰5", true) == 0)
	{
	SetPlayerSkin(playerid, 284);
	SendClientMessage(playerid,0xFFFFFFAA, "경찰 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/경찰6", true) == 0)
	{
	SetPlayerSkin(playerid, 265);
	SendClientMessage(playerid,0xFFFFFFAA, "경찰 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/경찰7", true) == 0)
	{
	SetPlayerSkin(playerid, 266);
	SendClientMessage(playerid,0xFFFFFFAA, "경찰 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/경찰8", true) == 0)
	{
	SetPlayerSkin(playerid, 267);
	SendClientMessage(playerid,0xFFFFFFAA, "경찰 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/스왓", true) == 0)
	{
	SetPlayerSkin(playerid, 285);
	SendClientMessage(playerid,0xFFFFFFAA, "스왓 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/FBI1") == 0 || strcmp(cmdtext, "/fbi1") == 0)
	{
	SetPlayerSkin(playerid, 165);
	SendClientMessage(playerid,0xFFFFFFAA, "FBI요원 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/FBI2") == 0 || strcmp(cmdtext, "/fbi2") == 0)
	{
	SetPlayerSkin(playerid, 166);
	SendClientMessage(playerid,0xFFFFFFAA, "FBI요원 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/FBI3") == 0 || strcmp(cmdtext, "/fbi3") == 0)
	{
	SetPlayerSkin(playerid, 286);
	SendClientMessage(playerid,0xFFFFFFAA, "FBI요원 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/FBI4") == 0 || strcmp(cmdtext, "/fbi4") == 0)
	{
	SetPlayerSkin(playerid, 295);
	SendClientMessage(playerid,0xFFFFFFAA, "FBI요원 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/주차요원") == 0)
	{
	SetPlayerSkin(playerid, 189);
	SendClientMessage(playerid,0xFFFFFFAA, "호텔 주차요원 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/소방관1") == 0)
	{
	SetPlayerSkin(playerid, 277);
	SendClientMessage(playerid,0xFFFFFFAA, "소방관 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/소방관2") == 0)
	{
	SetPlayerSkin(playerid, 278);
	SendClientMessage(playerid,0xFFFFFFAA, "소방관 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/소방관3") == 0)
	{
	SetPlayerSkin(playerid, 279);
	SendClientMessage(playerid,0xFFFFFFAA, "소방관 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/농부1", true) == 0)
	{
	SetPlayerSkin(playerid, 158);
	SendClientMessage(playerid,0xFFFFFFAA, "농부 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/농부2", true) == 0)
	{
	SetPlayerSkin(playerid, 159);
	SendClientMessage(playerid,0xFFFFFFAA, "농부 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/할매1", true) == 0)
	{
	SetPlayerSkin(playerid, 129);
	SendClientMessage(playerid,0xFFFFFFAA, "할매 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/할매2", true) == 0)
	{
	SetPlayerSkin(playerid, 197);
	SendClientMessage(playerid,0xFFFFFFAA, "할매 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/할매3", true) == 0)
	{
	SetPlayerSkin(playerid, 231);
	SendClientMessage(playerid,0xFFFFFFAA, "할매 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/할배1", true) == 0)
	{
	SetPlayerSkin(playerid, 49);
	SendClientMessage(playerid,0xFFFFFFAA, "할배 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/할배2", true) == 0)
	{
	SetPlayerSkin(playerid, 235);
	SendClientMessage(playerid,0xFFFFFFAA, "할배 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/아저씨1", true) == 0)
	{
	SetPlayerSkin(playerid, 258);
	SendClientMessage(playerid,0xFFFFFFAA, "아저씨 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/아저씨2", true) == 0)
	{
	SetPlayerSkin(playerid, 259);
	SendClientMessage(playerid,0xFFFFFFAA, "아저씨 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/아저씨3", true) == 0)
	{
	SetPlayerSkin(playerid, 43);
	SendClientMessage(playerid,0xFFFFFFAA, "아저씨 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/사장1", true) == 0)
	{
	SetPlayerSkin(playerid, 147);
	SendClientMessage(playerid,0xFFFFFFAA, "사장님 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/사장2", true) == 0)
	{
	SetPlayerSkin(playerid, 228);
	SendClientMessage(playerid,0xFFFFFFAA, "사장님 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/사장3", true) == 0)
	{
	SetPlayerSkin(playerid, 296);
	SendClientMessage(playerid,0xFFFFFFAA, "사장님 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/비서1", true) == 0)
	{
	SetPlayerSkin(playerid, 141);
	SendClientMessage(playerid,0xFFFFFFAA, "비서 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/비서2", true) == 0)
	{
	SetPlayerSkin(playerid, 150);
	SendClientMessage(playerid,0xFFFFFFAA, "비서 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/비키니1", true) == 0)
	{
	SetPlayerSkin(playerid, 138);
	SendClientMessage(playerid,0xFFFFFFAA, "비키니 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/비키니2", true) == 0)
	{
	SetPlayerSkin(playerid, 140);
	SendClientMessage(playerid,0xFFFFFFAA, "비키니 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/롤러1", true) == 0)
	{
	SetPlayerSkin(playerid, 99);
	SendClientMessage(playerid,0xFFFFFFAA, "롤러스케이트 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/롤러2", true) == 0)
	{
	SetPlayerSkin(playerid, 92);
	SendClientMessage(playerid,0xFFFFFFAA, "롤러스케이트 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/여자1", true) == 0)
	{
	SetPlayerSkin(playerid, 93);
	SendClientMessage(playerid,0xFFFFFFAA, "여자 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/여자2", true) == 0)
	{
	SetPlayerSkin(playerid, 233);
	SendClientMessage(playerid,0xFFFFFFAA, "여자 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/여자3", true) == 0)
	{
	SetPlayerSkin(playerid, 91);
	SendClientMessage(playerid,0xFFFFFFAA, "여자 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/여자4", true) == 0)
	{
	SetPlayerSkin(playerid, 85);
	SendClientMessage(playerid,0xFFFFFFAA, "여자 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/여자5", true) == 0)
	{
	SetPlayerSkin(playerid, 199);
	SendClientMessage(playerid,0xFFFFFFAA, "여자 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/여자6", true) == 0)
	{
	SetPlayerSkin(playerid, 298);
	SendClientMessage(playerid,0xFFFFFFAA, "여자 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/여자7", true) == 0)
	{
	SetPlayerSkin(playerid, 195);
	SendClientMessage(playerid,0xFFFFFFAA, "여자 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/햄버거", true) == 0)
	{
	SetPlayerSkin(playerid, 205);
	SendClientMessage(playerid,0xFFFFFFAA, "햄버거 판매원 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/피자", true) == 0)
	{
	SetPlayerSkin(playerid, 155);
	SendClientMessage(playerid,0xFFFFFFAA, "피자맨 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/치킨", true) == 0)
	{
	SetPlayerSkin(playerid, 167);
	SendClientMessage(playerid,0xFFFFFFAA, "치킨맨 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/뚱보", true) == 0)
	{
	SetPlayerSkin(playerid, 241);
	SendClientMessage(playerid,0xFFFFFFAA, "뚱보 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/경호원1", true) == 0)
	{
	SetPlayerSkin(playerid, 163);
	SendClientMessage(playerid,0xFFFFFFAA, "경호원 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/경호원2", true) == 0)
	{
	SetPlayerSkin(playerid, 164);
	SendClientMessage(playerid,0xFFFFFFAA, "경호원 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/경호원3", true) == 0)
	{
	SetPlayerSkin(playerid, 165);
	SendClientMessage(playerid,0xFFFFFFAA, "경호원 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/경호원4", true) == 0)
	{
	SetPlayerSkin(playerid, 166);
	SendClientMessage(playerid,0xFFFFFFAA, "경호원 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/기사", true) == 0)
	{
	SetPlayerSkin(playerid, 255);
	SendClientMessage(playerid,0xFFFFFFAA, "기사 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/짱깨1", true) == 0)
	{
	SetPlayerSkin(playerid, 123);
	SendClientMessage(playerid,0xFFFFFFAA, "중국인 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/짱깨2", true) == 0)
	{
	SetPlayerSkin(playerid, 263);
	SendClientMessage(playerid,0xFFFFFFAA, "중국인 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/짱깨3", true) == 0)
	{
	SetPlayerSkin(playerid, 169);
	SendClientMessage(playerid,0xFFFFFFAA, "중국인 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/이발사1", true) == 0)
	{
	SetPlayerSkin(playerid, 156);
	SendClientMessage(playerid,0xFFFFFFAA, "이발사 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/이발사2", true) == 0)
	{
	SetPlayerSkin(playerid, 176);
	SendClientMessage(playerid,0xFFFFFFAA, "이발사 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/이발사3", true) == 0)
	{
	SetPlayerSkin(playerid, 177);
	SendClientMessage(playerid,0xFFFFFFAA, "이발사 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/엘비스", true) == 0)
	{
	SetPlayerSkin(playerid, 83);
	SendClientMessage(playerid,0xFFFFFFAA, "엘비스 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/보라1", true) == 0)
	{
	SetPlayerSkin(playerid, 102);
	SendClientMessage(playerid,0xFFFFFFAA, "갱(보라팀) 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/보라2", true) == 0)
	{
	SetPlayerSkin(playerid, 103);
	SendClientMessage(playerid,0xFFFFFFAA, "갱(보라팀) 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/보라3", true) == 0)
	{
	SetPlayerSkin(playerid, 104);
	SendClientMessage(playerid,0xFFFFFFAA, "갱(보라팀) 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/그루브1", true) == 0)
	{
	SetPlayerSkin(playerid, 105);
	SendClientMessage(playerid,0xFFFFFFAA, "갱(그루브) 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/그루브2", true) == 0)
	{
	SetPlayerSkin(playerid, 106);
	SendClientMessage(playerid,0xFFFFFFAA, "갱(그루브) 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/그루브3", true) == 0)
	{
	SetPlayerSkin(playerid, 107);
	SendClientMessage(playerid,0xFFFFFFAA, "갱(그루브) 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/마약1", true) == 0)
	{
	SetPlayerSkin(playerid, 21);
	SendClientMessage(playerid,0xFFFFFFAA, "마약판매상 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/마약2", true) == 0)
	{
	SetPlayerSkin(playerid, 22);
	SendClientMessage(playerid,0xFFFFFFAA, "마약판매상 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/마약3", true) == 0)
	{
	SetPlayerSkin(playerid, 23);
	SendClientMessage(playerid,0xFFFFFFAA, "마약판매상 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/마약4", true) == 0)
	{
	SetPlayerSkin(playerid, 28);
	SendClientMessage(playerid,0xFFFFFFAA, "마약판매상 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/마약5", true) == 0)
	{
	SetPlayerSkin(playerid, 29);
	SendClientMessage(playerid,0xFFFFFFAA, "마약판매상 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/노랑1", true) == 0)
	{
	SetPlayerSkin(playerid, 108);
	SendClientMessage(playerid,0xFFFFFFAA, "갱(노랑팀) 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/노랑2", true) == 0)
	{
	SetPlayerSkin(playerid, 109);
	SendClientMessage(playerid,0xFFFFFFAA, "갱(노랑팀) 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/노랑3", true) == 0)
	{
	SetPlayerSkin(playerid, 110);
	SendClientMessage(playerid,0xFFFFFFAA, "갱(노랑팀) 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/연두1", true) == 0)
	{
	SetPlayerSkin(playerid, 114);
	SendClientMessage(playerid,0xFFFFFFAA, "갱(연두팀) 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/연두2", true) == 0)
	{
	SetPlayerSkin(playerid, 115);
	SendClientMessage(playerid,0xFFFFFFAA, "갱(연두팀) 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/연두3", true) == 0)
	{
	SetPlayerSkin(playerid, 116);
	SendClientMessage(playerid,0xFFFFFFAA, "갱(연두팀) 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/삼합1", true) == 0)
	{
	SetPlayerSkin(playerid, 117);
	SendClientMessage(playerid,0xFFFFFFAA, "조직(삼합회) 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/삼합2", true) == 0)
	{
	SetPlayerSkin(playerid, 118);
	SendClientMessage(playerid,0xFFFFFFAA, "조직(삼합회) 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/삼합3", true) == 0)
	{
	SetPlayerSkin(playerid, 294);
	SendClientMessage(playerid,0xFFFFFFAA, "조직(삼합회) 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/군인", true) == 0)
	{
	SetPlayerSkin(playerid, 287);
	SendClientMessage(playerid,0xFFFFFFAA, "군인 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/기장", true) == 0)
	{
	SetPlayerSkin(playerid, 61);
	SendClientMessage(playerid,0xFFFFFFAA, "기장 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/복서1", true) == 0)
	{
	SetPlayerSkin(playerid, 81);
	SendClientMessage(playerid,0xFFFFFFAA, "복서 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/복서2", true) == 0)
	{
	SetPlayerSkin(playerid, 80);
	SendClientMessage(playerid,0xFFFFFFAA, "복서 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/조깅1", true) == 0)
	{
	SetPlayerSkin(playerid, 96);
	SendClientMessage(playerid,0xFFFFFFAA, "조깅맨 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/조깅2", true) == 0)
	{
	SetPlayerSkin(playerid, 97);
	SendClientMessage(playerid,0xFFFFFFAA, "조깅맨 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/조깅3", true) == 0)
	{
	SetPlayerSkin(playerid, 18);
	SendClientMessage(playerid,0xFFFFFFAA, "조깅맨 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/조깅4", true) == 0)
	{
	SetPlayerSkin(playerid, 45);
	SendClientMessage(playerid,0xFFFFFFAA, "조깅맨 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/달건1", true) == 0)
	{
	SetPlayerSkin(playerid, 111);
	SendClientMessage(playerid,0xFFFFFFAA, "달건이 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/달건2", true) == 0)
	{
	SetPlayerSkin(playerid, 112);
	SendClientMessage(playerid,0xFFFFFFAA, "달건이 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/달건3", true) == 0)
	{
	SetPlayerSkin(playerid, 124);
	SendClientMessage(playerid,0xFFFFFFAA, "달건이 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/달건4", true) == 0)
	{
	SetPlayerSkin(playerid, 125);
	SendClientMessage(playerid,0xFFFFFFAA, "달건이 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/달건5", true) == 0)
	{
	SetPlayerSkin(playerid, 126);
	SendClientMessage(playerid,0xFFFFFFAA, "달건이 스킨으로 변경되었습니다.");
	return 1;
	}
	if(strcmp(cmdtext, "/달건6", true) == 0)
	{
	SetPlayerSkin(playerid, 241);
	SendClientMessage(playerid,0xFFFFFFAA, "달건이 스킨으로 변경되었습니다.");
	return 1;
	}
	if (strcmp("/신전올라", cmdtext, true, 10) == 0)
	{
	MoveObject(A,2081.760986,911.264038,67.739288,3);
	SendClientMessage(playerid,COLOR_YELLOW, "당신은 신에게 숭배하기위해 신전으로 올라가는중입니다.");
	return 1;
	}
	if (strcmp("/신전내려", cmdtext, true, 10) == 0)
	{
	MoveObject(A,2082.492920,908.827332,8.760883,3);
	SendClientMessage(playerid,COLOR_YELLOW, "당신은 신이 축복 하실것입니다.");
	return 1;
	}
	if (strcmp("/신전도움말", cmdtext, true, 10) == 0)
	{
	SendClientMessage(playerid,COLOR_YELLOW,"***************아파트도움말***************");
	SendClientMessage(playerid,COLOR_ORANGE," 신전명령어 : /신전올라 , /신전내려");
	SendClientMessage(playerid,COLOR_YELLOW," 신전 제작자: C.L.N_Vlast / [K_POP]Tio");
	return 1;
	}
	if (strcmp("/검정", cmdtext, true, 10) == 0)
	{
		ChangeVehicleColor(GetPlayerVehicleID(playerid),0,0);
		SendClientMessage(playerid,0xfffffff,"차량이 검정색으로 도색되었습니다.");
		return 1;
	}
	if (strcmp("/하양", cmdtext, true, 10) == 0)
	{
		ChangeVehicleColor(GetPlayerVehicleID(playerid),1.1);
		SendClientMessage(playerid,0xfffffff,"차량이 하얀색으로 도색되었습니다.");
		return 1;
	}
	if (strcmp("/빨강", cmdtext, true, 10) == 0)
	{
		ChangeVehicleColor(GetPlayerVehicleID(playerid),3.3);
		SendClientMessage(playerid,0xfffffff,"차량이 빨강색으로 도색되었습니다.");
		return 1;
	}
	if (strcmp("/파랑", cmdtext, true, 10) == 0)
	{
		ChangeVehicleColor(GetPlayerVehicleID(playerid),2.2);
		SendClientMessage(playerid,0xfffffff,"차량이 파랑색으로 도색되었습니다.");
		return 1;
	}
	if (strcmp("/노랑", cmdtext, true, 10) == 0)
	{
		ChangeVehicleColor(GetPlayerVehicleID(playerid),6.6);
		SendClientMessage(playerid,0xfffffff,"차량이 노랑색으로 도색되었습니다.");
		return 1;
	}
	if (strcmp("/초록", cmdtext, true, 10) == 0)
	{
		ChangeVehicleColor(GetPlayerVehicleID(playerid),1);
		SendClientMessage(playerid,0xfffffff,"차량이 초록색으로 도색되었습니다.");
		return 1;
	}
	if (strcmp("/황금", cmdtext, true, 10) == 0)
	{
		ChangeVehicleColor(GetPlayerVehicleID(playerid),61,61);
		SendClientMessage(playerid,0xfffffff,"차량이 황금색으로 도색되었습니다.");
		return 1;
	}
	if (strcmp("/은색", cmdtext, true, 10) == 0)
	{
		ChangeVehicleColor(GetPlayerVehicleID(playerid),15,15);
		SendClientMessage(playerid,0xfffffff,"차량이 은색으로 도색되었습니다.");
		return 1;
	}
	if(strcmp("/뿔",cmdtext,true,10)==0)
	{
		new Vehicle = GetPlayerVehicleID(playerid);
		SetPVarInt(playerid, "Status", 1);
		SetPVarInt(playerid, "carbull", CreateObject(19314,0,0,-1000,0,0,0,100));
		AttachObjectToVehicle(GetPVarInt(playerid, "carbull"), GetPlayerVehicleID(playerid), -0.000000,2.700000,-0.000000,89.099983,-0.000001,91.799980);
	}
	if(strcmp(cmdtext, "/샷건") == 0 || strcmp(cmdtext, "/shotgun") == 0 || strcmp(cmdtext, "/샷건") == 0)
	{

	  	GivePlayerWeapon(playerid, 25, 99999);
		SendClientMessage(playerid,COLOR_lawngreen,"이하이 : 펌프샷건 흭득명령어를 사용하셨습니다. ");
		return 1;
	}
	if(strcmp(cmdtext, "/카타나") == 0 || strcmp(cmdtext, "/katana") == 0 || strcmp(cmdtext, "/카타나") == 0)
	{

	  	GivePlayerWeapon(playerid, 8, 3000);
		SendClientMessage(playerid,COLOR_lawngreen,"이하이 : 카타나 흭득명령어를 사용하셨습니다. ");
		return 1;
	}
	if(strcmp(cmdtext, "/데글") == 0 || strcmp(cmdtext, "/이글") == 0 || strcmp(cmdtext, "/d.eagle") == 0)
	{

	  	GivePlayerWeapon(playerid, 24, 99999);
		SendClientMessage(playerid,COLOR_lawngreen,"이하이 : 이글 흭득명령어를 사용하셨습니다.");
		return 1;
	}
	if(strcmp(cmdtext, "/엠피") == 0 || strcmp(cmdtext, "/엠피5") == 0 || strcmp(cmdtext, "/mp5") == 0)
	{

	  	GivePlayerWeapon(playerid, 29, 99999);
		SendClientMessage(playerid,COLOR_lawngreen,"이하이 : MP5 흭득명령어를 사용하셨습니다. ");
		return 1;
	}
 	if(strcmp(cmdtext, "/에케") == 0 || strcmp(cmdtext, "/ak") == 0 || strcmp(cmdtext, "/ak47") == 0)
	{

	  	GivePlayerWeapon(playerid, 30, 99999);
		SendClientMessage(playerid,COLOR_lawngreen,"이하이 : AK-47 흭득명령어를 사용하셨습니다. ");
		return 1;
	}
	if(strcmp(cmdtext, "/무기") == 0)
	{
	SendClientMessage(playerid,0x9FB1EEAA, "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓");
	SendClientMessage(playerid,0xFFFFFFAA, "                        	무기 습득 명령어 ");
	SendClientMessage(playerid,0xFFFFFFAA, "     		/엠포 /에케 /엠피 /이글 /스나이퍼 /텍구 /콜트 ");
	SendClientMessage(playerid,0xFFFFFFAA, "        	/카타나 /샷건 /낙하산 /단검 /빠따 /소음총 /자샷  ");
	SendClientMessage(playerid,0x9FB1EEAA, "┗━━━━━━━━━━━━━━━━BY.C.L.N_Vlast━━━━━━━━━┛");
	return 1;
	}
	if(strcmp(cmdtext, "/weapons") == 0)
	{
    ClearChat(playerid,5);
	SendClientMessage(playerid,0x9FB1EEAA, "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓");
	SendClientMessage(playerid,0xFFFFFFAA, "         /autoshotgun	/m4		/tec9	/knife	/colt	/bat  ");
	SendClientMessage(playerid,0xFFFFFFAA, "       /silencer	 /parachute   /sniper	/d.eagle	/mp5");
	SendClientMessage(playerid,0xFFFFFFAA, "                        /ak47 	/katana		/shotgun");
	SendClientMessage(playerid,0x9FB1EEAA, "┗━━━━━━━━━━━━━━━━BY.C.L.N_Vlast━━━━━━━━━┛");
	return 1;
	}
	if(strcmp(cmdtext, "/고객센터") == 0)
	{
    ClearChat(playerid,5);
	SendClientMessage(playerid,0x9FB1EEAA, "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓");
	SendClientMessage(playerid,0xFFFFFFAA, "           이곳에 있는 간략한 문장을 채팅창에 입력해 주시면 ");
	SendClientMessage(playerid,0xFFFFFFAA, "             채팅봇이 답변을 관리자 대신 해드릴껍니다. ");
	SendClientMessage(playerid,0xFFFFFFAA, "   고멤하는법 / 카페주소 / 무기얻는법 / 신고하는방법 / 노래신청법 ");
	SendClientMessage(playerid,0xFFFFFFAA, "             노래추가신청법 / GM신청법 / 재미난놀거리 ");
	SendClientMessage(playerid,0x9FB1EEAA, "┗━━━━━━━━━━━━━━━━BY.C.L.N_Vlast━━━━━━━━━┛");
	return 1;
	}
	if(strcmp(cmdtext, "/english") == 0)
	{
    ClearChat(playerid,5);
	SendClientMessage(playerid,0x9FB1EEAA, "                Global SA:MP Server Vlast's Information");
	SendClientMessage(playerid,0xFFFFFFAA, "  Are you visit My server First Time? You must See this Information ");
	SendClientMessage(playerid,0xFFFFFFAA, "        Do you want to got Some weapon? Then you chat /weapons ");
	SendClientMessage(playerid,0xFFFFFFAA, "       Do you want to healing or Get Ammor? Then you chat /heal");
	SendClientMessage(playerid,0xFFFFFFAA, "    Do you want to teleport to Floor easily? Then you chat /floor ");
	SendClientMessage(playerid,0x9FB1EEAA, "   Do you want to ride a car? Then you chat /car and pick any car");
	return 1;
	}
	if(strcmp(cmdtext, "/GM목록") == 0)
	{
    ClearChat(playerid,5);
	SendClientMessage(playerid,0x9FB1EEAA, "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓");
	SendClientMessage(playerid,0xFFFFFFAA, "         			이하이절벽질주 서버 GM관리자 목록");
	SendClientMessage(playerid,0xFFFFFFAA, "        GM블래스트 / GM티오 / GM제로 / GM유리 / GM천성 / GM헬로 ");
	SendClientMessage(playerid,0xFFFFFFAA, "   								GM참외  ");
	SendClientMessage(playerid,0xFFFFFFAA, "           			 GM은 추후 추가될수도 있습니다. ");
	SendClientMessage(playerid,0x9FB1EEAA, "┗━━━━━━━━━━━━━━━━BY.C.L.N_Vlast━━━━━━━━━┛");
	return 1;
	}
 	if(strcmp(cmdtext, "/엠포") == 0 || strcmp(cmdtext, "/m4") == 0 || strcmp(cmdtext, "/m4a1") == 0)
	{

	  	GivePlayerWeapon(playerid, 31, 500);
		SendClientMessage(playerid,COLOR_lawngreen,"이하이 : M4 흭득명령어를 사용하셨습니다. ");
		return 1;
	}
 	if(strcmp(cmdtext, "/스나이퍼") == 0 || strcmp(cmdtext, "/sniper") == 0 || strcmp(cmdtext, "/스나") == 0)
	{

	  	GivePlayerWeapon(playerid, 34, 99999);
		SendClientMessage(playerid,COLOR_lawngreen,"이하이 : 스나이퍼 흭득명령어를 사용하셨습니다. ");
		return 1;
	}

 	if(strcmp(cmdtext, "/텍구") == 0 || strcmp(cmdtext, "/tec9") == 0 || strcmp(cmdtext, "/텍9") == 0)
	{

	  	GivePlayerWeapon(playerid, 32, 99999);
		SendClientMessage(playerid,COLOR_lawngreen,"이하이 : Tec-9 흭득명령어를 사용하셨습니다.");
		return 1;
	}
 	if(strcmp(cmdtext, "/콜트") == 0 || strcmp(cmdtext, "/colt") == 0 || strcmp(cmdtext, "/colt45") == 0)
	{

	  	GivePlayerWeapon(playerid, 22, 99999);
		SendClientMessage(playerid,COLOR_lawngreen,"이하이 : 콜트 흭득명령어를 사용하셨습니다. ");
		return 1;
	}
 	if(strcmp(cmdtext, "/낙하산") == 0 || strcmp(cmdtext, "/parachute") == 0 || strcmp(cmdtext, "/낙하산") == 0)
	{

	  	GivePlayerWeapon(playerid, 46, 500);
		SendClientMessage(playerid,COLOR_lawngreen,"이하이 : 낙하산 흭득명령어를 사용하셨습니다.");
		return 1;
	}
 	if(strcmp(cmdtext, "/단검") == 0 || strcmp(cmdtext, "/knife") == 0 || strcmp(cmdtext, "/나이프") == 0)
	{

	  	GivePlayerWeapon(playerid, 4, 500);
		SendClientMessage(playerid,COLOR_lawngreen,"이하이 : 단검 흭득명령어를 사용하셨습니다.");
		return 1;
	}
 	if(strcmp(cmdtext, "/빠따") == 0 || strcmp(cmdtext, "/bat") == 0 || strcmp(cmdtext, "/배트") == 0)
	{

	  	GivePlayerWeapon(playerid, 5, 500);
		SendClientMessage(playerid,COLOR_lawngreen,"이하이 : 야구빠따 흭득명령어를 사용하셨습니다. ");
		return 1;
	}

 	if(strcmp(cmdtext, "/소음총") == 0 || strcmp(cmdtext, "/silencer") == 0 || strcmp(cmdtext, "/소음권총") == 0)
	{
	  	GivePlayerWeapon(playerid, 23, 500);
		SendClientMessage(playerid,COLOR_lawngreen,"이하이 : 소음기콜트를 흭득명령어를 사용하셨습니다. ");
		return 1;
	}
	if(strcmp(cmdtext, "/음악목록") == 0 || strcmp(cmdtext, "/노래목록") == 0 || strcmp(cmdtext, "/음악신청") == 0)
	{
	SendClientMessage(playerid,0xFF0000FF, "≫  /노래목록[1~5] ");
	return 1;
	}
	if(strcmp(cmdtext, "/음악목록1") == 0 || strcmp(cmdtext, "/노래목록1") == 0 || strcmp(cmdtext, "/음악신청1") == 0)
	{
	SendClientMessage(playerid,0x9FB1EEAA, "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓");
	SendClientMessage(playerid,0xFFFFFFAA, "    			음악1 = 붐바스틱 / 음악2 = Dance with me / 음악3 = Sex appeal      ");
	SendClientMessage(playerid,0xFFFFFFAA, " 				음악4 = La La La / 음악5 = Internet Friends / 음악6 = Party Rock Anthem      ");
	SendClientMessage(playerid,0xFFFFFFAA, "     음악7 = Get Your Freakin Hands up / 음악8 = Shake That Boo Boo      ");
	SendClientMessage(playerid,0xFFFFFFAA, " 							음악9 = She Got It / 음악10 = 디스코 몬스터 ");
	SendClientMessage(playerid,0xFFFFFFAA, " 										Next	/노래목록2 ");
	SendClientMessage(playerid,0x9FB1EEAA, "┗━━━━━━━━━━━━━━━━━━━━BY.C.L.N_Vlast━━━━━━━━━━━━━━━━━━━━┛");
	return 1;
	}
	if(strcmp(cmdtext, "/음악목록2") == 0 || strcmp(cmdtext, "/노래목록2") == 0 || strcmp(cmdtext, "/음악신청2") == 0)
	{
	SendClientMessage(playerid,0x9FB1EEAA, "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓");
	SendClientMessage(playerid,0xFFFFFFAA, "    			음악11 = 강북멋쟁이 / 음악12 = 사랑해요 / 음악13 = 노가르시아      ");
	SendClientMessage(playerid,0xFFFFFFAA, " 				음악14 = 메뚜기 월드 / 음악15 = 섹시보이 / 음악16 = 엄마를 닯았네      ");
	SendClientMessage(playerid,0xFFFFFFAA, "     		음악17 = One More Night / 음악18 = Gay Bar / 음악19 = Run This Town     ");
	SendClientMessage(playerid,0xFFFFFFAA, " 음악20 = Sexy Back / 음악21 = Faint / 음악22 = Cult Of Personailty / 음악23 = Moves Like Jagger ");
	SendClientMessage(playerid,0xFFFFFFAA, " 										Next	/노래목록3			 ");
	SendClientMessage(playerid,0x9FB1EEAA, "┗━━━━━━━━━━━━━━━━━━━━BY.C.L.N_Vlast━━━━━━━━━━━━━━━━━━━━┛");
	return 1;
	}
	if(strcmp(cmdtext, "/음악목록3") == 0 || strcmp(cmdtext, "/노래목록3") == 0 || strcmp(cmdtext, "/음악신청3") == 0)
	{
	SendClientMessage(playerid,0x9FB1EEAA, "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓");
	SendClientMessage(playerid,0xFFFFFFAA, "    			음악24 = Time is Running / 음악25 = Skeletons / 음악26 = Yeah Yeah      ");
	SendClientMessage(playerid,0xFFFFFFAA, " 				음악14 = 메뚜기 월드 / 음악15 = 섹시보이 / 음악16 = 엄마를 닯았네      ");
	SendClientMessage(playerid,0xFFFFFFAA, "     		음악27 = 이하이 Mercy / 음악28 = 이하이 Dont Stop The Music / 음악29 = 카페인     ");
	SendClientMessage(playerid,0xFFFFFFAA, " 		음악30 = 매력있어 / 음악31 = Talk That / 음악32 = 먼지가 되어 / 음악33 = 닐리리 맘보 ");
	SendClientMessage(playerid,0xFFFFFFAA, " 										Next	/노래목록4			 ");
	SendClientMessage(playerid,0x9FB1EEAA, "┗━━━━━━━━━━━━━━━━━━━━BY.C.L.N_Vlast━━━━━━━━━━━━━━━━━━━━┛");
	return 1;
	}
	if(strcmp(cmdtext, "/음악목록4") == 0 || strcmp(cmdtext, "/노래목록4") == 0 || strcmp(cmdtext, "/음악신청4") == 0)
	{
	SendClientMessage(playerid,0x9FB1EEAA, "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓");
	SendClientMessage(playerid,0xFFFFFFAA, "    			음악34 = 나쁜사람 / 음악35 = 강남스타일 / 음악36 = What Goes up     ");
	SendClientMessage(playerid,0xFFFFFFAA, " 						음악37 = Kick My House / 음악38 = Come With me /     ");
	SendClientMessage(playerid,0xFFFFFFAA, " 음악39 = Livin My Love / 음악40 = Still Waiting / 음악41 = Hey Soul Sister / 음악42 = I'm Yours  ");
	SendClientMessage(playerid,0xFFFFFFAA, " 음악43 = 스트롱거 / 음악44 = Internet Friends Fuck You Remix / 음악45 = 이하이 It's over		 ");
	SendClientMessage(playerid,0xFFFFFFAA, " 	               음악46 = 이하이 1,2,3,4 / 음악47 = Party rock Antham Vlast Remix			 ");
	SendClientMessage(playerid,0xFFFFFFAA, " 									추후 노래는 업데이트 됩니다.			 ");
	SendClientMessage(playerid,0x9FB1EEAA, "┗━━━━━━━━━━━━━━━━━━━━BY.C.L.N_Vlast━━━━━━━━━━━━━━━━━━━━┛");
	return 1;
	}
	if(strcmp(cmdtext, "/음악목록5") == 0 || strcmp(cmdtext, "/노래목록5") == 0 || strcmp(cmdtext, "/음악신청5") == 0)
	{
	SendClientMessage(playerid,0x9FB1EEAA, "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓");
	SendClientMessage(playerid,0xFFFFFFAA, "    음악48 - The great escape / 음악49 - Just the way you are / 음악50 - Run Feat. Redfoo   ");
	SendClientMessage(playerid,0xFFFFFFAA, "    음악51 - Sex on the Beach / 음악52 - Bring Out The Bottles / 음악53 - 이하이 Rose   ");
	SendClientMessage(playerid,0xFFFFFFAA, " 								음악54 - FloRida - Low / 음악55 - 젠틀맨 - PSY		 ");
	SendClientMessage(playerid,0xFFFFFFAA, " 									추후 노래는 업데이트 됩니다.			 ");
	SendClientMessage(playerid,0x9FB1EEAA, "┗━━━━━━━━━━━━━━━━━━━━BY.C.L.N_Vlast━━━━━━━━━━━━━━━━━━━━┛");
	return 1;
	}
	if (strcmp("/무인도", cmdtext, true, 10) == 0)
	{
	new playname[MAX_PLAYER_NAME];
	new str[256];
	GetPlayerName(playerid, playname, sizeof(playname));
	SetPlayerPos(playerid,4066.773,-1684.518,4.647);
	format(str,sizeof(str),"ID: %s(%d번) 님께서 무인도로 텔포하셨습니다. ★(/무인도)★",playname,playerid);
	SendClientMessageToAll(COLOR_GREENYELLOW,str);
	SetPlayerInterior(playerid, 0);
	return 1;
	}
	if (strcmp("/범퍼열어", cmdtext, true, 10) == 0)
	{
	MoveObject(door1,1983.610,994.829,37.988,3);
	MoveObject(door2,2019.441,994.824,38.088,3);
	SendClientMessage(playerid,COLOR_GOLD,"[Door]범퍼카문 오픈");
	return 1;
	}
	if (strcmp("/범퍼닫어", cmdtext, true, 10) == 0)
	{
	MoveObject(door1,1988.710,994.829,37.988,3);
	MoveObject(door2,2005.242,994.824,38.088,3);
	SendClientMessage(playerid,COLOR_GOLD,"[Door]범퍼카문 클로즈");
	return 1;
	}
	if (strcmp("/범퍼올라", cmdtext, true, 10) == 0)
	{
	MoveObject(elb,2003.155,984.601,39.434,2.5);
	SendClientMessage(playerid,COLOR_TOMATO,"[Elevator]올라감");
	return 1;
	}
	if (strcmp("/범퍼내려", cmdtext, true, 10) == 0)
	{
	MoveObject(elb,2003.155,984.601,11.559,2.5);
	SendClientMessage(playerid,COLOR_TOMATO,"[Elevator]내려감");
	return 1;
	}
	if (strcmp("/범퍼카help", cmdtext, true, 10) == 0)
	{
	SendClientMessage(playerid,COLOR_GOLD,  "〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓");
	SendClientMessage(playerid,COLOR_TOMATO,"                                  ");
	SendClientMessage(playerid,COLOR_IVORY, "	+엘레베이터 작동 : /범퍼올라,/범퍼내려");
	SendClientMessage(playerid,COLOR_IVORY, "	+범퍼카문   작동 : /범퍼열어,/범퍼닫어");
	SendClientMessage(playerid,COLOR_TOMATO,"                                  ");
	SendClientMessage(playerid,COLOR_LIME,  "     		 호뭘심슨 & C.L.N_Vlast");
	SendClientMessage(playerid,COLOR_TOMATO,"                                  ");
	SendClientMessage(playerid,COLOR_GOLD,  "〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓");
	return 1;
	}
	/*====================================================================================================*/
	/*-----------------------------------------클럽노래------------------------------------------------*/
	if(strcmp("/음악1",cmdtext,true)==0) //명령어를 쳤을때   /*붐바스틱*/
	{
		if(IsPlayerAdmin(playerid))//친사람이 어드민일때 어드민 아닐때 하게하고싶으시면 지우시면 됍니다.
		for (new i=0;i <MAX_PLAYERS;i++)
		{
			if(IsPlayerConnected(i))
			{

				StopAudioStreamForPlayer(playerid);//중복 않돼게 할려면 오디오실행을 밑이 아닌 위에다가 넣어주시면 됍니다.
				PlayAudioStreamForPlayer(i,"https://dl.dropbox.com/s/dvzwj9xpz7dhv55/Bomba.mp3?dl=1");
			}
		}
	return 1;
}
	if(strcmp("/음악2",cmdtext,true)==0) //명령어를 쳤을때    /*Dance with Me*/
	{
		if(IsPlayerAdmin(playerid))//친사람이 어드민일때 어드민 아닐때 하게하고싶으시면 지우시면 됍니다.
		for (new i=0;i <MAX_PLAYERS;i++)
		{
			if(IsPlayerConnected(i))
			{

				StopAudioStreamForPlayer(playerid);//중복 않돼게 할려면 오디오실행을 밑이 아닌 위에다가 넣어주시면 됍니다.
				PlayAudioStreamForPlayer(i,"https://dl.dropbox.com/s/xsj8ogy0crjw2ky/Bryce%20Feat.%20Carlprit%20-%20Dance%20With%20Me%20%28Paramond%20Remix%29bykemo.mp3?dl=1");
			}
		}
	return 1;
}
	if(strcmp("/음악3",cmdtext,true)==0) //명령어를 쳤을때    /*Sex appeal*/
	{
		if(IsPlayerAdmin(playerid))//친사람이 어드민일때 어드민 아닐때 하게하고싶으시면 지우시면 됍니다.
		for (new i=0;i <MAX_PLAYERS;i++)
		{
			if(IsPlayerConnected(i))
			{

				StopAudioStreamForPlayer(playerid);//중복 않돼게 할려면 오디오실행을 밑이 아닌 위에다가 넣어주시면 됍니다.
				PlayAudioStreamForPlayer(i,"https://dl.dropbox.com/s/o79c710ldatiufe/bueno%20clinic%20-%20sex%20appeal.mp3?dl=1");
			}
		}
	return 1;
}
	if(strcmp("/음악4",cmdtext,true)==0) //명령어를 쳤을때    /*La La La*/
	{
		if(IsPlayerAdmin(playerid))//친사람이 어드민일때 어드민 아닐때 하게하고싶으시면 지우시면 됍니다.
		for (new i=0;i <MAX_PLAYERS;i++)
		{
			if(IsPlayerConnected(i))
			{

				StopAudioStreamForPlayer(playerid);//중복 않돼게 할려면 오디오실행을 밑이 아닌 위에다가 넣어주시면 됍니다.
				PlayAudioStreamForPlayer(i,"https://dl.dropbox.com/s/48nz3030mioxoxt/Da_Zoo_La_La_La.mp3?dl=1");
			}
		}
	return 1;
}
	if(strcmp("/음악5",cmdtext,true)==0) //명령어를 쳤을때    /*Internet Friends*/
	{
		if(IsPlayerAdmin(playerid))//친사람이 어드민일때 어드민 아닐때 하게하고싶으시면 지우시면 됍니다.
		for (new i=0;i <MAX_PLAYERS;i++)
		{
			if(IsPlayerConnected(i))
			{

				StopAudioStreamForPlayer(playerid);//중복 않돼게 할려면 오디오실행을 밑이 아닌 위에다가 넣어주시면 됍니다.
				PlayAudioStreamForPlayer(i,"https://dl.dropbox.com/s/g1s3nwkmbugqfhw/Knife%20Party-01-Internet%20Friends-128.mp3?dl=1");
			}
		}
	return 1;
}
	if(strcmp("/음악6",cmdtext,true)==0) //명령어를 쳤을때    /*Party Rock Anthem*/
	{
		if(IsPlayerAdmin(playerid))//친사람이 어드민일때 어드민 아닐때 하게하고싶으시면 지우시면 됍니다.
		for (new i=0;i <MAX_PLAYERS;i++)
		{
			if(IsPlayerConnected(i))
			{

				StopAudioStreamForPlayer(playerid);//중복 않돼게 할려면 오디오실행을 밑이 아닌 위에다가 넣어주시면 됍니다.
				PlayAudioStreamForPlayer(i,"https://dl.dropbox.com/s/t2b2bp736o9969g/LMFAO-Party%20Rock%20Anthem%20%28feat.%20Lauren%20Bennett%20%26%20GoonRock%29.mp3?dl=1");
			}
		}
	return 1;
}
	if(strcmp("/음악7",cmdtext,true)==0) //명령어를 쳤을때    /*Get Your Freakin Hands up*/
	{
		if(IsPlayerAdmin(playerid))//친사람이 어드민일때 어드민 아닐때 하게하고싶으시면 지우시면 됍니다.
		for (new i=0;i <MAX_PLAYERS;i++)
		{
			if(IsPlayerConnected(i))
			{

				StopAudioStreamForPlayer(playerid);//중복 않돼게 할려면 오디오실행을 밑이 아닌 위에다가 넣어주시면 됍니다.
				PlayAudioStreamForPlayer(i,"https://dl.dropbox.com/s/xrzxjy1kailhnn9/Madteam-01-Get%20Your%20Freakin%20Hands%20Up.mp3?dl=1");
			}
		}
	return 1;
}
	if(strcmp("/음악8",cmdtext,true)==0) //명령어를 쳤을때    /*Shake That Boo Boo*/
	{
		if(IsPlayerAdmin(playerid))//친사람이 어드민일때 어드민 아닐때 하게하고싶으시면 지우시면 됍니다.
		for (new i=0;i <MAX_PLAYERS;i++)
		{
			if(IsPlayerConnected(i))
			{

				StopAudioStreamForPlayer(playerid);//중복 않돼게 할려면 오디오실행을 밑이 아닌 위에다가 넣어주시면 됍니다.
				PlayAudioStreamForPlayer(i,"https://dl.dropbox.com/s/f3ts81iff15l5p3/Modana-01-Shake%20That%20Boo%20Boo%20%28Radio%20Edit%29.mp3?dl=1");
			}
		}
	return 1;
}
	if(strcmp("/음악9",cmdtext,true)==0) //명령어를 쳤을때    /*She Got It*/
	{
		if(IsPlayerAdmin(playerid))//친사람이 어드민일때 어드민 아닐때 하게하고싶으시면 지우시면 됍니다.
		for (new i=0;i <MAX_PLAYERS;i++)
		{
			if(IsPlayerConnected(i))
			{

				StopAudioStreamForPlayer(playerid);//중복 않돼게 할려면 오디오실행을 밑이 아닌 위에다가 넣어주시면 됍니다.
				PlayAudioStreamForPlayer(i,"https://dl.dropbox.com/s/umj0twfegyxwyzn/Vandalism-04-She%20Got%20It%20%28Jackhammer%20Remix%29.mp3?dl=1");
			}
		}
	return 1;
}
	if(strcmp("/음악10",cmdtext,true)==0) //명령어를 쳤을때    /*디스코 몬스터*/
	{
		if(IsPlayerAdmin(playerid))//친사람이 어드민일때 어드민 아닐때 하게하고싶으시면 지우시면 됍니다.
		for (new i=0;i <MAX_PLAYERS;i++)
		{
			if(IsPlayerConnected(i))
			{

				StopAudioStreamForPlayer(playerid);//중복 않돼게 할려면 오디오실행을 밑이 아닌 위에다가 넣어주시면 됍니다.
				PlayAudioStreamForPlayer(i,"https://dl.dropbox.com/s/wa5yrnh7ku7vonz/%ED%84%B0%EB%B3%B4%ED%8A%B8%EB%A1%9C%EB%8B%89-02-%EB%94%94%EC%8A%A4%EC%BD%94%20%EB%AA%AC%EC%8A%A4%ED%84%B0%20%28Extended%20Mix%29-128.mp3?dl=1");
			}
		}
	return 1;
}
/*------------------------------------------무한도전 박명수의 어떤가요------------------------------------*/
	if(strcmp("/음악11",cmdtext,true)==0) //명령어를 쳤을때    /*강북멋쟁이*/
	{
		if(IsPlayerAdmin(playerid))//친사람이 어드민일때 어드민 아닐때 하게하고싶으시면 지우시면 됍니다.
		for (new i=0;i <MAX_PLAYERS;i++)
		{
			if(IsPlayerConnected(i))
			{

				StopAudioStreamForPlayer(playerid);//중복 않돼게 할려면 오디오실행을 밑이 아닌 위에다가 넣어주시면 됍니다.
				PlayAudioStreamForPlayer(i,"https://dl.dropbox.com/s/40t8tqxezovz8k2/%EC%A0%95%ED%98%95%EB%8F%88-01-%EA%B0%95%EB%B6%81%EB%A9%8B%EC%9F%81%EC%9D%B4.mp3?dl=1");
			}
		}
	return 1;
}
	if(strcmp("/음악12",cmdtext,true)==0) //명령어를 쳤을때    /*사랑해요*/
	{
		if(IsPlayerAdmin(playerid))//친사람이 어드민일때 어드민 아닐때 하게하고싶으시면 지우시면 됍니다.
		for (new i=0;i <MAX_PLAYERS;i++)
		{
			if(IsPlayerConnected(i))
			{

				StopAudioStreamForPlayer(playerid);//중복 않돼게 할려면 오디오실행을 밑이 아닌 위에다가 넣어주시면 됍니다.
				PlayAudioStreamForPlayer(i,"https://dl.dropbox.com/s/3wrx42jm8ghaj73/%EC%A0%95%EC%A4%80%ED%95%98-05-%EC%82%AC%EB%9E%91%ED%95%B4%EC%9A%94.mp3?dl=1");
			}
		}
	return 1;
}
	if(strcmp("/음악13",cmdtext,true)==0) //명령어를 쳤을때    /*노가르시아*/
	{
		if(IsPlayerAdmin(playerid))//친사람이 어드민일때 어드민 아닐때 하게하고싶으시면 지우시면 됍니다.
		for (new i=0;i <MAX_PLAYERS;i++)
		{
			if(IsPlayerConnected(i))
			{

				StopAudioStreamForPlayer(playerid);//중복 않돼게 할려면 오디오실행을 밑이 아닌 위에다가 넣어주시면 됍니다.
				PlayAudioStreamForPlayer(i,"https://dl.dropbox.com/s/wbsuumqvcjlgcz3/%EB%85%B8%ED%99%8D%EC%B2%A0-02-%EB%85%B8%EA%B0%80%EB%A5%B4%EC%8B%9C%EC%95%84.mp3?dl=1");
			}
		}
	return 1;
}
	if(strcmp("/음악14",cmdtext,true)==0) //명령어를 쳤을때    /*메뚜기월드*/
	{
		if(IsPlayerAdmin(playerid))//친사람이 어드민일때 어드민 아닐때 하게하고싶으시면 지우시면 됍니다.
		for (new i=0;i <MAX_PLAYERS;i++)
		{
			if(IsPlayerConnected(i))
			{

				StopAudioStreamForPlayer(playerid);//중복 않돼게 할려면 오디오실행을 밑이 아닌 위에다가 넣어주시면 됍니다.
				PlayAudioStreamForPlayer(i,"https://dl.dropbox.com/s/cfgy625vhs998sz/%EC%9C%A0%EC%9E%AC%EC%84%9D-06-%EB%A9%94%EB%9A%9C%EA%B8%B0%EC%9B%94%EB%93%9C.mp3?dl=1");
			}
		}
	return 1;
}
	if(strcmp("/음악15",cmdtext,true)==0) //명령어를 쳤을때    /*섹시보이 Feat. 영지*/
	{
		if(IsPlayerAdmin(playerid))//친사람이 어드민일때 어드민 아닐때 하게하고싶으시면 지우시면 됍니다.
		for (new i=0;i <MAX_PLAYERS;i++)
		{
			if(IsPlayerConnected(i))
			{

				StopAudioStreamForPlayer(playerid);//중복 않돼게 할려면 오디오실행을 밑이 아닌 위에다가 넣어주시면 됍니다.
				PlayAudioStreamForPlayer(i,"https://dl.dropbox.com/s/dxfo59agwj3qztq/%ED%95%98%ED%95%98-04-%EC%84%B9%EC%8B%9C%20%EB%B3%B4%EC%9D%B4%20%28Feat.%20%EC%98%81%EC%A7%80%29.mp3?dl=1");
			}
		}
	return 1;
}
	if(strcmp("/음악16",cmdtext,true)==0) //명령어를 쳤을때    /*엄마를 닮았네*/
	{
		if(IsPlayerAdmin(playerid))//친사람이 어드민일때 어드민 아닐때 하게하고싶으시면 지우시면 됍니다.
		for (new i=0;i <MAX_PLAYERS;i++)
		{
			if(IsPlayerConnected(i))
			{

				StopAudioStreamForPlayer(playerid);//중복 않돼게 할려면 오디오실행을 밑이 아닌 위에다가 넣어주시면 됍니다.
				PlayAudioStreamForPlayer(i,"https://dl.dropbox.com/s/kqp0ic3b0sgs1k0/%EA%B8%B8-03-%EC%97%84%EB%A7%88%EB%A5%BC%20%EB%8B%AE%EC%95%98%EB%84%A4.mp3?dl=1");
			}
		}
	return 1;
}
/*-------------------------------------------팝송----------------------------------------------------------*/
	if(strcmp("/음악17",cmdtext,true)==0) //명령어를 쳤을때    /*One More Night*/
	{
		if(IsPlayerAdmin(playerid))//친사람이 어드민일때 어드민 아닐때 하게하고싶으시면 지우시면 됍니다.
		for (new i=0;i <MAX_PLAYERS;i++)
		{
			if(IsPlayerConnected(i))
			{

				StopAudioStreamForPlayer(playerid);//중복 않돼게 할려면 오디오실행을 밑이 아닌 위에다가 넣어주시면 됍니다.
				PlayAudioStreamForPlayer(i,"https://dl.dropbox.com/s/50hac9sqvd5bwdp/01_-_One_More_Night.mp3?dl=1");
			}
		}
	return 1;
}
	if(strcmp("/음악18",cmdtext,true)==0) //명령어를 쳤을때    /*Gay Bar*/
	{
		if(IsPlayerAdmin(playerid))//친사람이 어드민일때 어드민 아닐때 하게하고싶으시면 지우시면 됍니다.
		for (new i=0;i <MAX_PLAYERS;i++)
		{
			if(IsPlayerConnected(i))
			{

				StopAudioStreamForPlayer(playerid);//중복 않돼게 할려면 오디오실행을 밑이 아닌 위에다가 넣어주시면 됍니다.
				PlayAudioStreamForPlayer(i,"https://dl.dropbox.com/s/buqadmkr6nuwrc5/Electric%20Six-08-Gay%20Bar-128.mp3?dl=1");
			}
		}
	return 1;
}
	if(strcmp("/음악19",cmdtext,true)==0) //명령어를 쳤을때    /*Run This Town*/
	{
		if(IsPlayerAdmin(playerid))//친사람이 어드민일때 어드민 아닐때 하게하고싶으시면 지우시면 됍니다.
		for (new i=0;i <MAX_PLAYERS;i++)
		{
			if(IsPlayerConnected(i))
			{

				StopAudioStreamForPlayer(playerid);//중복 않돼게 할려면 오디오실행을 밑이 아닌 위에다가 넣어주시면 됍니다.
				PlayAudioStreamForPlayer(i,"https://dl.dropbox.com/s/37jysazbezspthf/Jay-Z%20feat.%20Rihanna%20And%20Kanye%20West-Run%20This%20Town.mp3?dl=1");
			}
		}
	return 1;
}
	if(strcmp("/음악20",cmdtext,true)==0) //명령어를 쳤을때    /*Sexy Back*/
	{
		if(IsPlayerAdmin(playerid))//친사람이 어드민일때 어드민 아닐때 하게하고싶으시면 지우시면 됍니다.
		for (new i=0;i <MAX_PLAYERS;i++)
		{
			if(IsPlayerConnected(i))
			{

				StopAudioStreamForPlayer(playerid);//중복 않돼게 할려면 오디오실행을 밑이 아닌 위에다가 넣어주시면 됍니다.
				PlayAudioStreamForPlayer(i,"https://dl.dropbox.com/s/sbdpv2vi5ytv8w3/Justin%20Timberlake-Sexy%20back.mp3?dl=1");
			}
		}
	return 1;
}
	if(strcmp("/음악21",cmdtext,true)==0) //명령어를 쳤을때    /*Faint*/
	{
		if(IsPlayerAdmin(playerid))//친사람이 어드민일때 어드민 아닐때 하게하고싶으시면 지우시면 됍니다.
		for (new i=0;i <MAX_PLAYERS;i++)
		{
			if(IsPlayerConnected(i))
			{

				StopAudioStreamForPlayer(playerid);//중복 않돼게 할려면 오디오실행을 밑이 아닌 위에다가 넣어주시면 됍니다.
				PlayAudioStreamForPlayer(i,"https://dl.dropbox.com/s/jqigwj79vhmhk2y/Linkin%20Park-Faint.mp3?dl=1");
			}
		}
	return 1;
}
	if(strcmp("/음악22",cmdtext,true)==0) //명령어를 쳤을때    /*Cult Of Personailty*/
	{
		if(IsPlayerAdmin(playerid))//친사람이 어드민일때 어드민 아닐때 하게하고싶으시면 지우시면 됍니다.
		for (new i=0;i <MAX_PLAYERS;i++)
		{
			if(IsPlayerConnected(i))
			{

				StopAudioStreamForPlayer(playerid);//중복 않돼게 할려면 오디오실행을 밑이 아닌 위에다가 넣어주시면 됍니다.
				PlayAudioStreamForPlayer(i,"https://dl.dropbox.com/s/igraxlbr01j2yaa/Living%20Colour%20-Cult%20Of%20Personality%20%28%20WWE%20CM%20Punk%202011%29.mp3?dl=1");
			}
		}
	return 1;
}
	if(strcmp("/음악23",cmdtext,true)==0) //명령어를 쳤을때    /*Moves Like Jagger*/
	{
		if(IsPlayerAdmin(playerid))//친사람이 어드민일때 어드민 아닐때 하게하고싶으시면 지우시면 됍니다.
		for (new i=0;i <MAX_PLAYERS;i++)
		{
			if(IsPlayerConnected(i))
			{

				StopAudioStreamForPlayer(playerid);//중복 않돼게 할려면 오디오실행을 밑이 아닌 위에다가 넣어주시면 됍니다.
				PlayAudioStreamForPlayer(i,"https://dl.dropbox.com/s/kyshvfasklwom4y/Maroon%205-Moves%20Like%20Jagger%20%28feat.%20Christina%20Aguilera%29.mp3?dl=1");
			}
		}
	return 1;
}
	if(strcmp("/음악24",cmdtext,true)==0) //명령어를 쳤을때    /*Time is Running*/
	{
		if(IsPlayerAdmin(playerid))//친사람이 어드민일때 어드민 아닐때 하게하고싶으시면 지우시면 됍니다.
		for (new i=0;i <MAX_PLAYERS;i++)
		{
			if(IsPlayerConnected(i))
			{

				StopAudioStreamForPlayer(playerid);//중복 않돼게 할려면 오디오실행을 밑이 아닌 위에다가 넣어주시면 됍니다.
				PlayAudioStreamForPlayer(i,"https://dl.dropbox.com/s/i8nnvgpi1wzaye9/Muse-Time%20Is%20Running%20Out.mp3?dl=1");
			}
		}
	return 1;
}
	if(strcmp("/음악25",cmdtext,true)==0) //명령어를 쳤을때    /*Skeletons*/
	{
		if(IsPlayerAdmin(playerid))//친사람이 어드민일때 어드민 아닐때 하게하고싶으시면 지우시면 됍니다.
		for (new i=0;i <MAX_PLAYERS;i++)
		{
			if(IsPlayerConnected(i))
			{

				StopAudioStreamForPlayer(playerid);//중복 않돼게 할려면 오디오실행을 밑이 아닌 위에다가 넣어주시면 됍니다.
				PlayAudioStreamForPlayer(i,"https://dl.dropbox.com/s/3r8kypulywqyvql/Stevie%20Wonder-06-Skeletons.mp3?dl=1");
			}
		}
	return 1;
}
	if(strcmp("/음악26",cmdtext,true)==0) //명령어를 쳤을때    /*Yeah Yeah*/
	{
		if(IsPlayerAdmin(playerid))//친사람이 어드민일때 어드민 아닐때 하게하고싶으시면 지우시면 됍니다.
		for (new i=0;i <MAX_PLAYERS;i++)
		{
			if(IsPlayerConnected(i))
			{

				StopAudioStreamForPlayer(playerid);//중복 않돼게 할려면 오디오실행을 밑이 아닌 위에다가 넣어주시면 됍니다.
				PlayAudioStreamForPlayer(i,"https://dl.dropbox.com/s/w5ugbzv6s5enw4w/Willy%20Moon-01-Yeah%20Yeah%20%28%EC%95%84%EC%9D%B4%ED%8C%9F%20%ED%84%B0%EC%B9%98%205%EC%84%B8%EB%8C%80%20%EA%B4%91%EA%B3%A0%20%EC%82%BD%EC%9E%85%EA%B3%A1%29.mp3?dl=1");
			}
		}
	return 1;
}
/*----------------------------------------------K-POP--------------------------------------------------------*/
	if(strcmp("/음악27",cmdtext,true)==0) //명령어를 쳤을때    /*이하이 Mercy*/
	{
		if(IsPlayerAdmin(playerid))//친사람이 어드민일때 어드민 아닐때 하게하고싶으시면 지우시면 됍니다.
		for (new i=0;i <MAX_PLAYERS;i++)
		{
			if(IsPlayerConnected(i))
			{

				StopAudioStreamForPlayer(playerid);//중복 않돼게 할려면 오디오실행을 밑이 아닌 위에다가 넣어주시면 됍니다.
				PlayAudioStreamForPlayer(i,"https://dl.dropbox.com/s/edu3pvggwosmcej/%EC%9D%B4%ED%95%98%EC%9D%B4-03-Mercy%20%28Duffy%29.mp3?dl=1");
			}
		}
	return 1;
}
	if(strcmp("/음악28",cmdtext,true)==0) //명령어를 쳤을때    /*이하이 Dont Stop The Music*/
	{
		if(IsPlayerAdmin(playerid))//친사람이 어드민일때 어드민 아닐때 하게하고싶으시면 지우시면 됍니다.
		for (new i=0;i <MAX_PLAYERS;i++)
		{
			if(IsPlayerConnected(i))
			{

				StopAudioStreamForPlayer(playerid);//중복 않돼게 할려면 오디오실행을 밑이 아닌 위에다가 넣어주시면 됍니다.
				PlayAudioStreamForPlayer(i,"https://dl.dropbox.com/s/30kudctox7dktlt/%EC%9D%B4%ED%95%98%EC%9D%B4-06-Don%60t%20Stop%20The%20Music%20%28Rihanna%29.mp3?dl=1");
			}
		}
	return 1;
}
	if(strcmp("/음악29",cmdtext,true)==0) //명령어를 쳤을때    /*카페인*/
	{
		if(IsPlayerAdmin(playerid))//친사람이 어드민일때 어드민 아닐때 하게하고싶으시면 지우시면 됍니다.
		for (new i=0;i <MAX_PLAYERS;i++)
		{
			if(IsPlayerConnected(i))
			{

				StopAudioStreamForPlayer(playerid);//중복 않돼게 할려면 오디오실행을 밑이 아닌 위에다가 넣어주시면 됍니다.
				PlayAudioStreamForPlayer(i,"https://dl.dropbox.com/s/ee5zeifyen0druj/%EC%96%91%EC%9A%94%EC%84%AD%20%28%EB%B9%84%EC%8A%A4%ED%8A%B8%29-02-%EC%B9%B4%ED%8E%98%EC%9D%B8%20%28Feat.%20%EC%9A%A9%EC%A4%80%ED%98%95%20Of%20BEAST%29.mp3?dl=1");
			}
		}
	return 1;
}
	if(strcmp("/음악30",cmdtext,true)==0) //명령어를 쳤을때    /*매력있어*/
	{
		if(IsPlayerAdmin(playerid))//친사람이 어드민일때 어드민 아닐때 하게하고싶으시면 지우시면 됍니다.
		for (new i=0;i <MAX_PLAYERS;i++)
		{
			if(IsPlayerConnected(i))
			{

				StopAudioStreamForPlayer(playerid);//중복 않돼게 할려면 오디오실행을 밑이 아닌 위에다가 넣어주시면 됍니다.
				PlayAudioStreamForPlayer(i,"https://dl.dropbox.com/s/p7eczqj981aew1s/%EC%95%85%EB%8F%99%EB%AE%A4%EC%A7%80%EC%85%98-%EB%A7%A4%EB%A0%A5%EC%9E%88%EC%96%B4.mp3?dl=1");
			}
		}
	return 1;
}
	if(strcmp("/음악31",cmdtext,true)==0) //명령어를 쳤을때    /*Talk That*/
	{
		if(IsPlayerAdmin(playerid))//친사람이 어드민일때 어드민 아닐때 하게하고싶으시면 지우시면 됍니다.
		for (new i=0;i <MAX_PLAYERS;i++)
		{
			if(IsPlayerConnected(i))
			{

				StopAudioStreamForPlayer(playerid);//중복 않돼게 할려면 오디오실행을 밑이 아닌 위에다가 넣어주시면 됍니다.
				PlayAudioStreamForPlayer(i,"https://dl.dropbox.com/s/ot0fk1mhefx271f/%EC%8B%9C%ED%81%AC%EB%A6%BF-01-TALK%20THAT-128.mp3?dl=1");
			}
		}
	return 1;
}
	if(strcmp("/음악32",cmdtext,true)==0) //명령어를 쳤을때    /*먼지가 되어*/
	{
		if(IsPlayerAdmin(playerid))//친사람이 어드민일때 어드민 아닐때 하게하고싶으시면 지우시면 됍니다.
		for (new i=0;i <MAX_PLAYERS;i++)
		{
			if(IsPlayerConnected(i))
			{

				StopAudioStreamForPlayer(playerid);//중복 않돼게 할려면 오디오실행을 밑이 아닌 위에다가 넣어주시면 됍니다.
				PlayAudioStreamForPlayer(i,"https://dl.dropbox.com/s/hkbf485ovtvfclp/%EB%A8%BC%EC%A7%80%EA%B0%80%EB%90%98%EC%96%B4.mp3?dl=1");
			}
		}
	return 1;
}
	if(strcmp("/음악33",cmdtext,true)==0) //명령어를 쳤을때    /*닐리리 맘보*/
	{
		if(IsPlayerAdmin(playerid))//친사람이 어드민일때 어드민 아닐때 하게하고싶으시면 지우시면 됍니다.
		for (new i=0;i <MAX_PLAYERS;i++)
		{
			if(IsPlayerConnected(i))
			{

				StopAudioStreamForPlayer(playerid);//중복 않돼게 할려면 오디오실행을 밑이 아닌 위에다가 넣어주시면 됍니다.
				PlayAudioStreamForPlayer(i,"https://dl.dropbox.com/s/zeo2fk50n3jdzmz/%EB%8B%90%EB%A6%AC%EB%A6%AC%EB%A7%98%EB%B3%B4.mp3?dl=1");
			}
		}
	return 1;
}
	if(strcmp("/음악34",cmdtext,true)==0) //명령어를 쳤을때    /*나쁜사람*/
	{
		if(IsPlayerAdmin(playerid))//친사람이 어드민일때 어드민 아닐때 하게하고싶으시면 지우시면 됍니다.
		for (new i=0;i <MAX_PLAYERS;i++)
		{
			if(IsPlayerConnected(i))
			{

				StopAudioStreamForPlayer(playerid);//중복 않돼게 할려면 오디오실행을 밑이 아닌 위에다가 넣어주시면 됍니다.
				PlayAudioStreamForPlayer(i,"https://dl.dropbox.com/s/v6n8pl7aasxknc4/JUNIEL-01-%EB%82%98%EC%81%9C%20%EC%82%AC%EB%9E%8C.mp3?dl=1");
			}
		}
	return 1;
}
	if(strcmp("/음악35",cmdtext,true)==0) //명령어를 쳤을때    /*강남스타일*/
	{
		if(IsPlayerAdmin(playerid))//친사람이 어드민일때 어드민 아닐때 하게하고싶으시면 지우시면 됍니다.
		for (new i=0;i <MAX_PLAYERS;i++)
		{
			if(IsPlayerConnected(i))
			{

				StopAudioStreamForPlayer(playerid);//중복 않돼게 할려면 오디오실행을 밑이 아닌 위에다가 넣어주시면 됍니다.
				PlayAudioStreamForPlayer(i,"https://dl.dropbox.com/s/bbjfrzhoii36dz6/001%20%EC%8B%B8%EC%9D%B4%20-%20%EA%B0%95%EB%82%A8%EC%8A%A4%ED%83%80%EC%9D%BC.mp3?dl=1");
			}
		}
	return 1;
}
/*==============================================1차 추가=====================================================*/
	if(strcmp("/음악36",cmdtext,true)==0) //명령어를 쳤을때    /*What Goes up*/
	{
		if(IsPlayerAdmin(playerid))//친사람이 어드민일때 어드민 아닐때 하게하고싶으시면 지우시면 됍니다.
		for (new i=0;i <MAX_PLAYERS;i++)
		{
			if(IsPlayerConnected(i))
			{

				StopAudioStreamForPlayer(playerid);//중복 않돼게 할려면 오디오실행을 밑이 아닌 위에다가 넣어주시면 됍니다.
				PlayAudioStreamForPlayer(i,"https://dl.dropbox.com/s/ef395t19q4am0xa/Hyper%20Crush%20-%20What%20Goes%20Up%20%28Radio%20Edit%29.mp3?dl=1");
			}
		}
	return 1;
}
	if(strcmp("/음악37",cmdtext,true)==0) //명령어를 쳤을때    /*Kick My House*/
	{
		if(IsPlayerAdmin(playerid))//친사람이 어드민일때 어드민 아닐때 하게하고싶으시면 지우시면 됍니다.
		for (new i=0;i <MAX_PLAYERS;i++)
		{
			if(IsPlayerConnected(i))
			{

				StopAudioStreamForPlayer(playerid);//중복 않돼게 할려면 오디오실행을 밑이 아닌 위에다가 넣어주시면 됍니다.
				PlayAudioStreamForPlayer(i,"https://dl.dropbox.com/s/r1xbnia1vzwd95y/Maury%20J%20%20-%20%20Kick%20My%20House%20%28%20Original%20Mix%20%29.mp3?dl=1");
			}
		}
	return 1;
}
	if(strcmp("/음악38",cmdtext,true)==0) //명령어를 쳤을때    /*Come With me*/
	{
		if(IsPlayerAdmin(playerid))//친사람이 어드민일때 어드민 아닐때 하게하고싶으시면 지우시면 됍니다.
		for (new i=0;i <MAX_PLAYERS;i++)
		{
			if(IsPlayerConnected(i))
			{

				StopAudioStreamForPlayer(playerid);//중복 않돼게 할려면 오디오실행을 밑이 아닌 위에다가 넣어주시면 됍니다.
				PlayAudioStreamForPlayer(i,"https://dl.dropbox.com/s/1bdi12abtr3sfv6/Steve%20Aoki-01-Come%20With%20Me%20%28Jidax%20Remix%29%20%28Feat.%20Polina%29.mp3?dl=1");
			}
		}
	return 1;
}
	if(strcmp("/음악39",cmdtext,true)==0) //명령어를 쳤을때    /*Livin My Love*/
	{
		if(IsPlayerAdmin(playerid))//친사람이 어드민일때 어드민 아닐때 하게하고싶으시면 지우시면 됍니다.
		for (new i=0;i <MAX_PLAYERS;i++)
		{
			if(IsPlayerConnected(i))
			{

				StopAudioStreamForPlayer(playerid);//중복 않돼게 할려면 오디오실행을 밑이 아닌 위에다가 넣어주시면 됍니다.
				PlayAudioStreamForPlayer(i,"https://dl.dropbox.com/s/pb1n39i1l44d9vo/LMFAO-01-Livin%60%20My%20Love.mp3?dl=1");
			}
		}
	return 1;
}
	if(strcmp("/음악40",cmdtext,true)==0) //명령어를 쳤을때    /*Still Waiting*/
	{
		if(IsPlayerAdmin(playerid))//친사람이 어드민일때 어드민 아닐때 하게하고싶으시면 지우시면 됍니다.
		for (new i=0;i <MAX_PLAYERS;i++)
		{
			if(IsPlayerConnected(i))
			{

				StopAudioStreamForPlayer(playerid);//중복 않돼게 할려면 오디오실행을 밑이 아닌 위에다가 넣어주시면 됍니다.
				PlayAudioStreamForPlayer(i,"https://dl.dropbox.com/s/0w530iwjll66k5m/Sum%2041-04-Still%20Waiting.mp3?dl=1");
			}
		}
	return 1;
}
	if(strcmp("/음악41",cmdtext,true)==0) //명령어를 쳤을때    /*Hey Soul Sister*/
	{
		if(IsPlayerAdmin(playerid))//친사람이 어드민일때 어드민 아닐때 하게하고싶으시면 지우시면 됍니다.
		for (new i=0;i <MAX_PLAYERS;i++)
		{
			if(IsPlayerConnected(i))
			{

				StopAudioStreamForPlayer(playerid);//중복 않돼게 할려면 오디오실행을 밑이 아닌 위에다가 넣어주시면 됍니다.
				PlayAudioStreamForPlayer(i,"https://dl.dropbox.com/s/0g6f7s1kalatgmp/Train-01-Hey%2C%20Soul%20Sister.mp3?dl=1");
			}
		}
	return 1;
}
	if(strcmp("/음악42",cmdtext,true)==0) //명령어를 쳤을때    /*I'm Yours*/
	{
		if(IsPlayerAdmin(playerid))//친사람이 어드민일때 어드민 아닐때 하게하고싶으시면 지우시면 됍니다.
		for (new i=0;i <MAX_PLAYERS;i++)
		{
			if(IsPlayerConnected(i))
			{

				StopAudioStreamForPlayer(playerid);//중복 않돼게 할려면 오디오실행을 밑이 아닌 위에다가 넣어주시면 됍니다.
				PlayAudioStreamForPlayer(i,"https://dl.dropbox.com/s/765doae8o5ye1dt/Jason%20Mraz-01-I%60m%20Yours.mp3?dl=1");
			}
		}
	return 1;
}
	if(strcmp("/음악43",cmdtext,true)==0) //명령어를 쳤을때    /*스트롱거*/
	{
		if(IsPlayerAdmin(playerid))//친사람이 어드민일때 어드민 아닐때 하게하고싶으시면 지우시면 됍니다.
		for (new i=0;i <MAX_PLAYERS;i++)
		{
			if(IsPlayerConnected(i))
			{

				StopAudioStreamForPlayer(playerid);//중복 않돼게 할려면 오디오실행을 밑이 아닌 위에다가 넣어주시면 됍니다.
				PlayAudioStreamForPlayer(i,"https://dl.dropbox.com/s/ojgq5fv0ujl5bo6/%ED%84%B0%EB%B3%B4%ED%8A%B8%EB%A1%9C%EB%8B%89-02-%EC%8A%A4%ED%8A%B8%EB%A1%B1%EA%B1%B0%20%28Extended%20Mix%29.mp3?token_hash=AAGqDfcnj10roPbR4f0dM0J8vndcg52NGtfTX7hmT8Tzcg&dl=1");
			}
		}
	return 1;
}
	if(strcmp("/음악44",cmdtext,true)==0) //명령어를 쳤을때    /*Internet Friends Fuck You Remix*/
	{
		if(IsPlayerAdmin(playerid))//친사람이 어드민일때 어드민 아닐때 하게하고싶으시면 지우시면 됍니다.
		for (new i=0;i <MAX_PLAYERS;i++)
		{
			if(IsPlayerConnected(i))
			{

				StopAudioStreamForPlayer(playerid);//중복 않돼게 할려면 오디오실행을 밑이 아닌 위에다가 넣어주시면 됍니다.
				PlayAudioStreamForPlayer(i,"https://dl.dropbox.com/s/neb22ckgjawilq7/internet%20friends%20-%20DJ%20Viper%20remix.mp3?token_hash=AAHOr7xw05_Bh5gTXYq2Q7c6zMK7DD0rSfgfYwooKmkbAw&dl=1");
			}
		}
	return 1;
}
	if(strcmp("/음악45",cmdtext,true)==0) //명령어를 쳤을때    /*It's over*/
	{
		if(IsPlayerAdmin(playerid))//친사람이 어드민일때 어드민 아닐때 하게하고싶으시면 지우시면 됍니다.
		for (new i=0;i <MAX_PLAYERS;i++)
		{
			if(IsPlayerConnected(i))
			{

				StopAudioStreamForPlayer(playerid);//중복 않돼게 할려면 오디오실행을 밑이 아닌 위에다가 넣어주시면 됍니다.
				PlayAudioStreamForPlayer(i,"https://dl.dropbox.com/s/2yzaev0nb76d68n/Lee%20Hi%20%28%EC%9D%B4%ED%95%98%EC%9D%B4%29%20-%20It%27s%20Over.mp3?token_hash=AAHHBbxQyn04thsCXe34DK4s7tkaZ6nYgSnTpB7QQK9Oog&dl=1");
			}
		}
	return 1;
}
	if(strcmp("/음악46",cmdtext,true)==0) //명령어를 쳤을때    /*1,2,3,4*/
	{
		if(IsPlayerAdmin(playerid))//친사람이 어드민일때 어드민 아닐때 하게하고싶으시면 지우시면 됍니다.
		for (new i=0;i <MAX_PLAYERS;i++)
		{
			if(IsPlayerConnected(i))
			{

				StopAudioStreamForPlayer(playerid);//중복 않돼게 할려면 오디오실행을 밑이 아닌 위에다가 넣어주시면 됍니다.
				PlayAudioStreamForPlayer(i,"https://dl.dropbox.com/s/417xn7nqcj6p0x2/Lee%20Hi%20%28%EC%9D%B4%ED%95%98%EC%9D%B4%29%20-%201%2C2%2C3%2C4.mp3?token_hash=AAG6WDYtPcl3QozVtlou7VOaMrf7rRSsc-D2Ow2FhgvJ3A&dl=1");
			}
		}
	return 1;
}
	if(strcmp("/음악47",cmdtext,true)==0) //명령어를 쳤을때    /*Party rock Antham Ray Mix*/
	{
		if(IsPlayerAdmin(playerid))//친사람이 어드민일때 어드민 아닐때 하게하고싶으시면 지우시면 됍니다.
		for (new i=0;i <MAX_PLAYERS;i++)
		{
			if(IsPlayerConnected(i))
			{

				StopAudioStreamForPlayer(playerid);//중복 않돼게 할려면 오디오실행을 밑이 아닌 위에다가 넣어주시면 됍니다.
				PlayAudioStreamForPlayer(i,"https://dl.dropbox.com/s/3972elsl5lhwwh2/Party%20Rock%20Anthem%20-%20DJ%20Viper%20Remix.mp3?token_hash=AAGEz5x_e0plTEliz1m5y7YjowVNdOgfhOj8aFE0KXmdMw&dl=1");
			}
		}
	return 1;
}
	if(strcmp("/음악48",cmdtext,true)==0) //명령어를 쳤을때    /*The great escape*/
	{
		if(IsPlayerAdmin(playerid))//친사람이 어드민일때 어드민 아닐때 하게하고싶으시면 지우시면 됍니다.
		for (new i=0;i <MAX_PLAYERS;i++)
		{
			if(IsPlayerConnected(i))
			{

				StopAudioStreamForPlayer(playerid);//중복 않돼게 할려면 오디오실행을 밑이 아닌 위에다가 넣어주시면 됍니다.
				PlayAudioStreamForPlayer(i,"https://dl.dropbox.com/s/f6624mg1wua66n2/01%20The%20Great%20Escape.mp3?token_hash=AAHtH0Bj99kbwK3QkVM27fvM2KJfVfaD2YVYHzEA5O5QMQ&dl=1");
			}
		}
	return 1;
}
	if(strcmp("/음악49",cmdtext,true)==0) //명령어를 쳤을때    /*Just the way you are*/
	{
		if(IsPlayerAdmin(playerid))//친사람이 어드민일때 어드민 아닐때 하게하고싶으시면 지우시면 됍니다.
		for (new i=0;i <MAX_PLAYERS;i++)
		{
			if(IsPlayerConnected(i))
			{

				StopAudioStreamForPlayer(playerid);//중복 않돼게 할려면 오디오실행을 밑이 아닌 위에다가 넣어주시면 됍니다.
				PlayAudioStreamForPlayer(i,"https://dl.dropbox.com/s/snd4o8mf5kmbh6s/02.%20Just%20The%20Way%20You%20Are.mp3?token_hash=AAFKvwAhecGKQgyNZMRaiHJczmS7uW5cnmbx9CVXrE92bw&dl=1");
			}
		}
	return 1;
}
	if(strcmp("/음악50",cmdtext,true)==0) //명령어를 쳤을때    /*Run*/
	{
		if(IsPlayerAdmin(playerid))//친사람이 어드민일때 어드민 아닐때 하게하고싶으시면 지우시면 됍니다.
		for (new i=0;i <MAX_PLAYERS;i++)
		{
			if(IsPlayerConnected(i))
			{

				StopAudioStreamForPlayer(playerid);//중복 않돼게 할려면 오디오실행을 밑이 아닌 위에다가 넣어주시면 됍니다.
				PlayAudioStreamForPlayer(i,"https://dl.dropbox.com/s/5gka2k0ni668uf3/Flo%20Rida-09-Run%20%28Feat.%20RedFoo%20Of%20LMFAO%29%20%28Bonus%20Track%29-128.mp3?token_hash=AAHcK6Jnl0tlTpGxEzUcdHimyqjAL8_VyfDLuhv1w5cE5Q&dl=1");
			}
		}
	return 1;
}
	if(strcmp("/음악51",cmdtext,true)==0) //명령어를 쳤을때    /*Sex on the Beach*/
	{
		if(IsPlayerAdmin(playerid))//친사람이 어드민일때 어드민 아닐때 하게하고싶으시면 지우시면 됍니다.
		for (new i=0;i <MAX_PLAYERS;i++)
		{
			if(IsPlayerConnected(i))
			{

				StopAudioStreamForPlayer(playerid);//중복 않돼게 할려면 오디오실행을 밑이 아닌 위에다가 넣어주시면 됍니다.
				PlayAudioStreamForPlayer(i,"https://dl.dropbox.com/s/y6fuxs4m91wkmlq/Spankers%20-%201%20-%20Sex%20On%20The%20Beach.mp3?token_hash=AAG7OFxv2kOSUUG1ik1sU0R8zxmTUrGEgrxvDp_X9CJY4Q&dl=1");
			}
		}
	return 1;
}
	if(strcmp("/음악52",cmdtext,true)==0) //명령어를 쳤을때    /*Bring Out The Bottles*/
	{
		if(IsPlayerAdmin(playerid))//친사람이 어드민일때 어드민 아닐때 하게하고싶으시면 지우시면 됍니다.
		for (new i=0;i <MAX_PLAYERS;i++)
		{
			if(IsPlayerConnected(i))
			{

				StopAudioStreamForPlayer(playerid);//중복 않돼게 할려면 오디오실행을 밑이 아닌 위에다가 넣어주시면 됍니다.
				PlayAudioStreamForPlayer(i,"https://dl.dropbox.com/s/gf71wqswf43wvbn/Redfoo-01-Bring%20Out%20The%20Bottles-128.mp3?token_hash=AAE6hSrbuBCkSEi1TpDwUoo7UFGKnjNu0NdSfsWpcrJtkw&dl=1");
			}
		}
	return 1;
}
	if(strcmp("/음악53",cmdtext,true)==0) //명령어를 쳤을때    /*Rose*/
	{
		if(IsPlayerAdmin(playerid))//친사람이 어드민일때 어드민 아닐때 하게하고싶으시면 지우시면 됍니다.
		for (new i=0;i <MAX_PLAYERS;i++)
		{
			if(IsPlayerConnected(i))
			{

				StopAudioStreamForPlayer(playerid);//중복 않돼게 할려면 오디오실행을 밑이 아닌 위에다가 넣어주시면 됍니다.
				PlayAudioStreamForPlayer(i,"https://dl.dropbox.com/s/zjrnn9utabljwl2/%EC%9D%B4%ED%95%98%EC%9D%B4%20-%20Rose.mp3?token_hash=AAGAI0soMwOZvMXnxerpEEkUleJ6YRLqB97N__S7-bJw5Q&dl=1");
			}
		}
	return 1;
}
	if(strcmp("/음악54",cmdtext,true)==0) //명령어를 쳤을때    /*Low*/
	{
		if(IsPlayerAdmin(playerid))//친사람이 어드민일때 어드민 아닐때 하게하고싶으시면 지우시면 됍니다.
		for (new i=0;i <MAX_PLAYERS;i++)
		{
			if(IsPlayerConnected(i))
			{

				StopAudioStreamForPlayer(playerid);//중복 않돼게 할려면 오디오실행을 밑이 아닌 위에다가 넣어주시면 됍니다.
				PlayAudioStreamForPlayer(i,"https://dl.dropboxusercontent.com/s/v9iqfmk1h0g5c7w/Florida%20feat.%20T-Pain%20-%20Low.mp3?token_hash=AAHJ7q4djLAhKHS88jkaZod42gslGktC4vtKLa7z6LhEhA&dl=1");
			}
		}
	return 1;
}
	if(strcmp("/음악55",cmdtext,true)==0) //명령어를 쳤을때    /*젠틀맨*/
	{
		if(IsPlayerAdmin(playerid))//친사람이 어드민일때 어드민 아닐때 하게하고싶으시면 지우시면 됍니다.
		for (new i=0;i <MAX_PLAYERS;i++)
		{
			if(IsPlayerConnected(i))
			{

				StopAudioStreamForPlayer(playerid);//중복 않돼게 할려면 오디오실행을 밑이 아닌 위에다가 넣어주시면 됍니다.
				PlayAudioStreamForPlayer(i,"https://dl.dropboxusercontent.com/s/9arc79c1chu6v6v/%EC%8B%B8%EC%9D%B4%28Psy%29%20-%2001%20-%20GENTLEMAN%20-%20192k.mp3?token_hash=AAFGJorB8rZ5Ew9PbUYSRdNOX4d5PIc-bV3gYwwB8J-1aA&dl=1");
			}
		}
	return 1;
}




/*----------------------------------------------The End-----------------------------------------------------*/

	if(strcmp("/음악끄기",cmdtext,true)==0) //이걸 친사람은 노래가 꺼져요.
	{
		StopAudioStreamForPlayer(playerid);
		return 1;
	}



	if(strcmp("/모두끄기",cmdtext,true)==0)
		{
			if(IsPlayerAdmin(playerid))//어드민일때
			{
			for (new i=0;i <MAX_PLAYERS;i++)
			    {
				if(IsPlayerConnected(i))
					{
						StopAudioStreamForPlayer(i);
					}
				}
			}
		return 1;
	}
	
/*=================================================================================================================*/
    if(strcmp("/엠포전",cmdtext,true,10)==0)
	{
	new command_string[128],name[24];GetPlayerName(playerid,name,MAX_PLAYER_NAME);
	SetPlayerHealth(playerid,100);
	SendClientMessage(playerid,0xFFFF00AA," 6.25전쟁으로 왔습니다 용병 뛰세여 ");
	format(command_string,sizeof(command_string)," %s님이 6.25전쟁으로 왔쏭 ★/엠포전★ ",name);
	SendClientMessageToAll(0xFFFF00AA,command_string);
	SetPlayerInterior(playerid,0);
	new yg = random(3);
	switch(yg)
	{
	case 0: { SetPlayerPos(playerid, -1666.0042,1366.9518,9.8047); }
	case 1: { SetPlayerPos(playerid, -1664.8766,1380.6658,7.8828); }
	case 2: { SetPlayerPos(playerid, -1657.4039,1394.7733,7.8828); }
	}
	if(IsPlayerConnected(playerid))
	{
	ResetPlayerWeapons(playerid);
	GivePlayerWeapon(playerid,31,9999999);
	}
	return 1;
	}
	if(strcmp("/스나전",cmdtext,true,10)==0)
	{
	new command_string[128],name[24];GetPlayerName(playerid,name,MAX_PLAYER_NAME);
	SetPlayerHealth(playerid,100);
	SetPlayerInterior(playerid,0);
	SendClientMessage(playerid,0x33CCFFAA," 크로스카운터로 왔습니다 적들을 갈겨죽이삼 ");
	format(command_string,sizeof(command_string)," %s님이 스나전으로 왔쏭 ★/스나전★ ",name);
	SendClientMessageToAll(0x33CCFFAA,command_string);
	new yg = random(4);
	switch(yg)
	{
	case 0: { SetPlayerPos(playerid, -1463.5540,1495.5830,8.2578); }
	case 1: { SetPlayerPos(playerid, -1381.0648,1489.4277,19.0547); }
	case 2: { SetPlayerPos(playerid, -1406.3611,1482.6755,11.8084); }
	case 3: { SetPlayerPos(playerid, -1368.1001,1489.3527,11.0391); }
	}

	if(IsPlayerConnected(playerid))
	{
	ResetPlayerWeapons(playerid);
	GivePlayerWeapon(playerid,34,9999999);
	}
	return 1;
	}
	if(strcmp(cmdtext, "/텔포") == 0 || strcmp(cmdtext, "/텔레포트") == 0)
	{
	SendClientMessage(playerid,0x9FB1EEAA, "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓");
	SendClientMessage(playerid,0xFFFFFFAA, "  /데글전 /스나전 /주먹전 /엠포전 /지상 /범퍼카 /빅이어 /마르코네      ");
	SendClientMessage(playerid,0xFFFFFFAA, " /공항1 /공항2 /공항3 /리버티시티 /주차장1 /주차장2 /cj집 /바위산        ");
	SendClientMessage(playerid,0xFFFFFFAA, "   /라이더집 /클럽 /비무장지대 /레이싱 /카지노 /교도소 /레슬링 /");
	SendClientMessage(playerid,0xFFFFFFAA, "   /신도시1 /야자수공원 /롤코 /크고아름다움 /낙하 /회사낙하 /왕카		      ");
	SendClientMessage(playerid,0xFFFFFFAA, "     /차이나타운 /경주장 /신도시2      ");
	SendClientMessage(playerid,0xFFFFFFAA, "                      이하이의 텔레포트 스크립트      ");
	SendClientMessage(playerid,0xFFFFFFAA, "               텔레포트 제작 및 배포 : C.L.N_Vlast ");
	SendClientMessage(playerid,0x9FB1EEAA, "┗━━━━━━━━━━━━━━BY.C.L.N_Vlast━━━━━━━━━━━┛");
	return 1;
	}
	if(strcmp("/데글전",cmdtext,true,10)==0)
	{
	new command_string[128],name[24];GetPlayerName(playerid,name,MAX_PLAYER_NAME);
	SetPlayerHealth(playerid,100);
	SetPlayerInterior(playerid,0);
	SendClientMessage(playerid,0xFF6347AA," 권총전으로 왔습니다 적들을 갈겨죽이삼 ");
	format(command_string,sizeof(command_string)," %s님이 권총전으로 왔쏭 ★/데글전★ ",name);
	SendClientMessageToAll(0xFF6347AA,command_string);
	new yg = random(3);
	switch(yg)
	{
	case 0: { SetPlayerPos(playerid, -1621.5453,1328.9285,5.5064); }
	case 1: { SetPlayerPos(playerid, -1602.0652,1335.0327,3.7762); }
	case 2: { SetPlayerPos(playerid, -1613.9041,1353.4441,5.0452); }
	}
	if(IsPlayerConnected(playerid))
	{
	ResetPlayerWeapons(playerid);
	GivePlayerWeapon(playerid,24,9999999);
	}
	return 1;
	}
	if(strcmp("/주먹전",cmdtext,true,10)==0)
	{
	new command_string[128],name[24];GetPlayerName(playerid,name,MAX_PLAYER_NAME);
	SetPlayerHealth(playerid,100);
	SendClientMessage(playerid,0xFFFF00AA," 복싱하러 왔쏭 적들을 씹부랄 때려죽이삼 ");
	format(command_string,sizeof(command_string)," %s님이 복싱하러 왔쏭 ★/주먹전★ ",name);
	SendClientMessageToAll(0xFFFF00AA,command_string);
	ResetPlayerWeapons(playerid);
	SetPlayerInterior(playerid,0);
	new yg = random(2);
	switch(yg)
	{
	case 0: { SetPlayerPos(playerid, -1753.9991,885.3441,295.8750); }
	case 1: { SetPlayerPos(playerid, -1752.9231,885.1411,295.8750); }
	}
	return 1;
	}
	if(strcmp(cmdtext, "/지상") == 0 || strcmp(cmdtext, "/floor") == 0 || strcmp(cmdtext, "/지상") == 0)
	{
	new name[24];GetPlayerName(playerid,name,MAX_PLAYER_NAME);
	SetPlayerPos(playerid,-2985.6682,472.5327,4.6458);
	SendClientMessage(playerid,0xFFFF00AA," 육지에 도착하였습니다. ");
	format(string,sizeof(string)," %s님이 손쉽게 육지에 오셨습니다. ★/지상★",name);
	SendClientMessageToAll(0xFFFF00AA,string);
	ResetPlayerWeapons(playerid);
	SetPlayerInterior(playerid,0);
	return 1;
	}
	if(strcmp("/왕카",cmdtext,true,10)==0)
	{
	new name[24];GetPlayerName(playerid,name,MAX_PLAYER_NAME);
	SetPlayerPos(playerid,-1958.98, 294.1799, 35.4599);
	SendClientMessage(playerid,0xFFFF00AA," 왕카에 도착하였습니다. ");
	format(string,sizeof(string)," %s님이 왕카에 오셨습니다. ★/왕카★",name);
	SendClientMessageToAll(0xFFFF00AA,string);
	ResetPlayerWeapons(playerid);
	SetPlayerInterior(playerid, 0);
	return 1;
	}
	if(strcmp("/차이나타운",cmdtext,true,10)==0)
	{
	new name[24];GetPlayerName(playerid,name,MAX_PLAYER_NAME);
	SetPlayerPos(playerid, 2614.4699, 1824.6899, 10.8199);
	SendClientMessage(playerid,0xFFFF00AA," 차이나타운에 도착하였습니다. ");
	format(string,sizeof(string)," %s님이 차이나타운에 오셨습니다. ★/차이나타운★",name);
	SendClientMessageToAll(0xFFFF00AA,string);
	ResetPlayerWeapons(playerid);
	SetPlayerInterior(playerid, 0);
	return 1;
	}
	if(strcmp("/신도시2",cmdtext,true,10)==0)
	{
	new name[24];GetPlayerName(playerid,name,MAX_PLAYER_NAME);
	SetPlayerPos(playerid, 3129.304,-2066.922,2.432,271.0,-1,-1);
	SendClientMessage(playerid,0xFFFF00AA," 신도시2에 도착하였습니다. ");
	format(string,sizeof(string)," %s님이 신도시2 에 오셨습니다. ★/신도시2★",name);
	SendClientMessageToAll(0xFFFF00AA,string);
	ResetPlayerWeapons(playerid);
	SetPlayerInterior(playerid, 0);
	return 1;
	}
	if(strcmp("/레슬링",cmdtext,true,10)==0)
	{
	new name[24];GetPlayerName(playerid,name,MAX_PLAYER_NAME);
	SetPlayerPos(playerid,1004.3671,2140.0740,10.6719);
	SendClientMessage(playerid,0xFFFF00AA," WWE 레슬링경기장에 도착하였습니다. ");
	format(string,sizeof(string)," %s님이 WWE 레슬링 경기장에 오셨습니다. ★/레슬링★",name);
	SendClientMessageToAll(0xFFFF00AA,string);
	ResetPlayerWeapons(playerid);
	SetPlayerInterior(playerid,0);
	return 1;
	}
	if(strcmp("/경주장",cmdtext,true,10)==0)
	{
	new name[24];GetPlayerName(playerid,name,MAX_PLAYER_NAME);
	SetPlayerPos(playerid, -1417.35, -664.2601, 1059.17);
	SendClientMessage(playerid,0xFFFF00AA," 경주장에 도착하였습니다. ");
	format(string,sizeof(string)," %s님이 경주장에 오셨습니다. ★/경주장★",name);
	SendClientMessageToAll(0xFFFF00AA,string);
	ResetPlayerWeapons(playerid);
	SetPlayerInterior(playerid, 4);
	return 1;
	}
	if(strcmp("/신도시1",cmdtext,true,10)==0)
	{
	new name[24];GetPlayerName(playerid,name,MAX_PLAYER_NAME);
	SetPlayerPos(playerid,3262.0918,745.5688,7.1438);
	SendClientMessage(playerid,0xFFFF00AA," 신도시에 도착하였습니다. ");
	format(string,sizeof(string)," %s님이 [NEW] 신도시에 오셨습니다. ★/신도시1★",name);
	SendClientMessageToAll(0xFFFF00AA,string);
	ResetPlayerWeapons(playerid);
	SetPlayerInterior(playerid,0);
	return 1;
	}
	if(strcmp("/하우스",cmdtext,true,10)==0)
	{
	if(IsPlayerAdmin(playerid))
	{
	new name[24];GetPlayerName(playerid,name,MAX_PLAYER_NAME);
	SetPlayerPos(playerid,-3005.7732,-150.4491,1014.4405);
	SendClientMessage(playerid,0xFFFF00AA," 육지에 도착하였습니다. ");
	format(string,sizeof(string)," %s님이 어드민 하우스로 가셨습니다. ★어드민만 가능★",name);
	SendClientMessageToAll(0xFFFF00AA,string);
	SetPlayerInterior(playerid,0);
	ResetPlayerWeapons(playerid);
	}
	return 1;
	}
	if(strcmp("/교도소",cmdtext,true,10)==0)
	{
	new name[24];GetPlayerName(playerid,name,MAX_PLAYER_NAME);
	SetPlayerPos(playerid,708.9269,-2605.1853,9.8830,184.7000);
	SendClientMessage(playerid,0xFFFF00AA," 프리즌브레이크의 교도소에 가셨습니다.");
	format(string,sizeof(string)," %s님이 프리즌브레이크의 교도소에 가셨습니다. ★/교도소★",name);
	SendClientMessageToAll(0xFFFF00AA,string);
	SetPlayerInterior(playerid,0);
	ResetPlayerWeapons(playerid);
	return 1;
	}
	if(strcmp("/비무장지대",cmdtext,true,10)==0)
	{
	new name[24];GetPlayerName(playerid,name,MAX_PLAYER_NAME);
	SetPlayerPos(playerid,2913.9685,-567.7088,11.1541);
	SendClientMessage(playerid,0xFFFF00AA," 비무장지대에 도착하셨습니다. ");
	format(string,sizeof(string)," %s님이 비무장지대로 가셨습니다. (무기소지, 싸움 금지) ★/비무장지대★",name);
	SendClientMessageToAll(0xFFFF00AA,string);
	SetPlayerInterior(playerid,0);
	ResetPlayerWeapons(playerid);
	return 1;
	}
	if(strcmp("/오토바이슛",cmdtext,true,10)==0)
	{
	new name[24];GetPlayerName(playerid,name,MAX_PLAYER_NAME);
	SetPlayerPos(playerid,2913.9685,-567.7088,11.1541);
	SendClientMessage(playerid,0xFFFF00AA," 오토바이슛에 도착하셨습니다. ");
	format(string,sizeof(string)," %s님이 오토바이슛으로 가셨습니다. ★/오토바이슛★",name);
	SendClientMessageToAll(0xFFFF00AA,string);
	SetPlayerInterior(playerid,0);
	ResetPlayerWeapons(playerid);
	return 1;
	}
	if(strcmp("/레이싱",cmdtext,true,10)==0)
	{
	new name[24];GetPlayerName(playerid,name,MAX_PLAYER_NAME);
	SetPlayerPos(playerid,422.4241,-2491.3984,5.1198);
	SendClientMessage(playerid,0xFFFF00AA," 슈퍼레이싱에 도착하셨습니다. ");
	format(string,sizeof(string)," %s님이 슈퍼레이싱을 도전하러 가셨습니다.. ★/레이싱★",name);
	SendClientMessageToAll(0xFFFF00AA,string);
	SetPlayerInterior(playerid,0);
	ResetPlayerWeapons(playerid);
	return 1;
	}
	if(strcmp("/마르코네",cmdtext,true,10)==0)
	{
	new name[24];GetPlayerName(playerid,name,MAX_PLAYER_NAME);
	SetPlayerInterior(playerid,1);
	SetPlayerPos(playerid,-785.191100,497.430400,1376.195000);
	SendClientMessage(playerid,0xFFFF00AA,"마르코네 레스토랑에 도착하셨습니다. ");
	format(string,sizeof(string)," %s님이 리버티시티의 레스토랑에 가셨습니다. (낙사방지제작중) ★/마르코네★",name);
	SendClientMessageToAll(0xFFFF00AA,string);
	ResetPlayerWeapons(playerid);
	return 1;
	}
	if(strcmp("/리버티시티",cmdtext,true,10)==0)
	{
	new name[24];GetPlayerName(playerid,name,MAX_PLAYER_NAME);
	SetPlayerInterior(playerid,1);
	SetPlayerPos(playerid,-735.0683,494.3022,1371.9766);
	SendClientMessage(playerid,0xFFFF00AA," 리버티시티에 도착하였습니다. ");
	format(string,sizeof(string)," %s님이 낙사방지가 제작완료된 리버티시티에 가셨습니다. ★/리버티시티★",name);
	SendClientMessageToAll(0xFFFF00AA,string);
	ResetPlayerWeapons(playerid);
	return 1;
	}
	if(strcmp("/공항2",cmdtext,true,10)==0)
	{
	new name[24];GetPlayerName(playerid,name,MAX_PLAYER_NAME);
	SetPlayerPos(playerid,-1310.9689,-205.3479,14.1484);
	SendClientMessage(playerid,0xFFFF00AA," 공항 ");
	format(string,sizeof(string)," %s님이 공항2에 도착하셨습니다. ★/공항2★",name);
	SendClientMessageToAll(0xFFFF00AA,string);
	ResetPlayerWeapons(playerid);
	SetPlayerInterior(playerid,0);
	return 1;
	}
	if(strcmp("/공항3",cmdtext,true,10)==0)
	{
	new name[24];GetPlayerName(playerid,name,MAX_PLAYER_NAME);
	SetPlayerPos(playerid,1332.0601,1274.8199,10.8203);
	SendClientMessage(playerid,0xFFFF00AA," 공항 ");
	format(string,sizeof(string)," %s님이 공항에 도착하셧습니다. ★/공항3★",name);
	SendClientMessageToAll(0xFFFF00AA,string);
	ResetPlayerWeapons(playerid);
	SetPlayerInterior(playerid,0);
	return 1;
	}
	if(strcmp("/공항",cmdtext,true,10)==0)
	{
	new name[24];GetPlayerName(playerid,name,MAX_PLAYER_NAME);
	SetPlayerPos(playerid,-833.1195, 5919.9375, 12.5623);
	SendClientMessage(playerid,0xFFFF00AA," 공항 ");
	format(string,sizeof(string)," %s님이 공항에 도착하셧습니다. ★/공항3★",name);
	SendClientMessageToAll(0xFFFF00AA,string);
	ResetPlayerWeapons(playerid);
	SetPlayerInterior(playerid,0);
	return 1;
	}
	if(strcmp("/cj집",cmdtext,true,10)==0)
	{
	new name[24];GetPlayerName(playerid,name,MAX_PLAYER_NAME);
	SetPlayerPos(playerid,2486.7510,-1667.4213,13.3438);
	SendClientMessage(playerid,0xFFFF00AA," cj집 ");
	format(string,sizeof(string)," %s님이 cj집에 도착하셧습니다. ★/cj집★",name);
	SendClientMessageToAll(0xFFFF00AA,string);
	ResetPlayerWeapons(playerid);
	SetPlayerInterior(playerid,0);
	return 1;
	}
	if(strcmp("/주차장1",cmdtext,true,10)==0)
	{
	new name[24];GetPlayerName(playerid,name,MAX_PLAYER_NAME);
	SetPlayerPos(playerid,1082.8677,2216.0222,16.7188);
	SendClientMessage(playerid,0xFFFF00AA," 주차장1 ");
	format(string,sizeof(string)," %s님이 주차장1 에 도착하셧습니다. ★/주차장1★",name);
	SendClientMessageToAll(0xFFFF00AA,string);
	ResetPlayerWeapons(playerid);
	SetPlayerInterior(playerid,0);
	return 1;
	}
	if(strcmp("/주차장2",cmdtext,true,10)==0)
	{
	new name[24];GetPlayerName(playerid,name,MAX_PLAYER_NAME);
	SetPlayerPos(playerid,2112.6079,1426.4137,10.8203);
	SendClientMessage(playerid,0xFFFF00AA," 주차장2 ");
	format(string,sizeof(string)," %s님이 주차장1 에 도착하셧습니다. ★/주차장2★",name);
	SendClientMessageToAll(0xFFFF00AA,string);
	ResetPlayerWeapons(playerid);
	SetPlayerInterior(playerid,0);
	return 1;
	}
	if(strcmp("/크고아름다움",cmdtext,true,10)==0)
	{
	new name[24];GetPlayerName(playerid,name,MAX_PLAYER_NAME);
	SetPlayerPos(playerid,-397.8513,2560.9358,41.6367);
	SendClientMessage(playerid,0xFFFF00AA," 그곳에 도착하셨습니다. ");
	format(string,sizeof(string)," %s님이 크고아름다운것을 보러 가셨습니다. ★/크고아름다움★",name);
	SendClientMessageToAll(0xFFFF00AA,string);
	ResetPlayerWeapons(playerid);
	SetPlayerInterior(playerid,0);
	return 1;
	}
	if(strcmp("/회사낙하",cmdtext,true,10)==0)
	{
	new name[24];GetPlayerName(playerid,name,MAX_PLAYER_NAME);
	SetPlayerPos(playerid,1786.4799,-1301.2126,125.7266);
	SendClientMessage(playerid,0xFFFF00AA," 회사낙하에 도착하셨습니다. ");
	format(string,sizeof(string)," %s님이 회사 낙하를 하러 가셨습니다. ★/회사낙하★",name);
	SendClientMessageToAll(0xFFFF00AA,string);
	ResetPlayerWeapons(playerid);
	SetPlayerInterior(playerid,0);
	return 1;
	}
	if(strcmp("/낙하",cmdtext,true,10)==0)
	{
	new name[24];GetPlayerName(playerid,name,MAX_PLAYER_NAME);
	SetPlayerPos(playerid,1540.6003,-1365.7981,329.7969);
	SendClientMessage(playerid,0xFFFF00AA," 낙하에 도착하셨습니다. ");
	format(string,sizeof(string)," %s님이 그냥 낙하를 하러 가셨습니다. ★/낙하★",name);
	SendClientMessageToAll(0xFFFF00AA,string);
	ResetPlayerWeapons(playerid);
	SetPlayerInterior(playerid,0);
	return 1;
	}
	if(strcmp("/롤코",cmdtext,true,10)==0)
	{
	new name[24];GetPlayerName(playerid,name,MAX_PLAYER_NAME);
	SetPlayerPos(playerid,43.2153, 2454.4873, 16.4766);
	SendClientMessage(playerid,0xFFFF00AA," 롤러코스터에 도착하셨습니다. ");
	format(string,sizeof(string)," %s님이 롤러코스터를 타러 가셨습니다. ★/롤코★",name);
	SendClientMessageToAll(0xFFFF00AA,string);
	ResetPlayerWeapons(playerid);
	SetPlayerInterior(playerid,0);
	return 1;
	}
	if(strcmp("/야자수공원",cmdtext,true,10)==0)
	{
	new name[24];GetPlayerName(playerid,name,MAX_PLAYER_NAME);
	SetPlayerPos(playerid,1261.9208,2797.2148,10.8203);
	SendClientMessage(playerid,0xFFFF00AA," 야자수공원에 도착하셨습니다. ");
	format(string,sizeof(string)," %s님이 야자수공원에 가셨습니다. ★/야자수공원★",name);
	SendClientMessageToAll(0xFFFF00AA,string);
	ResetPlayerWeapons(playerid);
	SetPlayerInterior(playerid,0);
	return 1;
	}
	if(strcmp("/클럽",cmdtext,true,10)==0)
	{
	new name[24];GetPlayerName(playerid,name,MAX_PLAYER_NAME);
	SetPlayerInterior(playerid,0);
	SetPlayerPos(playerid,2052.5476,991.8685,10.6719,88.6741);
	SendClientMessage(playerid,0xFFFF00AA," 클럽 ");
	format(string,sizeof(string)," %s님이 클럽에 도착하셧습니다. ★/클럽★",name);
	SendClientMessageToAll(0xFFFF00AA,string);
	ResetPlayerWeapons(playerid);
	return 1;
	}
	if(strcmp("/카지노",cmdtext,true,10)==0)
	{
	new name[24];GetPlayerName(playerid,name,MAX_PLAYER_NAME);
	SetPlayerInterior(playerid,10);
	SetPlayerPos(playerid,2015.5074,1017.1860,996.8750);
	SendClientMessage(playerid,0xFFFF00AA," 카지노");
	format(string,sizeof(string)," %s님이 카지노에 도착하셧습니다. ★/카지노★",name);
	SendClientMessageToAll(0xFFFF00AA,string);
	ResetPlayerWeapons(playerid);
	return 1;
	}
	if(strcmp("/라이더집",cmdtext,true,10)==0)
	{
	new name[24];GetPlayerName(playerid,name,MAX_PLAYER_NAME);
	SetPlayerInterior(playerid,2);
	SetPlayerPos(playerid,2466.9214,-1698.4576,1013.5078);
	SendClientMessage(playerid,0xFFFF00AA," 라이더집 ");
	format(string,sizeof(string)," %s님이 라이더집에 도착하셧습니다. ★/라이더집★",name);
	SendClientMessageToAll(0xFFFF00AA,string);
	ResetPlayerWeapons(playerid);
	return 1;
	}
	if(strcmp("/범퍼카",cmdtext,true,10)==0)
	{
	new name[24];GetPlayerName(playerid,name,MAX_PLAYER_NAME);
	SetPlayerInterior(playerid,0);
	SetPlayerPos(playerid,1994.8218,986.4297,10.8203,293.5727);
	SendClientMessage(playerid,0xFFFF00AA," 범퍼카당 ");
	format(string,sizeof(string)," %s님이 범퍼카에 가셨습니다. ★/범퍼카★",name);
	SendClientMessageToAll(0xFFFF00AA,string);
	ResetPlayerWeapons(playerid);
	return 1;
	}
	if(strcmp("/빅이어",cmdtext,true,10)==0)
	{
	new name[24];GetPlayerName(playerid,name,MAX_PLAYER_NAME);
	SetPlayerPos(playerid,-316.7874,1525.0967,75.3570);
	SendClientMessage(playerid,0xFFFF00AA," 빅이어에 도착하셧습니다~ ");
	format(string,sizeof(string)," %s님이 빅이어에 도착하셧습니다. ★/빅이어★",name);
	SendClientMessageToAll(0xFFFF00AA,string);
	SetPlayerInterior(playerid,0);
	ResetPlayerWeapons(playerid);
	return 1;
	}
	if(strcmp("/공항1",cmdtext,true,10)==0)
	{
	new name[24];GetPlayerName(playerid,name,MAX_PLAYER_NAME);
	SetPlayerPos(playerid,1939.6038,-2484.3887,13.5391);
	SendClientMessage(playerid,0xFFFF00AA," 공항 ");
	format(string,sizeof(string)," %s님이 공항에 도착하셧습니다. ★/공항1★",name);
	SendClientMessageToAll(0xFFFF00AA,string);
	SetPlayerInterior(playerid,0);
	ResetPlayerWeapons(playerid);
	return 1;
	}
	if(strcmp("/드카",cmdtext,true,10)==0)
	{
	new name[24];GetPlayerName(playerid,name,MAX_PLAYER_NAME);
	SetPlayerPos(playerid,1904.0056,964.3462,10.5281);
	SendClientMessage(playerid,0xFFFF00AA," 드레곤카지노에 도착햇습니다 ");
	format(string,sizeof(string)," %s님이 드래곤카지노에에 도착하셧습니다. ★/드카★",name);
	SendClientMessageToAll(0xFFFF00AA,string);
	SetPlayerInterior(playerid,0);
	ResetPlayerWeapons(playerid);
	return 1;
	}
	if(strcmp("/바위산",cmdtext,true,10)==0)
	{
	new name[24];GetPlayerName(playerid,name,MAX_PLAYER_NAME);
	SetPlayerPos(playerid,-2330.1841,-1625.9081,483.7060);
	SendClientMessage(playerid,0xFFFF00AA," 바위산 ");
	format(string,sizeof(string)," %s님이 바위산 절벽질주를 하려고 바위산에 왔쏭 ★/바위산★",name);
	SendClientMessageToAll(0xFFFF00AA,string);
	SetPlayerInterior(playerid,0);
	ResetPlayerWeapons(playerid);
	return 1;
	}
	/*=======================================================================================================*/
	if(strcmp("/처음",cmdtext,true,10)==0)
	{
	    ClearChat(playerid,2);
		format(string,sizeof(string),"%s - 샘프 입문",SERVER_TITLE);
		SendClientMessage(playerid,COLOR_TITLE,string);
		SendClientMessage(playerid,COLOR_ROPE,"━━━━━━━━━━━━━━━━━━━━");
		SendFreeMessage(playerid,"조작","\"엔터\"를 누르시면 차량에 탑니다, \"G\"키로 차량 옆자리에 함께탑니다(다른사람 차를 뺏어타는건 비매너 행위)");
		SendFreeMessage(playerid,"조작","힘샌 타격을 때리시려면, \"마우스오른쪽\"을 누르신 상태에서 \"F\"키를 연타하십시오");
		SendFreeMessage(playerid,"조작","\"F7\"으로 채팅창과 미니맵과 체력바를 없앱니다, \"F8\"로 스크린샷을 찍습니다(찍은건 게임깔린폴더에 저장됨)");
		SendFreeMessage(playerid,"오류","화면이 안움직일때 -> ESC -> OPTIONS -> CONTROLLER SETUP -> JOYPAD 되있는걸 MOUSE + KEY 로 변경");
		SendFreeMessage(playerid,"오류","마우스가 반대일때 -> ESC -> OPTIONS -> CONTROLLER SETUP -> MOUSE SETTING -> 맨위 ON 되있는걸 OFF로 변경");
		SendFreeMessage(playerid,"참고","인터넷상이라도 매너를 지키는 수준높은 샘프인이 됩시다");
		return 1;
	}
	if(strcmp("/rc",cmdtext,true,10)==0||strcmp("/차수리",cmdtext,true,10)==0)
	{
	    if(IsPlayerInAnyVehicle(playerid)&&GetPlayerState(playerid)==PLAYER_STATE_DRIVER)
		{
		    RepairVehicle(MyVehicle);
			SendInfoMessage(playerid,"차량을 멕가이버가 수리하였습니다 (단축키: 차량에 탑승후 \"H\"키)");
		}
		return 1;
	}
	if(strcmp("/nitro",cmdtext,true,10)==0||strcmp("/니트로",cmdtext,true,10)==0)
	{
	    if(IsPlayerInAnyVehicle(playerid)&&GetPlayerState(playerid)==PLAYER_STATE_DRIVER)
		{
		    AddVehicleComponent(MyVehicle,1010);
			SendInfoMessage(playerid,"차량에 부스터를 장착하였습니다 (단축키: 차량에 탑승후 \"H\"키)");
		}
		return 1;
	}
	if(strcmp("/c",cmdtext,true,10)==0||strcmp("/f",cmdtext,true,10)==0)
	{
	    new Float:Angle;
	    if(IsPlayerInAnyVehicle(playerid)&&GetPlayerState(playerid)==PLAYER_STATE_DRIVER)
		{
		    GetVehicleZAngle(MyVehicle,Angle);
		    SetVehicleZAngle(MyVehicle,Angle);
			SendInfoMessage(playerid,"차량을 뒤집개로 뒤집었습니다");
		}
		return 1;
	}
	if(Jailed[playerid]==0)
	{
		if(strcmp("/kill",cmdtext,true,10)==0||strcmp("/자살",cmdtext,true,10)==0)
		{
		    RespawnCheck(playerid);
		    SetPlayerHealth(playerid,0);
			SendInfoMessage(playerid,"당신은 자살하였습니다");
			return 1;
		}
		if(strcmp("/re",cmdtext,true,10)==0||strcmp("/리스폰",cmdtext,true,10)==0)
		{
		    RespawnCheck(playerid);
		    ResetPlayerWeapons(playerid);
		    GivePlayerWeapon(playerid,46,100000);
		    SetPlayerHealth(playerid,90);
		    SetPlayerPos(playerid,-5559.6191,471.1245,1202.8463);
			SendInfoMessage(playerid,"리스폰을 성공적으로 마쳤습니다");
			return 1;
		}
	}
	if(strcmp("/무술",cmdtext,true,10)==0)
	{
	    ShowPlayerDialog(playerid,DIALOG_1,DIALOG_STYLE_LIST,"무술 배우기","기본기\n복싱\n무에타이","확인","취소");
		return 1;
	}
	if(strcmp("/액션",cmdtext,true,10)==0)
	{
	    ShowPlayerDialog(playerid,DIALOG_2,DIALOG_STYLE_LIST,"액션 취하기","맥주\n와인\n음료\n담배","확인","취소");
		return 1;
	}
	if(strcmp(cmdtext, "/구매") == 0 || strcmp(cmdtext, "/heal") == 0 || strcmp(cmdtext, "/상점") == 0)
	{
	    ShowPlayerDialog(playerid,DIALOG_3,DIALOG_STYLE_LIST,"이하이 편의점","HP\nAmmo\n","구매[buy]","취소[cancel]");
		return 1;
	}
	if(strcmp("/고정멤버",cmdtext,true,10)==0)
	{
	    ShowPlayerDialog(playerid,DIALOG_5,DIALOG_STYLE_LIST,"고정멤버 등록","이하이 서버 고정멤버 등록","확인","취소");
		return 1;
	}
	if(strcmp("/무장",cmdtext,true,10)==0)
	{
	    if(!PlayerToPoint(65,playerid,-2921.5676,468.3167,4.9141))
		{
			SendErrorMessage(playerid,"데스매치 구역에서만 총기를 받을수 있습니다");
			return 1;
		}
		if(GetPlayerMoney(playerid)>=100)
		{
			GivePlayerWeapon(playerid,5,100000);
		    GivePlayerWeapon(playerid,25,100000);
		    GivePlayerWeapon(playerid,30,100000);
		    GivePlayerWeapon(playerid,24,100000);
		    GivePlayerWeapon(playerid,8,100000);
		    GivePlayerWeapon(playerid,29,100000);
		    GivePlayerWeapon(playerid,34,100000);
		    GivePlayerWeapon(playerid,46,100000);
		    GivePlayerMoney(playerid,-0);
		    ApplyAnimation(playerid,"BUDDY","buddy_reload",4.1,0,1,1,1,1);
			SendInfoMessage(playerid,"성공적으로 무장하였습니다 육지에서만 싸우세요 (지불: 무료)");
		}
		else
		{
			SendErrorMessage(playerid,"무장할 돈이 부족합니다 (가격: $100)");
		}
		return 1;
	}
	if(strcmp(cmd,"/r",true)==0||strcmp(cmd,"/닉네임",true)==0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[MAX_PLAYER_NAME];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
			{
				SendHintMessage(playerid,"/R [닉네임]");
				return 1;
			}
			Nickname[playerid]=(result);
			format(string,sizeof(string),"당신의 닉네임이 [%s]으로 등록되었습니다",result);
			SendInfoMessage(playerid,string);
		}
		return 1;
	}
	if(IsPlayerAdmin(playerid))/*Admin Commands*/
	{
	    if(strcmp("/차리스폰",cmdtext,true,10)==0)
		{
		    RespawnVehicle();
			SendInfoMessage(playerid,"모든차를 리스폰 시켰습니다");
			return 1;
		}
		if(strcmp("/지우개",cmdtext,true,10)==0)
		{
            for(new i=0; i<MAX_PLAYERS; i++)
            {
				if(IsPlayerConnected(i))
				{
					ClearChat(i,10);
				}
			}
			return 1;
		}
		if(strcmp("/육지",cmdtext,true,10)==0)
		{
            TelePlayer(playerid,-2903.6477,469.9044,4.9141,0);/*Quick Tele*/
			return 1;
		}
	}
	SendErrorMessage(playerid,"잘못된 명령어 입니다 \"/help\"를 통하여 도움말을 확인하십시오");
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)/*Son-Nell Shotgun Clear*/
{
    new vehicle=GetPlayerVehicleID(playerid);
	if(GetVehicleModel(vehicle)==596||GetVehicleModel(vehicle)==597||GetVehicleModel(vehicle)==598)
	{
		new Shotgun[MAX_PLAYERS];
		new Weapon,Ammo;
		GetPlayerWeaponData(playerid,3,Weapon,Ammo);
		if(Weapon==25&&Ammo>=5)
		{
			Ammo=Shotgun[playerid];
			Shotgun[playerid]-=5;
			GivePlayerWeapon(playerid,25,-1);
			GivePlayerWeapon(playerid,25,Shotgun[playerid]+1);
			Shotgun[playerid]=0;
			SendInfoMessage(playerid,"부정행위 방지를 위하여 샷건을 삭제합니다");
		}
	}
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

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{

if(lock[vehicleid] !=-1 && !ispassenger && lock[vehicleid] !=playerid)
{
//차량탈취
new Float:X, Float:Y, Float:Z;
new Float:pos[3];
GetPlayerPos(playerid,pos[0],pos[1],pos[2]);
SetPlayerPos(playerid,pos[0],pos[1],pos[2]+5);
//차량 탈취범에게 표시되는 메세지
SendClientMessage(playerid, COLOR_RED, "차량 도난방지 시스템이 작동되있으므로 차량 절도가 불가능합니다.");
freezing[playerid]=true;
SetTimer("OnPlayerFreeze", 15000, 1);
TogglePlayerControllable(playerid,0);
SetPlayerSpecialAction(playerid,SPECIAL_ACTION_HANDSUP);
GetPlayerPos(playerid,X,Y,Z);
Y = Y+0.5;
X = X+0.5;
Z = Z+3;
SetPlayerPos(playerid,X,Y,Z);
SetPlayerPos(playerid,X,Y,Z);
SetPlayerPos(playerid,X,Y,Z);
RemovePlayerFromVehicle(playerid);
//차량 주인에게 표시되는 메세지
SendClientMessage(lock[vehicleid], COLOR_WHITE, "차량 도난방지가 작동되서 차량을 도난당하지 않았습니다.");
PutPlayerInVehicle(lock[vehicleid], vehicleid, 0);
/* 프리즈 처리는 알아서 추가해주세요ㅋ;; */
}

return 1;

}

public OnPlayerStateChange(playerid,newstate,oldstate)
{
//차량 탑승시 잠금
if(newstate == PLAYER_STATE_DRIVER) //이게맞나모르겠네....
{
lock[GetPlayerVehicleID(playerid)] = playerid;
lockvehicle[playerid] = GetPlayerVehicleID(playerid);
SendClientMessage(playerid, COLOR_YELLOW, "차량 도난방지 시스템이 작동되었습니다.");
}

//차량에서 내릴 때 잠금해제

if(oldstate == PLAYER_STATE_DRIVER)
{
lock[lockvehicle[playerid]] = -1;
lockvehicle[playerid] = -1;
}

return 1;

}

forward OnPlayerFreeze();
public OnPlayerFreeze()
{
for(new i=0; i<MAX_PLAYERS; i++)
{
if (IsPlayerConnected(i))
{
if(freezing[i] == 1)
{
TogglePlayerControllable(i,1);

freezing[i]=false;
}
}
}
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
    for(new i=0; i<MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
		    //Here
		}
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
if(a == pickupid)
{
SetPlayerPos(playerid,1307.914,-21.536,1340.148);
CreatePickup(1318,1,1307.935,-18.220,1340.253);
SetPlayerInterior(playerid,1);
SendClientMessage(playerid,COLOR_LIME,"*** 나이트 클럽에 입장셨습니다."); //제작자 무시 ㄴㄴ
}
if(b == pickupid)
{
SetPlayerPos(playerid,2036.577,991.272,11.625);
CreatePickup(1318,1,2033.664,991.230,11.217);
SetPlayerInterior(playerid,0);
SendClientMessage(playerid,COLOR_LIME,"*** 나이트 클럽밖으로 퇴장하셨습니다."); // 제작자 무시 ㄴㄴ
}
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
    new MyVehicle=GetPlayerVehicleID(playerid);
    if(IsPlayerInAnyVehicle(playerid)&&GetPlayerState(playerid)==PLAYER_STATE_DRIVER)
	{
	    if(newkeys==KEY_CROUCH)
	    {
	        new Float:Nos[3];
	        GetVehicleVelocity(MyVehicle,Nos[0],Nos[1],Nos[2]);
	    }
		if(newkeys==KEY_CROUCH)
		{
		    AddVehicleComponent(GetPlayerVehicleID(playerid),1010);
		    RepairVehicle(GetPlayerVehicleID(playerid));
		    GameTextForPlayer(playerid,"~g~Repair ~w~and ~g~Nitro",1000,3);
		}
		if(GetVehicleModel(MyVehicle)==432)/*Son-Nell Siger mode*/
 		{
			if(newkeys==KEY_FIRE)
			{
				CreateExplosion(-2724.8738,468.2350,4.2643,1,5000);//Boom A
				CreateExplosion(-2686.7046,468.2881,5.7150,1,5000);//Boom B
				CreateExplosion(-2706.3032,449.8932,4.1875,1,5000);//Boom C
				CreateExplosion(-2706.0752,490.2172,5.5039,1,5000);//Boom D
				CreateExplosion(-2694.3618,483.0638,4.9090,1,5000);//Boom E
				CreateExplosion(-2722.9280,482.4721,4.9727,1,5000);//Boom F
				CreateExplosion(-2718.3281,454.4266,4.3281,1,5000);//Boom G
				CreateExplosion(-2693.1194,455.0158,4.3359,1,5000);//Boom H
				CreateExplosion(-2690.6208,482.6210,5.2947,1,5000);//Boom I
			}
		}
	}
 	if(GetPlayerState(playerid)==PLAYER_STATE_ONFOOT)
	{
	    if(newkeys==KEY_ANALOG_LEFT)
		{
            FastReload(playerid);
	    }
	}
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
    for(new i=0; i<MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
		    //Here
		}
	}
	return 1;
}

public escTimer()
{
	for(new i = 0; i < M_P; i++)
	{
		if(IsPlayerConnected(i))
		{
			if(!PlayerESC[i])
			{
				PlayerESC[i] = true;
				if(ESC1[i]==2)
				{
					Delete3DTextLabel(ESCDO[i]);
					ESC1[i]=0;
				}
			}
			else
			{
				if(ESC1[i]==0)
				{
					ESCDO[i] = Create3DTextLabel(ESC_MESSAGE,C_YELLOW,0,0,0.7,15,0,0);
					Attach3DTextLabelToPlayer(ESCDO[i],i,0,0,0.6);
					ESC1[i]=2;
				}
			}
		}
	}
}

public OnPlayerUpdate(playerid)/*Anti Hack System Son-Nell*/
{
    /*========================================================================*/
    new string[256];
    new PlayerName[MAX_PLAYER_NAME];
	GetPlayerName(playerid,PlayerName,sizeof(PlayerName));
	new MyVehicle=GetPlayerVehicleID(playerid);
	new Float:VehHealth;
	GetVehicleHealth(MyVehicle,VehHealth);
	new Float:Armour; GetPlayerArmour(playerid,Armour);
	new Float:Health; GetPlayerHealth(playerid,Health);
	/*========================================================================*/
	if(Health<Aero_LastHealth[playerid])
	{
		CallRemoteFunction("OnPlayerLoseHealth","df",playerid,Aero_LastHealth[playerid]-Health);
	}
	Aero_LastHealth[playerid]=Health;
	/*========================================================================*/
	if(GetPlayerSpecialAction(playerid)==SPECIAL_ACTION_USEJETPACK)
	{
	    format(string,sizeof(string),"(알림) %s님이 제트팩을 사용합니다 자동밴 됩니다",PlayerName);
		SendClientMessageToAll(COLOR_ADMIN,string);
	    BanEx(playerid,"제트팩사용 (By. Server System)");
	}
	/*========================================================================*/
	if(PlayerToPoint(200,playerid,-5578.0029,470.2464,1209.2645))
	{
		if(AllWeapon)
		{
			ResetPlayerWeapons(playerid);
		}
		PlayerGodmode[playerid]=1;
		SetPlayerHealth(playerid,1000000);
	}
	else
	{
	    if(PlayerGodmode[playerid]==1)
	    {
	    	PlayerGodmode[playerid]=0;
	    	SetPlayerHealth(playerid,90);
		}
	}
	/*========================================================================*/
	if(PlayerESC[playerid] == true)
	PlayerESC[playerid] = false;
	return 1;
	/*========================================================================*/
    if(PlayerSpawn[playerid]==1)
    {
		if(Armour==100)
		{
		    SetPlayerArmour(playerid,0);
		    return 1;
		}
		if(Health==100)
		{
		    SetPlayerHealth(playerid,10);
		    return 1;
		}
	}
	/*========================================================================*/
	if(GetVehicleModel(MyVehicle)==432)/*Siger mode*/
 	{
		if(GetPlayerState(playerid)==PLAYER_STATE_DRIVER)
		{
            SetVehiclePos(MyVehicle,-2705.5623,468.5577,4.1893);
			SetVehicleZAngle(MyVehicle,359.9216);
			GameTextForPlayer(playerid,"~r~Siger ~w~Tank",1000,3);
			RepairVehicle(MyVehicle);
		}
	}
	/*========================================================================*/
	if(VehHealth<=249&&GetPlayerState(playerid)==PLAYER_STATE_DRIVER)/*Vehicle Fire*/
	{
        GameTextForPlayer(playerid,"~r~FIRE!! ~n~~b~Repair: ~y~'H' ~w~Key",1000,3);
	}
	/*========================================================================*/
	if(PlayerToPoint(1,playerid,-2843.9597,425.2397,4.6638))
	{
	    if(GetPlayerState(playerid)==PLAYER_STATE_ONFOOT)
	    {
		    SetPlayerPos(playerid,-2847.7891,425.1609,4.5000);
			WeaponDialog(playerid);
		}
	}
	/*========================================================================*/
	EnterInterior(playerid); SetPlayerScore(playerid,GetPlayerMoney(playerid));
	/*========================================================================*/
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
	new string[256];
	new PlayerName[MAX_PLAYER_NAME];
	GetPlayerName(playerid,PlayerName,sizeof(PlayerName));
    if(dialogid==DIALOG_1)
	{
		if(response)
		{
	        if(listitem==0)
	        {
	            SetPlayerFightingStyle(playerid,FIGHT_STYLE_GRABKICK);
	            SendInfoMessage(playerid,"기본기 무술을 배웠습니다");
	        }
	        if(listitem==1)
	        {
	            SetPlayerFightingStyle(playerid,FIGHT_STYLE_BOXING);
	            SendInfoMessage(playerid,"복싱 무술을 배웠습니다");
	        }
	        if(listitem==2)
	        {
	            SetPlayerFightingStyle(playerid,FIGHT_STYLE_KUNGFU);
	            SendInfoMessage(playerid,"쿵푸 무술을 배웠습니다");
	        }
	    }
 	}
 	if(dialogid==DIALOG_2)
	{
		if(response)
		{
	        if(listitem==0)
	        {
	            SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DRINK_BEER);
	            SendInfoMessage(playerid,"술병을 꺼내서 들었습니다, 마우스 오른쪽 키로 마십니다");
	        }
	        if(listitem==1)
	        {
	            SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DRINK_WINE);
	            SendInfoMessage(playerid,"와인병을 꺼내서 들었습니다, 마우스 오른쪽 키로 마십니다");
	        }
	        if(listitem==2)
	        {
	            SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DRINK_SPRUNK);
	            SendInfoMessage(playerid,"음료수를 꺼내서 들었습니다, 마우스 오른쪽 키로 마십니다");
	        }
	        if(listitem==3)
	        {
	            SetPlayerSpecialAction(playerid,SPECIAL_ACTION_SMOKE_CIGGY);
	            SendInfoMessage(playerid,"담배를 꺼내서 들었습니다, 마우스 오른쪽 키로 한모금 합니다");
	        }
	    }
	}
	if(dialogid==DIALOG_3)
	{
		if(response)
		{
	        if(listitem==0)
	        {
	        	if(GetPlayerMoney(playerid)>=30)
				{
		            SetPlayerHealth(playerid,90);
		            SendInfoMessage(playerid,"체력을 구매했습니다 (지불: $0)");
		            GivePlayerMoney(playerid,-0);
		            //Get in the Cooltime
				}
				else
				{
				    SendErrorMessage(playerid,"구매할 돈이 부족합니다 (가격: $30)");
				}
	        }
	        if(listitem==1)
	        {
	            if(GetPlayerMoney(playerid)>=50)
				{
					SetPlayerArmour(playerid,90);
					SendInfoMessage(playerid,"아머를 구매했습니다 (지불: $무료)");
					GivePlayerMoney(playerid,-0);
				}
				else
				{
				    SendErrorMessage(playerid,"구매할 돈이 부족합니다 (가격: $50)");
				}
	        }
		}
	}
	if(dialogid==DIALOG_4)
	{
		if(response)
		{
	        if(listitem==0)
	        {
	            if(GetPlayerMoney(playerid)>=50)
				{
				    GivePlayerMoney(playerid,-0);
				    GivePlayerWeapon(playerid,30,100000);
				    SendInfoMessage(playerid,"소총을 구매했습니다 (지불: $무료)");
				    ApplyAnimation(playerid,"BUDDY","buddy_reload",4.1,0,1,1,1,1);
				}
	        	else
	        	{
	        	    SendErrorMessage(playerid,"구매할 돈이 부족합니다 (가격: $50)");
	        	}
	        	WeaponDialog(playerid);
	        }
	        if(listitem==1)
	        {
	            if(GetPlayerMoney(playerid)>=50)
				{
				    GivePlayerMoney(playerid,-0);
				    GivePlayerWeapon(playerid,31,100000);
				    SendInfoMessage(playerid,"엠포를 구매했습니다 (지불: $무료)");
				    ApplyAnimation(playerid,"BUDDY","buddy_reload",4.1,0,1,1,1,1);
				}
	        	else
	        	{
	        	    SendErrorMessage(playerid,"구매할 돈이 부족합니다 (가격: $50)");
	        	}
	        	WeaponDialog(playerid);
	        }
	        if(listitem==2)
	        {
	            if(GetPlayerMoney(playerid)>=30)
				{
				    GivePlayerMoney(playerid,-0);
				    GivePlayerWeapon(playerid,24,100000);
				    SendInfoMessage(playerid,"데글을 구매했습니다 (지불: $무료)");
				    ApplyAnimation(playerid,"BUDDY","buddy_reload",4.1,0,1,1,1,1);
				}
	        	else
	        	{
	        	    SendErrorMessage(playerid,"구매할 돈이 부족합니다 (가격: $30)");
	        	}
	        	WeaponDialog(playerid);
	        }
	        if(listitem==3)
	        {
	            if(ReloadPack[playerid]==0)
	            {
		            if(GetPlayerMoney(playerid)>=1000)
					{
					    GivePlayerMoney(playerid,-0);
					    ReloadPack[playerid]=1;
					    SendInfoMessage(playerid,"패스트 리로드 스킬을 배웠습니다 (지불: $무료)");
					    SendHintMessage(playerid,"장전을 하시려면 왼쪽에 보이시는 넘패드 4번을 누르세요");
					    ApplyAnimation(playerid,"BUDDY","buddy_reload",4.1,0,1,1,1,1);
					}
		        	else
		        	{
		        	    SendErrorMessage(playerid,"구매할 돈이 부족합니다 (가격: $50)");
		        	}
		        	WeaponDialog(playerid);
	            }
				else
				{
				    SendErrorMessage(playerid,"이미 스킬을 배웠습니다");
				}
	        }
		}
	}
	if(dialogid==DIALOG_5)
	{
		if(response)
		{
			if(listitem==0)
			{
				new CheckName=strfind(PlayerName,MemberCheck,true);
				new TACheckName=strfind(PlayerName,TAMemberCheck,true);
				if(CheckName!=-1)
				{
				    format(string,sizeof(string),"당신은 이미 %s서버의 고정멤버 입니다",SERVER_TITLE);
				    SendErrorMessage(playerid,string);
					return 1;
				}
				if(TACheckName!=-1)
				{
				    SendErrorMessage(playerid,"당신은 이미 타서버의 고정멤버 입니다");
					return 1;
				}
                format(string,sizeof(string),"%s%s",SERVER_MEMVER,PlayerName);
				SetPlayerName(playerid,string);
				format(string, sizeof(string),"(알림) (%d) %s님께서 %s서버의 고정멤버로 등록하였습니다",playerid,PlayerName,SERVER_TITLE);
				SendClientMessageToAll(COLOR_INFO,string);
			}
		}
	}
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
    new Name[MAX_PLAYER_NAME];
	GetPlayerName(clickedplayerid,Name,sizeof(Name));
	new Cash = GetPlayerMoney(clickedplayerid);
    new message[256];
	format(message,sizeof(message),"유저 이름: %s (%s)\n소지 금액: %d",Name,Nickname,Cash);
	ShowPlayerDialog(playerid,MSGBOX_NONE,DIALOG_STYLE_MSGBOX,"플레이어 정보",message,"확인","취소");
	return 1;
}


public carrespawn()
{
RespawnVehicle();
SendClientMessageToAll(COLOR_TITLE,"{ff0000}모든 차량이 리스폰 됩니다.");
}



public Notice()
{
	new string[256];
	if(NoticeNumber==0)
	{
	    NoticeNumber++;
		SendClientMessageToAll(COLOR_TITLE,"(공지) 부운과 고멤을 모집중입니다. 지원해 보세요.");
		return 1;
	}
	if(NoticeNumber==1)
	{
	    NoticeNumber++;
		SendClientMessageToAll(COLOR_TITLE,"(공지) 육지로 내려가시면 재미난 총격전을 즐기실수 있습니다");
        return 1;
	}
	if(NoticeNumber==2)
	{
	    NoticeNumber++;
		SendClientMessageToAll(COLOR_TITLE,"(공지) 저희 서버는 자동수리와 네온이 있습니다");
		return 1;
	}
	if(NoticeNumber==3)
	{
	    NoticeNumber++;
		SendClientMessageToAll(COLOR_TITLE,"(공지) 도로가 중간에 없어져보이면 그곳은 점프대가 있는 도로입니다");
		return 1;
	}
	if(NoticeNumber==4)
	{
	    NoticeNumber++;
		SendClientMessageToAll(COLOR_TITLE,"(공지) 차량 경적키를 누르시면 차량이 수리되고 니트로가 달립니다");
		return 1;
	}
	if(NoticeNumber==5)
	{
	    NoticeNumber++;
		SendClientMessageToAll(COLOR_TITLE,"(공지) 핵,비매너는 1차 : 프리즈, 2차 : 킥, 3차 : 밴");
		return 1;
	}
	if(NoticeNumber==6)
	{
	    NoticeNumber++;
		SendClientMessageToAll(COLOR_TITLE,"(공지) 어드민하우스는 어드민만의 별장입니다. 들어가지 마십시요");
		return 1;
	}
	if(NoticeNumber==7)
	{
	    NoticeNumber++;
		SendClientMessageToAll(COLOR_TITLE,"(공지) 어드민하우스 헬기타고 들어오면 킥입니다.");
		return 1;
	}
	if(NoticeNumber==8)
	{
	    NoticeNumber++;
		SendClientMessageToAll(COLOR_TITLE,"(공지) 어드민하우스에 가고싶으면 어드민한테 부탁하세요.");
		return 1;
	}
	if(NoticeNumber==9)
	{
	    NoticeNumber++;
		SendClientMessageToAll(COLOR_TITLE,"(공지) 리스폰지역에서 비행기 소환 등등을 하시는분은 킥하겠습니다");
		return 1;
	}
	if(NoticeNumber==10)
	{
	    NoticeNumber++;
		SendClientMessageToAll(COLOR_TITLE,"(공지) 매일 아침마다 밴리스트 초기화됩니다. 단 제 마음입니다.");
		return 1;
	}
	if(NoticeNumber==11)
	{
	    NoticeNumber++;
		SendClientMessageToAll(COLOR_TITLE,"(공지) 페이크킬 안됩니다. 소비에트 발견시 밴입니다");
		return 1;
	}
	if(NoticeNumber==12)
	{
	    NoticeNumber++;
		SendClientMessageToAll(COLOR_TITLE,"(공지) 부운영자는 서버 관리를 위해 핵이허용되고 있습니다.");
		return 1;
	}
	if(NoticeNumber==13)
	{
	    NoticeNumber++;
		SendClientMessageToAll(COLOR_TITLE,"(공지) 고멤을 하시면 핵을 피해안주는것 까지만 허용케 하였습니다.");
		return 1;
	}
	if(NoticeNumber==14)
	{
	    NoticeNumber++;
		SendClientMessageToAll(COLOR_TITLE,"(공지) 본모드의 저작권은 이하이서버 및 C.L.N_Vlast 에게 있습니다.");
		return 1;
	}
	if(NoticeNumber==15)
	{
	    NoticeNumber++;
		SendClientMessageToAll(COLOR_TITLE,"(공지) 데스존에서만 짱뜨십시요.안그럼 감옥갑니다.");
		return 1;
	}
	if(NoticeNumber==16)
	{
	    NoticeNumber++;
	    format(string,sizeof(string),"(공지) 현제 총 유저는 %d명 입니다 서로 싸우지말고 즐겁게 게임하세요",USER_PLAYER);
		SendClientMessageToAll(COLOR_TITLE,string);
		return 1;
	}
	if(NoticeNumber==17)
	{
	    NoticeNumber=0;
	    format(string,sizeof(string),"(공지) 오늘 저희서버에는 총 %d명이 방문하셨습니다",CONSOLE_PLAYER);
		SendClientMessageToAll(COLOR_TITLE,string);
		return 1;
	}
	if(NoticeNumber==18)
	{
	    NoticeNumber++;
		SendClientMessageToAll(COLOR_TITLE,"(공지) 저희서버는 현재 Sy서버와 동맹중입니다.");
		return 1;
	}
	if(NoticeNumber==19)
	{
	    NoticeNumber++;
		SendClientMessageToAll(COLOR_TITLE,"(공지) /무장을 하엿을때 나오는 무기를 업데이트 하였습니다.");
		return 1;
	}
	if(NoticeNumber==20)
	{
	    NoticeNumber++;
		SendClientMessageToAll(COLOR_TITLE,"(공지) 무장을 할시 스나, MP5, 카타나 등등이 지급됩니다!");
		return 1;
	}
	return 1;
}

public MakeBy()
{
    if(MakeByNumber==0)
	{
	    MakeByNumber++;
	    SendClientMessageToAll(COLOR_TITLE,"=============================================================");
	    SendClientMessageToAll(COLOR_TITLE,"                                                             ");
	    SendClientMessageToAll(COLOR_HINT, "  		이하이 절벽질주 제작자는 C.L.N_Vlast입니다 즐겜하세요 ");
	    SendClientMessageToAll(COLOR_TITLE,"                                                             ");
	    SendClientMessageToAll(COLOR_TITLE,"=============================================================");
	    return 1;
	}
	if(MakeByNumber==1)
	{
	    MakeByNumber++;
	    SendClientMessageToAll(COLOR_TITLE,"=============================================================");
	    SendClientMessageToAll(COLOR_TITLE,"                                                             ");
	    SendClientMessageToAll(COLOR_HINT, "        산안드레스 멀티 자체를 처음하시는분은 \"/처음\" 입력 ");
	    SendClientMessageToAll(COLOR_TITLE,"                                                             ");
	    SendClientMessageToAll(COLOR_TITLE,"=============================================================");
	    return 1;
	}
	if(MakeByNumber==2)
	{
	    MakeByNumber++;
	    SendClientMessageToAll(COLOR_TITLE,"=============================================================");
	    SendClientMessageToAll(COLOR_TITLE,"                                                             ");
	    SendClientMessageToAll(COLOR_HINT, "            이게임은 단순히 육지로가면 끝나는게임이 아닙니다 ");
	    SendClientMessageToAll(COLOR_HINT, " 육지로 내려간사람에게 혜택과 즐거움을 주기위해 개발중입니다 ");
	    SendClientMessageToAll(COLOR_TITLE,"                                                             ");
	    SendClientMessageToAll(COLOR_TITLE,"=============================================================");
	    return 1;
	}
	if(MakeByNumber==3)
	{
	    MakeByNumber++;
	    SendClientMessageToAll(COLOR_TITLE,"=============================================================");
	    SendClientMessageToAll(COLOR_TITLE,"                                                             ");
	    SendClientMessageToAll(COLOR_HINT, "             육지에 내려가셔서 \"/무장\" 하시면 무기얻습니다 ");
	    SendClientMessageToAll(COLOR_HINT, "                     아머랑 체력은 \"/구매\" 하시길 바랍니다 ");
	    SendClientMessageToAll(COLOR_TITLE,"                                                             ");
	    SendClientMessageToAll(COLOR_TITLE,"=============================================================");
	    return 1;
	}
	if(MakeByNumber==4)
	{
	    MakeByNumber=0;
	    SendClientMessageToAll(COLOR_TITLE,"=============================================================");
	    SendClientMessageToAll(COLOR_TITLE,"                                                             ");
	    SendClientMessageToAll(COLOR_HINT, "                    		   이하이의 절벽질주 본서버 카페 ");
	    SendClientMessageToAll(COLOR_HINT, "                             http://cafe.naver.com/leehi123/ ");
	    SendClientMessageToAll(COLOR_TITLE,"                                                             ");
	    SendClientMessageToAll(COLOR_TITLE,"=============================================================");
	    return 1;
	}
	return 1;
}

public Timer()
{
    NameLabel();
    for(new i=0; i<MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
		    if(Jailed[i]==1)
		    {
			    if(JailedTime[i]>=0)
			    {
			    	JailedTime[i]--;
			    	if(JailedTime[i]<=0)
			    	{
			    	    Jailed[i]=0; JailedTime[i]=0;
			    	}
			    }
			}
		}
	}
	return 1;
}

public DeleteLabel(playerid)
{
    Delete3DTextLabel(NicknameTag[playerid]);
}

public NameLabel()
{
    for(new i=0; i<MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
		    new Float:Nos[3];
		    new COLOR_PLAYER=GetPlayerColor(i);
			new string[MAX_PLAYER_NAME];
			GetPlayerPos(i,Nos[0],Nos[1],Nos[2]);
			format(string,sizeof(string),"%s",Nickname[i]);
			Create3DTextLabel(string,COLOR_PLAYER,0.0,0.0,0.0,30,0);
			Update3DTextLabelText(NicknameTag[i],COLOR_PLAYER,string);
			Attach3DTextLabelToPlayer(NicknameTag[i],i,Nos[0],Nos[1],Nos[2]);
		}
	}
}

public GiveWarring(playerid)
{
	new string[256];
	new PlayerName[MAX_PLAYER_NAME];
	GetPlayerName(playerid,PlayerName,sizeof(PlayerName));
    Warring[playerid]++;
    format(string,sizeof(string),"당신은 데스매치존에서 싸우지 않아 옐로카드를 받으셨습니다 (%d/%d)",Warring[playerid],MAX_WARING);
    SendInfoMessage(playerid,string);
    
    if(Warring[playerid]>=MAX_WARING)
    {
	    format(string,sizeof(string),"당신은 옐로카드를 많이받아서 사망합니다");
        SendInfoMessage(playerid,string);
        SetPlayerHealth(playerid,0);
        Warring[playerid]=0;
	}
}

public ResetInfo(playerid)
{
    Warring[playerid]=0; PlayerGodmode[playerid]=0; DriveKill[playerid]=0; ReloadPack[playerid]=0;
    Jailed[playerid]=0; JailedTime[playerid]=0;
}

public SafeHealth(playerid)
{
    PlayerSpawn[playerid]=0;
	SetPlayerHealth(playerid,90);
	PlayerSpawn[playerid]=1;
}

public WeaponDialog(playerid)
{
    ShowPlayerDialog(playerid,DIALOG_4,DIALOG_STYLE_LIST,"이하이 무기상점","(1) 소총($50)\n(1) 엠포($50)\n(2) 데글($30)\n(Skill) 빠른 장전($1000)\n \n번호끼리는 무기가 겹침","구매","취소");
}


public IconPlayer(playerid)
{
    SetPlayerMapIcon(playerid,0,-2832.5476,424.2212,13.1257,ICON_GUN,COLOR_INFO);
    SetPlayerMapIcon(playerid,1,-2918.2954,176.8986,8.9024,ICON_DEATH,COLOR_INFO);
    SetPlayerMapIcon(playerid,2,-2705.7363,468.3256,6.9519,ICON_WHAT,COLOR_INFO);
    SetPlayerMapIcon(playerid,3,-2891.2395,464.9435,4.9141,9,COLOR_INFO);
    SetPlayerMapIcon(playerid,4,-2926.6616,573.7340,17.9416,21,COLOR_INFO);
    GangZoneShowForPlayer(playerid,DMzone,Gzone_RED);/*DM Zone - not icon*/
}

public PlayerJailed(playerid, Time, Float:X, Float:Y, Float:Z, Interior)
{
	Jailed[playerid]=1; JailedTime[playerid]=Time;
	SetPlayerPos(playerid,X,Y,Z);
	SetPlayerInterior(playerid,Interior);
}

public RespawnCheck(playerid)
{
    if(IsPlayerInAnyVehicle(playerid)&&GetPlayerState(playerid)==PLAYER_STATE_DRIVER)
	{
	    new MyVehicle=GetPlayerVehicleID(playerid);
		SetVehicleToRespawn(MyVehicle);
	}
}

public FastReload(playerid)
{
	if(ReloadPack[playerid]==1)
	{
		if(GetPlayerWeapon(playerid)==24||GetPlayerWeapon(playerid)==30||GetPlayerWeapon(playerid)==31)
		{
		    if(GetPlayerWeapon(playerid)==24)
		    {
		        GivePlayerWeapon(playerid,24,100000);
		    }
		    if(GetPlayerWeapon(playerid)==30)
		    {
		        GivePlayerWeapon(playerid,30,100000);
		    }
		    if(GetPlayerWeapon(playerid)==31)
		    {
	            GivePlayerWeapon(playerid,31,100000);
		    }
	        ApplyAnimation(playerid,"BUDDY","buddy_reload",4.1,0,1,1,1,1);
	        GameTextForPlayer(playerid,"~g~Fast ~w~Reload",1000,3);
		}
	}
}

public EnterInterior(playerid)
{
	/*========================================================================*/
    if(PlayerToPoint(1,playerid,-2915.5056,175.5506,3.3711))//해적기지 입장
	{
	    if(GetPlayerState(playerid)==PLAYER_STATE_ONFOOT)
	    {
			TelePlayer(playerid,-395.4767,1261.7261,7.1441,0);
	    }
	}

	if(PlayerToPoint(1,playerid,-396.2138,1256.1169,6.9611))//해적기지 퇴장
	{
	    if(GetPlayerState(playerid)==PLAYER_STATE_ONFOOT)
	    {
			TelePlayer(playerid,-2920.5366,178.4711,2.4638,0);
	    }
	}
	/*==================================================================================*/
    if(PlayerToPoint(1,playerid,-3121.7297,-138.6293,1014.8406))//어드민 입장
	{
	    if(GetPlayerState(playerid)==PLAYER_STATE_ONFOOT)
	    {
			TelePlayer(playerid,-3153.5549,-550.4894,1114.8578,0);
	    }
	}
	
	if(PlayerToPoint(1,playerid,-3145.4287,-560.6431,1114.8578))//어드민 퇴장
	{
	    if(GetPlayerState(playerid)==PLAYER_STATE_ONFOOT)
	    {
			TelePlayer(playerid,-3034.9163,-149.4568,1014.8383,87);
			SetPlayerInterior(playerid,0);
	    }
	}
	/*==================================================================================*/
    if(PlayerToPoint(1,playerid,-2671.5483,258.2610,4.6328))//치킨집입장
	{
	    if(GetPlayerState(playerid)==PLAYER_STATE_ONFOOT)
	    {
			TelePlayer(playerid,-3198.4368,-557.8450,1107.9828,198);
	    }
	}
	
	if(PlayerToPoint(1,playerid,-3199.5732,-567.0225,1107.9828))//치킨집 퇴장
	{
	    if(GetPlayerState(playerid)==PLAYER_STATE_ONFOOT)
	    {
			TelePlayer(playerid,-2671.8809,273.6482,4.3359,180);
			SetPlayerInterior(playerid,0);
	    }
	}
	/*==================================================================================*/
    if(PlayerToPoint(1,playerid,-2801.8828,375.6166,6.3349))//경찰서 입장
	{
	    if(GetPlayerState(playerid)==PLAYER_STATE_ONFOOT)
	    {
			TelePlayer(playerid,-3176.5227,-576.4786,1111.6000,77);
	    }
	}

	if(PlayerToPoint(1,playerid,-3178.8916,-581.2861,1111.6000))//경찰서 퇴장
	{
	    if(GetPlayerState(playerid)==PLAYER_STATE_ONFOOT)
	    {
			TelePlayer(playerid,-2809.5645,375.4189,4.5082,271);
			SetPlayerInterior(playerid,0);
	    }
	}
	/*========================================================================*/
    if(PlayerToPoint(1,playerid,3443.9236,-2101.2620,4.6298))//시장집 입장
	{
	    if(GetPlayerState(playerid)==PLAYER_STATE_ONFOOT)
	    {
			TelePlayer(playerid,1264.67, -780.9501, 1091.9);
			SetPlayerInterior(playerid,5);
	    }
	}

	if(PlayerToPoint(1,playerid,-3178.8916,-581.2861,1111.6000))//시장집 퇴장
	{
	    if(GetPlayerState(playerid)==PLAYER_STATE_ONFOOT)
	    {
			TelePlayer(playerid,-2809.5645,375.4189,4.5082,271);
			SetPlayerInterior(playerid,0);
	    }
	}
	/*========================================================================*/
}

/*============================================================================*/
																																									/*
			                    Make by Son-Nell
				   Copyrightⓒ Hyeong-Uk All right reserved
																																									*/
/*============================================================================*/
