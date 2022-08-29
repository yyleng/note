#include <bitset>
#include <iostream>

using namespace std;

int main(){
    std::bitset<64> bs("110110110");
    cout << bs.size() << endl;
    return 0;
}
