#include "config.h"

using namespace std;

class BackEnd {
public:
    BackEnd();
    bool auth(string id, string pw) ;
    // void post(string id, string title, string content, ctime time);

private:
    static int post_num;
};