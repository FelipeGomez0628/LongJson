//
//  NetworkManager.swift
//  JsonLongWay
//
//  Created by Consultant on 7/12/22.
//

import Foundation

class NetworkManager {
    typealias JSONDirect = [String: Any]
    //retorn pokemon Optional
    func getPokemonManually() -> Pokemon? {
        
        guard let path = Bundle.main.path(forResource: "SampleJSONDragon", ofType: "json") else { return nil }
        
        do{
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let jsonObj = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
            guard let baseDict = jsonObj as? [String: Any] else { return nil }
            return parsePokemonManually(base: baseDict)
        } catch {
            print(error)
        }
        
        return nil
    }
    
   
    private func parsePokemonManually(base: JSONDirect) -> Pokemon? {
        
        
        //Damage
        
        guard let damageRelationArr = base["damage_relations"] as? JSONDirect else { return nil }
        
        guard let doubleDamageFromData = damageRelationArr["double_damage_from"] as? [JSONDirect] else { return nil }
                var doubleDamageFrom = [NameLink]()
                    doubleDamageFromData.forEach { data in
                    guard let damage = self.createNameLink(dict: data) else { return }
                    doubleDamageFrom.append(damage)
                }
        
        guard let doubleDamageToData = damageRelationArr["double_damage_to"] as? [JSONDirect] else {
            return nil
        }
                var doubleDamageTo = [NameLink]()
                    doubleDamageToData.forEach { data in
                    guard let damage = self.createNameLink(dict: data) else { return }
                    doubleDamageTo.append(damage)
        }
        
        
        guard let halfDamageFromData = damageRelationArr["half_damage_from"] as? [JSONDirect] else {
            return nil
        }
                var halfDamageFrom = [NameLink]()
                    halfDamageFromData.forEach { data in
                        guard let damage = self.createNameLink(dict: data) else { return }
                        halfDamageFrom.append(damage)
        }
        
        guard let halfDamageToData = damageRelationArr["half_damage_to"] as? [JSONDirect] else {
            return nil
        }
                var halfDamageTo = [NameLink]()
                    halfDamageToData.forEach { data in
                        guard let damage = self.createNameLink(dict: data) else { return }
                        halfDamageTo.append(damage)
        
        }
        
        guard let noDamageFromData = damageRelationArr["no_damage_from"] as? [JSONDirect] else {
            return nil
        }
                var noDamageFrom = [NameLink]()
                noDamageFromData.forEach { data in
                guard let damage = self.createNameLink(dict: data) else { return }
                    noDamageFrom.append(damage)
        }
        
        guard let noDamageToData = damageRelationArr["no_damage_to"] as? [JSONDirect] else {
            return nil
        }
        
                var noDamageTo = [NameLink]()
                noDamageToData.forEach { data in
                    guard let damage = self.createNameLink(dict: data) else { return }
                    noDamageTo.append(damage)
        }
        
        let damageRelations = Damage(double_damage_from: doubleDamageFrom, double_damage_to: doubleDamageTo, half_damage_from: halfDamageFrom, half_damage_to: halfDamageTo, no_damage_from: noDamageFrom, no_damage_to: noDamageTo)
        
        //Game Indices
        
        guard let gameIndicesArr = base["game_indices"] as? [JSONDirect] else { return nil }
        var finalGameIndices: [GameIndex] = []
        gameIndicesArr.forEach{ value in
            guard let gameIndex = value["game_index"] as? Int else { return }
            guard let version = value["version"] as? JSONDirect else { return }
            guard let returnVersion = self.createNameLink(dict: version) else { return }
            finalGameIndices.append(GameIndex(gameIndex: gameIndex, version: returnVersion))
        }
        
        //Generation
        
        guard let generationArr = base["generation"] as? JSONDirect else { return nil }
        guard let generation = self.createNameLink(dict: generationArr) else {return nil}
        
        //ID
        guard let id = base["id"] as? Int else { return nil }
        
        //MoveDamage
        
        guard let movesDamagesArr = base["move_damage_class"] as? JSONDirect else { return nil }
        guard let moveDamageClass = self.createNameLink(dict: movesDamagesArr) else { return nil }
        
        //Moves
        
        guard let movesArr = base["moves"] as? [JSONDirect] else { return nil }
        var finalMoves: [NameLink] = []
        movesArr.forEach { value in
            guard let moves = self.createNameLink(dict: value) else { return }
            finalMoves.append(moves)
        }
        
        //Name
        
        guard let name = base["name"] as? String else { return nil }
        
        
        // Pokemon
        
        guard let pokeArr = base["pokemon"] as? [JSONDirect] else { return nil }
        var allPokemon: [Poke] = []
        pokeArr.forEach{ value in
            guard let pokemon = value["pokemon"] as? JSONDirect else { return }
            guard let slots = value["slot"] as? Int else { return }
            guard let returnPokemon = self.createNameLink(dict: pokemon) else { return }
            allPokemon.append(Poke(POkemon: returnPokemon, slot: slots))
        }
        
        
        
        
        
            return Pokemon(damage_relations: damageRelations, game_indices: finalGameIndices, generation: generation, id: id, move_damage_class: moveDamageClass, moves: finalMoves, name: name, pokemon: allPokemon)}


    private func createNameLink(dict: [String: Any]) -> NameLink? {
        guard let name = dict["name"] as? String else { return nil }
        guard let url = dict["url"] as? String else { return nil }
        return NameLink(name: name, url: url)
        
        }
    
}

