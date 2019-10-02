//
//  ViewController.swift
//  iOS-Collection-View-Lab
//
//  Created by Krystal Campbell on 9/27/19.
//  Copyright © 2019 Krystal Campbell. All rights reserved.
//

import UIKit

class CountryCollectionViewController: UIViewController, UICollectionViewDataSource, UISearchBarDelegate {
    
    var countryInfo = [Countries]() {
        didSet {
            countryCollectionView.reloadData()
        }
    }
    
    
    @IBOutlet weak var countryCollectionView: UICollectionView!
    @IBOutlet weak var countrySearchBar: UISearchBar!
    
    func loadData(countryData:String) {
        CountriesAPIManager.shared.getCountries(showInfo: countryData) {(result)
            in DispatchQueue.main.async {
                switch result {
                case.failure(let error):
                    print(error)
                case.success(let data):
                    self.countryInfo = data
                    
                }
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        countryInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = countryCollectionView.dequeueReusableCell(withReuseIdentifier: "countryCell", for: indexPath) as? CountryCell else {
            fatalError("unable to dequeue an image cell")
        }
        
        let country = countryInfo[indexPath.item]
        cell.countryCapital.text = country.capital
        cell.countryName.text = country.name
        cell.population.text = country.population.description
        return cell
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        loadData(countryData: searchText)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        countryCollectionView.dataSource = self
    }


}

