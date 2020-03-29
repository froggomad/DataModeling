import Foundation

/*
 Scenario, multiplayer game where players can fight monsters, monsters can fight players, but players can't fight other players.

 Stretch: PVP players can fight PVP players, but  non-PVP players can only fight monsters

 */

protocol LoginUser: Identifiable {
    var password: String { get set }
    var email: String { get set }
    var phone: Int? { get set }
    var birthday: Date? { get }
}

protocol User: Identifiable, Nameable {
    // Doesn't need to be considered Mob from our point of view, because we aren't concerned with how fast they move.
    // We could get updates on their position without having to calculate their speed
    var firstName: String? { get set }
    var lastName: String? { get set }
    var username: String { get }
}

protocol Mob: Fightable, Identifiable, Nameable {
    var movementPoints: Int { get set } //in a turn-based game, this could be movement points, in a real time game, this could be movement speed
}

protocol Player: LoginUser, User, Mob {
    var magicPoints: Int { get set }
    var experience: Int { get set }
}

protocol Monster: Mob {
    var type: MonsterType { get }
}

protocol Identifiable {
    var id: Int { get }
}

protocol Nameable: CustomStringConvertible {
    //var description: String { get } <---- Comes with CustomStringConvertible (this isn't meant to be "exposed" -  it's for use in the compiler)
    var name: String { get } // <--- but we can use this for public access, and create an extension so that description mirrors name
    // This isn't always helpful or best practice and isn't necessarily even useful in this case...
    // Just another example of some implementation you can do with protocol extensions
}

extension Nameable {
    var description: String {
        name
    }
}

protocol Fightable {
    var hitPoints: Int { get set }
    var damageDealt: Int { get set }
    var damageAbsorbed: Int { get set }
}

enum MonsterType: String {
    case mouse = "A Mouse"
    case goblin = "A Goblin"
    case skeleton = "A Skeleton"
}


struct CurrentPlayer: Player {
    var birthday: Date?
    var damageDealt: Int
    var damageAbsorbed: Int
    var email: String
    var experience: Int
    var firstName: String?
    var hitPoints: Int
    var id: Int
    var lastName: String?
    var magicPoints: Int
    var movementPoints: Int
    var password: String
    var phone: Int?
    var username: String

    var name: String {
        "\(username) with \(movementPoints) movement points"
    }
}

struct OtherPlayer: User {
    var firstName: String?
    var lastName: String?
    var username: String
    var id: Int

    var name: String {
        "\(username)"
    }
}

struct Goblin: Monster {
    var type: MonsterType = .goblin
    var movementPoints: Int = 2
    var hitPoints: Int = 5
    var damageDealt: Int = 1
    var damageAbsorbed: Int = 0
    var id: Int

    var name: String {
        "\(type.rawValue) with \(movementPoints) movement points"
    }
}


/*

 Project idea 1: Implement a Protocol Oriented Inventory System

 Project idea 2: Implement SpriteKit, find free sprites to use, and make the player fight a monster

 Project idea 3: Implement an opt-in PVP system where PVP players can fight PVP players, but non-PVP players and PVP players can't fight each other


 */
