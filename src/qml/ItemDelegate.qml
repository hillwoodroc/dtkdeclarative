/*
 * Copyright (C) 2022 UnionTech Technology Co., Ltd.
 *
 * Author:     yeshanshan <yeshanshan@uniontech.com>
 *
 * Maintainer: yeshanshan <yeshanshan@uniontech.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Templates 2.4 as T
import QtQuick.Layouts 1.11
import org.deepin.dtk.impl 1.0 as D
import org.deepin.dtk.style 1.0 as DS

T.ItemDelegate {
    id: control
    property bool indicatorVisible
    property bool alternateHighlight: true
    property bool cascadeSelected
    property bool contentFlow
    property Component content
    property D.Palette checkedTextColor: DS.Style.checkedButtonText

    implicitWidth: DS.Style.control.implicitWidth(control)
    implicitHeight: DS.Style.control.implicitHeight(control)
    baselineOffset: contentItem.y + contentItem.baselineOffset
    padding: DS.Style.control.padding
    spacing: DS.Style.control.spacing
    checkable: true
    autoExclusive: true
    palette.windowText: checked && !control.cascadeSelected ? D.ColorSelector.checkedTextColor : undefined

    indicator: D.DciIcon {
        x: control.text ? (control.mirrored ? control.leftPadding : control.width - width - control.rightPadding) : control.leftPadding + (control.availableWidth - width) / 2
        y: control.topPadding + (control.availableHeight - height) / 2
        visible: control.indicatorVisible && control.checked
        palette: control.D.DTK.makeIconPalette(control.palette)
        mode: control.D.ColorSelector.controlState
        name: "mark_indicator"
        sourceSize: Qt.size(DS.Style.itemDelegate.checkIndicatorIconSize, DS.Style.itemDelegate.checkIndicatorIconSize)
    }

    contentItem: RowLayout {
        D.IconLabel {
            spacing: control.spacing
            mirrored: control.mirrored
            display: control.display
            alignment: control.display === D.IconLabel.IconOnly || control.display === D.IconLabel.TextUnderIcon ? Qt.AlignCenter : Qt.AlignLeft
            text: control.text
            font: control.font
            color: control.palette.windowText
            icon: D.DTK.makeIcon(control.icon, control.D.DciIcon)
            Layout.fillWidth: !control.contentFlow
        }
        Loader {
            sourceComponent: control.content
            Layout.fillWidth: control.contentFlow
            Layout.alignment: control.contentFlow ? Qt.AlignLeft : Qt.AlignRight
        }
    }

    background: Item {
        implicitWidth: DS.Style.itemDelegate.width
        implicitHeight: DS.Style.itemDelegate.height
        HighlightPanel {
            anchors.fill: parent
            visible: checked && !control.cascadeSelected
        }
        Rectangle {
            anchors.fill: parent
            visible: checked && control.cascadeSelected
            color: DS.Style.itemDelegate.cascadeColor
            radius: DS.Style.control.radius
        }
        Rectangle {
            anchors.fill: parent
            visible: !checked && (control.alternateHighlight ? index % 2 === 0 : true)
            color: DS.Style.itemDelegate.normalColor
            radius: DS.Style.control.radius
        }
    }
}