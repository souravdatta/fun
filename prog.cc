#include <sstream>
#include <string>
#include <vector>
#include <iostream>
#include <fstream>
#include <queue>
#include <algorithm>

using namespace std;

// line_reader util class
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

    template <class Type>
    Type read_one()
    {
        std::vector<Type> vec = this->read<Type>(1);
        return vec[0];
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
        std::cout << *it << " ";
    }
    std::cout << std::endl;
}

typedef std::vector< std::vector<int> > VII;
typedef std::vector<int> VI;
    
#define FOR1(I, L) for (int I = 0; I < L; I++)
#define FOR2(IT, V, TYPE) for (TYPE::iterator IT = V.begin(); IT != V.end(); ++IT)
#define POP_W(N1, N2, VINNER) \
    FOR1(i, N1) { \
        VI vec; \
        FOR1(j, N2) { \
            vec.push_back(VINNER); \
        } \
        W.push_back(vec); \
    }
#define SHOW_W \
    int ii = 0; \
    FOR2(it1, W, VII) { \
        cout << ii << "\t"; \
        show(*it1); \
        ii++; \
    }


VII W;
VI V1, V2;
int N, SIZE;

int main(int argc, char **argv)
{
    POP_W(N, N, false);
    if (argc != 2)
        return 1;
    fstream file(argv[1]);
    line_reader<fstream> rd(file);
    
    return 0;
}



