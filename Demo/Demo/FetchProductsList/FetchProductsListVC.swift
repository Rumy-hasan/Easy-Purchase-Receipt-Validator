//
//  FetchProductsListVC.swift
//  Demo
//
//  Created by BJIT on 17/10/23.
//

import UIKit

class FetchProductsListVC: UIViewController {
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var tableViewX: UITableView!
    static var viewModel = FetchProductListViewModel()
    var productList: FetchList = FetchList(consumable: [], nonConsumable: [], nonRenewable: [], autoRenewable: [])
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        setupBinders()
        FetchProductsListVC.viewModel.getPurchasableProducts()
    }
    func setupBinders() {
        FetchProductsListVC.viewModel.fetchList.bind(listener: { [weak self] fetchedList in
            DispatchQueue.main.async {
                self?.loader.stopAnimating()
            }
            guard let fetchedList else {
                return
            }
            self?.productList = fetchedList
            DispatchQueue.main.async { [weak self] in
                self?.tableViewX.reloadData()
            }
        })
    }
    
    func initialSetup() {
        tableViewX.delegate = self
        tableViewX.dataSource = self
        let nib = UINib(nibName: "ProductCell", bundle: nil)
        tableViewX.register(nib, forCellReuseIdentifier: "ProductCell")
    }
}

extension FetchProductsListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_: UITableView, heightForHeaderInSection _: Int) -> CGFloat {
        return 30 // Set the height of the header to 100 points
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 30))
        headerView.backgroundColor = .clear
        let headerLabel = UILabel(frame: CGRect(x: 10, y: 0, width: tableView.frame.width - 30, height: 20))
        if section == 0 {
            headerLabel.text = "Consumable"
        } else if section == 1 {
            headerLabel.text = "Non-Consumable"
        } else if section == 2 {
            headerLabel.text = "Non-Renewable"
        } else {
            headerLabel.text = "Auto-Renewable"
        }
        headerLabel.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        headerLabel.textColor = #colorLiteral(red: 0.2078385055, green: 0.2078467906, blue: 0.3428357244, alpha: 0.7636330712)
        headerView.addSubview(headerLabel)

        return headerView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return productList.consumable.count
        case 1:
            return productList.nonConsumable.count
        case 2:
            return productList.nonRenewable.count
        case 3:
            return productList.autoRenewable.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableViewX.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as? ProductCell else {
            return UITableViewCell()
        }
        cell.view.layer.cornerRadius = 10
        cell.productImage.layer.cornerRadius = 10
        if indexPath.section == 0 {
            cell.productTitle.text = productList.consumable[indexPath.row].localizedTitle
            cell.productPrice.text = "$ \(productList.consumable[indexPath.row].price)"
            cell.productImage.image = UIImage(named: "consume")
        } else if indexPath.section == 1 {
            cell.productTitle.text = productList.nonConsumable[indexPath.row].localizedTitle
            cell.productPrice.text = "$ \(productList.nonConsumable[indexPath.row].price)"
            cell.productImage.image = UIImage(named: "level")
        } else if indexPath.section == 2 {
            cell.productTitle.text = productList.nonRenewable[indexPath.row].localizedTitle
            cell.productPrice.text = "$ \(productList.nonConsumable[indexPath.row].price)"
            cell.productImage.image = UIImage(named: "nonrenew")
        } else {
            cell.productTitle.text = productList.autoRenewable[indexPath.row].localizedTitle
            cell.productPrice.text = "$ \(productList.nonConsumable[indexPath.row].price)"
            cell.productImage.image = UIImage(named: "autorenew")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableViewX.deselectRow(at: indexPath, animated: true)

        if indexPath.section == 0 {
            FetchProductsListVC.viewModel.buyProduct(productList.consumable[indexPath.row])
        } else if indexPath.section == 1 {
            FetchProductsListVC.viewModel.buyProduct(productList.nonConsumable[indexPath.row])
        } else if indexPath.section == 2 {
            FetchProductsListVC.viewModel.buyProduct(productList.nonRenewable[indexPath.row])
        } else {
            FetchProductsListVC.viewModel.buyProduct(productList.autoRenewable[indexPath.row])
        }
    }
}
