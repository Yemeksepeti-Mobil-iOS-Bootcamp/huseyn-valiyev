//
//  CookCreateViewController.swift
//  HomeworkWeek-3
//
//  Created by Huseyn Valiyev on 7.07.2021.
//

import UIKit
import CoreData

class CookCreateViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    @IBOutlet weak var cookImage: UIImageView!
    @IBOutlet weak var cookName: UITextField!
    @IBOutlet weak var cookLocation: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let notificationCenter: NotificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self, selector: #selector(self.changeLocation(notification:)), name: .sendLocationNameNotification, object: nil)
        
        cookImage.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(choosePhoto))
        cookImage.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func changeLocation(notification: NSNotification) {
        if let dataDict = notification.userInfo?["data"] as? String {
            cookLocation.text = dataDict
        }
    }
    
    @objc func choosePhoto() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        cookImage.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cookCreate(_ sender: Any) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        let newCook = NSEntityDescription.insertNewObject(forEntityName: "Cook", into: context)
        newCook.setValue(cookName.text, forKey: "name")
        newCook.setValue(cookLocation.text, forKey: "location")
        let imageData = cookImage.image?.jpegData(compressionQuality: 0.5)
        newCook.setValue(imageData, forKey: "image")
        
        do {
            try context.save()
        } catch  {
            print("Kaydedilemedi...")
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
}
