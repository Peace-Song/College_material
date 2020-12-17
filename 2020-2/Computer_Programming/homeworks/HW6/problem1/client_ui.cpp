#include <vector>
#include "client_ui.h"
#include "product.h"
#include "user.h"

ClientUI::ClientUI(ShoppingDB &db, std::ostream& os) : UI(db, os), current_user() { }

ClientUI::~ClientUI() {
    delete current_user;
}

void ClientUI::signup(std::string username, std::string password, bool premium) {
    // TODO: For problem 1-2
    User *user;
    if (premium) user = new PremiumUser(username, password);
    else user = new NormalUser(username, password);
    db.add_user(user);
    
    os << "CLIENT_UI: " << username << " is signed up." << std::endl;
}

void ClientUI::login(std::string username, std::string password) {
    // TODO: For problem 1-2
    User *user = db.find_user(username);

    if (current_user) {
        os << "CLIENT_UI: Please logout first." << std::endl;
        return;
    }
    if (user == nullptr || !user->verify_password(password)) {
        os << "CLIENT_UI: Invalid username or password." << std::endl;
        return;
    }

    current_user = user;
    os << "CLIENT_UI: " << username << " is logged in." << std::endl;
}

void ClientUI::logout() {
    // TODO: For problem 1-2
    if (current_user) {
        os << "CLIENT_UI: " << current_user->name << " is logged out." << std::endl;
        current_user = nullptr;
    } else {
        os << "CLIENT_UI: There is no logged-in user." << std::endl;
    }
}

void ClientUI::add_to_cart(std::string product_name) {
    // TODO: For problem 1-2
    Product *product = db.find_product(product_name);

    if (!current_user) {
        os << "CLIENT_UI: Please login first." << std::endl;
        return;
    }
    if (!product) {
        os << "CLIENT_UI: Invalid product name." << std::endl;
        return;
    }

    current_user->add_to_cart(product);
    os << "CLIENT_UI: " << product_name << " is added to the cart." << std::endl;
}

void ClientUI::list_cart_products() {
    // TODO: For problem 1-2.
    std::vector<Product*> cart;

    if (!current_user) {
        os << "CLIENT_UI: Please login first." << std::endl;
        return;
    }
    
    cart = current_user->fetch_all_products_in_cart();

    os << "CLIENT_UI: Cart: [";
    for (int idx = 0; idx < cart.size(); idx++) {
        Product *product = cart.at(idx);
        
        os << "(" << product->name << ", " << current_user->get_corrected_price(product->price) << (idx < cart.size() - 1 ? "), " : ")");
    }
    os << "]" << std::endl;
}

void ClientUI::buy_all_in_cart() {
    // TODO: For problem 1-2
    std::vector<Product*> cart;

    if (!current_user) {
        os << "CLIENT_UI: Please login first." << std::endl;
        return;
    }
    
    cart = current_user->fetch_all_products_in_cart();

    int total_price = 0;
    for (Product *product : cart) {
        total_price += current_user->get_corrected_price(product->price);
        current_user->buy(product);
    }

    os << "CLIENT_UI: Cart purchase completed. Total price: " << total_price << "." << std::endl;
    current_user->clear_cart();
}

void ClientUI::buy(std::string product_name) {
    // TODO: For problem 1-2
    Product *product = db.find_product(product_name);

    if (!current_user) {
        os << "CLIENT_UI: Please login first." << std::endl;
        return;
    }
    if (!product) {
        os << "CLIENT_UI: Invalid product name." << std::endl;
        return;
    }
    
    current_user->buy(product);
    os << "CLIENT_UI: Purchase completed. Price: " << current_user->get_corrected_price(product->price) << "." << std::endl;
}

void ClientUI::recommend_products() {
    // TODO: For problem 1-3.
    if (!current_user) {
        os << "CLIENT_UI: Please login first." << std::endl;
        return;
    }
    
    std::vector<Product*> products = current_user->recommend_products(db.fetch_all_users());

    os << "CLIENT_UI: Recommended products: [";
    for (int idx = 0; idx < products.size(); idx++) {
        Product *product = products.at(idx);
        
        os << "(" << product->name << ", " << current_user->get_corrected_price(product->price) << (idx < products.size() - 1 ? "), " : ")");
    }
    os << "]" << std::endl;
}

