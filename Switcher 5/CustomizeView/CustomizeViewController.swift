//
//  CustomizeViewController.swift
//  Switcher 5
//
//  Created by 古賀ミッシェル on 2018/07/31.
//  Copyright © 2018 古賀ミッシェル. All rights reserved.
//

import Cocoa

class CustomizeViewController: NSViewController {
	@IBOutlet weak var appsCollectionView: NSCollectionView!
	
	var images = ["Safari","Numbers","Pages","Xcode-beta","Finder"]
    override func viewDidLoad() {
        super.viewDidLoad()
		
		if let contentSize = self.appsCollectionView.collectionViewLayout?.collectionViewContentSize {
			self.appsCollectionView.setFrameSize(contentSize)
		}
    }
	
	@IBAction func setApp(_ sender: NSButton) {
		UserDefaults.standard.set(true, forKey: "isController") // so I can check if it is controller
		let character = UserDefaults.standard.string(forKey: "chosenKey")
		UserDefaults.standard.set(sender.image?.name(), forKey: character!)
		UserDefaults.standard.set(true, forKey: "appChanged")
		self.dismiss(self)
	}
	
	@IBAction func dismissModal(_ sender: Any) {
		self.dismiss(self)
	}
	@IBAction func selectApp(_ sender: ButtonInsideCollection) {
		if sender.appName != "" {
			UserDefaults.standard.set(false, forKey: "isController") // so I can check if it is controller
			let url = sender.url
			let character = UserDefaults.standard.string(forKey: "chosenKey")
			UserDefaults.standard.set(sender.appName, forKey: character!)
			UserDefaults.standard.set(url, forKey: character! + "Url")
			UserDefaults.standard.set(true, forKey: "appChanged")
			self.dismiss(self)
		} else {
			print("App don't have a name.")
		}
	}
}

extension CustomizeViewController: NSCollectionViewDataSource {
	static let item = "CollectionViewItem"
	static let apps = AppsLoader.getIconsAndUrlsFromApplicationsFolders()
	
	func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
		return CustomizeViewController.apps.count
	}
	func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
		
		
		
		
		
		
		
		let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: CustomizeViewController.item), for: indexPath) as! CollectionViewItem
		let app = CustomizeViewController.apps[indexPath.item]
		item.button.image = NSImage(byReferencing: app.url)
		item.label.stringValue = app.appName
		item.button.appName = app.appName
		item.button.url = app.url
		item.button.image?.size = NSSize(width: 80, height: 80) // Adjust the size of the image
		return item
	}
}
