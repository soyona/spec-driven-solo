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