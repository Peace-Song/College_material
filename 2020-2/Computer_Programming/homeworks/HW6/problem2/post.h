#include <string>
#include <ctime>

using namespace std;

class Post {
public:
    Post(string title, string content);
    Post(int id, time_t post_time, string title, string content);
    string get_summary();
    string to_string();
    int get_id();
    void set_id(int id);
    string get_date();
    time_t get_time();
    void set_time(time_t new_time);
    string get_title();
    string get_content();

private:
    int id;
    time_t post_time;
    string title;
    string content;

};

