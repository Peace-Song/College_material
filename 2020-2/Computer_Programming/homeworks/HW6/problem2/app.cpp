#include <iostream>
#include "app.h"

App::App(std::istream& is, std::ostream& os): is(is), os(os) {
    // TODO
}

void App::run() {
    // TODO
    ui = new UserInterface(is, os);
    be = new BackEnd();
    fe = new FrontEnd(ui, be);

    ui->create_ui(fe);
    ui->run();
}