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
        <#code#>
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        loadData(countryData: searchText)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

