import Cocoa

var beatles = ["John", "Paul", "George", "Ringo"]
let numbers = [4, 8, 15, 16, 23, 42]
var temperatures = [25.3, 28.2, 26.4]

print(beatles[0])
print(numbers[1])
print(temperatures[2])

beatles.append("Arian")
beatles.append("Allen")
beatles.append("Vivian")

var scores = Array<Int>()
scores.append(100)
scores.append(150)
scores.append(70)
print(scores[1])


var albums = ["Red"]
albums.append("Hybrid Theory")
print(albums.count)


var characters = ["Lana", "Pam", "Ray"]
print(characters.count)
characters.remove(at: 0)
print(characters.count)
characters.removeAll()
print(characters.count)

print(albums.contains("Red"))
print(albums.sorted())
print(albums.reversed())
