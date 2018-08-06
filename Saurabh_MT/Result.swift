//
//  Result.swift
//  Saurabh_MT
//
//  Created by saurabh srivastava on 29/07/18.
//  Copyright © 2018 saurabh. All rights reserved.
//

import Foundation
import UIKit

class Result:NSObject{
    
    var image = ""
    var title = ""
    var desc = ""
    var url = ""
    var id = 0
    
    func updateResult(_ data:[String:Any]){
        if let nam = data["title"] as? String{
            title = nam
        }
        if let nam = data["pageid"] as? Int{
            id = nam
        }
        
        if let terms = data["terms"] as? [String:Any]{
            if let descri = terms["description"] as? [String]{
                if descri.count > 0{
                    desc = descri[0]
                }
            }
        }
        
        if let terms = data["thumbnail"] as? [String:Any]{
            if let descri = terms["source"] as? String{
                image = descri
            }
        }
        
    }
    
    
}

