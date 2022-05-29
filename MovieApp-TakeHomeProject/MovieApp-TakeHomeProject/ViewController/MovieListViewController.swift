//
//  ViewController.swift
//  MovieApp-TakeHomeProject
//
//  Created by Ikmal Azman on 15/05/2022.
//

import UIKit

class MovieListViewController: UIViewController {
    
    @IBOutlet private(set) weak var sortBarButton: UIBarButtonItem!
    @IBOutlet private(set) weak var movieListCollectionView: UICollectionView!
    
    var viewModel = MovieListViewModel()
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupCollectionView()
        setupSortDropdownMenu()
        viewModel.delegate = self
        viewModel.fetchMovieLists()
    }
}

//MARK: - UICollectionViewDataSource
extension MovieListViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as! MovieCollectionViewCell
        
        let movie = viewModel.movieForCellAtIndex(indexPath.row)
        cell.movieLabel.text = movie.original_title
        cell.popularityLabel.text = "\(movie.vote_average)"
        cell.posterImageView.downloadImage(fromURLString: viewModel.moviePosterUrl(atIndex: indexPath.row) ?? "")
        
        let lastElement = viewModel.movies.count - 1
        
        if indexPath.row == lastElement {
            viewModel.nextMoviePage()
        }
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension MovieListViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieDetailVC = MovieDetailsViewController(id: viewModel.movieIdForCellAtIndex(indexPath.row))
        navigationController?.pushViewController(movieDetailVC, animated: true)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension MovieListViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widht = view.frame.size.width / 2.1
        let height : CGFloat = 285.0
        
        return CGSize(width: widht, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
}

//MARK: - MovieListViewModelDelegate
extension MovieListViewController : MovieListViewModelDelegate {
    func successHandler(_ viewModel: MovieListViewModel) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.view.removeSpinner()
            self?.movieListCollectionView.refreshControl?.endRefreshing()
            self?.movieListCollectionView.reloadData()
        }
    }
    
    func errorHandler(_ viewModel: MovieListViewModel, error: APIError) {
        showErrorAlert(error) { [weak self] in
            self?.viewModel.fetchMovieLists()
        }
    }
}

//MARK: - Private methods
private extension MovieListViewController {
    @objc func didPullToRefresh(_ sender : UIRefreshControl) {
        view.addSpinner()
        viewModel.removeAllMovies()
        movieListCollectionView.reloadData()
        viewModel.resetMoviePage()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.viewModel.fetchMovieLists()
        }
    }
    
    func setupSortDropdownMenu() {
        let menuItems = [
            UIAction(title: "Release date",state: .on, handler: menuActionHandler(_:)),
            UIAction(title: "A-Z", handler: menuActionHandler(_:)),
            UIAction(title: "Popularity",  handler: menuActionHandler(_:))
        ]
        let menu = UIMenu(title: "", image: UIImage(systemName: "slider.horizontal.3"), options: .singleSelection, children: menuItems)
        sortBarButton.menu = menu
    }
    
    func menuActionHandler(_ action : UIAction) {
        viewModel.removeAllMovies()
        movieListCollectionView.reloadData()
        viewModel.resetMoviePage()
        let dropdownTitle = action.title
        viewModel.filterMovieBy(dropdownTitle)
    }
    
    func setupCollectionView() {
        movieListCollectionView.register(MovieCollectionViewCell.nib(), forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        movieListCollectionView.delegate = self
        movieListCollectionView.dataSource = self
        movieListCollectionView.refreshControl = refreshControl
        movieListCollectionView.refreshControl?.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
    }
    
    func setupNavigation() {
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor : AppTheme.darkishPink ?? UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : AppTheme.darkishPink ?? UIColor.black]
        navigationController?.navigationBar.tintColor = AppTheme.darkishPink
    }
}
