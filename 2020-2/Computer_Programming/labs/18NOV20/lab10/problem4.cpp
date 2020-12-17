#include <iostream>
#include <cmath>

class Grid2d {
public:
    Grid2d(int row, int column)
        : row(row), column(column){
        grid = new int*[row];

        for (int i = 0; i < row ; i++) {
            grid[i] = new int[column];
        }
    }

    int getRow() const {
        return row;
    }

    int getColumn() const {
        return column;
    }

    void setAt(int v, int r, int c) {
        // ...
        // validation of r,c
        // ...
        grid[r][c] = v;
    }

    int getAt(int r, int c) const {
        // ...
        // validation of r,c
        // ...
        return grid[r][c];
    }

    
    friend std::ostream& operator <<(std::ostream& os, const Grid2d& grid) {
        for (int r = 0; r < grid.getRow(); r++) {
            for (int c = 0; c < grid.getColumn(); c++) {
                os << grid.getAt(r, c) << " ";
            }
            os << std::endl;
        }

        return os;
    }

    // TODO : Add proper clean-up code!
    ~Grid2d() {
        delete grid;
    }

private:
    int** grid;
    int row, column;
};



int main() {
    Grid2d grid(5, 10);

    for (int r = 0; r < grid.getRow(); r++) {
        for (int c = 0; c < grid.getColumn(); c++) {
            grid.setAt(r * grid.getColumn() + c, r, c);
        }
    }

    std::cout << grid << std::endl;
    
    // Potential memory leak!!!!
    return 0;
}