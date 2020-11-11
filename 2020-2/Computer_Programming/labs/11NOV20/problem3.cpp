#include <iostream>

using namespace std;

int main() {
    int a, b;
    float c;

    cin >> a >> b >> c;

    printf("%c %d %7d %07d %x %o %#x %#o\n", a, b, b, b, b, b, b, b);
    printf(".2f %E\n", c, c);
}