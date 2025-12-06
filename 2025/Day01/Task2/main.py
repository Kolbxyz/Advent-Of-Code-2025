# main.py
res : int = 0
ptr : int = 50

with open("./2025/Day01/Task2/input", "r") as f:
    for line in f:
        direction : int = line[0:1] == "R" and 1 or -1
        max_step : int = int(line[1:])

        for i in range(0, max_step):
            ptr += direction
            if ptr < 0 or ptr > 99:
                ptr = ptr < 0 and 99 or 0
            res += ptr == 0 and 1 or 0

print(res)