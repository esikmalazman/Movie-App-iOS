@testable import MovieApp_TakeHomeProject
import XCTest

final class MovieListViewControllerTests: XCTestCase {
    
    var sut : MovieListViewController!
    
    override func setUp() {
        super.setUp()
        let sb = UIStoryboard(name: "Main", bundle: nil)
        sut = sb.instantiateViewController(identifier: "\(MovieListViewController.self)")
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func test_outlets_shouldBeConnected() {
        XCTAssertNotNil(sut.sortBarButton, "sortBarButton")
        XCTAssertNotNil(sut.movieListCollectionView, "movieListCollectionView")
    }
    
    func test_tappingSortBarButton() {
        tap(sut.sortBarButton)
    }
}



