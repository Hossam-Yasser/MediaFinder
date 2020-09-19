//
//  MediaListCell.swift
//  Media Finder
//
//  Created by Hossam on 8/22/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import UIKit
import SDWebImage

class MoviesListCell: UITableViewCell {
    
    
    @IBOutlet weak var mediaDescriptionLabel: UILabel!
    @IBOutlet weak var mediaNameLabel: UILabel!
    @IBOutlet weak var mediaImageView: UIImageView!
    @IBOutlet weak var artistNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(media: Media) {

      let mediaType = media.getType()
        if mediaType == MediaTypes.tvShow {
            self.mediaNameLabel.text = media.artistName ?? ""
        }else{
            self.mediaNameLabel.text = media.trackName ?? ""
        }
        if mediaType == MediaTypes.music {
            self.mediaDescriptionLabel.text = media.artistName ?? ""
        } else {
            self.mediaDescriptionLabel.text = media.longDescription ?? ""
        }
        
        if let artImageUrl = URL(string: media.artworkUrl100) {
            mediaImageView.sd_setImage(with: artImageUrl ,placeholderImage: UIImage(named: "placeholder") ,options: .highPriority, progress: nil , completed: nil)
        
    }
    
}
    
    func imageshaker(view: UIImageView, for duration: TimeInterval = 0.5, withTranslation translation: CGFloat = 10) {
        let propertyAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 0.3) {
            view.layer.borderColor = UIColor.red.cgColor
            view.layer.borderWidth = 1
            view.transform = CGAffineTransform(translationX: translation, y: 0)
        }
        
        propertyAnimator.addAnimations({
            view.transform = CGAffineTransform(translationX: 0, y: 0)
        }, delayFactor: 0.2)
        
        propertyAnimator.addCompletion { (_) in
            view.layer.borderWidth = 0
        }
        
        propertyAnimator.startAnimation()
    }
    
    
    @IBAction func imageShakerBTN(_ sender: UIButton) {
        
        imageshaker(view: mediaImageView)
    }
    

}
