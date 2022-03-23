//
//  CharactersListViewController.swift
//  MarvelDemo
//
//  Created by Bhaswar Mukherjee on 12/03/22.
//

import UIKit

class CharactersListViewController: UIViewController {
    
    @IBOutlet weak private var tableView: UITableView!
    private var characterListViewModel = CharacterListViewModel()
    private var characterArray = [CharacterModel]()
    private var offset: Int = 0
    private var limit: Int = 0
    private var countofdata: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        offset = 0
        limit = 20
        
        configuration()
    }
}

extension CharactersListViewController
{
   private func configuration(){
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CharacterListCell", bundle: nil), forCellReuseIdentifier: "CharacterListCell")
        getAllCharacters(offset: offset , limit: limit)
    }
    
    private func getAllCharacters(offset: Int , limit: Int){
        characterListViewModel.getAllCharacters(offset: offset , limit: limit) { characterArray in
            
            self.characterArray.append(contentsOf: characterArray)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension CharactersListViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characterArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterListCell") as? CharacterListCell else { return UITableViewCell() }
        cell.model = characterArray[indexPath.row]
        return cell
    }
}

extension CharactersListViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        self.countofdata = APIHelper.shared.countofdata
        
        if self.offset > self.countofdata{
            return
        }

        tableView.addLoading(indexPath) {

            debugPrint("Startde")
            self.offset = self.offset + self.limit
            debugPrint(self.offset)
            self.getAllCharacters(offset: self.offset, limit: self.limit)
            debugPrint("Ended")
            tableView.stopLoading()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let CharacterDetailViewController = CharacterDetailViewController.shareInstace(){
            CharacterDetailViewController.characterDetailID = Int(characterArray[indexPath.row].id)
            CharacterDetailViewController.name = characterArray[indexPath.row].name
            CharacterDetailViewController.thumbnail = characterArray[indexPath.row].thumbnail
            CharacterDetailViewController.descriptionStr = characterArray[indexPath.row].description

            self.navigationController?.pushViewController(CharacterDetailViewController, animated: true)
        }
    }
}

