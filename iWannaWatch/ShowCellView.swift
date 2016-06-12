//
//  ShowCellView.swift
//  iWannaWatch
//
//  Created by Gaston Siffert on 6/4/16.
//  Copyright © 2016 Gaston Siffert. All rights reserved.
//

import Cocoa

class ShowCellView: NSTableCellView {

    private static let HEIGHT       = 64
    private static let WIDTH        = 200
    
    @IBOutlet weak var image                : NSImageView!
    @IBOutlet weak var titleLabel           : NSTextField!
    @IBOutlet weak var remainingLabel       : NSTextField!
    @IBOutlet weak var episodeStackView     : NSStackView!
    
    private let _request            = ShowRequest()
    private var _episodeControllers = [EpisodeView]()
    
    private var _hasLoaded          = false
    
    var show    : Show? {
        didSet {
            loadGUI()
        }
    }
    
    private func loadGUI() {
        if show == nil {
            return
        }
        
        if let picture = UserStorage.getPicture(show!.title) {
            image.image = picture
        } else {
            _request.getShowWithSize(show!.id, height: ShowCellView.HEIGHT, width: ShowCellView.WIDTH, onSuccess: onSuccess)
        }
        titleLabel.stringValue      = show?.title ?? ""
        remainingLabel.stringValue  = show == nil ? "" : String(show!.remaining)
        buildEpisodeView()
    }

    private func onSuccess(data: NSData) {
        let banner  = NSImage(data: data)!
        image.image = banner
        
        UserStorage.savePicture(show!.title, image: banner)
    }
    
}

extension ShowCellView {
    
    private func buildEpisodeView() {
        for view in episodeStackView.arrangedSubviews {
            episodeStackView.removeView(view)
        }
        
        for episode in (show?.unseen)! {
            let controller      = EpisodeView()
            controller.episode  = episode
            _episodeControllers.append(controller)
            episodeStackView.addArrangedSubview(controller.view)
        }
    }
    
}