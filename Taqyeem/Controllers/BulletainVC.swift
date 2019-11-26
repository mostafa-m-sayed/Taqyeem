//
//  BulletainVC.swift
//  Taqyeem
//
//  Created by Mostafa sayed on 11/26/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit

class BulletainVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
    }
    
    func initNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.title = "النشرات التوعوية"
        navigationItem.setHidesBackButton(true, animated: false)
    }
}
extension BulletainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GeneralNewsCell", for: indexPath) as! GeneralNewsCell
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}