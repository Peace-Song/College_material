#include "post.h"

/* citation: 
 * http://www.martinbroadhurst.com/how-to-trim-a-stdstring.html
 */
std::string& ltrim(std::string& str, const std::string& chars = "\t\n\v\f\r ")
{
    str.erase(0, str.find_first_not_of(chars));
    return str;
}
 
std::string& rtrim(std::string& str, const std::string& chars = "\t\n\v\f\r ")
{
    str.erase(str.find_last_not_of(chars) + 1);
    return str;
}
 
std::string& trim(std::string& str, const std::string& chars = "\t\n\v\f\r ")
{
    return ltrim(rtrim(str, chars), chars);
}


Post::Post(string title, string content): Post(-1, time(nullptr), title, content) { }

Post::Post(int id, time_t post_time, string title, string content): id(id), post_time(post_time), title(title) {
    this->content = trim(content);
}

string Post::get_summary() {
    return "id: " + std::to_string(id) + ", created at: " + get_date() + ", title: " + title;
}

string Post::to_string() {
    return string() +
           "-----------------------------------\n" +
           "id: " + std::to_string(id) + "\n" +
           "created at: " + get_date() + "\n" +
           "title: " + title + "\n" +
           "content: " + content;
}

int Post::get_id() {
    return id;
}

void Post::set_id(int id) {
    this->id = id;
}

string Post::get_date() {
    struct tm* time_info = localtime(&post_time);

    char formatted_time[20];
    strftime(formatted_time, 20, "%Y/%m/%d %T", time_info);
    return formatted_time;
}

void Post::set_time(time_t new_time) {
    this->post_time = new_time;
}

time_t Post::get_time() {
    return this->post_time;
}

string Post::get_title() {
    return title;
}

string Post::get_content() {
    return content;
}
