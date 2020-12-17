#ifndef PROBLEM1_SHOPPING_DB_H
#define PROBLEM1_SHOPPING_DB_H

#include <string>
#include <vector>
#include "user.h"
#include "product.h"

class ShoppingDB {
public:
    ShoppingDB();
    /* admin_ui */
    void add_product(Product *product);
    Product *find_product(std::string name);
    std::vector<Product*> fetch_all_products();

    /* client_ui */
    void add_user(User *user);
    User *find_user(std::string name);
    std::vector<User*> fetch_all_users();
private:
    std::vector<User*> users;
    std::vector<Product*> products;
};

#endif //PROBLEM1_SHOPPING_DB_H
