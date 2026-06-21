# ![COBOL Bootcamp Zero to Hero](./assets/bootcamp-header.svg)

[![License CC BY-NC-SA 4.0](https://img.shields.io/badge/license-CC%20BY--NC--SA%204.0-lightgrey.svg)](./LICENSE) [![14 Weeks](https://img.shields.io/badge/weeks-14-yellow.svg)](#) [![140 Hours](https://img.shields.io/badge/hours-140-orange.svg)](#) [![COBOL](https://img.shields.io/badge/COBOL-0D47A1?logo=data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyNCAyNCI+PHBhdGggZmlsbD0id2hpdGUiIGQ9Ik0yIDJoMjB2MjBIMnptMiAyaDE2djE2SDR6bTIgMmgxMnYxMkg2em0yIDJoOHY4SDh6Ii8+PC9zdmc+&logoColor=white)](#)

[![Versión en Español](https://img.shields.io/badge/%F0%9F%87%AA%F0%9F%87%B8_Espa%C3%B1ol-0969DA?style=for-the-badge&logoColor=white)](./README.md)

---

## 📋 Description

Intensive **14-week (~3.5 months)** bootcamp focused on mastering **COBOL** and enterprise systems development. Designed to take students from zero to **Junior COBOL Developer**, with emphasis on batch processing, file handling, embedded SQL, and mission-critical systems.

### 🎯 Objectives

Upon completion, students will be able to:

- ✅ Master COBOL structure and syntax (all four divisions)
- ✅ Design professional data layouts with PICTURE and USAGE
- ✅ Implement control flow with IF/EVALUATE/PERFORM
- ✅ Process sequential, indexed, and relative files
- ✅ Manipulate strings with STRING/UNSTRING/INSPECT
- ✅ Create and consume subprograms with CALL and LINKAGE SECTION
- ✅ Modularize code with COPYBOOKS
- ✅ Generate professional reports for batch systems
- ✅ Sort and merge large data volumes with SORT/MERGE
- ✅ Integrate COBOL with SQL databases (embedded)
- ✅ Write and execute JCL for batch jobs
- ✅ Understand CICS fundamentals for online transactions
- ✅ Build a complete banking system as final project

### 🏦 Why COBOL?

> **COBOL powers the financial world** — 95% of ATM transactions and 80% of financial transactions run through COBOL.

COBOL remains the dominant language in banking, insurance, government, and mainframes. This bootcamp uses **GnuCOBOL** (open source, standards-compatible) so anyone can learn without expensive mainframe access.

---

## 🗓️ Bootcamp Structure

| Stage | Weeks | Hours | Main Topics |
|-------|-------|-------|-------------|
| **Fundamentals** | 1-3 | 30h | Introduction, DATA DIVISION, PROCEDURE DIVISION |
| **Processing** | 4-7 | 40h | Sequential files, indexed files, tables, strings |
| **Modularization** | 8-9 | 20h | Subprograms, COPYBOOKS, reuse |
| **Batch** | 10-12 | 30h | Reports, SORT/MERGE, embedded SQL |
| **Production** | 13-14 | 20h | CICS, final project |

**Total: 14 weeks** | **140 hours** (10h/week)

> ⚠️ **Flexible duration**: Number of weeks depends on achieving learning objectives. Resources and exercises adjust to group needs, not a predetermined fixed count.

---

## 📆 Weekly Detail

| Wk | Topic | Main Objective |
|----|-------|---------------|
| 01 | COBOL Introduction | History, GnuCOBOL, 4-division structure, Hello World |
| 02 | DATA DIVISION | PICTURE, USAGE, VALUE, data types, 01-49 |
| 03 | PROCEDURE DIVISION | MOVE, COMPUTE, IF/EVALUATE, basic PERFORM |
| 04 | Sequential Files | OPEN, READ, WRITE, CLOSE, FILE STATUS |
| 05 | Indexed Files | INDEXED, ACCESS MODE, START, DELETE, REWRITE |
| 06 | Tables and Arrays | OCCURS, INDEXED BY, SEARCH, SEARCH ALL |
| 07 | String Manipulation | STRING, UNSTRING, INSPECT, reference/modification |
| 08 | Subprograms & COPYBOOKS | CALL, LINKAGE SECTION, parameters, COPY |
| 09 | Professional Reports | WRITE BEFORE/AFTER, page control, headers |
| 10 | SORT and MERGE | File sorting, merging, temporary files |
| 11 | Embedded SQL | EXEC SQL, cursors, ACID transactions |
| 12 | JCL Fundamentals | JOB, EXEC, DD, cataloged procedures |
| 13 | CICS Fundamentals | Transactions, MAPS, pseudo-conversation |
| 14 | Final Project | Banking system: batch + online + SQL |

---

## 🚀 Quick Start

### Prerequisites

- **Docker** and **Docker Compose** installed
- **Git** for version control
- **VS Code** (recommended) with COBOL extension

```bash
git clone https://github.com/ergrato-dev/bc-cobol.git
cd bc-cobol
docker compose up --build -d
docker compose exec cobol bash
cd bootcamp/week-01-introduccion-cobol
cobc -x -free hello.cbl
./hello
```

> 📖 Full Docker guide: [docs/docker-setup.md](docs/docker-setup.md)

---

## 📞 Support

- 💬 **Discussions**: [GitHub Discussions](https://github.com/ergrato-dev/bc-cobol/discussions)
- 🐛 **Issues**: [GitHub Issues](https://github.com/ergrato-dev/bc-cobol/issues)

---

## ⚠️ Disclaimer

This repository is an **educational resource** created for learning purposes. By using it, you agree to the following terms:

- **Educational use only**: Content, code examples, and projects are designed exclusively for teaching and learning.
- **No warranties**: Material is provided **"as is"**, without warranties of any kind.
- **Production code**: Examples are illustrative. Review security, performance, and context before production use.
- **Liability limitation**: Authors and contributors are not responsible for data loss, direct or indirect damages resulting from use of this material.

---

## 📄 License

This project is licensed under **[CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/)**.

**You may:** share and adapt material, create educational forks.
**You may not:** use this material for commercial purposes.
**You must:** give appropriate credit and distribute adaptations under the same license.

---

## 🏆 Acknowledgments

- [GnuCOBOL](https://gnucobol.sourceforge.io/) - Open source COBOL compiler
- [COBOL Programming Course](https://github.com/openmainframeproject/cobol-programming-course) - Open Mainframe Project
- [IBM COBOL Documentation](https://www.ibm.com/docs/en/cobol-zos) - Official reference
- COBOL Community - For keeping the language alive

---

**🎓 Bootcamp COBOL - Zero to Hero**
*From zero to junior COBOL developer*

[Start Week 1](bootcamp/week-01-introduccion-cobol) · [Documentation](docs) · [Report Issue](https://github.com/ergrato-dev/bc-cobol/issues)
