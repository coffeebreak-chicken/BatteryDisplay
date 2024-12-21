import sys
import time
import psutil
import keyboard

class battery_disp:

    def task():
        def batterry():#バッテリ残量を表示
            dsk = psutil.disk_usage('/')
            btr = psutil.sensors_battery()
            btr = f"{btr.percent}%"
            return btr
        
        while True:#無限ループ
            print(batterry())
            time.sleep(60)#ざっくり60秒毎の間隔表示
            
            if keyboard.is_pressed('escape'):#「Escape」キーを押したら終了
                print("you pressed escape")
                sys.exit()
            if batterry() == '20%':
                print('バッテリ残量が少ないので終了します.')
                sys.exit()
            
    def __init__(self):#コンストラクタ的なもの。なにもしない
        pass
    task()#こっからスタート
    # print(batterry())