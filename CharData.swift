//
//  CharData.swift
//  WordMagic
//
//  Created by Balaji Thiruppathi on 12/3/16.
//  Copyright © 2016 Rishabh Singh. All rights reserved.
//

import Foundation


class ChartData {
    var valueArr = [Int]()
    var dateArr = [Date]()
    

    
    
    init(key : String) {
 
        let defaults = UserDefaults.standard
        valueArr = defaults.object(forKey: key+"chartdatavalue") as? [Int] ?? [Int]()
        dateArr = defaults.object(forKey:   key+"chartdatadate") as? [Date] ?? [Date]()
    }
    
    
    func levelOfWordChanged(key : String) {
        
        
        let currentDate = Date()
        
        
        if (dateArr.count == 0)
        {
            
            valueArr.append(0);
            dateArr.append(currentDate);
            //defaults.set(currentDate, forKey: "startdate")
        }

       
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date1String = dateFormatter.string(from: currentDate)
        let date2String = dateFormatter.string(from: dateArr[dateArr.count-1])
        
        //let dateComparisionResult:ComparisonResult = currentDate.compare(dateArr[dateArr.count-1])
        
        if (date1String == date2String)
        {
            print("---------");
            valueArr[valueArr.count-1] += 1;
            print(valueArr[valueArr.count-1])
            print(dateArr[dateArr.count-1])

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

        
        let defaults = UserDefaults.standard

        defaults.set(valueArr, forKey: key+"chartdatavalue")
        defaults.set(dateArr, forKey: key+"chartdatadate")
        defaults.set(currentDate, forKey: "enddate")

        
    }
    
    
    func getChartDataValues(key: String) -> [Int] {
    
        let defaults = UserDefaults.standard
        let array = defaults.object(forKey: key+"chartdatavalue") as? [Int] ?? [Int]()

    return array
    
    }
 
    
    func getChartDataDates(key: String) -> [String] {
        
        let defaults = UserDefaults.standard
        let array = defaults.object(forKey: key+"chartdatadate") as? [Date] ?? [Date]()
        
        var strdates = [String]()
        
        for i in array
        {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            let dateString = dateFormatter.string(from: i)
            
            strdates.append(dateString)
            
        }
        
        return strdates
    }
    
    
    

}


