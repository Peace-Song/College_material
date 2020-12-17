#include <string>
#include "view.h"
#include "frontend.h"

using namespace std;

class UserInterface {
public:
    PostView *post_view;
    AuthView *auth_view;
    View *main_view;

    UserInterface(istream& is, ostream& os);
    void create_ui(FrontEnd *frontend);
    void create_ui_test(FrontEnd *frontend, string auth_input, string post_input);
    void println(string str);
    void run();
    
private:
    FrontEnd *frontend;
    istream& is;
    ostream& os;

    static string parse_instruction(string command);
    bool query(string command);
    void post();
    void search(string command);
    void recommend();
};