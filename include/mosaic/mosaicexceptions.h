#ifndef MOSAIC_EXCEPTION_H
#define MOSAIC_EXCEPTION_H

#include <exception>
#include <string>

namespace mosaic {

class MosaicException : public std::exception {
public:
    MosaicException(const std::string message) 
    : message_(message) {}
    virtual ~MosaicException() = default;

    virtual const char* what() const noexcept override { 
        return message_.c_str(); 
    }

private:
    std::string message_;
};

} // namespace mosaic

#endif // MOSAIC_EXCEPTION_H

