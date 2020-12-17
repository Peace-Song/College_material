#ifndef DATE_H
#define DATE_H

#include <iostream>

class Month {
public:
    Month(int m);

    friend std::ostream& operator <<(std::ostream& os, const Month& month);

    int m;
};

class Date {
public:
    Date();
    Date(int y, Month m, char d);

    char day() const;
    Month month() const;
    int year() const;

    friend std::ostream& operator <<(std::ostream& os, const Date& date);
private:
    int y;  Month m;  char d;
};

#endif // !