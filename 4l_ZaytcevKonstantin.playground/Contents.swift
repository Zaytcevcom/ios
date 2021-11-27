import UIKit

class Car {
    
    let mark: String
    let year: Int
    
    let trunkVolume: Double
    var filledVolume: FilledVolume = .empty
    
    var engineState: EngineState = .off
    var windowState: WindowState = .off
    var hatchState: HatchState?
    
    init(mark: String, year: Int, trunkVolume: Double)
    {
        self.mark = mark
        self.year = year
        self.trunkVolume = trunkVolume
    }
    
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
    
    enum HatchState: String {
        case on = "Люк открыт"
        case off = "Люк закрыт"
    }

    enum HatchAction {
        case open, close
    }
    
    func HatchAction(action: HatchAction)
    {
        switch action {
        case .open:
            self.hatchState = .on
        case .close:
            self.hatchState = .off
        }
    }
    
    enum Action {
        case EngineAction(EngineState)
        case WindowAction(WindowState)
        case HatchAction(HatchState)
    }
    
    func doAction(action: Action)
    {
        // empty
    }
    
    func engineAction(action: EngineAction)
    {
        switch action {
        case .start:
            self.engineState = .on
        case .stop:
            self.engineState = .off
        }
    }
    
    func windowAction(action: WindowAction)
    {
        switch action {
        case .open:
            self.windowState = .on
        case .close:
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
    
    func info()
    {
        // empty
    }
}

class SportCar: Car {
    
    let maxSpeed: Double
    
    init(mark: String, year: Int, trunkVolume: Double, maxSpeed: Double) {
        self.maxSpeed = maxSpeed
        super.init(mark: mark, year: year, trunkVolume: trunkVolume)
        self.hatchState = .off
    }
    
    override func doAction(action: Action) {
        switch action {
        case .EngineAction(let status):
            engineState = status
        case .WindowAction(let status):
            windowState = status
        case .HatchAction(let status):
            hatchState = status
        }
    }
    
    override func info()
    {
        print(
            "Легковой автомобиль: \(self.mark).",
            "Год: \(self.year)",
            "Загруженность багажника: \(getValueVolume()) из \(self.trunkVolume).",
            "Двигатель: \(self.engineState.rawValue).",
            "Окна: \(self.windowState.rawValue).",
            "Люк: \(self.hatchState!.rawValue).",
            "Максимальная скорость: \(self.maxSpeed)."
        );
    }
}

class TrunkCar: Car {
    
    let maxLoadCapacity: Double
    
    init(mark: String, year: Int, trunkVolume: Double, maxLoadCapacity: Double) {
        self.maxLoadCapacity = maxLoadCapacity
        super.init(mark: mark, year: year, trunkVolume: trunkVolume)
    }
    
    override func doAction(action: Action) {
        switch action {
        case .EngineAction(let status):
            engineState = status
        case .WindowAction(let status):
            windowState = status
        default:
            break
        }
    }
    
    override func info()
    {
        print(
            "Грузовой автомобиль: \(self.mark).",
            "Год: \(self.year)",
            "Загруженность кузова: \(getValueVolume()) из \(self.trunkVolume).",
            "Двигатель: \(self.engineState.rawValue).",
            "Окна: \(self.windowState.rawValue).",
            "Максимальная грузоподъемность: \(self.maxLoadCapacity)."
        );
    }
}

var SportCarAudi = SportCar(mark: "Audi", year: 2018, trunkVolume: 20, maxSpeed: 300)
var SportCarBmw = SportCar(mark: "Bmw", year: 2020, trunkVolume: 15, maxSpeed: 280)

print("Init sport cars:");
SportCarAudi.info()
SportCarBmw.info()

print("\r\nAfter actions:")
SportCarAudi.doAction(action: .EngineAction(.on))
SportCarAudi.doAction(action: .WindowAction(.on))
SportCarAudi.doAction(action: .HatchAction(.on))
SportCarAudi.info()

print("\r\n\r\n")

var TrunkCarVolvo = TrunkCar(mark: "Volvo", year: 2012, trunkVolume: 300, maxLoadCapacity: 3500)
var TrunkCarKamaz = TrunkCar(mark: "Kamaz", year: 2010, trunkVolume: 200, maxLoadCapacity: 3000)

print("Init trunk cars:");
TrunkCarVolvo.info()
TrunkCarKamaz.info()
