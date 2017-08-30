import UIKit
import XCTest
import CoroPaulus

class Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
        
    func testCanto() {
        let canto = Canto(nome: "nome", url: "url")
        XCTAssertEqual("nome", canto.nome)
        XCTAssertEqual("url", canto.url)
    }
}
