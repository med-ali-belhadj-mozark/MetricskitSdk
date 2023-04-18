//
//  QSLogsViewController.swift
//  QosiMetrics
//
//  Created by Mohamed Ali BELHADJ on 17/01/2023.
//

import UIKit

class QSLogsViewController: UIViewController {

    @IBOutlet var logsListView: UITableView?
    var logsFileName : [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Lists des logs reçus par jour"
        self.logsListView?.register(UINib(nibName: "QSLogsItemCell", bundle: Bundle(for: QSLogsItemCell.self)), forCellReuseIdentifier: QSLogsItemCell.identifier)
        self.logsFileName = QSMetrics.framework.getLogsFileNames()
        DispatchQueue.main.async {
            self.logsListView?.reloadData()
        }
    }
    // MARK: - Actions
    @IBAction func dismissVc(_ sender: UIButton) {
        self.dismiss(animated: true)
    }

}
extension QSLogsViewController : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.logsFileName.count
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: QSLogsItemCell.identifier, for: indexPath) as! QSLogsItemCell
        cell.logItemLabel?.text = self.logsFileName[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let qsLogDetailsVc = QSLogDetailsViewController(nibName: "QSLogDetailsViewController", bundle: Bundle(for: type(of: self)))
        qsLogDetailsVc.title = self.logsFileName[indexPath.row]
        qsLogDetailsVc.metricsContent = QSMetrics.framework.getEquivalentLogForFileAtIndex(index: indexPath.row)
        self.navigationController?.pushViewController(qsLogDetailsVc, animated: true)
    }
}
