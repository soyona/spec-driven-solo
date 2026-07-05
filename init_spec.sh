#!/bin/bash

# ==============================================================================
# 🚀 Spec-Driven Solo 开发工程规范 (V1.0) - Mac 一键初始化脚本
# 使用方法: 
#   1. bash init_spec.sh             (将以当前日期命名创建项目)
#   2. bash init_spec.sh my-cool-app (自定义项目名称)
# 
# 赋予权限命令: chmod +x init_spec.sh
# ==============================================================================

# 1. 动态获取项目名称
PROJECT_NAME=$1
if [ -z "$PROJECT_NAME" ]; then
    CURRENT_DATE=$(date "+%Y%m%d")
    PROJECT_NAME="spec-app-$CURRENT_DATE"
fi

# 🚨 核心冲突检查机制：判定本地是否存在同名目录
if [ -d "$PROJECT_NAME" ]; then
    echo "⚠️  警告: 本地已存在同名目录 [${PROJECT_NAME}]"
    echo "--------------------------------------------------------"
    echo " 请选择后续操作:"
    echo " [1] 覆盖初始化 (清空原目录并重新构建 - ⚠️ 危险操作)"
    echo " [2] 增量继续 (保留原目录，仅补全缺失的三轨制结构与规则文件)"
    echo " [3] 终止退出"
    echo "--------------------------------------------------------"
    
    # 💡 强制重定向标准输入至物理控制终端，确保 curl | bash 场景下键盘输入有效
    read -p "请输入选项数字 (1/2/3): " CONFLICT_CHOICE </dev/tty
    
    case $CONFLICT_CHOICE in
        1)
            echo "🔥 正在清空并重新初始化目录: ${PROJECT_NAME}..."
            rm -rf "$PROJECT_NAME"
            ;;
        2)
            echo "🔄 正在对已有目录进行增量合规化补全: ${PROJECT_NAME}..."
            ;;
        *)
            echo "🛑 操作已取消，脚本安全退出。"
            exit 0
            ;;
    esac
else
    echo "📂 正在初始化 Spec-Driven V1.0 项目: ${PROJECT_NAME}..."
fi

# 2. 创建项目根目录并进入
mkdir -p "$PROJECT_NAME" && cd "$PROJECT_NAME"

# 3. 创建三大轨道的标准子目录
mkdir -p product-assets/PRD product-assets/wireframes product-assets/research
mkdir -p memory-bank
mkdir -p src/types src/components src/lib

# 4. 写入常驻硬约束（AI 行为紧箍咒与熔断机制）
cat << 'EOF' > .clinerules
# 最高系统指令 (System Rules)
1. 每次会话开始前，必须完整通读 memory-bank/ 下的所有文件，重建对代码库的全局认知。
2. 严禁改动任何未在 `memory-bank/activeContext.md` 中提及的源码文件。
3. 【强类型契约】：编写任何业务逻辑前，必须严格对齐 `memory-bank/dataModels.md`。
4. 【报错熔断】：一旦你在终端运行编译、构建或 Lint 命令连续失败超过 3 次，你必须立刻停止（Stop）一切 Act 行为，向人类如实报告日志，严禁盲目猜测与高频试错。
EOF
cp .clinerules .codexrules

# 5. 初始化记忆轨基础模板文件
cat << 'EOF' > memory-bank/projectBrief.md
# 项目总纲 (projectBrief.md)
## 1. 核心愿景与产品定义
[在此写入产品的一句话显式定义]

## 2. 核心范围 (In Scope)
- [ ] 核心功能 1

## 3. 显式非目标与边界 (OUT of Scope)
- [ ] 本版本不进行任何真实云端数据库连接，全部使用本地 Mock。
- [ ] 不接入任何第三方真实支付网关。
EOF

cat << 'EOF' > memory-bank/techContext.md
# 技术栈与依赖约束 (techContext.md)
## 1. 锁死技术栈
- 基础框架: [例如：Vite + React + TypeScript / Next.js]
- 样式表现: Tailwind CSS

## 2. 严禁引入的依赖黑名单 (Negative Constraints)
- 严禁引入外部复杂状态库（如 Redux），仅允许使用 React Context。
- 编译与运行命令: `npm run dev` / `npm run build`
EOF

cat << 'EOF' > memory-bank/systemPatterns.md
# 架构与设计模式 (systemPatterns.md)
## 1. 核心设计模式与目录哲学
- 遵循三轨制职责划分，UI 纯组件与容器组件分离。

## 2. UI 组件嵌套树与关系
[在此记录组件的输入 Props、输出 Events 和副作用约束]
EOF

cat << 'EOF' > memory-bank/dataModels.md
# 数据契约模型 (dataModels.md)
## 1. 核心强类型定义 (TypeScript Interfaces)
```typescript
// 示例契约，开发前请由 ChatGPT 网页端生成并替换
export interface UserMock {
  id: string;
  name: string;
}
```
EOF

cat << 'EOF' > memory-bank/activeContext.md
# 动态上下文 (activeContext.md)
## 当前所处阶段
正在进行项目初始化与脚手架搭建。

## 遇到的技术债与权宜之计 (Blockers & Mitigations)
暂无。
EOF

cat << 'EOF' > memory-bank/progress.md
# 任务进度看板 (progress.md)
## 🚀 开发进度清单
[x] 项目 V1.0 目录架构初始化

[ ] 初始化 package.json 与基础依赖配置

[ ] 按照 dataModels.md 实现 src/types 强类型镜像

[ ] 核心功能迭代开始
EOF


# 6. 创建源码轨的占位文件
touch src/types/index.ts src/main.ts package.json tsconfig.json

# ⚖️ 【新增特性 V1.1.0】写入标准 .gitignore 锁死 Agent 索引范围
cat << 'EOF' > .gitignore
node_modules/
dist/
.DS_Store
*.log
EOF

echo "--------------------------------------------------------"
echo "✅ [Mac] Spec-Driven V1.0 目录结构一键初始化成功！"
echo "📂 项目路径: $(pwd)"
echo "💡 提示: 请直接使用 VS Code / IDE 打开该目录，并将工作区访问权限授予您的 Codex / Cline 智能体开始协同开发。"
echo "--------------------------------------------------------"