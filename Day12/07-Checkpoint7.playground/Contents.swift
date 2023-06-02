import Cocoa

class Animal {
    let numberOfLegs: Int
    
    init (numberOfLegs: Int) {
        self.numberOfLegs = numberOfLegs
    }
}

class Dog : Animal {
    init() {
        super.init(numberOfLegs: 4)
    }
    
    func speak() {
        print("Bark")
    }
}

final class Corgi : Dog {
    override func speak() {
        print("Bark at the Queen")
    }
}

final class Poodle : Dog {
    override func speak() {
        print("I am a poodle, bark")
    }
}

class Cat : Animal {
    var isTame: Bool
    init(isTame: Bool) {
        self.isTame = isTame
        super.init(numberOfLegs: 4)
    }
    
    func speak() {
        print("Meow")
    }
}

final class Persian : Cat {
    override func speak() {
        print("Persian")
    }
}

final class Lion : Cat {
    init() {
        super.init(isTame: false)
    }
    
    override func speak() {
        print("Roar")
    }
}
