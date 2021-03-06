//
//  CommentsVC.swift
//  Taqyeem
//
//  Created by mac on 12/14/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit
import GrowingTextView
class CommentsVC: UIViewController {
    
    @IBOutlet weak var lblNone: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    var resturant : Resturant =  Resturant()
    @IBOutlet weak var barButonItemTitle: UIBarButtonItem!
    var comments: [CommentVM]?
    var storeID : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource =  self
        tableView.reloadData()
        barButonItemTitle.title = "تعليقات مطعم  " + (resturant.storeArabicName ?? resturant.storeNameBanner ?? "") 
        self.navigationItem.setHidesBackButton(true, animated:false)
        self.tabBarController?.tabBar.isHidden = true
        barButonItemTitle.tintColor =  UIColor.white
        getData()
        
        
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func getData()  {
        self.startLoadingActivity()
        CommentVM.getAllComments(storeID:self.resturant.storeId ?? 0){ comments , error in
            self.stopLoadingActivity()
            if error != nil {
                self.showAlert(message: error!)
                return
            }
            guard let comments = comments else {return}
            self.comments = comments
            self.tableView.isHidden = comments.count == 0
            self.lblNone.isHidden = comments.count != 0
            
            self.tableView.delegate =  self
            self.tableView.dataSource =  self
            self.tableView.reloadData()
            
        }
    }
}
extension CommentsVC : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.comments?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
        cell.configure(comment: self.comments![indexPath.row])
        return cell
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
