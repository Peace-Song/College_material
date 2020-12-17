#include <iostream>
#include <memory>

using std::unique_ptr; using std::make_unique;
using std::shared_ptr; using std::make_shared;
using std::weak_ptr;
class Test {
    public:
        int test_id;
        Test(int id) : test_id(id) { 
            std::cout << "constructed" << std::endl;
        }
        ~Test() { std::cout << "destructed" << std::endl; }

};

void print_unique() {
    unique_ptr<Test> test_unique1(new Test(1));
    unique_ptr<Test> test_unique2 = std::make_unique<Test>(2);
    //unique_ptr<test> test_unique3 = test_unique2; // this is not allowed
    std::cout << "id : " << test_unique1->test_id << std::endl;
    std::cout << "id : " << test_unique2->test_id << std::endl;
}

shared_ptr<Test> test_shared() {
    shared_ptr<Test> test_shared1(new Test(1));
    shared_ptr<Test> test_shared2 = make_shared<Test>(2);
    shared_ptr<Test> test_shared3 = test_shared2;
    std::cout << "id : " << test_shared1->test_id << std::endl;
    std::cout << "id : " << test_shared2->test_id << std::endl;
    return test_shared3;
}

void print_shared() {
    shared_ptr<Test> ptr = test_shared();
    std::cout << "id : " << ptr->test_id << std::endl;
}

void print_weak() {
    shared_ptr<Test> test_shared1(new Test(1));
    shared_ptr<Test> test_shared2 = test_shared1;
    std::cout << "use count before : " << test_shared1.use_count() << std::endl;

    weak_ptr<Test> test_weak = test_shared1;    
    std::cout << "id : " << test_weak.lock()->test_id << std::endl;
    std::cout << "use count after : " << test_weak.use_count() << std::endl;
}

int main() {
    std::cout << "<Test unique_ptr>" << std::endl;
    print_unique();


    std::cout << "\n<Test shared_ptr>" << std::endl;
    print_shared();


    std::cout << "\n<Test weak_ptr>" << std::endl;
    print_weak();

    return 0;
}
