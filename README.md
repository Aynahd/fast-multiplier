# ⚔️ Ye Olde Systolic Array for Matrix Multiplication ⚔️  
*A Tale of Verilog and Valor*

## 📜 Preamble  
In an age most venerable, when numbers didst abound and multiplications were many, a champion arose: the **Systolic Array** — a noble architecture forged in silicon, wrought with precision, to multiply matrices as swift as a falcon's dive.

This be a project of sacred craftsmanship, wherein arrays of tiles, each a **processing element**, do march in rhythmic harmony to compute the product of two 4x4 matrices, as foretold in the scrolls of digital design.

---

## 🏰 Structure of the Realm

- `processing_element.sv` – The valiant heart of computation. Each one doth accept operands, multiply them with might, and pass the torch onward.
  
- `tile8x8.sv` – Though ours be a 4x4 domain, this mighty tile can span wider lands. A grid where elements doth commune in rows and columns to fulfill their destiny.

- `systolic_array.sv` – The grand hall, where the lords of logic assemble. It orchestrates the array’s pulse and dispatches operands unto their rightful fates.

- `hPE.sv` – A helper of humble stature but noble purpose, lending aid where needed in the arena of computation.

---

## 🧮 The Ritual of Multiplication

Thou shall:
1. Provide to the array two 4x4 matrices — one for the **X realm** (inputs marching east), and one for the **W realm** (weights riding south).
2. Invoke the pulse of the clock — the **beat of battle**.
3. Watch as the **Y outputs** emerge, each the sum of noble products, built line-by-line through honor and propagation.

---

## 🛠️ To Summon the Array

Thy tools of choice should include:

- **Vivado**, **ModelSim**, or other simulators of the land of Verilog.
- **Git**, the scrollkeeper, to maintain the record of all changes.
- A steadfast **terminal**, for issuing sacred commands.

To enlist the code into thy service:
```bash
git clone https://github.com/thy-honour/matrix-mult.git
cd matrix-mult
