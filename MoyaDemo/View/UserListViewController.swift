//
//  UserListViewController.swift
//  MoyaDemo
//

import UIKit
import Moya

class UserListViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    
    private var users: [User] = []
    private let networkManager: NetworkManager = NetworkManager()
    
    // MARK: - Constant
    private let identifier = "cell"
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUsers()
    }
}

// MARK: - UITableview Datasource Methods

extension UserListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) ??
        UITableViewCell(style: .default, reuseIdentifier: identifier)
        cell.textLabel!.text = users[indexPath.row].title
        return cell
    }
}

// MARK: - UITableview Delegate Methods

extension UserListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "UserDetailViewController") as! UserDetailViewController
        vc.userId = users[indexPath.row].id
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - API CALL

extension UserListViewController {
    
    private func loadUsers() {
        startLoading()
        networkManager.fetchUsers { [weak self] result in
            guard let strongSelf = self else { return }
            strongSelf.stopLoading()
            switch result {
            case .success(let userResponse):
                strongSelf.users = userResponse
                strongSelf.tableview.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
