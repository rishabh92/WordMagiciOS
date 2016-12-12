//
//  ChartsViewController.swift
//  WordMagic
//
//  Created by Balaji Thiruppathi on 11/27/16.
//  Copyright © 2016 Rishabh Singh. All rights reserved.
//

import UIKit
import Charts
import CoreData
import Foundation


@objc(BarChartFormatter)
public class BarChartFormatter: NSObject, IAxisValueFormatter{
    
    var dates: [String]
    
    init(dates : [String]) {
    
        self.dates = dates
    
    }
    
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        
        return dates[Int(value)]
    }
}

class ChartsViewController: UIViewController {

    @IBOutlet weak var barChartView: BarChartView!
    
    @IBOutlet weak var pieChartView: PieChartView!
    
    
    //var months = [Set]()
    var months : [String]!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor(red: 85 / 255, green: 172 / 255, blue: 238 / 255, alpha: 1)
        navigationController?.navigationBar.tintColor = UIColor.white
        let attrs = [
            NSForegroundColorAttributeName: UIColor.white,
            //  NSFontAttributeName: UIFont(name: "Georgia-Bold", size: 24)!
        ]
        navigationController?.navigationBar.titleTextAttributes = attrs
        
        
        let chartdatadown = ChartData(key: "down")
        //var chartdataup = ChartData(key: "up")
        
        //chartdatadown.levelOfWordChanged(key: "down")
        
        let wordCounts = chartdatadown.getChartDataValues(key: "down")
        let dates = chartdatadown.getChartDataDates(key: "down")
        

        
        
        setChart(dataPoints: dates, values: wordCounts)

    }
    override func viewWillAppear(_ animated: Bool) {
        let chartdatadown = ChartData(key: "down")
        let wordCounts = chartdatadown.getChartDataValues(key: "down")
        let dates = chartdatadown.getChartDataDates(key: "down")
        setChart(dataPoints: dates, values: wordCounts)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setChart(dataPoints: [String], values: [Int]) {
        barChartView.noDataText = "You need to provide data for the chart."
        

        let formato:BarChartFormatter = BarChartFormatter(dates: dataPoints)
        let xaxis:XAxis = XAxis()
        
        var dataEntries: [BarChartDataEntry] = []
        print (dataPoints.count)
        for i in 0..<dataPoints.count {
            //let dataEntry = BarChartDataEntry(x: Double(i), yValues: values, label: dataPoints[i])
            //dataEntries.append(dataEntry)
            
            let dataEntry = BarChartDataEntry(x:Double(i),y: Double(values[i]))
            
            dataEntries.append(dataEntry)
            
            formato.stringForValue(Double(i), axis: xaxis)
            
            //Labeling axes not supported with this version of iOS Charts.  Can still do
            
            //indexing and use number of days ago.  Will have to use label to title axes
        }
        
        xaxis.valueFormatter = formato

        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Words completed each Day")
        let chartData = BarChartData(dataSets: [chartDataSet])
        
        chartDataSet.colors = ChartColorTemplates.colorful()
        
        barChartView.xAxis.granularityEnabled = true
        barChartView.xAxis.granularity = 1.0 //default granularity is 1.0, but it is better to be explicit
        barChartView.xAxis.decimals = 0
        barChartView.xAxis.valueFormatter = xaxis.valueFormatter
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInBounce)
        barChartView.data = chartData
        
        
        var piedataEntries: [BarChartDataEntry] = []
        piedataEntries.append(BarChartDataEntry(x:Double(0),y:Double(wordList[0].count)))
        piedataEntries.append(BarChartDataEntry(x:Double(1),y:Double(wordList[1].count)))
        piedataEntries.append(BarChartDataEntry(x:Double(2),y:Double(wordList[2].count)))
        piedataEntries.append(BarChartDataEntry(x:Double(3),y:Double(wordList[3].count)))
        piedataEntries.append(BarChartDataEntry(x:Double(4),y:Double(wordList[4].count)))
        piedataEntries.append(BarChartDataEntry(x:Double(5),y:Double(wordList[5].count)))



        let chartDataSetpie = PieChartDataSet(values: piedataEntries, label: "Words in each set")
        let chartDatapie = PieChartData(dataSets: [chartDataSetpie])
        
        //chartDataSetpie.colors = ChartColorTemplates.colorful()
        
        var colors: [UIColor] = []
        
        colors.append(UIColor.purple)
        colors.append(UIColor.cyan)
        colors.append(UIColor.orange)
        colors.append(UIColor.red)
        colors.append(UIColor.magenta)

        
        chartDataSetpie.colors = colors
        
        pieChartView.animate(xAxisDuration: TimeInterval(1))
        pieChartView.descriptionText = "Words in each level";
        pieChartView.data = chartDatapie
        let l = pieChartView.legend
        
//        l.xEntrySpace = 7.0
//        l.yEntrySpace = 0.0
//        l.yOffset = 0.0
//        
        //legend.setCustom(entries: <#T##[LegendEntry]#>)
        //legend.labels = ["Level 1", "Level 2", "Level 3", "Level 4","Level 5"]
        l.setCustom(colors: [UIColor.purple, UIColor.cyan, UIColor.orange,UIColor.red,UIColor.magenta], labels: ["Level 1", "Level 2", "Level 3", "Level 4","Level 5"])
        
        pieChartView.notifyDataSetChanged()
        
        pieChartView.isUserInteractionEnabled = false
        barChartView.isUserInteractionEnabled = false
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
