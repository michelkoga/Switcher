//
//  VisualEffectView.swift
//  Switcher 5
//
//  Created by 古賀ミッシェル on 2018/08/01.
//  Copyright © 2018 古賀ミッシェル. All rights reserved.
//

import Cocoa
class VisualEffectView: NSVisualEffectView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
		self.material = .dark
		self.state = .active
		self.window?.contentView?.addSubview(self)
		
    }
    
}
