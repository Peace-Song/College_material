#include <string>
#include <iostream>

using namespace std;

class View {
public:
    bool is_test;
    istream& is;
    ostream& os;

    View(istream &is, ostream &os);
    string get_user_input(string prompt);
    string get_output();
    void println(string str);
    void print(string str);

private:

};

class PostView : public View {
public:
    PostView(istream &is, ostream &os);
    pair<string, string> get_post(string prompt);

private:

};

class AuthView : public View {
public:
    AuthView(istream &is, ostream &os);
    string get_user_input(string prompt);
private:

};