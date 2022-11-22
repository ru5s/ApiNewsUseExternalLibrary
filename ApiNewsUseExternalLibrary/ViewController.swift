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
    
    let thread1 = DispatchQueue(label: "com.apple.thread1")
    let group = DispatchGroup()

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
                
                let news = HeaderArticles(JSON: jsonData)
                for item in news!.allNews{
                    self.articlesArray.append(item)
                    print(item.author)
                }
            case .failure(let error):
                print("error \(error)")
            }
        }
        
    }

}

