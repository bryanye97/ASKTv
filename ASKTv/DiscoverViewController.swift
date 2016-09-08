//
//  DiscoverViewController.swift
//  ASKTv
//
//  Created by Bryan Ye on 11/08/2016.
//  Copyright © 2016 Bryan Ye. All rights reserved.
//

import UIKit
import Firebase

class DiscoverViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var videoAnswers = [VideoAnswer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self


        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let answersRef = ref.child("VideoAnswers")
        
        answersRef.observeSingleEventOfType(.Value) { (snapshot: FIRDataSnapshot) in
            self.videoAnswers = []
            for snap in snapshot.children {
                let videoAnswer = VideoAnswer(snap: snap as! FIRDataSnapshot)
                self.videoAnswers.append(videoAnswer)
                self.tableView.reloadData()
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DiscoverViewController: UITableViewDelegate {
    
}

extension DiscoverViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let videoAnswer = videoAnswers[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! DiscoverTableViewCell
        cell.backgroundColor = UIColor.cyanColor()
        cell.videoAnswer = videoAnswer
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoAnswers.count
    }
}
