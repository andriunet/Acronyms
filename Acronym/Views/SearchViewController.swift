//
//  SearchViewController.swift
//  Acronym
//
//  Created by Andres Marin on 26/03/21.
//

import UIKit
import Alamofire

class SearchViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
        
    var acronym: [Acronym]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    // MARK: - Funciones
    
    public func searchAcronym(search: String) {

        searchBar.cargando = true

        obtenerJson(url: "\(Endpoint.searchAcronym)\(search)") { (acronymSearch) in

            if let search = acronymSearch {
                self.acronym = search
                self.tableView.reloadData(efecto: .Roll)
                self.searchBar.cargando = false
            } else {
                self.searchBar.cargando = false
            }
            
        }
        
        
    }
    
    func obtenerJson(url: String, callback: @escaping (_ acronymSearch: [Acronym]?) -> ()) {
                
        AF.request(url, method: .get, encoding: JSONEncoding.default).responseString { response in

            guard let data = response.data else {
                callback(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let jsonResult = try decoder.decode([Acronym].self, from: data)
                self.tableView.reloadData()
                
                callback(jsonResult)
                
            } catch let error {
                print(error)
                callback(nil)
            }
        }
        
    }
    
    // MARK: - TableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let acronym = self.acronym, acronym.count > 0, let lfs = acronym[0].lfs {
                        
            if lfs.count == 0 {
                self.tableView.setMensajeVacio()
            } else {
                self.tableView.restaurar()
            }
            return lfs.count

        } else {
            self.tableView.setMensajeVacio()
            return 0
        }
    }

      
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "acronymCell")!
                  
        if let acronym = self.acronym, acronym.count > 0, let lfs = acronym[0].lfs {

            cell.textLabel?.text = lfs[indexPath.row].lf
            
            if let since = lfs[indexPath.row].since {
                cell.detailTextLabel?.text = "Since \(since)"
            } else {
                cell.detailTextLabel?.text = ""
            }
        }
        
        return cell
    
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK: - SearchBar
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let search = searchBar.text {
            searchAcronym(search: search)
        }
    }
    
}

