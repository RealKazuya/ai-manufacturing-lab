# AI賦能製造：從工廠數據到AI決策　課後延伸包

經濟部產業智慧化課程〈AI賦能製造：從工廠數據到AI決策〉的公開教材。講者張季倫。
**所有資料、公司、人物、機台、手冊、工單都是教學用虛構**（虛構公司：恆準精密工業）。

- 課程入口：https://realkazuya.github.io/ai-manufacturing-lab/
- 投影片：`slides/`（reveal.js）

## 筆記本（點連結在 Colab 開啟）

| 節次 | 筆記本 | 內容 |
|---|---|---|
| 第 1 節 | [N0_mqtt_live.ipynb](https://colab.research.google.com/github/RealKazuya/ai-manufacturing-lab/blob/main/notebooks/N0_mqtt_live.ipynb) | MQTT 即時資料示範（講師用，公開伺服器任何人可讀） |
| 第 2 節 | [N1_iot_health.ipynb](https://colab.research.google.com/github/RealKazuya/ai-manufacturing-lab/blob/main/notebooks/N1_iot_health.ipynb) | 資料健檢與稼動率 |
| 第 4 節 | [N2_aoi_labeling.ipynb](https://colab.research.google.com/github/RealKazuya/ai-manufacturing-lab/blob/main/notebooks/N2_aoi_labeling.ipynb) | 標註評分與資料增強 |
| 第 5 節 | [N3_predictive_maintenance.ipynb](https://colab.research.google.com/github/RealKazuya/ai-manufacturing-lab/blob/main/notebooks/N3_predictive_maintenance.ipynb) | 預測性維護：門檻、成本與切分 |
| 第 6 節 | [N4_sales_forecast.ipynb](https://colab.research.google.com/github/RealKazuya/ai-manufacturing-lab/blob/main/notebooks/N4_sales_forecast.ipynb) | 銷售預測：基準、LightGBM、Chronos-Bolt |
| 第 8 節 | [N5_rag_retrieval.ipynb](https://colab.research.google.com/github/RealKazuya/ai-manufacturing-lab/blob/main/notebooks/N5_rag_retrieval.ipynb) | RAG 檢索與黃金問題評估 |

由上往下逐格執行（Shift＋Enter）。要改的參數都在「參數」那一格。資料會自動從本 repo 讀取，不必上傳檔案。

## Neo4j

1. 在 Neo4j Aura 建立免費執行個體，**密碼只顯示一次，請當場下載帳密檔**。
2. 在 Query 貼上 `data/neo4j/build_graph.cypher` 執行。
3. 試 `data/neo4j/queries.cypher`；第 10 節的颱風與停線情境先執行 `data/neo4j/events.cypher`。

## 資料夾

| 資料夾 | 內容 |
|---|---|
| `data/iot/` | VMC-01～03 在 2026-09-10 的 10 秒感測資料（含 6 個資料問題） |
| `data/aoi/` | 程式繪製的外殼表面灰階影像與 YOLO 真值（類別：S 刮傷、D 壓傷、C 振紋、B 毛邊、U 看不清楚） |
| `data/pdm/` | 6 台 VMC 每日特徵（2024-01～2026-09）與維修紀錄 |
| `data/sales/` | 月訂單（2022-09～2026-08，客戶 × 料號） |
| `data/rag/` | 虛構維護手冊（md、pdf）、約 300 筆維修工單、20 筆髒工單、規格表、黃金問題參考集 |
| `data/neo4j/` | 供應鏈建圖、情境與查詢腳本 |
| `data/workshop/` | 戰情室桌上推演的情報資料 |

## 授權與第三方

本 repo 的教材與虛構資料可自由用於學習。筆記本使用的套件依其各自授權（例如 albumentations 2.0.8 為 MIT；Chronos-Bolt 為 Apache-2.0；multilingual-e5-small 為 MIT）。公開 MQTT 測試伺服器任何人都能讀取，只放虛構資料。
