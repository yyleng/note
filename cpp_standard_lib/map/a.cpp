#include <map>
#include <iostream>

using namespace std;

int main(){
     std::less<int> lt;
     std::map<int, int, std::less<int> > m(lt);
}
