#include <iostream>
#include "player.h"

Player::~Player() {
    for (int i = 0; i < num_monsters; i++) {
        delete monsters[i];
    }
}

int Player::get_num_monsters() const {
    return num_monsters;
}

int Player::get_total_hp() const {
    int total_hp = 0;
    for (int i = 0; i < num_monsters; i++) {
        total_hp += monsters[i]->get_hp();
    }
    return total_hp;
}

void Player::add_monster(MonsterType monster_type) {
    if (num_monsters == MAX_NUM_MONSTERS) {
        std::cerr << "Cannot add more monsters!" << std::endl;
        return;
    }
    switch (monster_type) {
        case waterMon:
            monsters[num_monsters++] = new WaterMon;
            break;
        case fireMon:
            monsters[num_monsters++] = new FireMon;
            break;
        case grassMon:
            monsters[num_monsters++] = new GrassMon;
            break;
        default:
            std::cerr << "Wrong monster_type! : " << monster_type << std::endl;
    }
}

void Player::delete_monster(Monster *monster) {
    for (int i = 0; i < num_monsters; i++) {
        if (monsters[i] == monster) {
            monsters[i] = monsters[--num_monsters];
            delete monster;
            return;
        }
    }
}

Monster *Player::select_monster() const {
    int index = (int) (num_monsters * std::rand() / RAND_MAX);
    return monsters[index];
}
