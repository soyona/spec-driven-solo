#!/bin/bash

# ==============================================================================
# 🚀 Spec-Driven Solo 开发工程规范 (V2.2.0-Kernel-Rotator) - 自动瘦身降噪初始化版
# 使用方法: 
#   1. bash init_spec.sh             (将以当前日期命名创建项目)
#   2. bash init_spec.sh my-cool-app (自定义项目名称)
#
# 🛠️ 升级核心：集成防只读内耗断路器、.clineignore 物理盲区、动态记忆体冷热轮转规约
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
    echo "📂 正在初始化 Spec-Driven V2.2.0-Kernel-Rotator 项目: ${PROJECT_NAME}..."
fi

# 🎯 3. 产品经理与架构师防线：技术轮廓 (Tech Profile) 矩阵交互选择
echo "--------------------------------------------------------"
echo "🎨 请选择您的产品形态与技术轮廓 (Tech Profile):"
echo " [1] Web/SaaS 轻量通用型 (Vite + React + TS + Tailwind) [直接回车默认]"
echo " [2] 微信跨端小程序 (Taro 4.x + React + TS + Tailwind)"
echo " [3] 跨平台桌面端应用 (Tauri 2.x + React + Rust + Tailwind)"
echo " [4] 复杂数据/BI 后台管理 (Next.js + Zustand + Shadcn/ui)"
echo "--------------------------------------------------------"
read -p "请输入选项数字 (1-4, 直接回车默认为 1): " PROFILE_CHOICE </dev/tty

# 【产品经理防线补丁】：回车默认无痛降级为 Web-MVP 方案
if [ -z "$PROFILE_CHOICE" ]; then
    PROFILE_CHOICE=1
fi

# 【资深架构师补丁】：将自然语言重构为冰冷的元依赖与行为特征约束词

case $PROFILE_CHOICE in
    2)
        PROFILE_NAME="微信跨端小程序 (Taro 4.x)"
        COMPILE_CMD="npm run build:weapp"
        STATE_STRATEGY="React Context 局部隔离"
        META_WHITELIST='[ "@tarojs/components", "@tarojs/taro", "lucide-react" ]'
        META_BLACKLIST='[ "vant-weapp", "miniprogram-custom-render", "微信原生未导出隐式全局对象" ]'
        TOOLCHAIN_ROUTER="- 特殊断路器 1：智能体只能且必须在本地通过 Taro CLI 进程进行静态 Lint 与编译，严禁在脱离微信开发者工具模拟器的环境下盲目猜测调试原生 API。\n- 特殊断路器 2：一旦本地构建产物（包体积）超过微信官方单包 2MB 物理硬限制，必须立刻触发强熔断（Stop），提示用户进行代码分包。"
        ;;
    3)
        PROFILE_NAME="跨平台桌面端应用 (Tauri 2.x)"
        COMPILE_CMD="cargo check && npm run tauri build"
        STATE_STRATEGY="前端 Context / 核心状态通过 Tauri IPC 路由由 Rust 侧持久化"
        META_WHITELIST='[ "tauri-plugin-fs", "wasm-bindgen", "serde", "tokio" ]'
        META_BLACKLIST='[ "child_process", "fs.writeFileSync", "panic!" ]'
        TOOLCHAIN_ROUTER="- 特殊断路器 1：智能体必须同时监控前端编译器与 Rust 后端编译器（cargo check），严禁在前端源码层编写任何破坏沙盒隔离的原生系统文件读写脚本。\n- 特殊断路器 2：Rust 侧代码一律严禁出现原生 \`panic!\` 恐慌，一旦连续触发编译或运行时恐慌超过 3 次，立刻终止一切 Act 行为并挂起会话。"
        ;;
    4)
        PROFILE_NAME="复杂数据/BI 后台管理 (Next.js)"
        COMPILE_CMD="npm run build"
        STATE_STRATEGY="特许解禁低熵原子状态库 Zustand 进行局部切片订阅，降低全局 Rerender 损耗"
        META_WHITELIST='[ "zustand", "echarts", "shadcn-ui", "next" ]'
        META_BLACKLIST='[ "recharts", "DOM轮询重绘", "context传递大对象", "redux", "mobx" ]'
        TOOLCHAIN_ROUTER="- 特殊断路器 1：Next.js App Router 静态编译与服务端组件渲染（SSR）双向走查，严禁抛弃现成的组件库进行低效的原子级 UI 从零造轮子。\n- 特殊断路器 2：大批量复杂图表交互（如 ECharts）严禁产生因依赖项配置错误导致的组件无效高频重渲染死循环。"
        ;;
    *)
        PROFILE_NAME="Web/SaaS 轻量通用型 (Vite Standard)"
        COMPILE_CMD="npm run build"
        STATE_STRATEGY="React Context 纯函数状态机"
        META_WHITELIST='[ "vite", "tailwindcss", "react-router-dom" ]'
        META_BLACKLIST='[ "redux", "webpack", "gulp" ]'
        TOOLCHAIN_ROUTER="- 特殊断路器 1：标准的 Vite HMR 热更新及严格的 TypeScript 编译期卡点，严禁破坏单页应用（SPA）的标准轻量路由结构。\n- 特殊断路器 2：严格执行标准的 Lint -> Build 连续编译防线。"
        ;;
esac

echo "🚀 已选定矩阵轮廓：$PROFILE_NAME，开始物理构建工程网络..."

# 4. 创建项目根目录并进入
mkdir -p "$PROJECT_NAME" && cd "$PROJECT_NAME"

# 5. 创建三大轨道的标准子目录
mkdir -p product-assets/PRD product-assets/wireframes product-assets/research
mkdir -p memory-bank
mkdir -p src/types src/components src/lib

# 6. 写入资产轨初始占位文件
cat << 'EOF' > product-assets/research/tech-review.md
# 架构师红队审查与技术选型白皮书 (tech-review.md)
> 此文件属于资产轨隔离区，用于封存网页端 Thinking 模型输出的长篇技术辩论历史。
> 本地 Agent 在开发中严禁高频扫描此文件，以斩断 Token 损耗。

## 🔍 核心技术攻坚与红队论证
*(请在此粘贴网页端 Thinking 模型输出的可行性分析、底层物理墙及架构演进原理解析)*
EOF

# 7. 写入多模态常驻硬约束（通用元内核自适应版）
cat << EOF > .clinerules
# Spec-Driven Solo 最高系统指令 (V2.2.0-Kernel-Rotator)

## 0. 【核心技术准入前置锁】
- 每次会话开始前的首要动作，你必须无条件物理读取 \`memory-bank/techContext.md\` 里的元依赖矩阵和 \`dataModels.md\` 的数据契约。
- **【硬性熔断卡点】**：检查 \`techContext.md\` 中的 \`人类审查状态\`。如果该状态为 \`PENDING\`，或者 \`Whitelist\` 为空、仅包含方括号占位符，说明人类尚未在网页端完成“技术选型与资产精炼”。你必须立刻停止（Stop）一切 Act 行为，强制原地断路并报警，绝不允许凭猜测动工！

## 1. 三轨资产绝对物理隔离
- **资产轨 (\`product-assets/\`)**：属于人类与网页端的顶层设计资产，你只有 Read 权限。为了节省上下文空间，你【严禁】高频扫描长篇幅的 \`product-assets/research/tech-review.md\`。
- **记忆轨 (\`memory-bank/\`)**：存放最冷酷、冰冷的静态事实、字典契约与任务看板。
- **源码轨 (\`src/\`)**：你唯一的生产阵地。
- 每次会话开始前，必须完整通读 memory-bank/ 下的所有文件，重建对代码库的全局认知。
- 严禁改动任何未在 \`memory-bank/activeContext.md\` 中提及的源码文件。
- 【强类型契约】：编写任何业务逻辑前，必须严格对齐 \`memory-bank/dataModels.md\` 定义的强类型边界。

## ⚖️ 最高铁律 4：记忆回写即交付 (No Log, No Done)
1. 【交付卡点】：你在声称任何任务“执行完毕”、“修复完成”或“请求人类验收”前，【必须且只能】将物理更新 \`memory-bank/activeContext.md\` 与 \`memory-bank/progress.md\` 作为你 Act 行为的最后一步。
2. 【非法交付判定】：若你仅修改了 \`src/\` 源码或配置文件，而未在同一次会话/Commit 中完整更新 Memory Bank 的物理状态（完成非瞬时状态外部化 EST），则判定该次交付为【非法交付 (Illegal Delivery)】。人类将拒绝进入下一步，你必须原地挂起并补齐状态。

## ⚖️ 最高铁律 5：跨领域自适应断路器 (Meta-Lint)
1. 【动态引入审查】：你在源码轨中引入的任何第三方库、SDK 或核心技术逻辑，必须能够完全在 \`techContext.md\` 的 \`Whitelist\` 中找到显式授权。
2. 【动态走查惩罚】：在日常代码生成中或执行验证命令前，一旦发现源码或配置文件中出现了包含 \`Blacklist\` 所列出的技术特征（关键字、被否决的包名、禁用的原生 API 或违规技术路径），你必须在 1 秒内触发强熔断（Stop），撤销当前代码生成，向人类报告违规！
3. 【连续编译卡点】：在修改任何核心功能或环境配置后，必须在终端主动运行当前矩阵对应的验证命令：$COMPILE_CMD
4. 【3次熔断线】：在终端运行检查、编译或测试命令时，一旦【连续失败超过 3 次】，必须立刻停止（Stop）一切 Act 行为，向人类如实报告原始日志并挂起会话。严禁盲目猜测与代码污染。
5. 【运行时网络审计】：若当前开发、调试环境涉及跨设备、局域网（如 192.168.x.x）或物理真机调试，必须在前置配置轨中显式允许安全源（如 Next.js 的 allowedDevOrigins），严禁产生隐式运行时跨域死锁。

## ❌ 6. 静态检索半径熔断与防重入锁 (Read/Search Circuit Breaker)
1. 【防重复读取锁】：你在单次 Task 周期（同一个会话窗口）内，对同一个 Markdown 记忆文件（尤其是 activeContext 或 progress）执行 \`read_file\` 的累计次数【严禁超过 2 次】。你必须优先复用自身 Context Window 中已缓存的文本快照。一旦试图触发第 3 次物理读取，必须自我声明进入“内耗断路状态”，强行原地挂起（Stop）并提请人类审查！
2. 【禁止全局盲搜】：严禁调用任何无路径限制的全局模糊检索命令（例：严禁执行全局 \`rg "关键词"\`）。你必须通过 \`-g\` 参数（例：\`rg "关键词" src/components/\`）或直接指定精准的目标文件名，将检索半径严格限制在受影响的特定代码块内，严禁将全量源码树无故读入上下文！
3. 【回归验证降级】：对于局部 UI 样式或局部 DOM 的 Bug 修复，必须优先依赖静态编译或类型检查进行回归验证。严禁无故高频启动 \`In-App Browser\` 执行端到端交互走查，只有在涉及复杂重绘且编译通过后，方可进行【单次】浏览器快照验证。

## 🧠 7. 微创定位与独立内聚重构准则
- 当接收到修复单时，禁止无脑通读整个记忆区。必须采用“逆向追溯法”，优先检查 Git 差异或直接读取报错表现涉及的单一核心组件。
- 在内部推演出根因因果链后，方可向源码轨申请修改。若发现底层资产（如 background-image）存在打印等物理环境设计缺陷，允许且仅允许对受影响的目标文件进行内联内聚式重构（如使用内联 SVG 替代背景图）。

## 💾 8. 动态记忆体轮转与瘦身规约 (Memory Rotation Protocol)
1. 【activeContext.md 瘦身】：当 \`activeContext.md\` 的物理行数超过 150 行，或记录的“历史已解决技术债”累积超过 5 项时，必须在当前 Task 结束前发起冷冻切片。将旧内容剪切移入并封存为 \`memory-bank/archive/activeContext_YYYYMMDD.md\`。原文件必须物理清空，仅保留当前特性的即时上下文和未解决的阻碍（Blockers）。
2. 【progress.md 看板熔断】：当 \`progress.md\` 中被勾选为 \`[x]\` 的已完成任务累积超过 20 项时，必须将所有已打勾的历史清单剪切，追加移入 \`memory-bank/archive/progress_historical_logs.md\` 的末尾。主干 \`progress.md\` 仅允许保留 \`[ ]\`（未解锁特性）和当前的 \`[-]\`（攻坚任务）。

## 🛠️ 库形态特化防线
$TOOLCHAIN_ROUTER
EOF
cp .clinerules .codexrules

# 8. 初始化解耦后的四大图纸文件（利用变量注入实现元插槽的静态固化）
cat << EOF > memory-bank/techContext.md
# 技术栈与依赖约束 (techContext.md V2.2.0-Kernel-Rotator)

## ⚖️ 架构师核心技术选型论证 (Arch Review)
- **人类审查状态**: PENDING
- **本领域核心难题**: [由网页端 Thinking 识别注入，开工前由人类填入]
- **本次研发上游资产**: \`product-assets/research/tech-review.md\`

## 🎯 1. 契约语言层 (The Contract Layer)
- 强制标准：TypeScript (或对应原生的强类型层)，严禁编写隐式 any。

## 🎨 2. 样式与布局层 (The UI/Visual Layer)
- 强制标准：低熵级渲染方案，样式与结构合一，彻底断绝样式文件失忆。
- 当前轮廓：Tailwind CSS 的自适应原子拓扑（如果适用）。

## 🧠 3. 状态拓扑层 (The State Topology Layer)
- 共享边界：$STATE_STRATEGY

## 🛑 4. 唯一准入核心依赖/技术白名单 (Whitelist)
<!-- 语法标准：必须写明具体的库名或原生的底层 API 命名，作为本地 Agent 唯一的合法引入目标 -->
- \`META_WHITELIST\` : $META_WHITELIST

## ❌ 5. 动态关联动态审计黑名单 (Blacklist)
<!-- 语法标准：必须写明被否决的技术路径或禁装包，作为 Lint 审计的拦截特征 -->
- \`META_BLACKLIST\` : $META_BLACKLIST

## ⚙️ 6. 编译命令与宿主路由控制
- 本地静态编译验证命令: \`$COMPILE_CMD\`
- 本地开发网络边界: 允许的开发源 localhost
EOF

cat << 'EOF' > memory-bank/projectBrief.md
# 项目总纲 (projectBrief.md)
## 1. 核心愿景与产品 definition
[🎯 在此写入当前矩阵架构下的产品一句话显式定义]

## 2. 核心范围 (In Scope)
- [ ] 核心功能 1

## 3. 显式非目标与边界 (OUT of Scope)
- [ ] 本版本不进行任何真实云端数据库连接，全部使用本地 Mock。
- [ ] 不接入任何第三方真实支付网关。
EOF

cat << 'EOF' > memory-bank/systemPatterns.md
# 架构与设计模式 (systemPatterns.md)
## 1. 核心设计模式与目录哲学
- 遵循三轨制职责划分，UI 纯组件与容器组件分离。

## 2. UI 组件嵌套树与 Props 关系契约表
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
# 任务进度看板 (progress.md V2.2.0-Kernel-Rotator)
## 🚦 核心准入依赖卡点
* [ ] 网页端顶级架构师红队论证并输出 `tech-review.md` 封存至资产轨
* [ ] 人类架构师走查白皮书，手动解锁 `techContext.md` 的人类审查状态为 `APPROVED`

## 🧱 🚀 开发进度清单
[x] 项目 V2.2.0-Kernel-Rotator 目录架构与特化规则配置初始化成功

[ ] 云端第一阶段图纸压榨（projectBrief/dataModels/systemPatterns）完成并本地覆盖

[ ] 按照 dataModels.md 实现 src/types 强类型镜像

[ ] 激活本地 Agent 开启宿主路由下的核心迭代
EOF


# 9. 创建源码轨的占位文件
touch src/types/index.ts src/main.ts package.json tsconfig.json

# 10. 写入资产轨原始输入规范
cat << EOF > product-assets/PRD/README.md
# 🎨 资产轨输入说明 (当前架构轮廓：$PROFILE_NAME)

本目录由人类开发者完全主导。你可以使用 `.txt` 或 `.md` 自由记录你的口语化创意或原始需求单。

## 📝 输入底线：请务必确保你的内容包含以下“三要素”：
1. **🎯 显式愿景**：产品是什么？解决什么核心痛点？
2. **🚧 显式边界 (Out of Scope)**：V1.0 阶段绝对**不做**什么？（如：不做登录、不接真实数据库、全Mock）。
3. **🛑 负向约束**：技术或业务上坚决**不能**出现什么？（如：禁止引入生僻字、严禁使用外部复杂状态库）。

## 👑 矩阵版压榨路线：
内容准备就绪后，直接全选并复制给 ChatGPT 网页端，配合【V2.1.0 架构师特化咒语】，下达指令：“请扮演特定领域的顶级架构师，进行红队技术可行性与选型论证，并严格按照 Spec-Driven Solo 规范，为我精炼输出隔离的 tech-review.md 以及带元依赖槽的记忆银行图纸。”
EOF

# 11. 🔨 核心升级：写入强力的 Agent 物理盲区防线 (.clineignore)
cat << 'EOF' > .clineignore
# ==============================================================================
# ❄️ SDD 资产隔离区：严禁 Agent 扫描、读取与建立向量索引的历史冷资产 (V2.2.0)
# ==============================================================================
memory-bank/archive/
memory-bank/*_historical_logs.md
product-assets/research/tech-review.md
node_modules/
dist/
.DS_Store
*.log
.next/
out/
.tauri/target/
next-env.d.ts
EOF

# 保持标准的 .gitignore 与物理盲区轨道绝对同步
cp .clineignore .gitignore

echo "--------------------------------------------------------"
echo "✅ [Mac] Spec-Driven V2.2.0-Kernel-Rotator目录结构一键初始化成功！"
echo "📂 项目路径: $(pwd)"
echo "👑 已锁定技术轮廓: $PROFILE_NAME"
echo ""
echo "🔥 [下一步防内耗激活指引]："
echo " 1. 本地已默认构建 memory-bank/archive/ 冷资产目录与 .clineignore 盲区 [已升级]。"
echo " 2. 请在 'product-assets/PRD/' 下创建你的业务需求。"
echo " 3. 根据云端 Thinking 推演，补全 'memory-bank/techContext.md' 的 Whitelist。"
echo " 4. 确认无误后，手动将 '人类审查状态' 物理修改为 APPROVED，解除开工锁！"
echo ""
echo "💡 提示: 本脚手架已在根目录内置最新的防内耗与轮转熔断铁律，Agent 连接后将自动锁定行为边界。"
echo "--------------------------------------------------------"