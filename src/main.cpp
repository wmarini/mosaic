#include "appexception.h"
#include "mosaic/mosaic.h"
#include <iostream>

namespace {

void Run(int argc, char* argv[]) 
{
  std::cout << "Argc: " << argc << std::endl;
  for (int i = 1; i < argc; ++i) {
    std::cout << "Argv[" << i << "]: " << argv[i] << std::endl;
  }
  mosaic::ProcessMosaic(mosaic::MosaicConfig{});
}

void PrintHeader()
{
    using namespace std::string_literals;
    std::cout 
        << "== Mosaic ==\n\n"
           "This is the Capstone project for the Coursera course \n"
           "CUDA at Scale for the Enterprise\n"
           "https://www.coursera.org/learn/cuda-at-scale-for-the-enterprise\n"
           "This course is part of GPU Programming Speciaization - John Hopkins University\n"
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