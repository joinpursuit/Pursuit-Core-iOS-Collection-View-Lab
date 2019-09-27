//
//  ViewController.swift
//  CollectionViewLab
//
//  Created by Michelle Cueva on 9/26/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var countryCollectionView: UICollectionView!
    
    @IBOutlet weak var countrySearchBar: UISearchBar!
    
    var countries = [Country]() {
        didSet {
            countryCollectionView.reloadData()
        }
    }
    
    var filteredCountries: [Country] {
        get {
            guard let searchString = searchString else {return countries}
            guard searchString != "" else {return countries}
            return Country.getFilteredResults(arr: countries, searchText: searchString)
        }
    }
    
    var searchString: String? = nil {
        didSet {
            self.countryCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        configureCollectionView()
        configureSearchBar()
    }
    
    private func configureCollectionView() {
        countryCollectionView.dataSource = self
        countryCollectionView.delegate = self
    }
    
    private func configureSearchBar() {
        countrySearchBar.delegate = self
    }
    
    private func loadData() {
        CountryAPIClient.manager.getElements { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let CountriesFromOnline):
                    self.countries = CountriesFromOnline
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    

}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredCountries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "countryCell", for: indexPath) as? CountryCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let country = filteredCountries[indexPath.row]
        cell.nameLabel.text = country.name
        
        ImageHelper.shared.getImage(urlStr: CountryAPIClient.getFlagUrl(from: country.alpha2Code)) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let imageFromOnline):
                    cell.countryImage.image = imageFromOnline
                    
                case .failure( let error):
                    print(error)
                }
            }
        }
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard.init(name: "Main", bundle:nil)
        let countryDVC = storyboard.instantiateViewController(withIdentifier: "detailVC") as! DetailViewController
        let country = filteredCountries[indexPath.row]
        countryDVC.country = country
        
        self.navigationController?.pushViewController(countryDVC, animated: true)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150 , height: 170)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let edgeInset = UIEdgeInsets(top: 20, left: 52, bottom: 20, right: 51)
        
        return edgeInset
    }
    
    
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchString = searchText
    }
}
