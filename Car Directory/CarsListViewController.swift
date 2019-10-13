//
//  ViewController.swift
//  Car Directory
//
//  Created by Timur Rakhimov on 07/10/2019.
//  Copyright © 2019 Timur Rakhimov. All rights reserved.
//

import UIKit
import SnapKit

class CarsListViewController: UIViewController {
    
    let tableView = UITableView()
    var cars = [Car]()
    
    private lazy var addBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .add,
                               target: self,
                               action: #selector(addBarButtonTapped))
    }()
    
    @objc func addBarButtonTapped() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createCarArray()
        setupTableView()
        setupNavigationBar()
        
    }
    
    func createCarArray() {
        cars.append(Car(manufacturer: "Volvo", yearOfRelease: 1994, model: "XC90", bodyType: "Sedan"))
        cars.append(Car(manufacturer: "Volvo", yearOfRelease: 1995, model: "XC90", bodyType: "Sedan"))
        cars.append(Car(manufacturer: "Volvo", yearOfRelease: 1995, model: "XC90", bodyType: "Sedan"))
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension CarsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CarCell", for: indexPath) as? CarCell else {
            fatalError("The cell is nil")
        }
        cell.car = cars[indexPath.row]
        return cell
    }
}

// MARK: - Setup
extension CarsListViewController {
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self

        tableView.register(CarCell.self, forCellReuseIdentifier: "CarCell")
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    func setupNavigationBar() {
        navigationItem.title = "Cars"
        navigationItem.rightBarButtonItem = addBarButtonItem
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}


