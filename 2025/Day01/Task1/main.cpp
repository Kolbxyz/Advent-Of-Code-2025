// main.cpp
#include <iostream>
#include <vector>
#include <fstream>

int main()
{
    int ptr = 50;
    std::string path = "2025/Day01/Task1/input";
    std::ifstream file(path);
    std::string str;

    while (std::getline(file, str)) {
        int direction = str.substr(0, 1) == "R" ? 1 : 0;
        int max_step = std::stoi(str.substr(1, str.length()));

        for (int i = 0; i < max_step; ++i) {
            //std::cout << i << std::endl;
            ptr++;
        }
    }
    
    /*
    std::vector<int> l = {1};

    l.push_back(3);
    l.push_back(6);
    for (int i : l)
        std::cout << i << std::endl;
    //std::cout << "Hello world!\n";*/
    return 0;
}