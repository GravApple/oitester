/** \file logger.cc
 * The logger module.
 */
#include <string>
#include <vector>
#include <fstream>
#include "yaml-cpp/yaml.h"
#include "logger.hh"

namespace OITesterExecutor {
    using namespace std;

    FileLogger::FileLogger(const string &log_file_name) {
        fs.open(log_file_name.c_str(), ios_base::out);
    }

    FileLogger::~FileLogger(void) {
        fs << record << endl;
        fs.close();
    }

    void FileLogger::log(const string &label, const vector<string> &info) {
        for (const auto &s: info) record[label].push_back(s);
    }
}
