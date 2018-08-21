//
//  CustomizeViewController.swift
//  Switcher 5
//
//  Created by 古賀ミッシェル on 2018/07/31.
//  Copyright © 2018 古賀ミッシェル. All rights reserved.
//

import Cocoa

class CustomizeViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
	
	@IBAction func setApp(_ sender: NSButton) {
		let character = UserDefaults.standard.string(forKey: "chosenKey")
		UserDefaults.standard.set(sender.image?.name(), forKey: character!)
		UserDefaults.standard.set(true, forKey: "appChanged")
		self.dismiss(self)
	}
	
	@IBAction func dismissModal(_ sender: Any) {
		self.dismiss(self)
	}
}

extension CustomizeViewController: NSCollectionViewDataSource {
	static let item = "CollectionViewItem"
	func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
		return 5 // Provisory
	}
	func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
		let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: CustomizeViewController.item), for: indexPath)
		return item
	}
}
