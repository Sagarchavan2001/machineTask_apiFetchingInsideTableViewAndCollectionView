//
//  ViewController.swift
//  apiFetchingInCollectionViewAndTableView
//
//  Created by STC on 17/12/22.
//

import UIKit
import SDWebImage
class ViewController: UIViewController {
    var product = [apiResponce1]()
    var users = [apiResponce2]()

    @IBOutlet weak var productImageCollectionView: UICollectionView!
    
    @IBOutlet weak var userTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        datasourceAndDelegate()
        registerNib1()
        apiFetchingproduct(){
            self.productImageCollectionView.reloadData()
        }
        apiFetchingUser(){
            self.userTableView.reloadData()
        }
        
    }
    func datasourceAndDelegate(){
        productImageCollectionView.delegate = self
        productImageCollectionView.dataSource = self
        userTableView.delegate = self
        userTableView.dataSource = self
        
    }
    func registerNib1()
    {
        let nibname = UINib(nibName: "productCollectionViewCell", bundle: nil)
        productImageCollectionView.register(nibname, forCellWithReuseIdentifier: "productCollectionViewCell")
        let nibname2 = UINib(nibName: "UserTableViewCell", bundle: nil)
        userTableView.register(nibname2, forCellReuseIdentifier: "UserTableViewCell")
    }
    func apiFetchingproduct(completed : @escaping() ->()){
        let apiUrl = "https://fakestoreapi.com/products"
        guard let url = URL(string: apiUrl) else {
            print("data not found")
            return
        }
        URLSession.shared.dataTask(with: url){ data ,  responce, error in
         if(error == nil)
            {
             do{
                 
                 let jsondecoder = JSONDecoder()
                 self.product = try! jsondecoder.decode([apiResponce1].self, from: data!)
             }catch{
                 print("error")
             }
             DispatchQueue.main.async {
                 completed()
             }
         }
            
        }.resume()
    }
    func apiFetchingUser(completed : @escaping() ->()){
        
        let apiUrl = "https://fakestoreapi.com/users"
        guard let url = URL(string: apiUrl) else {
            print("data not found")
            return
        }
        URLSession.shared.dataTask(with: url){ data ,  responce, error in
         if(error == nil)
            {
             do{
                 
                 let jsondecoder = JSONDecoder()
                 self.users = try! jsondecoder.decode([apiResponce2].self, from: data!)
             }catch{
                 print("error")
             }
             DispatchQueue.main.async {
                 completed()
             }
         }
            
        }.resume()
    }


}
extension ViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return product.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionViewcell = productImageCollectionView.dequeueReusableCell(withReuseIdentifier: "productCollectionViewCell", for: indexPath)as! productCollectionViewCell
        let imgurl = NSURL(string: product[indexPath.row].image)
        collectionViewcell.imageOnCollectionCell.sd_setImage(with: imgurl as! URL?)
        return collectionViewcell
    }
    
    
}
extension ViewController : UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 200, height: 150)
    }
}
extension ViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = userTableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath)as! UserTableViewCell
        tableCell.firstNameLabel.text = users[indexPath.row].name.firstname
        tableCell.lastNameLabel.text = users[indexPath.row].name.lastname
        return tableCell
    }
    
    
}
