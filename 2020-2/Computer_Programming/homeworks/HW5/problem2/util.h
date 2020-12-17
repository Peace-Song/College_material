#include <set>
#include <vector>
#include <map>

enum fight_option {
    FIGHT = 0,
    NOT_FIGHT = 1
};

const std::string MAXIMIZE_GAIN = "Maximize-Gain";
const std::string MINIMIZE_LOSS = "Minimize-Loss";
const std::string MINIMIZE_REGRET = "Minimize-Regret";


int choose_number_with_type(std::string type, std::multiset<int> my_numbers, std::multiset<int> enemy_numbers);
int get_bestcase_outcome_with_exception(int exception, std::multiset<int> my_numbers, std::multiset<int> enemy_numbers);
fight_option decide_fight(int me, int enemy);

std::pair<int, int> _number_fight(int a, int b);
std::pair<int, int> _number_vs_number(int a, int b);
std::pair<std::multiset<int>, std::multiset<int>> _player_battle(
    std::string type_a, std::multiset<int> a, std::string type_b, std::multiset<int> b
);
std::pair<std::multiset<int>, std::multiset<int>> _player_vs_player(
    std::string type_a, std::multiset<int> a, std::string type_b, std::multiset<int> b
);
int _tournament(std::vector<std::pair<std::string, std::multiset<int>>> players);
int _steady_winner(std::vector<std::pair<std::string, std::multiset<int>>> players);


static const int PRIME_TEST_LIMIT = 999999;
static int sieve_of_eratosthenes[PRIME_TEST_LIMIT + 1];
static bool sieve_calculated = false;

static void make_sieve();
static bool is_prime(int num);
std::multiset<int> factorize(int num);