//
//  ListViewController.swift
//  TaskDGA
//
//  Created by Sarath on 28/07/21.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var tblList: UITableView!
    var getResultData:[Result]?{
        didSet {
            DispatchQueue.main.async {
                self.tblList.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getList()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension ListViewController {
    func getList() {
        print("url : \(AppURL.List_URL)")
        ApiHandler.getParseService(with: AppURL.List_URL, methods: .get, parameters: [:], image: [nil], in: self, background: false) { (responseObject, error, networkID) in
            guard error == nil else {
                return
            }
            if let josn = responseObject as? [String : Any] {
                self.getListresponseHandler(josn: josn, networkID: networkID)
            }
        }
    }
    fileprivate func getListresponseHandler(josn: [String : Any], networkID: Int) {
        let response = Welcome(josn)
        print("getListresponseHandlerModel :\(response)")
        if response?.status == "OK" {
            self.getResultData = response?.results
           print("Data retrive")
        } else {
           // self.orderData = []
                self.showAlertViewWith(message:  "Error", ok: "Ok")
        }
        
    }
}
extension ListViewController :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.getResultData?.count ?? 0
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell") as! ListTableViewCell
        cell.lblText1.text = getResultData?[indexPath.row].title
        cell.lblTexte2.text = getResultData?[indexPath.row].abstract
        cell.lblDate.text = getResultData?[indexPath.row].published_date
        print(indexPath.row)
        if  getResultData?[indexPath.row].media?.count != 0 {
            if let strImg = getResultData?[indexPath.row].media?[0].media_metadata?[0].url {
                cell.imgArticle.imageFromServerURL(urlString: strImg, placeHolderImg: "")
            }
        }
       
           return cell

       }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.instatiateDetailViewController()
        vc.getResultData = self.getResultData?[indexPath.row]
         self.navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
extension UIStoryboard {
    static func instatiateFromMain(identifier: String) -> UIViewController {
        return instatiate(from: .main, identifier: identifier)
    }
    // optionally add convenience methods for other storyboards here ...

    // ... or use the main instatiateing method directly when
    // instantiating view controller from a specific storyboard
    static func instatiate(from storyboard: Storyboard, identifier: String) -> UIViewController {
        let uiStoryboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        return uiStoryboard.instantiateViewController(withIdentifier: identifier)
    }
    class func instatiateListViewController() -> ListViewController {
        return instatiateFromMain(identifier: "ListViewController") as! ListViewController
    }
    class func instatiateDetailViewController() -> DetailViewController {
        return instatiateFromMain(identifier: "DetailViewController") as! DetailViewController
    }
}
