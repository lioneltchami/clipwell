//
//  KeyboardShortcutNamesTests.swift
//  ClipwellTests
//

import KeyboardShortcuts
import Testing
@testable import Clipwell

struct KeyboardShortcutNamesTests {

    @Test func allShortcutNamesAreUniqueAndOptIn() {
        let names = KeyboardShortcuts.Name.clipwellShortcutNames

        #expect(names.count == 11)
        #expect(Set(names).count == names.count)
        #expect(names.allSatisfy { $0.defaultShortcut == nil })
    }

    @Test func shortcutNamesMatchTheirStoredIdentifiers() {
        let names = KeyboardShortcuts.Name.clipwellShortcutNames.map(\.rawValue)

        #expect(names == [
            "toggleRecording",
            "selectContent",
            "selectArea",
            "cycleCameraLayout",
            "cameraLayoutSmall",
            "cameraLayoutLarge",
            "cameraLayoutBar",
            "cameraLayoutHidden",
            "togglePauseRecording",
            "toggleAnnotationDrawMode",
            "clearAnnotations"
        ])
    }
}
