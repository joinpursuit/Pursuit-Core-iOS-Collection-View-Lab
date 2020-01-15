//
//  ViewController.swift
//  CollectionViewLab
//
//  Created by Cameron Rivera on 1/14/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var countries = [Country]() {
        didSet{
            DispatchQueue.main.async{
                self.collectionView.reloadData()
            }
        }
    }
    var location: Location?
    
    var userQuery = "" {
        didSet{
            CountryAPIClient.getCountries(CountryAPIClient.getCountryURL(userQuery)) { [weak self] result in
                switch result{
                case .failure:
                    DispatchQueue.main.async{
                        self?.showAlert("Oops", "Could not find a country with the name \(self?.userQuery ?? "").")
                    }
                case .success(let countryArr):
                    self?.countries = countryArr
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp(){
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.darkGray
        searchBar.delegate = self
        navigationItem.title = "Search Country"
        searchBar.placeholder = "Enter country name here"
    }

}

extension ViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let xCell = collectionView.dequeueReusableCell(withReuseIdentifier: "countryCell", for: indexPath) as? CountryCell else {
            fatalError("Could not dequeue Country Cell")
        }
        xCell.setUpCell(countries[indexPath.row])
        xCell.backgroundColor = UIColor.white
        return xCell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countries.count
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let detailedVC = storyboard?.instantiateViewController(withIdentifier: "DetailedController") as? DetailedController else {
            fatalError("Could not instantiate instance of Detailed Controller")
        }
        WeatherAPIClient.getLocations(WeatherAPIClient.getLocationURL(countries[indexPath.row].latlng[0], countries[indexPath.row].latlng[1])) { [weak self] result in
            switch result{
            case .failure(let netError):
                DispatchQueue.main.async{
                    self?.showAlert("Location Error", "Could not load location \(netError)")
                }
            case .success(let loc):
                self?.location = loc.first
            }
        }
        sleep(1)
        detailedVC.location = location ?? nil
        detailedVC.currentCountry = countries[indexPath.row]
        navigationController?.pushViewController(detailedVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width / 1.25, height: UIScreen.main.bounds.size.width / 1.25)
    }
    
}

extension ViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text{
            userQuery = text
        }
    }
}

