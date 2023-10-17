//
//  FetchProductsListVC.swift
//  Demo
//
//  Created by BJIT on 17/10/23.
//

import UIKit

class FetchProductsListVC: UIViewController {
    @IBOutlet weak var tableViewX: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        // Do any additional setup after loading the view.
    }
    
    func initialSetup() {
        tableViewX.delegate = self
        tableViewX.dataSource = self

        let nib = UINib(nibName: "ProductCell", bundle: nil)
        tableViewX.register(nib, forCellReuseIdentifier: "ProductCell")
    }
}

extension FetchProductsListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableViewX.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as? ProductCell else {
            return UITableViewCell()
        }
        cell.view.layer.cornerRadius = 10
        cell.productImage.layer.cornerRadius = 10
        return cell
    }
}
