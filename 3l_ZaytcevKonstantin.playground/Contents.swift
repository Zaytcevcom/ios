import UIKit

enum EngineState: String {
    case on = "Включен"
    case off = "Выключен"
}

enum EngineAction {
    case start, stop
}

enum WindowState: String {
    case on = "Открыты"
    case off = "Закрыты"
}

enum WindowAction {
    case open, close
}

enum FilledVolume {
    case empty
    case full
    case part(val: Double)
}

struct SportCar {
    
    let mark: String
    let year: Int
    
    let trunkVolume: Double
    var filledVolume: FilledVolume
    
    var engineState: EngineState
    var windowState: WindowState
    
    mutating func engineAction(action: EngineAction)
    {
        switch action {
        case .start:
            self.engineState = .on
        case .stop:
            self.engineState = .off
        }
    }
    
    mutating func windowAction(action: WindowAction)
    {
        switch action {
        case .open:
            self.windowState = .on
        case .close:
            self.windowState = .off
        }
    }
    
    func info()
    {
        var value: Double
        
        switch self.filledVolume {
        case .full:
            value = self.trunkVolume
        case let .part(val):
            value = val
        default:
            value = 0
        }
        
        print(
            "Легковой автомобиль: \(self.mark).",
            "Загруженность багажника: \(value) из \(self.trunkVolume).",
            "Двигатель: \(self.engineState.rawValue).",
            "Окна: \(self.windowState.rawValue)."
        );
    }
}

struct TrunkCar {
    
    let mark: String
    let year: Int
    
    let bodyVolume: Double
    var filledVolume: FilledVolume
    
    var engineState: EngineState
    var windowState: WindowState
    
    mutating func engineAction(action: EngineAction)
    {
        switch action {
        case .start:
            self.engineState = .on
        case .stop:
            self.engineState = .off
        }
    }
    
    mutating func windowAction(action: WindowAction)
    {
        switch action {
        case .open:
            self.windowState = .on
        case .close:
            self.windowState = .off
        }
    }
    
    func info()
    {
        var value: Double
        
        switch self.filledVolume {
        case .full:
            value = self.bodyVolume
        case let .part(val):
            value = val
        default:
            value = 0
        }
                
        print(
            "Грузовой автомобиль: \(self.mark).",
            "Загруженность кузова: \(value) из \(self.bodyVolume).",
            "Двигатель: \(self.engineState.rawValue).",
            "Окна: \(self.windowState.rawValue)."
        );
    }
}

var SportCarAudi = SportCar(mark: "Audi", year: 2018, trunkVolume: 20, filledVolume: .part(val: 10), engineState: .off, windowState: .off)
var SportCarBmw = SportCar(mark: "Bmw", year: 2020, trunkVolume: 15, filledVolume: .full, engineState: .on, windowState: .off)

print("Init sport cars:");
SportCarAudi.info()
SportCarBmw.info()

print("\r\nAfter actions:")
SportCarAudi.engineAction(action: .start)
SportCarAudi.filledVolume = .part(val: 12)
SportCarAudi.windowAction(action: .open)
SportCarAudi.info()

print("\r\n\r\n")

var TrunkCarVolvo = TrunkCar(mark: "Volvo", year: 2010, bodyVolume: 200, filledVolume: .part(val: 170), engineState: .on, windowState: .on)
var TrunkCarKamaz = TrunkCar(mark: "Kamaz", year: 2015, bodyVolume: 200, filledVolume: .full, engineState: .on, windowState: .off)

print("Init trunk cars:");
TrunkCarVolvo.info()
TrunkCarKamaz.info()

print("\r\nAfter actions:")
TrunkCarVolvo.engineAction(action: .stop)
TrunkCarVolvo.filledVolume = .empty
TrunkCarVolvo.windowAction(action: .close)
TrunkCarVolvo.info()
