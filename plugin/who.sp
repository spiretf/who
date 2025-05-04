#pragma semicolon 1
#include <sourcemod>

public Plugin:myinfo = {
	name = "who",
	author = "Icewind",
	description = "Who?",
	version = "0.1",
	url = "https://spire.tf"
};

public Action OnClientSayCommand(int client, const char[] command, const char[] sArgs) {
    if (strcmp(sArgs, "!who", false) == 0) {
        CreateTimer(0.1, HandleWhoCommand, client);
    }
    if (strcmp(sArgs, "!how", false) == 0) {
        CreateTimer(0.1, HandleHowCommand, client);
    }

    return Plugin_Continue;
}

public Action HandleWhoCommand(Handle Timer, int client) {
    PrintToChatAll("Everyone always asks \"Who is server?\". But nobody ever asks \"How is server?\".");

    return Plugin_Handled;
}

public Action HandleHowCommand(Handle Timer, int client) {
    PrintToChatAll("Doing well, thanks for asking.");

    return Plugin_Handled;
}
