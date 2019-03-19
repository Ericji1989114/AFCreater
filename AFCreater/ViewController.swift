//
//  ViewController.swift
//  AFCreater
//
//  Created by Ki, Un | Eric | PAYSD on 2019/03/13.
//  Copyright © 2019 Ericji. All rights reserved.
//

import Cocoa
import SnapKit

class ViewController: NSViewController {
    
    private let thumbnailIcon_simulatorFM: NSImageView = NSImageView()
    private let thumbnailIcon_deviceFM: NSImageView = NSImageView()
    
    private let simulatorTextField: NSTextField = NSTextField()
    private let deviceTextField: NSTextField = NSTextField()
    private let productTextField: NSTextField = NSTextField()


    override func viewDidLoad() {
        super.viewDidLoad()

        // self setting
        self.view.frame = NSRect(x: 0, y: 0, width: 420, height: 280)
        
        // layout setting
        // button
        let simulatorBtn = simulatorFMButtonLayoutSetting()
        let deviceBtn = deviceFMButtonLayoutSetting(referView: simulatorBtn)
//        let productBtn = productButtonLayoutSetting(referView: deviceBtn)
        executeButtonLayoutSetting()
        
        // thumbnail
        thumbnailIconSimulatorFMLayoutSetting(referView: simulatorBtn)
        thumbnailIconDeviceFMLayoutSetting(referView: deviceBtn)
        
        // textfield
        simulatorTextFieldLayoutSetting(referView1: simulatorBtn, referView2: thumbnailIcon_simulatorFM)
        deviceTextFieldLayoutSetting(referView1: deviceBtn, referView2: thumbnailIcon_deviceFM)
//        productTextFieldLayoutSetting(referView1: productBtn, referView2: thumbnailIcon_deviceFM)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    // MARK: Private function
    // MARK: Layout setting
    private func simulatorFMButtonLayoutSetting() -> NSView {
        
        let button = NSButton(title: "simulator Framework", target: self, action: #selector(self.onTapSimulatorFM(sender:)))
        self.view.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.top.equalTo(30)
            make.left.equalTo(20)
            make.width.equalToSuperview().dividedBy(3)
            make.height.equalTo(30)
        }
        
        return button
    }
    
    private func deviceFMButtonLayoutSetting(referView: NSView) -> NSView {
        
        let button = NSButton(title: "Device Framework", target: self, action: #selector(self.onTapDeviceFM(sender:)))
        self.view.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.left.height.width.equalTo(referView)
            make.top.equalTo(referView.snp.bottom).offset(30)
        }
        
        return button
    }
    
    private func productButtonLayoutSetting(referView: NSView) -> NSView {
        
        let button = NSButton(title: "Product Folder", target: self, action: #selector(self.onTapProductFolder(sender:)))
        self.view.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.left.height.width.equalTo(referView)
            make.top.equalTo(referView.snp.bottom).offset(30)
        }
        
        return button
    }
    
    private func executeButtonLayoutSetting() {
        
        let button = NSButton(title: "Execute", target: self, action: #selector(self.onTapExecute(sender:)))
        self.view.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.bottom.right.equalTo(-20)
            make.height.equalTo(30)
            make.width.equalToSuperview().dividedBy(5)
        }
    }
    
    private func simulatorTextFieldLayoutSetting(referView1: NSView, referView2: NSView) {
        
        simulatorTextField.font = NSFont.systemFont(ofSize: 12)
        simulatorTextField.textColor = NSColor.black
        simulatorTextField.alignment = .left
        simulatorTextField.placeholderString = "Please select framework"
        simulatorTextField.maximumNumberOfLines = 1
        self.view.addSubview(simulatorTextField)
        simulatorTextField.snp.makeConstraints { (make) in
            make.centerY.equalTo(referView1)
            make.left.equalTo(referView1.snp.right).offset(10)
            make.right.equalTo(referView2.snp.left).offset(-20)
            make.height.equalTo(22)
        }
    }
    
    private func deviceTextFieldLayoutSetting(referView1: NSView, referView2: NSView) {
        
        deviceTextField.font = NSFont.systemFont(ofSize: 12)
        deviceTextField.textColor = NSColor.black
        deviceTextField.alignment = .left
        deviceTextField.placeholderString = "Please select framework"
        deviceTextField.maximumNumberOfLines = 1
        self.view.addSubview(deviceTextField)
        deviceTextField.snp.makeConstraints { (make) in
            make.centerY.equalTo(referView1)
            make.left.equalTo(referView1.snp.right).offset(10)
            make.right.equalTo(referView2.snp.left).offset(-20)
            make.height.equalTo(22)
        }
    }
    
    private func productTextFieldLayoutSetting(referView1: NSView, referView2: NSView) {
        
        productTextField.font = NSFont.systemFont(ofSize: 12)
        productTextField.textColor = NSColor.black
        productTextField.alignment = .left
        productTextField.placeholderString = "Please select a path for product"
        productTextField.maximumNumberOfLines = 1
        self.view.addSubview(productTextField)
        productTextField.snp.makeConstraints { (make) in
            make.centerY.equalTo(referView1)
            make.left.equalTo(referView1.snp.right).offset(10)
            make.right.equalTo(referView2.snp.left).offset(-20)
            make.height.equalTo(22)
        }
    }
    
    private func thumbnailIconSimulatorFMLayoutSetting(referView: NSView) {
        
        thumbnailIcon_simulatorFM.coreradius = 10
        thumbnailIcon_simulatorFM.backgroundColor = NSColor.linkColor
        self.view.addSubview(thumbnailIcon_simulatorFM)
        thumbnailIcon_simulatorFM.snp.makeConstraints { (make) in
            make.height.width.equalTo(48)
            make.right.equalTo(-20)
            make.centerY.equalTo(referView)
        }
    }
    
    private func thumbnailIconDeviceFMLayoutSetting(referView: NSView) {
        
        thumbnailIcon_deviceFM.coreradius = 10
        thumbnailIcon_deviceFM.backgroundColor = NSColor.linkColor
        self.view.addSubview(thumbnailIcon_deviceFM)
        thumbnailIcon_deviceFM.snp.makeConstraints { (make) in
            make.height.width.right.equalTo(thumbnailIcon_simulatorFM)
            make.centerY.equalTo(referView)
        }
    }
    
    // MARK: Action
    @objc private func onTapSimulatorFM(sender: NSButton) {
        guard let path = selectFramework() else {return}
        // update textfield
        simulatorTextField.stringValue = path
        thumbnailIcon_simulatorFM.image = NSWorkspace.shared.icon(forFile: path)
    }

    @objc private func onTapDeviceFM(sender: NSButton) {
        guard let path = selectFramework() else {return}
        // update textfield
        deviceTextField.stringValue = path
        thumbnailIcon_deviceFM.image = NSWorkspace.shared.icon(forFile: path)
    }
    
    @objc private func onTapProductFolder(sender: NSButton) {
        guard let path = selectProductFolder() else {return}
        // update textfield
        productTextField.stringValue = path
    }
    
    @objc private func onTapExecute(sender: NSButton) {
        CommandLineManager.init().createIntegrationFramework(simulatorFm: simulatorTextField.stringValue, deviceFm: deviceTextField.stringValue, to: productTextField.stringValue)
    }
    
    // MARK: Private Function
    private func selectFramework() -> String? {
        
        let openpanel = NSOpenPanel()
        openpanel.allowsMultipleSelection = false
        openpanel.canChooseDirectories = false
        openpanel.canChooseFiles = true
        openpanel.allowedFileTypes = ["framework"]
        if openpanel.runModal() == .OK {
            guard let url = openpanel.url else {
                return nil
            }
            let path = url.path
            return path
        } else {
            return nil
        }
    }
    
    private func selectProductFolder() -> String? {
        
        let openpanel = NSOpenPanel()
        openpanel.allowsMultipleSelection = false
        openpanel.canChooseDirectories = true
        openpanel.canChooseFiles = false
        if openpanel.runModal() == .OK {
            guard let url = openpanel.url else {
                return nil
            }
            let path = url.path
            return path
        } else {
            return nil
        }
    }

}

