#include "CSI.h"
#include <fstream>
#include <iostream>

using namespace std;

Complex::Complex(): real(0), imag(0) {}

CSI::CSI(): data(nullptr), num_packets(0), num_channel(0), num_subcarrier(0) {}

CSI::~CSI() {
    if(data) {
        for(int i = 0 ; i < num_packets; i++) {
            delete[] data[i];
        }
        delete[] data;
    }
}

int CSI::packet_length() const {
    return num_channel * num_subcarrier;
}

void CSI::print(std::ostream& os) const {
    for (int i = 0; i < num_packets; i++) {
        for (int j = 0; j < packet_length(); j++) {
            os << data[i][j] << ' ';
        }
        os << std::endl;
    }
}

std::ostream& operator<<(std::ostream &os, const Complex &c) {
    os << c.real << "+" << c.imag << "i";
    return os;
}

void read_csi(const char* filename, CSI* csi) {
    string line;
    ifstream csi_values_file (filename);

    if (csi_values_file.is_open()) {
        getline(csi_values_file, line);
        csi->num_packets = stoi(line);
        
        getline(csi_values_file, line);
        csi->num_channel = stoi(line);

        getline(csi_values_file, line);
        csi->num_subcarrier = stoi(line);
        int ns = stoi(line);

        csi->data = new Complex*[csi->num_packets];

        for (int packet_idx = 0; packet_idx < csi->num_packets;  packet_idx++) {
            Complex *packet = new Complex[csi->num_channel * csi->num_subcarrier];

            for (int channel_idx = 0; channel_idx < csi->num_channel; channel_idx++) {
                for (int subcarrier_idx = 0; subcarrier_idx < csi->num_subcarrier; subcarrier_idx++) {
                    Complex complex;
                    getline(csi_values_file, line);
                    int real = stoi(line);
                    getline(csi_values_file, line);
                    int imag = stoi(line);

                    complex.real = real;
                    complex.imag = imag;

                    packet[channel_idx * csi->num_channel + subcarrier_idx] = complex;
                }
            }

            csi->data[packet_idx] = packet;
        }

        csi_values_file.close();
    }
}

float** decode_csi(CSI* csi) {
    float **result = new float*[csi->num_packets];

    for (int packet_idx = 0; packet_idx < csi->num_packets; packet_idx++) {
        float *amp_packet = new float[csi->num_channel * csi->num_subcarrier];

        for (int channel_idx = 0; channel_idx < csi->num_channel; channel_idx++) {
            for (int subcarrier_idx = 0; subcarrier_idx < csi->num_subcarrier; subcarrier_idx++) {
                Complex complex = csi->data[packet_idx][channel_idx * csi->num_channel + subcarrier_idx];

                float amp = sqrt(complex.real * complex.real + complex.imag * complex.imag);
                amp_packet[channel_idx * csi->num_channel + subcarrier_idx] = amp;
            }
        }

        result[packet_idx] = amp_packet;
    }

    return result;
}

float* get_std(float** decoded_csi, int num_packets, int packet_length) {
    float *result = new float[num_packets];

    for (int packet_idx = 0; packet_idx < num_packets; packet_idx++) {
        float *amp_packet = *(decoded_csi + packet_idx);

        result[packet_idx] = standard_deviation(amp_packet, packet_length);
    }

    return result;
}

void save_std(float* std_arr, int num_packets, const char* filename) {
    // TODO: problem 1.5

    ofstream std_file (filename);

    for (int packet_idx = 0; packet_idx < num_packets; packet_idx++) {
        float std = std_arr[packet_idx];

        std_file << std << " ";
    }

    std_file.close();
}

// convenience functions
float standard_deviation(float* data, int array_length) {
    float mean = 0, var = 0;
    for (int i = 0; i < array_length; i++) {
        mean += data[i];
    }
    mean /= array_length;
    for (int i = 0; i < array_length; i++) {
        var += pow(data[i]-mean,2);
    }
    var /= array_length;
    return sqrt(var);
}