//
//  ViewController.swift
//  LearningSwiftCharts
//
//  Created by Yapı Kredi Teknoloji A.Ş. on 1.08.2023.
//

// BarChartRenderer -> Rounded Bar Chart Customization (as comment)

// (old) context.fill(barRect)
// (new) let bezierPath = UIBezierPath(roundedRect: barRect, cornerRadius: %YOUR_CORNER_RADIUS%)
//context.addPath(bezierPath.cgPath)
//context.drawPath(using: .fill)

import UIKit
import Charts

class ViewController: UIViewController {

    override func viewDidLoad() {
        navigationItem.title = "Chart Title"
        super.viewDidLoad()
        createChart()
    }

    private func createChart() {
        // Create bar chart
        let barChart = BarChartView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width))
        // barChart.doubleTapZoomEnabled = false
        
        // Configure the axis
        let xAxis = barChart.xAxis
        let rightAxis = barChart.rightAxis
        
        // configure the legend
        let legend = barChart.legend
        
        // Supply data
        var entries = [BarChartDataEntry]()
        
        for x in 0..<10 {
            entries.append(
                BarChartDataEntry(
                    x: Double(x),
                    yValues: [
                        Double.random(in: 0...30),
                        Double.random(in: 0...30)
                    ]
                )
            )
        }

        let set = BarChartDataSet(entries: entries, label: "Label")
        
        set.colors = [
            NSUIColor(cgColor: UIColor.systemBlue.cgColor),
            NSUIColor(cgColor: UIColor.systemYellow.cgColor)
        ]
        
        let data = BarChartData(dataSet: set)        
        
        barChart.data = data
        
        barChart.rightAxis.drawGridLinesEnabled = false
        barChart.rightAxis.drawAxisLineEnabled = false
        barChart.rightAxis.drawLabelsEnabled = false
        barChart.doubleTapToZoomEnabled = false
        
        barChart.animate(yAxisDuration: 0.5, easingOption: .easeInBounce)
        
        view.addSubview(barChart)
        barChart.center = view.center
    }

}

