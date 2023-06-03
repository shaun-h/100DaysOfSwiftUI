import Cocoa


func getInt(_ numbers: [Int]?) -> Int { numbers?.randomElement() ?? Int.random(in: 1...100) }

print(getInt([]))
