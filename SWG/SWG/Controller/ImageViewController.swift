//
//  ImageViewController.swift
//  SWG
//
//  Created by Максим Сулим on 28.06.2023.
//

import UIKit

class ImageViewController: UIViewController {
        
    
    var urlImage: String?
    var segment: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadImage(text: urlImage, segment: segment!)
    }
    
    @IBOutlet weak var imageButton: UIButton!
    
    @IBAction func tapImageButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func loadImage(text: String?, segment: Int) {
        
        if let urlString = text {
            
            DispatchQueue.main.async {
                NetworkRequest.shared.request(stringUrl: urlString) { result in
                    switch result {
                        
                    case .success(let data):
                        if segment == 0 {
                            
                            let image = UIImage(data: data)
                            let cgW = self.view.frame.width
                            let cgH = self.view.frame.height
                            
                            let destonationSize = CGSize(width: cgW, height: cgH)
                            
                            let newImage = UIImageView(frame: CGRect(x: 0, y: 0, width: cgW, height: cgH))
                            newImage.image = image
                            self.view.addSubview(newImage)
                            
                            self.imageButton.imageView?.contentMode = .scaleAspectFill
                            
                        } else {
                            let image = UIImage(data: data)
                            let cgW = self.view.frame.width
                            let cgH = self.view.frame.height
                            
                            let destonationSize = CGSize(width: cgW, height: cgH)
                            
                            let newImage = UIImageView(frame: CGRect(x: 0, y: 0, width: cgW, height: cgH))
                            newImage.image = image
                            self.view.addSubview(newImage)
                            self.imageButton.imageView?.contentMode = .scaleAspectFit
                        }
                        
                    case .failure(let error ):
                        print(error.localizedDescription)
                        self.imageButton.imageView?.image = UIImage(systemName: "person.fill")
                        self.imageButton.imageView?.contentMode = .scaleAspectFit
                    }
                }
            }
        }
        
        
    }
}
