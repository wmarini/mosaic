#ifndef APP_EXCEPTION_H
#define APP_EXCEPTION_H

#include <exception>
#include <string>

namespace app {

class AppException : public std::exception {
public:
    AppException(const char* message) 
    : message_(message) {}
    virtual ~AppException() = default;

    virtual const char* what() const noexcept override { 
        return message_.c_str(); 
    }

private:
    std::string message_;
};

void handle_exception() noexcept;

} // namespace app

#endif // APP_EXCEPTION_H