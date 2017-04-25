//
//  QSCatalogInteractor.swift
//  zhuishushenqi
//
//  Created caonongyun on 2017/4/21.
//  Copyright © 2017年 QS. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import QSNetwork

class QSCatalogInteractor: QSCatalogInteractorProtocol {

    var output: QSCatalogInteractorOutputProtocol?
    
    var books:[[NSDictionary]] = [[],[]]
    
    func requestDetail(){
        let urlString = "\(BASEURL)/cats/lv2/statistics"
        QSNetwork.request(urlString, method: HTTPMethodType.get, parameters: nil, headers: nil) { (response) in
            QSLog(response.json)
            if let books = response.json?.object(forKey: "male") as? [NSDictionary] {
                self.books[0] = books
            }
            if let femaleTypes = response.json?.object(forKey: "female") as? [NSDictionary] {
                self.books[1] = femaleTypes
            }
            self.output?.fetchDataSuccess(models: self.books)
        }
    }
    
    func show(index:Int,indexPath:IndexPath){
        let genders = ["male","female"]
        let dict = books[indexPath.section][index]
        let param = ["major":dict["name"] ?? "","gender":genders[indexPath.section]]
        self.output?.showDetail(param: param)
    }
}