#include <fstream>
#include <sstream>
#include "view.h"

/* View */
View::View(istream &is, ostream &os): is(is), os(os) {
    is_test = false;
    user_input = &cin;
    print_stream = &cout;
}

View::View(istream &is, ostream &os, string input_file): is(is), os(os) {
    is_test = true;
    user_input = new ifstream(input_file);
    print_stream = &os;
}

string View::get_user_input(string prompt) {
    string next_line;

    print(prompt);
    getline(*user_input, next_line);
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
    *print_stream << str << endl;
}

void View::print(string str) {
    *print_stream << str;
}
/* View */


/* PostView */
PostView::PostView(istream &is, ostream &os): View(is, os) { }

PostView::PostView(istream &is, ostream &os, string post_input): View(is, os, post_input) { }

pair<string, string> PostView::get_post(string prompt) {
    string title;
    string content;
    string entire_content = "";
    println("-----------------------------------");
    println(prompt);
    
    print("* Title : ");
    getline(*user_input, title);
    if (is_test) {
        println(title);
    }

    println("* Content : ");
    print("> ");
    getline(*user_input, content);
    if (is_test) {
        println(content);
    }

    entire_content += content + "\n";
    while (content.size() != 0) {
        print("> ");
        getline(*user_input, content);
        if (is_test) {
            println(content);
        }
        entire_content += content + "\n";
    }
    println("-----------------------------------");
    return pair<string, string>(title, entire_content);
}
/* PostView */


/* AuthView */
AuthView::AuthView(istream &is, ostream &os): View(is, os) { }

AuthView::AuthView(istream &is, ostream &os, string auth_input): View(is, os, auth_input) { }

string AuthView::get_user_input(string prompt) {
    string id;
    string pw;

    print(prompt);

    print("id : ");
    getline(*user_input, id);
    if (is_test) {
        println(id);
    }
    
    print("passwd : ");
    getline(*user_input, pw);
    if (is_test) {
        println(pw);
    }

    return id + "\n" + pw;
}
/* AuthView */