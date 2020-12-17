#include "admin_ui.h"

AdminUI::AdminUI(ShoppingDB &db, std::ostream& os): UI(db, os) { }

void AdminUI::add_product(std::string name, int price) {
    // TODO: For problem 1-1
    if (price <= 0) {
        os << "ADMIN_UI: Invalid price." << std::endl;
        return;
    }

    Product *product = new Product(name, price);
    db.add_product(product);
    os << "ADMIN_UI: " << name << " is added to the database." << std::endl;
}

void AdminUI::edit_product(std::string name, int price) {
    // TODO: For problem 1-1
    Product *product = db.find_product(name);

    if (!product) {
        os << "ADMIN_UI: Invalid product name." << std::endl;
        return;
    }
    if (price <= 0) {
        os << "ADMIN_UI: Invalid price." << std::endl;
        return;
    }

    product->price = price;
    os << "ADMIN_UI: " << name << " is modified from the database." << std::endl;
}

void AdminUI::list_products() {
    // TODO: For problem 1-1
    std::vector<Product*> products = db.fetch_all_products();

    os << "ADMIN_UI: Products: [";
    for (int idx = 0; idx < products.size(); idx++) {
        Product *product = products.at(idx);
        
        os << "(" << product->name << ", " << product->price << (idx < products.size() - 1 ? "), " : ")");
    }
    os << "]" << std::endl;
}
