//
//  ViewController.swift
//  collectionViewsLab
//
//  Created by Sam Roman on 9/26/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var countryCollection: UICollectionView!
    
    var countries = [Countries]() {
        didSet {
            countryCollection.reloadData()
        }
    }
    
    
    //MARK:Private Methods
    private func loadCountries(){
        CountryAPIClient.shared.fetchData { (result) in
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
        loadCountries()
        countryCollection.delegate = self
        countryCollection.dataSource = self
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
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 374, height: 347)
    }
    
    
}
