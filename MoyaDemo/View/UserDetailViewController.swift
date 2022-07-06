//
//  UserDetail.swift
//  MoyaDemo
//

import UIKit

class UserDetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var userIdLabel: UILabel!
    
    private var user: User?
    private let networkManager: NetworkManager = NetworkManager()
    var userId: Int = 0
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUsers(userId: userId)
    }
    
    private func setData(_ user: User) {
        userIdLabel.text = "Id: \(user.id)"
        titleLabel.text = "Title: \(user.title)"
    }
}

// MARK: - API CALL

extension UserDetailViewController {
    
    private func loadUsers(userId: Int) {
        startLoading()
        networkManager.fetchUserDetail(userId: userId, completion: { [weak self] result in
            guard let strongSelf = self else { return }
            strongSelf.stopLoading()
            switch result {
            case .success(let userResponse):
                strongSelf.setData(userResponse)
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}
