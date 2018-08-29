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
	let bumpsColor = NSColor.controlAccent
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
		self.image?.size = NSSize(width: 80, height: 80)
		if self.character == "f" || self.character == "j" {
			let jfKeyBumps = NSBezierPath()
			jfKeyBumps.lineWidth = 6
			jfKeyBumps.lineCapStyle = .round
			jfKeyBumps.move(to: CGPoint(x: 40, y: 96))
			jfKeyBumps.line(to: CGPoint(x: 60, y: 96))
			bumpsColor.setStroke()
//			NSColor.init(calibratedWhite: 0.9, alpha: 0.8).setStroke()
			jfKeyBumps.stroke()
		}
		// (M)Tracking mouse:
		let area = NSTrackingArea.init(rect: self.bounds, options: [.mouseEnteredAndExited, .activeAlways], owner: self, userInfo: nil)
		self.addTrackingArea(area)
    }
	// (M)Tracking Mouse:
	override func mouseEntered(with event: NSEvent) {
		self.layer?.backgroundColor = NSColor(named: "ColorMouseEntered")?.cgColor
	}
	override func mouseExited(with event: NSEvent) {
		self.layer?.backgroundColor = CGColor.clear
	}
	override func mouseMoved(with event: NSEvent) {
		print("Moved")
	}
}
