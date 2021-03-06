// A simple path finding game
#include <iostream>
#include <cstdlib>
#include <cmath>
#include <vector>
#include <algorithm>

using namespace std;

int W[10][10] = {
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 3, 2, 0, 0, 0, 0, 0},
    {0, 0, 3, 3, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 3, 3, 0, 0, 3, 0, 0, 0, 0},
    {3, 0, 0, 0, 3, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 3, 0, 0, 0, 0, 0},
    {1, 3, 0, 0, 0, 0, 0, 0, 0, 0},
};

int N = 10;
int R1 = 9, R2 = 0;
int P1 = 3, P2 = 4;

inline void show()
{
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            char ch = '.';
            if (W[i][j] == 1)
                ch = 'H';
            else if (W[i][j] == 2)
                ch = 'B';
            else if (W[i][j] == 3)
                ch = 'X';
            cout << ch << " ";
        }
        cout << endl;
    }
    cout << endl;
}

int cost(int i, int j)
{
    return abs(R1 - i) + abs(R2 - j);
}

bool found()
{
    return ((P1 == R1) && (P2 == R2));
}

struct Node
{
    int i, j;
    int cost;

    Node(int ii, int jj, int cc) : i(ii), j(jj), cost(cc)
    {
    }

    bool operator<(const Node& other)
    {
        return this->cost < other.cost;
    }
};

inline void findpath()
{
    vector<Node> costs;
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            if ((i == P1 && j == P2) ||
                (i == P1 - 1 && j == P2 - 1) ||
                (i == P1 - 1 && j == P2 + 1) ||
                (i == P1 + 1 && j == P2 - 1) ||
                (i == P1 + 1 && j == P2 + 1) ||
                (W[i][j] == 3))
                continue;

            if (i == P1 - 1 || i == P1 + 1) {
                if (j == P2 - 1 || j == P2 || j == P2 + 1) {
                    Node n(i, j, cost(i, j));
                    costs.push_back(n);
                }
            }

            if (i == P1 && (j == P2 - 1 || j == P2 + 1)) {
                Node n(i, j, cost(i, j));
                costs.push_back(n);
            }
        }
    }

    if (costs.size() > 0) {
        sort(costs.begin(), costs.end());
        int P11 = costs[0].i;
        int P22 = costs[0].j;
        W[P1][P2] = 0;
        W[P11][P22] = 2;
        P1 = P11;
        P2 = P22;
    }
}

int main()
{
    char ans = 'Y';
    while (!found() && (ans == 'Y' || ans == 'y' || ans == '\n')) {
        show();
        findpath();
        cout << "Next? (Y/N) ";
        cin >> ans;
    }
    return 0;
}
