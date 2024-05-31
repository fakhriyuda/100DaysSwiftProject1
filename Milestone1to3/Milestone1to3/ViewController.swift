//
//  ViewController.swift
//  Milestone1to3
//
//  Created by ISYS Macbook air 1 on 30/05/24.
//

import UIKit

class ViewController: UITableViewController {
    
    var flags = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "Around the world"
        navigationController?.navigationBar.prefersLargeTitles = true
        let fm = FileManager.default
        let path = Bundle.main.resourcePath
        let items = try? fm.contentsOfDirectory(atPath: path ?? "")
        
        if let assetItems = items {
            for item in assetItems {
                if item.hasSuffix("png") {
                    flags.append(item)
                }
            }
            print(flags)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        flags.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Country", for: indexPath)
        cell.textLabel?.text = (flags[indexPath.row].capitalized as NSString).deletingPathExtension
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController{
            vc.imageToLoad = flags[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }


}

