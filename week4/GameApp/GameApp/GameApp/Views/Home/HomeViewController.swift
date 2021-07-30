//
//  HomeViewController.swift
//  GameApp
//
//  Created by Huseyn Valiyev on 20.07.2021.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var gameListCollectionView: UICollectionView!
    
    var searchCollectionView: UICollectionView!
    var searching = false
    var searchedGames = [Game]()
    
    var slider = [Game]()
    var gameList: [Game] = []
    var games: [Game] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        searchCollectionView.translatesAutoresizingMaskIntoConstraints = false
        searchCollectionView.backgroundColor = .white
        searchCollectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.view.addSubview(searchCollectionView)
        NSLayoutConstraint.activate([
                    self.view.topAnchor.constraint(equalTo: searchCollectionView.topAnchor, constant: -140),
                    self.view.bottomAnchor.constraint(equalTo: searchCollectionView.bottomAnchor),
                    self.view.leadingAnchor.constraint(equalTo: searchCollectionView.leadingAnchor),
                    self.view.trailingAnchor.constraint(equalTo: searchCollectionView.trailingAnchor),
                ])
        searchCollectionView.dataSource = self
        searchCollectionView.delegate = self
        searchCollectionView.isHidden = true
        registerCell()
        NetworkService.shared.fetchGames { [weak self] (result) in
            switch result {
            case .success(let allGames):
                self?.games = allGames.results!
                self?.slider = Array(self?.games.prefix(3) ?? [])
                self?.gameList = Array(self?.games.dropFirst(3) ?? [])
                self?.gameListCollectionView.reloadData()
                self?.sliderCollectionView.reloadData()
            case .failure(let error):
                print("\(error.localizedDescription)")
            }
        }
    }
    
    private func registerCell() {
        sliderCollectionView.register(UINib(nibName: SliderCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: SliderCollectionViewCell.identifier)
        gameListCollectionView.register(UINib(nibName: GameLandscapeCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: GameLandscapeCollectionViewCell.identifier)
        searchCollectionView.register(UINib(nibName: GameLandscapeCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: GameLandscapeCollectionViewCell.identifier)
    }

}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searching {
            if searchedGames.count == 0 {
                collectionView.setEmptyView(title: "Sorry, the game was not found.", message: "Try searching for another game")
            }
            return searchedGames.count
        } else {
            if collectionView == self.sliderCollectionView {
                return slider.count
            } else {
                return gameList.count
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if searching {
            let cell = searchCollectionView.dequeueReusableCell(withReuseIdentifier: GameLandscapeCollectionViewCell.identifier, for: indexPath) as! GameLandscapeCollectionViewCell
            cell.setup(game: searchedGames[indexPath.row])
            return cell
        } else {
            if collectionView == self.sliderCollectionView {
                let cell = sliderCollectionView.dequeueReusableCell(withReuseIdentifier: SliderCollectionViewCell.identifier, for: indexPath) as! SliderCollectionViewCell
                cell.setup(game: slider[indexPath.row])
                return cell
            } else {
                let cell = gameListCollectionView.dequeueReusableCell(withReuseIdentifier: GameLandscapeCollectionViewCell.identifier, for: indexPath) as! GameLandscapeCollectionViewCell
                cell.setup(game: gameList[indexPath.row])
                return cell
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if searching {
            return CGSize(width: view.frame.width - 20, height: 100)
        } else {
            if collectionView == self.gameListCollectionView {
                return CGSize(width: view.frame.width - 20, height: 100)
            } else {
                return CGSize(width: sliderCollectionView.frame.width - 20, height: sliderCollectionView.frame.height - 20)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if searching {
            return 5
        } else {
            if collectionView == self.gameListCollectionView {
                return 5
            } else {
                return 20
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(identifier: "GameDetailViewController") as! GameDetailViewController
        if searching {
            controller.gameId = searchedGames[indexPath.row].id
        } else {
            if collectionView == sliderCollectionView {
                controller.gameId = slider[indexPath.row].id
            } else {
                controller.gameId = gameList[indexPath.row].id
            }
        }
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: navigationController, action: nil)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        pageControl.currentPage = Int(scrollView.contentOffset.x / width)
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count >= 3 {
            sliderCollectionView.isHidden = true
            pageControl.isHidden = true
            gameListCollectionView.isHidden = true
            searchCollectionView.isHidden = false
            searchedGames = games.filter({ (game: Game) -> Bool in
                return game.name?.lowercased().contains(searchText.lowercased()) ?? false
            })
            searching = true
            searchCollectionView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        sliderCollectionView.isHidden = false
        pageControl.isHidden = false
        gameListCollectionView.isHidden = false
        searchCollectionView.isHidden = true
        searchCollectionView.reloadData()
        searchCollectionView.restore()
    }
}
