//
//  View.swift
//  Switcher 5
//
//  Created by 古賀ミッシェル on 2018/08/02.
//  Copyright © 2018 古賀ミッシェル. All rights reserved.
//

import Cocoa

class View: NSView {
	// Doesn't work
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
		let frameSize: NSSize = NSSize(width: 1180, height: 452)
		self.setFrameSize(frameSize)
		self.layer?.cornerRadius = 15
		
		let visualEffectView = NSVisualEffectView(frame: NSMakeRect(0, 0, 1180, 452))
		visualEffectView.material = NSVisualEffectView.Material.dark
		visualEffectView.blendingMode = NSVisualEffectView.BlendingMode.behindWindow
		visualEffectView.wantsLayer = true
		visualEffectView.layer?.cornerRadius = 15.0
		self.addSubview(visualEffectView)
    }
    
}
