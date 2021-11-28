import UIKit

enum EngineState: String {
    case on = "Включен"
    case off = "Выключен"
}

enum WindowState: String {
    case on = "Открыты"
    case off = "Закрыты"
}

enum HatchState: String {
    case on = "Люк открыт"
    case off = "Люк закрыт"
}

enum FilledVolume {
    case empty
    case full
    case part(val: Double)
}

// Протокол Car
protocol Car {
    
    var mark: String { get }
    var year: Int { get }
    
    var trunkVolume: Double { get }
    var filledVolume: FilledVolume { get set }
    
    var engineState: EngineState { get set }
    var windowState: WindowState { get set }
}

// Расширение протокола Car методами
extension Car {
    
    mutating func engineAction(state: EngineState)
    {
        switch state {
        case .on:
            self.engineState = .on
        case .off:
            self.engineState = .off
        }
    }
    
    mutating func windowAction(state: WindowState)
    {
        switch state {
        case .on:
            self.windowState = .on
        case .off:
            self.windowState = .off
        }
    }
    
    func getValueVolume() -> Double {
        
        var value: Double
        
        switch self.filledVolume {
        case .full:
            value = self.trunkVolume
        case let .part(val):
            value = val
        default:
            value = 0
        }
        
        return value
    }
}

// Класс SportCar на основе протокола Car
class SportCar: Car {
    
    let mark: String
    let year: Int
    let trunkVolume: Double
    
    var filledVolume: FilledVolume
    var engineState: EngineState
    var windowState: WindowState
    
    // Доп. свойства
    var hatchState: HatchState
    let maxSpeed: Double
    
    init(mark: String, year: Int, trunkVolume: Double, maxSpeed: Double)
    {
        self.mark = mark
        self.year = year
        self.trunkVolume = trunkVolume
        
        self.filledVolume = .empty
        self.engineState = .off
        self.windowState = .off
        
        self.hatchState = .off
        self.maxSpeed = maxSpeed
        
        func hatchAction(state: HatchState)
        {
            switch state {
            case .on:
                self.hatchState = .on
            case .off:
                self.hatchState = .off
            }
        }
    }
}

// Класс TrunkCar на основе протокола Car
class TrunkCar: Car {
    
    let mark: String
    let year: Int
    let trunkVolume: Double
    
    var filledVolume: FilledVolume
    var engineState: EngineState
    var windowState: WindowState
    
    // Доп. свойства
    let maxLoadCapacity: Double
    
    init(mark: String, year: Int, trunkVolume: Double, maxLoadCapacity: Double)
    {
        self.mark = mark
        self.year = year
        self.trunkVolume = trunkVolume
        
        self.filledVolume = .empty
        self.engineState = .off
        self.windowState = .off
        
        self.maxLoadCapacity = maxLoadCapacity
    }
}

extension SportCar: CustomStringConvertible {
    var description: String {
        return
            "Легковой автомобиль: \(self.mark). " +
            "Год: \(self.year). " +
            "Загруженность багажника: \(getValueVolume()) из \(self.trunkVolume). " +
            "Двигатель: \(self.engineState.rawValue). " +
            "Окна: \(self.windowState.rawValue). " +
            "Люк: \(self.hatchState.rawValue). " +
            "Максимальная скорость: \(self.maxSpeed)."
    }
}

extension TrunkCar: CustomStringConvertible {
    var description: String {
        return
            "Грузовой автомобиль: \(self.mark). " +
            "Год: \(self.year). " +
            "Загруженность кузова: \(getValueVolume()) из \(self.trunkVolume). " +
            "Двигатель: \(self.engineState.rawValue). " +
            "Окна: \(self.windowState.rawValue). " +
            "Максимальная грузоподъемность: \(self.maxLoadCapacity)."
    }
}

var SportCarAudi = SportCar(mark: "Audi", year: 2020, trunkVolume: 20, maxSpeed: 300)
var TrunkCarVolvo = TrunkCar(mark: "Volvo", year: 2015, trunkVolume: 300, maxLoadCapacity: 4000)

SportCarAudi.engineAction(state: .on)
SportCarAudi.windowAction(state: .on)
SportCarAudi.filledVolume = .full

TrunkCarVolvo.engineAction(state: .on)
TrunkCarVolvo.filledVolume = .part(val: 250)

print(SportCarAudi)
print(TrunkCarVolvo)
