"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
// main.js
var fs = require("fs");
var ptr = 50;
var score = 0;
var data = fs.readFileSync('./2025/Day01/Task1/input', 'utf8');
var lines = data.split("\n");
lines.forEach(function (line) {
    var direction = line[0] == "R" ? 1 : -1;
    var max_step = parseInt(line.substring(1));
    for (var i = 0; i < max_step; ++i) {
        ptr += direction;
        if (ptr > 99 || ptr < 0)
            ptr = ptr > 99 ? 0 : 99;
        if (ptr == 0)
            ++score;
    }
});
console.log(score);
