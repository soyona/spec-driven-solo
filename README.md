# 📘 Spec-Driven Solo 开发工程规范 (V1.0)

> **专为 ChatGPT Plus (Web) + Codex / Cline / Roo-Cline 架构设计的全栈三轨工程标准。旨在通过引入确定性的工程约束机制，系统性解决自主 AI 编程智能体在长对话迭代中出现的幻觉、状态丢失以及无限执行死循环等核心痛点。**

---

## 💡 为什么需要 Spec-Driven Solo？

### 从“人际协作”到“人机共生”的范式重构
在传统软件工程（如 Scrum、Agile）中，研发流程的底层设计主要用于解决**人与人之间的协作、分工和信任成本**，其核心瓶颈在于“人类团队的编码带宽”。

然而，在 **Solo（超级个体）+ AI 智能体** 的新开发范式下，生产力带宽已被十倍级放大，传统流程彻底失效。这一范式转变带来了全新的工程核心矛盾：**人机通信的精确度、状态同步的无序性，以及如何用确定性的代码规范去约束混沌的 AI 行为**。

若直接将传统研发习惯沿用至 AI 协同流水线中，将不可避免地遭遇以下由 Agent 机制缺陷导致的系统性工程痛点：

* **❌ 无约束异常修复（Token 异常消耗）**：在终端运行编译或 Lint 报错后，智能体容易进入“盲目修改 $\rightarrow$ 引入新错 $\rightarrow$ 再次盲目修改”的递归尝试中。这种缺乏根因验证的高频试错，极易陷入死循环，导致上下文窗口与 Token 额度异常消耗。
* **❌ 上下文窗口饱和（历史状态丢失）**：随着代码库规模线性增长，超出上下文窗口限制会导致历史状态丢失。智能体将失去对全局代码库的宏观认知，引发偏离初始产品愿景、重复编写已有逻辑、或引入未授权第三方冗余依赖等问题。
* **❌ 隐式契约脱节（重构与集成缺陷）**：过于依赖自然语言口语化输入，缺乏结构化、确定性的强类型契约支撑。当前后端或组件边界发生重构时，智能体无法自动感知变更边界，极易引入隐性回归缺陷。

关于独立开发中“AI 智能体引入的新痛点与研发范式演进”的深度剖析，可详细参考 [Solo Dev Problem 痛点定义文档](https://github.com/soyona/sadp/blob/main/v2/0-Solo%20Dev%20Problem.md)。

**Spec-Driven Solo** 正是为了响应这一范式代际转变而生。它摒弃了以自然语言低效指挥 Agent 的传统做法，通过建立严格的目录层级隔离，将工程划分为 **产品资产（资产轨）**、**状态控制（记忆轨）** 与 **功能落地（源码轨）**，为 Solo 开发者量身定制了一套确保软件协同构建过程高效、可预测与可验证的底层操作系统。


### 理论根基与行业演进坐标

**Spec-Driven Solo** 正是为了响应这一范式代际转变而生的工程方法论。本框架的设计基于两项核心软件工程理论：

1. **规范驱动软件合成 (Specification-Driven Software Synthesis)**：传统的自然语言 Prompt 具有极高的模糊性与语义熵。本规范通过引入前置、确定性的数据与行为规约，将 Agent 的自然语言生成问题（Generation）转化为基于严格约束的软件合成问题，从根本上降低了幻觉的发生概率。
2. **非瞬时状态外部化 (Externalized State Tracking)**：智能体在长对话中表现出的“健忘”本质上是有限上下文内的马尔可夫决策过程（MDP）失效。本规范参考了经典控制理论中的状态机设计，将智能体的运行状态与架构认知解耦并常驻于本地磁盘，实现跨会话的记忆持久化。

在当前的 AI Coding 行业演进浪潮中，本规范与全球主流的技术演进路径保持高度一致：

* **对齐行业标准架构**：本框架的“三轨隔离”与核心系统指令，在设计哲学上深度契合了 Anthropic 推出的 **Model Context Protocol (MCP)** 开放标准，即通过标准化上下文协议，切断智能体与不可控原始数据的直接接触。
* **演进自工业界最佳实践**：本框架的记忆银行（Memory Bank）设计，吸收并优化了 Cline、Roo-Cline 以及主流 Agent 开源社区中自发演进出的常驻知识库范式。相较于完全交由 Agent 自主维护的传统做法，本规范强调了“人机协同走查（Human-in-the-loop Review）”，确保图纸在输入源码轨前具备绝对的确定性。

通过将上述理论转化为开箱即用的工程目录与熔断协议，Spec-Driven Solo 为 Solo 开发者提供了一套确保软件协同构建过程高效、可预测与可验证的底层操作系统。

---

## 📂 一、 完整工程目录树 (Repository Tree)

本规范强制执行以下目录结构。智能体将通过常驻的行为准则，被严格约束在此套目录哲学之内：

```text
你的项目根目录/
├── 📄 .clinerules / .codexrules   # ⚖️ 【系统铁律】最高优先级 AI 行为紧箍咒（含强熔断机制）
│
├── 📂 product-assets/             # 🎨 【资产轨】人类初始想法与产品资产（AI 仅读，严禁高频扫描）
│   ├── 📂 PRD/                    # 原始需求文档、用户故事随笔、核心业务流
│   ├── 📂 wireframes/             # UI 截图、原型图说明、Figma/设计稿引用链接
│   └── 📂 research/               # 竞品调研、市场灵感、用户反馈记录
│
├── 📂 memory-bank/                # 🧠 【记忆轨】AI 外部持久化大脑（AI 高频读写，核心控制中枢）
│   ├── 📄 projectBrief.md         # 基础：产品愿景、核心范围、显式非目标（不做什么）
│   ├── 📄 techContext.md          # 依赖：锁死的技术栈、编译环境、严禁引入的黑名单库
│   ├── 📄 systemPatterns.md       # 架构：核心设计模式、目录哲学、UI 组件嵌套树
│   ├── 📄 dataModels.md           # 契约：TypeScript 强类型接口与 JSON Schema 定义
│   ├── 📄 activeContext.md        # 短期：当前执行的即时上下文、遇到的坎、采取的权宜之计
│   └── 📄 progress.md             # 状态：切香肠式可执行清单（Task Checklist: Todo/Doing/Done）
│
├── 📂 src/                        # 🛠️ 【源码轨】业务逻辑实现（AI 唯一的纯代码输出目标）
│   ├── 📂 types/                  # 强类型镜像（完全映射并引用 memory-bank/dataModels.md）
│   ├── 📂 components/             # 原子化前端 UI 组件（UI 纯组件与容器组件分离）
│   ├── 📂 lib/                    # 核心工具函数、数据库客户端、业务逻辑封装
│   └── 📄 main.ts / app.tsx       # 应用程序主入口
│
├── 📄 package.json                # 依赖管理清单
└── 📄 tsconfig.json               # 严格的 TypeScript 编译配置文件

```

---

## ⚖️ 二、 三轨制协作法理与最高铁律

### 1. 轨道职责隔离

* **资产轨 (`product-assets/`)**：存放未精炼的人类原始口语化需求。智能体在编码阶段严禁高频扫描此目录，以防止污染上下文空间。
* **记忆轨 (`memory-bank/`)**：由 ChatGPT 网页端将上游原料精炼后的标准工程图纸。所有文件采用高度结构化的 Markdown 格式，用以锁死技术边界与数据契约。
* **源码轨 (`src/`)**：智能体自动生成的唯一纯代码输出目标，由人类开发者实施差分审计（Diff Audit）。

### 2. 行为准则与硬熔断协议

项目根目录下的 `.clinerules / .codexrules` 会在全局层面劫持 AI Agent 的系统提示词：

> 1. **状态同步**：每次对话开始前，必须完整通读 `memory-bank/` 下的所有文件，重建对代码库的全局认知。
> 2. **契约对齐**：严禁改动任何未在 `activeContext.md` 中提及的源码文件；编写业务逻辑前，必须严格对齐 `dataModels.md` 的强类型。
> 3. **💥 异常熔断协议**：一旦在终端运行编译、构建或 Lint 命令**连续失败超过 3 次**，AI 必须立刻停止（Stop）一切 Act 行为，如实记录当前错误日志，并挂起会话以等待人类开发者干预。**严禁盲目猜测修改**。
> 
> 

---

## 🔄 三、 标准工程运行闭环 (SOP)

系统的交互模型遵循线性循环生命周期：

```mermaid
graph TD
    A[1. 人类在 product-assets 生成原始想法] --> B[2. ChatGPT 精炼出 memory-bank 规范]
    B --> C[3. 启动 Codex/Cline 强制通读 memory-bank 以重建状态]
    C --> D[4. 智能体严格按照规范修改 src 源码层]
    D --> E[5. 编译与测试成功后, 智能体更新 progress.md 与 activeContext.md]
    E --> B

```

---

## 🚀 四、 3秒极速上手 (Quick Start)

你无需手动创建这一堆繁琐的目录和规则文件。在 Mac / Linux 终端中，直接在你想创建项目的目录下运行以下命令，即可一键生成标准的 Spec-Driven 骨架：

```bash
curl -fsSL https://raw.githubusercontent.com/soyona/spec-driven-solo/main/init_spec.sh | bash
```

### 自定义项目名称：
```bash
curl -fsSL https://raw.githubusercontent.com/soyona/spec-driven-solo/main/init_spec.sh | bash -s my-cool-app
```
执行完毕后，使用集成开发环境（IDE）打开该目录，并将工作区访问权限授予您的 Codex / Cline 智能体。

---

## 📘 五、 进阶指南

为了更深入地理解底层设计模式与工作流自动化，请参阅随附 docs/ 的技术指南：

* [1-Spec-Driven Solo 开发工程规范 V1.0](https://github.com/soyona/spec-driven-solo/blob/main/docs/1-engineering-spec.md) ：深入理解三轨制的协作法理与目录哲学。
* [2-Spec-Driven Solo 新手入门指南 V1.0](https://github.com/soyona/spec-driven-solo/blob/main/docs/2-beginner-guide.md) ：手把手带你进行第一次“图纸压榨”与“人机协同 Review”，内含通关 Prompt 咒语。

---

## 📄 开源许可证

本项目基于 [MIT License](https://github.com/soyona/spec-driven-solo/blob/main/LICENSE) 开源。欢迎所有超级个体自由地修改、分发并用于商业项目。

如果你觉得这套规范切实优化了您的开发流程并降低了研发成本，请为本项目点一个 ⭐ Star，这也是对独立开发者最好的支持！


## 📅 变更日志 (Change Log)

### [V1.1.0] - 2026-07-05
* **🚀 新增特性**：项目初始化时默认自动构建 `.gitignore` 配置文件。
  * **工程根因**：Mac 系统在频繁操作目录时会自动生成隐藏的 `.DS_Store` 文件，该文件的无序变动会干扰本地自主智能体（如 Codex / Cline）的文件树索引（Indexing）。
  * **优化目的**：通过物理忽略机制，严格限制智能体的内容扫描与索引范围，将算力与 Token 消耗 100% 锁死在规范定义的三轨目录内，阻止非必要的上下文污染。