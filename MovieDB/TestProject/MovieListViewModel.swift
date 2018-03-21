//
//  MovieListViewModel.swift
//  TestProject
//
//  Created by Muhammad Waqas Bhati on 3/18/18.
//  Copyright © 2018 Emaar . All rights reserved.
//

import Foundation

class MovieListViewModel {
    
    //MARK: Instance
    private var dataAccessManager: MovieAPI?
    var movieSuccess: (() -> ())?
    var movieError: ((NetworkError?) -> ())?
    
    private var cellViewModels: [MovieViewModel] = [MovieViewModel]() {
        didSet {
            self.movieSuccess?()
        }
    }
    private var error: NetworkError? {
        didSet {
            self.movieError?(error)
        }
    }
    
    //MARK: Initializers
    
    init(cellVM: [MovieViewModel]) {
        self.cellViewModels = cellVM
    }
    required init( apiService: MovieAPI?) {
        self.dataAccessManager = apiService
    }
    
    //MARK: Helper Methds
    
    func getTotalMovies() -> Int {
        return cellViewModels.count
    }
    func resetMovies() {
        return cellViewModels.removeAll()
    }
    func getCellViewModel( at indexPath: IndexPath ) -> MovieViewModel {
        return cellViewModels[indexPath.row]
    }
    func initFetch(url: String) {
        dataAccessManager?.getMoviesList(url: url, completion: { [weak self] (movieContainer, error) in
            self?.processFetchedData(movieContainer: (movieContainer as? MovieContainer)!, error: error)
        })
        
    }
    private func processFetchedData( movieContainer: MovieContainer , error: NetworkError?) {
        guard error == nil else {
            self.error = error!
            return
        }
        var vms = [MovieViewModel]()
        for movie in movieContainer.results {
            vms.append(MovieViewModel(id: movie.id, imageURL: movie.poster_path, title: movie.title))
        }
        let total = self.cellViewModels + vms
        self.cellViewModels = total
    }
    
}

struct MovieViewModel {
    var id: Int
    var imageURL: String
    var title: String
}
