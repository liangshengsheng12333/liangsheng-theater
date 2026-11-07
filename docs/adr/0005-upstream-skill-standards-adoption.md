# ADR 0005: 严格继承与套用女娲 (Nuwa) 及仓颉 (Cangjie) 上游蒸馏标准

## 状态
已采纳 (Accepted) - 2026-10-09

## 背景与上下文
第二幕的核心是书籍与人物的认知蒸馏。为了确保蒸馏深度不是泛泛的 AI 摘要或表面角色扮演，必须严格继承并套用业界已被验证的成熟开源上游 Skill 体系：
- 蒸馏书：`kangarooking/cangjie-skill`
- 蒸馏人：`alchaincyf/nuwa-skill`

## 决策

1. **直接套用女娲体系 (`alchaincyf/nuwa-skill`) 作为人物蒸馏核心规范**：
   - **六维并行调研架构 (6D Research)**：代表作、长对话/访谈、外界评价、决策案例库、生平时间线与争议事件。
   - **产出结构**：3~7 个核心心智模型 (Mental Models)、5~10 条决策启发式 (Decision Heuristics)、专属表达 DNA (Expression DNA)。
   - **三层保真度测试 (Three-layer Test)**：已知历史场景回测、边缘极端压力测试、风格一致性测试。
2. **直接套用仓颉体系 (`kangarooking/cangjie-skill`) 作为书籍蒸馏核心规范**：
   - **RIA-TV++ 完整流水线**：
     - R (Reading)：原始文本解构与深度长文抽取；
     - I (Interpretation)：底层逻辑架构重塑；
     - A (Appropriation)：实际业务应用场景匹配；
     - TV (Triple Verification)：跨领域佐证、预测力检验、非显而易见性；
     - ++ (Agent Execution)：封装为包含 Triggers、Checklists、执行 SOP 的标准 Agent 指令。
3. **输出物兼容性**：
   - 蒸馏出的产物文件直接遵循标准 `SKILL.md` 规范，完全兼容女娲和仓颉的下游生态，支持脱离歌剧院独立安装或导出到全局 `~/.gemini/config/skills/`。

## 影响与后果
- **正面影响**：避免了重复造轮子；保证了人物具有深层灵魂与认知操作系统，书籍具有严格的方法论与执行约束，两者的结合达到了真正的工业级水准。
