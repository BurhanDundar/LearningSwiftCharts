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
    
    let dates = [
        "Tem 11",
        "Haz 11",
        "May 11",
        "Nis 11",
        "Mar 11",
        "Şub 11",
        "Oca 11",
        "Ara 11",
        "Tem 11"
    ]

    override func viewDidLoad() {
        navigationItem.title = "Chart Title"
        super.viewDidLoad()
        createChart()
    }

    private func createChart() {
        // Create bar chart
        let barChart = BarChartView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width))
        // barChart.doubleTapZoomEnabled = false
        
        barChart.drawGridBackgroundEnabled = false
        barChart.drawBordersEnabled = false
        barChart.doubleTapToZoomEnabled = false
        barChart.pinchZoomEnabled = false
        barChart.scaleXEnabled = false
        barChart.scaleYEnabled = false
        barChart.chartDescription.text = "" // boş kalabilir
//        barChart.backgroundColor = .red
        
        // Configure the axis
        let xAxis = barChart.xAxis
        xAxis.labelPosition = .bottom
        xAxis.granularity = 1
        xAxis.granularityEnabled = true
        xAxis.drawAxisLineEnabled = false
        xAxis.drawGridLinesEnabled = false
        xAxis.valueFormatter = IndexAxisValueFormatter(values: dates)
        //xAxis.valueFormatter = self // AxisValueFormatter Gerekli bunun için
        xAxis.labelFont = UIFont(name: "Kailasa", size: 12)!
        xAxis.labelTextColor = .label
        xAxis.labelCount = 7 // x ekseninde kaç label gösterileceğini ayarlar
        
        let leftAxis = barChart.leftAxis
//        leftAxis.valueFormatter = YAxisValueFormatter()
        leftAxis.axisMaximum = 100
        leftAxis.drawZeroLineEnabled = true
        leftAxis.drawGridLinesEnabled = true
//        leftAxis.zeroLineColor = getCurrentTheme().colorBorder.color
//        leftAxis.gridColor = getCurrentTheme().colorBorder.color
        leftAxis.labelFont = UIFont(name: "Kailasa", size: 12)!
        leftAxis.labelTextColor = .label
        
        let rightAxis = barChart.rightAxis
        rightAxis.drawGridLinesEnabled = false
        rightAxis.drawAxisLineEnabled = false
        rightAxis.drawLabelsEnabled = false
        rightAxis.enabled = false
        
        // configure the legend
        // legend -> kolon isimlerini yazan kısım ve onunla ilgili ayarlamalar örnek: Konum ayarları
        let legend = barChart.legend
        legend.enabled = false
        
        // Supply data
        var entries = [BarChartDataEntry]()
        
        for x in 0..<7 {
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
        data.barWidth = 0.8
        
        let xAxisPadding = 0.6
        barChart.xAxis.axisMinimum = -xAxisPadding
        barChart.xAxis.axisMaximum = data.xMax + xAxisPadding
        
        barChart.leftAxis.axisMinimum = 0
        
        if data.yMax > 0 {
            barChart.leftAxis.resetCustomAxisMax()
        }
        
        barChart.clear()
        barChart.data = data
        barChart.barData?.setDrawValues(false)
        barChart.notifyDataSetChanged() // Muhtemelen şu an buna ihtiyacım yok
        
        // Bu metoda parametre olarak verilen sayısal değer chart içerisinde min, max kaç kolon gösterilecek bunu belirler
        barChart.setVisibleXRangeMinimum(7)
        barChart.setVisibleXRangeMaximum(7)
        
        // Chart kolonlarının animasyonlu şekilde kullanıcıya gösterilmesini sağlar
        barChart.animate(yAxisDuration: 0.5, easingOption: .easeInBounce)
        
        view.addSubview(barChart)
        barChart.center = view.center
        
        let highlight = Highlight(x: Double(0), y: Double(0), dataSetIndex: 1, dataIndex: 0)
        barChart.highlightValue(highlight)
    }
    
//    fileprivate func highlightOnLoad() {
//        if let barChartItemModelList = orderDetailResponseModel?.barChartItemList, !barChartItemModelList.isEmpty, let index = barChartItemModelList.last?.index {
//            let highlight = Highlight(x: Double(index), y: barChartItemModelList[index].amount ?? 0, dataSetIndex: 1, dataIndex: 0)
//            barChartView.highlightValue(highlight)
//            triggerHighlightEventWork(index)
//        } else {
//            selectedBarAmountDisplayView.isHidden = true
//            changeToLastMonthStackView.isHidden = true
//            thisMonthNoInvoiceInfoView.isHidden = true
//            viewReceiptButton.isHidden = true
//        }
//    }

}

