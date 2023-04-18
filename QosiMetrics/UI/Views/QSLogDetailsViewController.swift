//
//  QSLogDetailsViewController.swift
//  QosiMetrics
//
//  Created by Mohamed Ali BELHADJ on 18/01/2023.
//

import UIKit

class QSLogDetailsViewController: UIViewController {

    @IBOutlet var logTextView: UITextView?
    var metricsContent : NSMutableAttributedString?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let metricsContent = self.metricsContent
        {
            self.logTextView?.attributedText = metricsContent
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
