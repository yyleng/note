#pragma once
#include <string>
#include <cstdint>

void shared_api();

class Model {
    public:
      Model(const std::string &model_file, uint32_t batch_size,
        const std::string &hw_conf = "", bool cached = false,
        uint32_t flag = 2);
    private:
      int a;
};
