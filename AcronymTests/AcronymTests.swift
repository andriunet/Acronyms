//
//  AcronymTests.swift
//  AcronymTests
//
//  Created by Andres Marin on 26/03/21.
//

import XCTest

class AcronymTests: XCTestCase {

    //Test para probar el API que este retornando bien
    func testBusquedaAPI() {
        
        let busqueda = "UK"
        
        guard let vURL = URL(string: "http://www.nactem.ac.uk/software/acromine/dictionary.py?sf=\(busqueda)") else { return }
        let expe = expectation(description: "Busqueda por UK")
        
        URLSession.shared.dataTask(with: vURL) { (data, response
            , error) in
                guard let data = data else { return }
                do {
                    
                    let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                    
                    if let result = json as? Array<Any> {
                        
                        XCTAssertEqual(result.count, 1)
                        
                        if let array = result[0] as? NSDictionary {
                            
                            //Comparamos que la busqueda sea igual al resultado
                            XCTAssertEqual(array["sf"] as! String, busqueda)
                            
                            XCTAssertNotNil(array["lfs"])
    
                            //Compara si el results tenga items.
                            if let results = array["lfs"] as? Array<Any> {
                                XCTAssertTrue(results.count > 0)
                                expe.fulfill()
                            }
                        }

                        
                    }
                } catch let err {
                    print("Error", err)
                }
            }.resume()
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    

}
