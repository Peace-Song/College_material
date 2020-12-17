#include <iostream>
#include <iomanip>
#include <algorithm>
#include "restaurant_app.h"


void RestaurantApp::rate(string target, int rate) {
    shared_ptr<vector<int>> ratings = find_restaurant(target);
    if (!ratings) {
        vector<int> new_ratings;
        new_ratings.push_back(rate);
        restaurants.insert(std::pair<string, shared_ptr<vector<int>>>(target, std::make_shared<vector<int>>(new_ratings)));

        return;
    }
    ratings->push_back(rate);
    std::sort(ratings->begin(), ratings->end());
}


void RestaurantApp::list() {
    auto it = restaurants.begin();
    
    while (it != restaurants.end()) {
        std::cout << it->first << " ";
        it++;
    }
    std::cout << std::endl;
}


void RestaurantApp::show(string target) {
    shared_ptr<vector<int>> ratings = find_restaurant(target);
    if (!ratings) {
        std::cout << target + " does not exist." << std::endl;
        return;
    }
    
    for (int rating : *ratings) {
        std::cout << rating << " ";
    }
    std::cout << std::endl;
}


void RestaurantApp::ave(string target) {
    shared_ptr<vector<int>> ratings = find_restaurant(target);
    if (!ratings) return;
    if (ratings->size() == 0) {
        std::cout << "0" << std::endl;
        return;
    }

    double rate_sum = 0;
    for (int rating : *ratings) {
        rate_sum += rating;
    }

    std::cout << std::fixed << std::setprecision(2) << double(rate_sum) / ratings->size() << std::endl;
}


void RestaurantApp::med(string target) {
    shared_ptr<vector<int>> ratings = find_restaurant(target);
    if (!ratings) return;
    if (ratings->size() == 0) {
        std::cout << "0" << std::endl;
        return;
    }

    double med;
    if (ratings->size() % 2 == 0) {
        med = (ratings->at(ratings->size() / 2) + ratings->at(ratings->size() / 2 - 1)) / 2;
    } else {
        med = ratings->at(ratings->size() / 2);
    }

    std::cout << std::fixed << std::setprecision(2) << med << std::endl;
}


void RestaurantApp::min(string target) {
    shared_ptr<vector<int>> ratings = find_restaurant(target);
    if (!ratings) return;
    if (ratings->size() == 0) {
        std::cout << "0" << std::endl;
        return;
    }

    std::cout << ratings->at(0) << std::endl;
}


void RestaurantApp::max(string target) {
    shared_ptr<vector<int>> ratings = find_restaurant(target);
    if (!ratings) return;
    if (ratings->size() == 0) {
        std::cout << "0" << std::endl;
        return;
    }

    std::cout << ratings->at(ratings->size() - 1) << std::endl;
}


void RestaurantApp::del(string target, int rate) {
    shared_ptr<vector<int>> ratings = find_restaurant(target);
    if (!ratings) return;

    auto it = std::remove(ratings->begin(), ratings->end(), rate);
    ratings->erase(it, ratings->end());
}


void RestaurantApp::cheat(string target, int rate) {
    auto ratings = find_restaurant(target);
    if (!ratings) return;

    auto it = std::lower_bound(ratings->begin(), ratings->end(), rate);
    ratings->erase(ratings->begin(), it);
}


shared_ptr<vector<int>> RestaurantApp::find_restaurant(string target) {
    auto it = restaurants.find(target);
    if (it == restaurants.end()) {
        return nullptr;
    }
    return restaurants[target];
}
