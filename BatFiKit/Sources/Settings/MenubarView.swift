//
//  File.swift
//  
//
//  Created by Adam on 19/09/2023.
//

import Defaults
import L10n
import SettingsKit
import SwiftUI

struct MenubarView: View {
    @Default(.monochromeStatusIcon)                 private var monochrom
    @Default(.showBatteryPercentageInStatusIcon)    private var batteryPercentage
    @Default(.showChart)                            private var showChart
    @Default(.showPowerDiagram)                     private var showPowerDiagram
    @Default(.showHighEnergyImpactProcesses)        private var showHighEnergyImpactProcesses
    @State                                          private var showingPopover = false

    var body: some View {
        let l10n = L10n.Settings.self
        Container(contentWidth: settingsContentWidth) {
            Section(title: l10n.Section.menu) {
                Toggle(l10n.Button.Label.showBatteryChartInMenu, isOn: $showChart)
                Toggle(l10n.Button.Label.showPowerDiagram, isOn: $showPowerDiagram)
                HStack(alignment: .top) {
                    Toggle(l10n.Button.Label.showHighEnergyImpactProcesses, isOn: $showHighEnergyImpactProcesses)
                    Button(action: { showingPopover.toggle() }, label: { Text(L10n.Menu.Label.settings) })
                        .popover(isPresented: $showingPopover, content: {
                            HighEnergyImpactSettingsView()
                        })
                }
            }
            
            Section(title: l10n.Section.statusIcon, bottomDivider: true) {
                Toggle(l10n.Button.Label.monochromeIcon, isOn: $monochrom)
                Toggle(l10n.Button.Label.batteryPercentage, isOn: $batteryPercentage)
            }
        }
    }

    static let pane: Pane<Self> = {
        Pane(
            identifier: NSToolbarItem.Identifier("Menubar"),
            title: L10n.Settings.Tab.Title.statusBar,
            toolbarIcon: NSImage(
                systemSymbolName: "menubar.rectangle",
                accessibilityDescription: L10n.Settings.Accessibility.Title.statusBar
            )!
        ) {
            Self()
        }

    }()
}
