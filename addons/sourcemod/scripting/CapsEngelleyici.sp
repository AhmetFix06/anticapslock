#include <sourcemod>
#include <chat-processor>

#pragma semicolon 1
#pragma newdecls required

public Plugin myinfo = 
{
	name = "Caps Engelleyici",
	author = "AhmetFix",
	description = "Caps ile yazılan kelimeleri engeller.",
	version = "1.0",
	url = "https://github.com/AhmetFix06"
};

ConVar g_cvarMinLength = null;

public void OnPluginStart()
{
	g_cvarMinLength = CreateConVar("gerekli_kelime_sayisi", "2", "Capssiz yazmaya zorlaması için gereken karakter sayısı.", _, true, 0.0);
	AutoExecConfig(true, "CapsEngelleyici", "AhmetFix");
}

public Action CP_OnChatMessage(int & author, ArrayList recipients, char[] flagstring, char[] name, char[] message, bool & processcolors, bool & removecolors)
{
	int klm, lnth = strlen(message);
	for (int i = 0; i < lnth; i++)
	{
		if (message[i] >= 'A' && message[i] <= 'Z')
		{
			klm++;
		}
	    else if (message[i] >= 'a' && message[i] <= 'z')
	    {
			klm++;
	    }
	}    
	if (klm >= g_cvarMinLength.IntValue)
	{
		for (int i = 0; i < lnth; i++)
		{
			if (message[i] >= 'A' && message[i] <= 'Z')
			{
				message[i] = CharToLower(message[i]);
			}
		}
		return Plugin_Changed;
	}
	return Plugin_Continue;
}