# Я писал это за пару часов до сдачи экза, мне было не до кодстайла)

Полезно

```bash
pip -m venv venv
venv/Scrits/activate
pip list -v
pip install -r requirements.txt
deactivate
pip install PyQt5
pip list
winget install Qt.Designer
```

QtWidgets.QApplication

The core of every Qt Applications is the QApplication class. Every application
needs one — and only one — QApplication object to function. This object holds the
event loop of your application — the core loop which governs all user interaction
with the GUI.

**Each interaction with your application** — whether a press of a key, click of a mouse,
or mouse movement — **generates an event** which is placed on the **event queue**.

In the event loop, the queue is checked on each iteration and if a waiting event is
found, the event and control is passed to the specific event handler for the event.
The event handler deals with the event, then passes control back to the event loop
to wait for more events. There is only one running event loop per application.

Keys

-   QApplication holds the Qt event loop
-   One QApplication instance required
-   You application sits waiting in the event loop until an action is taken
-   There is only one event loop

```regexp
^\d+\s+
```

```py
from PyQt5.QtWidgets import *
from PyQt5.QtCore import *
from PyQt5.QtGui import *

# Only needed for access to command line arguments
import sys

# You need one (and only one) QApplication instance per application.
# Pass in sys.argv to allow command line arguments for your app.
# If you know you won't use command line arguments QApplication([]) works too.
app = QApplication(sys.argv)

# Start the event loop.
# The underscore is there because exec is a reserved word in Python and
# can’t be used as a function name. PyQt5 handles this by appending an
# underscore to the name used in the C++ library. You’ll also see it for .print_()
app.exec_()

# Your application won't reach here until you exit and the event
# loop has stopped.
```

[Qt namespace docs (Qt.something)](https://doc.qt.io/qt-5/qt.html)

## Events

```py
class CustomButton(Qbutton):

def event(self, e):
    e.accept() # dont propagate to parent
    e.ignore() #  propagate to parent
```
