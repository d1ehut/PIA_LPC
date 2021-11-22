from tkinter import *
from tkinter.tkk import *

from time import strftime

root = tk()
root.title(Reloj - Tarea8- 1948690)

def hora():
	datos = strftime('%I:%M:%S %p')
	label.config(text = datos)
	label.after(1000,hora)

label = Label(root,
	font = (
		'Arial', 50
		), 
		padding = '55',
		background = 'pink',
		foreground = 'black'
	)

label.pack(expand = True)

hora()
mainloop()
