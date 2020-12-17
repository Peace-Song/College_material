#include <iostream>
#include <set>
#include "util.h"

int sum_numbers(std::multiset<int> numbers) {
    int sum = 0;
    for (int number : numbers) sum += number;
    return sum;
}

int choose_number_with_type(std::string type, std::multiset<int> my_numbers, std::multiset<int> enemy_numbers) {
    if (my_numbers.size() == 1) {
        for (int result : my_numbers) {
            return result;
        }
    }

    if (type.compare(MAXIMIZE_GAIN) == 0) {
        int curr_max_delta = INT32_MIN;
        int curr_max_num = 0;
        int delta;

        for (int my_number : my_numbers) {
            for (int enemy_number : enemy_numbers) {
                std::pair<int, int> fight_result = _number_vs_number(my_number, enemy_number);
                delta = fight_result.first - my_number;

                // TODO: update if same?
                if (delta > curr_max_delta) {
                    curr_max_delta = delta;
                    curr_max_num = my_number;
                }
            }
        }

        return curr_max_num;
    }

    else if (type.compare(MINIMIZE_LOSS) == 0) {
        int curr_max_delta = INT32_MIN;
        int curr_max_num = 0;
        int delta;

        for (int my_number : my_numbers) {
            int worst_delta = INT32_MAX;

            for (int enemy_number : enemy_numbers) {
                std::pair<int, int> fight_result = _number_vs_number(my_number, enemy_number);
                delta = fight_result.first - my_number;

                if (delta < worst_delta) worst_delta = delta;
            }

            // TODO: update if same?
            if (worst_delta > curr_max_delta) {
                curr_max_delta = worst_delta;
                curr_max_num = my_number;
            }
        }

        return curr_max_num;
    }

    else if (type.compare(MINIMIZE_REGRET) == 0) {
        int curr_min_regret = INT32_MAX;
        int curr_min_num = 0;
        int delta;
        int regret;

        for (int my_number : my_numbers) {
            int worst_delta = INT32_MAX;
            int best_if_choose_other = get_bestcase_outcome_with_exception(my_number, my_numbers, enemy_numbers);

            for (int enemy_number : enemy_numbers) {
                std::pair<int, int> fight_result = _number_vs_number(my_number, enemy_number);
                delta = fight_result.first - my_number;

                if (delta < worst_delta) worst_delta = delta;
            }

            regret = best_if_choose_other - worst_delta;
            if (regret < curr_min_regret) {
                curr_min_regret = regret;
                curr_min_num = my_number;
            }
        }

        return curr_min_num;
    }

    // must not reach here
    else {
        return 0;
    }
}

int get_bestcase_outcome_with_exception(int exception, std::multiset<int> my_numbers, std::multiset<int> enemy_numbers) {
        int curr_max_delta = INT32_MIN;
        int curr_max_num = 0;
        int delta;

        for (int my_number : my_numbers) {
            if (my_number == exception) continue;

            for (int enemy_number : enemy_numbers) {
                std::pair<int, int> fight_result = _number_vs_number(my_number, enemy_number);
                delta = my_number - fight_result.first;

                // TODO: update if same?
                if (delta > curr_max_delta) {
                    curr_max_delta = delta;
                    curr_max_num = my_number;
                }
            }
        }

        return curr_max_num;
}

fight_option decide_fight(int me, int enemy) {
    fight_option decision_enemy_fight;
    fight_option decision_enemy_not_fight;
    std::pair<int, int> result_if_fight = _number_fight(me, enemy);
    int _a = result_if_fight.first;
    int _b = result_if_fight.second;
    
    // assume enemy chooses FIGHT
    int me_fight_enemy_fight = _a;
    int me_not_fight_enemy_fight = me;

    // calculate damage
    int damage = me - _a;
    std::multiset<int> factors_me = factorize(me);
    
    if (factors_me.find(7) != factors_me.end()) {
        me_not_fight_enemy_fight = me_not_fight_enemy_fight - damage / 2;
        me_not_fight_enemy_fight = me_not_fight_enemy_fight < 1 ? 1 : me_not_fight_enemy_fight;
    } else {
        me_not_fight_enemy_fight = me - damage;
    }

    // decision
    decision_enemy_fight = me_fight_enemy_fight >= me_not_fight_enemy_fight ? FIGHT : NOT_FIGHT;

    // assume enemy chooses NOT_FIGHT
    int me_fight_enemy_not_fight = me;
    int me_not_fight_enemy_not_fight = me;

    // calculate damage
    damage = enemy - _b;
    std::multiset<int> factors_enemy = factorize(enemy);

    if (factors_enemy.find(7) != factors_enemy.end()) {
        me_fight_enemy_not_fight = me_fight_enemy_not_fight - damage / 2;
        me_fight_enemy_not_fight = me_fight_enemy_not_fight < 1 ? 1 : me_fight_enemy_not_fight;
    } else {
        me_fight_enemy_not_fight = me;
    }

    // decision
    decision_enemy_not_fight = me_fight_enemy_not_fight >= me_not_fight_enemy_not_fight ? FIGHT : NOT_FIGHT;
    
    // std::cout << "[DEBUG] " << me << ": decision enemy fight: " << decision_enemy_fight << " decision enemy not fight: " << decision_enemy_not_fight << std::endl;

    // final decision
    if (decision_enemy_fight == decision_enemy_not_fight) return decision_enemy_fight;
    else {
        if (me < enemy) return FIGHT;
        else return NOT_FIGHT;
    }
}


std::pair<int, int> _number_fight(int a, int b) {
    std::multiset<int> factors_a = factorize(a);
    std::multiset<int> factors_b = factorize(b);
    std::multiset<int> intersection;
    int product = 1;

    for (int elem : factors_a) {
        // if factors_b has the factor and not yet added to intersection
        if (factors_b.find(elem) != factors_b.end() && intersection.find(elem) == intersection.end()) {
            factors_b.erase(elem);
            intersection.insert(elem);
        }
    }

    for (int elem : intersection) {
        product *= elem;
    }
    
    return std::pair<int, int>(a / product, b / product);
}

std::pair<int, int> _number_vs_number(int a, int b) {
    fight_option decision_a = decide_fight(a, b);
    fight_option decision_b = decide_fight(b, a);

    if ((decision_a == decision_b) && (decision_b == FIGHT)) {
        return _number_fight(a, b);
    }
    else if(decision_a == decision_b) {
        return std::pair<int, int>(a, b);
    }
    else if (decision_a == FIGHT) {
        std::pair<int, int> result_if_fight = _number_fight(a, b);
        int _a = result_if_fight.first;
        int _b = result_if_fight.second;

        int damage = b - _b;
        std::multiset<int> factors_b = factorize(b);
        if (factors_b.find(7) != factors_b.end()) {
            a = a - damage / 2;
            b = b - damage / 2;

            a = a < 1 ? 1 : a;
            b = b < 1 ? 1 : b;
        }
        else {
            b = b - damage;
        }

        return std::pair<int, int>(a, b);
    }
    else if (decision_b == FIGHT) {
        std::pair<int, int> result_if_fight = _number_fight(a, b);
        int _a = result_if_fight.first;
        int _b = result_if_fight.second;

        int damage = a - _a;
        std::multiset<int> factors_a = factorize(a);
        if (factors_a.find(7) != factors_a.end()) {
            a = a - damage / 2;
            b = b - damage / 2;

            a = a < 1 ? 1 : a;
            b = b < 1 ? 1 : b;
        }
        else {
            a = a - damage;
        }

        return std::pair<int, int>(a, b);
    }

    // must not reach here
    return std::pair<int, int>(1, 1);
}

std::pair<std::multiset<int>, std::multiset<int>> _player_battle(
    std::string type_a, std::multiset<int> a, std::string type_b, std::multiset<int> b
) {
    int number_a = choose_number_with_type(type_a, a, b);
    int number_b = choose_number_with_type(type_b, b, a);

    std::pair<int, int> fight_result = _number_vs_number(number_a, number_b);
    int number_a_after = fight_result.first;
    int number_b_after = fight_result.second;

    a.erase(number_a);
    a.insert(number_a_after);
    b.erase(number_b);
    b.insert(number_b_after);

    return std::pair<std::multiset<int>, std::multiset<int>>(a, b);
}

std::pair<std::multiset<int>, std::multiset<int>> _player_vs_player(
    std::string type_a, std::multiset<int> a, std::string type_b, std::multiset<int> b
) {
    int num_state_not_changed = 0;

    while ((num_state_not_changed != a.size()) && (num_state_not_changed != b.size())) {
        int number_a = choose_number_with_type(type_a, a, b);
        int number_b = choose_number_with_type(type_b, b, a);

        std::pair<int, int> fight_result = _number_vs_number(number_a, number_b);
        int number_a_after = fight_result.first;
        int number_b_after = fight_result.second;

        if (number_a == number_a_after && number_b == number_b_after) {
            num_state_not_changed++;
        }
        else {
            a.erase(number_a);
            a.insert(number_a_after);
            b.erase(number_b);
            b.insert(number_b_after);

            num_state_not_changed = 0;
        }
    }

    return std::pair<std::multiset<int>, std::multiset<int>>(a, b);
}

int _tournament(std::vector<std::pair<std::string, std::multiset<int>>> players) {
    // construct first list
    std::vector<std::pair<std::string, std::multiset<int>>> players_to_fight;
    for (std::pair<std::string, std::multiset<int>> player : players) {
        std::string type = player.first;
        std::multiset<int> numbers = std::multiset<int>(player.second); // copy
        players_to_fight.push_back(std::pair<std::string, std::multiset<int>>(type, std::multiset<int>(numbers)));
    }

    while (true) {
        std::vector<std::pair<std::string, std::multiset<int>>> players_to_fight_expandable;
        for (std::pair<std::string, std::multiset<int>> player : players_to_fight) {
            std::string type = player.first;
            std::multiset<int> numbers = std::multiset<int>(player.second); // copy
            players_to_fight_expandable.push_back(std::pair<std::string, std::multiset<int>>(type, std::multiset<int>(numbers)));
        }

        std::vector<std::pair<std::string, std::multiset<int>>> players_to_fight_next;

        for (int idx = 0; idx < players_to_fight_expandable.size(); idx += 2) {
            if (idx + 1 == players_to_fight_expandable.size()) {
                players_to_fight_next.push_back(players_to_fight.at(idx));
                break;
            }

            std::pair<std::string, std::multiset<int>> player_one = players_to_fight_expandable.at(idx);
            std::pair<std::string, std::multiset<int>> player_two = players_to_fight_expandable.at(idx + 1);

            std::pair<std::multiset<int>, std::multiset<int>> result_numbers = 
                _player_vs_player(player_one.first, player_one.second, player_two.first, player_two.second);

            int player_one_sum = sum_numbers(result_numbers.first);
            int player_two_sum = sum_numbers(result_numbers.second);

            if (player_one_sum > player_two_sum) {
                players_to_fight_next.push_back(players_to_fight.at(idx));
            }
            else if (player_one_sum < player_two_sum) {
                players_to_fight_next.push_back(players_to_fight.at(idx + 1));
            }
            else {
                players_to_fight_next.push_back(players_to_fight.at(idx));
            }
        }

        players_to_fight = players_to_fight_next;

        if (players_to_fight_next.size() == 1) {
            for (int idx = 0; idx < players.size(); idx++) {
                if (players.at(idx) == players_to_fight_next.at(0)) {
                    return idx;
                }
            }
            return -1;
        }
    }
}

int _steady_winner(std::vector<std::pair<std::string, std::multiset<int>>> players) {
    std::map<std::pair<std::string, std::multiset<int>>, int> player_to_win_num;

    // shallow copy for keeping track of indices
    for (std::pair<std::string, std::multiset<int>> player : players) {
        player_to_win_num[player] = 0;
    }

    std::vector<std::pair<std::string, std::multiset<int>>> players_rotating = players;
    std::vector<std::pair<std::string, std::multiset<int>>> players_rotating_next;

    for (int cnt = 0; cnt < players.size(); cnt++) {
        int winner_idx = _tournament(players_rotating);
        std::pair<std::string, std::multiset<int>> winner = players_rotating.at(winner_idx);
        player_to_win_num[winner] += 1;

        for (int idx = 1; idx < players_rotating.size(); idx++) {
            players_rotating_next.push_back(players_rotating.at(idx));
        }
        players_rotating_next.push_back(players_rotating.at(0));
    }

    int max_win_num = 0;
    std::vector<std::pair<std::string, std::multiset<int>>> max_winners;

    for (std::map<std::pair<std::string, std::multiset<int>>, int>::iterator iter = player_to_win_num.begin(); iter != player_to_win_num.end(); ++iter) {
        int win_count = iter->second;
        if (win_count >= max_win_num) {
            max_win_num = win_count;
        }
    }

    for (std::map<std::pair<std::string, std::multiset<int>>, int>::iterator iter = player_to_win_num.begin(); iter != player_to_win_num.end(); ++iter) {
        std::pair<std::string, std::multiset<int>> player = iter->first;
        int win_count = iter->second;

        if (win_count == max_win_num) {
            max_winners.push_back(player);
        }
    }

    int min_idx = players.size();
    for (std::pair<std::string, std::multiset<int>> player : max_winners) {
        for (int idx = 0; idx < players.size(); idx++) {
            if (player == players.at(idx)) {
                if (idx < min_idx) {
                    min_idx = idx;
                    break;
                }
            }
        }
    }

    return min_idx;
}

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


void make_sieve() {
    sieve_of_eratosthenes[0] = -1;
    sieve_of_eratosthenes[1] = -1;
    for(int i=2; i<=PRIME_TEST_LIMIT; i++) {
        sieve_of_eratosthenes[i] = i;
    }
    for(int i=2; i*i<=PRIME_TEST_LIMIT; i++) {
        if(sieve_of_eratosthenes[i] == i) {
            for(int j=i*i; j<=PRIME_TEST_LIMIT; j+=i) {
                sieve_of_eratosthenes[j] = i;
            }
        }
    }
    sieve_calculated = true;
}

bool is_prime(int num) {
    if (!sieve_calculated) {
        make_sieve();
    }
    return sieve_of_eratosthenes[num] == num;
}

std::multiset<int> factorize(int num) {
    if (!sieve_calculated) {
        make_sieve();
    }
    std::multiset<int> result;
    while(num > 1) {
        result.insert(sieve_of_eratosthenes[num]);
        num /= sieve_of_eratosthenes[num];
    }
    if(result.empty()) {
        result.insert(1);
    }
    return result;
}

/* =======END OF PRIME-RELATED HELPERS======= */