//
//  MovieDetailViewController.swift
//  PruebaMovie
//
//  Created Jorge Espinoza on 16/02/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import SCLAlertView

class MovieDetailViewController: UIViewController, NVActivityIndicatorViewable {
    
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var lbRateMovie: UILabel!
    @IBOutlet weak var lbMovieName: UILabel!
    @IBOutlet weak var collectionProductCompany: UICollectionView!
    @IBOutlet weak var lbMovieDescription: UILabel!
    @IBOutlet weak var lbMovieDate: UILabel!
    @IBOutlet weak var btnFavorite: UIButton!
    
    var presenter: MovieDetailPresenterProtocol?
    private let cellIdentifier = "CompanyCell"
    var movieId: Int?
    private var companiesList: [ProductionCompanies]?
    private var dbManager = DBManager()
    private var movieSelected: MovieDetailResponse?

	override func viewDidLoad() {
        super.viewDidLoad()
        
        createToolbar()
        
        setUpView()
        
        presenter?.getMovieDetail(movieId: movieId ?? 0)
    }
    
    func createToolbar(){
        self.navigationController?.isNavigationBarHidden = false
        
        let backMenu = CustomBarButton(icon: UIImage(named: "back", in: Bundle(for: HomeViewController.self), compatibleWith: nil), title: nil, selector: #selector(goToBack))
        
        CustomNavigationBar.createNavigationBar(reference: self, backgroundColor: Colors.grayNavigationBar, textColor: Colors.white, title: "", leftButtonItem: backMenu, rigthButtonItem: nil)
    }
    
    func setUpView() {
        lbRateMovie.textColor = Colors.greenItemMovies
        lbMovieName.textColor = Colors.greenItemMovies
        lbMovieDescription.textColor = Colors.white
        lbMovieDate.textColor = Colors.white
        
        collectionProductCompany.register(UINib(nibName: "CompanyCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        collectionProductCompany.setCollectionViewLayout(layout, animated: true)
        collectionProductCompany.reloadData()
    }
    
    @objc func goToBack() {
        presenter?.goToBack()
    }
    
    @IBAction func setFavorite(_ sender: Any) {
        if let favorite = dbManager.getFavoriteById(movieId: movieId!) {
            if favorite.isFavorite {
                dbManager.updateFavorite(isFavorite: false, id: Int(favorite.id))
                self.btnFavorite.setImage(UIImage(named: "empty_favorite"), for: UIControl.State.normal)
            } else {
                dbManager.updateFavorite(isFavorite: true, id: Int(favorite.id))
                self.btnFavorite.setImage(UIImage(named: "favorite"), for: UIControl.State.normal)
            }
        } else {
            dbManager.insertMovie(movie: Movie(id: movieId, poster_path: movieSelected?.poster_path, title: movieSelected?.title, overview: movieSelected?.overview, vote_average: movieSelected?.vote_average, release_date: movieSelected?.release_date, isFavorite: true))
            self.btnFavorite.setImage(UIImage(named: "favorite"), for: UIControl.State.normal)
        }
    }
}

extension MovieDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return companiesList?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CompanyCell
        
        let company = companiesList?[indexPath.row]
        
        if let urlPhoto = company?.logo_path {
            cell.imageCompany.setImageFromUrl(urlPhoto: urlPhoto)
        }
    
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
        return CGSize(width: 76, height: 76)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

extension MovieDetailViewController: MovieDetailViewProtocol {
    
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
    
    func setMovieDetail(response: MovieDetailResponse) {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.movieSelected = response
            
            self.lbRateMovie.text = String(format: "%.1f", response.vote_average ?? 0)
            self.lbMovieName.text = response.title
            self.lbMovieDescription.text = response.overview
            self.lbMovieDate.text = DateTimeFunctions.dateFormat(dateString: response.release_date ?? "", inputFormat: "yyyy-mm-dd", outputFomrat: "MMM, d yyyy")
            
            if let urlPhoto = response.poster_path {
                self.imageMovie.setImageFromUrl(urlPhoto: urlPhoto)
            }
            
            self.companiesList = response.production_companies
            self.collectionProductCompany.reloadData()
            
            if let favorite = self.dbManager.getFavoriteById(movieId: (response.id)!) {
                
                var imageName = "empty_favorite"
                if favorite.isFavorite {
                    imageName = "favorite"
                }
                
                self.btnFavorite.setImage(UIImage(named: imageName), for: UIControl.State.normal)
            } else {
                self.btnFavorite.setImage(UIImage(named: "empty_favorite"), for: UIControl.State.normal)
            }
        }
    }
}
