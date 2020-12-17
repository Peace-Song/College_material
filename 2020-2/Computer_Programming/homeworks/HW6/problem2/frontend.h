// #include "user_interface.h"
#include "backend.h"
#include "user.h"

class UserInterface;

class FrontEnd {
public:
    FrontEnd(UserInterface *ui, BackEnd *be);
    bool auth(string auth_info);
    void post(pair<string, string> title_content_pair);
    void recommend();
    void search();
    User* get_user();

private:
    UserInterface *ui;
    BackEnd *backend;
    User *user;
};