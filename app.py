from PyQt5 import QtWidgets, uic
from PyQt5.QtCore import QAbstractTableModel, Qt
import sys
from models import get_spec_by_code, SpecificationItem, Specification, SpecificationSection 

# class EditableTableModel(QAbstractTableModel):
#     def __init__(self, data):
#         super().__init__()
#         self._data = data
#         # return super().headerData(section, orientation, role)
    
#     def headerData(self, section: int, orientation: Qt.Orientation, role: int = ...):
#         if role == Qt.DisplayRole and orientation == Qt.Orientation.Horizontal:
#             return [
#                     "обозначение",
#                     "название",
#                     "кол-во",
#                     "примечание",
#                     "раздел спецификации",
#             ][section]
    
#     def rowCount(self, index):
#         # The length of the outer list.
#         return len(self._data)

#     def columnCount(self, index):
#         # The following takes the first sub-list, and returns
#         # the length (only works if all rows are an equal length)
#         return len(self._data[0])

#     def data(self, index, role=Qt.DisplayRole):
#         if index.isValid():
#             if role == Qt.DisplayRole or role == Qt.EditRole:
#                 value = self._data[index.row()][index.column()]
#                 return str(value)
            
#     def setData(self, index, value, role):
#         if role == Qt.EditRole:
#             self._data[index.row()][index.column()] = value
#             return True
#         return False

#     def flags(self, index):
#         return Qt.ItemIsSelectable | Qt.ItemIsEnabled | Qt.ItemIsEditable

# class Selector(QtWidgets.QComboBox):
#     def __init__(self,  *argv):
#         super().__init__(*argv)


class AddSpecificationItemWindow(QtWidgets.QMainWindow):
    def __init__(self, *argv):
        super().__init__(*argv)
        uic.loadUi('addspecificationitem.ui', self)
        self.pushButton_2.clicked.connect(lambda x: self.close())

class AddSpecificationWindow(QtWidgets.QMainWindow):
    def __init__(self, *argv):
        super().__init__(*argv)
        uic.loadUi('addspecification.ui', self)
        self.pushButton_3.clicked.connect(lambda x: self.close())
        
        # data = [
        #         [ 
        #             "обозначение",
        #             "название",
        #             "кол-во",
        #             "примечание",
        #             "раздел спецификации",
        #         ],
        #         [ 
        #             "обозначение",
        #             "название",
        #             "кол-во",
        #             "примечание",
        #             "раздел спецификации",
        #         ]
        # ]

        # self.model = EditableTableModel(data)
        # self.tableView.setModel(self.model)
        # # self.tableView.horizontalHeader([1,2,3,4])
        # self.tableView.resizeColumnsToContents()
        # for index, item in enumerate(data):
        #     box = QtWidgets.QComboBox()
        #     box.addItems([
        #         'One',
        #         'Two',
        #         'Three'
        #     ])
        #     self.tableView.setIndexWidget(self.model.index(index, len(item) - 1), box)

# Требуется:
# - отпечатать спецификацию по коду изделия в порядке возрастания кода раздела и позиции);
# - отпечатать алфавитный список стандартных изделий.
class AddUserWindow(QtWidgets.QMainWindow):
    def __init__(self, *argv):
        super().__init__(*argv)
        uic.loadUi('adduser.ui', self)
        self.pushButton.clicked.connect(lambda x: self.close())

class MainWindow(QtWidgets.QMainWindow):
    def __init__(self, *argv) -> None:
        super().__init__(*argv)
        uic.loadUi('main.ui', self)

class App(QtWidgets.QApplication):
    def __init__(self, *argv) -> None:
        super().__init__(*argv)

        self.setup_windows()
        self.setup_listeners()
        self.main_window.show()
        # self.add_spec_window.show()
        # self.add_spec_item_window.show()

    def setup_windows(self):
        self.main_window = MainWindow()
        self.add_user_window = AddUserWindow()
        self.add_spec_window = AddSpecificationWindow()
        self.add_spec_item_window = AddSpecificationItemWindow()

    def setup_listeners(self):
        self.main_window.add_user_action.triggered.connect(self.show_add_user_window)
        self.main_window.add_spec_action.triggered.connect(self.show_add_spec_window)
        self.add_spec_window.open_add_spec_item.clicked.connect(self.open_add_specification_item_window)
        
        self.add_user_window.add_user_button.clicked.connect(self.add_user)
        self.main_window.pushButton.clicked.connect(self.on_search_click)

    def open_add_specification_item_window(self):
        self.add_spec_item_window.show()

    def show_add_user_window(self):
        self.add_user_window.show()

    def show_add_spec_window(self):
        self.add_spec_window.show()
    
    def add_spec_item(self):
        pass

    def add_spec(self):
        pass

    def add_user(self):
        print('add_user')
        # TODO add to db
        self.fill_sidebar()
        self.add_user_window.close()
        pass

    def fill_sidebar(self):
        pass

    def on_search_click(self):
        code = self.main_window.lineEdit.text()
        
        emsg = QtWidgets.QMessageBox(self.main_window)
        emsg.setWindowTitle('Ошибка')
        
        if not code:    
            emsg.setText('Пустое значение')
            emsg.exec()
            return

        spec = get_spec_by_code(code)

        if not spec:    
            emsg.setText('Спецификации с таким обозначением не существует')
            emsg.exec()
            return
        
        if not len(spec):
            emsg.setText('Спецификация пуста')
            emsg.exec()
            return

        vals = [
            [
                spec_entry[6],
                spec_entry[7],
                spec_entry[8],
                spec_entry[9],
                spec_entry[10],
                spec_entry[11],
            ] for spec_entry in spec
        ]

        details = list(filter(lambda row: row[5] == 'Детали', sorted(vals, key=lambda row: row[4])))
        
        self.main_window.tableWidget.setRowCount(len(spec))
        self.main_window.tableWidget_2.setRowCount(len(details))
        self.main_window.tableWidget.setColumnCount(6)
        self.main_window.tableWidget_2.setColumnCount(6)

        for rowIndex, row in enumerate(vals):
            for colIndex, value in enumerate(row):
                # print(value, colIndex, rowIndex)
                self.main_window.tableWidget.setItem(rowIndex, colIndex, QtWidgets.QTableWidgetItem(str(value or 'Н/Д')))
        
        for rowIndex, row in enumerate(details):
            for colIndex, value in enumerate(row):
                # print(value, colIndex, rowIndex)
                self.main_window.tableWidget_2.setItem(rowIndex, colIndex, QtWidgets.QTableWidgetItem(str(value or 'Н/Д')))
        
        # right table filling

        # for rowIndex, spec_entry in enumerate(entries):
        #     values = [
        #         spec_entry.section.name,
        #         spec_entry.position,
        #         spec_entry.item_specification.code,
        #         spec_entry.item_specification.name,
        #         spec_entry.count,
        #         spec_entry.note,
        #     ]

        #     for colIndex, value in enumerate(values):
        #         print(value, colIndex, rowIndex)
        #         self.main_window.tableWidget.setItem(rowIndex, colIndex, QtWidgets.QTableWidgetItem(str(value or '-')))

        self.main_window.tableWidget.resizeColumnsToContents()
        self.main_window.tableWidget_2.resizeColumnsToContents()



    

app = App(sys.argv)
app.exec()

# app = QtWidgets.QApplication(sys.argv)

# window = 

# add_user_window = QtWidgets.QMainWindow()
# uic.loadUi('adduserui.ui', add_user_window)

# # print(window.menubar)
# def show_adduser():
#     add_user_window.show()


# def close_adduser():
#     add_user_window.close()

# add_user_window.pushButton.clicked.connect(close_adduser)
# window.action.triggered.connect(show_adduser)

# window.show()
# app.exec()
