#include "appexception.h"
#include <stdexcept>
#include <iostream>

namespace app {

void handle_exception() noexcept {
    try {
        throw;
    } catch (const std::exception& e) {
        std::cerr << "Exception: " << e.what() << std::endl;
        std::exit(EXIT_FAILURE);
    } catch (...) {
        std::cerr << "Unknow Exception!\n";
        std::exit(EXIT_FAILURE);
    }
}

} // namespace app