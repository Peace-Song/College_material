#include <iostream>
#include "Date.h"

// TODO : Move date class to Date.h & Date.cpp

int main() {
    Date d(2012, 11, 'f');
    std::cout << d << std::endl;
    return 0;
}