#include <iostream>
#include <string>
#include <utility>
#include <set>
#include <vector>
#include <tuple>
#include "util.h"

/* =======START OF PRIME-RELATED HELPERS======= */
/*
 * The code snippet below AS A WHOLE does the primality
 * test and integer factorization. Feel free to move the
 * code to somewhere more appropriate to get your codes
 * more structured.
 *
 * You don't have to understand the implementation of it.
 * But if you're curious, refer to the sieve of Eratosthenes
 *
 * If you want to just use it, use the following 2 functions.
 *
 * 1) bool is_prime(int num):
 *     * `num` should satisfy 1 <= num <= 999999
 *     - returns true if `num` is a prime number
 *     - returns false otherwise (1 is not a prime number)
 *
 * 2) std::multiset<int> factorize(int num):
 *     * `num` should satisfy 1 <= num <= 999999
 *     - returns the result of factorization of `num`
 *         ex ) num = 24 --> result = { 2, 2, 2, 3 }
 *     - if `num` is 1, it returns { 1 }
 */

// const int PRIME_TEST_LIMIT = 999999;
// int sieve_of_eratosthenes[PRIME_TEST_LIMIT + 1];
// bool sieve_calculated = false;

// void make_sieve() {
//     sieve_of_eratosthenes[0] = -1;
//     sieve_of_eratosthenes[1] = -1;
//     for(int i=2; i<=PRIME_TEST_LIMIT; i++) {
//         sieve_of_eratosthenes[i] = i;
//     }
//     for(int i=2; i*i<=PRIME_TEST_LIMIT; i++) {
//         if(sieve_of_eratosthenes[i] == i) {
//             for(int j=i*i; j<=PRIME_TEST_LIMIT; j+=i) {
//                 sieve_of_eratosthenes[j] = i;
//             }
//         }
//     }
//     sieve_calculated = true;
// }

// bool is_prime(int num) {
//     if (!sieve_calculated) {
//         make_sieve();
//     }
//     return sieve_of_eratosthenes[num] == num;
// }

// std::multiset<int> factorize(int num) {
//     if (!sieve_calculated) {
//         make_sieve();
//     }
//     std::multiset<int> result;
//     while(num > 1) {
//         result.insert(sieve_of_eratosthenes[num]);
//         num /= sieve_of_eratosthenes[num];
//     }
//     if(result.empty()) {
//         result.insert(1);
//     }
//     return result;
// }

/* =======END OF PRIME-RELATED HELPERS======= */

/* =======START OF std::string LITERALS======= */
/* Use this code snippet if you want */

// const std::string MAXIMIZE_GAIN = "Maximize-Gain";
// const std::string MINIMIZE_LOSS = "Minimize-Loss";
// const std::string MINIMIZE_REGRET = "Minimize-Regret";

/* =======END OF std::string LITERALS======= */


/* =======START OF TODOs======= */

std::pair<int, int> number_fight(int a, int b) {
    // TODO 2-1
    return _number_fight(a, b);
}

std::pair<int, int> number_vs_number(int a, int b) {
    // TODO 2-2
    return _number_vs_number(a, b);
}

std::pair<std::multiset<int>, std::multiset<int>> player_battle(
    std::string type_a, std::multiset<int> a, std::string type_b, std::multiset<int> b
) {
    // TODO 2-3
    return _player_battle(type_a, a, type_b, b);
}

std::pair<std::multiset<int>, std::multiset<int>> player_vs_player(
    std::string type_a, std::multiset<int> a, std::string type_b, std::multiset<int> b
) {
    // TODO 2-4
    return _player_vs_player(type_a, a, type_b, b);
}

int tournament(std::vector<std::pair<std::string, std::multiset<int>>> players) {
    // TODO 2-5
    return _tournament(players);
}

int steady_winner(std::vector<std::pair<std::string, std::multiset<int>>> players) {
    // TODO 2-6
    return _steady_winner(players);
}

/* =======END OF TODOs======= */

/* =======START OF THE MAIN CODE======= */
/* Please do not modify the code below */

typedef std::pair<std::string, std::multiset<int>> player;

player scan_player() {
    std::multiset<int> numbers;
    std::string player_type; int size;
    std::cin >> player_type >> size;
    for(int i=0;i<size;i++) {
        int t; std::cin >> t; numbers.insert(t);
    }
    return make_pair(player_type, numbers);
}

void print_multiset(const std::multiset<int>& m) {
    for(int number : m) {
        std::cout << number << " ";
    }
    std::cout << std::endl;
}

int main() {
    int question_number; std::cin >> question_number;
    if (question_number == 1) {
        int a, b; std::cin >> a >> b;
        std::tie(a, b) = number_fight(a, b);
        std::cout << a << " " << b << std::endl;
    } else if (question_number == 2) {
        int a, b; std::cin >> a >> b;
        std::tie(a, b) = number_vs_number(a, b);
        std::cout << a << " " << b << std::endl;
    } else if (question_number == 3 || question_number == 4) {
        auto a = scan_player();
        auto b = scan_player();
        std::multiset<int> a_, b_;
        if (question_number == 3) {
            tie(a_, b_) = player_battle(
                a.first, a.second, b.first, b.second
            );
        } else {
            tie(a_, b_) = player_vs_player(
                a.first, a.second, b.first, b.second
            );
        }
        print_multiset(a_);
        print_multiset(b_);
    } else if (question_number == 5 || question_number == 6) {
        int num_players; std::cin >> num_players;
        std::vector<player> players;
        for(int i=0;i<num_players;i++) {
            players.push_back(scan_player());
        }
        int winner_id;
        if (question_number == 5) {
            winner_id = tournament(players);
        } else {
            winner_id = steady_winner(players);
        }
        std::cout << winner_id << std::endl;
    }
    return 0;
}
/* =======END OF MAIN CODE======= */