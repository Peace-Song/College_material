#include <ctime>
#include <vector>
#include <algorithm>
#include "user_interface.h" // to evade circular reference problem
// #include "frontend.h"

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
    time_t curr_time = time(nullptr);

    this->backend->post(this->user->id, title, content, curr_time);
}

void FrontEnd::recommend() {
    vector<Post*> posts = this->backend->get_friends_posts(this->user->id);
    
    posts.resize(min((int) posts.size(), 10));

    for (Post *post : posts) {
        ui->println(post->to_string());
    }
}

void FrontEnd::search(string command) {
    vector<string> keywords;
    vector<string> slices = split(command, " ");
    slices.erase(slices.begin());

    for (string keyword : slices) {
        if (find(keywords.begin(), keywords.end(), keyword) == keywords.end()) {
            keywords.push_back(keyword);
        }
    }
    
    vector<Post*> posts = this->backend->search(keywords);

    posts.resize(min((int) posts.size(), 10));

    ui->println("-----------------------------------");
    for (Post* post : posts) {
        ui->println(post->get_summary());
    }
}

User* FrontEnd::get_user() {
    return this->user;
}

vector<string> FrontEnd::split(string str, string delim) {
    vector<string> result;
    size_t curr_pos = str.find(delim);
    size_t prev_pos = 0;
    
    while (curr_pos != string::npos) {
        result.push_back(str.substr(prev_pos, curr_pos - prev_pos));
        prev_pos = curr_pos + 1;
        curr_pos = str.find(delim, prev_pos);
    }
    result.push_back(str.substr(prev_pos, curr_pos - prev_pos));

    return result;
}

