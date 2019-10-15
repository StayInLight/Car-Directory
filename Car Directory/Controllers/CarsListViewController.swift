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
    private var cars = [Car]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    private lazy var addBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .add,
                               target: self,
                               action: #selector(addBarButtonTapped))
    }()
    
    @objc func addBarButtonTapped() {
        let addEditDetailsViewController = AddEditDetailsViewController()
        self.present(UINavigationController(rootViewController: addEditDetailsViewController), animated: true) {
            addEditDetailsViewController.completionHandler = { [weak self] car in
                self?.cars.append(car)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.setupNavigationBar()
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension CarsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CarCell", for: indexPath) as? CarTableViewCell else {
            fatalError("The cell is nil")
        }
        cell.car = self.cars[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let car = cars[indexPath.row]
        let addEditDetailsViewController = AddEditDetailsViewController()
        addEditDetailsViewController.car = car
        let navigationController = UINavigationController(rootViewController: addEditDetailsViewController)
        self.present(navigationController, animated: true) {
            addEditDetailsViewController.completionHandler = { [weak self] car in
                self?.cars.remove(at: indexPath.row)
                self?.cars.insert(car, at: indexPath.row)
            }
        }
    }
}

// MARK: - Setup UI
extension CarsListViewController {
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self

        self.tableView.register(CarTableViewCell.self, forCellReuseIdentifier: "CarCell")
        
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

