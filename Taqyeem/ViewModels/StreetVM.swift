//
//  Streetvm.swift
//  Taqyeem
//
//  Created by mac on 12/14/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import Foundation
import Alamofire
struct StreetVM {
    var street :Street
    static func getAllStreets(municID :Int , districtID :Int , completion: @escaping (_ streets: [StreetVM]?, _ error: String?) -> Void) {

        var request = URLRequest(url: URL(string: "http://46.151.210.248:8888/rating_app/streets_by_district_id")!)
               request.httpMethod = HTTPMethod.post.rawValue
               request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(UserDefaultsAccess.sharedInstance.token)", forHTTPHeaderField: "Authorization")
               let paramString = "{\"codeDistrict\" : \(districtID)}"
               request.httpBody = paramString.data(using: .utf8)
               Alamofire.request(request).responseJSON { (response) in
                   if let statusCode = response.response?.statusCode {
                       if let res = response.result.value as? [NSDictionary] {
                           if statusCode >= 200 && statusCode < 300 {
                               if let resturants: [Street] = res.getObject() {
                                   completion(resturants.map { StreetVM(street: $0) }, nil)
                               }
                           } else {
                               completion(nil, "Unable to get data")
                           }
                       } else {
                           completion(nil, "Unable to get data")
                       }
                   } else {
                       completion(nil, "Unable to get data")
                   }
               }
        
        
    }
}
