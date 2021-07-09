//
//  TableViewController.swift
//  HomeworkWeek-3
//
//  Created by Huseyn Valiyev on 4.07.2021.
//

import UIKit
import CoreData

class TableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var cooks = [CookModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getCooks()
    }

    private func getCooks() {
        cooks.removeAll()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Cook")

        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    guard let name = result.value(forKey: "name") as? String else {return}
                    guard let location = result.value(forKey: "location") as? String else {return}
                    guard let image = result.value(forKey: "image") as? NSData else {return}

                    cooks.append(CookModel(name: name, location: location, image: UIImage(data: image as Data) ?? UIImage()))
                }
                self.tableView.reloadData()
            }
        } catch {
            print("Error happening")
        }
    }
    
}

extension TableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if cooks.count == 0 {
            tableView.setEmptyView(title: "You dont have any Cook", message: "Your cooks will be listed in here")
        } else {
            tableView.restore()
        }
        
        return cooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cookCell") as! CookCell
        cell.name.text = cooks[indexPath.row].name
        cell.location.text = cooks[indexPath.row].location
        cell.cookImage.image = cooks[indexPath.row].image
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let alert = UIAlertController(title: "Delete Cook", message: "Are you sure about delete this cook", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in }))
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (action) -> Void in
                tableView.beginUpdates()
                self.cooks.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.endUpdates()
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}

extension UITableView {
    func setEmptyView(title: String, message: String) {
            
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
            
        let titleLabel = UILabel()
        let messageLabel = UILabel()
            
            
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
            
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
            
        messageLabel.textColor = UIColor.lightGray
        messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
            
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
            
            
        titleLabel.topAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
            
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        messageLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true
            
        titleLabel.text = title
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
