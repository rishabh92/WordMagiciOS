//
//  CharData.swift
//  WordMagic
//
//  Created by Balaji Thiruppathi on 12/3/16.
//  Copyright © 2016 Rishabh Singh. All rights reserved.
//

import Foundation


class ChartData {
    var startDate : Date
    var valueArr = [Int]()
    var dateArr = [Date]()
    var endDate : Date
    

    
    
    init() {

    }
    
    
    func levelOfWordChanged() {
        
        
        let currentDate = Date()
        
        let defaults = UserDefaults.standard
        
        if (dateArr.count > 0)
        {
            valueArr = defaults.object(forKey: "chartdatavalue") as? [Int] ?? [Int]()
            dateArr = defaults.object(forKey: "chartdatadate") as? [Date] ?? [Date]()
        }
        else
        {
            
            valueArr.append(1);
            dateArr.append(currentDate);
            defaults.set(currentDate, forKey: "startdate")
        }
       
        
        if (dateArr[dateArr.count-1] == currentDate)
        {
            valueArr[valueArr.count-1] += 1;
            
            
        }
        else
        {
            if(dateArr.count > 10)
            {
                valueArr.removeFirst()
                dateArr.removeFirst()
                
                valueArr.append(1);
                dateArr.append(currentDate);
                
            }
            else{
                
                valueArr.append(1);
                dateArr.append(currentDate);
                
            }
            
            
        }

        
        
        defaults.set(valueArr, forKey: "chartdatavalue")
        defaults.set(dateArr, forKey: "chartdatadate")
        defaults.set(currentDate, forKey: "enddate")

        
    }
    
    
    func getChartDataValues() -> [Int] {
    
        let defaults = UserDefaults.standard
        let array = defaults.object(forKey: "chartdatavalue") as? [Int] ?? [Int]()

    return array
    
    }
 
    
    func getChartDataDates() -> [Date] {
        
        let defaults = UserDefaults.standard
        let array = defaults.object(forKey: "chartdatadate") as? [Date] ?? [Date]()
        
        //var strdate = [String]()
        
        return array
        
    }
    
    
    

}


