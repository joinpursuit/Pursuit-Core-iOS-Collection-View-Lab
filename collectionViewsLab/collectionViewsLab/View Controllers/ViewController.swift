//
//  ViewController.swift
//  collectionViewsLab
//
//  Created by Sam Roman on 9/26/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var countryCollection: UICollectionView!
    
    var countries = [Countries]() {
        didSet {
            countryCollection.reloadData()
        }
    }
    
    var searchString: String? {
        didSet {
            loadSearch(str: searchString ?? "United")
        }
    }
    
    
    
    //MARK:Private Methods
    private func loadSearch(str: String){
        CountryAPIClient.shared.fetchData(searchStr: str) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let data):
                    self.countries = data
                }
            }
        }
        
    }
    
    override func viewDidLoad() {
        loadSearch(str: "United")
        countryCollection.delegate = self
        countryCollection.dataSource = self
        searchBar.delegate = self
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    

}


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let country = countries[indexPath.row]
        guard let cell = countryCollection.dequeueReusableCell(withReuseIdentifier: "countryCell", for: indexPath) as? CountryCollectionViewCell else { return UICollectionViewCell() }
        cell.capital.text = "Capital: \(country.capital)"
        cell.name.text = country.name
        cell.population.text = "Pop: \(country.population)"
        ImageHelper.shared.fetchImage(urlString: country.imageURL) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let flag):
                    cell.flagImage.image = flag
                case .failure(let error):
                    print(error)
                }
            }
            }.self
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 374, height: 347)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedCell = sender as! CountryCollectionViewCell
        let index = (countryCollection.indexPath(for: selectedCell)?.row)!
        if segue.identifier == "countrySegue" {
            let destination = segue.destination as! CountryDetailViewController
            destination.country = countries[index]
        }
    }
    
    
}

extension ViewController: UISearchBarDelegate {
     func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
           var searchTerm = searchBar.text ?? ""
           searchTerm = searchTerm.lowercased().replacingOccurrences(of: " ", with: "")
           loadSearch(str: searchTerm)
           print(searchTerm)
       }
}
