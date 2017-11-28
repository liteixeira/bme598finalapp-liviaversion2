//
//  BarChartViewController.swift
//  final app
//
//  Created by Ethan Mathew on 11/27/17.
//  Copyright © 2017 Ethan Mathew. All rights reserved.
//

import UIKit
import Charts

class chartViewController: UIViewController {

    var months:[String] = []
    var temperature:[Double] = []
    var points:[Double] = []
    //var dataEntries: [BarChartDataEntry] = []
    var dataEntries: [ChartDataEntry] = []
    // remember to change chartView type if want to change to BarChartView
   // @IBOutlet weak var chartView: BarChartView!
    @IBOutlet weak var lineView: LineChartView!
    
    @IBAction func savesChart(_ sender: UIBarButtonItem) {
        let img = lineView.getChartImage(transparent: false)
        UIImageWriteToSavedPhotosAlbum(img!, nil, nil, nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBackButton()
        // Do any additional setup after loading the view.
        // Data Source
        months = ["Ja","Fe","Mar","Ap","May","Jun","July","Ago","Set","Oc","Nov","Dec"]
        temperature = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        // Call function chart_Creation to create a chart
        chart_Creation(x: months, y: temperature)
    }
    
    
    func chart_Creation(x: [String], y: [Double]) {
        lineView.noDataText = "You need to provide data for the chart."
        lineView.noDataText.append("\n Explain user why the chart is empty")
        lineView.noDataText.append("\n Tell what they need to do in order to get data")
        lineView.backgroundColor = UIColor.black
        
        for i in 0..<temperature.count {
            dataEntries.append(ChartDataEntry(x: Double(i), y: Double(temperature[i])))
            
        }
        print("\(dataEntries)")
        
        let chart = LineChartDataSet(values: dataEntries, label: "Temperature")
        let line_Chart = LineChartData()
        line_Chart.addDataSet(chart)
        line_Chart.setDrawValues(true)
        line_Chart.setValueTextColor(UIColor.orange)
        chart.colors = [UIColor.orange]
        chart.setCircleColor(UIColor.orange)
        chart.circleHoleColor = UIColor.orange
       // chart.colors = [UIColor.orange]
       // let gdtColors = [UIColor.orange.cgColor, UIColor.clear.cgColor] as CFArray
       // let locColors:[CGFloat] = [1.0, 0.0]
       // guard let gdt = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gdtColors, locations: locColors) else {
         //   print("Error"); return
       // }
        chart.fill = Fill.fillWithColor(UIColor.orange)
        //chart.fill = Fill.fillWithRadialGradient(gdt)
       // chart.fill = Fill.fillWithLinearGradient(gdt, angle: 120.0)
      
        chart.drawFilledEnabled = true
        
    
        line_Chart.setValueFont(UIFont(name: "Verdana", size: 14.0)!)
        lineView.xAxis.valueFormatter = IndexAxisValueFormatter(values: months)
        lineView.xAxis.labelFont = UIFont(name: "Verdana", size: 15.0)!
        lineView.leftAxis.labelFont = UIFont(name: "Verdana", size: 15.0)!
        lineView.legend.font = UIFont(name: "Verdana", size: 15.0)!
        lineView.legend.textColor = UIColor.orange
        lineView.xAxis.drawGridLinesEnabled = false
        lineView.xAxis.labelPosition = .bottom
        lineView.xAxis.labelTextColor = UIColor.orange
        lineView.xAxis.granularity = 1
        lineView.chartDescription?.enabled = false
        lineView.rightAxis.enabled = false
        lineView.leftAxis.drawGridLinesEnabled = false
        lineView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        // Add limit line
        let limitLine = ChartLimitLine(limit: 10.0, label: "Threshold")
        limitLine.lineColor = UIColor.red
        limitLine.valueTextColor = UIColor.red
        lineView.leftAxis.addLimitLine(limitLine)
        lineView.leftAxis.labelTextColor = UIColor.orange
        lineView.data = line_Chart
        
        // For bar chart
        // Remember, change the class view in the storyboard to barchartview
        /*
        for i in 0..<temperature.count {
            let dataEntry = BarChartDataEntry(x:Double(i), y: Double(temperature[i]))
            dataEntries.append(dataEntry)
            
        }
        
        let chart = BarChartDataSet(values: dataEntries, label: "Temperature")
        let chartData = BarChartData()
        chartData.addDataSet(chart)
        chartData.setDrawValues(true)
        chartData.setValueFont(UIFont(name: "Verdana", size: 14.0)!)
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values:months)
        // barChartView.xAxis.setLabelCount(months.count, force: true)
        barChartView.xAxis.labelFont = UIFont(name: "Verdana", size: 15.0)!
        barChartView.leftAxis.labelFont = UIFont(name: "Verdana", size: 15.0)!
        barChartView.legend.font = UIFont(name: "Verdana", size: 15.0)!
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.xAxis.labelPosition = .bottom
        barChartView.xAxis.granularity = 1
        barChartView.chartDescription?.enabled = false
        barChartView.rightAxis.enabled = false
        barChartView.leftAxis.drawGridLinesEnabled = false
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        // Add limit line
        let limitLine = ChartLimitLine(limit: 10.0, label: "Temperature Threshold")
        barChartView.leftAxis.addLimitLine(limitLine)
        barChartView.data = chartData*/
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addBackButton() {
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "BackButton.png"), for: .normal)
        backButton.setTitle(" Back", for: .normal)
        backButton.setTitleColor(backButton.tintColor, for: .normal)
        backButton.addTarget(self, action: #selector(self.backAction(_:)), for: .touchUpInside)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    @objc func backAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */


}
