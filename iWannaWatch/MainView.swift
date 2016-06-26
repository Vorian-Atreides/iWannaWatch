//
//  MainView.swift
//  iWannaWatch
//
//  Created by Gaston Siffert on 6/8/16.
//  Copyright © 2016 Gaston Siffert. All rights reserved.
//

import Cocoa

class MainView: NSViewController {

    @IBOutlet weak var  tableView       : NSTableView!
    
    private let         episodeRequests = EpisodesRequest()
    private var         showViews       = [ShowView]()
    
    private var         timer           : NSTimer?
    private let         reachability    = Reachability()
    
    var delegate    : IReachabilityDelegate?
    
    private var shows = [Show]() {
        didSet {
            showViews.removeAll()
            tableView.reloadData()
            tableView.layout()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        startCheckNews()
    }
    
    @objc
    private func loadEpisodes() {
        print("Load episodes at: \(NSDate())")
        shows = [Show]()
        episodeRequests.get(onEpisodesSuccess, onErrors: onEpisodeFailed)
    }
    
    private func onEpisodesSuccess(shows: [Show]) {
        delegate?.isReachable()
        
        self.shows = shows.sort({ (first, second) -> Bool in
            return first.title < second.title
        })
    }
    
    private func onEpisodeFailed(errors: [Error]) {
        if let error = errors.first {
            if error.code == 0 {
                delegate?.isUnreachable()
                startCheckReachability()
            }
        }
    }
}

extension MainView {
    
    private func startCheckNews() {
        timer?.invalidate()
        timer = NSTimer(timeInterval: 10 * 60, target: self, selector:
            #selector(MainView.loadEpisodes), userInfo: nil, repeats: true)
        NSRunLoop.mainRunLoop().addTimer(timer!, forMode: NSRunLoopCommonModes)
        loadEpisodes()
    }
    
    private func startCheckReachability() {
        timer?.invalidate()
        timer = NSTimer(timeInterval: 10, target: self, selector:
            #selector(MainView.checkReachability), userInfo: nil, repeats: true)
        NSRunLoop.mainRunLoop().addTimer(timer!, forMode: NSRunLoopCommonModes)
        checkReachability()
    }
    
    @objc
    private func checkReachability() {
        reachability.Ping({ [weak self] in
            
            self?.delegate?.isReachable()
            self?.startCheckNews()
            
        }) { [weak self] in
            
            self?.delegate?.isUnreachable()
        }
    }
    
}

extension MainView: NSTableViewDataSource {
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return shows.count
    }
    
}

extension MainView: NSTableViewDelegate {
    
    private static let SHOW_CELL_IDENTIFIER = "show_cell"
    
    func selectionShouldChangeInTableView(tableView: NSTableView) -> Bool {
        return false
    }
    
    func tableView(tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        let height = 64 + shows[row].unseen.count * (32 + 2)
        return CGFloat(height)
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        let show    = ShowView()
        show.show   = shows[row]

        showViews.append(show)
        return show.view
    }
    
}