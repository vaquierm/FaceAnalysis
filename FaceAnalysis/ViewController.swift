//
//  ViewController.swift
//  FaceAnalysis
//
//  Created by Michael Vaquier on 2017-10-08.
//  Copyright © 2017 Michael Vaquier. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var pickedImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func analyzeaction(_ sender: UIButton) {
        
        let imageData:Data = UIImageJPEGRepresentation(pickedImage.image!, 0.6)! as Data
        
        let myUrl = URL(string: "https://westus.api.cognitive.microsoft.com/emotion/v1.0/recognize");
        let request = NSMutableURLRequest(url: myUrl!);
        request.setValue("", forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        request.setValue("application/octet-stream", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST";
        request.httpBody = imageData
        let uploadSession = URLSession.shared
        let postRequest = uploadSession.dataTask(with: request as URLRequest) { (data, response, error) in
            if error != nil {
                print("error: " , error)
            } else {
                if let usableData = data {
                    var dataString = String(data: usableData, encoding: .utf8)
                    var scoresArr = dataString!.components(separatedBy: "scores\":")
                    var scoresFull = scoresArr[1]
                    let i = scoresFull.index(scoresFull.startIndex, offsetBy: 1)..<scoresFull.index(scoresFull.endIndex, offsetBy: -3)
                    let scores = scoresFull[i]
                    let scoresFormatted = scores.replacingOccurrences(of: ",", with: "\n")
                    print(scoresFormatted)
                    self.responsePopUp(message: scoresFormatted)
                }
            }
        }
        postRequest.resume()
        
    }
    

    @IBAction func camerabuttonaction(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    

    @IBAction func photolibraryaction(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let imagePicker = UIImagePickerController();
            imagePicker.delegate = self;
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func saveaction(_ sender: UIButton) {
        let imageData = UIImageJPEGRepresentation(pickedImage.image!, 0.6)
        let compressedJPEGImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compressedJPEGImage!, nil, nil, nil)
        saveNotice()
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        pickedImage.image = image
        self.dismiss(animated: true, completion: nil);
    }
    
    
    func saveNotice() {
        let alertController = UIAlertController(title: "Image Saved!", message: "Your picture was saved to your library.", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController,animated: true, completion: nil)
    }
    
    func responsePopUp(message: String) {
        let alertController = UIAlertController(title: "Response received!", message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController,animated: true, completion: nil)
    }
    
}

