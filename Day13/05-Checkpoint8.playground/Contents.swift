import Cocoa

protocol Building {
    var rooms: Int { get }
    var cost: Int { get }
    var agent: String { get }
    
    func printSalesSummary() -> Void
}

extension Building  {
    func printSalesSummary() {
        print("Building sold by \(agent) for \(cost), it has \(rooms) room(s)")
    }
}


struct Office : Building {
    var rooms: Int
    var cost: Int
    var agent: String
}

struct House: Building {
    var rooms: Int
    var cost: Int
    var agent: String
}

