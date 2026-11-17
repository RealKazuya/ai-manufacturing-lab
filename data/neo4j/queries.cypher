// ── 實作 9b：把每條翻成一句中文問題 ──
// 1
MATCH (s:Supplier {name:'光澤表面處理'})-[:PROCESSES]->(p:Product)
RETURN p.code;
// 2
MATCH (c:Customer)-[:PLACED]->(o:Order)-[:FOR]->(p:Product {code:'AH-2101'})
WHERE o.status = '未出貨'
RETURN c.name, count(o) AS 訂單數;
// 3
MATCH (p:Product)-[:MADE_ON]->(m:Machine)
WHERE m.id <> 'VMC-02'
RETURN p.code, collect(m.id) AS 可用機台;
// 4
MATCH path = (:Location {name:'名古屋港'})-[:ROUTE*1..3]->(:Location {name:'恆準台中廠'})
RETURN path;
// 5
MATCH (s:Supplier {name:'光澤表面處理'})-[:PROCESSES]->(p:Product)<-[:FOR]-(o:Order)<-[:PLACED]-(c:Customer)
WHERE o.status = '未出貨'
RETURN c.name, o.id, o.due ORDER BY o.due;

// ── 第 10 節情境查詢（先執行 events.cypher）──
// A 光澤停線 9/15～9/19，陽極交期 7 天：交期 9/16～9/26 的未出貨訂單受影響
MATCH (s:Supplier {status:'down'})-[:PROCESSES]->(p:Product)<-[:FOR]-(o:Order)<-[:PLACED]-(c:Customer)
WHERE o.status = '未出貨' AND o.due >= date('2026-09-16') AND o.due <= date('2026-09-26')
RETURN c.name AS 客戶, count(DISTINCT o) AS 受影響訂單 ORDER BY 受影響訂單 DESC;
// B 替代陽極廠：有能力、在營運、看產能與 Northbridge 核准
MATCH (v:Supplier {process:'陽極', status:'open'})
RETURN v.name, v.monthly_capacity, v.nb_approved, v.lead_days;
// C 軸承替代路線：排除已關閉的地點，依天數與運費排序
MATCH path = (:Location {name:'名古屋港'})-[:ROUTE*1..3]->(:Location {name:'恆準台中廠'})
WHERE all(n IN nodes(path) WHERE n.status <> 'closed')
RETURN [n IN nodes(path) | n.name] AS 路線,
       reduce(d = 0.0, r IN relationships(path) | d + r.days) AS 天數,
       reduce(c = 0.0, r IN relationships(path) | c + r.cost) AS 運費萬元
ORDER BY 天數;
MATCH path = (:Location {name:'中部國際機場'})-[:ROUTE*1..3]->(:Location {name:'恆準台中廠'})
WHERE all(n IN nodes(path) WHERE n.status <> 'closed')
RETURN [n IN nodes(path) | n.name] AS 路線,
       reduce(d = 0.0, r IN relationships(path) | d + r.days) AS 天數,
       reduce(c = 0.0, r IN relationships(path) | c + r.cost) AS 運費萬元;
// D 第二層影響：材料供應商的出貨也經過關閉的港口
MATCH (l:Location {status:'closed'})<-[:SHIPS_VIA]-(s:Supplier)-[:SUPPLIES]->(m:Material)<-[:USES]-(p:Product)
RETURN s.name, m.name, collect(p.code) AS 受影響產品;

// ── 實作 10b 的錯誤示範：沒有排除已關閉的路線，基隆港排第一 ──
MATCH path = (:Location {name:'名古屋港'})-[:ROUTE*1..3]->(:Location {name:'恆準台中廠'})
RETURN [n IN nodes(path) | n.name] AS 路線, reduce(d = 0.0, r IN relationships(path) | d + r.days) AS 天數
ORDER BY 天數;
