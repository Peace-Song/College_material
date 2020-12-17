#include <iostream>
#include <cmath>

class Distance {
public:
    Distance(double magnitude)
        :magnitude(magnitude), unit(1) {}

    double meters() const {
        return magnitude * unit;
    }

    // TODO: Add validity check 
    // Condition 1 : u should be non-negative number
    // Condition 2 : u should be powers of ten
    // Hint: std::log10, std::pow(10, n)
    void set_unit(double u) {
        if (u < 0 || (int)std::log10(u) != std::log10(u)) return;
        unit = u;
    }

private:
    double magnitude, unit;
};



int main() {
    Distance d(100);

    d.set_unit(1000); // Invalid

    std::cout << d.meters() << std::endl;

    return 0;
}