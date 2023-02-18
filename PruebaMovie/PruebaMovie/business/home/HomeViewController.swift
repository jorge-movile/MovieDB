//
//  HomeViewController.swift
//  PruebaMovie
//
//  Created Jorge Espinoza on 15/02/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import SCLAlertView

class HomeViewController: UIViewController, NVActivityIndicatorViewable {
    
    @IBOutlet weak var collectionMovies: UICollectionView!
    @IBOutlet weak var collectionCategories: UICollectionView!
    
    var presenter: HomePresenterProtocol?
    private let cellIdentifier = "MovieCell"
    private let cellIdentifierCat = "CategoryCell"
    private var categoriesList: [Category]?
    private var moviesList: [Movie]?
    private var dbManager = DBManager()

	override func viewDidLoad() {
        super.viewDidLoad()
        
        createToolbar()
        
        setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.getCategoriesList()
    }
    
    func createToolbar(){
        self.navigationController?.isNavigationBarHidden = false
        
        let optionsMenu = CustomBarButton(icon: UIImage(named: "menu", in: Bundle(for: HomeViewController.self), compatibleWith: nil), title: nil, selector: #selector(showOptionsMenu))
        
        CustomNavigationBar.createNavigationBar(reference: self, backgroundColor: Colors.grayNavigationBar, textColor: Colors.white, title: Constants.homeTitle, leftButtonItem: nil, rigthButtonItem: optionsMenu)
    }
    
    func setUpView() {
        
        collectionCategories.backgroundColor = Colors.semiBlack
        collectionCategories.layer.cornerRadius = 8
        
        collectionMovies.register(UINib(nibName: "MovieCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        
        collectionCategories.register(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifierCat)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        collectionMovies.setCollectionViewLayout(layout, animated: true)
        collectionMovies.reloadData()
        
        let layoutCat = UICollectionViewFlowLayout()
        layoutCat.scrollDirection = .horizontal
        layoutCat.minimumLineSpacing = 1
        layoutCat.minimumInteritemSpacing = 1
        collectionCategories.setCollectionViewLayout(layoutCat, animated: true)
        collectionCategories.reloadData()
    }
    
    @objc func showOptionsMenu() {
        presenter?.showOptionMenu(vc: self)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionMovies {
            return moviesList?.count ?? 0
        } else {
            return categoriesList?.count ?? 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.collectionMovies {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MovieCell
            
            cell.delegate = self
            
            let movie = moviesList?[indexPath.row]
            
            cell.lbTitleMovie.text = movie?.title ?? ""
            cell.lbDateMovie.text = DateTimeFunctions.dateFormat(dateString: movie?.release_date ?? "", inputFormat: "yyyy-mm-dd", outputFomrat: "MMM, d yyyy")
            cell.lbRateMovie.text = "\(movie?.vote_average ?? 0)"
            cell.lbDescriptionMovie.text = movie?.overview ?? ""
            
            if let urlPhoto = movie?.poster_path {
                cell.imageMovie.setImageFromUrl(urlPhoto: urlPhoto)
            }
            
            if let favorite = dbManager.getFavoriteById(movieId: (movie?.id)!) {
                
                var imageName = "empty_favorite"
                if favorite.isFavorite {
                    imageName = "favorite"
                }
                
                cell.btnFavorite.setImage(UIImage(named: imageName), for: UIControl.State.normal)
            } else {
                cell.btnFavorite.setImage(UIImage(named: "empty_favorite"), for: UIControl.State.normal)
            }
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifierCat, for: indexPath) as! CategoryCell
            
            let category = categoriesList?[indexPath.row]
            
            cell.lbCategory.text = category?.name ?? ""
            
            if indexPath.row == 0 {
                cell.isSelected = true
                collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .left)
                presenter?.getMoviesList(categoryId: category?.id ?? 0)
            } else {
                cell.isSelected = false
            }
            
            return cell
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.collectionMovies {
            let movie = moviesList?[indexPath.row]
            presenter?.goToDetail(movieId: movie?.id ?? 0)
        } else {
            let category = categoriesList?[indexPath.row]
            presenter?.getMoviesList(categoryId: category?.id ?? 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.collectionMovies {
            let lay = collectionViewLayout as! UICollectionViewFlowLayout
            let widthPerItem = collectionView.frame.width / 2 - lay.minimumInteritemSpacing
            
            return CGSize(width:widthPerItem, height:320)
        } else {
            let lay = collectionViewLayout as! UICollectionViewFlowLayout
            let widthPerItem = collectionView.frame.width / 4 - lay.minimumInteritemSpacing
            
            return CGSize(width:widthPerItem, height:40)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

extension HomeViewController: HomeViewProtocol {
    
    func showMessage(message: String) {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            SCLAlertView().showError("Warning", subTitle: message)
        }
    }
    
    func showLoading() {
        self.startAnimating(Constants.LoadingConfig.size, type: NVActivityIndicatorType.lineSpinFadeLoader, color: Colors.greenItemMovies)
    }
    
    func hideLoading() {
        self.stopAnimating()
    }
    
    func setCategoriesList(categoriesList: [Category]) {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.categoriesList = categoriesList
            self.collectionCategories.reloadData()
        }
    }
    
    func setMoviesList(moviesList: [Movie]) {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.moviesList = moviesList
            self.collectionMovies.reloadData()
            
            if self.moviesList?.count == 0 {
                SCLAlertView().showWarning("Warning", subTitle: "Not found")
            }
        }
    }
}

extension HomeViewController: FavoriteDelegate {
    
    func setFavorite(cell: MovieCell) {
        let indexPath = self.collectionMovies.indexPath(for: cell)
        let item = moviesList?[indexPath?.row ?? 0]
        
        if let favorite = dbManager.getFavoriteById(movieId: (item?.id)!) {
            if favorite.isFavorite {
                dbManager.updateFavorite(isFavorite: false, id: Int(favorite.id))
                moviesList?[indexPath?.row ?? 0].isFavorite = false
                collectionMovies.reloadData()
            } else {
                dbManager.updateFavorite(isFavorite: true, id: Int(favorite.id))
                moviesList?[indexPath?.row ?? 0].isFavorite = true
                collectionMovies.reloadData()
            }
        } else {
            if let movie = item {
                debugPrint("Ida insertar: \(movie.id)")
                //dbManager.insertMovie(movie: movie)
                moviesList?[indexPath?.row ?? 0].isFavorite = true
                dbManager.insertMovie(movie: (moviesList?[indexPath?.row ?? 0])!)
                collectionMovies.reloadData()
            }
        }
    }
}

protocol FavoriteDelegate: AnyObject {
    func setFavorite(cell: MovieCell)
}
