//
//  CollectionViewLabTests.swift
//  CollectionViewLabTests
//
//  Created by Ahad Islam on 12/25/19.
//  Copyright © 2019 Ahad Islam. All rights reserved.
//

import XCTest
@testable import CollectionViewLab

class CollectionViewLabTests: XCTestCase {

    func testModel() {
        let url = "https://restcountries.eu/rest/v2/name/united"
        var countries = [Country]()
        let exp = XCTestExpectation(description: "Succesfully decoded JSON.")
        
        GenericCoderService.manager.getJSON(objectType: [Country].self, with: url) { result in
            switch result {
            case .failure(let error):
                XCTFail("Error occured: \(error)")
            case .success(let countriesFromAPI):
                countries = countriesFromAPI
                exp.fulfill()
            }
        }
        
        wait(for: [exp], timeout: 5)
    }
    
    func testImage() {
        let url = "https://www.countryflags.io/be/flat/64.png"
        let imageView = UIImageView()
        let exp = XCTestExpectation(description: "Succesfully loaded Image.")
        
        imageView.getImage(with: url) { result in
            switch result {
            case .failure(let error):
                XCTFail("Error occurred: \(error)")
            case .success(let imageFromAPI):
                imageView.image = imageFromAPI
                XCTAssertNotNil(imageView.image)
                exp.fulfill()
            }
        }
        
        wait(for: [exp], timeout: 5)
    }

}
