#include <iostream>
#include <fstream>
#include <filesystem>
#include <algorithm>
#include "backend.h"

namespace fs = std::filesystem;

BackEnd::BackEnd() { }

bool BackEnd::auth(string id, string pw) {
    // ifstream ifs(SERVER_STORAGE_DIR + id + "/password.txt");
    ifstream ifs;
    ifs.open((SERVER_STORAGE_DIR + id + "/password.txt").c_str());

    string true_pw;
    
    getline(ifs, true_pw);
    ifs.close();
    return true_pw == pw;
}

void BackEnd::post(string id, string title, string content, time_t curr_time) {
    struct tm* time_info = localtime(&curr_time);
    char formatted_time[20];
    strftime(formatted_time, 20, "%Y/%m/%d %T", time_info);
    int post_num = get_post_num();
    // ofstream ofs(SERVER_STORAGE_DIR + id + "/post/" + to_string(post_num) + ".txt");
    ofstream ofs;
    ofs.open((SERVER_STORAGE_DIR + id + "/post/" + to_string(post_num) + ".txt").c_str());

    ofs << formatted_time << endl;
    ofs << title << endl << endl;
    ofs << content << endl;
    
    ofs.close();
}

vector<Post*> BackEnd::search(vector<string> keywords) {
    vector<pair<Post*, int>> post_occurence_pair;

    auto server_storage_dir_iter = fs::directory_iterator(SERVER_STORAGE_DIR);
    for (auto& user_dir : server_storage_dir_iter) {
        if (!user_dir.is_directory()) {
            continue;
        }

        auto post_dir_iter = fs::directory_iterator(user_dir.path().string() + "/post/");
        for (auto& post_file : post_dir_iter) {
            string file_name = post_file.path().filename();
            // ifstream ifs(post_file);
            ifstream ifs;
            ifs.open(post_file.path().c_str());
            string date;
            string title;
            string content = "";
            string content_line;
            string dummy;

            getline(ifs, date);
            getline(ifs, title);
            getline(ifs, dummy);
            while (getline(ifs, content_line)) {
                content += content_line + " ";
            }

            int count = 0;
            for (string keyword : keywords) {
                for (string title_kw : split(title, " ")) {
                    if (title_kw == keyword) {
                        count++;
                    }
                }

                for (string content_kw : split(content, " ")) {
                    if (content_kw == keyword) {
                        count++;
                    }
                }
            }

            if (count != 0) {
                struct tm time_info;
                time_info.tm_year = atoi(date.substr(0, 4).c_str()) - 1900;
                time_info.tm_mon  = atoi(date.substr(5, 2).c_str()) - 1;
                time_info.tm_mday = atoi(date.substr(8, 2).c_str());
                time_info.tm_hour = atoi(date.substr(11, 2).c_str());
                time_info.tm_min  = atoi(date.substr(14, 2).c_str());
                time_info.tm_sec  = atoi(date.substr(17, 2).c_str());
                time_info.tm_isdst = 0;

                post_occurence_pair.push_back(
                    pair<Post*, int>(
                        new Post(stoi(file_name.substr(0, file_name.find("."))), mktime(&time_info), title, content),
                        count
                    )
                );
            }

            ifs.close();
        }
    }
    
    sort(post_occurence_pair.begin(), post_occurence_pair.end(),
        [](pair<Post*, int> &p1, pair<Post*, int> &p2) {
            if (p1.second == p2.second) {
                return p1.first->get_time() > p2.first->get_time();
            } else {
                return p1.second > p2.second;
            }
        }
    );

    vector<Post*> result;
    for (pair<Post*, int> pair : post_occurence_pair) {
        result.push_back(pair.first);
    }

    return result;
}

vector<Post*> BackEnd::get_friends_posts(string id) {
    vector<string> friend_names;
    vector<Post*> friend_posts;

    // ifstream ifs(SERVER_STORAGE_DIR + id + "/friend.txt");
    ifstream ifs;
    ifs.open((SERVER_STORAGE_DIR + id + "/friend.txt").c_str());
    string name;
    while (getline(ifs, name)) {
        friend_names.push_back(name);
    }
    ifs.close();

    for (string friend_name : friend_names) {
        auto friend_post_dir_iter = fs::directory_iterator(SERVER_STORAGE_DIR + friend_name + "/post/");
        for (auto& post : friend_post_dir_iter) {
            string file_name = post.path().filename();
            // ifstream ifs(post);
            ifstream ifs;
            ifs.open(post.path().c_str());
            string date;
            string title;
            string content = "";
            string content_line;
            string dummy;

            getline(ifs, date);
            getline(ifs, title);
            getline(ifs, dummy);
            while (getline(ifs, content_line)) {
                content += content_line + "\n";
            }

            struct tm time_info;
            time_info.tm_year = atoi(date.substr(0, 4).c_str()) - 1900;
            time_info.tm_mon  = atoi(date.substr(5, 2).c_str()) - 1;
            time_info.tm_mday = atoi(date.substr(8, 2).c_str());
            time_info.tm_hour = atoi(date.substr(11, 2).c_str());
            time_info.tm_min  = atoi(date.substr(14, 2).c_str());
            time_info.tm_sec  = atoi(date.substr(17, 2).c_str());
            time_info.tm_isdst = 0;

            friend_posts.push_back(new Post(stoi(file_name.substr(0, file_name.find("."))), mktime(&time_info), title, content));

            ifs.close();
        }
    }

    sort(friend_posts.begin(), friend_posts.end(), 
        [](Post *p1, Post *p2) {
            return p1->get_time() > p2->get_time();
        }
    );

    return friend_posts;
}


int BackEnd::get_post_num() {
    int max_id = 0;

    auto storage_dir_iter = fs::directory_iterator(SERVER_STORAGE_DIR);
    for (auto& user_dir : storage_dir_iter) {
        if (user_dir.is_directory()) {
            auto post_dir_iter = fs::directory_iterator(user_dir.path().string() + "/post/");
            for (auto& post_file : post_dir_iter) {
                string file_name = post_file.path().filename();
                int post_num = stoi(file_name.substr(0, file_name.find(".")));
                
                if (post_num > max_id) {
                    max_id = post_num;
                }
            }
        }
    }

    return max_id + 1;
}

vector<string> BackEnd::split(string str, string delim) {
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