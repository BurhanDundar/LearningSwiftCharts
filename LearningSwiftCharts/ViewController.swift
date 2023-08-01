//
//  ViewController.swift
//  LearningSwiftCharts
//
//  Created by Yapı Kredi Teknoloji A.Ş. on 1.08.2023.
//

import UIKit
import Charts

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        createChart()
    }

    private func createChart() {
        // Create bar chart
        let barChart = BarChartView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width))
        
        // Configure the axis
        
        // configure the legend
        
        // Supply data
        var entries = [BarChartDataEntry]()
        
        for x in 0..<10 {
            entries.append(
                BarChartDataEntry(
                    x: Double(x),
                    y: Double.random(in: 0...30)
                )
            )
        }
        
        let set = BarChartDataSet(entries: entries, label: "Cost")
        let data = BarChartData(dataSet: set)
        
        barChart.data = data
        
        view.addSubview(barChart)
        barChart.center = view.center
    }

}
