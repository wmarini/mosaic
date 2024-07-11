#ifndef APP_MOSAIC_H
#define APP_MOSAIC_H

#include "appexception.h"
#include "mosaic/mosaic.h"
#include <vector>
#include <tuple>
#include <string>
#include <iostream>

namespace app {

using ImageList = std::vector<std::string>;
using ImagePair = std::tuple<std::string,std::string>;

} // namespace app

#endif // APP_MOSAIC_H
