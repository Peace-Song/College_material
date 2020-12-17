#ifndef LAB11_PLAYER_H
#define LAB11_PLAYER_H

#include "monster.h"

class Player {
private:
    static const int MAX_NUM_MONSTERS = 6;
    Monster *monsters[MAX_NUM_MONSTERS] = {};
    int num_monsters = 0;
public:
    ~Player();
    int get_num_monsters() const;
    int get_total_hp() const;

    void add_monster(MonsterType monster_type);
    void delete_monster(Monster *monster);
    Monster *select_monster() const;
};

#endif //LAB11_PLAYER_H
