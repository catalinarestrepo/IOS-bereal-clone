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
    @IBOutlet weak var dates: UILabel!
    @IBOutlet weak var blur: UIVisualEffectView!
    
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
        if let user = Users.current{
            if user.lastPostedDate == nil{
                blur.isHidden = true
            }
        }
        
        // Date
        if let date = post.createdAt {
            dates.text = DateFormatter.postFormatter.string(from: date)
        }
        // A lot of the following returns optional values so we'll unwrap them all together in one big `if let`
        // Get the current user.
        if let currentUser = Users.current,

            // Get the date the user last shared a post (cast to Date).
           let lastPostedDate = currentUser.lastPostedDate,
        
            // Get the date the given post was created.
           let postCreatedDate = post.createdAt,

            // Get the difference in hours between when the given post was created and the current user last posted.
           let diffHours = Calendar.current.dateComponents([.hour], from: postCreatedDate, to: lastPostedDate).hour {

            // Hide the blur view if the given post was created within 24 hours of the current user's last post. (before or after)
            blur.isHidden = abs(diffHours) < 24
        } else {

            // Default to blur if we can't get or compute the date's above for some reason.
            blur.isHidden = false
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
