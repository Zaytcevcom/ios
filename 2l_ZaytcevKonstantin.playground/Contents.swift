import Foundation

/*
 1. Написать функцию, которая определяет, четное число или нет.
 */
func isEvenNumber(number: Int) -> Bool
{
    return number % 2 == 0;
}


/*
 2. Написать функцию, которая определяет, делится ли число без остатка на 3
 */
func isDeleteThree(number: Int) -> Bool
{
    return number % 3 == 0;
}


/*
 3. Создать возрастающий массив из 100 чисел.
 */
var array: [Int] = []

for i in 0...99 {
    array.append(i)
}


/*
 4. Удалить из этого массива все четные числа и все числа, которые не делятся на 3.
 */
for value in array {
    if (isEvenNumber(number: value) || !isDeleteThree(number: value)) {
        array.remove(at: array.firstIndex(of: value)!)
    }
}


/*
 5. Написать функцию, которая добавляет в массив новое число Фибоначчи, и добавить при помощи нее 50 элементов
 */
func addElemToArrayFib(arrayFib: inout Array<Int>) -> Array<Int>
{
    let sum = arrayFib[arrayFib.count - 1] + arrayFib[arrayFib.count - 2];
    
    arrayFib.append(sum)
    
    return arrayFib
}

var arrayFib = [0, 1]

// Добавляем 50 элементов с помощью функции
for _ in 0...49 {
    addElemToArrayFib(arrayFib: &arrayFib)
}

// Проверяем результат
for elem in arrayFib {
    //print(elem)
}


/*
 6. Заполнить массив из 100 элементов различными простыми числами.
 Натуральное число, большее единицы, называется простым, если оно делится только на себя и на единицу
 */

func getSimpleNumbers(maxNumber: Int) -> Array<Int>
{
    var arr = [Int: Bool]()
    
    // Заполнения словаря данными
    for i in 2...maxNumber {
        arr[i] = true
    }
    
    var p = 2

    while (true) {
        
        // Зачеркиваем числа с шагом p
        for i in stride(from: 2 * p, through: maxNumber, by: p) {
            arr[i] = false
        }
    
        
        var flag = false
        
        // Находим первое незачеркнутое число большее p
        for i in p...maxNumber {
            
            if (i > p && arr[i] == true) {
                p = i
                flag = true
                break
            }
        }
        
        if (!flag) {
            break
        }
    }
    
    var arrResult: Array<Int> = []
    
    // Формируем массив с простыми числами
    for (key, value) in arr {
        if (value) {
            arrResult.append(key)
        }
    }
    
    return arrResult.sorted()
}


let arraySimpleNumbers = getSimpleNumbers(maxNumber: 100)

var arraySimple: [Int] = []

// Заполнение массива простыми числами
for _ in 0...99 {
    let randomNum = arraySimpleNumbers[Int.random(in: 0..<arraySimpleNumbers.count)]
    arraySimple.append(randomNum)
}

for elem in arraySimple {
    print(elem)
}

