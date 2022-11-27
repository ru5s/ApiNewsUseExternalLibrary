//
//  ViewController.swift
//  ApiNewsUseExternalLibrary
//
//  Created by Ruslan Ismailov on 21/11/22.
//

import UIKit
import Moya
import Alamofire
import ObjectMapper
import Kingfisher

class ViewController: UIViewController {
    
    let child = SpinnerViewController()
    
    @IBOutlet weak var btn: UIButton!
    var articlesArray: [Articles] = []
    
    let requester = MoyaProvider<NewsEnum.bitcoin>()
    
    let thread1 = DispatchQueue(label: "com.thread1", qos: .default, attributes: .concurrent)
    let thread2 = DispatchQueue(label: "com.thread2", qos: .default, attributes: .concurrent)
    let group = DispatchGroup()
    let semaphore = DispatchSemaphore(value: 2)
    
    let tableView: UITableView = {
        let tb = UITableView()
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.register(TableViewCell.self, forCellReuseIdentifier: "Cell")
        return tb
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        
        createSpinnerView()
        tableView.reloadData()
    }
    
    override func viewWillLayoutSubviews() {
        requestApi()
        
        let safeArea = view.layoutMarginsGuide
        
        tableView.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 0).isActive = true
    }
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if articlesArray.count > 0 {
            return articlesArray.count
        }
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        cell.image.image = UIImage(named: "Default")
        cell.author.text = "No name author"
        cell.title.text = "No title by this news"
        
        
        
        if articlesArray.count > 0 {
            DispatchQueue.main.async{
                
                self.stopAndRemoveSpinnerView()
                
                let url = URL(string: self.articlesArray[indexPath.row].urlToImage)
                
                if (url?.relativeString.count)! > 0 {
                    cell.image.kf.setImage(with: url)
                } else {
                    cell.image.image = UIImage(named: "Default")
                }
                
                cell.image.kf.setImage(with: url)
            
                let haveAuthor = self.articlesArray[indexPath.row].author
                if haveAuthor.count > 0 {
                    cell.author.text = self.articlesArray[indexPath.row].author
                } else {
                    cell.author.text = "No name author"
                }
                
                let haveTitle = self.articlesArray[indexPath.row].title
                if haveTitle.count > 0 {
                    cell.title.text = self.articlesArray[indexPath.row].title
                } else {
                    cell.title.text = "No title by this news"
                }
            
                
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        let header: String = " All news ".uppercased()

        return header
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
                    }
                self.tableView.reloadData()
            case .failure(let error):
                print("error \(error)")
                
            }
        }
    }

    func createSpinnerView() {
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func stopAndRemoveSpinnerView(){
        DispatchQueue.main.async {
            self.child.willMove(toParent: nil)
            self.child.view.removeFromSuperview()
            self.child.removeFromParent()
        }
    }
}


