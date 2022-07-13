//
//  Pokemon.swift
//  JsonLongWay
//
//  Created by Consultant on 7/12/22.
//

import Foundation


struct Pokemon {
    
    let damage_relations : Damage
    let game_indices : [GameIndex]
    let generation : NameLink
    let id : Int
    let move_damage_class : NameLink
    let moves : [NameLink]
    let name : String
    let pokemon : [Poke]
    
    
    
}

struct Damage{
    let double_damage_from: [NameLink]
    let double_damage_to: [NameLink]
    let half_damage_from: [NameLink]
    let half_damage_to: [NameLink]
    let no_damage_from: [NameLink]
    let no_damage_to: [NameLink]
}

struct NameLink{
    let name: String
    let url: String
    
}

struct GameIndex {
    let gameIndex : Int
    let version : NameLink
}


struct Poke {
    let POkemon: NameLink
    let slot: Int
}

