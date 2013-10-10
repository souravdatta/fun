#ifndef __LINE_READER_H__
#define __LINE_READER_H__

#include <sstream>
#include <string>
#include <vector>
#include <iostream>
#include <queue>

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

// Graph class (TODO: add DFS/BFS/A* algos)
template <class T, int N>
class Graph
{
public:
	static const int SIZE = N;

	Graph()
	{
		for (int i = 0; i < N; i++) {
			VI vec;
			for (int j = 0; j < N; j++) {
				vec.push_back(false);
			}
			G.push_back(vec);
		}
	}

	void addNode(const T& node)
	{
		this->actuals.push_back(node);
	}

	T getNodeAt(int i) const
	{
		if (i < 0 || i >= N)
			throw "out of bounds";
		return actuals[i];
	}

	void connect(int i, int j)
	{
		if (i < 0 || i >= N)
			throw "out of bounds 1";
		if (j < 0 || j >= N)
			throw "out of bounds 2";
		G[i][j] = true;
	}

	void printMatrix() const
	{
		VII::const_iterator it = G.begin();
		for (int i = 0; it != G.end(); ++it, ++i) {
			std::cout << i << "\t";
			VI::const_iterator iit = it->begin();
			for (; iit != it->end(); ++iit) {
				std::cout << ((*iit)? 1 : 0) << " ";
			}
			std::cout << std::endl;
		}
	}

private:
	typedef std::vector< std::vector<int> > VII;
	typedef std::vector<int> VI;
	std::vector<T> actuals;
	VII G;
};
    

#endif
