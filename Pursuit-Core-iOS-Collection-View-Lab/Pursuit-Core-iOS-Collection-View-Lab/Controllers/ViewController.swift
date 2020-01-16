//
//  ViewController.swift
//  Pursuit-Core-iOS-Collection-View-Lab
//
//  Created by Bienbenido Angeles on 1/14/20.
//  Copyright © 2020 Bienbenido Angeles. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //@IBOutlet weak var countryCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var countryFlagCollectionView: UICollectionView!
    
    var allCountryData = [CountryList](){
        didSet{
            DispatchQueue.main.async {
                self.countryFlagCollectionView.reloadData()
            }
        }
    }
    
    var query = ""{
        didSet{
            allCountryData = allCountryData.filter{$0.name.lowercased().contains(query.lowercased())}
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadData()
        dataSourcesAndDelegates()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cell = sender as? CountryCell else {
            fatalError("failed to downcast as Country Cell")
        }
        
        guard let detailVC = segue.destination as? DetailViewController, let indexPath = countryFlagCollectionView.indexPath(for: cell) else{
            fatalError("failed to segue to detailViewController")
        }
        
        let country = allCountryData[indexPath.row]
        
        detailVC.passedObj = country
    }
    
    func loadData(){
        CountryListAPI.getListOfCountries {[weak self] (result) in
            switch result{
            case .failure(let appError):
                self?.showAlert(title: "Network Error", message: "\(appError)")
            case .success(let countries):
                self?.allCountryData = countries
            }
        }
    }
    
    func dataSourcesAndDelegates(){
        countryFlagCollectionView.dataSource = self
        countryFlagCollectionView.delegate = self
        searchBar.delegate = self
    }
}

extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        allCountryData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = countryFlagCollectionView.dequeueReusableCell(withReuseIdentifier: "countryCell", for: indexPath) as? CountryCell else {
            fatalError("Could not downcast to CountryCell")
        }
        let country = allCountryData[indexPath.row]
        
        cell.configureCell(with: "https://www.countryflags.io/\(country.alpha2Code)/flat/64.png", country: country)
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let interItemSpacingV:CGFloat = 5 //space between items
        let interItemSpacingH:CGFloat = 3
        
        let maxHeight = UIScreen.main.bounds.size.height // device's width
        let maxWidth = UIScreen.main.bounds.size.width
        let numberOfItemsV: CGFloat = 3// items
        let totalSpacingV: CGFloat = numberOfItemsV * interItemSpacingV
        
        let numberOfItemsH: CGFloat = 5
        let totalSpacingH: CGFloat = numberOfItemsH * interItemSpacingH
        
        
        let itemHeight: CGFloat = (maxHeight - totalSpacingV) / numberOfItemsV
        let itemWidth: CGFloat = (maxWidth - totalSpacingH) / numberOfItemsH
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            loadData()
            return
        }
        query = searchText
    }
}
