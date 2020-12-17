#include "user.h"

User::User(std::string name, std::string password): name(name), password(password) {

}

bool User::verify_password(std::string password) {
    return (this->password == password) ? true : false;
}

void User::add_to_cart(Product *product) {
    this->cart.push_back(product);
}

std::vector<Product*> User::fetch_all_products_in_cart() {
    return this->cart;
}

void User::clear_cart() {
    this->cart.clear();
}

void User::buy(Product *product) {
    this->buy_history.push_back(product);
}

std::vector<Product*> User::get_buy_history() {
    return this->buy_history;
}

/* NormalUser */
NormalUser::NormalUser(std::string name, std::string password): User(name, password) {

}

int NormalUser::get_corrected_price(int price) {
    return price;
}

std::vector<Product*> NormalUser::recommend_products(std::vector<User*> users) {
    std::vector<Product*> result;
    int product_count = 0;
    
    for (int idx = this->buy_history.size() - 1; idx >= 0; idx--) {
        Product *product = this->buy_history.at(idx);
        
        if (std::find(result.begin(), result.end(), product) != result.end()) {
            continue;
        }
        result.push_back(product);
        product_count++;
        if (product_count == 3) {
            break;
        }
    }

    return result;
}
/* NormalUser */

/* PremiumUser */
PremiumUser::PremiumUser(std::string name, std::string password): User(name, password) {

}

int PremiumUser::get_corrected_price(int price) {
    double discounted_price = price * 0.9;
    double decimal_point = discounted_price - (int) discounted_price; 
    if (decimal_point < 0.5) price = (int) discounted_price;
    else price = (int) discounted_price + 1;

    return price;
}

std::vector<Product*> PremiumUser::recommend_products(std::vector<User*> users) {
    std::vector<Product*> result;
    std::vector<std::pair<User*, int>> similarities;
    std::vector<Product*> this_purchased_items;

    // construct this_purchased_items
    for (Product *product : this->buy_history) {
        if (std::find(this_purchased_items.begin(), this_purchased_items.end(), product) == this_purchased_items.end()) {
            this_purchased_items.push_back(product);
        }
    }

    // construct similarities
    for (int idx = 0; idx < users.size(); idx++) {
        User *user = users.at(idx);
        int count = 0;

        // construct his_purchased_items
        std::vector<Product*> his_purchased_items;
        for (Product *product : user->get_buy_history()) {
            if (std::find(his_purchased_items.begin(), his_purchased_items.end(), product) == his_purchased_items.end()) {
                his_purchased_items.push_back(product);
            }
        }

        for (Product *product : his_purchased_items) {
            if (std::find(this_purchased_items.begin(), this_purchased_items.end(), product) != this_purchased_items.end()) {
                count++;
            }
        }

        if (user == this) {
            count = -1;
        }

        similarities.push_back(std::pair<User*, int>(user, count));
    }

    // sort with similarity as key
    std::stable_sort(similarities.begin(), similarities.end(),
        [](const std::pair<User*, int> &p1, const std::pair<User*, int> &p2) {
            return p1.second > p2.second;
        }  
    );

    // construct result
    int product_count = 0;
    for (int idx = 0; idx < similarities.size() - 1; idx++) {
        User *user = similarities.at(idx).first;
        if (user->get_buy_history().size() == 0) continue;
        Product *product = user->get_buy_history().at(user->get_buy_history().size() - 1);
        
        if (std::find(result.begin(), result.end(), product) == result.end()) {
            result.push_back(product);
            product_count++;
            if (product_count == 3) {
                break;
            }
        }
    }

    return result;
}
/* PremiumUser */
