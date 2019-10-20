//
//  ViewController.swift
//  Car Directory
//
//  Created by Timur Rakhimov on 07/10/2019.
//  Copyright © 2019 Timur Rakhimov. All rights reserved.
//

import UIKit
import SnapKit
import RealmSwift

final class CarsListViewController: UIViewController {
    
    private let tableView = UITableView()
    private var cars: Results<Car>? 
    
    private lazy var addBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .add,
                               target: self,
                               action: #selector(addBarButtonTapped))
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.cars = Car.all()
        self.setupTableView()
        self.setupNavigationBar()
    }

    @objc func addBarButtonTapped() {
        self.addCar()
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension CarsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cars?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CarCell", for: indexPath) as? CarTableViewCell else {
            fatalError("The cell is nil")
        }
        cell.car = self.cars?[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let car = cars?[indexPath.row]
        self.edit(car)
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let car = cars?[indexPath.row], editingStyle == .delete else { return }
        car.delete()
        self.tableView.reloadData()
    }
}

// MARK: - Setup UI
private extension CarsListViewController {
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

// MARK: - Actions
private extension CarsListViewController {
    func addCar() {
        let addEditDetailsViewController = AddEditDetailsViewController()
        self.present(UINavigationController(rootViewController: addEditDetailsViewController), animated: true) {
            addEditDetailsViewController.completionHandler = { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    func edit(_ car: Car?) {
        let addEditDetailsViewController = AddEditDetailsViewController()
        addEditDetailsViewController.car = car
        let navigationController = UINavigationController(rootViewController: addEditDetailsViewController)
        self.present(navigationController, animated: true) {
            addEditDetailsViewController.completionHandler = { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
}
