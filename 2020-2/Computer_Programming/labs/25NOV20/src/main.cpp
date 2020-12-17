#include <iostream>
#include <ctime>
#include "player.h"

void round(Player &player1, Player &player2);

int main() {
    std::srand(std::time(nullptr));

    Player a, b;
    a.add_monster(fireMon);
    a.add_monster(fireMon);
    a.add_monster(waterMon);
    b.add_monster(waterMon);
    b.add_monster(grassMon);
    b.add_monster(grassMon);

    for (int i = 1;; i++) {
        round(a, b);
        std::cout << "Round " << i << ": " << a.get_total_hp() << " " << b.get_total_hp() << std::endl;
        if (b.get_num_monsters() == 0) {
            std::cout << "Player a won the game!" << std::endl;
            break;
        } else if (a.get_num_monsters() == 0) {
            std::cout << "Player b won the game!" << std::endl;
            break;
        }
    }
    return 0;
}

void round(Player &player1, Player &player2) {
    Monster *monster1 = player1.select_monster();
    Monster *monster2 = player2.select_monster();

    monster1->attack(monster2);
    monster2->attack(monster1);

    if (monster1->get_hp() <= 0) {
        player1.delete_monster(monster1);
    }

    if (monster2->get_hp() <= 0) {
        player2.delete_monster(monster2);
    }
}
