#include "CSI.h"
#include "TestHelper.h"
#include <cassert>

void print_amp(float** csi_amp, int num_packets, int num_array, std::ostream& os) {
    for (int i = 0; i < num_packets; i++) {
        for (int j = 0; j < num_array; j++) {
            os << csi_amp[i][j] << ' ';
        }
        os << std::endl;
    }
}

void print_std(float* std_arr, int num_packets, std::ostream& os) {
    for (int i = 0; i < num_packets; i++) {
        os << std_arr[i] << ' ';
    }
    os << std::endl;
}

int main() {
    /* Main code for problem 1
    Implement TODOs in CSI.cpp
    Use print_cout flag to print & test the implementation
    If print_cout is true, main code print results to console.
    Otherwise, verify implementation with outputs in test/ folder.
    */
    bool print_cout = false;
    std::ostringstream oss_lhs;
    std::ostream& os_lhs = print_cout ? std::cout : oss_lhs;

    // test code 1.1
    Complex c;
    os_lhs << c << std::endl;
    if(!print_cout)
        TestHelper::verify("1-1",oss_lhs, "test/test1.out");

    // test code 1.2
    CSI* csi = new CSI;
    read_csi("test/test.in", csi);
    csi->print(os_lhs);
    if(!print_cout)
        TestHelper::verify("1-2",oss_lhs, "test/test2.out");

    // test code 1.3
    float** csi_amp = decode_csi(csi);
    print_amp(csi_amp, csi->num_packets, csi->packet_length(), os_lhs);
    if(!print_cout)
        TestHelper::verify("1-3",oss_lhs, "test/test3.out");

    // test code 1.4
    float* std_arr = get_std(csi_amp, csi->num_packets, csi->packet_length());
    print_std(std_arr, csi->num_packets, os_lhs);
    if(!print_cout)
        TestHelper::verify("1-4",oss_lhs, "test/test4.out");

    // test code 1.5
    save_std(std_arr, csi->num_packets, "standard_deviation.dat");
    if(!print_cout)
        TestHelper::verify("1-5","standard_deviation.dat", "test/test5.out");

    // clean-up memory
    for(int i = 0; i < csi->num_packets; i++) {
        if(csi_amp[i])
            delete [] csi_amp[i];
    }

    if(csi_amp)
        delete[] csi_amp;
    if(std_arr)
        delete[] std_arr;
    if(csi)
        delete csi;

    return 0;
}