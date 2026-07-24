# 📝 TypeScript 接口与 JSON Schema 定义 (dataModels.md)

> 提示：本文件定义的数据结构，必须 100% 物理映射镜像至 `src/types/index.ts` 中。

## 1. 核心实体模型 (Core Domain Models)

```typescript
// 示例：基础通用实体契约
export interface BaseEntity {
  id: string;
  createdAt: number;
  updatedAt: number;
}
```

## 2. API 响应通用结构 (API Schema)

```typescript
export interface ApiResponse<T> {
  code: number;
  message: string;
  data: T;
}
```