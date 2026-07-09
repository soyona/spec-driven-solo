#!/bin/bash

# ==============================================================================
# 🚀 Spec-Driven Solo 开发工程规范 (V1.2.0) - Mac 一键初始化脚本
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
    echo "📂 正在初始化 Spec-Driven V1.2.0 项目: ${PROJECT_NAME}..."
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
0. 【开工依赖前置检查】：每次会话开始前，必须检查 `memory-bank/` 下的 `projectBrief.md` 与 `dataModels.md` 是否已被人类初始化。如果这两个文件为空、仅包含模板说明或方括号占位符，说明人类尚未完成“资产轨精炼”，你必须立刻停止（Stop）一切 Act 行为，并提示用户：“请先参考 product-assets/PRD/ 规范，前往 ChatGPT 网页端完成记忆图纸压榨后方可开工。”
1. 每次会话开始前，必须完整通读 memory-bank/ 下的所有文件，重建对代码库的全局认知。
2. 严禁改动任何未在 `memory-bank/activeContext.md` 中提及的源码文件。
3. 【强类型契约】：编写任何业务逻辑前，必须严格对齐 `memory-bank/dataModels.md`。
## ⚖️ 最高铁律 4：记忆回写即交付 (No Log, No Done)
1. 【交付卡点】：你在声称任何任务“执行完毕”、“修复完成”或“请求人类验收”前，【必须且只能】将物理更新 `memory-bank/activeContext.md` 与 `memory-bank/progress.md` 作为你 Act 行为的最后一步。
2. 【非法交付判定】：若你仅修改了 `src/` 源码或配置文件，而未在同一次会话/Commit 中完整更新 Memory Bank 的物理状态（完成非瞬时状态外部化 EST），则判定该次交付为【非法交付 (Illegal Delivery)】。人类将拒绝进入下一步，你必须原地挂起并补齐状态。

## ⚖️ 最高铁律 5：异常熔断与环境双轨验证
1. 【连续编译卡点】：在修改任何核心功能或环境配置后，必须在终端主动运行静态验证：静态检查 (Lint) -> 生产构建 (Build)。
2. 【3次熔断线】：在终端运行检查、编译或测试命令时，一旦【连续失败超过 3 次】，必须立刻停止（Stop）一切 Act 行为，向人类如实报告原始日志并挂起会话。严禁盲目猜测、高频试错与代码污染。
3. 【运行时网络审计】：若当前开发、调试环境涉及跨设备、局域网（如 192.168.x.x）或物理真机调试，必须在前置配置轨中显式允许安全源（如 Next.js 的 allowedDevOrigins），严禁产生隐式运行时跨域死锁。
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

## 3. 运行时与网络边界 (Runtime & Network Boundaries)
- [开发环境局域网 IP / 域名白名单适配情况记录，防止真机/多端调试时发生热更新及跨域死锁]
- 允许的开发源: 
  - localhost
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
[x] 项目 V1.2.0 目录架构初始化

[ ] 初始化 package.json 与基础依赖配置

[ ] 按照 dataModels.md 实现 src/types 强类型镜像

[ ] 核心功能迭代开始
EOF


# 6. 创建源码轨的占位文件
touch src/types/index.ts src/main.ts package.json tsconfig.json

# ⚖️ 【新增特性 V1.2.0】写入资产轨原始输入规范
cat << 'EOF' > product-assets/PRD/README.md
# 🎨 资产轨输入说明 (Raw Requirements)

本目录由人类开发者完全主导。你可以使用 `.txt` 或 `.md` 自由记录你的口语化创意或原始需求单。

## 📝 输入底线：请务必确保你的内容包含以下“三要素”：
1. **🎯 显式愿景**：产品是什么？解决什么核心痛点？
2. **🚧 显式边界 (Out of Scope)**：V1.0 阶段绝对**不做**什么？（如：不做登录、不接真实数据库、全Mock）。
3. **🛑 负向约束**：技术或业务上坚决**不能**出现什么？（如：禁止引入生僻字、严禁使用外部复杂状态库）。

内容准备就绪后，直接全选并复制给 ChatGPT 网页端，下达指令：“请扮演系统架构师，根据这份原始需求，严格按照 Spec-Driven Solo 规范，为我精炼输出 memory-bank/ 下的 projectBrief.md 和 dataModels.md 图纸。”
EOF

# ⚖️ 【新增特性 V1.2.0】写入标准 .gitignore 锁死 Agent 索引范围
cat << 'EOF' > .gitignore
node_modules/
dist/
.DS_Store
*.log
.next/
out/
next-env.d.ts
EOF

echo "--------------------------------------------------------"
echo "✅ [Mac] Spec-Driven V1.2.0 目录结构一键初始化成功！"
echo "📂 项目路径: $(pwd)"
echo ""
echo "🔥 [下一步核心实战指引]："
echo " 1. 打开目录，在 'product-assets/PRD/' 下创建你的需求文件（.txt 或 .md 均可）。"
echo " 2. 需求必须包含：[显式愿景]、[V1.0 不做什么]、[负向约束] 三要素。"
echo " 3. 内容完成后，直接将其全选复制给 ChatGPT 网页端进行‘图纸压榨’。"
echo ""
echo "💡 提示: 请直接使用 VS Code / IDE 打开该目录，并将工作区访问权限授予您的 Codex / Cline 智能体开始协同开发。"
echo "--------------------------------------------------------"