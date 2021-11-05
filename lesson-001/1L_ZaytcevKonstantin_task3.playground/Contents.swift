import UIKit

var sum: Double = 100000
let percent: Double = 7

sum = sum + sum / 100 * percent
sum = sum + sum / 100 * percent
sum = sum + sum / 100 * percent
sum = sum + sum / 100 * percent
sum = sum + sum / 100 * percent

print("Сумма вклада через 5 лет под", percent, "% составляет:", sum)
