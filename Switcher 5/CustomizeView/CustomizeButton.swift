//
//  CustomizeButton.swift
//  Switcher 5
//
//  Created by 古賀ミッシェル on 2018/08/01.
//  Copyright © 2018 古賀ミッシェル. All rights reserved.
//

import Cocoa

class CustomizeButton: NSButton {
	@IBInspectable var character: String = ""
	
	override func draw(_ dirtyRect: NSRect) {
		super.draw(dirtyRect)
		self.image?.size = NSSize(width: 80, height: 80)
		if self.character == "f" || self.character == "j" {
			let jfKeyBumps = NSBezierPath()
			jfKeyBumps.lineWidth = 6
			jfKeyBumps.lineCapStyle = .round
			jfKeyBumps.move(to: CGPoint(x: 40, y: 96))
			jfKeyBumps.line(to: CGPoint(x: 60, y: 96))
			NSColor.init(calibratedWhite: 0.5, alpha: 0.8).setStroke()
			jfKeyBumps.stroke()
		}
		let buttonBorders = NSBezierPath()
		buttonBorders.lineWidth = 1
		buttonBorders.move(to: CGPoint(x: 0, y: 0))
		buttonBorders.line(to: CGPoint(x: self.frame.width, y: 0))
		buttonBorders.line(to: CGPoint(x: self.frame.width, y: self.frame.height))
		buttonBorders.line(to: CGPoint(x: 0, y: self.frame.height))
		buttonBorders.line(to: CGPoint(x: 0, y: 0))
		NSColor.init(calibratedWhite: 0.5, alpha: 0.8).setStroke()
		buttonBorders.stroke()
		// (M)Tracking mouse:
		let area = NSTrackingArea.init(rect: self.bounds, options: [.mouseEnteredAndExited, .activeAlways], owner: self, userInfo: nil)
		self.addTrackingArea(area)
	}
	// (M)Tracking Mouse:
	override func mouseEntered(with event: NSEvent) {
		self.layer?.backgroundColor = CGColor.init(gray: 0.2, alpha: 0.3)
		for case let button as CloseButton in (self.superview?.subviews)! {
			if button.relatedButton == self.character {
				button.isHidden = false
			}
		}
	}
	override func mouseExited(with event: NSEvent) {
		self.layer?.backgroundColor = CGColor.clear
		for case let button as CloseButton in (self.superview?.subviews)! {
			if button.relatedButton == self.character {
				button.isHidden = true
			}
		}
	}
	override func mouseMoved(with event: NSEvent) {
		print("Moved")
	}
}
