import XCTest

#if !canImport(ObjectiveC)
    public func allTests() -> [XCTestCaseEntry] {
        [
            testCase(BlinkKitTests.allTests),
        ]
    }
#endif
