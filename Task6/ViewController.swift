//
//  ViewController.swift
//  Task6
//
//  Created by Mac on 07/03/23.
//

import UIKit
import SDWebImage
class ViewController: UIViewController {
    var detailVC = UserDetailViewController()
    @IBOutlet weak var usersTableView: UITableView!
    var users = [User]()
    override func viewDidLoad() {
        super.viewDidLoad()
        jsonParsing()
        tableView()
        
    }
    func tableView(){
        usersTableView.dataSource = self
        usersTableView.delegate = self
        let uinib = UINib(nibName: "UserTableViewCell", bundle: nil)
        self.usersTableView.register(uinib, forCellReuseIdentifier: "UserTableViewCell")
    }
    func jsonParsing(){
        var urlString = "https://reqres.in/api/users?page=2"
        var url = URL(string: urlString)
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"
        URLSession.shared.dataTask(with: urlRequest){data,response,error in
            print(String(data: data!, encoding: .utf8)!)
            let getJsonObject = try! JSONSerialization.jsonObject(with: data!) as! [String : Any]
            let jsonObject = getJsonObject["data"] as! [[String : Any]]
            for eachDictionary in jsonObject{
                let userId = eachDictionary["id"] as! Int
                let userFName = eachDictionary["first_name"] as! String
                let userLName = eachDictionary["last_name"] as! String
                let userEmail = eachDictionary["email"] as! String
                let userAvatar = eachDictionary["avatar"] as! String
                let newUserObject = User(id: userId, email: userEmail, first_name: userFName, last_name: userLName, avatar: userAvatar)
                self.users.append(newUserObject)
                DispatchQueue.main.async {
                    self.usersTableView.reloadData()
                }
            }

        }.resume()
     }
}
extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.usersTableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
        cell.idLabel.text = "Id: \(users[indexPath.row].id)"
        cell.nameLabel.text = " Name : \(users[indexPath.row].first_name)"
        let urlString = users[indexPath.row].avatar
        let url = URL(string: urlString)
        cell.avtarImg.sd_setImage(with: url)
        cell.layer.borderWidth = 10
        cell.layer.cornerRadius = 20
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        detailVC = self.storyboard?.instantiateViewController(withIdentifier: "UserDetailViewController") as! UserDetailViewController
        detailVC.user = users[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }

}
