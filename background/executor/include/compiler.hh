#ifndef CompilerModuleHH
#define CompilerModuleHH

#include <string>
#include "logger.hh"

namespace OITesterExecutor {
    using namespace std;

    int compile(const string &lang, const string &command, const string &file_name, Logger &logger);
}

#endif
