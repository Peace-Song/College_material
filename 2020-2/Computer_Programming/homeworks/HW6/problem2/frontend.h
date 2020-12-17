#include <string>
#include <vector>
#include "user.h"
#include "backend.h"

using namespace std;

class UserInterface;

class FrontEnd {
public:
    FrontEnd(UserInterface *ui, BackEnd *be);
    bool auth(string auth_info);
    void post(pair<string, string> title_content_pair);
    void recommend();
    void search(string command);
    User* get_user();

private:
    UserInterface *ui;
    BackEnd *backend;
    User *user;

    vector<string> split(string str, string delim);
};