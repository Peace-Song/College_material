#include "user_interface.h"

#ifndef PROBLEM2_APP_H
#define PROBLEM2_APP_H

class App {
public:
    App(std::istream& is, std::ostream& os);
    void run();
private:
    std::istream& is;
    std::ostream& os;
    static UserInterface *ui;
    static FrontEnd *fe;
    static BackEnd *be;
};

#endif //PROBLEM2_APP_H
