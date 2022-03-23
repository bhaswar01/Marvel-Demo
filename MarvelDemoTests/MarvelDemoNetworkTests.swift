//
//  MarvelDemoNetworkTests.swift
//  MarvelDemoTests
//
//  Created by Bhaswar Mukherjee on 23/03/22.
//
import Foundation
import XCTest
@testable import MarvelDemo

class MarvelDemoNetworkTests: XCTestCase {

    var characterViewModel = CharacterListViewModel()
    var resultOfCharacterAPI: [CharacterModel]?
    var comicsViewModel = ComicDetailsViewModel()
    var comicsResult  : [ComicsItems]?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


    func testFetchingDataFromCharacterList () {

        characterViewModel.getAllCharacters(offset: 0 , limit: 20) {_ in

        APIHelper.shared.getAllCharacters (offset: 0 , limit: 20) { result in

            switch result{
            case .success(let resultOfCharacterAPI):
                DispatchQueue.main.async {
                    XCTAssertTrue(resultOfCharacterAPI.count > 0)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    XCTAssertNotNil(error, "error should not be nil")
                }
             }
          }
       }
    }
    
    func testFetchDataFromCharacterDetails() {
        
        APIHelper.shared.getAllComics (characterDetailID: Int((resultOfCharacterAPI?.first?.id ?? 1011334))) { result in
                                         
           switch result{
        case .success(let comicsResult):
               DispatchQueue.main.async {
                   XCTAssertTrue(comicsResult.count > 0)
               }
        case .failure(let error):
               DispatchQueue.main.async {
                   XCTAssertNotNil(error, "error should not be nil")
               }
           }
        }
    }
    
    
    
    func testFetchDataFromComics() {
        
        let strid = (comicsResult?.first?.resourceURI.components(separatedBy: "/").last) ?? "21366"
        APIHelper.shared.getAllComicDetails(strid: strid) { result in
           switch result{
        case .success(let comicsImgDict):
               DispatchQueue.main.async {
                   XCTAssertNotNil(comicsImgDict.thumbnail)
                   XCTAssertNotNil(comicsImgDict.thumbnail["path"])
                   XCTAssertNotNil(comicsImgDict.thumbnail["extension"])
               }
        case .failure(let error):
               DispatchQueue.main.async {
                   XCTAssertNotNil(error, "error should not be nil")
               }
          }
        }
    }
    
    
    
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
