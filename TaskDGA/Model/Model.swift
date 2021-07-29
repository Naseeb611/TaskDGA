//
//  Model.swift
//  TaskDGA
//
//  Created by Sarath on 28/07/21.
//

import Foundation
import UIKit
import SDWebImage

// MARK: - Welcome
class Welcome:NSObject {
    var status, copyright: String?
    var num_results: Int?
    var results: [Result]?
    
    init?(_ dictionary: [String: Any]) {
        self.status = dictionary["status"] as? String
        self.num_results = dictionary["num_results"] as? Int
        guard let data = dictionary["results"] as? [[String: Any]]  else {
            return
        }
        self.results = data.compactMap{ return Result($0)}
        
    }
    
}

// MARK: - Result
class Result:NSObject {
    var uri: String?
    var url: String?
    var id, asset_id: Int?
    var source: String?
    var published_date, updated, section, subsection: String?
    var nytdsection, adxKeywords: String?
    var column: NSNull?
    var byline: String?
    var type: String?
    var title, abstract: String?
    var des_facet, org_facet, per_facet, geo_facet: [String]?
    var media: [Media]?
    var eta_id: Int?
    
    init?(_ dictionary: [String: Any]) {
        self.uri = dictionary["uri"] as? String
        self.url = dictionary["url"] as? String
        self.id = dictionary["id"] as? Int
        self.asset_id = dictionary["asset_id"] as? Int
        self.source = dictionary["source"] as? String
        self.published_date = dictionary["published_date"] as? String
        self.updated = dictionary["updated"] as? String
        self.section = dictionary["section"] as? String
        self.subsection = dictionary["subsection"] as? String
        self.nytdsection = dictionary["nytdsection"] as? String
        self.adxKeywords = dictionary["adxKeywords"] as? String
        self.byline = dictionary["byline"] as? String
        self.type = dictionary["type"] as? String
        self.title = dictionary["title"] as? String
        self.abstract = dictionary["abstract"] as? String
        self.des_facet = dictionary["des_facet"] as? [String]
        self.org_facet = dictionary["org_facet"] as? [String]
        self.per_facet = dictionary["per_facet"] as? [String]
        self.geo_facet = dictionary["geo_facet"] as? [String]
        guard let media = dictionary["media"] as?  [[String: Any]]  else {
            return
        }
        self.media =  media.compactMap{ return Media($0)}
        self.eta_id = dictionary["eta_id"] as? Int
    }
  
}

// MARK: - Media
class Media:NSObject {
    var type: String?
    var subtype: String?
    var caption, copyright: String?
    var approved_for_syndication: Int?
    var media_metadata: [MediaMetadatum]?
    
    init?(_ dictionary: [String: Any]) {
        self.type = dictionary["type"] as? String
        self.subtype = dictionary["subtype"] as? String
        self.caption = dictionary["caption"] as? String
        self.copyright = dictionary["copyright"] as? String
        self.approved_for_syndication = dictionary["approved_for_syndication"] as? Int
        guard let media_metadata = dictionary["media-metadata"] as?  [[String: Any]]  else {
            return
        }
        self.media_metadata =  media_metadata.compactMap{ return MediaMetadatum($0)}
       
    }
}

// MARK: - MediaMetadatum
class MediaMetadatum:NSObject {
    var url: String?
    var format: Format?
    var height, width: Int?

    init?(_ dictionary: [String: Any]) {
        self.url = dictionary["url"] as? String
        self.height = dictionary["height"] as? Int
        self.width = dictionary["Width"] as? Int
    }
}

enum Format {
    case mediumThreeByTwo210
    case mediumThreeByTwo440
    case standardThumbnail
}

enum Subtype {
    case photo
}

enum MediaType {
    case image
}

enum Source {
    case newYorkTimes
}

enum ResultType {
    case article
}
struct AppURL {
    
    // URLs
    static let List_URL                  = "http://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/7.json?api-key=xaJSKJmpaALueznSrHCRzPI2SSjuSKNE"
    static let REFRESH_TOCKEN_URL                  = ""
    
}
extension UIViewController {
    func showAlertViewWith(message: String, ok: String){
        let alert = UIAlertController(title: "NyT", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: ok, style: UIAlertAction.Style.destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
enum Storyboard : String {
    case main = "Main"
}

extension UIImageView {
    
    
    
    public func imageFromServerURL(urlString: String, placeHolderImg : String?) {
      
        let withBseURLStr = urlString
        print("image URL:\(withBseURLStr)")
        if let url =  URL(string: withBseURLStr.replacingOccurrences(of: " ", with: "%20")) {
            let pathExtention = url.pathExtension
            
            guard  pathExtention != "gif" else {
                // self.loadForGif(url, placeHolderImg: placeHolderImg)
                return
            }
            SDWebImageManager.shared().cachedImageExists(for: url) { (imageExist) in
               
                if imageExist {
                    if let vw = self.viewWithTag(99) {
                        vw.removeFromSuperview()
                    }
                    self.sd_setImage(with: url, completed: nil)
                } else {
                    if self.viewWithTag(99) == nil {
                        if  placeHolderImg != nil {
                            self.image = UIImage(named: placeHolderImg!)
                        }else {
                           // self.addSubview(loadingAnimation)
                        }
                    }
                    
                    self.sd_setImage(with: url) { (img, err, type, ur) in
                        if let vw = self.viewWithTag(99) {
                            vw.removeFromSuperview()
                        }
                        if img == nil {
                            if  placeHolderImg != nil {
                                self.image = UIImage(named: placeHolderImg!)
                            }else {
                                self.image = UIImage(named: "test")
                            }
                            
                        }
                    }
                }
            }
            
            
        }
        
    }
    
    
    func flipImage() {
        let image = self.image
        let flippedImage = image?.imageFlippedForRightToLeftLayoutDirection()
        self.image = flippedImage
    }
    
    func setBorder() {
        self.layer.borderWidth = 1
       // self.layer.borderColor = UIColor.CellBorderGrayColor().cgColor
    }
}
