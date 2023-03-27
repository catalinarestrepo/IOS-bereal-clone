//
//  PostCell.swift
//  Bereal-clone
//
//  Created by Khiem Tran Le on 3/26/23.
//

import UIKit
import Alamofire
import AlamofireImage

class PostCell: UITableViewCell {
    
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var caption: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    private var imageDataRequest: DataRequest?
    
    func configure(with post: Post) {
        // Username
        if let user = post.user {
            userName.text = user.username
        }

        // Image
        if let imageFile = post.imageFile,
           let imageUrl = imageFile.url {
            
            // Use AlamofireImage helper to fetch remote image from URL
            imageDataRequest = AF.request(imageUrl).responseImage { [weak self] response in
                switch response.result {
                case .success(let image):
                    // Set image view image with fetched image
                    self?.postImage.image = image
                case .failure(let error):
                    print("❌ Error fetching image: \(error.localizedDescription)")
                    break
                }
            }
        }

        // Caption
        caption.text = post.caption

        // Date
        if let date = post.createdAt {
            dateLabel.text = DateFormatter.postFormatter.string(from: date)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // TODO: P1 - Cancel image download
        // Reset image view image.
        postImage.image = nil

        // Cancel image request.
        imageDataRequest?.cancel()
    }

}
