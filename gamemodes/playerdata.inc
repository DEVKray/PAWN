#include <a_samp>
#include <dini>

enum E_PlayerData
{
    Float:pPosX,
    Float:pPosY,
    Float:pPosZ,
    Float:pRot,
}
new PlayerInfo[MAX_PLAYERS][E_PlayerData];

public OnPlayerConnect(playerid)
{
    new 
        pName[MAX_PLAYER_NAME],
        PlayerPathFile[50];

    GetPlayerName(playerid, pName, sizeof(pName));
    format(PlayerPathFile, sizeof(PlayerPathFile), "/PlayerData/%s.ini", pName);

    if(!dini_Exists(PlayerPathFile))
    {
        dini_Create(PlayerPathFile);
        // assign default location values to the vars //
    }
    else
    {
        PlayerInfo[playerid][pPosX] = dini_Float(PlayerPathFile, "PositionX");
        PlayerInfo[playerid][pPosY] = dini_Float(PlayerPathFile, "PositionY");
        PlayerInfo[playerid][pPosZ] = dini_Float(PlayerPathFile, "PositionZ");
        PlayerInfo[playerid][pRot] = dini_Float(PlayerPathFile, "Rotation");
    }

    SetSpawnInfo(playerid, 0, 0, PlayerInfo[playerid][pPosX], PlayerInfo[playerid][pPosY], PlayerInfo[playerid][pPosZ], PlayerInfo[playerid][pRot], 0, 0, 0, 0, 0, 0);

    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    new 
        pName[MAX_PLAYER_NAME],
        PlayerPathFile[50];

    GetPlayerName(playerid, pName, sizeof(pName));
    format(PlayerPathFile, sizeof(PlayerPathFile), "/PlayerData/%s.ini", pName);

    dini_FloatSet(PlayerPathFile, "PositionX", PlayerInfo[playerid][pPosX]);
    dini_FloatSet(PlayerPathFile, "PositionY", PlayerInfo[playerid][pPosY]);
    dini_FloatSet(PlayerPathFile, "PositionZ", PlayerInfo[playerid][pPosZ]);
    dini_FloatSet(PlayerPathFile, "Rotation", PlayerInfo[playerid][pRot]);

    return 1;
}