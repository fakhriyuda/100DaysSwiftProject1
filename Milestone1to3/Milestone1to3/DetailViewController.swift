//
//  DetailViewController.swift
//  Milestone1to3
//
//  Created by ISYS Macbook air 1 on 31/05/24.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var flagImage: UIImageView!
    
    var imageToLoad : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        flagImage.image = UIImage(named: imageToLoad ?? "")
        flagImage.layer.borderWidth = 0.3
        flagImage.layer.borderColor = UIColor.lightGray.cgColor

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
