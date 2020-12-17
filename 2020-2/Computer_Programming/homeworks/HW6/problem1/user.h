#ifndef PROBLEM1_USER_H
#define PROBLEM1_USER_H

#include <string>
#include <vector>
#include <algorithm>
#include <utility>
#include "product.h"

#include <iostream>

class User {
public:
    User(std::string name, std::string password);
    virtual ~User() {};
    bool verify_password(std::string password);
    virtual int get_corrected_price(int price) = 0;
    void add_to_cart(Product *product);
    std::vector<Product*> fetch_all_products_in_cart();
    void clear_cart();
    void buy(Product *product);
    virtual std::vector<Product*> recommend_products(std::vector<User*> users) = 0;
    std::vector<Product*> get_buy_history();
    const std::string name;
private:
    std::string password;
    std::vector<Product*> cart;
protected:
    std::vector<Product*> buy_history;
};

class NormalUser : public User {
public:
    NormalUser(std::string name, std::string password);
    int get_corrected_price(int price) override;
    std::vector<Product*> recommend_products(std::vector<User*> users) override;
};

class PremiumUser : public User {
public:
    PremiumUser(std::string name, std::string password);
    int get_corrected_price(int price) override;
    std::vector<Product*> recommend_products(std::vector<User*> users) override;
};

#endif //PROBLEM1_USER_H
