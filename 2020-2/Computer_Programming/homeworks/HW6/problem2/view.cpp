#include <fstream>
#include <sstream>
#include "view.h"

/* View */
View::View(istream &is, ostream &os): is(is), os(os), is_test(false) { }

string View::get_user_input(string prompt) {
    string next_line;

    print(prompt);
    getline(is, next_line);

    if (is_test) {
        println(next_line);
    }
    return next_line;
}

string View::get_output() {
    ostringstream ss;
    ss << os.rdbuf();
    return ss.str();
}

void View::println(string str) {
    os << str << endl;
}

void View::print(string str) {
    os << str;
}
/* View */


/* PostView */
PostView::PostView(istream &is, ostream &os): View(is, os) { }

pair<string, string> PostView::get_post(string prompt) {
    string title;
    string content;
    string entire_content = "";
    println("-----------------------------------");
    println(prompt);
    
    print("* Title=");
    getline(is, title);

    if (is_test) {
        println(title);
    }

    println("* Content");
    print(">");
    getline(is, content);

    if (is_test) {
        println(content);
    }

    entire_content += content + "\n";
    while (content.size() != 0) {
        print(">");
        getline(is, content);

        if (is_test) {
            println(content);
        }
        entire_content += content + "\n";
    }
    return pair<string, string>(title, entire_content);
}
/* PostView */


/* AuthView */
AuthView::AuthView(istream &is, ostream &os): View(is, os) { }

string AuthView::get_user_input(string prompt) {
    string id;
    string pw;

    print(prompt);

    print("id=");
    getline(is, id);

    if (is_test) {
        println(id);
    }
    
    print("passwd=");
    getline(is, pw);

    if (is_test) {
        println(pw);
    }

    return id + "\n" + pw;
}
/* AuthView */