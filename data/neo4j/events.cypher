// 第 10 節情境：9/15 颱風警報與外包停線。貼上後執行，再跑 queries.cypher 的情境查詢。
MATCH (l:Location {name:'基隆港'}) SET l.status = 'closed', l.closed_from = date('2026-09-16'), l.closed_to = date('2026-09-18');
MATCH (s:Supplier {name:'光澤表面處理'}) SET s.status = 'down', s.down_from = date('2026-09-15'), s.down_to = date('2026-09-19');
// 工作坊第一次情境注入：封港延長到 5 天
// MATCH (l:Location {name:'基隆港'}) SET l.closed_to = date('2026-09-20');
