//
//  DetailViewController.swift
//  TaskDGA
//
//  Created by Sarath on 29/07/21.
//

import UIKit

class DetailViewController: UIViewController {
    var getResultData:Result?

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAbsract: UILabel!
    @IBOutlet weak var lblByLineName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var imgPerson: UIImageView!
    override func viewWillAppear(_ animated: Bool) {
        self.lblByLineName.text = getResultData?.byline
        self.lblTitle.text = getResultData?.title
        self.lblAbsract.text = getResultData?.abstract
        if let strImg = getResultData?.media?[0].media_metadata?[0].url {
            self.imgPerson.imageFromServerURL(urlString: strImg, placeHolderImg: "")
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
