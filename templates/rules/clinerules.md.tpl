# ⚖️ 系统铁律与 AI 行为紧箍咒 (.clinerules)

## 🚨 最高法律与安全边界 (Non-Negotiable Principles)
1. **三轨物理隔离铁律**：
   - 🎨 `product-assets/`（资产轨）：人类初始资产，AI **仅读（ReadOnly）**，严禁主动修改或高频扫描。
   - 🧠 `memory-bank/`（记忆轨）：AI 外部持久化大脑，AI **高频读写**，修改代码前必须先同步上下文。
   - 🛠️ `src/`（源码轨）：业务逻辑实现，AI **唯一的纯代码输出目标**。
2. **防只读内耗断路器**：
   - 单 Task 针对同一记忆文件（如 `techContext.md`）读取不得超过 **2 次**。
   - 严禁无路径限制的全局模糊搜索，只允许精准定位检索。
3. **强熔断机制 (Stop-Loss Protocol)**：
   - 连续 **3 次** 编译/类型检查报错，必须立即中断 Act 阶段，主动向人类求助并吐出归因日志。

---

## ⚙️ 当前项目绑定轮廓 (Active Profile)
- **形态/技术栈**: `__PROFILE_NAME__`
- **默认构建指令**: `__COMPILE_CMD__`
- **状态管理策略**: `__STATE_STRATEGY__`

---

## 🛑 唯一准入依赖白名单 (Whitelist)
`__META_WHITELIST__`

## ❌ 动态审计黑名单 (Blacklist)
`__META_BLACKLIST__`

---

## 🛠️ 工具链断路器规则 (Toolchain Router)
__TOOLCHAIN_ROUTER__