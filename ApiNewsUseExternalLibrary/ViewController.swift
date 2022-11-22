//
//  ViewController.swift
//  ApiNewsUseExternalLibrary
//
//  Created by Ruslan Ismailov on 21/11/22.
//

import UIKit
import Moya
//import Moya_ObjectMapper
import Alamofire
import ObjectMapper

class ViewController: UIViewController {
    
    var articlesArray = [Articles]()
    
    let requester = MoyaProvider<NewsEnum.bitcoin>()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        requestApi()
    }

    func requestApi(){
        
        requester.request(.bitcoinUrl){ (result) in
            
            switch result {
            case .success(let response):
                let result = try? JSONSerialization.jsonObject(with: response.data, options: [])
                 
                 guard let jsonData = result as? [String:Any] else { return }
                 
                 if let arrayNews = jsonData["articles"] as? NSArray {
                     print(arrayNews.count)
                 
                 
                 
                     for news in arrayNews {
                        guard let currentNews = news as? [String:Any] else { return }
                 
                         if let title = currentNews["title"] as? String {
                             print(title)
                 
                         }
                     }
                 }
                 
            case .failure(let error):
                print("error \(error)")
            }
        }
    }

}

