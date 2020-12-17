#include <string>
#include <ctime>
#include <vector>
#include "config.h"
#include "post.h"

using namespace std;

class BackEnd {
public:
    BackEnd();
    bool auth(string id, string pw) ;
    void post(string id, string title, string content, time_t curr_time);
    vector<Post*> search(vector<string> keywords);
    vector<Post*> get_friends_posts(string id);

private:
    static int post_num;

    int get_post_num();
    vector<string> split(string str, string delim);
};