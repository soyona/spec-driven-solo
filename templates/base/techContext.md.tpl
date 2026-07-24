# ⚙️ 技术依赖与运行约束 (techContext.md)

## ⚖️ 架构师审查状态 (Arch Review)
- **当前状态**: APPROVED
- **构建指令**: `__COMPILE_CMD__`
- **状态策略**: `__STATE_STRATEGY__`

---

## 🛑 准入依赖白名单 (Whitelist)
`__META_WHITELIST__`

## ❌ 动态审计黑名单 (Blacklist)
`__META_BLACKLIST__`

---

## 🛡️ 环境约束与开发工具链
- 推荐包管理器:自动识别绑定 (`npm`/`pnpm`/`bun`/`yarn`)
- 编译工具卡点: 必须通过 TypeScript 严格类型检查 (`tsc --noEmit`)