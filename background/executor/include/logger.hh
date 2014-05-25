#ifndef LoggerModuleHH
#define LoggerModuleHH

#include <string>
#include <vector>
#include <fstream>
#include "yaml-cpp/yaml.h"

namespace OITesterExecutor {
    using namespace std;

    /*! A class to log infomation. */
    class Logger {
        public:
            /*! Log a sequence of strings with a label. */
            virtual void log(const string &label, const vector<string> &info) = 0;
            virtual ~Logger() {}
    };

    /*! Logger with file. */
    class FileLogger: public Logger {
        public:
            /*! Init with a file name. */
            FileLogger(const string &log_file_name);
            virtual ~FileLogger(void);

            void log(const string &label, const vector<string> &info);
        private:
            YAML::Node record;
            ofstream fs;
    };
}

#endif
