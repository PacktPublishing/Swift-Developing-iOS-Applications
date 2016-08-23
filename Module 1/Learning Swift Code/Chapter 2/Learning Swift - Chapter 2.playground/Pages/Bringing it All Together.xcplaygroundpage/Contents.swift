//: [Previous](@previous)

//: Bringing it All Together - Generate Party Invites
//: ==================================================

//: Import Foundation so that "rand" can be used
import Foundation

//: Input Data
//: -----------------------------

//: invitees
//:
//: Each element is a tuple which contains a name
//: that is a String and a Bool for if they have been
//: invited yet. It is a variable because we will be
//: tracking if each invitee has been invited yet.
var invitees = [
    (name: "Sarah", alreadyInvited: false),
    (name: "Jamison", alreadyInvited: false),
    (name: "Marcos", alreadyInvited: false),
    (name: "Roana", alreadyInvited: false),
    (name: "Neena", alreadyInvited: false),
]

//: showsByGenre
//:
//: Constant because we will not need to modify
//: the show list at all
let showsByGenre = [
    "Comedy": "Modern Family",
    "Drama": "Breaking Bad",
    "Variety": "The Colbert Report",
]

//: Helper functions
//: -----------------------------

//: inviteAtIndex:toBringShow:
//:
//: Another function to help make future code
//: more comprehensible and maintainable
func inviteAtIndex
    (
    index: Int,
    toBringShow show: (genre: String, name: String)
    )
{
    let name = invitees[index].name
    print("\(name), bring a \(show.genre) show")
    print("\(show.name) is a great \(show.genre)")

    invitees[index].alreadyInvited = true
}

//: inviteToBringThemselvesAtIndex:
//:
//: Similar to the previous function but this time for
// the remaining invitees
func inviteToBringThemselvesAtIndex(index: Int) {
    let invitee = invitees[index]
    print("\(invitee.name), just bring yourself")

    invitees[index].alreadyInvited = true
}

//: Now the core logic
//: -----------------------------

//: Seed the random number generator
srand(UInt32(clock()))

//: First, we want to make sure each genre is assigned
//: to an invitee
for show in showsByGenre {
    // We need to pick a random invitee that has not
    // already been invited. With the following loop
    // we will continue to pick an invitee until we
    // find one that has not already been invited
    var inviteeIndex: Int
    repeat {
        inviteeIndex = Int(rand()) % invitees.count
    } while invitees[inviteeIndex].alreadyInvited

    // Now that we have found an invitee that has not
    // been invited, we will invite them
    inviteAtIndex(inviteeIndex, toBringShow: (show))
}

//: Now that we have assigned each genre, we
//: will ask the remaining people to just bring
//: themselves
for index in 0 ..< invitees.count {
    let invitee = invitees[index]
    if !invitee.alreadyInvited {
        inviteToBringThemselvesAtIndex(index)
    }
}
