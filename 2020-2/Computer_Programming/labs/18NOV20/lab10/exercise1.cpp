#include <iostream>

class Date {
public:
   Date(int y, int m, int d)
      :y(y), m(m), d(d) {}
   int y;  
   int m;  
   int d; 

   friend std::ostream& operator <<(std::ostream& os, const Date& date) {
      return os << date.y << "-" << date.m << "-" << date.d;
   }
} ;


int main(){
 Date date(2012, 11, 18);   
 std::cout << date.y << "-" << date.m << "-" << date.d << std::endl;
 std::cout << date << std::endl;
}
