#include <iostream>
using namespace std;

int modular(int n1, int n2)
{
    while (n1 >= n2)
    {
        n1 -= n2;
    }
    return n1;
}

int gcd(int n1, int n2)
{
    if (n2 != 0)
    {
        return gcd(n2, modular(n1, n2));
    }
    return n1;
}

int main()
{
    int a, b;
    cin >> a >> b;
    cout << gcd(a, b) << endl;
    return 0;
}