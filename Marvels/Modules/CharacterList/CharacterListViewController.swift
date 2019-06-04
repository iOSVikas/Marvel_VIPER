//
//  CharacterListViewController.swift
//  Marvels
//
//  Created by Vikas on 02/06/19.
//  Copyright © 2019 Vikas. All rights reserved.
//

import UIKit

class CharacterListViewController: UIViewController {

    var presenter: CharacterListPresenter!
    
    private var isLoading: Bool = false
    private var isCanceledRequest = false
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad()
        self.setupTableView()
    }
}

//MARK: Supporting functions
extension CharacterListViewController: CharacterListViewProtocol {
    
    func setupTableView() {
        tableView.register(UINib(nibName: "CharactersListCell",
                                 bundle: nil),
                           forCellReuseIdentifier: CharactersListCell.reuseIdentifier)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func showLoader(message: String?) {
        MLoader.shared.showLoader(message: message ?? "")
    }
    
    func hideLoader() {
        MLoader.shared.hideLoader()
    }
    
    func showFooterLoader() {
        let spinner = UIActivityIndicatorView(style: .white)
        spinner.startAnimating()
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0),
                               width: tableView.bounds.width, height: CGFloat(60))
        
        tableView.tableFooterView = spinner
        tableView.tableFooterView?.isHidden = false
        isLoading = true
    }
    
    func hideFooterLoader() {
        tableView.tableFooterView = UIView()
        tableView.tableFooterView?.isHidden = true
        isLoading = false
    }
    
    func setRefreshButton() {
        let rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "refresh"), style: .done,
                                                      target: self, action: #selector(self.didSelectRefreshButton))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    func removeRefreshButton() {
        self.navigationItem.rightBarButtonItem = nil
    }
    
    @objc func didSelectRefreshButton() {
        self.isCanceledRequest = false
        self.presenter.loadCaractersList()
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message,preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Reload!", style: UIAlertAction.Style.default, handler: { _ in
            self.isCanceledRequest = false
            self.presenter.loadCaractersList()
            self.removeRefreshButton()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel!", style: UIAlertAction.Style.default, handler: { _ in
            //Cancel Action
            self.isCanceledRequest = true
            self.setRefreshButton()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}

//MARK: UITableView Delegate and Datasource

extension CharacterListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfCharacters()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharactersListCell.reuseIdentifier, for: indexPath) as! CharactersListCell
        let character = presenter.characterAt(indexPath: indexPath)
        cell.configure(character: character)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == presenter.numberOfCharacters() - 4 {
            if (isLoading == false && isCanceledRequest != true) {
                self.presenter.loadCaractersList()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.showCharacterDetail(indexpath: indexPath, navigationController: self.navigationController!)
    }
}

//MARK: ViewModel Interactor methods
extension CharacterListViewController {
    
    func refreshList(indexPathList: [IndexPath]) {
        if indexPathList.count > 0 {
            tableView.insertRows(at: indexPathList, with: .automatic)
        }
    }
}
