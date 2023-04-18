//
//  QSMetrics+Content.swift
//  QosiMetrics
//
//  Created by Mohamed Ali BELHADJ on 18/01/2023.
//

import Foundation
import MetricKit
import UIKit

extension QSMetrics
{
    
    fileprivate func getMetadata(sourceString:String, metaData:MXMetaData)-> String
    {
        var metricsString : String = ""
        metricsString.append("Metadata : \n\n")
        metricsString.append("  App Build Version : \(metaData.applicationBuildVersion)\n")
        metricsString.append("  OS Version : \(metaData.osVersion)\n")
        metricsString.append("  Region Format : \(metaData.regionFormat)\n")
        metricsString.append("  Platform Architecture : \(metaData.platformArchitecture)\n")
        metricsString.append("  Device Type : \(metaData.deviceType)\n")
        return metricsString
    }
    fileprivate func getCellularConditionMetrics(sourceString:String, cellularConditionMetrics:MXCellularConditionMetric)-> String
    {
        var metricsString : String = ""
        metricsString.append("\n\nCellular Condition Metrics : \n\n")
        let cellConditionTime = cellularConditionMetrics.histogrammedCellularConditionTime
        metricsString.append("  Cell Condition Time : \n")
        metricsString = self.addHistogrammeValues(metricsString: metricsString, histograme: cellConditionTime)
        return metricsString
    }
    fileprivate func getCpuMetrics(sourceString:String, cpuMetrics:MXCPUMetric)-> String
    {
        var metricsString : String = ""
        metricsString.append("\n\nCpu Metrics : \n\n")
        metricsString.append("  Cumulative CPU Time : \(cpuMetrics.cumulativeCPUTime)\n")
        metricsString.append("  Cumulative CPU Instructions : \(cpuMetrics.cumulativeCPUInstructions)\n")
        return metricsString
    }
    fileprivate func getDisplayMetrics(sourceString:String, displayMetrics:MXDisplayMetric)-> String
    {
        var metricsString : String = ""
        metricsString.append("\n\nDisplay Metrics : \n\n")
        if let averagePixelLuminance = displayMetrics.averagePixelLuminance {
            metricsString.append("  Average Pixel Luminance :\n")
            metricsString = self.addAverageValues(metricsString: metricsString, average: averagePixelLuminance)
        }
        return metricsString
    }
    fileprivate func getGpuMetrics(sourceString:String, gpuMetrics:MXGPUMetric)-> String
    {
        var metricsString : String = ""
        metricsString.append("\n\nGpu Metrics : \n\n")
        metricsString.append("  Cumulative GPU Time : \(gpuMetrics.cumulativeGPUTime)\n")
        return metricsString
    }
    fileprivate func getLocationsMetrics(sourceString:String, locationActivityMetrics:MXLocationActivityMetric)-> String
    {
        var metricsString : String = ""
        metricsString.append("\n\nLocation Activity Metrics : \n\n")
        metricsString.append("  Cumulative Best Accuracy For Navigation Time : \(locationActivityMetrics.cumulativeBestAccuracyForNavigationTime)\n")
        metricsString.append("  Cumulative Best Accuracy Time : \(locationActivityMetrics.cumulativeBestAccuracyTime)\n")
        metricsString.append("  Cumulative Hundred Meters Accuracy Time : \(locationActivityMetrics.cumulativeHundredMetersAccuracyTime)\n")
        metricsString.append("  Cumulative Nearest Ten Meters Accuracy Time : \(locationActivityMetrics.cumulativeNearestTenMetersAccuracyTime)\n")
        metricsString.append("  Cumulative Kilometer Accuracy Time : \(locationActivityMetrics.cumulativeKilometerAccuracyTime)\n")
        metricsString.append("  Cumulative Three Kilometers Accuracy Time : \(locationActivityMetrics.cumulativeThreeKilometersAccuracyTime)\n")
        return metricsString
    }
    fileprivate func getNetworkTransferMetrics(sourceString:String, networkTransferMetrics:MXNetworkTransferMetric)-> String
    {
        var metricsString : String = ""
        metricsString.append("\n\nNetwork Transfer Metrics : \n\n")
        metricsString.append("  Cumulative Cellular Download : \(networkTransferMetrics.cumulativeCellularDownload)\n")
        metricsString.append("  Cumulative Wifi Download : \(networkTransferMetrics.cumulativeWifiDownload)\n")
        metricsString.append("  Cumulative Cellular Upload : \(networkTransferMetrics.cumulativeCellularUpload)\n")
        metricsString.append("  Cumulative Wifi Upload : \(networkTransferMetrics.cumulativeWifiUpload)\n")
        return metricsString
    }
    fileprivate func getMemoryMetrics(sourceString:String, memoryMetrics:MXMemoryMetric)-> String
    {
        var metricsString : String = ""
        metricsString.append("\n\nMemory Metrics : \n\n")
        metricsString.append("  Peak Memory Usage : \(memoryMetrics.peakMemoryUsage)\n")
        metricsString.append("  Average Suspended Memory :\n")
        metricsString = self.addAverageValues(metricsString: metricsString, average: memoryMetrics.averageSuspendedMemory)
        return metricsString
    }
    fileprivate func getDiskIoMetrics(sourceString:String, diskIoMetrics:MXDiskIOMetric)-> String
    {
        var metricsString : String = ""
        metricsString.append("\n\nDisk IO Metrics : \n\n")
        metricsString.append("  Cumulative Logical Writes : \(diskIoMetrics.cumulativeLogicalWrites)\n")
        return metricsString
    }
    fileprivate func getApplicationLaunchMetrics(sourceString:String, applicationLaunchMetrics:MXAppLaunchMetric)-> String
    {
        var metricsString : String = ""
        metricsString.append("\n\nApplication Launch Metrics : \n\n")
        let histogrammedTimeToFirstDraw = applicationLaunchMetrics.histogrammedTimeToFirstDraw
        metricsString.append("  Histogrammed Time To First Draw : \n")
        metricsString = self.addHistogrammeValues(metricsString: metricsString, histograme: histogrammedTimeToFirstDraw)
        let histogrammedOptimizedTimeToFirstDraw = applicationLaunchMetrics.histogrammedOptimizedTimeToFirstDraw
        metricsString.append("  \nHistogrammed Optimized Time To First Draw : \n")
        metricsString = self.addHistogrammeValues(metricsString: metricsString, histograme: histogrammedOptimizedTimeToFirstDraw)
        
        let histogrammedExtendedLaunch = applicationLaunchMetrics.histogrammedExtendedLaunch
        metricsString.append("  \nHistogrammed Extended Launch : \n")
        metricsString = self.addHistogrammeValues(metricsString: metricsString, histograme: histogrammedExtendedLaunch)
        
        
        let histogrammedApplicationResumeTime = applicationLaunchMetrics.histogrammedApplicationResumeTime
        metricsString.append("  \nHistogrammed Application Resume Time : \n")
        metricsString = self.addHistogrammeValues(metricsString: metricsString,histograme: histogrammedApplicationResumeTime)
        return metricsString
    }
    fileprivate func getApplicationResponsivenessMetrics(sourceString:String, applicationResponsivenessMetrics:MXAppResponsivenessMetric)-> String
    {
        var metricsString : String = ""
        metricsString.append("\n\nApplication Responsiveness Metrics : \n\n")
        let histogrammedApplicationHangTime = applicationResponsivenessMetrics.histogrammedApplicationHangTime
        metricsString.append("  Histogrammed Application Hang Time : \n")
        metricsString = self.addHistogrammeValues(metricsString: metricsString, histograme: histogrammedApplicationHangTime)
        return metricsString
    }
    fileprivate func getApplicationTimeMetrics(sourceString:String, applicationTimeMetrics:MXAppRunTimeMetric)-> String
    {
        var metricsString : String = ""
        metricsString.append("\n\nApplication Time Metrics : \n\n")
        metricsString.append("  Cumulative Foreground Time : \(applicationTimeMetrics.cumulativeForegroundTime)\n")
        metricsString.append("  Cumulative Background Time : \(applicationTimeMetrics.cumulativeBackgroundTime)\n")
        metricsString.append("  Cumulative Background Audio Time : \(applicationTimeMetrics.cumulativeBackgroundAudioTime)\n")
        metricsString.append("  Cumulative Background Location Time : \(applicationTimeMetrics.cumulativeBackgroundLocationTime)\n")
        return metricsString
    }
    fileprivate func getApplicationExitMetrics(sourceString:String, applicationExitMetrics:MXAppExitMetric)-> String
    {
        var metricsString : String = ""
        metricsString.append("\n\nApplication Exit Metrics : \n\n")
        metricsString.append("  Background Exit Data : \n\n")
        
        let backgroundExitData = applicationExitMetrics.backgroundExitData
        metricsString.append("    Cumulative App Watchdog Exit Count : \(backgroundExitData.cumulativeAppWatchdogExitCount)\n")
        metricsString.append("    Cumulative Memory Resource Limit Exit Count : \(backgroundExitData.cumulativeMemoryResourceLimitExitCount)\n")
        metricsString.append("    Cumulative Background Task Assertion Timeout Exit Count : \(backgroundExitData.cumulativeBackgroundTaskAssertionTimeoutExitCount)\n")
        metricsString.append("    Cumulative Abnormal Exit Count : \(backgroundExitData.cumulativeAbnormalExitCount)\n")
        metricsString.append("    Cumulative Suspended With Locked File Exit Count : \(backgroundExitData.cumulativeSuspendedWithLockedFileExitCount)\n")
        metricsString.append("    Cumulative Illegal Instruction Exit Count : \(backgroundExitData.cumulativeIllegalInstructionExitCount)\n")
        metricsString.append("    Cumulative Memory Pressure Exit Count : \(backgroundExitData.cumulativeMemoryPressureExitCount)\n")
        metricsString.append("    Cumulative Bad Access Exit Count : \(backgroundExitData.cumulativeBadAccessExitCount)\n")
        metricsString.append("    Cumulative CPU Resource Limit Exit Count : \(backgroundExitData.cumulativeCPUResourceLimitExitCount)\n")
        metricsString.append("    Cumulative Normal App Exit Count : \(backgroundExitData.cumulativeNormalAppExitCount)\n")
        
        let foregroundExitData = applicationExitMetrics.foregroundExitData
        metricsString.append("  \nForeground Exit Data : \n\n")
        metricsString.append("    Cumulative BadAccess Exit Count : \(foregroundExitData.cumulativeBadAccessExitCount)\n")
        metricsString.append("    Cumulative Abnormal ExitCount : \(foregroundExitData.cumulativeAbnormalExitCount)\n")
        metricsString.append("    Cumulative Memory Resource Limit Exit Count : \(foregroundExitData.cumulativeMemoryResourceLimitExitCount)\n")
        metricsString.append("    Cumulative Normal App Exit Count : \(foregroundExitData.cumulativeNormalAppExitCount)\n")
        metricsString.append("    Cumulative Illegal Instruction Exit Count : \(foregroundExitData.cumulativeIllegalInstructionExitCount)\n")
        metricsString.append("    Cumulative App Watchdog Exit Count : \(foregroundExitData.cumulativeAppWatchdogExitCount)\n")
        return metricsString
    }
    fileprivate func getSignpostMetrics(sourceString:String, signpostMetrics:[MXSignpostMetric])-> String
    {
        var metricsString : String = ""
        guard signpostMetrics.isEmpty == false else {
            return metricsString
        }
        metricsString.append("\n\nSignpost Metrics : \n\n")
        for i in 0...signpostMetrics.count-1 {
            let signpostMetric = signpostMetrics[i]
            metricsString.append("  \(i) : \n")
            metricsString.append("    Signpost Category : \(signpostMetric.signpostCategory) \n")
            metricsString.append("    Signpost name : \(signpostMetric.signpostName) \n")
            metricsString.append("    Total Count : \(signpostMetric.totalCount) \n")
            
            if let signpostIntervalData = signpostMetric.signpostIntervalData
            {
                metricsString.append("    Signpost Interval Data :\n")
                let histogrammedSignpostDurations = signpostIntervalData.histogrammedSignpostDuration
                metricsString = self.addHistogrammeValues(metricsString: metricsString, histograme: histogrammedSignpostDurations)
                if let cumulativeCPUTime = signpostIntervalData.cumulativeCPUTime
                {
                    metricsString.append("        Signpost Cumulative CPU Time : \(cumulativeCPUTime)\n")
                }
                if let cumulativeHitchTimeRatio = signpostIntervalData.cumulativeHitchTimeRatio
                {
                    metricsString.append("        Cumulative Hitch Time Ratio : \(cumulativeHitchTimeRatio)\n")
                }
                if let cumulativeLogicalWrites = signpostIntervalData.cumulativeLogicalWrites
                {
                    metricsString.append("        Cumulative Logical Writes : \(cumulativeLogicalWrites)\n")
                }
            }
            
        }
        return metricsString
    }
    fileprivate func addHistogrammeValues(metricsString: String,histograme:Any)->String
    {
        var resultString = metricsString
        let histogrameObject = histograme as! MXHistogram<Unit>
        resultString.append("    Histogram Num Buckets : \(histogrameObject.totalBucketCount)\n")
        guard histogrameObject.bucketEnumerator.allObjects.isEmpty == false else {
            return resultString
        }
        resultString.append("    Histogram Value : \n")
        for i in 0...histogrameObject.bucketEnumerator.allObjects.count-1 {
            resultString.append("        \(i) : \n")
            let histogrameBucket :MXHistogramBucket = histogrameObject.bucketEnumerator.allObjects[i] as! MXHistogramBucket<Unit>
            resultString.append("        bucketCount : \(histogrameBucket.bucketCount)\n")
            resultString.append("        bucketEnd : \(histogrameBucket.bucketEnd)\n")
            resultString.append("        bucketStart : \(histogrameBucket.bucketStart)\n")
        }
        return resultString
    }
    fileprivate func addAverageValues(metricsString: String,average : Any)->String
    {
        var resultString = metricsString
        let averageObject : MXAverage = average as! MXAverage<Unit>
        resultString.append("    Average Value : \(averageObject.averageMeasurement)\n")
        resultString.append("    Standard Deviation : \(averageObject.standardDeviation)\n")
        resultString.append("    Sample Count : \(averageObject.sampleCount)\n")
        return resultString
    }
    internal func getEquivalentContentToShow(metricsPayload:MXMetricPayload)->NSMutableAttributedString
    {
        
        var metricsString : String = ""
        metricsString.append("Time Stamp Begin : \(dateFormatter.string(from: metricsPayload.timeStampBegin))\n")
        metricsString.append("Time Stamp End : \(dateFormatter.string(from: metricsPayload.timeStampEnd))\n\n")
        
        if let metaData = metricsPayload.metaData {
            metricsString.append(self.getMetadata(sourceString: metricsString, metaData: metaData))
        }
        if let cellularConditionMetrics = metricsPayload.cellularConditionMetrics {
            metricsString.append(self.getCellularConditionMetrics(sourceString: metricsString, cellularConditionMetrics: cellularConditionMetrics))
        }
        if let cpuMetrics = metricsPayload.cpuMetrics {
            metricsString.append(self.getCpuMetrics(sourceString: metricsString, cpuMetrics: cpuMetrics))
        }
        if let displayMetrics = metricsPayload.displayMetrics {
            metricsString.append(self.getDisplayMetrics(sourceString: metricsString, displayMetrics: displayMetrics))
        }
        if let gpuMetrics = metricsPayload.gpuMetrics {
            metricsString.append(self.getGpuMetrics(sourceString: metricsString, gpuMetrics: gpuMetrics))
        }
        if let locationActivityMetrics = metricsPayload.locationActivityMetrics {
            metricsString.append(self.getLocationsMetrics(sourceString: metricsString, locationActivityMetrics: locationActivityMetrics))
        }
        if let networkTransferMetrics = metricsPayload.networkTransferMetrics {
            metricsString.append(self.getNetworkTransferMetrics(sourceString: metricsString, networkTransferMetrics: networkTransferMetrics))
        }
        if let memoryMetrics = metricsPayload.memoryMetrics {
            metricsString.append(self.getMemoryMetrics(sourceString: metricsString, memoryMetrics: memoryMetrics))
        }
        if let diskIoMetrics = metricsPayload.diskIOMetrics {
            metricsString.append(self.getDiskIoMetrics(sourceString: metricsString, diskIoMetrics: diskIoMetrics))
        }
        if let applicationLaunchMetrics = metricsPayload.applicationLaunchMetrics {
            metricsString.append(self.getApplicationLaunchMetrics(sourceString: metricsString, applicationLaunchMetrics: applicationLaunchMetrics))
        }
        if let applicationResponsivenessMetrics = metricsPayload.applicationResponsivenessMetrics {
            metricsString.append(self.getApplicationResponsivenessMetrics(sourceString: metricsString, applicationResponsivenessMetrics: applicationResponsivenessMetrics))
        }
        if let applicationTimeMetrics = metricsPayload.applicationTimeMetrics {
            metricsString.append(self.getApplicationTimeMetrics(sourceString: metricsString, applicationTimeMetrics: applicationTimeMetrics))
        }
        if let applicationExitMetrics = metricsPayload.applicationExitMetrics {
            metricsString.append(self.getApplicationExitMetrics(sourceString: metricsString, applicationExitMetrics: applicationExitMetrics))
        }
        if let signpostMetrics = metricsPayload.signpostMetrics {
            metricsString.append(self.getSignpostMetrics(sourceString: metricsString, signpostMetrics: signpostMetrics))
        }
        return self.applyAttributedContent(metricsString: metricsString)
    }
    fileprivate func applyAttributedContent(metricsString:String)-> NSMutableAttributedString
    {
        let metricsAttributedString = NSMutableAttributedString(string: metricsString)
        metricsAttributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: metricsAttributedString.mutableString.range(of: "Metadata :", options: .caseInsensitive))
        metricsAttributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: metricsAttributedString.mutableString.range(of: "Cellular Condition Metrics :", options: .caseInsensitive))
        metricsAttributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: metricsAttributedString.mutableString.range(of: "Cpu Metrics :", options: .caseInsensitive))
        metricsAttributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: metricsAttributedString.mutableString.range(of: "Gpu Metrics :", options: .caseInsensitive))
        
        metricsAttributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: metricsAttributedString.mutableString.range(of: "Display Metrics :", options: .caseInsensitive))
        metricsAttributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: metricsAttributedString.mutableString.range(of: "Location Activity Metrics :", options: .caseInsensitive))
        metricsAttributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: metricsAttributedString.mutableString.range(of: "Network Transfer Metrics : ", options: .caseInsensitive))
        metricsAttributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: metricsAttributedString.mutableString.range(of: "Memory Metrics : ", options: .caseInsensitive))
        metricsAttributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: metricsAttributedString.mutableString.range(of: "Disk IO Metrics : ", options: .caseInsensitive))
        metricsAttributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: metricsAttributedString.mutableString.range(of: "Application Launch Metrics : ", options: .caseInsensitive))
        metricsAttributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: metricsAttributedString.mutableString.range(of: "Application Responsiveness Metrics : ", options: .caseInsensitive))
        metricsAttributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: metricsAttributedString.mutableString.range(of: "Application Time Metrics : ", options: .caseInsensitive))
        metricsAttributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: metricsAttributedString.mutableString.range(of: "Application Exit Metrics : ", options: .caseInsensitive))
        metricsAttributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: metricsAttributedString.mutableString.range(of: "Signpost Metrics : ", options: .caseInsensitive))
        return metricsAttributedString
    }
}
extension NSMutableAttributedString {
    func rangeOf(string: String) -> Range<String.Index>? {
        return self.string.range(of: string)
    }
}
