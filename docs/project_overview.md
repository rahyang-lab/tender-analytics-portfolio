# 📚 Master Guide — Tender Analytics Portfolio Project

**Untuk:** Abdurrahman Rahyang
**Tujuan:** Membangun portfolio data analyst pertama dalam 4-5 minggu
**Time commitment:** 2-3 jam/minggu

---

## 📁 File-File di Folder Ini

Folder ini berisi 6 file yang harus dibaca **berurutan**:

| # | File | Isi | Kapan Dipakai |
|---|------|-----|---------------|
| 0 | `00_README_Master_Guide.md` | File ini — overview & navigation | Baca pertama kali |
| 1 | `01_Tender_Dataset_RAW.csv` | 104 baris data tender sintetis siap pakai | Minggu 1 |
| 2 | `02_Analysis_Workflow_Guide.md` | 8 analisis step-by-step + formula Excel | Minggu 1-3 |
| 3 | `03_Dashboard_Design_Template.md` | Layout & color scheme dashboard | Minggu 3-4 |
| 4 | `04_Portfolio_Writeup_Template.md` | Template GitHub README + Notion page | Minggu 4 |
| 5 | `05_Launch_Pitch_Strategy.md` | Strategi launch & pitch ke recruiter | Minggu 5 |

---

## 🗓️ Roadmap 5 Minggu

### MINGGU 1: Setup & Initial Analysis

**Time: 2-3 jam**

✅ Day 1 (30 menit):
- Baca `00_README_Master_Guide.md` (file ini)
- Skim cepat semua file untuk overview
- Setup folder project di komputer

✅ Day 2-3 (1 jam):
- Import `01_Tender_Dataset_RAW.csv` ke Excel
- Convert ke Excel Table (Ctrl+T)
- Buat 5 sheet: RAW_Data, Calculations, Pivot_Analyses, Dashboard, Insights
- Save sebagai `Tender_Analysis_Master.xlsx`

✅ Day 5-7 (1-1.5 jam):
- Kerjakan **Analisis #1** (KPI Cards) di sheet Calculations
- Kerjakan **Analisis #2** (Win Rate by Industry) - bikin pivot table pertama

**Output Minggu 1:** File Excel dengan 2 analisis selesai + structure siap

---

### MINGGU 2: Deep Analysis Phase 1

**Time: 2-3 jam**

✅ Day 1-3 (1.5 jam):
- Kerjakan **Analisis #3** (Equipment Category Performance)
- Kerjakan **Analisis #4** (Loss Reason Analysis)
- Tulis 1-2 insight per analisis di sheet Insights

✅ Day 5-7 (1-1.5 jam):
- Kerjakan **Analisis #5** (Quarterly Trend)
- Bikin combo chart (line + bar)
- Add trendline

**Output Minggu 2:** 5 dari 8 analisis selesai

---

### MINGGU 3: Deep Analysis Phase 2 + Dashboard Start

**Time: 2-3 jam**

✅ Day 1-3 (1 jam):
- Kerjakan **Analisis #6** (Regional Performance)
- Kerjakan **Analisis #7** (Pricing Strategy)
- Kerjakan **Analisis #8** (Decision Maker Pattern)

✅ Day 5-7 (1.5-2 jam):
- Open `03_Dashboard_Design_Template.md`
- Setup dashboard sheet dengan layout 5-column KPI
- Buat 4 KPI cards menggunakan shapes
- Apply color scheme (Navy + Amber Gold + Forest Green)

**Output Minggu 3:** Semua 8 analisis selesai + skeleton dashboard

---

### MINGGU 4: Dashboard Polish + Portfolio Writeup

**Time: 3-4 jam**

✅ Day 1-3 (1.5-2 jam):
- Pindah 4 chart utama ke Dashboard sheet
- Add slicers untuk interactivity
- Apply conditional formatting
- Polish typography & spacing
- Print preview test (A4 landscape)
- Export ke PDF
- Screenshot ke PNG (1920x1080)

✅ Day 5-7 (1.5-2 jam):
- Open `04_Portfolio_Writeup_Template.md`
- Setup GitHub account (sudah punya katanya — gunakan existing)
- Buat repository: `tender-analytics-portfolio`
- Upload Excel file, dataset CSV, dashboard PNG
- Customize README.md dari template (siap copy-paste)
- Setup Notion page (sudah punya katanya)
- Make Notion page public
- Pin portfolio link di LinkedIn Featured section

**Output Minggu 4:** Portfolio sudah live di GitHub + Notion!

---

### MINGGU 5: Launch & Engagement

**Time: 2-3 jam (dibagi banyak slot kecil)**

✅ Day -7 to -1 (Pre-launch teasing):
- Open `05_Launch_Pitch_Strategy.md`
- Schedule 2 teaser posts (T-7 dan T-3)

✅ Day 0 (LAUNCH DAY) — Senin atau Selasa pagi:
- Publish Big Reveal post di 09:00 WIB
- Stay online 2 jam untuk respond komen
- Update LinkedIn Featured dengan post

✅ Day 1-7 (Sustained engagement):
- 1 post baru per 2 hari (Behind the Methodology, Lessons, Sugar Deep Dive)
- Connect 5 recruiter/hiring manager per hari
- Reply setiap komen dalam 2 jam

✅ Day 7-14 (Direct pitch phase):
- Send 10 connection requests/hari ke recruiter
- Follow-up message ke connection yang accept
- Setup Upwork profile (gunakan template di file 05)

**Output Minggu 5:** Network grew 200+, 5+ DM dari recruiter, 1-3 freelance inquiry

---

## 🎯 Success Metrics (Target di Akhir 5 Minggu)

| Metric | Baseline (Start) | Target (Week 5) |
|--------|------------------|-----------------|
| LinkedIn connections | 51 | **300+** |
| LinkedIn followers | 54 | **400+** |
| Portfolio views (Notion + GitHub) | 0 | **150+** |
| Profile views/week | ~30 | **800+** |
| DMs from recruiters | 0 | **5+** |
| Job interviews scheduled | 0 | **1-2** |
| Freelance inquiries | 0 | **2-3** |

---

## 🔧 Tools yang Dibutuhkan (Semua Gratis)

### Required:
- ✅ **Microsoft Excel** (atau LibreOffice gratis)
- ✅ **GitHub account** (sudah punya)
- ✅ **Notion account** (sudah punya)
- ✅ **LinkedIn account** (sudah punya, sudah di-update)

### Recommended:
- 📱 **Canva** (gratis) — untuk banner LinkedIn & post images
- 📱 **GitHub Desktop** (optional) — easier than command line
- 📱 **Loom** (gratis) — untuk video tour portfolio (advanced)

### Untuk Phase 2-3 (bulan 2-3, tidak urgent sekarang):
- 🔮 **Power BI Desktop** (gratis dari Microsoft)
- 🔮 **DB Browser for SQLite** (gratis) — untuk SQL practice

---

## ❓ FAQ (Pertanyaan yang Mungkin Muncul)

### Q1: "Saya stuck di Analisis #4 — pivot table-nya tidak menampilkan apa yang diharapkan."

**A:** Biasanya karena:
- Excel Table belum di-rename jadi `tblTender` → ubah di Table Design tab
- Filter masih aktif dari analisis sebelumnya → klik Clear Filter di header
- Data type column salah (Tender_Value sebagai text, bukan number) → pilih kolom → Format Cells → Number

### Q2: "Dataset 104 baris — apakah cukup untuk portfolio?"

**A:** **Ya, sangat cukup.** Bahkan banyak data analyst portfolio menggunakan dataset 50-100 baris. Yang penting bukan jumlah data, tapi:
- Quality of insights (lebih bernilai)
- Storytelling
- Methodology yang clear

Recruiter ingin melihat **how you think**, bukan dataset terbesar.

### Q3: "Saya boleh ubah data sintetis ini?"

**A:** **100% boleh!** Bahkan disarankan:
- Tambah industri lain yang Anda kenal
- Ubah equipment names sesuai pengalaman
- Tambah baris baru jika ingin
- Ubah angka untuk lebih realistic

Disclaimer di README sudah saya tulis: "synthetic data inspired by general industry patterns". Aman.

### Q4: "Berapa lama sampai dapat job offer setelah portfolio live?"

**A:** Realistic timeline:
- **Bulan 1-2:** Network growing, 1-2 interviews
- **Bulan 3-4:** First serious offers (junior data analyst, business analyst)
- **Bulan 6+:** Mid-level roles dengan SQL & Power BI cert

Freelance projects bisa lebih cepat (1-2 bulan untuk first project).

### Q5: "Saya tidak yakin tentang storytelling di portfolio — seberapa personal harus?"

**A:** **Mix yang ideal (sesuai pilihan Anda Storyline E):**
- 70% professional (tools, methodology, insights)
- 20% niche expertise (sugar industry positioning)
- 10% personal journey (transition story)

Ini formula yang membuat Anda terasa **expert + relatable**, bukan generic atau terlalu emosional.

### Q6: "Bahasa Inggris saya tidak sempurna. Apakah masalah?"

**A:** **Tidak masalah sama sekali.** Yang penting:
- Clear & understandable (lebih baik simple than fancy salah)
- Pakai grammar checker (Grammarly free version sudah cukup)
- Ada versi Indonesian summary untuk audience lokal

Recruiter Indonesian + Asia Tenggara sangat OK dengan English yang functional.

---

## 🚨 Common Pitfalls to Avoid

### 1. ❌ Perfectionism Paralysis
"Mau update lagi sebelum publish..."
**Solution:** Ship at 80%. Iterate publicly. Better posted-imperfect than perfect-but-private.

### 2. ❌ Underselling Yourself
"Saya cuma pakai Excel, tidak istimewa."
**Solution:** **Excel ADVANCED (yang Anda kuasai) lebih bernilai dari Python BASIC.** Position dari kekuatan, bukan kekurangan.

### 3. ❌ Generic Hashtags
Pakai #data #analytics #career — terlalu broad
**Solution:** Mix general + niche: #SugarIndustry #B2BAnalytics #ApplicantEngineer

### 4. ❌ One-and-Done Posting
Post launch lalu hilang.
**Solution:** Plan 4-6 follow-up posts untuk maximize launch momentum.

### 5. ❌ Ignoring DMs
"Ini probably spam, skip aja."
**Solution:** **Reply to ALL DMs in 24 hours.** Bahkan yang seems spam — bisa jadi recruiter dari company yang Anda tidak kenal.

---

## 📞 Bantuan & Support

Kalau Anda stuck di langkah manapun:

1. **Re-read** file yang relevan (sebagian besar pertanyaan sudah ada jawabannya)
2. **Cek FAQ** di file ini
3. **Tanya saya kapan saja** di sesi berikutnya — saya save context Anda di memory

### Hal yang akan saya bantu di sesi berikutnya:

- ✅ Review file Excel Anda (jika ada error)
- ✅ Customize content posts kalau ada update progress
- ✅ Setup Phase 2 (Power BI) saat Anda sudah ready
- ✅ Bantuan apply ke specific job posting
- ✅ Review portfolio sebelum publish
- ✅ Debug LinkedIn engagement issues

---

## 🎯 NEXT IMMEDIATE ACTIONS (untuk dikerjakan minggu ini)

**Hari ini (30 menit):**
1. ✅ Baca file ini sampai selesai
2. ✅ Buka `01_Tender_Dataset_RAW.csv` di Excel
3. ✅ Save As `Tender_Analysis_Master.xlsx`
4. ✅ Convert range ke Excel Table (Ctrl+T)

**Besok (1 jam):**
1. ✅ Buka `02_Analysis_Workflow_Guide.md`
2. ✅ Kerjakan Analisis #1 (KPI Cards) di sheet Calculations
3. ✅ Test 2-3 formula sebelum lanjut

**Akhir minggu (1-1.5 jam):**
1. ✅ Selesaikan Analisis #2 (Win Rate by Industry)
2. ✅ Buat pivot table pertama
3. ✅ Tulis 1 insight di sheet Insights

---

## 🏁 Vision Akhir (Setelah 5 Minggu)

Bayangkan ini di akhir minggu ke-5:

✅ Anda punya **portfolio impresif** yang publik di GitHub & Notion
✅ Headline LinkedIn Anda **menarik recruiter** specifically
✅ Network Anda **300+ koneksi** dengan recruiter & data analyst
✅ Sudah ada **1-2 wawancara** dijadwalkan
✅ Sudah ada **2-3 freelance inquiry**
✅ Dikenal sebagai "**Sugar Industry Data Specialist**" yang unique
✅ HackerRank SQL Basic Cert sudah didapat (paralel dengan portfolio)
✅ Confidence Anda jauh lebih tinggi karena ada **bukti konkret** keahlian

**Ini achievable. Step by step. Anda bisa.** 🚀

---

**Selamat memulai! Kalau sudah selesai Minggu 1, kabari saya — saya akan check progress dan adjust strategy berikutnya.**
