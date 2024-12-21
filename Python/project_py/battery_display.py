import tkinter as tk
from tkinter import ttk

import psutil
import sys
import keyboard

###
root = tk.Tk()
# root.geometry("240x50")
root.geometry("100x50+0+0")
root.title(u"バッテリ残量")
###

#バッテリ残量を文字列に格納（関数）
def battery():    
    btr = psutil.sensors_battery()
    btr = f"{btr.percent}%"
    return btr

#グルグル（バッテリ残量をラベルに貼りつつグルグル）
def update():
    label2.configure(text=battery())
    label.after(6000, update)

def key_press(event):
    print('input: ' + event.keysym)
    if event.keysym=="Escape":
        sys.exit()

#ラベル"現在の残量
label = tk.Label(text=u'現在の残量')
label.pack()

#ラベル2"実際の残量"
label2 = tk.Label(text=battery())
label2.pack()

#グルグルのスタート地点
label2.after(6000, update)

#キー入力連携
root.bind("<KeyPress>",key_press)

#常に最前面
root.attributes("-topmost", True)

#透過（数字1で表示。0で透明）
root.attributes("-alpha",0.8)

###
root.mainloop()
###