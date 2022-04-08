import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import org.julialang

ApplicationWindow {
  title: "Arrays"
  width: 200
  height: 500
  visible: true

  ColumnLayout {
    id: root
    spacing: 6
    anchors.fill: parent

    ListView {
      width: 200
      height: 125
      model: array_model
      delegate: Text { text: string}
    }

    ListView {
      id: decoratedlv
      width: 200
      height: 125
      model: array_model2
      delegate: Text {
        text: decorated
      }
    }

    ListView {
      id: lv
      width: 200
      height: 125
      model: array_model2
      delegate: TextField {
        placeholderText: myrole.toString()
        onTextChanged: myrole = text
      }
    }

    Component
    {
      id: columnComponent
        Rectangle {
            implicitWidth: 50

            Text {
                text: role
            }
        }
    }

    TableView {
      id: tabview
      width: 200
      height: 125
      model: tablemodel

      function generateText(item) {
        var label = ""
        for (var i = 0; i < tablemodel.roles.length; ++i) {
          console.log(tablemodel.roles[i], item.c, i)
          label += "%1 " // .arg(item[tablemodel.roles[i]])
        }

        return label.trim()
      }

      delegate: Rectangle {
        implicitWidth: 50
        implicitHeight: 50

        property string text: cellText.text

        Text {
          id: cellText
          text: tabview.generateText(model)
        }
      }

      /* function setcolumns() { */
      /*   model = null */

      /*   for(var i=0; i < tablemodel.roles.length; i++) { */
      /*     var role  = tablemodel.roles[i]; */
      /*     addColumn(columnComponent.createObject(tabview, { "role": role, "title": role})) */
      /*   } */
      /*   model = tablemodel */
      /* } */

      /* Connections { */
      /*   target: tablemodel */
      /*   function onRolesChanged() { */
      /*     tabview.setcolumns() */
      /*   } */
      /* } */

      /* Component.onCompleted: setcolumns() */
    }
  }

  Timer {
    interval: 500; running: true; repeat: false
    onTriggered: {

      decoratedlv.currentIndex = 0
      if(decoratedlv.currentItem.text != "---A---") {
        Julia.testfail("wrong value in decorated list: " + decoratedlv.currentItem.text)
      }

      lv.currentIndex = 0
      lv.currentItem.text = "TEST"

      function getRoles(row = 0) {
        return tabview.itemAtCell(0, row).text.split(" ");
      }

      var roles = getRoles()
      if(roles.length != 3) {
        Julia.testfail("wrong column count: " + roles.length)
      }

      if(tablemodel.roles[0] != "a") {
        Julia.testfail("Bad role name for a")
      }
      if(tablemodel.roles[1] != "b") {
        Julia.testfail("Bad role name for b")
      }
      if(tablemodel.roles[2] != "c") {
        Julia.testfail("Bad role name for c")
      }

      Julia.removerole_b()
      /* if(tabview.columns != 2) { */
      /*   Julia.testfail("wrong column count after remove 1: " + tabview.columns) */
      /* } */
      /* if(tabview.getColumn(0).role != "a") { */
      /*   Julia.testfail("Bad role name for a after remove 1") */
      /* } */
      /* if(tabview.getColumn(1).role != "c") { */
      /*   Julia.testfail("Bad role name for c after remove 1") */
      /* } */
      /* Julia.removerole_c() */
      /* if(tabview.columns != 1) { */
      /*   Julia.testfail("wrong column count after remove: " + tabview.columns) */
      /* } */
      /* if(tabview.getColumn(0).role != "a") { */
      /*   Julia.testfail("Bad role name for a after remove 2") */
      /* } */

      /* Julia.setrole_a() */
      /* if(tabview.columns != 1) { */
      /*   Julia.testfail("wrong column count after setrole: " + tabview.columns) */
      /* } */
      /* if(tabview.getColumn(0).role != "abc") { */
      /*   Julia.testfail("Bad role name for abc after setrow") */
      /* } */

      // Qt.quit()
    }
  }
}
