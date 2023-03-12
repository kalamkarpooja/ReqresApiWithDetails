//
//  UserDetailViewController.swift
//  Task6
//
//  Created by Mac on 07/03/23.
//

import UIKit

class UserDetailViewController: UIViewController {

    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userId: UILabel!
    @IBOutlet weak var userImg: UIImageView!
    var user:User?
    override func viewDidLoad() {
        super.viewDidLoad()
        userName.text = "Name: \(user!.first_name + " " + user!.last_name)"
        userId.text = "Id: \(String(user!.id))"
        userEmail.text = "Email: \(String(user!.email))"
        let url = URL(string: user!.avatar)
        userImg.sd_setImage(with: url!)
        userImg.layer.cornerRadius = 30
       
    }
}
