//
//  GameDetailViewController.swift
//  GameApp
//
//  Created by Huseyn Valiyev on 22.07.2021.
//

import UIKit
import Kingfisher
import CoreData

class GameDetailViewController: UIViewController {
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var gameRatingLabel: UILabel!
    @IBOutlet weak var gameReleaseDateLabel: UILabel!
    @IBOutlet weak var gameDescriptionTextField: UITextView!
    @IBOutlet weak var addFavourite: UIImageView!
    
    var gameId: Int!
    var favouriteGames = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addFavourite.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapFavouriteButton))
        addFavourite.addGestureRecognizer(tapRecognizer)
        gameDescriptionTextField.isEditable = false
        NetworkService.shared.fetchGameWithId(gameId: gameId) { [weak self] (result) in
            switch result {
            case .success(let game):
                self?.gameImageView.kf.setImage(with: game.imageURL)
                self?.gameNameLabel.text = game.name
                self?.gameRatingLabel.text = "Metacritic Rate:\(game.metacritic!)"
                self?.gameReleaseDateLabel.text = game.releaseDate
                self?.gameDescriptionTextField.text = String(htmlEncodedString: game.description!)
                self?.title = game.name
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        getFavouriteGames()
        if favouriteGames.contains(gameId) {
            addFavourite.image = UIImage(systemName: "heart.fill")
        }
    }
    
    private func getFavouriteGames() {
        favouriteGames.removeAll()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favourites")
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    guard let id = result.value(forKey: "id") as? Int else { return }
                    favouriteGames.append(id)
                }
            }
        } catch {
            print("Error happening get Favourites")
        }
    }
    
    @objc func tapFavouriteButton() {
        if addFavourite.image == UIImage(systemName: "heart") {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let context = appDelegate.persistentContainer.viewContext
            let newFavouriteGame = NSEntityDescription.insertNewObject(forEntityName: "Favourites", into: context)
            newFavouriteGame.setValue(gameId, forKey: "id")
            do {
                try context.save()
            } catch  {
                print("Error happening while adding favourite")
            }
            addFavourite.image = UIImage(systemName: "heart.fill")
        } else {
            let alert = UIAlertController(title: "Remove From Favourites", message: "Are you sure about remove from favourites?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in }))
            alert.addAction(UIAlertAction(title: "Remove", style: .destructive, handler: { (action) in
                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
                let context = appDelegate.persistentContainer.viewContext
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Favourites")
                fetchRequest.predicate = NSPredicate(format: "id = %@", "\(self.gameId ?? -1)")
                do {
                    let fetchedResults =  try context.fetch(fetchRequest) as? [NSManagedObject]
                    self.addFavourite.image = UIImage(systemName: "heart")
                    for entity in fetchedResults! {
                        context.delete(entity)
                    }
                    try context.save()
                } catch {
                    print("Error happening delete")
                }
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }

}
