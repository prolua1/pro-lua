#include <iostream>

using namespace std;

int main() {
    int luaChon;
    double so1, so2;

    do {
        cout << "\n--- MAY TINH DON GIAN (C++) ---\n";
        cout << "1. Cong (+)\n";
        cout << "2. Tru (-)\n";
        cout << "3. Nhan (*)\n";
        cout << "4. Chia (/)\n";
        cout << "0. Thoat\n";
        cout << "Nhap lua chon cua ban (0-4): ";
        cin >> luaChon;

        if (luaChon == 0) {
            cout << "Cam on ban da su dung!\n";
            break;
        }

        if (luaChon >= 1 && luaChon <= 4) {
            cout << "Nhap so thu nhat: ";
            cin >> so1;
            cout << "Nhap so thu hai: ";
            cin >> so2;

            switch (luaChon) {
                case 1:
                    cout << "Ket qua: " << so1 << " + " << so2 << " = " << so1 + so2 << "\n";
                    break;
                case 2:
                    cout << "Ket qua: " << so1 << " - " << so2 << " = " << so1 - so2 << "\n";
                    break;
                case 3:
                    cout << "Ket qua: " << so1 << " * " << so2 << " = " << so1 * so2 << "\n";
                    break;
                case 4:
                    if (so2 == 0) {
                        cout << "Loi: Khong the chia cho 0!\n";
                    } else {
                        cout << "Ket qua: " << so1 << " / " << so2 << " = " << so1 / so2 << "\n";
                    }
                    break;
            }
        } else {
            cout << "Lua chon khong hop le, vui long chon lai!\n";
        }

    } while (luaChon != 0);

    return 0;
}
