//
//  Permissions.swift
//  Chimesy
//
//  Created by Swift Admin on 2023-12-18.
//

import Foundation
//For requesting permissions for stuff
import UIKit
import AVFoundation

class YourViewController: ViewController, UIDocumentPickerDelegate {
    var picked = false
    var convertedURL: URL?
    func convertToM4A(inputURL: URL, outputURL: URL) -> URL?{
        let asset = AVAsset(url: inputURL)
        let exporter = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetPassthrough)

        // Set the output file type to ma4
        exporter?.outputFileType = .caf
        exporter?.outputURL = outputURL
        print(outputURL)

        exporter?.exportAsynchronously {
            //Change all this
            if exporter?.status == .completed {
                print("Conversion to MP3 successful.")
            } else if exporter?.status == .failed {
                print("Conversion to MP3 failed: \(exporter?.error?.localizedDescription ?? "Unknown error")")
            }
        }
        picked = true
        return outputURL
    }
    func showDocumentPicker() {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.audio, .video])
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        present(documentPicker, animated: true, completion: nil)
    }

    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let pickedURL = urls.first else {
            return
        }
        let outputURL = pickedURL.deletingPathExtension().appendingPathExtension("caf")
        convertedURL = convertToM4A(inputURL: pickedURL, outputURL: outputURL)
    }
}

