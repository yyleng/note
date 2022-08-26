#include <iostream>
#include <vector>
using namespace std;

int main() {
  vector<int> v2(10, 1);
  for (int i = 0; i < 10; i++) {
    cout << v2[i] << endl;
  }
  vector<int> v3(std::move(v2));
  for (int i = 0; i < v2.size(); i++) {
    cout << v2[i] << endl;
  }
}
