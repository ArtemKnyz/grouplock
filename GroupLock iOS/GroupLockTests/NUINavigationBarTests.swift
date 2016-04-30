//
//  NUINavigationBarTests.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 15.04.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import XCTest
import NUI
@testable import GroupLock

class NUINavigationBarTests: XCTestCase {
    
    let correspondingClass = "NavigationBar"
    
    // System Under Test:
    var sut: UINavigationBar!
    
    var barTintColor: UIColor?
    var fontColor: UIColor?
    var backgroundTintColor: UIColor?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        NUISettings.initWithStylesheet("UI")
        
        sut = UINavigationBar(frame: CGRect(x: 0, y: 0, width: 100, height: 10))
        sut.applyNUI()
        
        // We'll take all the properties for this particular SUT from the NSS-file as control properties
        barTintColor        = NUISettings.getColor("bar-tint-color",        withClass: correspondingClass)
        fontColor           = NUISettings.getColor("font-color",            withClass: correspondingClass)
        backgroundTintColor = NUISettings.getColor("background-tint-color", withClass: correspondingClass)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        sut = nil
        
        super.tearDown()
    }
    
    // MARK: Test Methods
    
    func testSetBarTintColor() {
        XCTAssertEqual(sut.barTintColor, barTintColor, "NUI should set UINavigationBar bar tint color")
    }
    
    func testSetFontColor() {
        XCTAssertEqual(sut.titleTextAttributes?[NSForegroundColorAttributeName] as? UIColor, fontColor,
                       "NUI should set UINavigationBar font color")
    }
    
    func testSetBackgroundTintColor() {
        XCTAssertEqual(sut.tintColor, backgroundTintColor, "NUI should set UINavigationBar tint color")
    }
}
