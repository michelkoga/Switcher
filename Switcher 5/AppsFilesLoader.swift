//
//  AppsFilesLoader.swift
//  Switcher 5
//
//  Created by 古賀ミッシェル on 2018/08/21.
//  Copyright © 2018 古賀ミッシェル. All rights reserved.
//

import Foundation
class AppsLoader {
	private static let applicationUrl = URL(fileURLWithPath: "/Applications/")
	static func getIconsAndUrlsFromApplicationsFolders() -> [(appName: String, url: URL)] {
		let allFilesFromFolder = Loader.contentsOf(folder: applicationUrl)
		let allAppFilesOnly = Loader.filterToApplicationsOnly(of: allFilesFromFolder)
		let completeUrl = Loader.appendIconPath(urls: allAppFilesOnly)
		let allIconsUrl = Loader.getIconFolder(urls: completeUrl)
		// Working above
		
		// Creating tuples
		var tuples = [(appName: String, url: URL)]()
		
		for url in allIconsUrl {
			let appName = Loader.getAppName(url: url)
			tuples.append((appName: appName, url: url))
		}
		return tuples
	}
}
