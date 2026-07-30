#!/bin/bash
# ==============================================================================
# 🚀 Spec-Driven Solo 自动初始化脚本 (Self-Contained Executable)
# 注意：此文件由 build.sh 自动构建生成，请勿手动修改！
# ==============================================================================
set -e

# 1. 创建安全临时解压物理隔离区
TMP_DIR=$(mktemp -d 2>/dev/null || mktemp -d -t 'spec_init')
trap 'rm -rf "$TMP_DIR"' EXIT

# 2. 嵌入 Base64 模版资产 Payload
PAYLOAD_DATA="
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
"

# 3. 兼容 macOS 与 Linux 的 Base64 解码与解压
if echo "$PAYLOAD_DATA" | base64 -d >/dev/null 2>&1; then
    echo "$PAYLOAD_DATA" | base64 -d | tar -xzf - -C "$TMP_DIR"
elif echo "$PAYLOAD_DATA" | base64 -D >/dev/null 2>&1; then
    echo "$PAYLOAD_DATA" | base64 -D | tar -xzf - -C "$TMP_DIR"
else
    echo "❌ 错误: 本地环境缺少兼容的 base64 解码工具！"
    exit 1
fi

# 4. 自检断路器：校验解压完整性
if [ ! -d "$TMP_DIR/templates" ]; then
    echo "❌ 错误: 模版 Payload 解压损坏或格式不兼容！"
    exit 1
fi

# ==============================================================================
# 🛠️ Spec-Driven 核心交互与 100% 物理对齐渲染引擎 (src/cli.sh)
# ==============================================================================

PROJECT_NAME=$1
if [ -z "$PROJECT_NAME" ]; then
    CURRENT_DATE=$(date "+%Y%m%d")
    PROJECT_NAME="spec-app-$CURRENT_DATE"
fi

if [ -d "$PROJECT_NAME" ]; then
    echo "⚠️  警告: 本地已存在同名目录 [${PROJECT_NAME}]"
    echo "--------------------------------------------------------"
    echo " [1] 覆盖初始化 (⚠️ 危险操作)"
    echo " [2] 终止退出"
    echo "--------------------------------------------------------"
    read -p "请输入选项数字 (1/2): " CONFLICT_CHOICE </dev/tty
    case $CONFLICT_CHOICE in
        1) rm -rf "$PROJECT_NAME" ;;
        *) echo "🛑 操作已取消。"; exit 0 ;;
    esac
fi

# 1. 自动识别本地包管理器
PKG_MANAGER="npm"
RUN_CMD="npm run"
if command -v bun &> /dev/null; then
    PKG_MANAGER="bun"
    RUN_CMD="bun run"
elif command -v pnpm &> /dev/null; then
    PKG_MANAGER="pnpm"
    RUN_CMD="pnpm"
elif command -v yarn &> /dev/null; then
    PKG_MANAGER="yarn"
    RUN_CMD="yarn"
fi

echo "--------------------------------------------------------"
echo "🎨 请选择您的产品形态与技术轮廓 (Tech Profile):"
echo " [1] Web/SaaS 轻量通用型 (Vite Standard) [默认]"
echo " [2] 微信跨端小程序 (Taro 4.x)"
echo " [3] 跨平台桌面端应用 (Tauri 2.x)"
echo " [4] 复杂数据/BI 后台管理 (Next.js)"
echo "--------------------------------------------------------"
read -p "请输入选项数字 (1-4, 默认 1): " PROFILE_CHOICE </dev/tty
[ -z "$PROFILE_CHOICE" ] && PROFILE_CHOICE=1

case $PROFILE_CHOICE in
    2)
        PROFILE_NAME="微信跨端小程序 (Taro 4.x)"
        COMPILE_CMD="$RUN_CMD build:weapp"
        STATE_STRATEGY="React Context 局部隔离"
        META_WHITELIST='[ "@tarojs/components", "@tarojs/taro", "lucide-react" ]'
        META_BLACKLIST='[ "vant-weapp", "miniprogram-custom-render" ]'
        TOOLCHAIN_ROUTER="- 断路器 1：只能在本地通过 Taro CLI 进行静态编译。\n- 断路器 2：构建体积超 2MB 物理极限必须触发强熔断。"
        ;;
    3)
        PROFILE_NAME="跨平台桌面端应用 (Tauri 2.x)"
        COMPILE_CMD="cargo check && $RUN_CMD build"
        STATE_STRATEGY="前端 Context / Tauri IPC 持久化"
        META_WHITELIST='[ "tauri-plugin-fs", "wasm-bindgen", "serde", "tokio" ]'
        META_BLACKLIST='[ "child_process", "fs.writeFileSync", "panic!" ]'
        TOOLCHAIN_ROUTER="- 断路器 1：必须同时监控前后端编译器。\n- 断路器 2：Rust 侧严禁原生 panic!，连续 3 次报错强熔断。"
        ;;
    4)
        PROFILE_NAME="复杂数据/BI 后台管理 (Next.js)"
        COMPILE_CMD="$RUN_CMD build"
        STATE_STRATEGY="特许解禁 Zustand 局部切片订阅"
        META_WHITELIST='[ "zustand", "echarts", "shadcn-ui", "next" ]'
        META_BLACKLIST='[ "recharts", "DOM轮询重绘", "redux" ]'
        TOOLCHAIN_ROUTER="- 断路器 1：Next.js App Router SSR 双向走查。\n- 断路器 2：严禁因依赖项配置错误导致高频重渲染。"
        ;;
    *)
        PROFILE_NAME="Web/SaaS 轻量通用型 (Vite Standard)"
        COMPILE_CMD="$RUN_CMD build"
        STATE_STRATEGY="React Context 纯函数状态机"
        META_WHITELIST='[ "vite", "tailwindcss", "react-router-dom" ]'
        META_BLACKLIST='[ "redux", "webpack", "gulp" ]'
        TOOLCHAIN_ROUTER="- 断路器 1：标准 Vite HMR 及严格 TS 编译期卡点。\n- 断路器 2：严格执行 Lint -> Build 连续编译防线。"
        ;;
esac

# 2. 100% 物理创建目标工程目录树规范
mkdir -p "$PROJECT_NAME" && cd "$PROJECT_NAME"

# 🎨 资产轨
mkdir -p product-assets/PRD
mkdir -p product-assets/wireframes
mkdir -p product-assets/research

# 🧠 记忆轨
mkdir -p memory-bank/archive

# 🛠️ 源码轨
mkdir -p src/types
mkdir -p src/components
mkdir -p src/lib

# 3. 纯 Bash 字符串模版渲染函数
render_template_file() {
    local src_file="$1"
    local dest_file="$2"
    local content
    
    if [ -f "$src_file" ]; then
        content=$(cat "$src_file")
        content="${content//__PROFILE_NAME__/$PROFILE_NAME}"
        content="${content//__COMPILE_CMD__/$COMPILE_CMD}"
        content="${content//__STATE_STRATEGY__/$STATE_STRATEGY}"
        content="${content//__META_WHITELIST__/$META_WHITELIST}"
        content="${content//__META_BLACKLIST__/$META_BLACKLIST}"
        content="${content//__TOOLCHAIN_ROUTER__/$TOOLCHAIN_ROUTER}"
        
        mkdir -p "$(dirname "$dest_file")"
        echo "$content" > "$dest_file"
    fi
}

# 4. 根目录系统规则与防线落盘
render_template_file "$TMP_DIR/templates/rules/clinerules.md.tpl" ".clinerules"
cp .clinerules .codexrules
render_template_file "$TMP_DIR/templates/rules/agents.md.tpl" "AGENTS.md"
render_template_file "$TMP_DIR/templates/base/clineignore.tpl" ".clineignore"

cat << 'EOF' > .gitignore
# ⚙️ 依赖与产物
node_modules/
dist/
out/
.DS_Store
*.log

# 映射物理盲区
memory-bank/archive/
memory-bank/*_historical_logs.md
product-assets/research/tech-review.md
EOF

# 5. 资产轨：冰封资产落盘
cat << 'EOF' > product-assets/research/tech-review.md
# ❄️ 【冰封资产】红队论证与底层技术选型结论
> 本文件为云端上游红队论证产物，Agent 仅允许读取，严禁修改。
EOF

# 6. 记忆轨：补齐 6 大持久化核心大脑文件
render_template_file "$TMP_DIR/templates/base/projectBrief.md.tpl" "memory-bank/projectBrief.md"
render_template_file "$TMP_DIR/templates/base/techContext.md.tpl" "memory-bank/techContext.md"
render_template_file "$TMP_DIR/templates/base/systemPatterns.md.tpl" "memory-bank/systemPatterns.md"
render_template_file "$TMP_DIR/templates/base/dataModels.md.tpl" "memory-bank/dataModels.md"
render_template_file "$TMP_DIR/templates/base/activeContext.md.tpl" "memory-bank/activeContext.md"
render_template_file "$TMP_DIR/templates/base/progress.md.tpl" "memory-bank/progress.md"

# 7. 源码轨与基础配置文件落盘
touch src/types/index.ts
touch src/main.ts

cat << 'EOF' > tsconfig.json
{
  "compilerOptions": {
    "target": "ES2022",
    "module": "ESNext",
    "moduleResolution": "bundler",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true,
    "baseUrl": ".",
    "paths": {
      "@/*": ["src/*"]
    }
  },
  "include": ["src/**/*"]
}
EOF

cat << EOF > package.json
{
  "name": "$PROJECT_NAME",
  "version": "0.1.0",
  "private": true,
  "type": "module",
  "scripts": {
    "build": "$COMPILE_CMD"
  }
}
EOF

echo "--------------------------------------------------------"
echo "✅ [$(uname)] Spec-Driven 项目初始化成功！"
echo "📂 项目物理路径: $(pwd)"
echo "⚙️  自动化绑定: 包管理器 [$PKG_MANAGER] | 编译指令 [$COMPILE_CMD]"
echo "--------------------------------------------------------"
