//
//  ViewController.swift
//  Car Directory
//
//  Created by Timur Rakhimov on 07/10/2019.
//  Copyright © 2019 Timur Rakhimov. All rights reserved.
//

import UIKit
import SnapKit

final class CarsListViewController: UIViewController {
    
    private let tableView = UITableView()
    private var cars = [Car]()
    
    private lazy var addBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .add,
                               target: self,
                               action: #selector(addBarButtonTapped))
    }()
    
    @objc func addBarButtonTapped() {
        let addDetailsViewController = AddDetailsViewController()
        self.present(addDetailsViewController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createCarArray()
        self.setupTableView()
        self.setupNavigationBar()
        
    }
    
    func createCarArray() {
        self.cars.append(Car(manufacturer: "Volvo", yearOfRelease: 1994, model: "XC90", bodyType: "Sedan"))
        self.cars.append(Car(manufacturer: "Volvo", yearOfRelease: 1995, model: "XC90", bodyType: "Sedan"))
        self.cars.append(Car(manufacturer: "Volvo", yearOfRelease: 1995, model: "XC90", bodyType: "Sedan"))
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension CarsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CarCell", for: indexPath) as? CarCell else {
            fatalError("The cell is nil")
        }
        cell.car = self.cars[indexPath.row]
        return cell
    }
}

// MARK: - Setup
extension CarsListViewController {
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self

        self.tableView.register(CarCell.self, forCellReuseIdentifier: "CarCell")
        
        self.view.addSubview(tableView)
        self.tableView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    func setupNavigationBar() {
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "Cars"
        self.navigationItem.rightBarButtonItem = addBarButtonItem
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}


