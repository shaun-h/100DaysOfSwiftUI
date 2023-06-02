import Cocoa
enum GearDirection {
    case up, down
}

struct Car {
    private let model:String
    private let numberOfSeats:Int
    private(set) var currentGear:Int
    
    init(model: String, numberOfSeats: Int) {
        self.model = model
        self.numberOfSeats = numberOfSeats
        self.currentGear = 1
    }
    
    mutating func ChangeGear(direction: GearDirection) {
        switch direction {
        case .up:
            if currentGear < 10 {
                currentGear += 1
            }
        case .down:
            if currentGear > 1 {
                currentGear -= 1
            }
        }
    }
}

var car = Car(model: "Ford", numberOfSeats: 5)

print(car.currentGear)

car.ChangeGear(direction: .down)
print(car.currentGear)
car.ChangeGear(direction: .up)
print(car.currentGear)
car.ChangeGear(direction: .up)
print(car.currentGear)
car.ChangeGear(direction: .up)
print(car.currentGear)
car.ChangeGear(direction: .up)
print(car.currentGear)
car.ChangeGear(direction: .up)
print(car.currentGear)
car.ChangeGear(direction: .up)
print(car.currentGear)
car.ChangeGear(direction: .up)
print(car.currentGear)
car.ChangeGear(direction: .up)
print(car.currentGear)
car.ChangeGear(direction: .up)
print(car.currentGear)
car.ChangeGear(direction: .up)
print(car.currentGear)
car.ChangeGear(direction: .down)
print(car.currentGear)
