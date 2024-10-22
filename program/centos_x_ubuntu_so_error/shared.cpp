#include "shared.h"

#include <iostream>

void shared_api() { std::cout << "this is a shared api call" << std::endl; }

Model::Model(const std::string &model_file, uint32_t batch_size,
             const std::string &hw_conf, bool cached, uint32_t flag) {
    std::cout << "Model con" << std::endl;
    a = 1;
}
