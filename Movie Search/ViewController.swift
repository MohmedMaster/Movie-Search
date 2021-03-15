//
//  ViewController.swift
//  Movie Search
//
//  Created by Mohmed Master on 2021/03/02.
//

import UIKit

class ViewController: UIViewController {

    //Outlets
    @IBOutlet private weak var movieCollectionView: UICollectionView!
    var largestTitleLabelHeight: CGFloat = 20.5
    
    var listOfMovies = [MovieResult]()
    var genreMap: [IndexPath: [Genre]] = [:]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "MovieCollectionViewCell", bundle: bundle)
        movieCollectionView.register(nib, forCellWithReuseIdentifier: "MovieCollectionViewCell")
    
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        DispatchQueue.main.async (qos: .default) {
            self.getMoviesNowPlaying()
        }
    }
}

//Data Source
extension ViewController: UICollectionViewDataSource {
    //Data Source
    func getMoviesNowPlaying() {
        let movieRequest = MovieRequest()
        movieRequest.getMoviesInCinemas { [weak self] result in
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
    
    func getMovieGenres(id: Int, indexPath: IndexPath) {
        let movieRequest = MovieRequest()
        movieRequest.getMovieGenre(id: id, indexPath: indexPath) { [weak self] result, indexPath in
            switch result{
            case .failure(let error):
                print(error)

            case .success(let genres):
                self?.genreMap[indexPath] = genres
                DispatchQueue.main.async {
                    let cell = self?.movieCollectionView.cellForItem(at: indexPath) as? MovieCollectionViewCell
                    //Accessing the movie object and set movie title abd rating to it's related labels
                    cell?.updateMovieGenre(with: genres)
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = listOfMovies[indexPath.row]
        let id = movie.id
        getMovieGenres(id: id, indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = movieCollectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as? MovieCollectionViewCell else {return UICollectionViewCell()}
        
        let target = 1
        //Accessing the movie object and set movie title abd rating to it's related labels
        if target >= listOfMovies.startIndex && target < listOfMovies.endIndex {
            let movie = listOfMovies[indexPath.row]
            cell.updateMovieTitleAndRating(with: movie.title, with: movie.voteAverage)
            cell.loadMovieImage(with: movie.backdropURL.description)
        }
        
        if cell.currentTitleLabelHeight > largestTitleLabelHeight {
            largestTitleLabelHeight = cell.currentTitleLabelHeight
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = cell as? MovieCollectionViewCell
        cell?.updateTitleLabelHeight(to: largestTitleLabelHeight)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.bounds.width - 8) / 3

        return CGSize(width: cellWidth , height: 350)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
