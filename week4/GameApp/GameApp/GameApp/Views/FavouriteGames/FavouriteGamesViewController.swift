//
//  FavouriteGamesViewController.swift
//  GameApp
//
//  Created by Huseyn Valiyev on 23.07.2021.
//

import UIKit
import CoreData

class FavouriteGamesViewController: UIViewController {
    
    @IBOutlet weak var favouriteGamesCollectionView: UICollectionView!
    
    var games: [Game] = []
    var favouriteGamesId = [Int]()
    var favouriteGames = [Game]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        getFavouriteGamesId()
        NetworkService.shared.fetchGames { [weak self] (result) in
            switch result {
            case .success(let allGames):
                self?.games = allGames.results!
                if let games = self?.games {
                    for game in games {
                        if self!.favouriteGamesId.contains(game.id ?? -1) {
                            self?.favouriteGames.append(game)
                        }
                    }
                }
                self?.favouriteGamesCollectionView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        getFavouriteGamesId()
        favouriteGames.removeAll()
        for game in games {
            if favouriteGamesId.contains(game.id ?? -1) {
                favouriteGames.append(game)
            }
        }
        favouriteGamesCollectionView.reloadData()
    }
    
    private func getFavouriteGamesId() {
        favouriteGamesId.removeAll()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favourites")
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    guard let id = result.value(forKey: "id") as? Int else { return }
                    favouriteGamesId.append(id)
                }
            }
        } catch {
            print("Error happening get Favourites")
        }
    }
    
    private func registerCell() {
        favouriteGamesCollectionView.register(UINib(nibName: GameLandscapeCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: GameLandscapeCollectionViewCell.identifier)
    }

}

extension FavouriteGamesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favouriteGames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = favouriteGamesCollectionView.dequeueReusableCell(withReuseIdentifier: GameLandscapeCollectionViewCell.identifier, for: indexPath) as! GameLandscapeCollectionViewCell
        cell.setup(game: favouriteGames[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 20, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(identifier: "GameDetailViewController") as! GameDetailViewController
        controller.gameId = favouriteGames[indexPath.row].id
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: navigationController, action: nil)
        navigationController?.pushViewController(controller, animated: true)
    }
    
}
