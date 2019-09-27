//
//  ViewController.swift
//  Collection View Lab
//
//  Created by Jason Ruan on 9/26/19.
//  Copyright © 2019 Jason Ruan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //MARK: Properties
    var arrayOfCountries: [Country] = [] {
        didSet {
            filteredArrOfCountries = self.arrayOfCountries
        }
    }
    
    var filteredArrOfCountries: [Country] = [] {
        didSet {
            countryCollectionView.reloadData()
        }
    }
    
    var searchString = "" {
        didSet {
            if self.searchString == "" {
                filteredArrOfCountries = arrayOfCountries
            } else {
                filteredArrOfCountries = arrayOfCountries.filter { $0.name.contains(self.searchString) }
            }
        }
    }
    
    //MARK: IBOutlets
    @IBOutlet weak var countrySearchBar: UISearchBar!
    @IBOutlet weak var countryCollectionView: UICollectionView!
    
    //MARK: LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureInitialViewController()
        loadCountries()
    }
    
    //MARK: Custom Functions
    private func configureInitialViewController() {
        countrySearchBar.delegate = self
        countryCollectionView.dataSource = self
        countryCollectionView.delegate = self
    }
    
    private func loadCountries() {
        CountryAPIClient.manager.getCountries { (result) in
            switch result {
            case .failure(let error):
                print("Could not get countries: Error:\(error)")
            case .success(let countriesArr):
                self.arrayOfCountries = countriesArr
            }
        }
    }
    
}

//MARK: SearchBar Delegate
extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchString = searchText
    }
}

//MARK: CollectionView DataSource
extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredArrOfCountries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = countryCollectionView.dequeueReusableCell(withReuseIdentifier: "countryCell", for: indexPath) as? CountryCollectionViewCell else {
            return UICollectionViewCell()
        }
        let currentCountry = filteredArrOfCountries[indexPath.row]
        cell.countryNameLabel.text = currentCountry.name
        cell.capitalNameLabel.text = currentCountry.capital
        cell.populationLabel.text = currentCountry.population.description
        
        DispatchQueue.main.async {
            CountryAPIClient.manager.getFlagImage(countryCode: currentCountry.countryCode) { (result) in
                switch result {
                case .failure(let error):
                    print("Could not get image: \(error)")
                case .success(let flagImage):
                    DispatchQueue.main.async {
                        cell.flagImageView.image = flagImage
                    }
                }
            }
        }
        
        return cell
    }
    
    
}

//MARK: CollectionView Delegate Flow Layout
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
}

//MARK: CollectionView Delegate
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCountry = arrayOfCountries[indexPath.row]
        let detailVC = storyboard?.instantiateViewController(identifier: "DetailViewController") as! DetailViewController
        detailVC.country = selectedCountry
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
