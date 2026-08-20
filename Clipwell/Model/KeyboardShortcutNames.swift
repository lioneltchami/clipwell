//
//  KeyboardShortcutNames.swift
//  Clipwell
//
//  Created by Joshua Sattler on 28.03.26.
//

import KeyboardShortcuts

extension KeyboardShortcuts.Name {
    static let toggleRecording = Self("toggleRecording")
    static let selectContent = Self("selectContent")
    static let selectArea = Self("selectArea")
    static let cycleCameraLayout = Self("cycleCameraLayout")
    static let cameraLayoutSmall = Self("cameraLayoutSmall")
    static let cameraLayoutLarge = Self("cameraLayoutLarge")
    static let cameraLayoutBar = Self("cameraLayoutBar")
    static let cameraLayoutHidden = Self("cameraLayoutHidden")
    static let togglePauseRecording = Self("togglePauseRecording")
    static let toggleAnnotationDrawMode = Self("toggleAnnotationDrawMode")
    static let clearAnnotations = Self("clearAnnotations")

    static let clipwellShortcutNames: [Self] = [
        .toggleRecording,
        .selectContent,
        .selectArea,
        .cycleCameraLayout,
        .cameraLayoutSmall,
        .cameraLayoutLarge,
        .cameraLayoutBar,
        .cameraLayoutHidden,
        .togglePauseRecording,
        .toggleAnnotationDrawMode,
        .clearAnnotations
    ]
}
