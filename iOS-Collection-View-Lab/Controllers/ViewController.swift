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
       return countryInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = countryCollectionView.dequeueReusableCell(withReuseIdentifier: "countryCell", for: indexPath) as? CountryCell else { return
            UICollectionViewCell()
        }
        let country = countryInfo[indexPath.item]
        cell.countryCapital.text = country.capital
        cell.countryName.text = country.name
        cell.population.text = country.population.description
        
        ImageHelper.shared.getImage(alphaCode: country.alpha2Code){(result)in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let imageFromOnline):
                    cell.countryImage.image = imageFromOnline
                }
            }
        }
        return cell
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        loadData(countryData: searchBar.text!)
       print(countryInfo)
    }
    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        loadData(countryData: searchText)
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        countryCollectionView.dataSource = self
        countrySearchBar.delegate = self
    }


}

