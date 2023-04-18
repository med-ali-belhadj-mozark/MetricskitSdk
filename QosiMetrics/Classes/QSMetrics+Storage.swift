//
//  QSMetrics+Storage.swift
//  QosiMetrics
//
//  Created by Mohamed Ali BELHADJ on 17/01/2023.
//

import Foundation
import MetricKit

extension QSMetrics
{
    internal func archiveMetrics(metricsPayload: MXMetricPayload) {
        guard let metricsDirectory = getMetricsDirectory() else {
            print("Failed to get or create metrics directory")
            return
        }
        guard let metricsPayloadPath = getOrCreateDirectory(parentDirectory: metricsDirectory, newDirectoryName: self.getFolderName(metricPayload: metricsPayload)) else {
            print("Failed to get or create payload directory")
            return
        }
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: metricsPayload, requiringSecureCoding: false)
            try data.write(to: metricsPayloadPath.appendingPathComponent(QSMetrics.metricPayloadDirectoryName))
        } catch {
            print("Couldn't write file")
        }
    }
    internal func getEquivalentLogForFileAtIndex(index:Int)->NSMutableAttributedString?
    {
        guard let metricsDirectory = getMetricsDirectory() else {
            print("Failed to get or create metrics directory")
            return nil
        }
        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(at: metricsDirectory, includingPropertiesForKeys: nil)
            if fileURLs.count > index
            {
                let payloadURL = fileURLs[index].appendingPathComponent("MetricPayload", isDirectory: false)
                print("payloadURL \(payloadURL)")
                if FileManager.default.fileExists(atPath: payloadURL.path) {
                    do {
                        let data = try Data(contentsOf: payloadURL)
                        if let payload = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? MXMetricPayload
                        {
                            return self.getEquivalentContentToShow(metricsPayload: payload)
                        }
                    } catch {print("Couldn't read file.")}
                }
                else {return nil}
            }else {return nil}
        } catch {
            print("Error while enumerating files \(metricsDirectory.path): \(error.localizedDescription)")
        }
        return nil
    }
    internal func getLogsFileNames()->[String]
    {
        var logsFileName : [String] = [String]()
        guard let metricsDirectory = getMetricsDirectory() else {
            print("Failed to get or create metrics directory")
            return logsFileName
        }
        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(at: metricsDirectory, includingPropertiesForKeys: nil)
            fileURLs.forEach { file in
                logsFileName.append(file.lastPathComponent)
            }
            return logsFileName
        } catch {
            print("Error while enumerating files \(metricsDirectory.path): \(error.localizedDescription)")
        }
        return logsFileName
    }
    internal func getOrCreateDirectory(parentDirectory:URL,newDirectoryName:String) -> URL? {
        let newDirectory = parentDirectory.appendingPathComponent(newDirectoryName, isDirectory: true)
        if !FileManager.default.fileExists(atPath: newDirectory.path) {
            do {
                try FileManager.default.createDirectory(at: newDirectory, withIntermediateDirectories: true, attributes: nil)
            } catch {
                return nil
            }
        }
        return newDirectory
    }
    internal func getMetricsDirectory() -> URL? {
        return getOrCreateDirectory(parentDirectory: getMetricKitDirectory(), newDirectoryName: QSMetrics.metricsDirectoryName)
    }
    internal func getMetricKitDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(Self.mainDirectoryName, isDirectory: true)
    }
}
