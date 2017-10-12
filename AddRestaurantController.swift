//
//  ViewController.swift
//  HelloWord
//
//  Created by mac on 2017/8/4.
//  Copyright © 2017年 Lai. All rights reserved.
//

import UIKit
import CoreData

class AddRestaurantController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var photoImageView: UIImageView!
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var typeTextField: UITextField!
    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var yesButton: UIButton!
    @IBOutlet var noButton: UIButton!
    @IBOutlet var phoneTextField: UITextField!
    
    var isVisited = true
    var restaurant:RestaurantMO!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .photoLibrary
                
                imagePicker.delegate = self
                
                present(imagePicker, animated: true, completion: nil)
            }
        }
    }

    // MARK: - Image Picker Delegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            photoImageView.image = selectedImage
            photoImageView.contentMode = .scaleAspectFill
            photoImageView.clipsToBounds = true
        }
        
        let leadingConstraint = NSLayoutConstraint(item: photoImageView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: photoImageView.superview, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        leadingConstraint.isActive = true
        
        let trailingConstraint = NSLayoutConstraint(item: photoImageView, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: photoImageView.superview, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
        trailingConstraint.isActive = true
        
        let topConstraint = NSLayoutConstraint(item: photoImageView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: photoImageView.superview, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        topConstraint.isActive = true
        
        let bottomConstraint = NSLayoutConstraint(item: photoImageView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: photoImageView.superview, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        bottomConstraint.isActive = true
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(sender: AnyObject) {
        if nameTextField.text == "" || typeTextField.text == "" || locationTextField.text == "" {
            let alertController = UIAlertController(title: "Oops", message: "We can't proceed because one of the fields is blank. Please note that all fields are required.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
        }
        
        print("Name: \(nameTextField.text)")
        print("Type: \(typeTextField.text)")
        print("Location: \(locationTextField.text)")
        print("Phone: \(phoneTextField.text)")
        print("Have you been here: \(isVisited)")
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            restaurant = RestaurantMO(context: appDelegate.persistentContainer.viewContext)
            restaurant.name = nameTextField.text
            restaurant.type = typeTextField.text
            restaurant.location = locationTextField.text
            restaurant.isVisited = isVisited
            restaurant.phone = phoneTextField.text
            
            if let restaurantImage = photoImageView.image {
                if let imageData = UIImagePNGRepresentation(restaurantImage) {
                    restaurant.image = NSData(data: imageData)
                }
            }
            
            print("Saving data to context ...")
            appDelegate.saveContext()
            
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func toggleBeenHereButton(sender: UIButton) {
        //按鈕＿yes
        if sender == yesButton {
            isVisited = true
          
            //改變yes按鈕為紅色
            yesButton.backgroundColor = UIColor(red: 218.0/255.0, green: 100.0/255.0, blue: 70.0/255.0, alpha: 1.0)
            
            //改變no按鈕為灰色
            noButton.backgroundColor = UIColor(red: 218.0/255.0, green: 223.0/255.0, blue: 225.0/255.0, alpha: 1.0)

        } else if sender == noButton {
            isVisited = false

            //改變yes按鈕為灰色
            yesButton.backgroundColor = UIColor(red: 218.0/255.0, green: 223.0/255.0, blue: 225.0/255.0, alpha: 1.0)

            //改變no按鈕為灰色
            noButton.backgroundColor = UIColor(red: 218.0/255.0, green: 100.0/255.0, blue: 70.0/255.0, alpha: 1.0)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
