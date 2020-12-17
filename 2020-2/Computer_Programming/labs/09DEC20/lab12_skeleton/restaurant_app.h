#include <vector>
#include <map>
#include <string>
#include <utility>
#include <memory>

using std::string;
using std::vector;
using std::shared_ptr;
class RestaurantApp {
    private:
        std::map<string, shared_ptr<vector<int>>> restaurants;
        shared_ptr<vector<int>> find_restaurant(string target);

    public:
        void rate(string target, int rate);
        void list();
        void show(string target);
        void ave(string target);
        void med(string target);
        void min(string target);
        void max(string target);
        void del(string target, int rate);
        void cheat(string target, int rate);
};

