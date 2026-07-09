#!/bin/bash

# ==============================================================================
# 🚀 Spec-Driven Solo 开发工程规范 (V2.0.0-Matrix) - 矩阵化一键初始化脚本
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

# 🚨2. 核心冲突检查机制：判定本地是否存在同名目录
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
    echo "📂 正在初始化 Spec-Driven V2.0.0-Matrix 项目: ${PROJECT_NAME}..."
fi

# 🎯 3. 【新增 V2.0 特性】产品经理与架构师防线：技术轮廓 (Tech Profile) 矩阵交互选择
echo "--------------------------------------------------------"
echo "🎨 请选择您的产品形态与技术轮廓 (Tech Profile):"
echo " [1] Web/SaaS 轻量通用型 (Vite + React + TS + Tailwind) [直接回车默认]"
echo " [2] 微信跨端小程序 (Taro 4.x + React + TS + Tailwind)"
echo " [3] 跨平台桌面端应用 (Tauri 2.x + React + Rust + Tailwind)"
echo " [4] 复杂数据/BI 后台管理 (Next.js + Zustand + Shadcn/ui)"
echo "--------------------------------------------------------"
read -p "请输入选项数字 (1-4, 直接回车默认为 1): " PROFILE_CHOICE </dev/tty

# 【产品经理防线补丁】：回车默认无痛降级为 Web-MVP 方案，降低启动焦虑
if [ -z "$PROFILE_CHOICE" ]; then
    PROFILE_CHOICE=1
fi

# 【资深架构师补丁】：提取各 Profile 的核心元数据、黑名单以及宿主路由约束

case $PROFILE_CHOICE in
    2)
        PROFILE_NAME="微信跨端小程序 (Taro 4.x)"
        COMPILE_CMD="npm run dev:weapp / npm run build:weapp"
        STATE_STRATEGY="React Context 局部隔离"
        NEGATIVE_CONSTRAINTS="- 严禁安装原生微信小程序的 WXML 组件库，必须统一使用 Taro 核心组件。\n- 严禁绕过 Taro 顶层 API 直接在源码中调用微信原生未导出的隐式全局对象。"
        TOOLCHAIN_ROUTER="- 宿主编译路由：AI 只能且必须在本地通过 Taro CLI 进程进行静态 Lint 与编译，严禁在脱离微信开发者工具模拟器的环境下盲目猜测调试原生 API。\n- 特殊断路器：一旦本地构建产物（包体积）超过微信官方单包 2MB 物理硬限制，必须立刻触发熔断（Stop），提示用户进行代码分包。"
        ;;
    3)
        PROFILE_NAME="跨平台桌面端应用 (Tauri 2.x)"
        COMPILE_CMD="cargo check && npm run tauri dev"
        STATE_STRATEGY="前端 Context / 核心状态通过 Tauri IPC 路由由 Rust 侧持久化"
        NEGATIVE_CONSTRAINTS="- 严禁 AI 智能体擅自引入未经架构评审的 Rust 外部 Crate 依赖。\n- 严禁在前端源码层（src/）编写任何破坏沙盒隔离的原生系统文件读写脚本。"
        TOOLCHAIN_ROUTER="- 宿主编译路由：智能体必须同时监控前端编译器与 Rust 后端编译器（cargo check）。\n- 特殊断路器：Rust 侧代码一律严禁出现原生 \`panic!\` 恐慌，一旦连续触发编译或运行时恐慌超过 3 次，立刻终止一切 Act 行为并挂起会话。"
        ;;
    4)
        PROFILE_NAME="复杂数据/BI 后台管理 (Next.js)"
        COMPILE_CMD="npm run dev / npm run build"
        STATE_STRATEGY="特许解禁低熵原子状态库 Zustand 进行局部切片订阅，降低全局 Rerender 损耗"
        NEGATIVE_CONSTRAINTS="- 特许放行 Zustand，但坚决禁止引入冗余的大厂级 Redux/MobX 模板代码。\n- 严禁 AI 抛弃现成的 Shadcn/ui 或 Ant Design 组件库进行任何低效的、原子级 UI 组件从零造轮子。"
        TOOLCHAIN_ROUTER="- 宿主编译路由：Next.js App Router 静态编译与服务端组件渲染（SSR）双向走查。\n- 特殊断路器：大批量复杂图表交互（如 ECharts）严禁产生因依赖项配置错误导致的组件无效高频重渲染死循环。"
        ;;
    *)
        PROFILE_NAME="Web/SaaS 轻量通用型 (Vite Standard)"
        COMPILE_CMD="npm run dev / npm run build"
        STATE_STRATEGY="React Context 纯函数状态机"
        NEGATIVE_CONSTRAINTS="- 严禁引入任何外部复杂状态库（如 Redux），仅允许使用 React Context。\n- 严禁破坏单页应用（SPA）的标准轻量路由结构。"
        TOOLCHAIN_ROUTER="- 宿主编译路由：标准的 Vite HMR 热更新及严格的 TypeScript 编译期卡点。\n- 特殊断路器：严格执行标准的 Lint -> Build 连续编译防线。"
        ;;
esac

echo "🚀 已选定矩阵轮廓：$PROFILE_NAME，开始物理构建工程网络..."

# 4. 创建项目根目录并进入
mkdir -p "$PROJECT_NAME" && cd "$PROJECT_NAME"

# 5. 创建三大轨道的标准子目录
mkdir -p product-assets/PRD product-assets/wireframes product-assets/research
mkdir -p memory-bank
mkdir -p src/types src/components src/lib

# 6. 写入多模态常驻硬约束（AI 行为紧箍咒与特化宿主路由拦截）
# 💡 完美统一反引号转义，确保物理输出的纯净性
cat << EOF > .clinerules
# 最高系统指令 (System Rules)
0. 【矩阵型开工依赖检查】：每次会话开始前，必须物理检查 \`memory-bank/\` 下的 \`projectBrief.md\` 与 \`dataModels.md\` 是否已被人类通过所选的技术轮廓（$PROFILE_NAME）成功初始化。如果文件为空、仅包含模板说明或方括号占位符，说明人类尚未在网页端完成“资产轨精炼”，你必须立刻停止（Stop）一切 Act 行为，强制熔断并报警！
1. 每次会话开始前，必须完整通读 memory-bank/ 下的所有文件，重建对代码库的全局认知。
2. 严禁改动任何未在 \`memory-bank/activeContext.md\` 中提及的源码文件。
3. 【强类型契约】：编写任何业务逻辑前，必须严格对齐 \`memory-bank/dataModels.md\` 定义的强类型边界。

## ⚖️ 最高铁律 4：记忆回写即交付 (No Log, No Done)
1. 【交付卡点】：你在声称任何任务“执行完毕”、“修复完成”或“请求人类验收”前，【必须且只能】将物理更新 \`memory-bank/activeContext.md\` 与 \`memory-bank/progress.md\` 作为你 Act 行为的最后一步。
2. 【非法交付判定】：若你仅修改了 \`src/\` 源码或配置文件，而未在同一次会话/Commit 中完整更新 Memory Bank 的物理状态（完成非瞬时状态外部化 EST），则判定该次交付为【非法交付 (Illegal Delivery)】。人类将拒绝进入下一步，你必须原地挂起并补齐状态。

## ⚖️ 最高铁律 5：宿主编译路由与特化熔断线
1. 【连续编译卡点】：在修改任何核心功能或环境配置后，必须在终端主动运行当前矩阵对应的验证命令：$COMPILE_CMD
2. 【3次熔断线】：在终端运行检查、编译或测试命令时，一旦【连续失败超过 3 次】，必须立刻停止（Stop）一切 Act 行为，向人类如实报告原始日志并挂起会话。严禁盲目猜测、高频试错与代码污染。
3. 【运行时网络审计】：若当前开发、调试环境涉及跨设备、局域网（如 192.168.x.x）或物理真机调试，必须在前置配置轨中显式允许安全源（如 Next.js 的 allowedDevOrigins），严禁产生隐式运行时跨域死锁。
4. 【🛠️ 宿主编译特殊防线】：
$TOOLCHAIN_ROUTER
EOF
cp .clinerules .codexrules

# 7. 初始化解耦后的四大图纸文件（利用变量注入实现 techContext 的静态固化）
cat << EOF > memory-bank/techContext.md
# 技术栈与依赖约束 (techContext.md V2.0.0-Matrix)

## 🎯 1. 契约语言层 (The Contract Layer)
- 强制标准：TypeScript (或对应原生的强类型层)，严禁编写隐式 any。

## 🎨 2. 样式与布局层 (The UI/Visual Layer)
- 强制标准：低熵级渲染方案，样式与结构合一，彻底断绝样式文件失忆。
- 当前轮廓：Tailwind CSS 的自适应原子拓扑。

## 🧠 3. 状态拓扑层 (The State Topology Layer)
- 共享边界：$STATE_STRATEGY

## 🛑 4. 严禁引入的依赖黑名单 (Negative Constraints)
$NEGATIVE_CONSTRAINTS

## ⚙️ 5. 编译命令与宿主路由控制
- 本地静态编译验证命令: \`$COMPILE_CMD\`[cite: 8]
- 本地开发网络边界: 允许的开发源 localhost[cite: 8]
EOF

cat << 'EOF' > memory-bank/projectBrief.md
# 项目总纲 (projectBrief.md)
## 1. 核心愿景与产品定义[cite: 8]
[🎯 在此写入当前矩阵架构下的产品一句话显式定义]

## 2. 核心范围 (In Scope)[cite: 8]
- [ ] 核心功能 1[cite: 8]

## 3. 显式非目标与边界 (OUT of Scope)[cite: 8]
- [ ] 本版本不进行任何真实云端数据库连接，全部使用本地 Mock。[cite: 8]
- [ ] 不接入任何第三方真实支付网关。[cite: 8]
EOF

cat << 'EOF' > memory-bank/systemPatterns.md
# 架构与设计模式 (systemPatterns.md)
## 1. 核心设计模式与目录哲学[cite: 8]
- 遵循三轨制职责划分，UI 纯组件与容器组件分离。[cite: 8]

## 2. UI 组件嵌套树与 Props 关系契约表
[在此记录组件的输入 Props、输出 Events 和副作用约束][cite: 8]
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
[x] 项目 V2.0.0-Matrix 目录架构与特化规则配置初始化成功

[ ] 云端第一阶段图纸压榨（projectBrief/dataModels/systemPatterns）完成并本地覆盖

[ ] 按照 dataModels.md 实现 src/types 强类型镜像[cite: 8]

[ ] 激活本地 Agent 开启宿主路由下的核心迭代
EOF


# 8. 创建源码轨的占位文件
touch src/types/index.ts src/main.ts package.json tsconfig.json

# 9. 写入资产轨原始输入规范（结合技术轮廓提示）
cat << EOF > product-assets/PRD/README.md
# 🎨 资产轨输入说明 (当前架构轮廓：$PROFILE_NAME)

本目录由人类开发者完全主导。你可以使用 `.txt` 或 `.md` 自由记录你的口语化创意或原始需求单。

## 📝 输入底线：请务必确保你的内容包含以下“三要素”：
1. **🎯 显式愿景**：产品是什么？解决什么核心痛点？
2. **🚧 显式边界 (Out of Scope)**：V1.0 阶段绝对**不做**什么？（如：不做登录、不接真实数据库、全Mock）。
3. **🛑 负向约束**：技术或业务上坚决**不能**出现什么？（如：禁止引入生僻字、严禁使用外部复杂状态库）。

## 👑 矩阵版压榨路线：
内容准备就绪后，直接全选并复制给 ChatGPT 网页端，配合新手指南 V2.0 中的【超级黄金咒语】，下达指令：“请扮演系统架构师，根据我的技术轮廓和这份原始需求，严格按照 Spec-Driven Solo 规范，为我精炼输出记忆银行图纸。”
EOF

# 10. 写入标准 .gitignore 锁死 Agent 索引范围
cat << 'EOF' > .gitignore
node_modules/
dist/
.DS_Store
*.log
.next/
out/
.tauri/target/
next-env.d.ts
EOF

echo "--------------------------------------------------------"
echo "✅ [Mac] Spec-Driven V2.0.0-Matrix 目录结构一键初始化成功！"
echo "📂 项目路径: $(pwd)"
echo "👑 已锁定技术轮廓: $PROFILE_NAME"
echo ""
echo "🔥 [下一步核心实战指引]："
echo " 1. 打开目录，在 'product-assets/PRD/' 下创建你的需求文件（.txt 或 .md 均可）。"
echo " 2. 将其全选，配合新手指南中的【超级黄金咒语】复制给 ChatGPT 网页端进行‘图纸压榨’。[cite: 8]"
echo " 3. 将 AI 输出的 projectBrief/dataModels/systemPatterns 覆盖到本地 memory-bank/ 下。"
echo ""
echo "💡 提示: 请直接使用 VS Code / IDE 打开该目录，并将工作区访问权限授予您的 Codex / Cline 智能体开始协同开发。"
echo "--------------------------------------------------------"