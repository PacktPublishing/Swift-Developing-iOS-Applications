//: [Previous](@previous)

import Foundation

//: List of people to invite
let invitees = [
    "Sarah",
    "Jamison",
    "Marcos",
    "Roana",
    "Neena",
]

//: Dictionary of shows organized by genre
var showsByGenre = [
    "Comedy": "Modern Family",
    "Drama": "Breaking Bad",
    "Variety": "The Colbert Report",
]

//: Function to pick and then remove a random genre from showsByGenre
func pickAndRemoveRandomGenre() -> (genre: String, example: String)? {
    let genres = Array(showsByGenre.keys)
    guard genres.count > 0 else {
        return nil
    }

    let genre = genres[Int(rand()) % genres.count]
    let example = showsByGenre[genre]!
    showsByGenre[genre] = nil
    return (genre: genre, example: example)
}

//: Shuffle the order of the passed in array
func shuffle(array: [String]) -> [String] {
    return array
        .map({ ($0, Int(rand())) })
        .sort({ $0.1 < $1.1 })
        .map({$0.0})
}

//: Seed the random number generator
srand(UInt32(clock()))

//: Map the invitees list to a list of invitations and then
//: join them with new line characters
let invitations: [String] = shuffle(invitees)
.map({ name in
    guard let (genre, example) = pickAndRemoveRandomGenre() else {
        return "\(name), just bring yourself"
    }
    return "\(name), bring a \(genre) show"
        + "\n\(example) is a great \(genre)"
})

//: Print result
print(invitations.joinWithSeparator("\n"))
