//
//  ViewController.swift
//  CollectionViewProj
//
//  Created by Kevin Natera on 9/26/19.
//  Copyright © 2019 Kevin Natera. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var countryCollectionView: UICollectionView!
    
    var countries = [Country]() {
        didSet {
            DispatchQueue.main.async {
                self.countryCollectionView.reloadData()
            }
        }
    }
    
    var filteredCountries : [Country] {
        get {
            guard let searchString = searchString else { return countries }
            guard searchString != ""  else { return countries }
            return Country.getFilteredCountries(arr: countries, searchString: searchString)
        }
    }
    
    var searchString: String? = nil {
        didSet {
            countryCollectionView.reloadData()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredCountries.count
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = countryCollectionView.dequeueReusableCell(withReuseIdentifier: "country", for: indexPath) as! CountryCollectionViewCell
        let country = filteredCountries[indexPath.row]
        cell.configureCell(with: country)
        return cell
       }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchString = searchText
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          return CGSize(width: 190, height: 200)
        }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
         if let cell = sender as? CountryCollectionViewCell, let indexPath = self.countryCollectionView.indexPath(for: cell) {
        
            let detailVC = segue.destination as! DetailViewController
            detailVC.country = countries[indexPath.row]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpProtocols()
        loadData()
    }

    private func loadData() {
        CountryAPIHelper.shared.getCountries { (result) in
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
    
    
    
    func setUpProtocols() {
        searchBar.delegate = self
        countryCollectionView.delegate = self
        countryCollectionView.dataSource = self
    }
    
    
}

