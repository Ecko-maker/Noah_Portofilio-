# 📂 erd

MySQL Workbench Entity Relationship Diagram (ERD) files.

---

## Files

| File | Description |
|------|-------------|
| `Capstone01_Noah_Asgodom.mwb` | Final ERD — complete Star Schema with all 7 tables |
| `1EER_Diagram.mwb.bak` | Backup of the initial ERD (V1 design) |

---

## How to Open

1. Install [MySQL Workbench](https://dev.mysql.com/downloads/workbench/) (free)
2. Open MySQL Workbench
3. Go to **File → Open Model**
4. Select `Capstone01_Noah_Asgodom.mwb`

---

## Schema Overview

The ERD follows a **Star Schema** design:

```
                    ┌──────────┐
                    │ Authors  │
                    └────┬─────┘
                         │ 1:N
┌──────────┐       ┌─────▼────┐       ┌──────────┐
│  Genres  ├──1:N──►   Books  ├──1:N──►  Loans   ◄──1:N──┐
└──────────┘       └──────────┘       └────┬─────┘        │
                                           │ 1:1      ┌───┴──────┐
                                      ┌────▼─────┐    │ Members  │
                                      │  Fines   │    └──────────┘
                                      └──────────┘
                                           │
                                      ┌────┴─────┐
                                      │  Staff   │
                                      └──────────┘
```

### Table Relationships

| Relationship | Cardinality | Description |
|---|---|---|
| Authors → Books | 1:N | One author can write many books |
| Genres → Books | 1:N | One genre can classify many books |
| Members → Loans | 1:N | One member can have many loans |
| Books → Loans | 1:N | One book can appear in many loans |
| Staff → Loans | 1:N | One staff member can process many loans |
| Loans → Fines | 1:1 | Each loan can have at most one fine record |

### Normalisation

The schema is normalised to **Third Normal Form (3NF)**:
- No partial dependencies (2NF satisfied)
- No transitive dependencies (3NF satisfied)
- All non-key attributes depend only on the primary key of their table
