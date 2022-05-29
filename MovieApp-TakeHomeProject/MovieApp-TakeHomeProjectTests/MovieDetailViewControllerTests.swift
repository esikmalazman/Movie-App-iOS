@testable import MovieApp_TakeHomeProject
import XCTest

final class MovieDetailViewControllerTests: XCTestCase {

    var sut : MovieDetailsViewController!
    
    override func setUp() {
        super.setUp()
        sut = MovieDetailsViewController(id: 0)
         sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func test_oulets_shouldBeConnected() {
        XCTAssertNotNil(sut.detailsTableView, "detailsTableView")
    }
    
}
