//
//  BugReportControllerTests.swift
//  WhereIsUBikeTests
//
//  Created by t19960804 on 2018/11/11.
//  Copyright © 2018 t19960804. All rights reserved.
//

import XCTest
@testable import WhereIsUBike
class BugReportControllerTests: XCTestCase {
    var bugReportController: BugReportController!
    override func setUp() {
        bugReportController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "bugReportController") as! BugReportController
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testComponent(){
        XCTAssertEqual(bugReportController.bugDate_Label.text, "日期")
        XCTAssertEqual(bugReportController.bugDate_Button.currentTitle, "請選擇")
        XCTAssertEqual(bugReportController.close_DatePicker.currentImage, UIImage(named: "cancel2"))
        XCTAssertEqual(bugReportController.bugTitle_Label.text, "標題")
        XCTAssertEqual(bugReportController.bugTitle_TextField.placeholder, "請輸入")
        XCTAssertEqual(bugReportController.bugDiscription_Label.text, "問題敘述")

    }
    func testClearUserInput(){
        bugReportController.clearUserInput()
        XCTAssertEqual(bugReportController.bugDate_Button.currentTitle, "請選擇")
        XCTAssertEqual(bugReportController.bugTitle_TextField.text, "")
        XCTAssertEqual(bugReportController.bugDiscription_TextView.text, "")
        
    }
    func testIsEnabledComponents(){
        bugReportController.isEnabledComponents(with: false)
        XCTAssertFalse(bugReportController.bugTitle_TextField.isEnabled)
        XCTAssertFalse(bugReportController.bugDiscription_TextView.isEditable)
    }
   

}
