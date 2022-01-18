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
import QtQuick.Templates 2.4 as T
import org.deepin.dtk.impl 1.0 as D
import org.deepin.dtk.style 1.0 as DS

T.MenuItem {
    id: control

    implicitWidth: DS.Style.control.implicitWidth(control)
    implicitHeight: DS.Style.control.implicitHeight(control)
    baselineOffset: contentItem.y + contentItem.baselineOffset

    padding: DS.Style.control.padding
    spacing: DS.Style.control.spacing

    icon {
        height: DS.Style.menu.itemIconSize.height
        width: DS.Style.menu.itemIconSize.height
    }

    property D.Palette itemColor:  D.Palette {
        normal: control.palette.text
        hovered: control.palette.base
    }
    contentItem: D.IconLabel {
        property bool existsChecked: {
            for (var i = 0; i < menu.count; ++i) {
                var item = menu.itemAt(i)
                if (item && item.checked)
                    return true
            }
            return false
        }
        readonly property real arrowPadding: control.subMenu && control.arrow ? control.arrow.width + control.spacing : 0
        readonly property real indicatorPadding: existsChecked && control.indicator ? control.indicator.width + control.spacing : 0
        leftPadding: !control.mirrored ? indicatorPadding : arrowPadding
        rightPadding: control.mirrored ? indicatorPadding : arrowPadding

        spacing: control.spacing
        mirrored: control.mirrored
        display: control.display
        alignment: Qt.AlignLeft
        text: control.text
        font: control.font
        color: control.D.ColorSelector.itemColor
        icon: D.DTK.makeIcon(control.icon, D.DciIcon)
    }

    indicator: D.QtIcon {
        anchors {
            left: control.left
            leftMargin: control.mirrored ? control.width - width - control.rightPadding : control.leftPadding
            verticalCenter: parent.verticalCenter
        }
        visible: control.checked
        name: "mark_indicator"
        color: control.D.ColorSelector.itemColor
    }

    arrow: D.DciIcon {
        anchors {
            right: parent.right
            rightMargin: control.mirrored ? control.width - width - control.rightPadding : control.rightPadding
            verticalCenter: parent.verticalCenter
        }
        visible: control.subMenu
        mirror: control.mirrored
        name: control.subMenu ? "go-next" : ""
        color: control.D.ColorSelector.itemColor
    }

    background:  HighlightPanel {
        implicitWidth: DS.Style.menu.itemWidth
        implicitHeight: DS.Style.menu.itemHeight
        backgroundColor.normal: (!control.hovered && control.subMenu && control.subMenu.opened)
                                ? DS.Style.menu.subMenuOpendBackground : "transparent"
    }
}