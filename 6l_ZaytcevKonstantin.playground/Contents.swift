import UIKit

struct Queue<T: Comparable> {
    
    var elements: [T] = []
    
    mutating func add(_ element: T) {
        elements.append(element)
    }
    
    mutating func get() -> T? {
        return elements.removeFirst()
    }
    
    func filter(_ element: T) -> [T] {
        return elements.filter {$0 == element }
    }
    
    subscript (index: Int) -> T? {
        return (index < elements.count) ? elements[index] : nil
    }
}

print("=== String elements ===")

var StringElements = Queue<String>()

// Добавление элементов в очередь
StringElements.add("Первый")
StringElements.add("Второй")
StringElements.add("Третий")

print(StringElements.elements)

// Удаление из очереди
StringElements.get()

print(StringElements.elements)


// Поиск элементов по названию
print("Find elements: \(StringElements.filter("Второй"))")

// Обращение к несуществующему индексу (должен вернуться nil)
print(StringElements[5000])


print("\r\n=== Int elements ===")

var IntElements = Queue<Int>()
IntElements.add(10)
IntElements.add(20)
IntElements.add(30)

print(IntElements.elements)

// Удаление из очереди
IntElements.get()

print(IntElements.elements)
