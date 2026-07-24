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
# ❄️ 【V2.1.0 冰封资产】红队论证与底层技术选型结论
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