//
//  ViewController.swift
//  Useful_Closures_2
//
//  Created by Jon Hoffman on 1/26/15.
//  Copyright (c) 2015 Jon Hoffman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tableView:UITableView?
    var tableData: [String]?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getData() {
        let dataClosure: Guests.UseArrayClosure = {
            self.tableData = $0
            if let tView = self.tableView {
                tView.reloadData()
            }
        }
        
        let guests = Guests()
        guests.getGuest(dataClosure)
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        if let tData = tableData {
            return tData.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView!,cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
        let cell:UITableViewCell = UITableViewCell(style:UITableViewCellStyle.Default, reuseIdentifier:"cell")
        if let tData = tableData {
            cell.textLabel?.text = tData[indexPath.row]
        }
        
        return cell
    }

}

