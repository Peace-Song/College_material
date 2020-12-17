#include <string>
#include <iostream>

using namespace std;

class View {
public:
    bool is_test;
    istream& is;
    ostream& os;
    istream* user_input;
    ostream* print_stream;

    View(istream &is, ostream &os);
    View(istream &is, ostream &os, string input_file);
    string get_user_input(string prompt);
    string get_output();
    void println(string str);
    void print(string str);

private:

protected:

};

class PostView : public View {
public:
    PostView(istream &is, ostream &os);
    PostView(istream &is, ostream &os, string post_input);
    pair<string, string> get_post(string prompt);

private:

};

class AuthView : public View {
public:
    AuthView(istream &is, ostream &os);
    AuthView(istream &is, ostream &os, string auth_input);
    string get_user_input(string prompt);
private:

};