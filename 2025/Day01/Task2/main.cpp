// main.cpp
#include <iostream>
#include <vector>
#include <fstream>
#include <string>

int main()
{
    int res = 0;
    int ptr = 50;
    std::string path = "./2025/Day01/Task2/input";
    std::ifstream file(path);
    std::string str;

    while (std::getline(file, str)) {
        int direction = str.substr(0, 1) == "R" ? 1 : -1;
        int max_step = std::stoi(str.substr(1, str.length()));

        for (int i = 0; i < max_step; ++i) {
            ptr += direction;
            if (ptr < 0 || ptr > 99)
                ptr = ptr < 0 ? 99 : 0;
            if (ptr == 0)
                ++res;
        }
    }
    
    std::cout << res;
    return 0;
}