import UIKit

/*
 1. Придумать класс, методы которого могут завершаться неудачей и возвращать либо значение, либо ошибку Error?.
 Реализовать их вызов и обработать результат метода при помощи конструкции if let, или guard let.
 */

class Analytics {
    
    func avarageSales(products: [String:Int]) -> Int
    {
        if products.count == 0 {
            return 0
        }
        
        var total = 0;
        
        for product in products {
            total += product.value
        }
        
        return total / products.count
    }
}

let productsSale2021 = [
    "Томат": 10892,
    "Огурец": 6237,
    "Шампиньон": 2894,
]

let productsSale2022: [String:Int] = [:]

let analytics = Analytics()

print(analytics.avarageSales(products: productsSale2021))
print(analytics.avarageSales(products: productsSale2022))


print("\n\r")

/*
 2. Придумать класс, методы которого могут выбрасывать ошибки. Реализуйте несколько throws-функций.
 Вызовите их и обработайте результат вызова при помощи конструкции try/catch.
 */

enum PasswordValidateError:Error {
    case MinLength // слишком короткий пароль
    case MaxLength // слишком длинный пароль
    case Forbidden // данное слово запрещено
}

class PasswordValidate
{
    func check(password: String) throws -> Bool
    {
        if (password.count < 4) {
            throw PasswordValidateError.MinLength
        }
        
        if (password.count > 30) {
            throw PasswordValidateError.MaxLength
        }
        
        if (password == "admin" || password == "qwerty") {
            throw PasswordValidateError.Forbidden
        }
        
        return true
    }
}

do {
    
    let passValid = PasswordValidate()
    
    try passValid.check(password: "qwe")
    
    print("Пароль прошел все проверки!")
    
} catch PasswordValidateError.MinLength {
    print("Минимальная длина пароля 4 символов!")
} catch PasswordValidateError.MaxLength {
    print("Максимальная длина пароля 30 символов!")
} catch PasswordValidateError.Forbidden {
    print("Данный пароль запрещен!")
}
