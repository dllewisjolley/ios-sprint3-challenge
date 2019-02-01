//
//  PokemonController.swift
//  DianteSprint3PokeMon
//
//  Created by Diante Lewis-Jolley on 2/1/19.
//  Copyright © 2019 Diante Lewis-Jolley. All rights reserved.
//

import Foundation


class PokemonController {
    //Properties
    private(set) var pokemons: [Pokemon] = []
    private let baseUrl = URL(string: "https://pokeapi.co/api/v2/pokemon/")!

    func addPokemon(withName name: Pokemon) {
        pokemons.append(name)
    }
    func delete(name: Pokemon) {
        guard let index = pokemons.index(of: name) else { return }
        pokemons.remove(at: index)
    }

    func fetchPakemon(with searchWord: String, completion: @escaping (Pokemon?, Error?) -> Void) {
        let url = baseUrl.appendingPathComponent(searchWord.lowercased())
        let urlRequest = URLRequest(url: url)

        URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let data = data else {
                completion(nil, NSError())
                return
            }
            do {
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                completion(pokemon, nil)
            } catch {
                completion(nil, error)
                return
            }
        } .resume()
    }
}