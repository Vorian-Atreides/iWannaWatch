//
//  ShowCell.swift
//  iWannaWatch
//
//  Created by Gaston Siffert on 6/22/16.
//  Copyright © 2016 Gaston Siffert. All rights reserved.
//

import Cocoa

class ShowView: NSViewController {

    private static let  HEIGHT      = 64
    private static let  WIDTH       = 200
    
    @IBOutlet weak var  imageView   : NSImageView!
    @IBOutlet weak var  titleLabel  : NSTextField!
    @IBOutlet weak var  unseenLabel : NSTextField!
    @IBOutlet weak var  tableView   : NSTableView!
    @IBOutlet weak var  scrollView  : NSScrollView!
    
    private var         episodes    = [EpisodeView]()
    
    private let         request     = ShowRequest()
    
    var show    : Show? {
        didSet {
            loadGUI()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadGUI()
    }
    
    func loadGUI() {
        if show == nil {
            return
        }
        
        titleLabel?.stringValue     = show!.title ?? ""
        unseenLabel?.stringValue    = String(show!.remaining ?? 0)

        if let title = show!.title, let picture = UserStorage.getPicture(title) {
            imageView?.image = picture
        } else if let id = show!.id {
            request.getShowWithSize(id, height: ShowView.HEIGHT, width: ShowView.WIDTH, onSuccess: onSuccess)
        }

    }
    
    private func onSuccess(data: NSData) {
        let banner  = NSImage(data: data)!
        imageView?.image = banner
        
        if let title = show!.title {
            UserStorage.savePicture(title, image: banner)
        }
    }
    
}

extension ShowView: NSTableViewDataSource {

    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return show?.unseen.count ?? 0
    }

}

extension ShowView: NSTableViewDelegate {
    
    func selectionShouldChangeInTableView(tableView: NSTableView) -> Bool {
        return false
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        let episode     = EpisodeView()
        episode.episode = show?.unseen[row]
        
        episodes.append(episode)
        return episode.view
    }

}