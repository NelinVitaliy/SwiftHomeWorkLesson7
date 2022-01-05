//
//  main.swift
//  SwiftHomeWorkLesson7
//
//  Created by N3L1N on 05/01/2022.
//

import Foundation


enum dispensingMachineError: Error{
    case invalidItems
    case notEnoughMoney(coinsNeeded: Int)
    case outOfStock
}


struct Item {
    var cost:Int
    var count:Int
}



class DispensingMachine{
    var inventory = [
        "Cola":Item(cost: 4, count: 5),
        "Sprite":Item(cost: 3,count: 2),
        "Chocopay":Item(cost:2, count: 10),
        "Oreo":Item(cost: 5, count: 5),
    ]
    
    var coinsDeposit = 0
    
    func vend(itemNamed name: String) throws {
            guard let item = inventory[name] else {
                throw dispensingMachineError.invalidItems
            }

            guard item.count > 0 else {
                throw dispensingMachineError.outOfStock
            }

            guard item.cost <= coinsDeposit else {
                throw dispensingMachineError.notEnoughMoney(coinsNeeded: item.cost - coinsDeposit)
            }
        
            coinsDeposit -= item.cost

            var newItem = item
            newItem.count -= 1
            inventory[name] = newItem

            print("Dispensing \(name)")
            
            }
        
}

let snacks = [
    "Oleg": "Cola",
    "Petya": "Chocopay",
    "Eve": "Pretzels",
]

func buySnack(person: String, dispensingMachine: DispensingMachine)
    throws {
    let snacksName = snacks[person] ?? "Chocopay"
    try dispensingMachine.vend(itemNamed: snacksName)
}
    

struct PurchasedSnack {
    let name: String
    init(name: String, dispensingMachine: DispensingMachine) throws {
        try dispensingMachine.vend(itemNamed: name)
        self.name = name
    }
}

var dispensingMachine = DispensingMachine()
dispensingMachine.coinsDeposit = 10
do {
    try buySnack(person: "Oleg", dispensingMachine: dispensingMachine)
    print("Success!")
} catch dispensingMachineError.invalidItems {
    print("Invalid Items.")
} catch dispensingMachineError.outOfStock {
    print("Out of Stock.")
} catch dispensingMachineError.notEnoughMoney(let coinsNeeded) {
    print("Please insert an additional \(coinsNeeded) coins.")
} catch {
    print("Unexpected error: \(error).")
}

