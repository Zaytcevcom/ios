import UIKit

let a: Double = 1
let b: Double = 3
let c: Double = -4

let d = b * b - 4 * a * c

if (d < 0) {
    
    print("D < 0, корней нет")
    
} else if (d > 0) {
    
    let x1 = (-b + sqrt(d)) / (2 * a)
    let x2 = (-b - sqrt(d)) / (2 * a)
    
    print("D > 0, x1 =", x1, ", x2 =", x2)
    
} else {
    
    let x = -b / (2 * a)
    
    print("D = 0, x =", x)
    
}
