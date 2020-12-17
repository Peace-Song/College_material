#include <iostream>

int main(){
   int v = 5;
   int* array= &v;
   int** array_of_array;

   // Allocate arrays of (pointer to int array)
   array_of_array = new int*[5];

   // Allocate arrays
   for (int i = 0; i < 5; i++) {
      array_of_array[i] = new int[5];
   }

   // Assign values
   for (int i = 0 ; i < 5; i++) {
      for (int j = 0; j < 5 ; j++) {
         array_of_array[i][j] = i * 5 + j;
      }
   }

   // Print pointers to array
   for (int i = 0; i < 5; i++) {
      std::cout << array_of_array[i] << std::endl;
   }

   // Print values
   for (int i = 0; i < 5; i++) {
      for (int j = 0; j < 5 ; j++) {
         std::cout << array_of_array[i][j] << " ";
      }
      std::cout << std::endl;
   }

   return 0;
}
