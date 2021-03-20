//
//  ViewController.swift
//  Movie Search
//
//  Created by Mohmed Master on 2021/03/02.
//

import UIKit

class ViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet private weak var movieCollectionView: UICollectionView!
    var listOfMovies = [MovieResult]()
    var genreMap: [IndexPath: [Genre]] = [:]
    var movieMap: [IndexPath: [MovieResult]] = [:]
    let movieRequest = MovieRequest()
    var largestTitleLabelHeight: CGFloat = 20.5
    let numberOfHorizontalCells: CGFloat = 3
    let numberOfVerticalCells: CGFloat = 5
    let horizontalSpacing: CGFloat = 4
    let verticalSpacing: CGFloat = 5
    let movieCollectionViewCellString = "MovieCollectionViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        registerCollectionViewCell()
    }

    fileprivate func registerCollectionViewCell() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: movieCollectionViewCellString, bundle: bundle)
        movieCollectionView.register(nib, forCellWithReuseIdentifier: movieCollectionViewCellString)
    }

    @IBAction func searchButtonTapped(_ sender: Any) {
        DispatchQueue.main.async(qos: .default) {
            self.retrieveMoviesNowPlaying()
        }
    }

    func loadMovieImage(urlString: String, indexPath: IndexPath,
                        completionHandler: @escaping(IndexPath, UIImage) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async {
                guard let image = UIImage(data: data) else { return }
                completionHandler(indexPath, image)
            }
        }
        task.resume()
    }
}

// MARK: Data Source Delegate
extension ViewController: UICollectionViewDataSource {
    func retrieveMoviesNowPlaying() {
        movieRequest.fetchMoviesInCinemas { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)

            case .success(let movies):
                self?.listOfMovies = movies
                DispatchQueue.main.async {
                    self?.movieCollectionView.reloadData()
                }
            }
        }
    }

    func retrieveMovieGenres(movieId: Int, indexPath: IndexPath) {
        movieRequest.fetchGenreDetail(movieId: movieId, indexPath: indexPath) { [weak self] result, indexPath in
            switch result {
            case .failure(let error):
                print(error)

            case .success(let genres):
                self?.genreMap[indexPath] = genres
                DispatchQueue.main.async {
                    let cell = self?.movieCollectionView.cellForItem(at: indexPath) as? MovieCollectionViewCell
                    // Accessing the movie object and set movie title abd rating to it's related labels
                    cell?.updateMovieGenre(genre: genres)
                }
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        listOfMovies.count
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = listOfMovies[indexPath.row]
        retrieveMovieGenres(movieId: movie.id, indexPath: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) ->
    UICollectionViewCell { guard let cell = movieCollectionView.dequeueReusableCell(
                                    withReuseIdentifier: movieCollectionViewCellString,
                                    for: indexPath) as? MovieCollectionViewCell else {return UICollectionViewCell()}

        let movieTarget = 1
        // Accessing the movie object and set movie title abd rating to it's related labels
        if movieTarget >= listOfMovies.startIndex && movieTarget < listOfMovies.endIndex {
            let movie = listOfMovies[indexPath.row]
            cell.updateMovieTitleRating(movie.title, movie.voteAverage)
            loadMovieImage(urlString: movie.backdropURL.description,
                           indexPath: indexPath, completionHandler: { indexPath, movieImage in
                cell.updateMovieImage(movieImage: movieImage)
            })
        }
        if cell.currentTitleLabelHeight > largestTitleLabelHeight {
            largestTitleLabelHeight = cell.currentTitleLabelHeight
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        let cell = cell as? MovieCollectionViewCell
        cell?.updateTitleLabelHeight(to: largestTitleLabelHeight)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        /*let cellWidth = (collectionView.bounds.width - (horizontalSpacing * 2)) / numberOfCellsInRow

        return CGSize(width: cellWidth, height: 350)*/

        return sizeForItem()
    }

    private func sizeForItem() -> CGSize {
        if traitCollection.horizontalSizeClass == .compact && traitCollection.verticalSizeClass == .regular {
            let cellWidth = (movieCollectionView.bounds.width - (horizontalSpacing * 2)) / numberOfHorizontalCells
            return CGSize(width: cellWidth, height: 300)
        } else {
            let cellWidth = (movieCollectionView.bounds.width - (horizontalSpacing * 4)) / numberOfVerticalCells
            return CGSize(width: cellWidth, height: 300)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return horizontalSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return verticalSpacing
    }
}
