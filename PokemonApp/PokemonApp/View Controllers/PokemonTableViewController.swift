//
//  PokemonTableViewController.swift
//  PokemonApp
//
//  Created by Diante Lewis-Jolley on 5/17/19.
//  Copyright © 2019 Diante Lewis-Jolley. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {

    let pokemonController = PokemonController()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        tableView.reloadData()
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemonController.pokeDex.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        let pokemon = pokemonController.pokeDex[indexPath.row]

        cell.textLabel?.text = pokemon.name

        return cell
    }




    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let pokemon = pokemonController.pokeDex[indexPath.row]
            pokemonController.deletePokemon(pokemon: pokemon)

            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*/ Alternative Segue
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if let DetailVC  = self.storyboard?.instantiateViewController(withIdentifier: "DetailVC") as? DetailViewController {
            DetailVC.pokemon = pokemonController.pokeDex[indexPath.row]
            navigationController?.pushViewController(DetailVC, animated: true)
        }
        // let detailVc = DetailViewController()

        //navigationController?.present(detailVc, animated: true)
    }

 */



    //Segue wasn't working correctly. Pokemon came back nil
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.

        if segue.identifier == "DetailSegue" {
            guard let DetailVC = segue.destination as? DetailViewController,
            let indexPath = tableView.indexPathForSelectedRow else { return }
            let pokemon = pokemonController.pokeDex[indexPath.row]
            DetailVC.pokemonController = pokemonController
            DetailVC.pokemon = pokemon
            

        }


    }



}
