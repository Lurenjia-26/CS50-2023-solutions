import random
LENGTH = 10
MIN = 0
MAX = 1000


def main():
    li = randLicense()
    est(li)


def randLicense():
    li = set()
    while True:
        li.add(random.randint(MIN, MAX))
        if (len(li) == LENGTH):
            break
    return li


def est(li):
    li = list(li)
    li.sort()
    max0 = 2 * sum(li) / len(li)
    max1 = 2 * li[int(LENGTH / 2)]
    max2 = li[LENGTH - 1] + (li[0] - MIN)
    max3 = 0
    print(li)
    print("Avg\t Median\t    Gap\t  Avg Gap")
    print(f"{max0}\t {max1}\t    {max2}\t  {max3}")


main()