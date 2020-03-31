import Foundation

/*
 Scenario, multiplayer game where players can fight monsters, monsters can fight players, but players can't fight other players.

 Stretch: PVP players can fight PVP players, but  non-PVP players can only fight monsters

 */

import Foundation

protocol IDAble {
    var id: Int { get }
}

protocol Nameable {
    var name: String { get }
}

protocol LoginUser: IDAble, Nameable {
    var email: String { get set }
    var password: String { get set }
    var phone: Int? { get set }
    var birthday: Date? { get }
}

protocol RemoteUser: IDAble {
    var username: String { get }
}

protocol Mob: Fightable, IDAble, Nameable {
    var movementPoints: Int { get set }
}

protocol Fightable {
    var hitPoints: Int { get set }
    var damageDealt: Int { get set }
    var damageAbsorbed: Int { get set }
}

protocol PlayerProtocol: LoginUser, Mob {
    var magicPoints: Int { get set }
    var experience: Int { get set }
}

enum MonsterType: String {
    case mouse = "A Mouse"
    case goblin = "A Goblin"
    case skeleton = "A Skeleton"
}

protocol MonsterProtocol: Mob {
    var type: MonsterType { get set }
}

struct Player: PlayerProtocol {
    var magicPoints: Int
    var experience: Int
    var email: String
    var password: String
    var phone: Int?
    var birthday: Date?
    var movementPoints: Int
    var id: Int
    var name: String
    var hitPoints: Int
    var damageDealt: Int
    var damageAbsorbed: Int
}

struct RemotePlayer: RemoteUser {
    var username: String
    var id: Int
}

struct Monster: MonsterProtocol {
    var movementPoints: Int

    var id: Int

    var name: String {
        type.rawValue
    }

    var type: MonsterType

    var hitPoints: Int

    var damageDealt: Int

    var damageAbsorbed: Int

    init(type: MonsterType) {
        self.type = type
        switch type {
        case .mouse:
            self.id = 01
            self.hitPoints = 2
            self.damageDealt = 1
            self.damageAbsorbed = 1
            self.movementPoints = 1
        case .goblin:
            self.id = 02
            self.hitPoints = 4
            self.damageDealt = 2
            self.damageAbsorbed = 3
            self.movementPoints = 5
        case .skeleton:
            self.id = 03
            self.hitPoints = 10
            self.damageDealt = 5
            self.damageAbsorbed = 5
            self.movementPoints = 4
        }
    }
}

let goblin = Monster(type: .goblin)
let player = Player(magicPoints: 10,
                    experience: 100,
                    email: "me@me.com",
                    password: "123456",
                    phone: nil,
                    birthday: nil,
                    movementPoints: 10,
                    id: 9001,
                    name: "froggomad",
                    hitPoints: 100,
                    damageDealt: 10,
                    damageAbsorbed: 3)
let user = RemotePlayer(username: "OtherUser", id: 1)

var mobs: [Mob] = [
    goblin,
    player
]

print(mobs)

/*

 Project idea 1: Implement a Protocol Oriented Inventory System
    Stretch: Implement id system so that id is always unique

 Project idea 2: Implement SpriteKit, find free sprites to use, and make the player fight a monster visually
    Alternate: Have the monsters fight only in text, but show a representation of it by animating the text on the screen
    Stretch: Implement health bars that track the player and monster's health

 Project idea 3: Implement an opt-in PVP system where PVP players can fight PVP players, but non-PVP players and PVP players can't fight each other
    Stretch: Non-PVP Players can opt in to duel another player (PVP or non-PVP) - but only those 2 players can fight each other. Nobody else can interrupt

 */
