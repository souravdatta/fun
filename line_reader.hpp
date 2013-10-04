#ifndef __LINE_READER_H__
#define __LINE_READER_H__

#include <sstream>
#include <string>
#include <vector>
#include <iostream>

namespace lnrd {

    template <class Stream>
    class line_reader
    {
    public:
        line_reader(Stream& stream) : my_stream(stream) {}

        template <class Type>
        std::vector<Type> read(const std::size_t l_num)
        {
            std::string line;
            std::getline(my_stream, line);
            std::stringstream value_stream(line);
            std::vector<Type> vec;
        
            for (int i = 0; i < l_num; i++) {
                Type temp;
                value_stream >> temp;
                vec.push_back(temp);
            }
        
            return vec;
        }
    private:
        Stream& my_stream;

        line_reader(const line_reader&) {}
        line_reader& operator=(const line_reader&) {}
    };

    template <class T>
    void show(const std::vector<T>& vec)
    {
        typename std::vector<T>::const_iterator it;
        for (it = vec.begin();
             it != vec.end();
             ++it) {
            std::cout << ">> " << *it << std::endl;
        }
    }
    
} // namespace lnrd
#endif
