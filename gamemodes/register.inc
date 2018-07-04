#include <a_samp>
#include <dini>
#include <ZCMD>

#include "./colors.inc"

new level[MAX_PLAYERS];
new logged[MAX_PLAYERS];

stock udb_hash(buf[], length = sizeof(buf))
{
    new s1 = 1, s2 = 0, n;
    for (n = 0; n < length; n++)
    {
       s1 = (s1 + buf[n]) % 65521;
       s2 = (s2 + s1) % 65521;
    }
    return (s2 << 16) + s1;
}
CMD:register(playerid, params[])
{
	new file[128], pname[MAX_PLAYER_NAME];
	GetPlayerName (playerid, pname, sizeof(pname));
	format (file, sizeof(file), "/Users/%s.ini", pname);
	if(!strlen(params)) return SendClientMessage(playerid, COLOR_RED, "USAGE:/register [password]");
	if(dini_Exists(file)) return SendClientMessage(playerid, COLOR_RED, "You are already registered!");
	dini_Create(file);
	dini_IntSet(file, "hashPW", udb_hash(params, 128));
	dini_Set(file, "password", params);
	dini_IntSet(file, "level", 0);
	dini_IntSet(file, "score", GetPlayerScore(playerid));
	dini_IntSet(file, "money", GetPlayerMoney(playerid));
	new string[128];
	format(string, 128, "Yoh have successfully registered the nickname %s with password %s", pname, params);
	SendClientMessage(playerid, COLOR_YELLOW, string);
	logged[playerid] = 1;
	SendClientMessage(playerid, COLOR_YELLOW, "You have been automatically logged in!");
	return 1;
}

CMD:login(playerid, params[])
{
	new file[128];
	new string[128], pname[MAX_PLAYER_NAME];
	GetPlayerName(playerid, pname, sizeof(pname));
	format(file, sizeof(file), "/Users/%s.ini", pname);
	if(!strlen(params)) return SendClientMessage(playerid, COLOR_RED, "USAGE: /login [password]");
	if(!dini_Exists(file)) return SendClientMessage(playerid, COLOR_RED, "You are not registered!");
	if(logged[playerid]) return SendClientMessage(playerid, COLOR_RED, "You are already logged in!");
	new tmp;
	tmp = dini_Int(file, "hashPW");
	if(udb_hash(params, 128) != tmp)
	{
	  format(string, 256, "You have specified the wrong password for %s!", pname);
	  SendClientMessage(playerid, COLOR_RED, string);
	 }
	 else
	 {
	  	logged[playerid] = 1;
	  	level[playerid] = dini_Int(file, "level");
	  	SetPlayerScore(playerid, dini_Int(file, "score"));
		GivePlayerMoney(playerid, dini_Int(file, "money")-GetPlayerMoney(playerid));
	  	SendClientMessage(playerid, COLOR_YELLOW, "You have succesfully logged in!");
	  	printf("%s (%i) logged in with password %s", pname, playerid, params);
	  }
	  
	return 1;
}