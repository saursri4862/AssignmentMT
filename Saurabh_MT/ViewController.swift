//
//  ViewController.swift
//  Saurabh_MT
//
//  Created by saurabh srivastava on 29/07/18.
//  Copyright © 2018 saurabh. All rights reserved.
//

import UIKit

class ViewController: UIViewController{

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchField: UITextField!
    
    var timer:Timer!
    
    var result = [Result]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "WikiTableCell", bundle: nil), forCellReuseIdentifier: "WikiTableCell")
      //  getResults()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @objc func getResults(){
        var text = self.searchField.text!
        DispatchQueue.global().async {
        text = text.replacingOccurrences(of: " ", with: "%20")
        let stringUrl = "https://en.wikipedia.org//w/api.php?action=query&format=json&prop=pageimages%7Cpageterms&generator=prefixsearch&redirects=1&formatversion=2&piprop=thumbnail&pithumbsize=50&pilimit=10&wbptterms=description&gpssearch="+text+"&gpslimit=10"
        let url = URL(string: stringUrl)!
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                let str = error?.localizedDescription
                let alert = UIAlertController(title: "Error", message: str, preferredStyle: .alert)
                let okACtion = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(okACtion)
                self.present(alert, animated: true, completion: nil)
                return
            }
            do{
                
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]{
                    print(json)
                    
                    if let query = json["query"] as? [String:Any]{
                        if let pages = query["pages"] as? [[String:Any]]{
                            self.result.removeAll()
                            for page in pages{
                                var res = Result()
                                res.updateResult(page)
                                self.result.append(res)
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                }
            }
            catch{
                
            }
        }
        task.resume()
        }
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "WikiTableCell", for:indexPath) as! WikiTableCell
        if indexPath.row < result.count{
            cell.updateCell(result[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < result.count{
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
            controller.pageId = result[indexPath.row].id
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        if timer != nil{
            timer.invalidate()
            timer = nil
        }
        self.result.removeAll()
        self.tableView.reloadData()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        return
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let count = (textField.text?.characters.count)!+range.length-string.characters.count
        if count > 3{
            if timer != nil{
                timer.invalidate()
                timer = nil
            }
 //       getResults()
            self.timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(getResults), userInfo: nil, repeats: false)
        }
        return true
    }
    
}

