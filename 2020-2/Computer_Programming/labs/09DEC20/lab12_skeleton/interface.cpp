#include <iostream>
#include <sstream>
#include <string>
#include <vector>
#include <algorithm>
#include "restaurant_app.h"


void run_command(std::vector<std::string> cmd);
RestaurantApp app;

int main() {
    std::cout << "Welcome to Restaurant Rating System" << std::endl;
    std::cout << "Commands : (EXIT to exit)" << std::endl;
    std::cout << "\tRATE <name> <X> | LIST | SHOW <name>" << std::endl;
    std::cout << "\tAVE <name> | MED <name> | MIN <name> | MAX <name> <X>" 
            << std::endl;
    std::cout << "\tDEL <name> <X> | CHEAT <name> <X>" << std::endl;

    std::string input;
    while (input != "EXIT") {
        std::getline(std::cin, input);

        std::stringstream ss(input);
        std::vector<std::string> cmds;
        std::string str;
        while (ss >> str) {
            cmds.push_back(str);
        }

        run_command(cmds);
    }
}


void run_command(std::vector<std::string> cmd) {
    if (cmd.size() == 1) {
        if (cmd[0] == "LIST") {
            app.list();
        }
    }
    else if (cmd.size() == 2) {
        if (cmd[0] == "SHOW") {
            app.show(cmd[1]);
        }
        else if (cmd[0] == "AVE") {
            app.ave(cmd[1]);
        }
        else if (cmd[0] == "MED") {
            app.med(cmd[1]);
        }
        else if (cmd[0] == "MIN") {
            app.min(cmd[1]);
        }
        else if (cmd[0] == "MAX") {
            app.max(cmd[1]);
        }
    }
    else if (cmd.size() == 3) {
        if (cmd[0] == "RATE") {
            app.rate(cmd[1], std::stoi(cmd[2]));
        }
        else if (cmd[0] == "DEL") {
            app.del(cmd[1], std::stoi(cmd[2]));
        }
        else if (cmd[0] == "CHEAT") {
            app.cheat(cmd[1], std::stoi(cmd[2]));
        }    
    }
}
