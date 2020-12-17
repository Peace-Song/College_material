#include <iostream>
#include "user_interface.h"

UserInterface::UserInterface(istream& is, ostream& os): is(is), os(os) { }

void UserInterface::create_ui(FrontEnd *frontend) {
    this->frontend = frontend;
    this->auth_view = new AuthView(is, os);
    this->post_view = new PostView(is, os);
    this->main_view = this->auth_view;
}

void UserInterface::println(string str) {
    main_view->println(str);
}

void UserInterface::run() {
    string command;
    string auth_info = auth_view->get_user_input("------ Authentication ------\n");

    if (frontend->auth(auth_info)) {
        main_view = post_view;
        do {
            command = post_view->get_user_input(
                "-----------------------------------\n" +
                frontend->get_user()->id + "@sns.com\n" +
                "post : Post contents\n" +
                "recommend : recommend interesting posts\n" +
                "search <keyword> : List post entries whose contents contain <keyword>\n" +
                "exit : Terminate this program\n" +
                "-----------------------------------\n" +
                "Command="
            );
        } while (query(command));
    } else {
        println("Failed Authentication.");
    }
}

string UserInterface::parse_instruction(string command) {
    string delim = " ";
    string instr = command.substr(0, command.find(delim));
    return instr;
}

bool UserInterface::query(string command) {
    string instruction = parse_instruction(command);
    if (instruction == "exit") {
        return false;
    } else if (instruction == "post") {
        post();
    } else if (instruction == "search") {
        search(command);
    } else if (instruction == "recommend") {
        recommend();
    } else {
        os << "Illegal Command Format : " << command << endl;
    }
    
    return true;
}

void UserInterface::post() {
    frontend->post(post_view->get_post("New Post"));
}

void UserInterface::search(string command) {
    frontend->search(command);
}

void UserInterface::recommend() {
    frontend->recommend();
}