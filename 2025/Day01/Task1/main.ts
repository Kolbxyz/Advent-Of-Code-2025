// main.js
import * as fs from 'fs';

let ptr : number = 50
let score : number = 0;

const data : string = fs.readFileSync('./2025/Day01/Task1/input', 'utf8');
const lines : string[] = data.split("\n");

lines.forEach(line => {
    const direction : number = line[0] == "R" ? 1 : -1;
    const max_step : number = parseInt(line.substring(1));

    for (let i : number = 0; i < max_step; ++i) {
        ptr += direction;
        if (ptr > 99 || ptr < 0)
            ptr = ptr > 99 ? 0 : 99;
    }
    if (ptr == 0)
        ++score;
}
)

console.log(score);