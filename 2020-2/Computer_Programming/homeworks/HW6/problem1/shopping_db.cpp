#include "shopping_db.h"

ShoppingDB::ShoppingDB() {

}

void ShoppingDB::add_product(Product* product) {
    this->products.push_back(product);
} 

Product *ShoppingDB::find_product(std::string name) {
    for (Product *product : this->products) {
        if (product->name == name) {
            return product;
        }
    }

    return nullptr;
}

std::vector<Product*> ShoppingDB::fetch_all_products() {
    return this->products;
}


void ShoppingDB::add_user(User *user) {
    this->users.push_back(user);
}

User *ShoppingDB::find_user(std::string name) {
    for (User *user : this->users) {
        if (user->name == name) {
            return user;
        }
    }

    return nullptr;
}

std::vector<User*> ShoppingDB::fetch_all_users() {
    return this->users;
}

