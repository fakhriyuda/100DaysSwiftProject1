//
//  ListWebViewController.swift
//  Yuda Ios 4
//
//  Created by ISYS Macbook air 1 on 04/06/24.
//

import UIKit

class ListWebViewController: UITableViewController {
    var websites = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        websites = GlobalList().websites
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Navigate")
        let vc = storyboard?.instantiateViewController(withIdentifier: "WebView") as! ViewController
        vc.link = websites[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Link", for: indexPath)
        cell.textLabel?.text = websites[indexPath.row]
        return cell
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
