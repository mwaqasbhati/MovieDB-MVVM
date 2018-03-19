//
//  ViewController.swift
//  TestProject
//
//  Created by Muhammad Waqas  on 3/06/18.
//  Copyright © 2018 Emaar . All rights reserved.
//

import UIKit
import SDWebImage
import RMPZoomTransitionAnimator

class MovieListViewController: UIViewController {

    // MARK: - Propertiesa

    @IBOutlet weak var collectionView: UICollectionView!

    var movieListViewModel: MovieListViewModel?
    fileprivate let movieCellId = "MovieCellId"
    fileprivate let segueId = "goToFilter"
    fileprivate let placeHolderIcon = "placeholder.png"
    fileprivate let movieDetailControllerID = "MovieDetailViewController"
    private var page = 1
    private var gotData = false
    private var isFilterApplied = false
    private var minYear: String = "0"
    private var maxYear: String = "0"

    private var mURL: String {
        if isFilterApplied == true {
            let url = String(format: Constant.MOVIE_FILTER_URL.path + "&primary_release_date.gte=%@&primary_release_date.lte=%@&page=\(page)", minYear,maxYear)
            return url
        } else {
            let url = String(format: Constant.MOVIE_URL.path + "&page=\(page)")
            return url
        }
    }
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieListViewModel?.movieSuccess = { [weak self] () in
            HUD.hide(view: self?.view)
            self?.gotData = true
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        movieListViewModel?.movieError = { [weak self] (error) in
            guard error != nil else {
                return
            }
            self?.showAlertInViewController(titleStr: Constant.Alert.title, messageStr: (error?.localizedDescription)! , okButtonTitle: Constant.Alert.ok)
        }
        getStoresForPage(page: page)
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueId {
            if let filterVC = segue.destination as? FiltersViewController {
                filterVC.filterVM = FilterViewModel()
                filterVC.delegate = self
            }
        }
    }
}

extension MovieListViewController {
    
    // MARK: - Network

    func getStoresForPage(page: Int) {
        self.gotData = false
        HUD.show(view: view)
        movieListViewModel?.initFetch()
    }
    
}

extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieListViewModel?.movieContainer?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: movieCellId, for: indexPath) as! MovieCollectionViewCell
        if let movieVM = movieListViewModel?.getCellViewModel(at: indexPath) {
            cell.titleLabel.text = movieVM.title
            let url = movieVM.imageURL
            cell.posterImgView.sd_setImage(with: URL(string: Constant.makeImagePath(url: url)), placeholderImage: UIImage(named: placeHolderIcon))
        }
        return cell
        
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if let movieVM = movieListViewModel?.getCellViewModel(at: indexPath) {
            let cell = collectionView.cellForItem(at: indexPath) as! MovieCollectionViewCell
            if let controller = self.storyboard?.instantiateViewController(withIdentifier: movieDetailControllerID) as? MovieDetailViewController {
                controller.movieDetailViewModel = MovieDetailViewModel(movieID: movieVM.id, movieImage: cell.posterImgView.image ?? UIImage(), apiService: MovieDetailAPI())
                self.present(controller, animated: true, completion: nil)
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.size.height {
            if self.gotData == true {
                page = page + 1
                Logger.log(message: "PAGE: \(page)")
                getStoresForPage(page: page)
            }
        }
    }
}

extension MovieListViewController: FilterViewDelegate {
    
    func applyFilter(minYear: Int, maxYear: Int) {
         page = 1
         isFilterApplied = true
         self.movieListViewModel?.movieContainer?.results.removeAll()
         self.minYear = String(minYear)
         self.maxYear = String(maxYear)
         getStoresForPage(page: page)
    }
    func resetFilter() {
         page = 1
         isFilterApplied = false
        self.movieListViewModel?.movieContainer?.results.removeAll()
         getStoresForPage(page: page)
    }

}



