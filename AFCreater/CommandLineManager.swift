//
//  CommandLineManager.swift
//  AFCreater
//
//  Created by Ki, Un | Eric | PAYSD on 2019/03/13.
//  Copyright © 2019 Ericji. All rights reserved.
//

import Cocoa

class CommandLineManager: NSObject {    
    
    func createIntegrationFramework(simulatorFm path1: String, deviceFm path2: String, to destinationFolderPath: String) {
        
        guard path1.fileName == path2.fileName else { return }
        
        let task = Process()
        let pipe = Pipe()
        let cmd = "/usr/bin/lipo"
        // get binary file
        guard let simulatorFmBinaryPath = self.searchForBinaryFile(in: path1), !simulatorFmBinaryPath.isEmpty else { return }
        guard let deviceFmBinaryPath = self.searchForBinaryFile(in: path2), !deviceFmBinaryPath.isEmpty else { return }
        
        // get file name
        let fileName = path1.fileName
        guard !fileName.isEmpty else { return }
        
        // get file name without extension
        let fileNameWithExt = path1.fileNameWithExt
        guard !fileNameWithExt.isEmpty else { return }
        
        let productPath = destinationFolderPath + "/" + fileName + "/" + fileNameWithExt
        
        task.arguments = ["-create",simulatorFmBinaryPath, deviceFmBinaryPath, "-output", deviceFmBinaryPath]
        task.launchPath = cmd
        task.standardOutput = pipe
        task.launch()
        task.waitUntilExit()
        
    }
    
    // MARK: Private Functions
    func searchForBinaryFile(in frameworkPath: String) -> String? {
        
        let fileManager = FileManager()
        guard fileManager.fileExists(atPath: frameworkPath) else { return nil }
        
        // get file name
        let fileName = frameworkPath.fileName
        guard !fileName.isEmpty else { return nil }
        
        // get file name without extension
        let fileNameWithExt = frameworkPath.fileNameWithExt
        guard !fileNameWithExt.isEmpty else { return nil }
        
        do {
            let contentFiles = try fileManager.contentsOfDirectory(atPath: frameworkPath)
            if contentFiles.contains(fileNameWithExt) {
                return frameworkPath + "/" + fileNameWithExt
            } else {
                return nil
            }
        } catch {
            return nil
        }
        
    }
    

}
