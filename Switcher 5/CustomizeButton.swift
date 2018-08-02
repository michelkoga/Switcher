//
//  CustomizeButton.swift
//  Switcher 5
//
//  Created by 古賀ミッシェル on 2018/08/01.
//  Copyright © 2018 古賀ミッシェル. All rights reserved.
//

import Cocoa

class CustomizeButton: NSButton {
	
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
		
		// (M)Tracking mouse:
		let area = NSTrackingArea.init(rect: self.bounds, options: [.mouseEnteredAndExited, .activeAlways], owner: self, userInfo: nil)
		self.addTrackingArea(area)
		// Background color
        self.layer?.backgroundColor = NSColor.red.cgColor
    }
	// (M)Tracking Mouse:
	override func mouseEntered(with event: NSEvent) {
		self.layer?.backgroundColor = NSColor.red.cgColor
		print("Mouse entered")
	}
	override func mouseExited(with event: NSEvent) {
		self.layer?.backgroundColor = CGColor.clear
	}
    
}
