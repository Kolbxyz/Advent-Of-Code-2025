from pulp import * # type: ignore
from typing import cast
import re

#### PARSING
# Convert the "pattern" (joltage requirements) to an array of ints
def to_list_int(s: str) -> list[int]:
    return [int(x) for x in s.split(",")]

# converts buttons to their respective vectors
def buttons_to_vec(s: str, size: int) -> list[int]:
    v = [0] * size

    for x in s.split(","):
        v[int(x)] = 1
    return v

# Basically the same thing as Part 1
# Except I rewrote it in python...
def parse(content: str):
    buttons, targets = [], []

    for line in content.splitlines():
        t = re.search(r"\{([0-9,]+)\}", line)
        target = to_list_int(t.group(1)) # type: ignore
        groups = re.findall(r"\(([0-9,]+)\)", line) # basically gmatch but returns an array instead of an iterator func
        button_vectors = [buttons_to_vec(g, len(target)) for g in groups]

        buttons.append(button_vectors) # type: ignore
        targets.append(target) # type: ignore

    return buttons, targets # type: ignore

with open("2025/Day10/Task2/input") as f:
    content = f.read()
button_sets, target_sets = parse(content)

#### Magic

total: int = 0
for i in range(len(button_sets)): # type: ignore
    buttons: List[List[int]] = button_sets[i] # type: ignore
    target: List[int] = target_sets[i] # type: ignore

    average_life_problem: LpProblem = LpProblem(f"machine_{i}", LpMinimize) # Init problem
    x: List[LpVariable] = [LpVariable(f"x_{i}_{j}", lowBound=0, cat="Integer") for j in range(len(buttons))] # type: ignore
    average_life_problem += lpSum(x)

    for i in range(len(target)): # type: ignore
        constraint_sum: LpVariable = lpSum(buttons[j][i] * x[j] for j in range(len(buttons))) # type: ignore
        average_life_problem += constraint_sum == target[i] # type: ignore

    average_life_problem.solve(PULP_CBC_CMD(msg=False)) # type: ignore
    total += sum(int(cast(float, v.value())) for v in x)

# I've got no clue how that mathematically works but the lib does its job
# Please forgive my horrible code, it's really ugly, I know!

print(total)
