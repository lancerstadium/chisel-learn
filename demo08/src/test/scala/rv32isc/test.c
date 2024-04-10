int test(int n)
{
    if (n == 1 || n == 2) // 数列前两项
    {
        return 1;
    }
    else // 从第三项开始
    {
        return test(n - 1) + test(n - 2);
    }
    return 0;
}
int main()
{
    int n = 10;
    int ret = test(n); // 计算斐波那契数列
    return ret;
}