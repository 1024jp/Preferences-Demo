//
//  PreferencesTabViewController.swift
//  Preferences Demo
//
//  Created by 1024jp on 2018-12-18.
//  © 2018-2019 1024jp
//

import Cocoa

final class PreferencesTabViewController: NSTabViewController {
    
    // MARK: Tab View Controller Methods
    
    override var selectedTabViewItemIndex: Int {
        
        didSet {
            // avoid storing initial state (set in the storyboard)
            if
                self.isViewLoaded,
                let identifier = self.tabViewItems[selectedTabViewItemIndex].identifier as? String
            {
                UserDefaults.standard.set(identifier, forKey: "lastPreferencesPaneIdentifier")
            }
        }
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // select last used pane
        if
            let identifier = UserDefaults.standard.string(forKey: "lastPreferencesPaneIdentifier"),
            let item = self.tabViewItems.enumerated().first(where: { ($0.element.identifier as? String) == identifier })
        {
            self.selectedTabViewItemIndex = item.offset
        }
    }
    
    
    override func viewWillAppear() {
        
        super.viewWillAppear()
        
        self.view.window!.title = self.tabViewItems[selectedTabViewItemIndex].label
    }
    
    
    override func tabView(_ tabView: NSTabView, willSelect tabViewItem: NSTabViewItem?) {
        
        super.tabView(tabView, willSelect: tabViewItem)
        
        guard let tabViewItem = tabViewItem else { return assertionFailure() }
        
        self.switchPane(to: tabViewItem)
    }
    
    
    
    // MARK: Private Methods
    
    /// resize window to fit to new view
    private func switchPane(to tabViewItem: NSTabViewItem) {
        
        guard let viewFrame = tabViewItem.view?.frame else { return assertionFailure() }
        
        // initialize tabView's frame size
        guard let window = self.view.window else {
            self.view.frame = viewFrame
            return
        }
        
        // calculate window frame
        var frame = window.frameRect(forContentRect: viewFrame)
        frame.origin = window.frame.origin
        frame.origin.y += window.frame.height - frame.height
        
        // apply to window
        self.view.isHidden = true
        NSAnimationContext.runAnimationGroup({ _ in
            window.animator().setFrame(frame, display: false)
            
        }, completionHandler: { [weak self] in
            self?.view.isHidden = false
            window.title = tabViewItem.label
        })
    }
    
}
