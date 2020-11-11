#include <iostream>

using namespace std;

int main() {
    char str[100];

    cin >> str;

    printf("\t[%s]\n", str);
    printf("\t[%10s]\n", str);
    printf("\t[%-10s]\n", str);

    return 0;
}