# 🛠️ Spec-Driven Solo 开发者与维护者贡献指南 (CONTRIBUTING)

欢迎加入 **Spec-Driven Solo** 的维护与演进！为了保证本脚手架的**单源真理（Single Source of Truth）、100% 物理目录树对齐**以及**跨平台零依赖发布**，所有维护者（包括人类贡献者与 AI 协同 Agent）必须严格遵守以下规范。

---

## ⚖️ 维护者最高三大铁律

1. **单源真理**：严禁直接手动修改 `release/init_spec.sh`！所有代码与逻辑变动必须修改 `src/cli.sh` 或 `templates/`，并通过 `./build.sh` 编译生成产物。
2. **100% 物理对齐**：任何物理目录或文件结构的变更，必须同步更新 `src/cli.sh`（渲染逻辑）、`templates/`（模版文件）以及 `README.md`（目录树说明）。
3. **卡点防线（No Assertion, No Release）**：任何 PR 或版本发布前，必须通过沙盒物理存在性断言测试（Physical Assertion Check）。

---

## 🔄 规范升级 4 步标准 SOP

```mermaid
graph TD
    A[1. 源码/模版修改 (src & templates)] --> B[2. 本地打包 (./build.sh)]
    B --> C[3. 沙盒物理断言测试 (/tmp)]
    C --> D[4. 版本同步与 Release 发布]
```

### 1. 修改源码轨与模版轨

* **修改 AI 系统铁律**：编辑 `templates/rules/clinerules.md.tpl`。
* **修改 CLI 逻辑或交互**：编辑 `src/cli.sh`。
* **修改模版文件**：编辑 `templates/` 对应 Profile 目录下的内容。

### 2. 执行本地编译打包

在项目根目录运行：

```bash
./build.sh

```

*构建脚本会自动对 `templates/` 进行物理过滤、压缩并进行安全 Base64 编码，生成纯净的自包含单文件 `release/init_spec.sh`。*

### 3. 沙盒物理断言测试

在本地终端中运行以下测试命令，确保新打包的脚手架能够 100% 正确渲染目录树：

```bash
# 进入临时目录测试
cd /tmp && rm -rf test-spec-app
/路径/到/spec-driven-solo/release/init_spec.sh test-spec-app

# 执行 100% 物理存在性断言
cd test-spec-app
test -f .clinerules && \
test -f .codexrules && \
test -f .clineignore && \
test -f .gitignore && \
test -f package.json && \
test -f tsconfig.json && \
test -d product-assets/PRD && \
test -d product-assets/wireframes && \
test -f product-assets/research/tech-review.md && \
test -f memory-bank/projectBrief.md && \
test -f memory-bank/techContext.md && \
test -f memory-bank/systemPatterns.md && \
test -f memory-bank/dataModels.md && \
test -f memory-bank/activeContext.md && \
test -f memory-bank/progress.md && \
test -d memory-bank/archive && \
test -f src/types/index.ts && \
test -d src/components && \
test -d src/lib && \
test -f src/main.ts && \
echo "🎉 [ASSERTION PASSED]: 所有物理节点 100% 精准对齐！零遗漏，零偏差！"

```

### 4. 版本同步与 Git 发布

1. 同步更新 `README.md` 中的 Change Log 与 Quick Start 路径。
2. (可选) 在 GitHub 发起 Release 提案时，建议选用 .github/ISSUE_TEMPLATE/release_checklist.md 模板进行逐项走查打勾。
3. 运行发布命令：
```bash
git add .
git commit -m "chore: release vX.Y.Z"
git tag -a vX.Y.Z -m "Spec-Driven V X.Y.Z 正式发布"
git push origin main --tags

```
---

## 💬 维护者 AI 协同 Prompt

如果你在使用 AI 助手（ChatGPT / Claude / Cursor / Cline）协助演进本规范，请将以下 Prompt 复制给 AI：

> 你现在是 Spec-Driven Solo 规范的架构维护者。我们需要对现有 Spec-Driven Solo 框架进行版本迭代升级。
> ### 🎯 本次升级需求
> 
> 
> [填入你的升级需求]
> ### ⚖️ 升级执行铁律
> 
> 
> 1. 单源真理：所有修改必须从 templates/ 和 src/cli.sh 开始，严禁直接手动编辑 release/init_spec.sh。
> 2. 100% 物理对齐：若改动涉及目录或文件结构，必须同步更新 templates/、src/cli.sh 和 README.md。
> 3. 打包校验：修改完成后，提示我运行 ./build.sh 并给出 /tmp 下的物理断言测试命令。
> 
> 

---