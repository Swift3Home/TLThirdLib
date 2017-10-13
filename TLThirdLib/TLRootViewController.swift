//
//  TLRootViewController.swift
//  TLThirdLib
//
//  Created by lichuanjun on 2017/10/12.
//  Copyright © 2017年 lichuanjun. All rights reserved.
//

import UIKit

class TLRootViewController: UITableViewController {

    var titles: NSMutableArray?
    var classNames: NSMutableArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Swift Library";
        self.titles = [];
        self.classNames = [];
        
        self.addCell(title: "CryptoSwift", className: "TLCryptoSwiftVC")
        
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension TLRootViewController {
    
    fileprivate func addCell(title: String, className: String) -> (Void) {
        self.titles?.add(title)
        self.classNames?.add(className)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.titles?.count)!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier")
        
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "reuseIdentifier")
        }
        cell?.textLabel?.text = self.titles?[indexPath.row] as? String;
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 1. 取得数组内容
        guard let clsName: String = self.classNames![indexPath.row] as? String,
            let cls = NSClassFromString(Bundle.main.namespace + "." + clsName) as? UIViewController.Type else {
                print("\(self.classNames![indexPath.row] as? String) 创建失败")
                return
        }
        
        // 2. 创建视图控制器
        let vc = cls.init()
        vc.title = self.titles?[indexPath.row] as? String
        self.navigationController?.pushViewController(vc, animated: true)
        
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
