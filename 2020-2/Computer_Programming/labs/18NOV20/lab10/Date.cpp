#include <iostream>
#include "Date.h"

Month::Month(int m): m(m) {}
std::ostream& operator <<(std::ostream& os, const Month& month) {
    return os << month.m;
}


Date::Date(): y(0), m(0), d('d') {}
Date::Date(int y, Month m, char d): y(y), m(m), d(d) {}

char Date::day() const {
    return d;
}

Month Date::month() const {
    return m;
}

int Date::year() const {
    return y;
}

std::ostream& operator <<(std::ostream& os, const Date& date) {
    return os << date.y << "-" << date.m << "-" << date.d;
}