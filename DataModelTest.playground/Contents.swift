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

protocol MonsterProtocol: Mob {
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

struct Monster: MonsterProtocol {
    var type: MonsterType
    var movementPoints: Int
    var hitPoints: Int
    var damageDealt: Int
    var damageAbsorbed: Int
    var id: Int

    init(type: MonsterType) {
        self.type = type
        switch type {
        case .mouse:
            self.movementPoints = 1
            self.hitPoints = 2
            self.damageDealt = 1
            self.damageAbsorbed = 0
            self.id = 0
        case .goblin:
            self.movementPoints = 2
            self.hitPoints = 4
            self.damageDealt = 3
            self.damageAbsorbed = 1
            self.id = 1
        case .skeleton:
            self.movementPoints = 3
            self.hitPoints = 10
            self.damageDealt = 5
            self.damageAbsorbed = 2
            self.id = 2
        }
    }

    var name: String {
        "\(type.rawValue) with \(movementPoints) movement points"
    }
}


/*

 Project idea 1: Implement a Protocol Oriented Inventory System
    Stretch: Implement id system so that id is always unique

 Project idea 2: Implement SpriteKit, find free sprites to use, and make the player fight a monster visually
    Alternate: Have the monsters fight only in text, but show a representation of it by animating the text on the screen
    Stretch: Implement health bars that track the player and monster's health

 Project idea 3: Implement an opt-in PVP system where PVP players can fight PVP players, but non-PVP players and PVP players can't fight each other
    Stretch: Non-PVP Players can opt in to duel another player (PVP or non-PVP) - but only those 2 players can fight each other. Nobody else can interrupt

 */
