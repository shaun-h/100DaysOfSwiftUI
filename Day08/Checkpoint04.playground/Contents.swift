import Cocoa

enum SquareRootError: Error {
    case OutOfBounds
    case NoRoot
}

func squareRoot(number: Int) throws -> Int {
    if number < 1 || number > 10_000 {
        throw SquareRootError.OutOfBounds
    }
    
    var found = false
    
    var i = 0
    
    while !found {
        i += 1;
        var toCheck = i * i
        if toCheck > number {
            throw SquareRootError.NoRoot
        }
        
        found = toCheck == number;
    }
    
    return i
}

do {
    print(try squareRoot(number: 10000))
}
catch SquareRootError.OutOfBounds {
    print("Must be between 1 and 10000")
}
catch SquareRootError.NoRoot {
    print("Unable to calculate int square root")
}
catch {
    print("Unknown error: \(error.localizedDescription)")
}

