// main.cpp
#include <iostream>
#include <vector>
#include <fstream>
#include <string>

int main()
{
    using namespace std;
    int res = 0;
    int ptr = 50;
    string path = "./2025/Day01/Task1/input";
    ifstream file(path);
    string str;
    if (!file.is_open()) {
        cerr << "Error: Could not open file " << path << endl;
        return 1;
    }

    while (getline(file, str)) {
        int direction = str[0] == 'R' ? 1 : -1;
        int max_step = stoi(str.substr(1));

        for (int i = 0; i < max_step; ++i) {
            ptr += direction;
            if (ptr < 0 || ptr > 99)
                ptr = ptr < 0 ? 99 : 0;
        }
        if (ptr == 0)
            ++res;
    }
    
    cout << res << endl;
    return 0;
}