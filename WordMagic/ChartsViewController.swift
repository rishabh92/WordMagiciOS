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
        
       // barChartView.noDataText = "You need to provide data for the chart."
        
        months = ["Set 1", "Set 2", "Set 3", "Set 4", "Set 5", "Set 6", "Set 7", "Set 8", "Set 9", "Set 10"]
        let unitsSold = [10.0, 5.0, 10.0, 4.0, 10.0, 8.0, 3.0, 9.0, 8.0, 10.0]
        setChart(dataPoints: months, values: unitsSold)
        
    //    barchartview.noDataTextDescription = "GIVE REASON"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setChart(dataPoints: [String], values: [Double]) {
        barChartView.noDataText = "You need to provide data for the chart."
        
        var dataEntries: [BarChartDataEntry] = []
        print (dataPoints.count)
        for i in 0..<dataPoints.count {
            //let dataEntry = BarChartDataEntry(x: Double(i), yValues: values, label: dataPoints[i])
            //dataEntries.append(dataEntry)
            
            let dataEntry = BarChartDataEntry(x:Double(i),y: values[i])
            
            dataEntries.append(dataEntry)
            
            //Labeling axes not supported with this version of iOS Charts.  Can still do
            
            //indexing and use number of days ago.  Will have to use label to title axes
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Words completed in Sets")
        let chartData = BarChartData(dataSets: [chartDataSet])
        
        chartDataSet.colors = ChartColorTemplates.colorful()
        
        barChartView.animate(xAxisDuration: 4.0, yAxisDuration: 4.0, easingOption: .easeInBounce)
        barChartView.data = chartData
        
        
        let chartDataSetpie = PieChartDataSet(values: dataEntries, label: "Words in each set")
        let chartDatapie = PieChartData(dataSets: [chartDataSetpie])
        
        chartDataSetpie.colors = ChartColorTemplates.colorful()

        pieChartView.data = chartDatapie

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
