//
//  Button.swift
//  Switcher 5
//
//  Created by 古賀ミッシェル on 2018/07/31.
//  Copyright © 2018 古賀ミッシェル. All rights reserved.
//

import Cocoa

class Button: NSButton {
	
	@IBInspectable var character: String = ""
	@IBInspectable var appName: String = ""
	
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
		if self.tag == 1 || self.tag == 2 {
			let jfKeyBumps = NSBezierPath()
			jfKeyBumps.lineWidth = 6
			jfKeyBumps.lineCapStyle = NSBezierPath.LineCapStyle.roundLineCapStyle
			jfKeyBumps.move(to: CGPoint(x: 40, y: 96))
			jfKeyBumps.line(to: CGPoint(x: 60, y: 96))
			NSColor.init(calibratedWhite: 0.9, alpha: 0.8).setStroke()
			jfKeyBumps.stroke()
		}
		// (M)Tracking mouse:
		let area = NSTrackingArea.init(rect: self.bounds, options: [.mouseEnteredAndExited, .activeAlways], owner: self, userInfo: nil)
		self.addTrackingArea(area)
    }
	// (M)Tracking Mouse:
	override func mouseEntered(with event: NSEvent) {
		self.layer?.backgroundColor = CGColor.init(gray: 0.2, alpha: 0.1)
	}
	override func mouseExited(with event: NSEvent) {
		self.layer?.backgroundColor = CGColor.clear
	}
}
