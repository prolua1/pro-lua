import tkinter as tk


def click_btn(item):
    global expression
    expression = expression + str(item)
    input_text.set(expression)


def clear():
    global expression
    expression = ""
    input_text.set("")


def evaluate():
    global expression
    try:
        result = str(eval(expression))
        input_text.set(result)
        expression = result
    except:
        input_text.set("Lỗi")
        expression = ""



root = tk.Tk()
root.title("Máy Tính Đơn Giản")
root.geometry("300x400")
root.resizable(False, False)

expression = ""
input_text = tk.StringVar()


input_frame = tk.Frame(root, width=311, height=50, bd=0, highlightbackground="black", highlightcolor="black", highlightthickness=1)
input_frame.pack(side=tk.TOP)

input_field = tk.Entry(input_frame, textvariable=input_text, font=('arial', 18, 'bold'), width=21, bg="#eee", bd=0, justify=tk.RIGHT)
input_field.grid(row=0, column=0)
input_field.pack(ipady=10)


btns_frame = tk.Frame(root, width=300, height=350, bg="grey")
btns_frame.pack()


tk.Button(btns_frame, text="C", width=16, height=3, bd=0, bg="#eee", cursor="hand2", command=lambda: clear()).grid(row=0, column=0, columnspan=2, padx=1, pady=1)
tk.Button(btns_frame, text="/", width=7, height=3, bd=0, bg="#eee", cursor="hand2", command=lambda: click_btn("/")).grid(row=0, column=2, padx=1, pady=1)
tk.Button(btns_frame, text="*", width=7, height=3, bd=0, bg="#eee", cursor="hand2", command=lambda: click_btn("*")).grid(row=0, column=3, padx=1, pady=1)


tk.Button(btns_frame, text="7", width=7, height=3, bd=0, bg="#fff", cursor="hand2", command=lambda: click_btn(7)).grid(row=1, column=0, padx=1, pady=1)
tk.Button(btns_frame, text="8", width=7, height=3, bd=0, bg="#fff", cursor="hand2", command=lambda: click_btn(8)).grid(row=1, column=1, padx=1, pady=1)
tk.Button(btns_frame, text="9", width=7, height=3, bd=0, bg="#fff", cursor="hand2", command=lambda: click_btn(9)).grid(row=1, column=2, padx=1, pady=1)
tk.Button(btns_frame, text="-", width=7, height=3, bd=0, bg="#eee", cursor="hand2", command=lambda: click_btn("-")).grid(row=1, column=3, padx=1, pady=1)


tk.Button(btns_frame, text="4", width=7, height=3, bd=0, bg="#fff", cursor="hand2", command=lambda: click_btn(4)).grid(row=2, column=0, padx=1, pady=1)
tk.Button(btns_frame, text="5", width=7, height=3, bd=0, bg="#fff", cursor="hand2", command=lambda: click_btn(5)).grid(row=2, column=1, padx=1, pady=1)
tk.Button(btns_frame, text="6", width=7, height=3, bd=0, bg="#fff", cursor="hand2", command=lambda: click_btn(6)).grid(row=2, column=2, padx=1, pady=1)
tk.Button(btns_frame, text="+", width=7, height=3, bd=0, bg="#eee", cursor="hand2", command=lambda: click_btn("+")).grid(row=2, column=3, padx=1, pady=1)


tk.Button(btns_frame, text="1", width=7, height=3, bd=0, bg="#fff", cursor="hand2", command=lambda: click_btn(1)).grid(row=3, column=0, padx=1, pady=1)
tk.Button(btns_frame, text="2", width=7, height=3, bd=0, bg="#fff", cursor="hand2", command=lambda: click_btn(2)).grid(row=3, column=1, padx=1, pady=1)
tk.Button(btns_frame, text="3", width=7, height=3, bd=0, bg="#fff", cursor="hand2", command=lambda: click_btn(3)).grid(row=3, column=2, padx=1, pady=1)
tk.Button(btns_frame, text="=", width=7, height=3, bd=0, bg="#ff9933", cursor="hand2", command=lambda: evaluate()).grid(row=3, column=3, rowspan=2, padx=1, pady=1)


tk.Button(btns_frame, text="0", width=16, height=3, bd=0, bg="#fff", cursor="hand2", command=lambda: click_btn(0)).grid(row=4, column=0, columnspan=2, padx=1, pady=1)
tk.Button(btns_frame, text=".", width=7, height=3, bd=0, bg="#eee", cursor="hand2", command=lambda: click_btn(".")).grid(row=4, column=2, padx=1, pady=1)

root.mainloop()
