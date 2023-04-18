//
//  QosiMetrics.swift
//  Qosi-Metric-iOS
//
//  Created by Mohamed Ali BELHADJ on 17/01/2023.
//

import Foundation
import MetricKit
import UIKit

public class QSMetrics:NSObject {
    
    internal static let mainDirectoryName = "MetricKit"
    internal static let metricsDirectoryName = "Metrics"
    internal static let diagnosticsDirectoryName = "Diagnostics"
    internal static let metricPayloadDirectoryName = "MetricPayload"

    public enum QSSignPostType {
        case begin
        case end
        case event
    }
    
    /// Framework main accessor
    public static let framework = QSMetrics()
    
    private var currentVc : UIViewController?
    
    public func signPost(singPostType:QSSignPostType,log : String, name:StaticString)
    {
        mxSignpost(self.getEquivalentSignType(singPostType: singPostType), log: MXMetricManager.makeLogHandle(category: log), name: name)
    }
    
    func getEquivalentSignType(singPostType:QSSignPostType) -> OSSignpostType {
        
        switch singPostType {
        case .begin:
            return OSSignpostType.begin
        case .end:
            return OSSignpostType.end
        case .event:
            return OSSignpostType.event
        }
    }
    public func start(debug:Bool=false) {
        let metricManager = MXMetricManager.shared
        metricManager.add(self)
        if debug == true {
            self.perform(#selector(showMetricButton), with: nil, afterDelay: 2.0)
        }
    }
    @objc @MainActor
    func showMetricButton() {
        guard let currentVc = UIApplication.shared.findTopViewController() else {
            return
        }
        self.currentVc = currentVc
        let metricButton = UIButton()
        metricButton.setTitle("->", for: .normal)
        metricButton.setTitleColor(.blue, for: .normal)
        metricButton.frame = CGRect(x: UIScreen.main.bounds.width - 100, y: UIScreen.main.bounds.height - 100, width: 50, height: 50)
        metricButton.addTarget(self, action: #selector(showLogVc), for: .touchUpInside)
        metricButton.backgroundColor = UIColor.white
        currentVc.view.addSubview(metricButton)
    }
    @objc func showLogVc() {
        let qsLogVc = QSLogsViewController(nibName: "QSLogsViewController", bundle: Bundle(for: type(of: self)))
        let navc : UINavigationController = UINavigationController(rootViewController: qsLogVc)
        self.currentVc?.present(navc, animated: true, completion: nil)
    }
    
    internal let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        return formatter
    } ()
    
    func getFolderName(metricPayload:MXMetricPayload)->String
    {
        return String(format:"%@ --- %@",dateFormatter.string(from: metricPayload.timeStampBegin),dateFormatter.string(from: metricPayload.timeStampEnd))
    }
    
}
extension QSMetrics: MXMetricManagerSubscriber {
    
    public func didReceive(_ payloads: [MXMetricPayload]) {
        print("Received metrics payloads")
        for (_, payload) in payloads.enumerated() {
            self.archiveMetrics(metricsPayload: payload)
        }
        print("Finished storing metrics payload")
    }
    
    public func didReceive(_ payloads: [MXDiagnosticPayload]) {
        guard let firstPayload = payloads.first else { return }
        print(firstPayload.dictionaryRepresentation())
    }
}

