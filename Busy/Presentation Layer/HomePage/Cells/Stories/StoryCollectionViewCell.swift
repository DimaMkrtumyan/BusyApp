//
//  StoryCollectionViewCell.swift
//  Busy
//
//  Created by Davit Muradyan on 29.12.21.
//

import UIKit

class StoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var storyImageView: UIImageView!
    var id: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setContent(story: Story) {
        storyImageView.load(str: story.image)
        id = story.id
    }
    
    func setContentForAll(story: AllAdds) {
        storyImageView.load(str: story.image)
        id = story.id
    }
}

