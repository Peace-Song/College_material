#ifndef PROBLEM1_H
#define PROBLEM1_H

#include <iostream>
#include <string>
#include <cmath>

struct Complex {
    Complex();
    int real, imag;
};

// TODO : 1.1
std::ostream& operator<<(std::ostream& os, const Complex& c);

struct CSI {
    CSI();
    ~CSI();

    int packet_length() const;
    void print(std::ostream& os = std::cout) const;

    Complex ** data;
    int num_packets;
    int num_channel;
    int num_subcarrier;
};

// TODO : 1.2 ~ 1.5
void read_csi(const char* filename, CSI* csi);
float** decode_csi(CSI* csi);
float* get_std(float** decoded_csi, int num_packets, int packet_length);
void save_std(float* std_arr, int num_packets, const char* filename);

// convenience functions
float standard_deviation(float* data, int array_length);

#endif //PROBLEM1_H
