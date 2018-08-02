//
//  View.swift
//  Switcher 5
//
//  Created by 古賀ミッシェル on 2018/08/02.
//  Copyright © 2018 古賀ミッシェル. All rights reserved.
//

import Cocoa

class View: NSView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
		let frameSize: NSSize = NSSize(width: 1770, height: 678)
		self.setFrameSize(frameSize)
    }
    
}
