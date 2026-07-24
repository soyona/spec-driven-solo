---
name: 🚀 版本发布走查清单 (Release Checklist)
about: 用于发布 Spec-Driven Solo 新版本前的物理卡点走查
title: 'chore(release): bump version to vX.Y.Z'
labels: 'release'
assignees: ''
---

## 📋 vX.Y.Z 版本发布前置走查清单

在合并发布 PR 或打 Tag 前，请维护者依次确认并打勾 `[x]`：

### 1. 源码轨与模版对齐 (Source & Templates Alignment)
- [ ] `templates/` 中的模版占位符与 `src/cli.sh` 渲染逻辑已 100% 对应
- [ ] 若增删了物理文件/目录，`src/cli.sh` 中的 `mkdir/touch` 逻辑已同步更新
- [ ] 根目录下**没有**残留的 `init_spec.sh`（唯一入口仅在 `release/init_spec.sh`）

### 2. 编译打包与断言测试 (Build & Sandbox Assertion)
- [ ] 已运行 `./build.sh`，成功生成/更新 `release/init_spec.sh`
- [ ] 在 `/tmp` 沙盒目录下运行了初始化测试，终端输出 `🎉 [ASSERTION PASSED]`

### 3. 文档与版本号同步 (Single Source of Truth)
- [ ] `README.md` 中的 `Quick Start` 命令 URL 已确认指向 `release/init_spec.sh`
- [ ] `README.md` 中的 `Repository Tree` 物理目录树结构已与脚手架实际生成保持一致
- [ ] `README.md` 中的 `## 📅 变更日志 (Change Log)` 已补充本次发布的版本说明
- [ ] `package.json`（若有）与 `cli.sh` 中的版本号标记已更新为新版本号

---
**确认无误后即可执行打 Tag 并通过 `gh release create` 进行发布！** 🚀