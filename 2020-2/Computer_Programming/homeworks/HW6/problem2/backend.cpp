#include <iostream>
#include <fstream>
#include "backend.h"

using namespace std;

BackEnd::BackEnd() { }

bool BackEnd::auth(string id, string pw) {
    ifstream ifs(SERVER_STORAGE_DIR + id + "/password.txt");
    string true_pw;
    
    getline(ifs, true_pw);
    ifs.close();
    return true_pw == pw;
}