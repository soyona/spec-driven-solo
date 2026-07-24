# 🏗️ 架构模式与目录哲学 (systemPatterns.md)

## 1. 核心架构模式 (Architecture Patterns)
- **UI 纯组件与容器分离**: `src/components/` 仅负责无状态/纯展示 UI，业务逻辑收拢于 `src/lib/` 或 Custom Hooks。
- **类型单源真理 (Single Source of Truth)**: 所有的全局类型契约统一在 `src/types/index.ts` 导出，并映射 `dataModels.md`。

## 2. 目录哲学 (Directory Philosophy)
- `src/types/`: 强类型镜像
- `src/components/`: 原子化前端 UI 组件
- `src/lib/`: 核心工具函数、API 客户端与业务逻辑封装