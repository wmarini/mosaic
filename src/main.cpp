#include "appmosaic.h"

namespace {

void Usage()
{
    std::cout << "Usage: mosaic <input file> <output file>\n";
}

void CheckCUDADevice()
{
    if (common::GetDeviceCount() == 0)
      throw app::AppException("No CUDA device found");
}

void CheckArguments(int argc)
{
    if (argc < 2) {
      Usage();
      throw app::AppException("No input files provided");
    }
}

app::ImagePair ParseArguments(int argc, char* argv[])
{
    return std::make_tuple(argv[1], argv[2]);
}

void Run(int argc, char* argv[]) 
{
  CheckArguments(argc);
  CheckCUDADevice();

  auto [in_fn, out_fn] = ParseArguments(argc, argv);

  mosaic::ProcessMosaic(
      mosaic::MosaicConfig{},
      in_fn,
      out_fn);
}

void PrintHeader()
{
    using namespace std::string_literals;
    std::cout 
        << "== Mosaic ==\n\n"
           "This is the Capstone project for the Coursera course \n"
           "CUDA at Scale for the Enterprise\n"
           "https://www.coursera.org/learn/cuda-at-scale-for-the-enterprise\n"
           "This course is part of GPU Programming Specialization - John Hopkins University\n"
           "https://www.coursera.org/specializations/gpu-programming\n\n";
}

void PrintCUDAVersion()
{
    auto version = common::CUDAVersion();
    std::cout << "CUDA version: " 
      << version.major << '.' << version.minor << "\n";
}

void PrintNPPVersion()
{
  auto version = common::NPPVersion();
    std::cout << "NPP version: " 
      << version.major << '.' << version.minor << "\n";
}

void PrintSeparator()
{
    std::cout << "----------------------------------------\n";
}

void PrintFinalWords()
{
    std::cout << "== Mosaic ==\n";
}

} // namespace

int main(int argc, char* argv[]) 
{
  try {
    PrintHeader();
    PrintSeparator();
    PrintCUDAVersion();
    PrintNPPVersion();
    PrintSeparator();
    Run(argc, argv);
    PrintSeparator();
    PrintFinalWords();
  } catch (...) {
    app::handle_exception();
    return EXIT_FAILURE;
  }
  return EXIT_SUCCESS;
}