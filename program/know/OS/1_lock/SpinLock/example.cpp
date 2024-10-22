#include <atomic>
#include <chrono>
#include <thread>

class SpinLock {
  public:
    SpinLock() : flag(false) {}

    void lock() {
        while (flag.exchange(true, std::memory_order_acquire)) {
            std::this_thread::yield();
        }
    }

    void unlock() { flag.store(false, std::memory_order_release); }

  private:
    std::atomic<bool> flag;
};

// #include <iostream>
// #include <thread>
// #include <vector>

// SpinLock spinlock;
// int sharedResource = 0;

// void incrementResource() {
//     for (int i = 0; i < 1000000; ++i) {
//         spinlock.lock();
//         ++sharedResource; // 访问共享资源
//         spinlock.unlock();
//     }
// }

// int main() {
//     auto start = std::chrono::high_resolution_clock::now();
//     std::vector<std::thread> threads;

//     for (int i = 0; i < 10; ++i) {
//         threads.emplace_back(incrementResource);
//     }

//     for (auto &th : threads) {
//         th.join();
//     }

//     auto end = std::chrono::high_resolution_clock::now();
//     auto time_delay =
//         std::chrono::duration_cast<std::chrono::microseconds>(end - start)
//             .count();
//     std::cout << "Final value: " << sharedResource << std::endl;
//     std::cout << "time is " << time_delay << " us";
//     return 0;
// }

#include <iostream>
#include <mutex>
#include <thread>
#include <vector>

std::mutex spinlock;
int sharedResource = 0;

void incrementResource() {
    for (int i = 0; i < 1000000; ++i) {
        spinlock.lock();
        ++sharedResource; // 访问共享资源
        spinlock.unlock();
    }
}

int main() {
    auto start = std::chrono::high_resolution_clock::now();
    std::vector<std::thread> threads;

    for (int i = 0; i < 10; ++i) {
        threads.emplace_back(incrementResource);
    }

    for (auto &th : threads) {
        th.join();
    }

    auto end = std::chrono::high_resolution_clock::now();
    auto time_delay =
        std::chrono::duration_cast<std::chrono::microseconds>(end - start)
            .count();
    std::cout << "Final value: " << sharedResource << std::endl;
    std::cout << "time is " << time_delay << " us";
    return 0;
}
