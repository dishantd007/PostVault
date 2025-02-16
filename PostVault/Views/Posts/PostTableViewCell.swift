//
//  PostTableViewCell.swift
//  PostVault
//
//  Created by Dishant Choudhary on 14/02/25.
//

import UIKit
import RxSwift

class PostTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var favoriteIcon: UIImageView!
    @IBOutlet weak var commentButton: UIButton!
    
    // MARK: - Properties
    /// Emits post ID on tap
    let commentTapped = PublishSubject<Int>()
    private var postID: Int?
    /// Dispose bag for managing subscriptions
    var disposeBag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setupUI()
        self.setupBindings()
    }

    // MARK: - UI Setup
    private func setupUI() {
        /// Setup Card View
        self.cardView.backgroundColor = .secondarySystemBackground
        self.cardView.layer.cornerRadius = 10
        self.cardView.layer.shadowColor = UIColor.black.cgColor
        self.cardView.layer.shadowOpacity = 0.1
        self.cardView.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.cardView.layer.shadowRadius = 4
        
        /// Setup Title label
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        self.titleLabel.numberOfLines = 0
        
        /// Setup Body label
        self.bodyLabel.font = UIFont.systemFont(ofSize: 14)
        self.bodyLabel.textColor = .gray
        self.bodyLabel.numberOfLines = 0
        
        /// Setup favorite icon
        self.favoriteIcon.contentMode = .scaleAspectFit
        self.favoriteIcon.tintColor = .systemRed
    }
    
    // MARK: - Rx Bindings
    /// Bind the comment button tap event to the commentTapped subject
    private func setupBindings() {
        self.commentButton.rx.tap
            .compactMap { self.postID }
            .bind(to: commentTapped)
            .disposed(by: disposeBag)
    }
    
    // MARK: - Update UI with Post Data
    /// Set favorite icon based on post's favorite status
    func updateUI(with post: Post) {
        self.postID = post.id
        self.titleLabel.text = post.title
        self.bodyLabel.text = post.body
        self.favoriteIcon.image = UIImage(systemName: post.isFavorite ?? false ? Constants.Images.filledHeartIcon : Constants.Images.heartIcon)
    }
}
