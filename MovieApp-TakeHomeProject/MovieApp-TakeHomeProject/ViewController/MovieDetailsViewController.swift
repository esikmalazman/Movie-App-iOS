//
//  MovieDetailsViewController.swift
//  MovieApp-TakeHomeProject
//
//  Created by Ikmal Azman on 15/05/2022.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet private(set) weak var detailsTableView: UITableView!
    
    lazy var buttonView : BookNowButtonView = {
        let view = BookNowButtonView.instantiate()
        return view
    }()
    
    let viewModel = MovieDetailViewModel()
    let movieId : Int
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        view.addSpinner()
        setupTableView()
        setupButtonView()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.view.removeSpinner()
        }
    }
    
    init(id: Int) {
        self.movieId = id
        viewModel.fetchMovideDetails(withId: movieId)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - UITableViewDataSource
extension MovieDetailsViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0 :
            let cell = tableView.dequeueReusableCell(withIdentifier: ImageTableViewCell.identifier, for: indexPath) as! ImageTableViewCell
            cell.posterImage.downloadImage(fromURLString: viewModel.imageForMovie())
            return cell
            
        case 1 :
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieInfoTableViewCell.identifier, for: indexPath) as! MovieInfoTableViewCell
            cell.data = viewModel.movideDetails
            cell.titleLabel.text = viewModel.movideDetails?.title
            cell.durationLabel.text = viewModel.durationForMovie()
            cell.languageLabel.setTitle(viewModel.languageForMovie(), for: .normal)
            cell.genreLabel.text = viewModel.genreForMovie()
            return cell
            
        case  2 :
            let cell = tableView.dequeueReusableCell(withIdentifier: SynopsisTableViewCell.identifier, for: indexPath) as!
            SynopsisTableViewCell
            cell.synopsisDescription.text = viewModel.synopsisForMovie()
            return cell
        default:
            return UITableViewCell()
        }
    }
}

//MARK: - BookNowButtonViewDelegate
extension MovieDetailsViewController : BookNowButtonViewDelegate {
    func bookNowButtonView(_ view: BookNowButtonView, didTapBookButton: UIButton) {
        let webView = WebViewController(urlString: ApiURL.bookMovieURL.rawValue)
        navigationController?.pushViewController(webView, animated: true)
    }
}

//MARK: - Private
private extension MovieDetailsViewController {
    func setupTableView() {
        detailsTableView.register(MovieInfoTableViewCell.nib(), forCellReuseIdentifier: MovieInfoTableViewCell.identifier)
        detailsTableView.register(SynopsisTableViewCell.nib(), forCellReuseIdentifier: SynopsisTableViewCell.identifier)
        detailsTableView.register(ImageTableViewCell.nib(), forCellReuseIdentifier: ImageTableViewCell.identifier)
        detailsTableView.dataSource = self
        detailsTableView.estimatedRowHeight = 100
        detailsTableView.rowHeight = UITableView.automaticDimension
        detailsTableView.separatorStyle = .none
    }
    
    func setupButtonView() {
        view.insertSubview(buttonView, aboveSubview: detailsTableView)
        buttonView.delegate = self
        
        NSLayoutConstraint.activate([
            buttonView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            buttonView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            buttonView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10),
        ])
    }
}

//MARK: - MovieDetailViewModelDelegate
extension MovieDetailsViewController : MovieDetailViewModelDelegate {
    func errorHandler(_ viewModel: MovieDetailViewModel, error: APIError) {
        showErrorAlert(error) { [weak self] in
            self?.viewModel.fetchMovideDetails(withId: self?.movieId ?? 0)
        }
    }
}
