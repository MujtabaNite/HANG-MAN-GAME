# 🎮 HANGMAN GAME (x86 Assembly)

![Assembly](https://img.shields.io/badge/Language-x86%20Assembly-blue)
![Platform](https://img.shields.io/badge/Platform-DOS-orange)
![Graphics](https://img.shields.io/badge/Graphics-VGA%20Mode%2013h-red)

A sophisticated implementation of the classic Hangman Game built entirely in x86 Assembly language. This project showcases low-level system programming, custom graphics rendering, and efficient hardware interaction.

## 👤 Author
*   **Student Name:** Muhammad Mujtaba
*   **Roll Number:** 2023-Arid-3738
*   **Course:** Computer Organization and Assembly Language (COAL)
*   **Institution:** Barani Institute of Information Technology (BIIT)
*   **Semester:** BSCS-AI-4C (Spring 2025)

---

## 🚀 Features
*   **Graphical Interface**: Utilizes **VGA Mode 13h** (320x200, 256 colors) for a visual experience.
*   **Custom Sprites**: Hand-drawn 8x8 pixel bitmaps for the gallows, head, body, and limbs.
*   **Robust Game Logic**: 
    *   Dynamic word processing (handles spaces and multiple occurrences).
    *   Input validation (only A-Z allowed).
    *   Duplicate guess detection.
    *   Mistake tracking (up to 6 attempts).
*   **User Feedback**: Real-time status updates, including victory and game-over messages.
*   **Modular Codebase**: Highly structured procedures for memory efficiency and readability.

---

## 🛠️ Technical Specifications
*   **Video Memory**: Direct manipulation of segment `0A000h`.
*   **Keyboard Input**: Handled via DOS interrupts (`int 21h`).
*   **Assets**: Embedded 8x8 bitmap font and sprite table.
*   **Optimization**: Minimal memory footprint (~10KB) and register-level performance tuning.

---

## 📖 How to Run
To experience the game, you will need a DOS emulator like **DOSBox**.

1.  Download and install [DOSBox](https://www.dosbox.com/).
2.  Clone this repository:
    ```bash
    git clone https://github.com/MujtabaNite/HANG-MAN-GAME.git
    ```
3.  Mount the project folder in DOSBox:
    ```dos
    mount c C:\path\to\HANG-MAN-GAME\GAME
    c:
    main.exe
    ```

---

## 📄 Project Documentation
A comprehensive technical report is included in this repository: [HANG MAN GAME Report .pdf](./HANG%20MAN%20GAME%20Report%20.pdf). It covers:
*   System Architecture
*   Data Structures
*   Testing Strategies
*   Performance Optimizations

---

## 📜 License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
