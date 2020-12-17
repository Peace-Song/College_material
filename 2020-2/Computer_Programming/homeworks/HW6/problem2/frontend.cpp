#include <ctime>
#include "frontend.h"
#include "user_interface.h"



FrontEnd::FrontEnd(UserInterface *ui, BackEnd *be): ui(ui), backend(be) { }

bool FrontEnd::auth(string auth_info) {
    string delim = "\n";
    string id = auth_info.substr(0, auth_info.find(delim));
    string password = auth_info.substr(auth_info.find(delim) + 1);

    if (this->backend->auth(id, password)) {
        this->user = new User(id, password);
        return true;
    }
    return false;
}

void FrontEnd::post(pair<string, string> title_content_pair) {
    string title = title_content_pair.first;
    string content = title_content_pair.second;

}

void FrontEnd::recommend() {

}

void FrontEnd::search() {

}

User* FrontEnd::get_user() {

}
