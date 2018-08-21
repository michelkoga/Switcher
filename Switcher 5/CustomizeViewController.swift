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
		// Test appsLoader
		let apps = AppsLoader.getIconsAndUrlsFromApplicationsFolders()
		for app in apps {
			print("Name: \(app.appName), Url: \(app.url)")
		}
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
	static let apps = AppsLoader.getIconsAndUrlsFromApplicationsFolders()
	
	func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
		return CustomizeViewController.apps.count
	}
	func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
		
		
		
		
		
		
		
		let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: CustomizeViewController.item), for: indexPath) as! CollectionViewItem
		let iconUrl = CustomizeViewController.apps[indexPath.item].url
		print("The url is \(iconUrl)")
		item.button.image = NSImage(byReferencing: iconUrl)
		item.button.image?.size = NSSize(width: 100, height: 100) // Adjust the size of the image
		return item
	}
}
